noyd
=======

nodejs command line tools for android developers

### install

```bash
npm install -g noyd
```

### Assumption

You have the android sdk into your PATH, with something like this in your `.bash_profile`

```bash
export PATH="$HOME/android-sdks/platform-tools:$HOME/android-sdks/tools:$PATH"
``` 

### usage 

```bash
noyd --logcat -w YourLogTag
```

### suggestion

Create an alias called 'logcat' by putting this in your `.bash_profile`

```bash

# 
# enables command 'logcat MyLogTag'
# 
alias logcat="noyd --logcat -w"

```

Then start a new terminal (or reload the profile with `source ~/.bash_profile`)

