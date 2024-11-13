# Overview

[python-install]: ./installing/python.md
[r-install]: ./installing/r.md
[easybuild]: ./installing/easybuild.md
[singularity-jobs]: ../runjobs/scheduled-jobs/container-jobs.md
[software-env]: ./Lmod_modules.md
[install-policy]: ./policy.md
[workspace]: ../storage/index.md

---
On this page, you will find information about pre-installed software on UBELIX as well
as guidance on ways to install additional software yourself.

UBELIX users are expected to be able to compile and install the software that they need themselves in their own project directories. If they cannot do that, they need to secure help from their local IT support responsible or supervisor if applicable before requesting support from the UBELIX team.

Please note that UBELIX Team can only offer limited help with installing scientific software.
The UBELIX team is very small, and we cannot maintain and install all software centrally (e.g. `module load xyz`) for all the projects running on UBELIX. The maximum amount of help we can offer to each user is on the order of a few hours, including answering the support tickets.

---

## Pre-installed software

On UBELIX, we provide some pre-installed software in a central software stack. Consult the [software environment page][software-env] for instructions on identifying the pre-installed software on UBELIX through the module system.

## Installing additional software

!!! danger "Warning"
    You **cannot** use the package managers apt, dnf or yum for this, since these commands require root privileges to install software system wide. Instead you have to compile and install the software yourself. 

!!! tip "Tip"
    If you know that some missing software could be of general interest for a **wide community** on our machines, you can ask us to install the software system wide.

If you intend to install Python packages, please consult the [Python packages
installation guide][python-install] for an overview of your options.

If you intend to install R packages, please consult the [R packages
installation guide][r-install] for an overview of your options.

If you need to install common scientific software and libraries, please use [EasyBuild][easybuild].
EasyBuild is the primary software installation tool on UBELIX. It is used to install
most software in the [central software stack][software-env] on UBELIX, but it
is also extremely easy to install additional software in your personal or project
space and have it integrate fully with the software stacks.

The preferred location for software installations is a [workspace][workspace] directory,
so that a software installation can be shared with all users in your project.
Software can also be installed in your home directory, but it is not recommended
and you will not get additional quota for it. Creating permanent software
installations in your `/scratch` directories is not recommended as
these will be cleaned automatically.

Please note that **UBELIX operates under a "bring your own license" model for commercial software**. Only a small amount of software (mainly development tools) are covered by the UBELIX or university budget. If your organisation has existing software licenses, these licenses can in many cases be used on UBELIX by checking out the licenses from the organisation's license server across the network when a job starts on a compute node. Please note that there are currently no facilities for running private license servers inside UBELIX.
