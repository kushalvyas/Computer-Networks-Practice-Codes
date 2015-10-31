	
I would not recommend compiling Wireshark on Ubuntu(it is possible, but there are too many odd library dependencies for the average user to troubleshoot).

If you are simply looking to be able to sniff multiple interfaces, any version past 1.8.0 will be able do that. Fortunately, there is a PPA(see below) that will allow you to install Wireshark without the need to compile from source.

You can install a PPA package that provides Wireshark 1.8.2 to 12.04 rather than compiling from source. The latest wireshark version is 1.8.4 and the latest in the Ubuntu 12.04 repositories is 1.6.7. The following provides instruction for installing wireshark 1.8.2

To install the PPA, run the following commands:

sudo add-apt-repository ppa:eugenesan/ppa
sudo apt-get update
sudo apt-get install wireshark
To start Wireshark, run the command sudo wireshark

Note: It is necessary to run the application as sudo since one needs elevated privileges in order to have access to the raw network stack.
