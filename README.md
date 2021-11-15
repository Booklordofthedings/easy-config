# Easy-Config
*A beeflang library with the goal to make loading configuration/settings files easy*

## Installation and Usage
- Clone the repo from github into a folder of your choice
- Open the project that wants to use this libary in the beef ide
- Rightclick on the workspace -> Add existing project
- Find and select the directory you copied from
- Rightlick the project you wanna use it in -> Dependencies -> select the checkbox
- You can now use functions from the library under the easy_config namespace

## Exposed Functions

WriteConfig	*Write the current state of the config file to the path*
GetValueAsFloat *Read a value as float*
GetValueAsBool	*Read a value as bool*
GetValueAsInt	*Read a value as int*
GetValueAsDouble	*Read a value as double*
AddValue	*Add a value to the opened config, can also override a value if it already exists*

## File syntax
key:value\n
key2:value2
