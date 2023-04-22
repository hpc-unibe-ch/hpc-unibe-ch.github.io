# HPC documentation

In this repository the offical end user documentation of UBELIX and related topics
is managed.

This documentation project makes use of [MkDocs Material Design Theme](https://squidfunk.github.io/mkdocs-material)

## Contributing

Everybody is invited to contribute to the doucmentation. If you find that certain topics
are not sufficiently covered or difficult to understand, you can fork this repository,
fix the respective part and then send us a pull request. Even for such small things like
typos! Yes, really, we appreciate your effort!

You can make our life easier when you ship logically selfcontained pull requests, which means:

  * one logical change per pull reuqest (typos or a new paragraph on topic X, another for topic Y)
  * squash multiple commits before starting the pull request

To make changes and test it locally, you have to setup mkdocs-material and all
other dependencies. We are delivering a conda environemnt file right within
this repo. A possible installation scenario for macOS using Homebrew might look
like:

```
# Install miniconda using Homebrew
brew install miniconda

# Setup conda
conda init "$(basename "${SHELL}")"
# --> For changes to take effect, close and re-open your current shell <--

# Fetch the documentation repository
git clone https://github.com/hpc-unibe-ch/hpc-docs.git
cd hpc-docs

# Create and activate the environment
conda create
conda activate hpcdocs

# Start the local mkdocs webserver that renders and displays all change instantly
mkdocs serve
```

Thank you!

## License

This work is licensed under the Creative Commons Attribution 3.0 Switzerland
License. To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/ch/
or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
