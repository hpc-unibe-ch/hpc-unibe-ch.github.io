# News

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

