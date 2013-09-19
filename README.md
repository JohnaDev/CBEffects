# CBEffects for Corona® SDK #

CBEffects is the ultimate particle system for Corona SDK. It's easy to use, powerful, flexible, and (best of all for people who are as broke as me) **entirely free**! The code is fully open-source, so any contributors can help develop it to be even better.

The CBEffects package is a folder containing everything needed (and unneeded, for that matter) to get CBEffects working in your project. It has two `.lua` files, a basic texture set, an information file, and a parameter reference. The full package (including fried mushrooms and bacon) is about `-((12 * 15) - (110 / 0.1) + 59) - (4 * 200) + 148` KB in size (that's 209 KB, for those who don't want to do the math or copy and paste it into Alfred).

### Licensing ###

CBEffects is distributed under a simple and sweet license I call "The Truffle License". Here it is reproduced in full:

###### The Truffle License ######
- This project is free to get
- This project is free to edit
- This project is free to use in a game
- This project is free to use in an app
- This project is free to use without crediting the author (credits are still appreciated)
- This project is free to use without crediting the project (credits are still appreciated)
- This project is NOT free to sell for any amount of money
- This project is NOT free to sell for anything else
- This project is NOT free to credit yourself with  

### Using this Repository ###

Download the ZIP file, unzip, and run the `main.lua` to get a feel for the kinds of cool effects you can make with CBEffects. Then, to unlock awesome visuals in your project, copy the folder named "CBEffects" into your project's **root** directory. Now add the following lines of code to the top of the file you'll be using the library in:
```Lua
local CBE = require("CBEffects.Library")
```
Now CBEffects is loaded and ready under the name `CBE`.
