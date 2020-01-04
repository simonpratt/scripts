#
# My zsh shell setup scripts

This is just a bunch of little scripts I've created to make life smoother when setting my my local env's without wasting too much time. General idea is to run setup, and have my: ohmyzsh; vim; git; autocompletion ... installed automatically.

## prerequisites

* git
* curl

## what will happen when you run

When you run the script below it will do the following

* setup a `bin` directory in your home
* pull down and install ohmyzsh
* crete sim links for profiles i.e vim/pgsql
* install zsh + switching your default profile
* check out the setup script to find out more

## running

```bash
# in your home dir clone the scripts down
cd ~
git clone git@github.com:donkeyx/scripts.git

# now they have been downloaded you can run the install script
./scripts/setup.sh
