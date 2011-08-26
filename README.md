# rmsgen

## Synopsis 
This is a set of scripts useful for the generation of political notes. 

## Usage

### Setup Config File

Create the default directory structure:

    mkdir ~/.rmsgen
    touch ~/.rmsgen/config.yml

The configuration file will take multiple options. The following options are available for use.

### Config Options

#### Local Storage

Use __email_dir__ to set the local directory that RMS emails are sent to.

Note: Do not use __email_dir__ if you are reading polnotes from an IMAP server.

     # example
     email_dir:  /home/uname/mail/rms

#### IMAP

Use the following IMAP options for logging into an IMAP server:  

* __imap_server__ - the address of an IMAP server
* __imap_login__ - the login for an IMAP server
* __imap_password__ - the password for an IMAP server


        # example
        imap_server: mail.example.com
        imap_login: abc123
        imap_password: rainbowsandunicorns

#### Output File

Use __output_file__ to set the file that the polnote html source is written to.

Note: path must be absolute.

    # example
    output_file: /home/uname/polnotes.html

## Run `rmsgen` to iterate all messages in inbox

    $ rmsgen
