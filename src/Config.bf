/*	Syntax of the .cfg files:
Key:Value /n
Key2:Value /n
*/

/*	Error Codes
00: No Error

01: Key is already in settings dictionary
02: The key you want to load isn't in the file

10: Error while reading file

20: Error while parsing to float
21: Error while parsing to double
22: Error while parsing to bool
23: Error while parsing to int
*/

using System.Collections;
using System.IO;
using System;
namespace easy_config
{
	class Config
	{
		private static List<String> _ErrorString;

		private Dictionary<String,String> _Settings;

		///Returns the last error thrown by the config program
		public static String GetLastError()
		{

			return _ErrorString.Back;
		}

		

		
		public this(String path = "config.cfg")
		{
			_Settings = new .();
			_ErrorString = new .();
			_ErrorString.Add(new String($"[00]: No error yet"));

			String input = scope String();
			if(File.ReadAllText(path,input,true) case .Err)
			{
				_ErrorString.Add(new $"[10]: The file cant be read");
			}

			StringSplitEnumerator e = input.Split('\n');
			for(StringView s in e)
			{
				int index = s.IndexOf(':');
				if(index < 0)
				{
					_ErrorString.Add(new $"[11]: A Line doesnt contain a :");
					break;
				}
				StringView key = .(s,0,index);

				int offset = 2;
				if(e.HasMore == false)
					offset = 1;

				StringView value = .(s,index+1,s.Length - key.Length - 2);

				_Settings.Add(new String(key),new String(value));
			}
		}

		public ~this()
		{
			DeleteDictionaryAndKeysAndValues!(_Settings);
			DeleteContainerAndItems!(_ErrorString);
		}

		///Write the current config object to a file specified by path
		public  Result<void> WriteConfig(String path = "config.cfg")
		{
			String output = scope .();

			for((String,String) pair in _Settings)
			{
				output.Append(pair.0);
				output.Append(":");
				output.Append(pair.1);
				output.Append("\n");
			}

			if(File.WriteAllText(path,output) == .Ok)
				return .Ok;

			_ErrorString.Add(new $"[04]: An error occured while saving the config");
			return .Err;
		}


#region GetValues
		
		/// Get a value from the loaded config file as a float
		/// @param save should the value be added to the dictionary, should the key not exist
		public float GetValueAsFloat(String key, float defaultValue, bool save = true)
		{
			//Key exists in config
			if(_Settings.ContainsKey(key))
			{
				float output;
				if(float.Parse(_Settings.GetValue(key).Value) case .Ok(let val))
				{
					output = val;
					return output;
				}
				//The value couldnt be parsed into the type
				_ErrorString.Add(new $"[20]: Error while trying to get the value from key {key}, as a float. \n Instead returning {defaultValue.ToString(.. scope String())}");
				return defaultValue;
			}
			//The key doesnt exist in the config
			_ErrorString.Add(new $"[02]: Value isnt in the file");
			if(save)
			{
				_Settings.Add(new String(key),defaultValue.ToString(.. new .())); //Adds the key to the config for further use
			}
			return defaultValue;
		}

		/// Get a value from the loaded config file as a double
		public double GetValueAsDouble(String key, double defaultValue, bool save = true)
		{
			//Key exists in config
			if(_Settings.ContainsKey(key))
			{
				double output;
				if(double.Parse(_Settings.GetValue(key).Value) case .Ok(let val))
				{
					output = val;
					return output;
				}
				//The value couldnt be parsed into the type
				_ErrorString.Add(new $"[21]: Error while trying to get the value from key {key}, as a double. \n Instead returning {defaultValue.ToString(.. scope String())}");
				return defaultValue;
			}
			//The key doesnt exist in the config
			_ErrorString.Add(new $"[02]: Value isnt in the file");
			if(save)
			{
				_Settings.Add(new String(key),defaultValue.ToString(.. new .())); //Adds the key to the config for further use
			}
			return defaultValue;
		}

		/// Get a value from the loaded config file as a bool 
		public bool GetValueAsBool(String key, bool defaultValue, bool save = true)
		{
			//Key exists in config
			if(_Settings.ContainsKey(key))
			{
				bool output;
				if(bool.Parse(_Settings.GetValue(key).Value) case .Ok(let val))
				{
					output = val;
					return output;
				}
				//The value couldnt be parsed into the type
				_ErrorString.Add(new $"[22]: Error while trying to get the value from key {key}, as a bool. \n Instead returning {defaultValue.ToString(.. scope String())}");
				return defaultValue;
			}
			//The key doesnt exist in the config
			_ErrorString.Add(new $"[02]: Value isnt in the file");
			if(save)
			{
				_Settings.Add(new String(key),defaultValue.ToString(.. new .())); //Adds the key to the config for further use
			}
			return defaultValue;
		}

		/// Get a value from the loaded config file as a integer
		public int GetValueAsInt(String key, int defaultValue, bool save = true)
		{
			//Key exists in config
			if(_Settings.ContainsKey(key))
			{
				int output;
				if(int.Parse(_Settings.GetValue(key).Value) case .Ok(let val))
				{
					output = val;
					return output;
				}
				//The value couldnt be parsed into the type
				_ErrorString.Add(new $"[23]: Error while trying to get the value from key {key}, as a Int. \n Instead returning {defaultValue.ToString(.. scope String())}");
				return defaultValue;
			}
			//The key doesnt exist in the config
			_ErrorString.Add(new $"[02]: Value isnt in the file");
			if(save)
			{
				_Settings.Add(new String(key),defaultValue.ToString(.. new .())); //Adds the key to the config for further use
			}
			return defaultValue;
		}

		/// Get a value from the loaded config file as a 
		public String GetValueAsString(String key, String defaultValue, bool save = true)
		{
			//Key exists in config
			if(_Settings.ContainsKey(key))
			{
				return _Settings.GetValue(key);
			}
			//The key doesnt exist in the config
			_ErrorString.Add(new $"[02]: Value isnt in the file");
			if(save)
			{
				_Settings.Add(new String(key),new String(defaultValue)); //Adds the key to the config for further use
			}
			return defaultValue;
		}
		
#endregion

		///Adds a value to the config file
		public Result<void> AddValue(String key, String value, bool replace = true)
		{
			if(_Settings.ContainsKey(key))
			{
				if(replace)
				{
					_Settings.GetValue(key).Value.Set(new String(value));
					return .Ok;
				}
				_ErrorString.Add(new $"[01]: The Value you tried to write already exists: {key}");
				return .Err;
			}

			_Settings.Add(key,value);

			return .Ok;
		}
		

	}
}
