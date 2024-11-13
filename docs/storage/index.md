[hdf5]: https://www.hdfgroup.org/solutions/hdf5/

[researchstorage]: https://intern.unibe.ch/dienstleistungen/informatik/dienstleistungen_der_informatikdienste/dienstleistungen___ressourcen/research_storage/index_ger.html
[capacitystorage]: https://intern.unibe.ch/dienstleistungen/informatik/dienstleistungen_der_informatikdienste/dienstleistungen___ressourcen/capacity_storage/index_ger.html

# Data Storage Overview

---

This describes the available data storage options on UBELIX. Please look closely
at their descriptions to find the ideal storage option for your use case.

## Where to store data?

=== "User home"

    Each user has a home directory (`$HOME`) that is limited to maximum `1TB`. It is located under `/storage/home/$USER`, where `$USER` is the campus account. `$HOME` is meant for private and configuration data. Regular Snapshots provide possibility to recover accidentally modified or deleted data.

    Sharing data with other cluster users is not supported for `$HOME`. The user home directory is purged once the user account expires.

=== "Workspaces (Research Storage)"

    Workspace storage is intended to share data amongst the members of a project.
    Typically, workspace storage is used to store project data, share applications
    and libraries compiled for the project.
    Workspaces are located under `/storage/research` and `/storage/workspaces`. The
    space in each workspace is controlled individually by the quota of the
    corresponding research storage share. Similar to user home directories,
    workspaces are protected by regular snapshots to recover accidentally modified
    or deleted data.

    Workspace storage is based on the [Research Storage][researchstorage] service.

=== "Capacity Storage"

    Capacity storage is intended to store large amounts of reproducible research
    data amongst the members of a project.
    Projects are located under `/storage/capacicty` and only accessible through
    the `submit` nodes. The
    space in each project is controlled individually by the quota of the
    corresponding capacity storage share. In contrast to workspaces,
    data is **NOT** protected by regular snapshots to recover accidentally modified
    or deleted data.

    Capacity storage is based on the [Capacity Storage][capacitystorage] service.

=== "Network scratch"

    SCRATCH (`/storage/scratch`) is a temporary space with less restrictive
    limitations in size, but more restrictive limitation in time.
    There is no snapshot or backup service implemented in that space.

    You are not supposed to use the scratch space as long-term storage. The 
    scratch file system is a temporary storage space. Files that have not been
    accessed will be **purged after 30 days**.

=== "Local scratch"

    Temporary storage for input, output, or checkpoint data of your application.
    When running jobs on UBELIX, this is the main storage you should use for your
    disk I/O needs.

    A high performance variant of network scratch that is local to the node(s)
    your job is running on. Data is only available as long as the job is
    running!

## UBELIX file system location of storage systems

|                            | Path                       | Intended use                                                     | Comment |
|----------------------------|----------------------------|------------------------------------------------------------------|-------------------------|
| **User<br> home**          | `/storage/homefs/<username>`        | User home directory for<br> personal and configuration files     |         |
| **Workspace<br> (Research Storage)** | `/storage/research/`<br>`/storage/workspaces/`       | Project storage directory for<br> shared project files              |        |
| **Capacity Storage** | `/storage/capacity/`       | Project storage directory for<br> large, reproducible data | Only available on `submit` nodes  |
| **Network<br> scratch**    | `/scratch/network/`       | Temporary storage for<br> input, output or checkpoint data       |    |
| **Project<br> flash**      | `/scratch/local/`         | High performance temporary<br> storage for input and output data | Only available during job execution |


