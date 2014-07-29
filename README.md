Koha-gitify
===========
Koha-gitify will convert an existing Koha package install to use source code located in a git repo.

Koha installation and Setup
---------------------------

These instructions will help you get a Koha up and running to use with koha-gitify.
We will only go over using Ubuntu desktop edition to install Koha, doing this in a virtual machine on Windows or Mac should not be much different, but is left as an exercise for the reader.

Dependencies
------------

we will need apache2 and mysql-server installed

    sudo apt-get install mysql-server
    sudo apt-get install apache2

and then enable Apache rewrite

    sudo a2enmod rewrite
    sudo service apache2 restart

Installing
----------

These steps will install the Koha package from the current stable package available from the Koha Community

Type the following into your terminal: 

    echo deb http://debian.koha-community.org/koha squeeze main | sudo tee /etc/apt/sources.list.d/koha.list

install the key (to keep apt-get happy)

    wget -O- http://debian.koha-community.org/koha/gpg.asc | sudo apt-key add -

update and install

    sudo apt-get update
    sudo apt-get install koha-common

NB: If you get a prompt saying something along the lines of 'if you are upgrading, run /usr/sbin/koha-upgrade-to-3.4.sh' you can safely ignore this as we are doing a 'clean' install and not an upgrade

Install the Koha package site template 

    wget http://segfault.net.nz/koha-academy/koha-sites.conf
    sudo mv koha-sites.conf /etc/koha/

Create your first Koha instance

    sudo koha-create --create-db mykoha

In this case, "mykoha" is the name of our instance. You can name your instance whatever you like, but do make a note of the name for later.

Run the following command

    echo 127.0.0.1 mykoha.localhost mykoha-intra.localhost | sudo tee -a /etc/hosts

If you have named your instance something besides 'mykoha' - be sure to put that instance name in place of mykoha. 
if you are lucky (and you probably are), then you should be able to visit your new Koha instance, open your browser and try navigate to mykoha.localhost.

This is where most libraries stop. We have a few more tasks before we are done.

Transforming our Koha instance into a Developer instance
--------------------------------------------------------

Now we take our Koha instance and make it developer friendly, for this we need git, you can see if you have git installed by typing

    git

you may have to install it with

    sudo apt-get install git

Find a place you want to store Koha, your home directory works nicely.

    git clone git://git.koha-community.org/koha.git

now we have a fresh copy of the Koha codebase (in our Koha folder)
Next, we need to get the koha-gitify script and make it executable 
From another directory (the same place we put our Koha directory could be nice) 

    git clone git://github.com/mkfifo/koha-gitify.git
    cd koha-gitify
    chmod +x koha-gitify

now we run koha-gitify to convert our Koha instance we created above to use the Koha git repository we just cloned above

    sudo ./koha-gitify mykoha ~/koha

now we restart apache (our webserver that is hosting Koha)

    sudo service apache2 restart

and then we can visit our Koha instance again, in a browser navigate to mykoha-intra.localhost

Logging in for the first time
-----------------------------

We are first going to log in with the Super superlibrarian. This is the DB user and password.

db user is: koha_mykoha 

(do recall that if you named your instance something other than mykoha, you will use that instance name in place of mykoha)

to get the db password, execute the following:

    sudo xmlstarlet sel -t -v 'yazgfs/config/pass' /etc/koha/sites/mykoha/koha-conf.xml

(again, if you changed your instance name, replace 'mykoha' with your instance name)

Step through the Koha Installer

Now we are going to step through Koha's web installer. Please specify the following options:

* Step 1: En -> Next

* Dependencies ok -> Next

* Database settings ok -> Next

* Confirm -> Next

* Step 3: -> Next, wait a tick

* Success -> Next

* Click the link "install basic configuration settings"

* MARC Flavor: Tick Marc21 -> Next

* Now: Tick all the boxes! 

* Click import, wait a tick

* Success! -> Finish

If you now see a Koha login page, celebrate!

Log in with your credentials 
----------------------------

You will see a yellow box alert saying "You're logged in with the database administrator..."

* Click the link for "create a patron" 

* Give it a surname, a OPAC/Staff login and password, and click "Save"

* This should bring you back to a patron detail. 

* Click More 

* Click Set Permissions 

* Tick the box for "Superlibrarian" 

* Click Set Flags 

* Click Log out in the upper right hand corner 

* Log in again with your new username and password. Now we are ready to rock with an installed Koha. 

Celebrate!

Useful Links
------------

Using Git with Koha

http://wiki.koha-community.org/wiki/Version_Control_Using_Git

See the database schema and how it is laid out

http://schema.koha-community.org/

Information about signing off on patches

http://wiki.koha-community.org/wiki/Sign_off_on_patches

Using Git-BZ to attach patches to bugs

http://wiki.koha-community.org/wiki/Git_bz_configuration

Read Koha documentation: 

http://www.koha-community.org/documentation

Installing koha-gitify in a permanent location (advanced users):
-----------------------------------------------

If you want koha-gitify to live in a more permanent position you can install it with

    sudo make install

If you get sick of it then simply

    sudo make uninstall

