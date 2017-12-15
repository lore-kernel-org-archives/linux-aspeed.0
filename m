From: Joel Stanley <joel@jms.id.au>
Date: Fri, 15 Dec 2017 16:54:38 +1030
Subject: [PATCH v2 14/19] ARM: dts: aspeed: Sort ASPEED entries in makefile
In-Reply-To: <20171215062443.23059-1-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
Message-ID: <20171215062443.23059-15-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preperation for adding more boards.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d0381e9caf21..5d1e9d37bf3a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1101,7 +1101,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
-dtb-$(CONFIG_ARCH_ASPEED) += aspeed-bmc-opp-palmetto.dtb \
-	aspeed-bmc-opp-romulus.dtb \
-	aspeed-ast2500-evb.dtb
+dtb-$(CONFIG_ARCH_ASPEED) += \
+	aspeed-ast2500-evb.dtb \
+	aspeed-bmc-opp-palmetto.dtb \
+	aspeed-bmc-opp-romulus.dtb
 endif
-- 
2.14.1

