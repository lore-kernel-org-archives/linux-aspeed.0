From: Neal Liu <neal_liu@aspeedtech.com>
Date: Mon, 19 Sep 2022 14:37:05 +0800
Subject: [PATCH] crypto: aspeed: fix build error when only CRYPTO_DEV_ASPEED is enabled
Message-ID: <20220919063705.358225-1-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix build error within the following configs setting:
- CONFIG_CRYPTO_DEV_ASPEED=y
- CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH is not set
- CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO is not set

Error messages:
make[4]: *** No rule to make target 'drivers/crypto/aspeed/aspeed_crypto.o'
, needed by 'drivers/crypto/aspeed/built-in.a'.
make[4]: Target '__build' not remade because of errors.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/crypto/aspeed/Kconfig  | 3 +--
 drivers/crypto/aspeed/Makefile | 7 ++++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
index ae3eb0eb57f6..ae2710ae8d8f 100644
--- a/drivers/crypto/aspeed/Kconfig
+++ b/drivers/crypto/aspeed/Kconfig
@@ -1,6 +1,7 @@
 config CRYPTO_DEV_ASPEED
 	tristate "Support for Aspeed cryptographic engine driver"
 	depends on ARCH_ASPEED || COMPILE_TEST
+	select CRYPTO_ENGINE
 	help
 	  Hash and Crypto Engine (HACE) is designed to accelerate the
 	  throughput of hash data digest, encryption and decryption.
@@ -20,7 +21,6 @@ config CRYPTO_DEV_ASPEED_DEBUG
 config CRYPTO_DEV_ASPEED_HACE_HASH
 	bool "Enable Aspeed Hash & Crypto Engine (HACE) hash"
 	depends on CRYPTO_DEV_ASPEED
-	select CRYPTO_ENGINE
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
@@ -34,7 +34,6 @@ config CRYPTO_DEV_ASPEED_HACE_HASH
 config CRYPTO_DEV_ASPEED_HACE_CRYPTO
 	bool "Enable Aspeed Hash & Crypto Engine (HACE) crypto"
 	depends on CRYPTO_DEV_ASPEED
-	select CRYPTO_ENGINE
 	select CRYPTO_AES
 	select CRYPTO_DES
 	select CRYPTO_ECB
diff --git a/drivers/crypto/aspeed/Makefile b/drivers/crypto/aspeed/Makefile
index 3be78cec0ecb..a0ed40ddaad1 100644
--- a/drivers/crypto/aspeed/Makefile
+++ b/drivers/crypto/aspeed/Makefile
@@ -1,6 +1,7 @@
-hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) := aspeed-hace.o aspeed-hace-hash.o
-hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) := aspeed-hace.o aspeed-hace-crypto.o
+hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) := aspeed-hace-hash.o
+hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) := aspeed-hace-crypto.o
 
 obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
-aspeed_crypto-objs := $(hace-hash-y)	\
+aspeed_crypto-objs := aspeed-hace.o	\
+		      $(hace-hash-y)	\
 		      $(hace-crypto-y)
-- 
2.25.1

