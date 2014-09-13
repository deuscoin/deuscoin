Deuscoin Core integration/staging tree
=====================================

Copyright (c) 2014 Deuscoin Core - Original code Copyright Bitcoin Core Team

What is Deuscoin?
----------------

Deuscoin focuses on new features via a PHP interface instead of the software behind it. That allows for faster upgrades to the software in order to stay competitive. Deuscoin wallet runs on a nearly pristine version of Bitcoin for this reason. Deuscoin is the first coin to have an open-source PHP wallet that runs locally. Setup is very easy and it doesn't require you to configure a web server. On Windows, you simply run the installer and open the program.

For more information, as well as an immediately useable, binary version of
the Deuscoin Core software, see http://deuscoin.tk.

Where is Deuscoin-QT?
---------------------

As the whole purpose of Dueuscoin is to focus exclusivly on providing a feature packed PHP based wallet, the QT client isn't used. The PHP wallet takes the place of the QT interface you're used to seeing and offers you a nicer, clean-cut interface with the same features and then some. You can still build the QT binaries from these sources, but QT is not included in the official binary releases. If there's enough of a demand for them, they may appear in the official binary releases at a later date.

Why is it based on Bitcoin directly?
------------------------------------

Bitcoin is the first crypto-coin ever to be developed and has massive amounts of exposure. With that kind of exposure and with the market full of hackers, Bitcoin's code has been tried, tested, and used by millions of people. Bitcoin is activly developed and under constant security scrutiny, so it makes sense to clone Bitcoin directly. The Bitcoin Binaries are easily updated and deployed as a Deuscoin upgrade and they won't take away from the time required to focus on developing new PHP wallet features.

As an added bonus, Bitcoin is a Sha-256 based PoW coin, but the difficulty of the coin is astoundingly high. Deuscoin offers miners who would otherwise be loosing money mining Bitcoin, the opportunity to take part in our exciting new project while securing the Deuscoin network and making a nice profit. So, bring out your old mining rigs and mine Deuscoin!

License
-------

Deuscoin Core is released under the terms of the MIT license. See [COPYING](COPYING) for more
information or see http://opensource.org/licenses/MIT.

Building Deuscoin
-------------------

As the software sources are not heavily modified, most of the Bitcoin documentation still applies, so the docs directory contains the original documentation. Also included is a custom taylored version of [how to build Deuscoin](doc/building-deuscoin.md).

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
