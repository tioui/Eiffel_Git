Eiffel_Git
==========

A library that enable git functionnality from Eiffel code. Work with EiffelStudio. 
Currently only the repository initialization is Working. 

Installation
============

Linux Ubuntu
------------

Tested with Linux Ubuntu 14.04 with libgit2 0.21.3 manually installed (not the one from the package manager).


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
