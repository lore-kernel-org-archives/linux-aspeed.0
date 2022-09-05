From: Neal Liu <neal_liu@aspeedtech.com>
Date: Mon, 5 Sep 2022 10:54:33 +0800
Subject: [PATCH v2] crypto: aspeed: fix build module error
Message-ID: <20220905025433.1610696-1-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

If CONFIG_MODULES=y and CONFIG_CRYPTO_DEV_ASPEED=m,
build modpost would be failed.

Error messages:
  ERROR: modpost: "aspeed_register_hace_hash_algs"
  [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
  ERROR: modpost: "aspeed_unregister_hace_hash_algs"
  [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!

Change build sequence to fix this.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
v2: Remove redundant obj- lines.

 drivers/crypto/aspeed/Makefile | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/aspeed/Makefile b/drivers/crypto/aspeed/Makefile
index 421e2ca9c53e..3be78cec0ecb 100644
--- a/drivers/crypto/aspeed/Makefile
+++ b/drivers/crypto/aspeed/Makefile
@@ -1,9 +1,6 @@
+hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) := aspeed-hace.o aspeed-hace-hash.o
+hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) := aspeed-hace.o aspeed-hace-crypto.o
+
 obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
-aspeed_crypto-objs := aspeed-hace.o	\
-		      $(hace-hash-y)	\
+aspeed_crypto-objs := $(hace-hash-y)	\
 		      $(hace-crypto-y)
-
-obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) += aspeed-hace-hash.o
-hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) := aspeed-hace-hash.o
-obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) += aspeed-hace-crypto.o
-hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) := aspeed-hace-crypto.o
-- 
2.25.1

