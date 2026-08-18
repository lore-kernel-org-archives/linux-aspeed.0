Return-Path: <linux-aspeed+bounces-4750-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5D1C5DF83
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Aug 2026 10:31:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPQx42KYqz2yCL;
	Tue, 18 Aug 2026 20:31:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787049112;
	cv=none; b=Vfe6mCg7JCm37+/RvfVQ8b1XZb/pXaE1QkJW5/RXPcaqssve2QKtaAJ99OIkjSVtYdpQSrB0i1jcLdzvxPb0hRwN6/VJHDihT7Yiq4BTGXjfjCfEavH97+5OueBoNaNhZF1Z/7a15hstNRY+Iw/gM1fg+x3Qw7ldHkysVRh2uhkxnMBIL+zdAy81iT2AVH5Kwp6SPeQ2TiDgQSbKgTaR033umFvtUgiOcLDNVDVJK+5JL3Dn2XdZ3fL2erby9usawvUaQUWfkfJ/5ZZEaWWoHv/ReFzIGA/TH5NzxfZ4VTf0yIMb9SWYYwPWGvKd/nS1qsg2/8xtGnA+0imW4crsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787049112; c=relaxed/relaxed;
	bh=qjRJ6CK8+10XxSw1IIq1k9Y5+IsaxjCnKt7BPw+fxxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXubluLXJe2vabdjvoHdTOcr4Tqa5tYQSwsC1ys483Z+FOrAqSX1fqhvxsJlWxpmJOebkx7T9oaWLgleDvlK/5J0+4Vd/HOGEAj38iLO1DTKCct6DgS8/BbQl/lH/Mnhl8Xj1iM1GpP06NiRMP241zXghM3xdWcRtYnLfaYtcJziSHv31B/+v0spkR+q9EWqQvN+YGSM9yW9BkBl72PrZakOPBXoa1K/Jb98obNRyxJlR+DCwwaEuUUcvo1rl7slywQUC/ZgG/B1me3JqfyoMCxMNQp6SaPec1SoeHvzqfMOXFgvzFfr0nC63PKv2h9DpT4RxEkuQgedBOY1p7AYag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Dgw7OioV; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Dgw7OioV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPQx26MJjz2yH5
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Aug 2026 20:31:50 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4954df200ddso31774855e9.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Aug 2026 03:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787049107; x=1787653907; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qjRJ6CK8+10XxSw1IIq1k9Y5+IsaxjCnKt7BPw+fxxg=;
        b=Dgw7OioVl5U64ObPrxJ+pmLqDZT0iI6VS6S8quI5Q/xa7/nXkyikPthUFKQ4q/sT7D
         I/FrrpHpl5yh8CY5rZPgPp6kfHObuVnrW3KEKgVGYdYpGdG7lR0iTfRDYxZ7yXQJDu9P
         nuxwF7fey+QCNkOi2bRmzonMFjB+ypZ0P7sWqbwfhOi4mHuhoOmtNp17jbxfHLjZbnS9
         MvFqGv7Hv194GC+4AthWr/rR4xuVAdDVHdU6XQD5WSaLnh4wtFp9c9nXZi6P5nc97fFH
         jS+TsJA5feG0lX8P4OTTfdjJgouU/3AO9iR3DQFtXKrf0+XwHuTBbAxELSr5OpTTM456
         WTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049107; x=1787653907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qjRJ6CK8+10XxSw1IIq1k9Y5+IsaxjCnKt7BPw+fxxg=;
        b=oepVTWq/bAhc0pfMSmDQR4HqXwdtDehF4HTiC25bs6cA2eSAeTyGJreKUoFIPo5D77
         lHhMx05op4ZBCcSJ3oD0Fjal6gP8ls45pBIKDQMe2Q1vanx8XB5IY8yXzYLi/TT+byBU
         ea/ZFhfy8Vli3cK7b4TOPxIRdRKF06JcKZ1y0vpDxh8P6FzcBFg0eRIBOZFbUvdQ60G6
         fWiPPuRg6UdOT9s9PM4LkxMeXNq9bFbyJY5/hH8gYUDxH1sEdNpCCxGvlsfBb1pZJyUa
         n1YM0R8sbXtRoKZY4saMPRKL7KOf1r+nNww/PH7zhpnzy+RAPPEVBG4Ir+sRgWhTRaQL
         NI7w==
X-Forwarded-Encrypted: i=1; AHgh+RotZv+zNeB+tiJTyiP8/VS+lMNywOTxSN37t5admZd/E1xCIyUml3Gs9pe+Ho9AoPmUbgQ17TodLSyZOxQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxq/tVzDmEWDHEMC/56zPHRBiSF3sevGzEOZv4hn5UDrAH865Vw
	i45Wt0wXf0uF7EGDFsCBgES6zO04mb8ZC+GuE1xwdqC/iT4dgbxgcxHt3Z65CBW+JZQ=
X-Gm-Gg: AR+sD12EUZ8ECJPUFnnwNFrTYQ+7T3nO6eGYNsV5TMXR5kdLKfhxDVTmMN6RUIPIKJm
	i5K5k54+GNP6+FA7ndjvZnJjfag08fA1Z8LcEfcdyqFDVfiOglGPa0C+n7JsckShc2Nne8XY8Oy
	c/Xp8O48dVvkYz7ZcqC95KkSMJdzRhlS4tzPN/JeIuGevFjj6UxGNrFVUKlFP12rfUTyCuIgxPm
	XQuxRVyOoBPdJrZX9Kt2pPDrF+0tQQhW8x+MaULJdSlQFyLsm4EnbKfAqd58ak38brF3qYtzY56
	lMll2Q+rc8PtiT5xOCvt9ecKQ32TuqNESHlQbMAfVPsKyeduhhPo2pdhM3XptCWbXMz2AVvsUiQ
	YBhK+zq+8Sxcr8B6ixJ9bxuw7rhkPoGVjp8kW54uIVW0x1wq0kFWtBR57Yl+hi9G9EgAfDOr4zE
	ef4qK8WBxsvo+3/aFyyhwZjguMMa2oKRb4AhnsJidW47jT/9c/z214wKmynZ55bmSvEJd6227pG
	oUMY+p8KOvZ13iCFWixjF9/sW5gT3rImsErDEZX8vtuz9kRRUYi/i5XyVH7
X-Received: by 2002:a05:600c:3b1d:b0:499:79b9:e226 with SMTP id 5b1f17b1804b1-49988057986mr490766875e9.0.1787049107156;
        Tue, 18 Aug 2026 03:31:47 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm246025575e9.0.2026.08.18.03.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:31:46 -0700 (PDT)
From: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 18 Aug 2026 10:29:16 +0000
Subject: [PATCH v6 3/6] serial: 8250_aspeed_vuart: add VUART over PCI
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-aspeed-driver-v6-v6-3-fd7cc0b338ea@9elements.com>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
In-Reply-To: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
X-Mailer: b4 0.15.2

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

The ASPEED_SCUC24 regmap update is use an undefined reserved register
ASPEED_SCUC24_RESERVED_14. I was unable to determine the purpose of this
bit. In the AST2600 A3 datasheet it is marked as 'reserved'. It is only
used on the other revision. As I only have the AST2600A3, I was unable
to try this code path. This BIT14 was set in the ASPEED SDK so I kept it.
I can remove it and the untested path if necessary.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
Reviewed-by: Tan Siewert <tan.siewert@9elements.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 91 +++++++++++++++++++++++++++++
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


