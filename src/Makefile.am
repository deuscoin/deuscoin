AM_LDFLAGS = $(PTHREAD_CFLAGS) $(LIBTOOL_LDFLAGS)

if USE_LIBSECP256K1
secp256k1/libsecp256k1.la: $(wildcard secp256k1/src/*) $(wildcard secp256k1/include/*)
	@$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)
endif

if EMBEDDED_LEVELDB
LEVELDB_CPPFLAGS += -I$(srcdir)/leveldb/include
LEVELDB_CPPFLAGS += -I$(srcdir)/leveldb/helpers/memenv
LIBLEVELDB += $(builddir)/leveldb/libleveldb.a
LIBMEMENV  += $(builddir)/leveldb/libmemenv.a

# NOTE: This dependency is not strictly necessary, but without it make may try to build both in parallel, which breaks the LevelDB build system in a race
$(LIBLEVELDB): $(LIBMEMENV)

$(LIBLEVELDB) $(LIBMEMENV):
	@echo "Building LevelDB ..." && $(MAKE) -C $(@D) $(@F) CXX="$(CXX)" \
	  CC="$(CC)" PLATFORM=$(TARGET_OS) AR="$(AR)" $(LEVELDB_TARGET_FLAGS) \
          OPT="$(CXXFLAGS) $(CPPFLAGS)"
endif

DEUSCOIN_CONFIG_INCLUDES=-I$(builddir)/config
DEUSCOIN_INCLUDES=-I$(builddir) -I$(builddir)/obj $(BOOST_CPPFLAGS) $(LEVELDB_CPPFLAGS) $(CRYPTO_CFLAGS) $(SSL_CFLAGS)

if USE_LIBSECP256K1
DEUSCOIN_INCLUDES += -I$(srcdir)/secp256k1/include
endif

LIBDEUSCOIN_SERVER=libdeuscoin_server.a
LIBDEUSCOIN_WALLET=libdeuscoin_wallet.a
LIBDEUSCOIN_COMMON=libdeuscoin_common.a
LIBDEUSCOIN_CLI=libdeuscoin_cli.a
LIBDEUSCOIN_UTIL=libdeuscoin_util.a
LIBDEUSCOIN_CRYPTO=crypto/libdeuscoin_crypto.a
LIBDEUSCOIN_UNIVALUE=univalue/libdeuscoin_univalue.a
LIBDEUSCOINQT=qt/libdeuscoinqt.a

noinst_LIBRARIES = \
  libdeuscoin_server.a \
  libdeuscoin_common.a \
  libdeuscoin_cli.a \
  libdeuscoin_util.a \
  univalue/libdeuscoin_univalue.a \
  crypto/libdeuscoin_crypto.a
if ENABLE_WALLET
DEUSCOIN_INCLUDES += $(BDB_CPPFLAGS)
noinst_LIBRARIES += libdeuscoin_wallet.a
endif

bin_PROGRAMS =
TESTS =

if BUILD_DEUSCOIND
  bin_PROGRAMS += deuscoind
endif

if BUILD_DEUSCOIN_UTILS
  bin_PROGRAMS += deuscoin-cli deuscoin-tx
endif

.PHONY: FORCE
# deuscoin core #
DEUSCOIN_CORE_H = \
  addrman.h \
  alert.h \
  allocators.h \
  base58.h \
  bloom.h \
  chainparams.h \
  chainparamsbase.h \
  chainparamsseeds.h \
  checkpoints.h \
  checkqueue.h \
  clientversion.h \
  coincontrol.h \
  coins.h \
  compat.h \
  core.h \
  core_io.h \
  crypter.h \
  db.h \
  hash.h \
  init.h \
  key.h \
  keystore.h \
  leveldbwrapper.h \
  limitedmap.h \
  main.h \
  miner.h \
  mruset.h \
  netbase.h \
  net.h \
  noui.h \
  pow.h \
  protocol.h \
  random.h \
  rpcclient.h \
  rpcprotocol.h \
  rpcserver.h \
  script/interpreter.h \
  script/compressor.h \
  script/script.h \
  script/sign.h \
  script/standard.h \
  wallet_ismine.h \
  serialize.h \
  sync.h \
  threadsafety.h \
  timedata.h \
  tinyformat.h \
  txdb.h \
  txmempool.h \
  ui_interface.h \
  uint256.h \
  util.h \
  utilstrencodings.h \
  utilmoneystr.h \
  utiltime.h \
  version.h \
  walletdb.h \
  wallet.h \
  compat/sanity.h

JSON_H = \
  json/json_spirit.h \
  json/json_spirit_error_position.h \
  json/json_spirit_reader.h \
  json/json_spirit_reader_template.h \
  json/json_spirit_stream_reader.h \
  json/json_spirit_utils.h \
  json/json_spirit_value.h \
  json/json_spirit_writer.h \
  json/json_spirit_writer_template.h

obj/build.h: FORCE
	@$(MKDIR_P) $(builddir)/obj
	@$(top_srcdir)/share/genbuild.sh $(abs_top_builddir)/src/obj/build.h \
	  $(abs_top_srcdir)
libdeuscoin_util_a-version.$(OBJEXT): obj/build.h

# server: shared between deuscoind and deuscoin-qt
libdeuscoin_server_a_CPPFLAGS = $(DEUSCOIN_INCLUDES) $(MINIUPNPC_CPPFLAGS)
libdeuscoin_server_a_SOURCES = \
  addrman.cpp \
  alert.cpp \
  bloom.cpp \
  checkpoints.cpp \
  init.cpp \
  leveldbwrapper.cpp \
  main.cpp \
  miner.cpp \
  net.cpp \
  noui.cpp \
  pow.cpp \
  rpcblockchain.cpp \
  rpcmining.cpp \
  rpcmisc.cpp \
  rpcnet.cpp \
  rpcrawtransaction.cpp \
  rpcserver.cpp \
  timedata.cpp \
  txdb.cpp \
  txmempool.cpp \
  $(JSON_H) \
  $(DEUSCOIN_CORE_H)

# wallet: shared between deuscoind and deuscoin-qt, but only linked
# when wallet enabled
libdeuscoin_wallet_a_CPPFLAGS = $(DEUSCOIN_INCLUDES)
libdeuscoin_wallet_a_SOURCES = \
  db.cpp \
  crypter.cpp \
  rpcdump.cpp \
  rpcwallet.cpp \
  wallet_ismine.cpp \
  wallet.cpp \
  walletdb.cpp \
  $(DEUSCOIN_CORE_H)

# crypto primitives library
crypto_libdeuscoin_crypto_a_CPPFLAGS = $(DEUSCOIN_CONFIG_INCLUDES)
crypto_libdeuscoin_crypto_a_SOURCES = \
  crypto/sha1.cpp \
  crypto/sha2.cpp \
  crypto/ripemd160.cpp \
  crypto/common.h \
  crypto/sha2.h \
  crypto/sha1.h \
  crypto/ripemd160.h

# univalue JSON library
univalue_libdeuscoin_univalue_a_SOURCES = \
  univalue/univalue.cpp \
  univalue/univalue_read.cpp \
  univalue/univalue_write.cpp \
  univalue/univalue_escapes.h \
  univalue/univalue.h

# common: shared between deuscoind, and deuscoin-qt and non-server tools
libdeuscoin_common_a_CPPFLAGS = $(DEUSCOIN_INCLUDES)
libdeuscoin_common_a_SOURCES = \
  allocators.cpp \
  base58.cpp \
  chainparams.cpp \
  coins.cpp \
  core.cpp \
  core_read.cpp \
  core_write.cpp \
  hash.cpp \
  key.cpp \
  keystore.cpp \
  netbase.cpp \
  protocol.cpp \
  script/interpreter.cpp \
  script/compressor.cpp \
  script/script.cpp \
  script/sign.cpp \
  script/standard.cpp \
  $(DEUSCOIN_CORE_H)

# util: shared between all executables.
# This library *must* be included to make sure that the glibc
# backward-compatibility objects and their sanity checks are linked.
libdeuscoin_util_a_CPPFLAGS = $(DEUSCOIN_INCLUDES)
libdeuscoin_util_a_SOURCES = \
  compat/glibc_sanity.cpp \
  compat/glibcxx_sanity.cpp \
  chainparamsbase.cpp \
  random.cpp \
  rpcprotocol.cpp \
  sync.cpp \
  uint256.cpp \
  util.cpp \
  utilstrencodings.cpp \
  utilmoneystr.cpp \
  utiltime.cpp \
  version.cpp \
  $(DEUSCOIN_CORE_H)

if GLIBC_BACK_COMPAT
libdeuscoin_util_a_SOURCES += compat/glibc_compat.cpp
libdeuscoin_util_a_SOURCES += compat/glibcxx_compat.cpp
endif

# cli: shared between deuscoin-cli and deuscoin-qt
libdeuscoin_cli_a_CPPFLAGS = $(DEUSCOIN_INCLUDES)
libdeuscoin_cli_a_SOURCES = \
  rpcclient.cpp \
  $(DEUSCOIN_CORE_H)

nodist_libdeuscoin_util_a_SOURCES = $(srcdir)/obj/build.h
#

# deuscoind binary #
deuscoind_LDADD = \
  $(LIBDEUSCOIN_SERVER) \
  $(LIBDEUSCOIN_COMMON) \
  $(LIBDEUSCOIN_UNIVALUE) \
  $(LIBDEUSCOIN_UTIL) \
  $(LIBDEUSCOIN_CRYPTO) \
  $(LIBLEVELDB) \
  $(LIBMEMENV)

if USE_LIBSECP256K1
  deuscoind_LDADD += secp256k1/libsecp256k1.la
endif

if ENABLE_WALLET
deuscoind_LDADD += libdeuscoin_wallet.a
endif
deuscoind_SOURCES = deuscoind.cpp
#

if TARGET_WINDOWS
deuscoind_SOURCES += deuscoind-res.rc
endif

deuscoind_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS)
deuscoind_CPPFLAGS = $(DEUSCOIN_INCLUDES)
deuscoind_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS)

# deuscoin-cli binary #
deuscoin_cli_LDADD = \
  $(LIBDEUSCOIN_CLI) \
  $(LIBDEUSCOIN_COMMON) \
  $(LIBDEUSCOIN_UTIL) \
  $(LIBDEUSCOIN_CRYPTO) \
  $(BOOST_LIBS) \
  $(SSL_LIBS) \
  $(CRYPTO_LIBS)

deuscoin_cli_SOURCES = \
  deuscoin-cli.cpp

if USE_LIBSECP256K1
  deuscoin_cli_LDADD += secp256k1/libsecp256k1.la
endif
deuscoin_cli_CPPFLAGS = $(DEUSCOIN_INCLUDES)
#

# deuscoin-tx binary #
deuscoin_tx_LDADD = \
  $(LIBDEUSCOIN_UNIVALUE) \
  $(LIBDEUSCOIN_COMMON) \
  $(LIBDEUSCOIN_UTIL) \
  $(LIBDEUSCOIN_CRYPTO)

if USE_LIBSECP256K1
  deuscoin_tx_LDADD += secp256k1/libsecp256k1.la
endif

  deuscoin_tx_LDADD += $(BOOST_LIBS) \
  $(SSL_LIBS) \
  $(CRYPTO_LIBS)
deuscoin_tx_SOURCES = deuscoin-tx.cpp
deuscoin_tx_CPPFLAGS = $(DEUSCOIN_INCLUDES)
#
deuscoin_tx_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS)

if TARGET_WINDOWS
deuscoin_cli_SOURCES += deuscoin-cli-res.rc
endif
deuscoin_cli_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS)

CLEANFILES = leveldb/libleveldb.a leveldb/libmemenv.a *.gcda *.gcno

DISTCLEANFILES = obj/build.h

EXTRA_DIST = leveldb secp256k1

clean-local:
	-$(MAKE) -C leveldb clean
	-$(MAKE) -C secp256k1 clean 2>/dev/null
	rm -f leveldb/*/*.gcno leveldb/helpers/memenv/*.gcno
	-rm -f config.h

.rc.o:
	@test -f $(WINDRES)
	$(AM_V_GEN) $(WINDRES) -i $< -o $@

.mm.o:
	$(AM_V_CXX) $(OBJCXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) \
	  $(CPPFLAGS) $(AM_CXXFLAGS) $(QT_INCLUDES) $(CXXFLAGS)  -c -o $@ $<

%.pb.cc %.pb.h: %.proto
	@test -f $(PROTOC)
	$(AM_V_GEN) $(PROTOC) --cpp_out=$(@D) --proto_path=$(abspath $(<D) $<)

if ENABLE_TESTS
include Makefile.test.include
endif

if ENABLE_QT
include Makefile.qt.include
endif

if ENABLE_QT_TESTS
include Makefile.qttest.include
endif
