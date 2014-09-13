Deuscoin Core integration/staging tree
=====================================

Copyright (c) 2014 Deuscoin Core - Original code Copyright Bitcoin Core Team

What is Deuscoin?
----------------

Deuscoin focuses on new features via a PHP interface instead of the software behind it. That allows for faster upgrades to the software in order to stay competitive. Deuscoin wallet runs on a nearly pristine version of Bitcoin for this reason. Deuscoin is the first coin to have an open-source PHP wallet that runs locally. Setup is very easy and it doesn't require you to configure a web server. On Windows, you simply run the installer and open the program.

For more information, as well as an immediately useable, binary version of
the Deuscoin Core software, see http://deuscoin.tk.

License
-------

Deuscoin Core is released under the terms of the MIT license. See [COPYING](COPYING) for more
information or see http://opensource.org/licenses/MIT.

Building Deuscoin
-------------------

As the software sources are not heavily modified, most of the Bitcoin documentation still applies, so the docs directory contains the original documentation. Also included is a custom taylored version of [how to build Deuscoin](blob/master/doc/building-deuscoin.md).

Development process
-------------------

Developers work in their own trees, then submit pull requests when they think
their feature or bug fix is ready.

If it is a simple/trivial/non-controversial change, then one of the Deuscoin
development team members simply pulls it.

If it is a *more complicated or potentially controversial* change, then the patch
submitter will be asked to start a discussion (if they haven't already) on the
[BitcoinTalk.org Announcement Thread](https://bitcointalk.org/index.php?board=159.0).

The patch will be accepted if there is broad consensus that it is a good thing.
Developers should expect to rework and resubmit patches if the code doesn't
match the project's coding conventions (see [doc/coding.md](doc/coding.md)) or are
controversial.

Development tips and tricks
---------------------------

**compiling for debugging**

Run configure with the --enable-debug option, then make. Or run configure with
CXXFLAGS="-g -ggdb -O0" or whatever debug flags you need.

**debug.log**

If the code is behaving strangely, take a look in the debug.log file in the data directory;
error and debugging message are written there.

The -debug=... command-line option controls debugging; running with just -debug will turn
on all categories (and give you a very large debug.log file).

The Qt code routes qDebug() output to debug.log under category "qt": run with -debug=qt
to see it.

**testnet and regtest modes**

Run with the -testnet option to run with "play deuscoins" on the test network, if you
are testing multi-machine code that needs to operate across the internet.

If you are testing something that can run on one machine, run with the -regtest option.
In regression test mode blocks can be created on-demand; see qa/rpc-tests/ for tests
that run in -regest mode.

**DEBUG_LOCKORDER**

Deuscoin Core is a multithreaded application, and deadlocks or other multithreading bugs
can be very difficult to track down. Compiling with -DDEBUG_LOCKORDER (configure
CXXFLAGS="-DDEBUG_LOCKORDER -g") inserts run-time checks to keep track of what locks
are held, and adds warning to the debug.log file if inconsistencies are detected.
