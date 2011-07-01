# rmsgen

## Synopsis 
This is a set of scripts useful for the generation of political notes. 

## Usage

### Setup Config File
    mkdir ~/.rmsgen
    touch ~/.rmsgen/config.yml

    # add the mail dir to the config.yml file
    mail_dir: /home/lacus/Mail/Stallman

    # output file for polnotes
    output_file: /home/lacus/polnotes.html

#### Config Options

     mail_dir: the local directory that stallman emails are sent to.
     output_file: the file to output polnotes

### Run `rmsgen` to iterate all messages in inbox

    $ rmsgen
    
## Todo
* Read email from IMAP server
