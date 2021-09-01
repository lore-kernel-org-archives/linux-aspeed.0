From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 1 Sep 2021 11:30:13 +0800
Subject: [PATCH v4 2/4] MAINTAINER: Add ASPEED eSPI driver entry
In-Reply-To: <20210901033015.910-1-chiawei_wang@aspeedtech.com>
References: <20210901033015.910-1-chiawei_wang@aspeedtech.com>
Message-ID: <20210901033015.910-3-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add Ryan Chen and myself as the maintainer of Aspeed eSPI
driver. Joel Stanley is added as the reviewer.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3267183e993..35c3164277ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1720,6 +1720,15 @@ F:	drivers/crypto/axis
 F:	drivers/mmc/host/usdhi6rol0.c
 F:	drivers/pinctrl/pinctrl-artpec*
 
+ARM/ASPEED ESPI DRIVER
+M:	Chia-Wei Wang <chiawei_wang@aspeedtech.com>
+M:	Ryan Chen <ryan_chen@aspeedtech.com>
+R:	Joel Stanley <joel@jms.id.au>
+L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
+L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/aspeed/espi.yaml
+
 ARM/ASPEED I2C DRIVER
 M:	Brendan Higgins <brendanhiggins@google.com>
 R:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
-- 
2.17.1

