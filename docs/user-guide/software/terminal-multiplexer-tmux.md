# Terminal Multiplexer (tmux)

## Description

Frequently, people want to run programs on the submit host independently from an SSH session. Besides allowing a user to access multiple terminal sessions inside a single terminal window, tmux also lets you separate a program from the Unix shell that started the program. Tmux allows you detach from your running tmux session (the session will keep running in the background) and attach to the same session later on. Because the tmux session is running on the remote server, your session persists even on logout.

## Working Example

Start a new tmux session on the submit host:

```Bash
$ tmux new -s first_session
```

This will automatically attach you to a tmux session named first_session.

Do your work within your tmux session.

Detach from the session:

```Bash
Ctrl-b d
```

Now you cloud disconnect from the server and reconnect later on.

List all your existing tmux session:

```Bash
$ tmux ls
first_session: 1 windows (created Wed Jan 14 15:23:11 2016) [80x85]
```Bash

Reattach to an existing tmux session:

```Bash
$ tumb attach -t first_session
```

### Further Information

A tmux primer: [https://danielmiessler.com/study/tmux](https://danielmiessler.com/study/tmux/)

