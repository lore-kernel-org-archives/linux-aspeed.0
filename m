From: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 6 Jan 2021 13:59:35 +0800
Subject: [PATCH 2/6] MAINTAINER: Add ASPEED eSPI driver entry
In-Reply-To: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
References: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
Message-ID: <20210106055939.19386-3-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add myself and Ryan Chen as maintainer of the Aspeed eSPI
driver and the associated eSPI interrupt controller.
Joel Stanley is also added as the reviewer.

Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c1e45c416b1..d5f9205a5439 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1639,6 +1639,20 @@ F:	drivers/crypto/axis
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
+F:	drivers/irqchip/irq-aspeed-espi-ic.c
+F:	drivers/soc/aspeed/aspeed-espi*
+F:	include/dt-bindings/interrupt-controller/aspeed-espi-ic.h
+F:	include/soc/aspeed/espi.h
+F:	include/uapi/linux/aspeed-espi.h
+
 ARM/ASPEED I2C DRIVER
 M:	Brendan Higgins <brendanhiggins@google.com>
 R:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
-- 
2.17.1

