Occasionally we are asked if UBELIX is featuring any TeX flavor. UBELIX does not
provide any form of TeX to our uses neither TeX packages from the host OS nor
any custom installation through EasyBuild nor other custom installations. While
the distribution packages are way to old, all other form's won't serve all
researchers and installing TeX in your home directory is not that difficult.
Therefore we think you should choose and install whatever serves you the most.

If in doubt, we recommend to install the [TeX Live system]

## Install texlive to $HOME

Just follow the steps below. These are the same steps as in the [official
installation instructions] but the installation is not unattended but
interactive, so that you can change the installation directory. See there for
all the details.

1. `mkdir -p ~/temp; cd $_` # working directory of your choice
1. `wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz`
1. `zcat install-tl-unx.tar.gz | tar xf -`
1. `cd install-tl-*`
1. `perl ./install-tl --texdir=~/texlive/YYYY` # where YYYY is the texlive release
1. Finally, prepend `~/texlive/YYYY/bin/PLATFORM` to your PATH, e.g., `~/texlive/2022/bin/x86_64-linux`
1. and cleanup, `cd ~; rm -rf ~/temp`

[TeX Live system]: https://tug.org/texlive/
[official installation instructions]: https://tug.org/texlive/quickinstall.html
