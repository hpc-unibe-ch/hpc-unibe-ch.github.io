# Login

## Description

UBELIX is available to everybody with a valid Campus Account (CA) of the University of Bern. The cluster is meant to be used for research related to the University of Bern. 
**Before you can use this service we have to activate your CA for UBELIX**, see [Accounts and Activation](account.md). 
This page contains information on how to configure your SSH environment for a simplified login procedure and information regarding the application of a CA for external researchers.

## Log in to UBELIX

!!! types note "Before proceeding make sure that:"
    * you have your Campus Account activated for UBELIX (see above)
    * you have a working SSH client
        * Linux/Mac: e.g ssh command in a terminal 
        * Microsoft Windows: **MobaXterm**, Windows Subsytem Linux, or Putty. Alternatively, a flavor of Linux can be installed on Microsoft Windows using virtualization software (e.g VirtualBox). We strongly encourage you to familiarize with a Unix-based Terminal commands. 
    

!!! types caution "Requirement"
    Login to UBELIX is only possible from within the UniBE network. If you want to connect from outside, you must first establish a VPN connection. For VPN profiles and instructions see [the official tutorial](http://www.unibe.ch/university/campus_and_infrastructure/rund_um_computer/internetzugang/access_to_internal_resources_via_vpn/index_eng.html).


### Mac/Linux/Unix

Run the following commands in a terminal. Open an SSH connection to the submit host:

```Bash
$ ssh <username>@submit.unibe.ch
OR
$ ssh -l <username> submit.unibe.ch
```
At the password prompt enter your Campus Account password:

```Bash
$ ssh <username>@submit.unibe.ch
Password:
```

!!! types note ""
    Usually there is no indication of typing when entering your password (not even asterisks or bullets). That's intended. Just enter your password and press 'enter'.

After log in successfully you will see the welcome message and the command prompt:

```Bash
Last login: Tue Apr 21 16:17:26 2020

CentOS 7.7.1908.x86_64

FQDN:      submit01.ubelix.unibe.ch (10.1.129.21)
Processor: 24x Intel(R) Xeon(R) CPU E5-2630 v2 @ 2.60GHz
Kernel:    3.10.0-1062.9.1.el7.x86_64
Memory:    62.73 GiB
```

!!! type note "Customize your SSH session"
    Useful feartures like SSH alias, X and port forwarding are described on our page [SSH customization](ssh-customization.md). 

### MobaXterm at Microsoft Windows

Here we present the configuration and first steps using MobaXterm. This tool combines Terminal sessions with file transfer (scp/ftp) and X Window Server. There are many more features which are not described here. For a productive work environment you should get familiar with the tools, configuration and features. 

MobaXterm can be downloaded on the [MobaXterm Website](https://mobaxterm.mobatek.net/). There are two versions, portable and installation, you can choose one.

After installing and starting MobaXterm, a SSH session need to be configured:

 * Click 'Session' in the top left corner:
 ![MobaXterm Start](../images/mobaXterm_01_start.png "MobaXterm Start")
 * In "SSH" tab:
     - Set the remote host to submit.unibe.ch
     -  Enable the "Specify username" option and put your Campus Account short name in the corresponding box (here user ms20e149 will be used)
 * In the "Advanced SSH settings"
     - Set SSH-browser type to 'SCP (enhanced speed)'
     -  Optionally, tick the 'Follow SSH path' button
![MobaXterm Config](../images/mobaXterm_02_sshConfig.png "MobaXterm Config")

* From now one the settings are stored and you can access the session on the left at the star icon
![MobaXterm Sessions](../images/mobaXterm_02b_selectSession.png "MobaXterm Sessions")

* MobaXterm will ask you to store the Password and manage a MasterPassword. 

After starting the session, you should see the UBELIX login message and prompt. 
![MobaXterm Sessions](../images/mobaXterm_03_established.png "MobaXterm Overview")
Here we have a colored prompt, see [Shell Prompt](shell.md#shell-prompt). 
On the left hand side a File browser is located. There the UBELIX file system can be browsed and files up or downloaded, e.g. using drag and drop or the context menue. 
![MobaXterm File Browser](../images/mobaXterm_04_scp.png "SCP pane")

