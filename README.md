get-ghc.ps1 is a Powershell script that automates the setup of a GHC development environment on Windows using the [MSYS2](https://ghc.haskell.org/trac/ghc/wiki/Building/Preparation/Windows/MSYS2) procedure. It requires PowerShell 3.0.

get-ghc-win7.ps1 is a version that works on Windows 7 without installing a new PowerShell.

The script is configured to set up the environment for building a 64-bit GHC by default, change the `$msys` variable to 32 for a 32-bit environment.

### Usage
 - Create a new directory.
 - Run the get-ghc script in that directory
 - Sit back and wait while everything is downloaded and unpacked

To start hacking, start the `msys/mingw64_shell.bat` for a 64-bit environment, or `msys/mingw32_shell.bat`  for a 32-bit. The bootstrap compiler is in the `msys/ghc-7.8.2` directory, and the GHC git is in `msys/home/<username>/ghc`. The GHC git has been cloned, all the various sub-gits have been synced and the boot script has been run. What remains is to run the configure script and to build GHC. That is described at [Building GHC](https://ghc.haskell.org/trac/ghc/wiki/Building/Hacking).
