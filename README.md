# HPC documentation

In this repository the offical end user documenttion of UBELIX and related topics
is managed.

This documentation project is built with [Zensical](https://zensical.org).

## Contributing

Everybody is invited to contribute to the doucmentation. If you find that certain topics
are not sufficiently covered or difficult to understand, you can fork this repository,
fix the respective part and then send us a pull request. Even for such small things like
typos! Yes, really, we appreciate your effort!

You can make our life easier when you ship logically selfcontained pull requests, which means:

  * one logical change per pull reuqest (typos or a new paragraph on topic X, another for topic Y)
  * squash multiple commits before starting the pull request

To make changes and test it locally, you have to setup Zensical and all
other dependencies. A possible installation scenario using a Python virtual
environment might look like:

```
# Fetch the documentation repository
git clone https://github.com/hpc-unibe-ch/hpc-unibe-ch.github.io.git
cd hpc-unibe-ch.github.io

# Create and activate a virtual environment
python3 -m venv .venv
source .venv/bin/activate

# Install Zensical
pip install zensical

# Start the local webserver that renders and displays all changes instantly
zensical serve
```

Thank you!

## License

This work is licensed under the Creative Commons Attribution 3.0 Switzerland
License. To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/ch/
or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
