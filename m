Return-Path: <linux-aspeed+bounces-5112-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EA6CA5FDD
	for <linux-aspeed@archiver.kernel.org>; Fri,  2 Oct 2026 13:16:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx8Sg3XR3z30B9;
	Fri, 02 Oct 2026 23:16:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790947011;
	cv=none; b=Na2Pzs509hlAlDna5gP8Hu2DBCtdMo0BIwhXEGM961SXe7EdBdkf6+8IyU935AmBn+ipmvKRqhjX02t0R/5ke+BlXqHLfk3CB6YHwFd7oSve7kDf1AkQigxhyBDDhL/cnaNstMm120kdMVKfEGZqACweb0gvUDhM2T48R6oJUeVsqE39j4t/RmxOcYFnPNv7F6kbxgB1teFZkHPdqeSMM2yhVKSE7ouK19TaSY+dWbFn4S403NmIgNBR4RtTpI1DGzUnUZIlg0myIQIx5C/uIRKCyf3nXXXnF+5hGa63zhbmKWDGCzc7qb1gMHcAdaKh+eBKvx46f5V5uk/OhygUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790947011; c=relaxed/relaxed;
	bh=Nvx/6wkLcHShWXkNZT1A0xIy9aByre6GFax+04vmtXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQZEHOLrDux9jHSmIJd3rKOOorbGdMt8v/bv5+p5EPNGzYWbfPR+1In1gx892g9IVVs1ZhEb8gri5t5gU0UdgGOYicmUvsVh0zmqu28Bs+mnZtXtDMZ0lDw/jUUYgzBbMxfPGD7M+1WvMqZA+ixkuTO8bZkNgsjRnsh3FrgIiwIogp9kW/uzm5ZJ+5TOwwGTjLeGMt7XuNviHJ8kppUlkxqQ9noLeeWlz0FsnTdpFXI+zHUWPouHE6luFnafBBSlD+mzqc08Oq+iWe0r067RgIbncBSmppo6BVms8IIS/Ct7UE0+ZEiEXVSmDG4v8zHlPfZV86i38l5K2abzSHSlKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QgW1oSJL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::d; helo=mail-dy2-x0d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QgW1oSJL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::d; helo=mail-dy2-x0d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0d.google.com (mail-dy2-x0d.google.com [IPv6:2607:f8b0:4864:36::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx8Sf02tjz2xrC
	for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Oct 2026 23:16:49 +1000 (AEST)
Received: by mail-dy2-x0d.google.com with SMTP id 5a478bee46e88-34c0b552ccfso2061402eec.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Oct 2026 06:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790947006; x=1791551806; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nvx/6wkLcHShWXkNZT1A0xIy9aByre6GFax+04vmtXM=;
        b=QgW1oSJLkKEvMCF68gnADuqqF19KVd3JPHJnsKHjVKoLVwD1sBVXTJVCZZQaCNSciP
         hyexuIUmODCtWDP7ZzFrtBnBq+i5JHB2/nuSXtfkNwtpMpsnDRYN2kwSz10Y5hoktUGN
         a56k8LsGAkY+cZR3NhazrMjm1aM7fGLXOOhLkMdpLDbV192QoQy6H0q2pqPbW7QWH6Pc
         D08yZQ2qnQ+loUi5atpQuSY2qZ8UpwPDcXtq6tD9GdAV8/WWK+XOohGgovxgN+CXnNfm
         aVc1K6VHiFNp/oZCH9NeU0KhDMMlQTUOGjpbqjvl1p5Aw6Ag02u86JYLTahwrNEalHsc
         OIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790947006; x=1791551806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nvx/6wkLcHShWXkNZT1A0xIy9aByre6GFax+04vmtXM=;
        b=T3XmPDUlWWmXkQL94KwOcP7u0sTiRRYj8I3QCfjHQSuIcJTxeEQ4HMiD6ZFiW7V9mT
         UsQl7o9idKgWyxMm6osOpGLbQSKOTOMcGYJFSZ9JQUmRR/794tw1a6mPRFzhBuN/mV87
         c1TKkB4dHt1Tc8nOPBkKcZbAqVlQ8IJcZGBw2GtE6Bzmdxlf0UB9pxkBIxHRE2uM1gnX
         8zaDDaT1STEju+ZBtc3DIxhRlNLhvnnOsD4pC2xgsq65Ng34dwBk/bEuEq/r2e29eW/i
         rYUipwO6TuTRa+efI2IuwsQh/pA4HtiQ0k/qBNtA+iLQ+CLzAa2OIqf+m+3QrnTMi1iM
         u2CA==
X-Forwarded-Encrypted: i=1; AKwUvByYNfZvC+BfP5kFHcJQLQ/PfCbx5qYa6+ekZJ/pS6zFUpDSo5InWHDrO+ZPFEDpQ2oQJKEmS2F3zuo69g0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLaQ3AGYzEF72B4gvLZ07QgAU3JrFMScxMmwMTj6vdG02cGR745
	H0FKBwBRmDpyEfxYI2nJsp8XD11W09mZdqHpC2svX3sPNl8lngw48HwC
X-Gm-Gg: AYBFou1AecIpxQiKwTtFuJ6KJg9hfqlC4QH3zvKtva0ixXAaf/23t4o7EBrNK60Ct6q
	1wEgDyuVnInMoeYW/bJDPkzQR1wHnMB/VS+pYqrurMjy2A0AqAOUCMLEjtRyYmmm2trWZsb2yWA
	AZjAHm2jsnqrw/hLxDXvIvPf0AnHYvJw0qVh+ZjupVYlp0xAzkNBm/MIv35GSyu+0DIcbBhg996
	HL2/G26NpR/IfBB6KAZsSxEhOVffCI6GnLYAPXwHQQQ8ExCtW8KSK60Xml6FZhNWavagIT8z0IB
	FxRDQX74o6hvCHSMz1yiLy8e5NqYDxjZX31JRUkQwq143biouZ3iNfqENnE9BKtxqRrND3Q4TPu
	r0D1teR7zZa142K+ZKt0z2bn6y0Mr2z5puuhASO4cvJPhVXoJS4XCHfTjja+PdvwATAbnRi75zo
	vnKcZ2FaV6bmRjJYX0mzHF4gT680HHVBo6YJKe19mGfhYBu7L0T9UJpGVoIxl+ObwXPOCkNRvGN
	SEl/JlA2KLpUBs1MoigtI4vCu8=
X-Received: by 2002:a05:693c:8951:10b0:34d:2084:12d3 with SMTP id 5a478bee46e88-34f219a4e69mr2785581eec.39.1790947004214;
        Fri, 02 Oct 2026 06:16:44 -0700 (PDT)
Received: from debian.prasanth ([103.183.205.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f9f2afsm15839228eec.18.2026.10.02.06.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:16:42 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	joel@jms.id.au,
	ryan_chen@aspeedtech.com,
	tan.siewert@9elements.com,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [RFC PATCH] soc: aspeed: Add B650D4U power passthrough support
Date: Fri,  2 Oct 2026 18:46:34 +0530
Message-ID: <20261002131634.113680-1-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Add the AST2600 SCU passthrough selector support used by the
ASRock Rack B650D4U host power-control circuit. This RFC includes
the driver, Devicetree binding, and board node to discuss the final
kernel-facing interface.

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 .../asrock,b650d4u-power-passthrough.yaml     |  23 ++++
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  |   5 +
 drivers/soc/aspeed/Kconfig                    |   9 ++
 drivers/soc/aspeed/Makefile                   |   1 +
 drivers/soc/aspeed/aspeed-b650d4u-power.c     | 110 ++++++++++++++++++
 5 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4u-power-passthrough.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-b650d4u-power.c

diff --git a/Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4u-power-passthrough.yaml b/Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4u-power-passthrough.yaml
new file mode 100644
index 000000000000..e6451d17955c
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4u-power-passthrough.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/aspeed/asrock,b650d4u-power-passthrough.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASRock Rack B650D4U power passthrough
+
+maintainers:
+  - Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
+
+properties:
+  compatible:
+    const: asrock,b650d4u-power-passthrough
+
+  aspeed,scu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - aspeed,scu
+
+additionalProperties: false
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
index a4e384588a54..86291c250562 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
@@ -32,6 +32,11 @@ gfx_memory: framebuffer {
 			size = <0x01000000>;
 		};
 	};
+
+	host-power-passthrough {
+		compatible = "asrock,b650d4u-power-passthrough";
+		aspeed,scu = <&syscon>;
+	};
 };
 
 &fmc {
diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index 11e4db998c06..1b0281e0bfb0 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -58,6 +58,15 @@ config ASPEED_SBC
 	  Say yes to provide information about the secure boot controller in
 	  debugfs.
 
+config ASPEED_B650D4U_POWER
+	tristate "ASRock B650D4U host power passthrough"
+	select REGMAP
+	select MFD_SYSCON
+	default ARCH_ASPEED
+	help
+	  Enable the AST2600 GPIO passthrough selector used by the
+	  ASRock Rack B650D4U host power-control circuit. This selector routes the host power pulse through the board's passthrough logic during power sequencing.
+
 config ASPEED_XDMA
 	tristate "ASPEED XDMA Engine Driver"
 	select REGMAP
diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
index 5f61bb4cc36c..3e9618d1eafc 100644
--- a/drivers/soc/aspeed/Makefile
+++ b/drivers/soc/aspeed/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
 obj-$(CONFIG_ASPEED_P2A_CTRL)		+= aspeed-p2a-ctrl.o
 obj-$(CONFIG_ASPEED_SOCINFO)		+= aspeed-socinfo.o
 obj-$(CONFIG_ASPEED_SBC)		+= aspeed-sbc.o
+obj-$(CONFIG_ASPEED_B650D4U_POWER)	+= aspeed-b650d4u-power.o
 obj-$(CONFIG_ASPEED_XDMA)		+= aspeed-xdma.o
diff --git a/drivers/soc/aspeed/aspeed-b650d4u-power.c b/drivers/soc/aspeed/aspeed-b650d4u-power.c
new file mode 100644
index 000000000000..22a6925539dc
--- /dev/null
+++ b/drivers/soc/aspeed/aspeed-b650d4u-power.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mutex.h>
+#include <linux/kstrtox.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/bits.h>
+
+#define ASPEED_SCU_PROTECTION        0x000
+#define ASPEED_SCU_GPIO_PASSTHROUGH  0x4bc
+#define ASPEED_SCU_GPIO_ACTION       0x51c
+#define ASPEED_SCU_UNLOCK_KEY        0x1688a8a8
+#define ASPEED_B650D4U_POWER_MASK    GENMASK(27, 26)
+
+static struct regmap *b650d4u_scu;
+static DEFINE_MUTEX(b650d4u_lock);
+
+static int b650d4u_set_passthrough(bool enable)
+{
+	int ret;
+
+	mutex_lock(&b650d4u_lock);
+
+	ret = regmap_write(b650d4u_scu, ASPEED_SCU_PROTECTION,
+			   ASPEED_SCU_UNLOCK_KEY);
+	if (ret) {
+		pr_err("B650D4U: SCU unlock failed: %d\n", ret);
+		goto out;
+	}
+
+	ret = regmap_update_bits(b650d4u_scu,
+				 ASPEED_SCU_GPIO_PASSTHROUGH,
+				 ASPEED_B650D4U_POWER_MASK,
+				 enable ? ASPEED_B650D4U_POWER_MASK : 0);
+	if (ret) {
+		pr_err("B650D4U: passthrough update failed: %d\n", ret);
+		goto out;
+	}
+
+	if (!enable)
+		ret = regmap_write(b650d4u_scu,
+				   ASPEED_SCU_GPIO_ACTION, 0);
+
+out:
+	mutex_unlock(&b650d4u_lock);
+	return ret;
+}
+
+static ssize_t passthrough_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+
+	ret = b650d4u_set_passthrough(enable);
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_WO(passthrough);
+
+static int aspeed_b650d4u_power_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	b650d4u_scu = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+						      "aspeed,scu");
+	if (IS_ERR(b650d4u_scu))
+		return dev_err_probe(&pdev->dev, PTR_ERR(b650d4u_scu),
+				     "failed to get AST2600 SCU regmap\n");
+
+	ret = b650d4u_set_passthrough(true);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to enable power GPIO passthrough\n");
+
+	ret = device_create_file(&pdev->dev, &dev_attr_passthrough);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to create passthrough control\n");
+
+	dev_info(&pdev->dev, "enabled GPIO passthrough selector 1\n");
+	return 0;
+}
+
+static const struct of_device_id aspeed_b650d4u_power_of_match[] = {
+	{ .compatible = "asrock,b650d4u-power-passthrough" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aspeed_b650d4u_power_of_match);
+
+static struct platform_driver aspeed_b650d4u_power_driver = {
+	.probe = aspeed_b650d4u_power_probe,
+	.driver = {
+		.name = "aspeed-b650d4u-power",
+		.of_match_table = aspeed_b650d4u_power_of_match,
+	},
+};
+module_platform_driver(aspeed_b650d4u_power_driver);
+
+MODULE_DESCRIPTION("ASRock Rack B650D4U host power GPIO passthrough");
+MODULE_LICENSE("GPL");
-- 
2.47.3


