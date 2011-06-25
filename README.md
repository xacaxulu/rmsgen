# rmsgen

## Synopsis 
This is a set of scripts useful for the generation of political notes. `rmsgen` will only be useful
if you are a voluntary contributor for http://stallman.org

## Usage

### Setup Config File
    mkdir ~/.rmsgen
    touch ~/.rmsgen/config.yml

    # add the mail dir to the config.yml file
    mail_dir: /home/lacus/Mail/Stallman

#### Config Options

     mail_dir: the local directory that stallman emails are sent to.
     polnote_file: the file that the completed polnotes are written to. [Default: ~/.rmsgen/polnotes.html]
     urgent_file: the file that urgent polnotes are written to. [Default: ~/.rmsgen/urgent.html]

### Run `rmsgen` to iterate all messages in inbox

    $ rmsgen
    
## Todo
* Read email from IMAP server
