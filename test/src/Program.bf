namespace test
{
	class Program
	{
		public static void Main()
		{
			easy_config.Config test = scope easy_config.Config();
			System.Console.WriteLine(test.GetValueAsFloat("test_float",5));
			System.Console.WriteLine(test.GetValueAsInt("test_int",7));
			System.Console.WriteLine(test.GetValueAsBool("test_bool",true));
			System.Console.WriteLine(test.GetValueAsDouble("test_double",7));
			System.Console.WriteLine(test.GetValueAsString("test_string","va"));
			//test.WriteConfig();
			System.Console.Read();
		}
	}
}
