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
