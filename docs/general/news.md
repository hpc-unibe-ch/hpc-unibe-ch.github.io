# News

22.05.2024:

  - UBELIX went through a major upgrade:
    
     - The operating system was upgraded to Rocky Linux 9.3
     - The supported software stack was updated. Supported toolchain versions are now 2021a through 2023a
     - The scheduler accounting hierarchy was restructured and simplified
     - The monitoring system was upgraded to Grafana
     - The user documentation was refactored
    
    **SSH Key Switch**
    
    Please be aware that the sshd configuration of UBELIX has changed. Consequently, only ED25519 host keys are supported. You will receive a warning when connecting to UBELIX for the first time after the change. You will need to remove the old host keys from your known hosts:
    
     - ssh-keygen -R submit.unibe.ch
     - ssh-keygen -R submit01.unibe.ch
     - ssh-keygen -R submit02.unibe.ch
     - ssh-keygen -R submit03.unibe.ch
     - ssh-keygen -R submit04.unibe.ch
    
    The new ED22519 host key fingerprints are:
    
     - submit01.unibe.ch (130.92.250.231) - SHA256:qmMfIbwyosfLUsY8BMCTgj6HjQ3Im6bAdhCWK9nSiDs.
     - submit02.unibe.ch (130.92.250.232) - SHA256:eRTZGWp2bvlEbl8O1pigcONsFZAVKT+hp+5lSQ8lq/A.
     - submit03.unibe.ch (130.92.250.233) - SHA256:PUkldwWf86h26PSFHCkEGKsrYlXv668LeSnbHBrMoCQ
     - submit04.unibe.ch (130.92.250.234) - SHA256:D3cmfXkb40P7W935J2Un8sBUd4Sv2MNLkvz9isJOnu0.
    
    **Software Stack**
    
    Since the all software modules have changed, we advise recompiling all custom software based on the new toolchains!
    
    The supported software was rebuilt in the most recent stable version of the foss/2023a toolchain if available. You can search for packages or modules containing a specific string using "module spider". You can list all currently available packages using "module avail". Beware, this list is very long! It may be more useful to use "module spider" instead.
    
    In case you're missing software, please follow these steps:
    
     - Check if a newer version of the software is already available (module spider <software>). Please use this version. If this isn't possible you will need to install it yourself. See our documentation for more information.
     - Check if your tool/version is available in the easybuilders/easybuild-easyconfigs repository for an easyconfig for foss/2023a or intel/2023a toolchains.
     - Follow the instructions in this documenation to install the software to your personal stack. If the software is useful to a larger group of users, please open a ticket. Note that no software from unsupported toolchains will be centrally installed.
    
    **SLURM changes**
    
    Slurm associations are no longer set on partitions. This means it is now possible to submit a job to both the epyc2 as well as the bdw partition, e.g. --partition=epyc2,bdw. When no partition is specified in the job script, partition=epyc2,bdw will be the default. The scheduler will then try to start your job as early as possible on either of the two partitions while prioritizing the partition mentioned first.
    
    To eliminate confusion the QoS "job_gpu_preempt" has been renamed to "job_gpu_preemptable" to indicate that jobs submitted with this QoS are in fact preemptable by investor jobs.
    
    Also, there are no longer personal and workspace accounts. This means you don't have to specify an account when submitting jobs.
    
    Finally, the resources that users can use at the same time, given by the CPU core limit per user in the past has been replaced by a maximum CPU hours limit per user. This should improve the overall scheduling performance.
    
    
    **Monitoring**
    
    The status web page is now available at https://ubelix.hpc.unibe.ch. Please note that user jobs are no longer displayed on the status page. Use the "squeue --me" command to get a high-level overview of all your active (running and pending) jobs in the cluster.

12.01.2024:

- The user documentation has been streamlined and updated with recent information
- The UBELIX9 testing system, previewing the next generation OS is now availble for all users.
  
    In our ongoing commitment to providing a secure and efficient computing environment, we are migrating the HPC system from CentOS 7 to Rocky Linux 9.  
  
    We are pleased to inform you that a part of our infrastructure has been migrated and is ready to be tested by you. To get you started, please take the time to read this information thoroughly. 
    
    As part of the migration, we have implemented general software and security updates to ensure a secure and optimized computing environment. Please consult the manual pages (i.e., `man <command>`) to review the latest command syntax. 
    
    The list of software modules managed by the UBELIX Team accessible via the module commands has been updated. Please note that old software versions may have been discontinued in favor of more recent versions. Additionally, the Vital-IT and UBELIX software stacks have been merged. Explore the enhanced range of modules to benefit from the latest tools and applications available on UBELIX using the module spider command. 
    
    While we have taken measures to minimize user impact, it is crucial to be aware of potential adjustments needed on your end. Most importantly, please verify that your workflows, scripts, and applications are compatible with the new environment.  
    
    It is important to note that there may be a need to recompile your executables for compatibility with the new system. Existing Python environments are expected to remain functional unless special libraries such as TensorFlow with GPU support are used. These may require a fresh installation. 
    
    Additionally, older software modules that are no longer managed by the UBELIX team may need to be installed by users if required. Instructions for custom software modules installations can be found in the documentation section on EasyBuild.  
    
    The testing system is kept simple, and therefore, only default Quality of Service (QOS) is available now. Investor resources have not been migrated yet and are still fully accessible on the old system. Existing job scripts that use the debug, long, gpu_preempt and invest QOS need to be updated. Investors are encouraged to reach out to us if they wish to proceed with the migration of their resources. 
    
    To access the new system please login to submit02: `ssh <username>@submit02.unibe.ch`
    
    Note that the graphical monitoring ([https://ubelix.unibe.ch/)](https://ubelix.unibe.ch/)) does not cover the new testing environment yet. Please use the `squeue --me` command to query your jobs status on the new system. More details on the monitoring of the new system will follow. 
    
    If you encounter any issues, we are ready to assist you. Feel free to reach out via [https://serviceportal.unibe.ch/hpc](https://serviceportal.unibe.ch/hpc). Please make sure to specify that your problem is related to the UBELIX testing environment and provide as much information as possible. 
    
    We appreciate your attention to these details and your cooperation as we work together to ensure a smooth transition to Rocky Linux 9.

    Happy computing!

