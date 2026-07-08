Return-Path: <linux-aspeed+bounces-4437-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2609AC43458
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jul 2026 23:20:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwYx24gTGz2yf9;
	Thu, 09 Jul 2026 09:20:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783525122;
	cv=none; b=cdV3PuZyUt3LrsM6fO0TF6RtRwM3bpSudn2j+BFsXyHTmegLrYAff/dysNis6iPrCUDnRkV3R4x/ZAx+tsbuBFJTmiHhAydkwOzjEmOQlhpCPZUDhiUIAHu+VSgzppTWOJzCbAnvKzMfaX3eivP4n7Ts7T7rzJkMjWbOs2RprTvl1FvUgs+1h066ePjiEb16bG2jf9dVJvn4bhBo0k57wX3HQGs01SEaVbawVlDJR7FsxAaQo5e5JLycBW3GXlZaPc9t+vzJEFQiHhTS5Dg8bOdJ3PNA6sybcXmnLq7KtEeZjvuvIyAR2rXH6A7t8RwrhnnT1WeGuI74GbU4UAUBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783525122; c=relaxed/relaxed;
	bh=uZx0CqGWbyzDUzo0/NyEFqDoVb8LDJ7NHysAd8cbbL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uq+sIKMY3p83vo4YesgsGU2QLcgkVa2lnJN3fNKHWoPbuPwBomiel63yPYdr/S+BMSGuKXZ6QjUYu/dNI6rdeMEG9y6fllWilFf8PlcNIGJuGem+beH4El18bB1XD48kicMqnzDH0S8eBQEEnkTx97Ofw7CctNzPGTMYwAdCeUjzVzMlvkkb19pSCcVznR9fs+P7a4RPMAWd0KSgoXJEzM67ldpQPkYUExlNVWlN2Mwd2m4j2ENzeOxhKnn5FjhQXD/0eqU/nQ+JM17l5fMXlqAkIGm6v5O9EMTQT8AMl+9xxHdrmq8MF2sM3/Zuzpn1dee9AvbjhEs1wYVObhpP8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=KlhwprSz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=KlhwprSz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwMh12J5Rz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Jul 2026 01:38:41 +1000 (AEST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso791899f8f.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jul 2026 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783525118; x=1784129918; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uZx0CqGWbyzDUzo0/NyEFqDoVb8LDJ7NHysAd8cbbL8=;
        b=KlhwprSzu8cjNliRzPzB3Bi2/yrd/89cxD1BlYHbCPMja3jYCoMCe8u2DnajSK/sS2
         qTtkYQ9q+HagIQBcPBRoV936jFsiBWXsulx265ckSEnIcOoyeMKgVrnGOyA8R+WuXPTV
         WjqpcU3Lc6c8af8jiDz+0SL6JMBcG7ODELDzdHl41g45lOmQujOe9gLRojytLq3ZdisS
         bs6YtgvMue0KO7tXvfsc5hAhfdzPCxERFihX12/IEODPkzb4CSuQnlf5ZYnW9yxj7AKs
         Ice8KiwQIXzO0u6W2Fw+hqearoVOPO5JXGK8hTYGV29MVuovqKaGFT1MiXuL8pfosUE5
         ZKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525118; x=1784129918;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uZx0CqGWbyzDUzo0/NyEFqDoVb8LDJ7NHysAd8cbbL8=;
        b=fVWagNUbrVC4PH8l/spfQnzeVAZ/9ePAcXytBEp82NZb7ZVMQCzNIIeawNnnH0As+Z
         HFTMkmX79eyLu8UpV1aN3UKXBY79H9y7CjhjXTvdnU/HCx/y3zAEEpyZqG2eEZqSwX7C
         1f1DOCjBuoMrinMo0wJ5ThtZsoMOQQsKyOaHodqHtyZnp34LSrIQLKzniwKH3Q8Nnhc1
         r9iajrOEECydMA0509lS9zrh9uyAwWB5JHeSWe0S2fJ7mWxdRYLvjoqWdRnrFr8IbdcX
         vxyJ0mx8Mp1Iwc5HwWslJ9eNQFh0aG9wr7ApmhWmUdU7SW7tEfSM+7jufQzhY5qh+KO5
         rVGA==
X-Forwarded-Encrypted: i=1; AHgh+RpqphzoDjcMu91Id5o5o8UE/10R21r45PA/qHDX1BjPfntHgP6s4hkRnyZN7vcpQPcHGLqGSZkw2lKLgJw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwgVcLfNWTN2cHeOocLoOJtSluuVqW3cJbngCvdotFFO/XPLnza
	O2Hou17FvaheLz50mEFDk9dgbs3fv5zawqOmkHPF9UFVS7cPX9DW59LAeBnE9nvqsEk=
X-Gm-Gg: AfdE7ck3MjLq6rTxoCdbx/mRenn8WEBFhdaWrZM0mz/aEC1TTJ68nUrwr4jr7lZTmGI
	A9HN0TrT9xlM/GMscp7kU2tdlO+SwSp4be2eI3csAm5555NeibpadnxIAQcKVOvkrh2Zk+rhLJ8
	N/RZOxzL1+/uqx9E8wbk62b74nEhgAGqbJPvQtKTcZd2TzXBAZ+xYNyA8mg4xgM2LxUNdyKYH7E
	UxgqkElpPD4cSh4ErLCqavgujeUUOGfxduwNKsQg09wW5AYXgnpTP5ntThhwSLv1BIGcU0k0IhM
	WuyPn7Qogj+tFs1S5EUnG9ROe+zs7ACn8IdYOs+PC9hyCDlGVhvDtEfcpGKaIMCNmit7Ucr3RSu
	jGil1mlYKfM8VvADetDr465+O7p/xsYodF0s4C7KbsgfZ1Q2OSlR2apzdvCZVUS8t4Ye2YSaMPu
	IVXOZu7uS3IQaaeqnLUn8HAjXofUULLY791i4GKfHvv+5OWAL0vhVLeOhZXFxgEg8YZvvZFqxMH
	kbESwX7T4PSxXH27U47GEp6rvcyT+GhWN8K4vc=
X-Received: by 2002:a5d:5846:0:b0:472:edc7:b4c9 with SMTP id ffacd0b85a97d-47df07896demr3174799f8f.38.1783525118187;
        Wed, 08 Jul 2026 08:38:38 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44254136f8f.15.2026.07.08.08.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:38:37 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v4 4/7] serial: 8250_aspeed_vuart: add VUART over PCI
Date: Wed,  8 Jul 2026 15:35:56 +0000
Message-ID: <28c6e7c493559feffc7e6231b0a2f0b73b7fda41.1783524645.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783524645.git.gregoire.layet@9elements.com>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
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

The AST2600 has 2 VUART that are usable over PCI. These are already defined as
the VUART3 and VUART4 in the 'aspeed-g6.dtsi'.

Sets the BMC PCI device enable bits, sets the PCI class code to
unassgined/device specific, and configures MSI interrupts.

There is no disable function. Removing this driver should not disable
the BMC PCI device, as other drivers could use it.
However, if all the drivers using it are removed, the
BMC PCI device will still be activated, which is not ideal. But in reality,
this is not a use case for a BMC, the drivers will never be removed.

This is useful on PCIe BMC expansion cards that use the AST2600, such as the
ASUS Kommando IPMI Expansion Card.

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
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 86 +++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 6afa2f4057e1..4d09c04cb972 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -32,6 +32,26 @@
 #define ASPEED_VUART_DEFAULT_SIRQ	4
 #define ASPEED_VUART_DEFAULT_SIRQ_POLARITY	IRQ_TYPE_LEVEL_LOW
 
+#define ASPEED_SCU_SILICON_REVISION_ID			0x04
+#define AST2600A3_REVISION_ID				0x05030303
+
+#define ASPEED_SCUC24			0xC24
+#define  ASPEED_SCUC24_MSI_ROUTING_MASK			GENMASK(11, 10)
+#define  ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1		(0x2 << 10)
+#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN		BIT(18)
+#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN			BIT(17)
+
+#define ASPEED_SCU_PCIE_CONF_CTRL	0xC20
+#define  SCU_PCIE_CONF_BMC_DEV_EN					BIT(8)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_MMIO				BIT(9)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_MSI				BIT(11)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_IRQ				BIT(13)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_PCIE_BUS_MASTER	BIT(14)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_E2L				BIT(15)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_LPC_DECODE		BIT(21)
+
+#define ASPEED_SCU_BMC_DEV_CLASS	0xC68
+
 struct aspeed_vuart {
 	struct device		*dev;
 	int			line;
@@ -412,6 +432,63 @@ static int aspeed_vuart_map_irq_polarity(u32 dt)
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
+	scu = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
+	if (IS_ERR(scu)) {
+		dev_err(&pdev->dev, "failed to find SCU regmap\n");
+		return PTR_ERR(scu);
+	}
+
+	/* update class code to be an Unassigned/device specific class device */
+	if (regmap_write(scu, ASPEED_SCU_BMC_DEV_CLASS, 0xff000000)) {
+		dev_err(dev, "could not set PCI class code\n");
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
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_MASK,
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
+	else
+		rc = regmap_update_bits(scu, ASPEED_SCUC24,
+					/**
+					 * The bit 14 is reserved in the Datasheet.
+					 */
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_MASK,
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
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
@@ -540,6 +617,15 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
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


