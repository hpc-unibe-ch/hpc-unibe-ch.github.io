# Code of Conduct

On this page we list some expectations from our side and recommended practice that
is crucial for maintaining a good and professional working relationship between the 
user and the system administrators. Most of those contents are quite self-explanatory 
while others help to reduce the amount of support time needed to allocate.

## General

  * We assume that you are familiar with some basic knowledge about Linux command 
  line (shell) navigation and shell scripting. If you never worked on the command 
  line, consider some Linux tutorials on the subject first.
  * We expect you to exploit this valuable documentation before asking for help.
  All that is needed to get some simple jobs done on UBELIX is documented here.

## Account

  * Staff accounts are preferred over student accounts! If you currently use your 
  student Campus Account to access UBELIX, but you also possess a staff Campus 
  Account, get in contact with us so we can activate your staff Campus Account,
  migrate all your user data to the new account and deactivate your student account
  for UBELIX.

## Mailing List

  * We communicate upcoming events (e.g. maintenance downtimes) on our mailing list. 
  Make sure that you are subscribed to this list, otherwise you will miss important
  announcements.

## Security

  * Do not share your account
  * If using public key authentication, do not share your private key

## General Communication with the Cluster Administrators
  
  * Use the support email address [hpc@id.unibe.ch](mailto:hpc@id.unibe.ch) for question regarding
  UBELIX. Do not use the personal email address of a cluster administrator. This
  is important because it keeps all administrators informed about the ongoing 
  problem-solving process, and if one administrator is on vacation, another
  administrator can help you with your question
  * For each new problem start a new conversation with a new subject. Avoid to write
  to us by replying to an old answer mail from the last problem that you received 
  from us or even worse by replying to mailing list email you received from us. The 
  point here is that though it looks like an ordinary email, you actually are opening
  a new ticket in our ticket system (or reopening an old ticket if replying to an old email).
  * State your Campus Account username when communicating with the administrators. This helps
  us to identify you on the cluster faster.
  * Use your official UniBE email address for the communication with the cluster administrators,
  not any *@hotmail.com addresses or the like.

## Problem-Solving Process

  * Exploit resources provided by your institute/research group before asking the UBELIX 
  staff about domain-specific problems. We make an effort to help you, but we are no 
  experts in your field, hence a colleague from your group who uses the cluster to solve 
  a similar problem like you do might be a better first contact
  * Ask Google for help before contacting us. We often also just "google" for an answer,
  and then forward the outcome to you.
  * Do not ask for/expect step-by-step solutions to a problem. Sometimes we give 
  step-by-step instructions, but generally you should use our answers to do some 
  refined research on the problem. If you still stuck, we are happy to provide further 
  support
  * Always give an exact as possible description of the problem. Provide your username, 
  error messages, the path to the job script, the id of the job, and other hints that make
  the problem-solving process as economic as possible.

## Housekeeping

  * Clean up your home directory frequently, in particular before asking for an increase of your quota limit
  * Do not save thousands of files in a single directory. Distribute the files to subdirectories

## Job Submission

  * Before submitting the same job a hundred times, please verify that the job finishes
  successfully. We often experience that hundreds of jobs getting killed due to an
  invalid path referenced in the job script, which generates hundreds of notification 
  mails in our system.

## Cluster Performance

  * **DO NOT** run resource-intensive computations directly on the front-end server (submit
  host). This will have a negative impact on the performance of the whole cluster.
  Instead, submit such computations as a job to the cluster
  * **DO NOT** run server applications (PostgreSQL server, web server, ...) on the front-end 
  server (submit host). Such a program usually run as a background process (daemon) rather
  than being under the direct control of an interactive user. We will immediately kill
  such processes
