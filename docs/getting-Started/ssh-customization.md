# Customize your SSH environment

## Description 
This page is listing useful tricks and features with SSH connections.

## Create a SSH alias

**Mac/Linux/Unix**

To simplify the login procedure you can define an alias for the user-/hostname combination. Add a host declaration to ~/.ssh/config **on your local desktop/laptop** (substitute your own alias and username):


**~/.ssh/config**
```Bash
Host <alias>
    Hostname submit03.unibe.ch
    User <user>
```

From now on you can log in to the cluster by using the specified alias:

```Bash
$ ssh <alias>
```

You still have to provide your password!

## SSH session timeout

**Mac/Linux/Unix**  
If a SSH connection goes idle for a specific amount of time (default 10 minutes), you may be confronted with a "Write failed: Broken pipe" error message or the connection is simply frozen, and you are forced to log in again. To prevent this from happening, configure the client to periodically (e.g. every 60 seconds) send a message to trigger a response from the remote server. To do so, add the following line to the SSH configuration file:

```Bash
ServerAliveInterval 60
```

The host declaration may now look like this:

**~/.ssh/config**
```Bash
Host <alias>
    Hostname submit03.unibe.ch
    User <user>
    ServerAliveInterval 60
```

## SSH key pairs

**Mac/Linux/Unix**  
SSH keys serve as a means of identifying a user to a SSH server. When using SSH keys your password will never be send over the network.
Here SSH keys are created on your local desktop/laptop which are later used to authenticate during a SSH login into UBELIX. 
Therefore, the following steps are required:

- Creation of key pair consisting of a private and a public key
- Adding a public key to your UBELIX account
- Adding the key to the SSH config

### Creation of key pair

!!! types caution ""
    Remember to always keep your private keys private! Share only public keys, never share your private key.

!!! types info ""
    If you already have a valid private/public key pair that you also want to use for UBELIX, you can omit the rest of this section and continue with "Adding a public key to your UBELIX account". 

First, generate a private/public key pair. You can substitute your own comment (-C).  To accept the default name/location simply press Enter, otherwise specify a different name/location:

```Bash
$ ssh-keygen -t rsa -b 4096 -C "ubelix"
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/<user>/.ssh/id_rsa):
```

Enter and confirm a secure passphrase:

!!! types caution ""
    If you do not specify a passphrase and someone else gets a copy of your private key, then he will be able to login with your identity on any account that uses the corresponding public key!

```Bash
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

### Adding a public key to your UBELIX account

Now, the public key need to be added to the `~/.ssh/authorized_keys` file in your UBELIX account. This step can be done by simply issuing:

```Bash
ssh-copy-id -i ~/.ssh/id_rsa_ubelix.pub `<alias>`
```

### Adding the key to the SSH config
Add the key to your host declaration in your local ssh configuration:

**~/.ssh/config**
```Bash
Host <alias>
    Hostname submit03.unibe.ch
    User <user>
    ServerAliveInterval 60
    IdentityFile ~/.ssh/id_rsa_ubelix
```

If everything was correct, you will now be able to login without providing you Campus Account password upon your next login attempt. However, if you have secured your key with a passphrase, you will get prompted for your passphrase instead. You can use ssh-agent to securely save your passphrase, so you do not have to re-enter it all the time.

### Adding your Key to SSH-Agent  
The behavior of ssh-agent depends on the flavor and version of your operating system. On OS X Leopard or later your keys can be saved in the system's keychain. Most Linux installations will automatically start ssh-agent when you log in.

Add the key to ssh-agent:

```Bash
$ ssh-add ~/.ssh/id_rsa_ubelix
```

## X11 - forwarding
For applications with graphical interfaces X11-forwarding is sometimes necessary. You can enable X11-forwarding by using `-Y` option during your login process:
```Bash 
ssh -Y <alias>
```
The success can be tested e.g. by calling `xterm` on the login node, which should open a new window. 
Keep in mind your local operating system need to have a X server running. E.g. Xming on Windows or XQuartz for Mac.

## Passwordless SSH within the HPCs
Some application require passwordless SSH within the HPC machine, e.g. for establishing reverse port forwarding. 
Please verify that you created and registered a SSH key within UBELIX. If you can perform the following command without entering your password your are ready to go:
```Bash
ssh localhost
```
otherwise create and register a new key on a login node.
```Bash
ssh-keygen -t rsa -b 4096
# follow on-screen instructions and choose defaults: id_rsa / no passphrase
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 640 .ssh/authorized_keys
```

## Port forwarding
Some application like JupyterLab require port forwarding, where a port on the remote machine gets connected with a port on the local machine. 
The ssh command need to be called with additional arguments:

```Bash
ssh -Y -L 15051:localhost:15051 submit03.unibe.ch
```

Here port 15051 is selected for both sides. Ports are numbers between 2000 and 65000, which needs to be unique on the present machine. The default port for JupyterLab is 8888, but only one user can use this port on the machine at a time.
To avoid the need for modifying your workflow again and again, we suggest to (once) select a unique number (between 2000 and 65000), which hopfully and most likely will not be used by another user. 
