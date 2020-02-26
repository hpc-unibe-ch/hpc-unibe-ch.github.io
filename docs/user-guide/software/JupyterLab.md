# Jupyter Lab

## Description

Some useful information on using Jupyter Lab on UBELIX compute nodes.  

## Overview

On UBELIX we provide Jupyter Lab for working with Jupyter Notebooks. 
JupyterLab is a single-user web-based Notebook server, running in the user space. 
JupyterLab servers should be started preferably on a compute node, especially for compute intensive or memory intensive workloads. 
After starting the Jupyter Lab server your local browser can be connected using port forwarding. Therefore port forwarding needs to be enabled properly. 
On this page we describe:

* Launch JupyterLab
    * Connect to UBELIX and establishing SSH port forwarding 
    * SSH with port forwarding
    * Launch the JupyterLab server
    * Launch JupyterLab in your local browser
* Kernels
* Packages

# Launch JupyterLab

Since JupyterLab is a web based application, a port needs to be forwarded to your local machine, where your browser can connect to. 
This port numbers need to be between 2000 and 65000 and need to be unique on the present machine. 
The default port for JupyterLab is 8888, but only one user can use this at a time.

To avoid the need for modifying the following procedure again and again, we suggest to (once) select a unique number (between 2000 and 65000). And then following commands can be hopefully reused without modification.  
The port needs to be specified while establishing the connection to UBELIX and while launching JupyterLab. In the following we use the port number 15051 (**please select another number**).

## Setup SSH with port forwarding 

First, the port forwarding needs to be enabled between your local machine and UBELIX. Therewith a local port will be connected to the remote port on UBELIX. For simplicity, we kept both numbers the same (here 15051). This can be specified on the command line in the terminal.

> Note: MobaXterm has an internal terminal which acts like a linux terminal and can be configured as described in the Standard Terminal Setup. Therewith, the SSH command line approach above can be used.

## SSH with port forwarding

The ```ssh``` command need to be called with following arguments:

```
ssh -L 15051:localhost:15051 submit.unibe.ch
```
If configured in your ```.ssh/config```, you can also use the alias instead of the full name for UBELIX.

## Launch the JupyterLab server 

On UBELIX, the required *Anaconda3* module needs to be loaded. If you want to use additional kernels (R) you need to load additional modules, e.g. IRkernel (for R kernels):

```
module load Anaconda3
```

A script is provided, taking care of enabling the port forwarding to the compute node and launching JupyterLab. 
As an example a session with 60 min on 1 core can be launched using:

```
srun --ntasks 1 -t 60  jupyter-compute 15051  # please change port number
```

After general output, JupyterLab prints a URL with a unique key and the network port number where the web-server is listening, this should look similar to:

```
...
[C 21:43:35.291 LabApp]

    To access the notebook, open this file in a browser:
        file:///gpfs/homefs/id/ms20e149/.local/share/jupyter/runtime/nbserver-30194-open.html
    Or copy and paste one of these URLs:
        http://anode001:15051/?token=69ba5d24acab5915f2520c008a57df51f3cc38b7050ea073
     or http://127.0.0.1:15051/?token=69ba5d24acab5915f2520c008a57df51f3cc38b7050ea073
```

The last line needs to be copied in your local browser.

More resources can be requested, e.g. by using:

```
srun --ntasks 1 -t 60 --cpus-per-task 5 --mem 512MB jupyter-compute 15051 
```
Where 5 cores are requested for threading and a total memory of 3GB. 
Please do not use multiprocessing.cpu_count() since this is returning the total amount of cores on the node. 
Furthermore, if you use libraries, which implement threading: align the numbers of threads (often called jobs) to the selected number of cores (otherwise the performance will be affected).

OR requesting GPU resources on a node with a NVIDIA graphics card:
```
srun --ntasks 1 -t 60 --partition=gpu --gres=gpu:gtx1080ti:1 jupyter-compute 15051
```

## JupyterLab in your local browser 

Finally, you need to open your local web browser and copy and paste the URL specified by the JupyterLab server into the address bar. After initializing Jupyter Lab you should see a page similar to:

![jupyterLab-example](../../images/jupyterLab-example.png "JupyterLab Example")

Therewith the Notebook and its containing tasks are performed on a compute node, which can double check e.g. using using the following in Python:

```
import socket
print(socket.gethostname())
```

> Note: After stopping the JupyterLab server some sessions may get corrupted and do not take input correctly anymore. In this case just quit and re-establish your ssh session.

# Kernels

The following JupyterLab kernel are installed:

* Python3
* R

## R

verify that the module *IRkernel* is loaded

```
module load IRkernel
```

## Packages

There are a long list of default packages provided by Anaconda3 (list all using `!pip list`) and R (list using `installed.packages(.Library)`, note the list is shortened). 

Furthermore, you can install additional packages in Python using `pip install --user` or in R using `install.packages("sampling")`. 
