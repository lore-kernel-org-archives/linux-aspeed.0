Return-Path: <linux-aspeed+bounces-1775-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43122C83F34
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Jul 2025 09:52:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmXcP6Tcsz3bV6;
	Tue, 22 Jul 2025 19:52:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753177941;
	cv=none; b=gWTU6IYOV+4t4ZeIQ1pZ84/FrwQOIktYQw+lG24wLgx7jvICc65LzKtKR4JoOs5jvEu0m6S5fV3EKpDYfK8E1rOlLkipERUc7OgQpxdzVB//mVcaITccJA8Oi6nqSTtleIM9KN7EQoeB6fmnLcRTjvfl74X3TkXQsyv4j61eIDxbv1xqvcKOuzebIEdQydXzArFOBwyApAJEZtC7EOV+e6yiBTXQ374FK/UGxuPOpQl9T4RGK2qmOR1WxfnfTxLVNIv1VYZpRVBPyiKUFm9vJGdHXACTfRVSKgb+A13Z3gmbCEdxnNhaj7g3R+x9HIeKIkKIGC5yceQVOccU5ymhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753177941; c=relaxed/relaxed;
	bh=rUo/yJ7a91LoDUP7SPiyBVha4MNKfVwyk503ltg1S60=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONoU32B/sR7Hjs9er+n97CynH+sGzD/lY98Kmu9Q16r/arPoZlKaGpVpZFOuEoLpOIWsHqDnSZoKnUc1qpsVQUImNqUyFJlgPzqzN4U2mo+dagjbSj+/2bFxP5BRQjYiH80P220PTV8oAIGjJBJ2SaAm0nuTkIQkedOGXunzFQdeLMxTTX/a5GZcPa7y0tpGcdrE0uy3rXqUPmpLs0mM9CBBwBQYgpOZsNW6mpXG6uNou5cnOPhK5ZMy3hn3nvWVSwFndCw2vUvp5Wb3F8DCVzesfIH45YVpgpTVChYbYOZgFZSDQPFvYr5mU40qAs3ttOXwVQonasNFjJ1muG5lKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmXcP2HVSz2yF0
	for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Jul 2025 19:52:21 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 22 Jul
 2025 17:51:56 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 22 Jul 2025 17:51:56 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v3 2/2] irqchip: aspeed: add debugfs support and AST2700 INTC0/INTC1 routing/protection display
Date: Tue, 22 Jul 2025 17:51:56 +0800
Message-ID: <20250722095156.1672873-3-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

AST2700 INTC0/INTC1 nodes ("aspeed,ast2700-intc0/1") not only
include the interrupt controller child node ("aspeed,ast2700-intc-ic"),
but also provide interrupt routing and register protection features.
This patch adds debugfs entries for interrupt routing and protection
status for AST2700 INTC0/INTC1.

- Register platform driver for "aspeed,ast2700-intc0" and
 "aspeed,ast2700-intc1" compatible nodes.
- Add show_routing/show_prot callbacks for both intc0 and intc1,
 displaying current interrupt routing and protection register status.
- Expose routing/protection information via debugfs for debugging
 and validation.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/irqchip/irq-aspeed-intc.c | 238 ++++++++++++++++++++++++++++++
 1 file changed, 238 insertions(+)

diff --git a/drivers/irqchip/irq-aspeed-intc.c b/drivers/irqchip/irq-aspeed-intc.c
index 8330221799a0..8385f3d5f901 100644
--- a/drivers/irqchip/irq-aspeed-intc.c
+++ b/drivers/irqchip/irq-aspeed-intc.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/debugfs.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
@@ -15,6 +16,13 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>
 
+#define INTC0_ROUTING0_SEL0	0x200
+#define INTC0_ROUTING0_SEL1	0x300
+#define INTC0_ROUTING0_SEL2	0x400
+#define INTC1_ROUTING0_SEL0	0x80
+#define INTC1_ROUTING0_SEL1	0xa0
+#define INTC1_ROUTING0_SEL2	0xc0
+
 #define INTC_INT_ENABLE_REG	0x00
 #define INTC_INT_STATUS_REG	0x04
 #define INTC_IRQS_PER_WORD	32
@@ -137,3 +145,233 @@ static int __init aspeed_intc_ic_of_init(struct device_node *node,
 }
 
 IRQCHIP_DECLARE(ast2700_intc_ic, "aspeed,ast2700-intc-ic", aspeed_intc_ic_of_init);
+
+struct aspeed_intc {
+	void __iomem *base;
+	struct device *dev;
+	struct dentry *dbg_root;
+	int (*show_routing)(struct seq_file *s, void *unused);
+	int (*show_prot)(struct seq_file *s, void *unused);
+};
+
+/*
+ * 000: Route interrupt INTn to PSP GICINT0-31
+ * 001: Route interrupt INTn to SSPINT0-31
+ * 010: Route interrupt INTn to TSPINT0-31
+ */
+static int aspeed_intc0_show_routing(struct seq_file *s, void *unused)
+{
+	struct aspeed_intc *intc = s->private;
+	int group, bit;
+
+	seq_puts(s, "int | PSP | SSP | TSP\n");
+	seq_puts(s, "----+-----+-----+----\n");
+
+	for (group = 0; group < 4; group++) {
+		u32 reg0 = readl(intc->base + INTC0_ROUTING0_SEL0 + group * 4);
+		u32 reg1 = readl(intc->base + INTC0_ROUTING0_SEL1 + group * 4);
+		u32 reg2 = readl(intc->base + INTC0_ROUTING0_SEL2 + group * 4);
+
+		for (bit = 0; bit < 32; bit++) {
+			int idx = group * 32 + bit;
+			u8 routing = (((reg2 >> bit) & 0x1) << 2) |
+				     (((reg1 >> bit) & 0x1) << 1) |
+				     (((reg0 >> bit) & 0x1) << 0);
+
+			const char *ca35 = (routing == 0) ? " O " : " - ";
+			const char *ssp  = (routing == 1) ? " O " : " - ";
+			const char *tsp  = (routing == 2) ? " O " : " - ";
+
+			seq_printf(s, "%-4d| %s | %s | %s\n", idx, ca35, ssp, tsp);
+		}
+	}
+	return 0;
+}
+
+static int aspeed_intc0_show_prot(struct seq_file *s, void *unused)
+{
+	struct aspeed_intc *intc = s->private;
+	u32 prot = readl(intc->base + 0x40);
+
+	seq_printf(s, "INTC040 : 0x%08x\n", prot);
+
+	static const char * const prot_bits[] = {
+		"hprot_ca35: Protect INTC010~018,1xxx accessed by PSP only",
+		"hprot_ssp: Protect INTC020~028,2xxx accessed by SSP only",
+		"hprot_tsp: Protect INTC030~038,3xxx accessed by TSP only",
+		"hprot_sirqs: Protect INTC0C0~0D4 to be read only",
+		"hprot_sirqs_1700: Protect INTC0D8~0DC to be read only",
+		"hprot_sirqs_ext: Protect INTC0E0 to be read only",
+		"hprot_reg_prot: Protect INTC044,2xx~3xx to be read only",
+		"hprot_rd1_prot: Read protect for INTC044,200-438",
+		"hprot_rd2_prot: Read protect for INTC0C0~164",
+		"hprot_rd3_prot: Read protect for INTC02x,1xxx to be read by PSP only",
+		"hprot_rd4_prot: Read protect for INTC03x,2xxx to be read by SSP only",
+		"hprot_rd5_prot: Read protect for INTC04x,3xxx to be read by TSP only",
+		"hprot_mcu0: Protect INTC050~054,028 accessed by MCU0 only",
+		"hprot_ca35p: Protect INTC010~018 accessed by PSP secure only"
+	};
+
+	for (int i = 0; i < 14; i++)
+		seq_printf(s, "  [%2d] %s: %s\n", i, prot_bits[i],
+			   (prot & BIT(i)) ? "Enable" : "Disable");
+	return 0;
+}
+
+/*
+ * 000: Route interrupt INTi to PSP(default)
+ * 001: Route interrupt INTi to INTC controller
+ * 010: Route interrupt INTi to SSP
+ * 011: Route interrupt INTi to TSP
+ * 100: Route interrupt INTi to PSP S1
+ * 101: Route interrupt INTi to PSP S2
+ * 110: Route interrupt INTi to MCU0
+ */
+static int aspeed_intc1_show_routing(struct seq_file *s, void *unused)
+{
+	struct aspeed_intc *intc = s->private;
+	int group, bit;
+
+	seq_puts(s, "index      | PSP | INTC| SSP | TSP | S1  | S2  | MCU0\n");
+	seq_puts(s, "-----------+-----+-----+-----+-----+-----+-----+-----\n");
+
+	for (group = 0; group < 6; group++) {
+		u32 reg0 = readl(intc->base + INTC1_ROUTING0_SEL0 + group * 4);
+		u32 reg1 = readl(intc->base + INTC1_ROUTING0_SEL1 + group * 4);
+		u32 reg2 = readl(intc->base + INTC1_ROUTING0_SEL2 + group * 4);
+
+		for (bit = 0; bit < 32; bit++) {
+			u8 routing = (((reg2 >> bit) & 0x1) << 2) |
+				     (((reg1 >> bit) & 0x1) << 1) |
+				     (((reg0 >> bit) & 0x1) << 0);
+
+			const char *psp  = (routing == 0) ? " O " : " - ";
+			const char *intc = (routing == 1) ? " O " : " - ";
+			const char *ssp  = (routing == 2) ? " O " : " - ";
+			const char *tsp  = (routing == 3) ? " O " : " - ";
+			const char *s1   = (routing == 4) ? " O " : " - ";
+			const char *s2   = (routing == 5) ? " O " : " - ";
+			const char *mcu0 = (routing == 6) ? " O " : " - ";
+
+			seq_printf(s, "intc1_%d_%02d | %s | %s | %s | %s | %s | %s | %s\n",
+				   group, bit, psp, intc, ssp, tsp, s1, s2, mcu0);
+		}
+	}
+	return 0;
+}
+
+static int aspeed_intc1_show_prot(struct seq_file *s, void *unused)
+{
+	struct aspeed_intc *intc = s->private;
+	u32 prot = readl(intc->base);
+
+	seq_printf(s, "INTC1: 0x%08x\n", prot);
+
+	static const char * const prot_bits[] = {
+		"pprot_ca35: Protect INTC100~150,280~2D0,300~350 write by PSP only",
+		"pprot_ssp: Protect INTC180~1D0 write by SSP only",
+		"pprot_tsp: Protect INTC200~250 write by TSP only",
+		"pprot_reg_prot: Protect INTC080~0D4 to be read only",
+		"pprot_regrd: Protect INTC080~0D4 to be read protected",
+		"pprot_regrd2: Protect INTC100~150,280~2D0,300~350 read by PSP only",
+		"pprot_regrd3: Protect INTC180~1D0 read by SSP only",
+		"pprot_regrd4: Protect INTC200~250 read by TSP only",
+		"pprot_mcu0: Protect INTC010,014 write by MCU0 only",
+		"pprot_regrd5: Protect INTC010,014 read by MCU0 only",
+		"pprot_treg: Protect INTC040~054 to be read protected"
+	};
+
+	for (int i = 0; i < 11; i++)
+		seq_printf(s, "  [%2d] %s: %s\n", i, prot_bits[i],
+			   (prot & BIT(i)) ? "Enable" : "Disable");
+	return 0;
+}
+
+static int aspeed_intc_open_routing(struct inode *inode, struct file *file)
+{
+	struct aspeed_intc *intc = inode->i_private;
+
+	if (!intc->show_routing)
+		return -ENODEV;
+	return single_open(file, intc->show_routing, intc);
+}
+
+static int aspeed_intc_open_prot(struct inode *inode, struct file *file)
+{
+	struct aspeed_intc *intc = inode->i_private;
+
+	if (!intc->show_prot)
+		return -ENODEV;
+	return single_open(file, intc->show_prot, intc);
+}
+
+static const struct file_operations aspeed_intc_routing_fops = {
+	.owner   = THIS_MODULE,
+	.open    = aspeed_intc_open_routing,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+
+static const struct file_operations aspeed_intc_prot_fops = {
+	.owner   = THIS_MODULE,
+	.open    = aspeed_intc_open_prot,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+
+static int aspeed_intc_probe(struct platform_device *pdev)
+{
+	struct aspeed_intc *intc;
+	struct resource *res;
+
+	intc = devm_kzalloc(&pdev->dev, sizeof(*intc), GFP_KERNEL);
+	if (!intc)
+		return -ENOMEM;
+	intc->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	intc->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(intc->base))
+		return PTR_ERR(intc->base);
+
+	if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2700-intc0")) {
+		intc->show_routing = aspeed_intc0_show_routing;
+		intc->show_prot    = aspeed_intc0_show_prot;
+	} else if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2700-intc1")) {
+		intc->show_routing = aspeed_intc1_show_routing;
+		intc->show_prot    = aspeed_intc1_show_prot;
+	} else {
+		intc->show_routing = NULL;
+		intc->show_prot = NULL;
+	}
+
+	platform_set_drvdata(pdev, intc);
+
+	intc->dbg_root = debugfs_create_dir(dev_name(&pdev->dev), NULL);
+	if (intc->dbg_root) {
+		debugfs_create_file("routing", 0400, intc->dbg_root, intc,
+				    &aspeed_intc_routing_fops);
+		debugfs_create_file("protection", 0400, intc->dbg_root, intc,
+				    &aspeed_intc_prot_fops);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id aspeed_intc_of_match[] = {
+	{ .compatible = "aspeed,ast2700-intc0", },
+	{ .compatible = "aspeed,ast2700-intc1", },
+	{},
+};
+
+static struct platform_driver aspeed_intc_driver = {
+	.probe  = aspeed_intc_probe,
+	.driver = {
+		.name = "ast2700-intc",
+		.of_match_table = aspeed_intc_of_match,
+	},
+};
+builtin_platform_driver(aspeed_intc_driver);
+
-- 
2.34.1


