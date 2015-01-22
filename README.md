Eiffel_Git
==========

A library that enable git functionnality from Eiffel code. Work with EiffelStudio. 
Currently only the repository initialization, openning and cloning is Working. 

[<img src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif">](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=louis%40tioui%2ecom&lc=CA&item_name=Louis%20Marchand&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_SM%2egif%3aNonHosted)
[<img src="https://www.coinbase.com/assets/buttons/donation_small-5dab7534cbb87a4ff2b44e469351ec86.png">](https://www.coinbase.com/tioui)

Installation
============

Linux Ubuntu
------------

Tested with Linux Ubuntu 14.04 with libgit2 0.21.3 manually installed (not the one from the package manager).
To install the library, you must download it, name the containing directory "git", and put it in the 
$EIFFEL_LIBRARY/contrib/library/ folder (You can also use a symbolic link). After that, you have to compile
some C files. The easyest way to install the library is shown below. Be sure to have the EIFFEL_LIBRARY environment
variables set and also to have the EiffelStudio binary files in the path. On most system, EIFFEL_LIBRARY will be set
to /usr/local/Eiffel_XX.XX or /usr/lib/eiffelstudio-14.05 .

```bash
git clone https://github.com/tioui/Eiffel_Git.git
cp -rp Eiffel_Git $EIFFEL_LIBRARY/contrib/library/git
cd $EIFFEL_LIBRARY/contrib/library/git/library/Clib/
finish_freezing -library
```


Windows
-------

Tested with MinGW and Microsoft VisualC compiler on Windows 32 and 64 bits. Look at the branch
win-binary to have the libgit2 C library already compiled with the Eiffel_Git library. To download,
use the following command:

```bash
git clone https://github.com/tioui/Eiffel_Git.git git
cd git
git checkout win-binary
```

Then, copy the git folder in the $EIFFEL_LIBRARY\contrib\library\ folder. One you compile an application
using the Eiffel_Git library, you will have to copy the git2.dll file in the Eiffel project folder (be
sure to take the dll that fit your compilation platform, i.e libgit2/lib32/git2.dll for 32 bits compilation
and libgit2/lib64/git2.dll for 64 bits compilation). Alternatively, you can put the git2.dll in the
c:\Windows\system32 folder or the c:\Windows\sysWOW64 folder in the case of the 32 bits git2.dll in a 64 bits
system.
