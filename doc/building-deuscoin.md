Building Deuscoin with Gitian
-----------------------------

**Environment**

Virtualbox running an instance of Ubuntu 12.04.4 64Bit (The version must be exact or you'll have issues!)

**Building - Rig Setup**

Follow the setup for Ubuntu in Virtualbox as described in the [Bitcoin Documentation](https://github.com/bitcoin/bitcoin/blob/master/doc/gitian-building.md)

Don't do the port mapping portion of that tutorial, but instead change the Network -> Attached to to be "Bridged Adapter." Boot into Ubuntu and log in as your user and run the following command.

	sudo vi /etc/network/interfaces

On the screen that pops up, hit the "insert" key and go to the last line and change "dhcp" to "static." Make the last line on your screen similar to the following for your connection.

	iface eth0 inet static
	address 192.168.0.10
	netmask 255.255.255.0
	gateway 192.168.0.1
	dns-nameservers 8.8.8.8 8.8.4.4

Once you're finished, save up and run the following to get online:

	sudo ifdown eth0
	sudo ifup eth0

From now on you can use PuTTY to make it easier by copy and pasting stuff. Now we'll add the required packages. Use WinSCP to move files back and forth easily from your Linux VirtualBox instance.

**Gitian Setup**

	sudo apt-get install git ruby1.9.1 apt-cacher-ng python-vm-builder qemu-utils debootstrap lxc python-cheetah parted kpartx bridge-utils

This next part sets up your environment for Gitian. You'll need to reboot for the changes to take effect.

	echo "%sudo ALL=NOPASSWD: /usr/bin/lxc-start" > /etc/sudoers.d/gitian-lxc
	echo 'export USE_LXC=1' >> ~/.profile
	echo 'LXC_GUEST_IP=10.0.3.5' >> ~/.profile
	echo 'GITIAN_HOST_IP=10.0.3.1' >> ~/.profile
	echo 'LXC_BRIDGE=lxcbr0' >> ~/.profile
	reboot

Now let's grab Gitian Builder and Deuscoin.

	cd ~
	git clone https://github.com/devrandom/gitian-builder.git
	git clone https://github.com/deuscoin/deuscoin.git

**Build Gitian's Templates**

Gitian Builder needs to build the template files for it to build with. This will take a few minutes, so go grab some coffee and watch TV... Yeah, that or read ahead.

	cd gitian-builder
	bin/make-base-vm --lxc --arch i386 --suite precise
	bin/make-base-vm --lxc --arch amd64 --suite precise

There will be a bunch of warnings, but you can ignore them.

**Prepare the Dependencies for Building Deuscoin**

This section only needs to be completed once.

Now we'll be following the [Bitcoin Release Process](https://github.com/bitcoin/bitcoin/blob/master/doc/release-process.md) loosely. Make the directory we'll be downloading everything to.

	mkdir -p inputs; cd inputs/

Go to [Apple's Developer website](https://developer.apple.com/downloads/download.action?path=Developer_Tools/xcode_4.6.3/xcode4630916281a.dmg) and register in order to get that dmg file. Once downloaded, extract the directory

	Xcode/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.7.sdk

That must be done on Mac OSX or the compile will fail. If you do not have a Mac OSX system handy, get a copy from [Mike Perry's files](https://people.torproject.org/~mikeperry/mirrors/sources/MacOSX10.7.sdk.tar.gz).

In PuTTY, run the following wgets.

	wget 'http://miniupnp.free.fr/files/download.php?file=miniupnpc-1.9.tar.gz' -O miniupnpc-1.9.tar.gz
	wget 'https://www.openssl.org/source/openssl-1.0.1h.tar.gz' --no-check-certificate
	wget 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz'
	wget 'http://zlib.net/zlib-1.2.8.tar.gz'
	wget 'ftp://ftp.simplesystems.org/pub/png/src/history/libpng16/libpng-1.6.8.tar.gz'
	wget 'https://fukuchi.org/works/qrencode/qrencode-3.4.3.tar.bz2'
	wget 'https://downloads.sourceforge.net/project/boost/boost/1.55.0/boost_1_55_0.tar.bz2'
	wget 'https://svn.boost.org/trac/boost/raw-attachment/ticket/7262/boost-mingw.patch' -O boost-mingw-gas-cross-compile-2013-03-03.patch
	wget 'https://download.qt-project.org/official_releases/qt/5.2/5.2.0/single/qt-everywhere-opensource-src-5.2.0.tar.gz'
	wget 'https://download.qt-project.org/official_releases/qt/5.2/5.2.1/single/qt-everywhere-opensource-src-5.2.1.tar.gz'
	wget 'https://download.qt-project.org/archive/qt/4.6/qt-everywhere-opensource-src-4.6.4.tar.gz'
	wget 'https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.bz2'
	wget 'https://github.com/mingwandroid/toolchain4/archive/10cc648683617cca8bcbeae507888099b41b530c.tar.gz'
	wget 'http://www.opensource.apple.com/tarballs/cctools/cctools-809.tar.gz'
	wget 'http://www.opensource.apple.com/tarballs/dyld/dyld-195.5.tar.gz'
	wget 'http://www.opensource.apple.com/tarballs/ld64/ld64-127.2.tar.gz'
	wget 'http://distfiles.lesslinux.org/cdrkit-1.1.11.tar.gz'
	wget 'https://github.com/theuni/libdmg-hfsplus/archive/libdmg-hfsplus-v0.1.tar.gz'
	wget 'http://llvm.org/releases/3.2/clang+llvm-3.2-x86-linux-ubuntu-12.04.tar.gz' -O clang-llvm-3.2-x86-linux-ubuntu-12.04.tar.gz
	wget 'https://raw.githubusercontent.com/theuni/osx-cross-depends/master/patches/cdrtools/genisoimage.diff' -O cdrkit-deterministic.patch

Now we build the dependencies for Deuscoin on Gitian. Ignore the ominous "stdin: is not a tty" messages. Everything comes out OK, but it takes a long time. (A few hours)

	cd ..
	./bin/gbuild ../deuscoin/contrib/gitian-descriptors/boost-linux.yml
	mv build/out/boost-*.zip inputs/
	./bin/gbuild ../deuscoin/contrib/gitian-descriptors/deps-linux.yml
	mv build/out/deuscoin-deps-*.zip inputs/
	./bin/gbuild ../deuscoin/contrib/gitian-descriptors/qt-linux.yml
	mv build/out/qt-*.tar.gz inputs/
	./bin/gbuild ../deuscoin/contrib/gitian-descriptors/boost-win.yml
	mv build/out/boost-*.zip inputs/
	./bin/gbuild ../deuscoin/contrib/gitian-descriptors/deps-win.yml
	mv build/out/deuscoin-deps-*.zip inputs/
	./bin/gbuild ../deuscoin/contrib/gitian-descriptors/qt-win.yml
	mv build/out/qt-*.zip inputs/
	./bin/gbuild ../deuscoin/contrib/gitian-descriptors/protobuf-win.yml
	mv build/out/protobuf-*.zip inputs/
	./bin/gbuild ../deuscoin/contrib/gitian-descriptors/gitian-osx-native.yml
	mv build/out/osx-*.tar.gz inputs/
	./bin/gbuild ../deuscoin/contrib/gitian-descriptors/gitian-osx-depends.yml
	mv build/out/osx-*.tar.gz inputs/
	./bin/gbuild ../deuscoin/contrib/gitian-descriptors/gitian-osx-qt.yml
	mv build/out/osx-*.tar.gz inputs/

**Building Deuscoin**

Let's build Deuscoin now.

	export SIGNER=(my-name)
	export VERSION=(1.0)



	./bin/gbuild --commit deuscoin=HEAD ../deuscoin/contrib/gitian-descriptors/gitian-linux.yml
	./bin/gsign --signer $SIGNER --release ${VERSION}-linux --destination ../gitian.sigs/ ../deuscoin/contrib/gitian-descriptors/gitian-linux.yml
	pushd build/out
	zip -r deuscoin-${VERSION}-linux-gitian.zip *
	mv deuscoin-${VERSION}-linux-gitian.zip ../../../
	popd


	./bin/gbuild --commit deuscoin=HEAD ../deuscoin/contrib/gitian-descriptors/gitian-win.yml
	./bin/gsign --signer $SIGNER --release ${VERSION}-win --destination ../gitian.sigs/ ../deuscoin/contrib/gitian-descriptors/gitian-win.yml
	pushd build/out
	zip -r deuscoin-${VERSION}-win-gitian.zip *
	mv deuscoin-${VERSION}-win-gitian.zip ../../../
	popd


	./bin/gbuild --commit deuscoin=HEAD ../deuscoin/contrib/gitian-descriptors/gitian-osx-deuscoin.yml
	./bin/gsign --signer $SIGNER --release ${VERSION}-osx --destination ../gitian.sigs/ ../deuscoin/contrib/gitian-descriptors/gitian-osx-deuscoin.yml
	pushd build/out
	mv deuscoin-Qt.dmg ../../../
	popd
	popd
