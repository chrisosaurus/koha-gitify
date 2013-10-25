Koha-gitify
===========
Koha-gitify will convert an existing Koha package install to use source code located in a git repo.

Prerequisites:
--------------
You will need to an existing package install, you can find the names of your existing instances by running `ls /etc/koha/sites/`

You will also need an existing koha clone, if you do not already have one then you can clone the repo using

    git clone git://git.koha-community.org/koha.git

Instructions for use:
---------------------

    git clone https://github.com/mkfifo/koha-gitify.git
    cd koha-gitify

    # replace instance-name with the name for one of your instances
    # /path/to/koha/clone should be the path to your koha git clone
    ./koha-gitify instance-name /path/to/koha/clone

Installing:
-----------

If you want koha-gitify to live in a more permanent position you can install it with

    sudo make install

If you get sick of it then simply

    sudo make uninstall

