Return-Path: <linux-aspeed+bounces-4286-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972B1CD4F26
	for <linux-aspeed@archiver.kernel.org>; Tue, 23 Jun 2026 23:54:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glMNh05W4z2yRC;
	Wed, 24 Jun 2026 09:54:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782224994;
	cv=none; b=OJq2oRwhTsKUeViwNXwQzMHcI2yIsYhoHnOPJXneIYs/Sx/FdWyz4RxyAytXawsxeM4IJVUYfjECRdxcyXV4lmm0siNbghctKUMfvXR4fE7fVOpbjC4PuZIhp0f7v1ynOFmESsOhq9UzqolF0RzfSwgSCWVnJ2yiyMFx1cEWzoS33roy5P3QUpQ2EoXSa2EZACjkCyHcDLulQwIO2XW4cUFcwhjeKWOmG5vN0rPyuOt56Fl6ffvBO/RtgkYjsTGlGhaJMTC5LwsecevCqfkB1iFQcBwMNG/Dm6e4ZjvzNPohYnBvXgB2MPvgHQCQGV2ch/tIOFqSZiJAA5sjsUa8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782224994; c=relaxed/relaxed;
	bh=/Ys1+I3mTN4tFLUeTqimgmOWnqyRP0wdFQKXJW//HVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IK1sn9dgPDiWCD+90MP/Fiqzlxkh7SRqyLb4bO3QlpI9ag30TRe+b9J/UQffzNyI64jtSiJYNAsbXyHhV9PqTDceO5lvTGmhzWd2ZT8AgfNUULTwpaAVLg1pjujkS5P+rt6F9yx3gXDeih5PPKBcFYdnIDg/T/eP5fpClxhIGd8cHH72kS6218s6dnxsezGbWhcaGqgIF2mhgBq9Sk4MEG9UTYa72ZLev+IvqBxyecdj01/3rwAo+1pMdbddKKzLLXZDFMdSM/RVNdvsf5kPRYqooBTbfb/KluNhB+qVqP+hcyZoK6gEfR/d9noMCde16CL9Tlv/8t/+vb6gTr2Mbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=BcgttSvZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=BcgttSvZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl6sY37Mnz2xM7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Jun 2026 00:29:53 +1000 (AEST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-490b64c8311so53723705e9.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Jun 2026 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782224990; x=1782829790; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ys1+I3mTN4tFLUeTqimgmOWnqyRP0wdFQKXJW//HVk=;
        b=BcgttSvZb1r10TjyDxA7Ews4bltRfaTyPRCEUagkKCV+QWXIE4/m5nCxSnsAMb3DNc
         5cHR0iJxXPk9cAvTnpfJJ4JlgUEeqJWu5lBfGZsRM6u5k/Xf1a024bwnTWFI0eqenIun
         kr57+wz0ovH50FpmF3nV42DduUaBo5Ei6FFEOVgc/cXUxqjVR2jpxCh+Kg/VFKYErAxu
         vkgiEM+KO+BROp689fFC8K3FnZVl0UAjWVgQom4dTn47KQ+gNHHMUrgt1YN4+oP95TX0
         M2LxwRVbUP+5ENAWxXhNLjNssuC5RS3M1RyZZWXINdxdhlzRUVu+3SWyMGPkRAdMTuvT
         KpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224990; x=1782829790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Ys1+I3mTN4tFLUeTqimgmOWnqyRP0wdFQKXJW//HVk=;
        b=B5BqdiZfHt59w1RN1TWg2wFxuCmXETCUEfNx7hqWsXMrVDL30/VzEzKv3K8ykba80A
         IwyVl4ePQ6/e3i00Ar8yLK3/BGG257Zc8dYdFyr1s1BUVkEZg0h1hrUIOJTlCXDshAaJ
         XDyW/B2NOCcyAyesOxQoQ33J4ZRA0pRr42Xyoj75rDn/eZH6lGA3rsc7F+5z5bcaK596
         Cx7IVjaYXcArAVRsZ4udfj6MC9DBu4oYoWylK49V/gAgqY4U7EXEBkmbuOERrKEWFxUG
         32/yQYtp//Idm3FWDrUXdnnmI7t7WpALJva7q+MoDCwjOsa0PKGgXKqFxPCeqRpTzw3E
         oMEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8P3B4oFO6jBG3U82Z7JZobyq+9Xn0lF1JY3pxh242xlV5g5/uLTJ1ils9IH4BJeOkrkqiRF9UVkoXMHYg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwAIhchHbJyGgYN7eSF4u7rPXhDpGvNnYtp9nBuRM7lw8r0HNnu
	4f5zNBAKTsYmqu8EwWmCMA7VV118PTYwkoMOwLOLUo5U9XnK7YE3IFhAzdYxilliByU=
X-Gm-Gg: AfdE7cmxD4mH6UXKnheP5riEcEAybMm9j9bIhBzimWguBpgKAYUIpNcYXYllnaUND9A
	yUN3w+Cq0bbiN+MnzgFcmHvZ7KOLTEpNMsvCFLZJp0Yxww7WLd6pKKQTK9JkeyyQDSBBFqSmRFj
	EqR8A8OlkWCFQrZWguMafD8Q7yrRSKrR4+8k97k2/iHw1erNHo+6lhHhiIazG9O7dadsfPB7fHI
	gTxEARdiqydxdxgwq82wkydeO3ox4UmnnwlMoWJIzuNMXfYPduFEMpErJoVZH/Hbtq2k5GAlD/B
	GXFuhX9WWhlrRdUv7GiwPJPpmIHwTGFLi3BU/fzuMzoyQ3QWxQVqgTsFEPbMWyYSzWktnOAl0EG
	E+exHidoWHm43HgBm2YnNA2o4qP2zHqa3DHG0irsXhWpBkbkRhq7x1szVinGt1vM7Icm61xuxhp
	Ml3rXF8yEii8rCdOhd6qaIj4/OFhWr6z0VR3HuFjAHuQUxVWViPgsyrvSwYH3vT+QsdMy4cobnn
	c+b3tCoUV74VmIb1FvYZCWflRPw
X-Received: by 2002:a05:600c:1d1e:b0:492:4ca9:a46d with SMTP id 5b1f17b1804b1-4924ca9a4e8mr215051385e9.5.1782224990389;
        Tue, 23 Jun 2026 07:29:50 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm362507805e9.2.2026.06.23.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:29:49 -0700 (PDT)
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
Subject: [PATCH v3 4/7] serial: 8250_aspeed_vuart: add VUART over PCI
Date: Tue, 23 Jun 2026 14:25:42 +0000
Message-ID: <c3e1136d3565216c254db138e29299c2a3c6499f.1782224059.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782224059.git.gregoire.layet@9elements.com>
References: <cover.1782224059.git.gregoire.layet@9elements.com>
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

This patch enables the VUART over PCI possible for the AST2600. This is
only activated if the 'aspeed,vuart-over-pci' property flag is set on an
'ast2600-vuart' compatible node.

The AST2600 has 2 VUART that are usable over PCI. These are the VUART3
and VUART4 in the 'apseed-g6.dtsi'.

This code sets the BMC PCI device enables
bits, sets the PCI class code to MFD device and configures MSI interrupts.

There is no disable function. Removing this driver should not disable
the BMC PCI device, as other drivers could use it.
However, if all the drivers using it are removed, the
BMC PCI device will still be activated, which is not ideal. Realistically though, this is not a
use case for a BMC, the drivers will never be removed.

This is useful on PCIe BMC expansion cards that use the AST2600, such as the
ASUS Kommando IPMI Expansion Card.

Registers initialisation taken from ASPEED 6.18 Kernel SDK.
Return code checks were added to each register write.
The code has been simplified and macros have been added.

The ASPEED_SCUC24 regmap update is missing a macro for 'BIT(14)'. I was
unable to  determine the purpose of this bit. In the AST2600 A3
datasheet it is marked as 'reserved'. It is only used on the other
revision. As I only have the AST2600A3, I was unable to try this code
path.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
Tested-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 86 +++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 6afa2f4057e1..e204e26fa173 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -32,6 +32,27 @@
 #define ASPEED_VUART_DEFAULT_SIRQ	4
 #define ASPEED_VUART_DEFAULT_SIRQ_POLARITY	IRQ_TYPE_LEVEL_LOW
 
+#define ASPEED_SCU_SILICON_REVISION_ID			0x04
+#define AST2600A3_REVISION_ID				0x05030303
+
+#define ASPEED_SCUC24			0xC24
+#define  ASPEED_SCUC24_MSI_ROUTING_MASK			GENMASK(11, 10)
+#define  ASPEED_SCUC24_MSI_ROUTING_PCIe2LPC_PCIDEV1		(0x2 << 10)
+#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN		BIT(18)
+#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN			BIT(17)
+
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
@@ -412,6 +433,62 @@ static int aspeed_vuart_map_irq_polarity(u32 dt)
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
+						SCU_PCIE_CONF_BMC_DEV_EN_MMIO |
+						SCU_PCIE_CONF_BMC_DEV_EN_MSI |
+						SCU_PCIE_CONF_BMC_DEV_EN_PCIE_BUS_MASTER |
+						SCU_PCIE_CONF_BMC_DEV_EN_E2L |
+						SCU_PCIE_CONF_BMC_DEV_EN_LPC_DECODE |
+						SCU_PCIE_CONF_BMC_DEV_EN;
+
+	scu = syscon_regmap_lookup_by_phandle(dev->of_node, "clocks");
+	if (IS_ERR(scu)) {
+		dev_err(&pdev->dev, "failed to find SCU regmap\n");
+		return PTR_ERR(scu);
+	}
+
+	/* update class code to be an MFD device */
+	if (regmap_write(scu, ASPEED_SCU_BMC_DEV_CLASS, 0xff000000)) {
+		dev_err(dev, "could not set PCI class code\n");
+		return -EIO;
+	}
+
+	if (regmap_update_bits(scu, ASPEED_SCU_PCIE_CONF_CTRL,
+			   pcie_config_ctl, pcie_config_ctl)) {
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
+				   ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_MASK,
+				   ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_PCIe2LPC_PCIDEV1);
+	else
+		rc = regmap_update_bits(scu, ASPEED_SCUC24,
+					/* The bit 14 is reserved in the Datasheet, so we can't say what it does. This revision has not been tested */
+				   ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_MASK,
+				   ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_PCIe2LPC_PCIDEV1);
+	if (rc) {
+		dev_err(dev, "could not set PCI device 1 MSI interrupt routing\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+
 static int aspeed_vuart_probe(struct platform_device *pdev)
 {
 	struct of_phandle_args sirq_polarity_sense_args;
@@ -540,6 +617,15 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	aspeed_vuart_set_host_tx_discard(vuart, true);
 	platform_set_drvdata(pdev, vuart);
 
+	if (of_device_is_compatible(dev->of_node, "aspeed,ast2600-vuart") &&
+		of_property_read_bool(dev->of_node, "aspeed,vuart-over-pci")) {
+		rc = aspeed_ast2600_vuart_over_pci_set_enabled(pdev);
+		if (rc) {
+			dev_err(dev, "could not enable VUART over PCI\n");
+			return rc;
+		}
+	}
+
 	return 0;
 
 err_sysfs_remove:
-- 
2.54.0


