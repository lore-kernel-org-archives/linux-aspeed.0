Return-Path: <linux-aspeed+bounces-4622-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA248C56203
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 12:20:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFTyg1fQQz2yYf;
	Wed, 05 Aug 2026 22:20:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785932443;
	cv=none; b=amEKcyBY+TVc+WT4vGYetq+eiNQWVf7WvKVXGUF7BdQcBtexXf9eisSvRywZiJiU66AwIycyugs26zlyWmWwiEoE4VH6AD9FE/SH8dyUGjaHufFDkdhMuTAoZN7DrKYNHhGIWGYXq4x+y7BBuvcoWMYMqj541JHFR+Ng/+0xT93qHOvfU2fWKOA5paKQXZgyYukXXFB/qhI3Vm8do5CyGpDehu/q9pD6ELlPnJt/nwbyAxrQQ3gHuVWzpezvRpanbyi13Fx0to6aC+H6hLH34fWXF72gYi8XFfxsA2cpJ23EM93p6vgNJJTRL4AjZjuzTSD4IlnY81cUanLls/XNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785932443; c=relaxed/relaxed;
	bh=jiYoCygDlxrRrot+eB6RDJlTFwCO5JkkHaoDbWt1nfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgBDanaGjM1RoyhxnUL7CSAIYLM/PaVDksluR9SbaOIhVw1NUgzgWOgCIO0e0VJHf2JpWsLXlSo0FRaqLi7uymcdC7mYc2FsxFVrdLuj+oCsugprgc2NDnaBI2Nb3UOiYm8qy+7LxWkR4Jj8LiiYyCxPitCx0VnhHP1BMy8ZIADpwOQAbgN2ptxIX4CKaZY5tGz86DhabyUXqlNFaYgNh7NFiTMqYJ8MdMgHVoGFI07ZSEXOAfjIfn/0XCIp2cq71R7nLU8aNMzyr9h9t97vDIwhO93CXfp1r5k3LfYDX2P0yM5ts2hym4M8E+7qyjgYfKp/h24Sms2ZjLTQU76oug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=QziCklLx; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=QziCklLx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFTyf2Fw4z2xqM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 22:20:42 +1000 (AEST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4954d29264cso4729975e9.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785932439; x=1786537239; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jiYoCygDlxrRrot+eB6RDJlTFwCO5JkkHaoDbWt1nfs=;
        b=QziCklLxP3NdI0Ud7yI7Lm8EtYySAzbtIkUCoioDxGtg9oWQSeiFpmwwIOOb3R/K6V
         PCCZbVBjRvHm6bTuc6tEjhBY8LFAma8jB/b8wkJoqykAIUhHyrqorLWsEEVbSunKdI1r
         hYi6S6AorN2lCvE3dN64eifWt4fiYXMnqcKj22V/PZZKITwPTMNpXgrFepwhboPVFmqV
         FPkhjQtVZ93umqXl8TQ9y5RrP9c99WmPeGYJu5L3obX38BEOgMdFEkfXueIyoZ6W2+6p
         56bXjPV5iGpe2wBtaXVp/yLMkyqMm71V3gLClx3d7QKN/qZIlyLD9R/P4x8518XSDlK0
         W5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932439; x=1786537239;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jiYoCygDlxrRrot+eB6RDJlTFwCO5JkkHaoDbWt1nfs=;
        b=MNUrSimGU6VYJt4sa6t90WaxLYq9Tq92Z7i/uao8xt4t194TPncg/6O08lF8epudQ1
         MZL4eGOHe7PjfUN0S8Fidcr6nzZ1q+pqW3DOpArjJFXyqWaP68qmZDPlgtV6+k+SW5dL
         +yEBMNDjyJ27bD4hKckQ8RfXT3GzkxFaCSVcg7GqYnv+hcX8bB9HlMLcRDUj93GAFwwy
         a2w1clLMG7WkPrKCqu4jd06ooVG3KhgqsOUW0QanJOOxor8qLcpozxTP4M1qTgtaDb/R
         /+c+/0jRznC3DKW7EYgqlCwnwIc+aYFsxfmyrouacgSzWp98V2UbP/4CNkoW2nPk9w4c
         IvaA==
X-Forwarded-Encrypted: i=1; AHgh+RpWGkqsWhyP2nB7tb6i2JLCEKEFecVTmMvwi05BZKr69/f+OQabsVn46ne9umW1PdLVkN9qTLsf2h6f0JQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxalT0GCXUX8RBDX3wJq/7vRitAkGKP8EbV8vdGwDjvl4IM8yUU
	hcDaZ45lyP8C1K390qMZP4KMnWSDbteWgmjtAV0k/NYH4FiPlvUVSZfs2vcqfQLinOA=
X-Gm-Gg: AR+sD11EIRQmOQi+V493ul2pQy7QeqLgMQlSBSPh//njI2+opgg0hIQqMZe1XF+fdJU
	Kb26aAKCo1gG+RuC0iwpzsxgm1cK41BibJOjf3+EcMRxIEt8rdpAGsJM+eUz+2JmlZZwZNnOcRy
	Lj+/GC8sL27RS/IsA9PdZ1CkcsWLJzux/QoNDyfSOiMelmYnsiNhQE/to6DiG7fp00VsAah1dTz
	26xQ5tGas+kVZvvK+f6/ZVte0ufeM8RnS2e9/e/zNkrQytVDVPiIsZIwBl4Ufzcp63dZhO51O6g
	73DWH3uPA9gFoeZjSp9h7P9ySu73kjPU86WwqHyQSY9+NioTd9QIgZbC8gR6uI8vwComYmWy74q
	t/k7ess3AeNe/iIufyqAhBpZ5xLVYar4DYxGZ22qvdHyOThBrenhD0pjRvFk8Hriduphj1qhPqf
	9z2ApKhqLtFeafEzec/YIupo0wsMYDchKOp2sxYXyQXpWLNePgeZgQ2G30nyzbUP48g/lO/TWZ+
	yyAOv1GklYFOvFybn9DgzJdD7Y1MX7kq9MBWC+rL5JFW4gVrkndwQjcG3IDMFhuyVHB4/EmMInd
X-Received: by 2002:a05:600c:3b9b:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-4994e7ba85fmr75294935e9.9.1785932438769;
        Wed, 05 Aug 2026 05:20:38 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm196663515e9.0.2026.08.05.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:20:38 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	tan.siewert@9elements.com,
	linux-serial@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v5 3/6] serial: 8250_aspeed_vuart: add VUART over PCI
Date: Wed,  5 Aug 2026 14:19:50 +0200
Message-ID: <84efc6b23b79e901245e9ed7f58546bef6089530.1785932211.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable the VUART over PCI for the AST2600. Activate it only if the
'aspeed,vuart-over-pci' property flag is set on an
'ast2600-vuart' compatible node.

The AST2600 has 2 VUART that are usable over PCI. These are already
defined as the VUART3 and VUART4 in the 'aspeed-g6.dtsi'.

Sets the BMC PCI device enable bits, sets the PCI class code to
unassgined/device specific, and configures MSI interrupts.

There is no disable function. Removing this driver should not disable
the BMC PCI device, as other drivers could use it.
However, if all the drivers using it are removed, the
BMC PCI device will still be activated, which is not ideal. But in reality,
this is not a use case for a BMC, the drivers will never be removed.

This is useful on PCIe BMC expansion cards that use the AST2600,
such as the ASUS Kommando IPMI Expansion Card.

Register initialisation taken from ASPEED 6.18 Kernel SDK.
Add return code checks to each register write.
Simplify the code and add macros.

The ASPEED_SCUC24 regmap update is missing a macro for 'BIT(14)'. I was
unable to determine the purpose of this bit. In the AST2600 A3
datasheet it is marked as 'reserved'. It is only used on the other
revision. As I only have the AST2600A3, I was unable to try this code
path. This BIT14 was set in the ASPEED SDK so I kept it.
I can remove it and the untested path if necessary.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
Change from v4 to v5:
- Change bit 14 to RESERVED macro
- Changed ordering of macros
- use FIELD_PREP macro
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 91 +++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 6afa2f4057e1..2360d37139bf 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -32,6 +32,28 @@
 #define ASPEED_VUART_DEFAULT_SIRQ	4
 #define ASPEED_VUART_DEFAULT_SIRQ_POLARITY	IRQ_TYPE_LEVEL_LOW
 
+#define ASPEED_SCU_SILICON_REVISION_ID			0x04
+#define AST2600A3_REVISION_ID				0x05030303
+
+#define ASPEED_SCU_PCIE_CONF_CTRL 0xC20
+#define  SCU_PCIE_CONF_BMC_DEV_EN					BIT(8)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_MMIO				BIT(9)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_MSI				BIT(11)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_IRQ				BIT(13)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_PCIE_BUS_MASTER	BIT(14)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_E2L				BIT(15)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_LPC_DECODE		BIT(21)
+
+#define ASPEED_SCUC24 0xC24
+#define  ASPEED_SCUC24_MSI_ROUTING_MASK				GENMASK(11, 10)
+#define  ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1 \
+		FIELD_PREP(ASPEED_SCUC24_MSI_ROUTING_MASK, 2)
+#define  ASPEED_SCUC24_RESERVED_14					BIT(14)
+#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN	BIT(17)
+#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN	BIT(18)
+
+#define ASPEED_SCU_BMC_DEV_CLASS	0xC68
+
 struct aspeed_vuart {
 	struct device		*dev;
 	int			line;
@@ -412,6 +434,66 @@ static int aspeed_vuart_map_irq_polarity(u32 dt)
 	}
 }
 
+static int aspeed_ast2600_vuart_over_pci_set_enabled(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	u32 silicon_revision_id;
+	struct regmap *scu;
+	int rc;
+
+	u32 pcie_config_ctl = SCU_PCIE_CONF_BMC_DEV_EN_IRQ |
+				SCU_PCIE_CONF_BMC_DEV_EN_MMIO |
+				SCU_PCIE_CONF_BMC_DEV_EN_MSI |
+				SCU_PCIE_CONF_BMC_DEV_EN_PCIE_BUS_MASTER |
+				SCU_PCIE_CONF_BMC_DEV_EN_E2L |
+				SCU_PCIE_CONF_BMC_DEV_EN_LPC_DECODE |
+				SCU_PCIE_CONF_BMC_DEV_EN;
+
+	scu = syscon_regmap_lookup_by_phandle(dev->of_node, "aspeed,scu-syscon");
+	if (IS_ERR(scu)) {
+		dev_err(dev, "failed to find SCU regmap\n");
+		return PTR_ERR(scu);
+	}
+
+	/* update class code to be an Unassigned/device specific class device */
+	if (regmap_write(scu, ASPEED_SCU_BMC_DEV_CLASS, 0xff000000)) {
+		dev_err(dev, "could not set PCIe class code\n");
+		return -EIO;
+	}
+
+	if (regmap_update_bits(scu, ASPEED_SCU_PCIE_CONF_CTRL,
+			       pcie_config_ctl, pcie_config_ctl)) {
+		dev_err(dev, "could not set PCIe configuration\n");
+		return -EIO;
+	}
+
+	if (regmap_read(scu, ASPEED_SCU_SILICON_REVISION_ID, &silicon_revision_id)) {
+		dev_err(dev, "could not read silicon revision\n");
+		return -EIO;
+	}
+
+	if (silicon_revision_id == AST2600A3_REVISION_ID)
+		rc = regmap_update_bits(scu, ASPEED_SCUC24,
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN |
+					ASPEED_SCUC24_MSI_ROUTING_MASK,
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN |
+					ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
+	else
+		rc = regmap_update_bits(scu, ASPEED_SCUC24,
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN |
+					ASPEED_SCUC24_RESERVED_14 |
+					ASPEED_SCUC24_MSI_ROUTING_MASK,
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN |
+					ASPEED_SCUC24_RESERVED_14 |
+					ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
+	if (rc) {
+		dev_err(dev, "could not set PCI device 1 MSI interrupt routing\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int aspeed_vuart_probe(struct platform_device *pdev)
 {
 	struct of_phandle_args sirq_polarity_sense_args;
@@ -540,6 +622,15 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	aspeed_vuart_set_host_tx_discard(vuart, true);
 	platform_set_drvdata(pdev, vuart);
 
+	if (of_device_is_compatible(dev->of_node, "aspeed,ast2600-vuart") &&
+	    of_property_read_bool(dev->of_node, "aspeed,vuart-over-pci")) {
+		rc = aspeed_ast2600_vuart_over_pci_set_enabled(pdev);
+		if (rc < 0) {
+			dev_err_probe(dev, rc, "could not enable VUART over PCI\n");
+			goto err_sysfs_remove;
+		}
+	}
+
 	return 0;
 
 err_sysfs_remove:
-- 
2.54.0


