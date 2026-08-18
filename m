Return-Path: <linux-aspeed+bounces-4751-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80258C5DF81
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Aug 2026 10:31:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPQx550Jqz2yH5;
	Tue, 18 Aug 2026 20:31:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787049113;
	cv=none; b=VAblJ7HYKIb+xHT3ob2sg9D0glG7RuO9XDaNT2kksYc+mVVGUULz/9dBQx6Ch8qb9nVHYwOWpS+8wVjYdqt3ucY22cW53ucNARNfazeQqRH8GD/Afkn27dviiPt6LBk56/xC0A0Op214DH0gMywNtLZbcit8vPmjciAbxVMhuMGO4/4veqkrD+84dbM3NXWDA+RKwlvRWQyNvzmNJJEmrnqtlABOTC/QKJFOWraCx4kTxpN6R0HWcjrwadR2bApR9eN/8VBTDxiZ8Oh23uq8qbUKs6+W/j4ghEbeSC55gIcAMEf/qu5/1kifpb5t5u+0rwp2zIUc5T9RDwk1EJwRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787049113; c=relaxed/relaxed;
	bh=KU+bDqYU/O9Dr1Oo3XPL7kKeSTUBEiouuUJWuvT/yEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eRfvERvxmsibXR+xW5nJD4va3EOV2FfTjV+gxTghQQyvb9FUDQ0JhMExdKDnePNvo9TPhFI5PKKdVMKcwbSK1E4D9Q0bzS2FFphANxhuvMa2/bYi2zDntfM6aaHHwTwn00ERDXmV8wbnUvSTiIdo+tnFhEld/ZrNmXjCG4h1ePsAxdLt/LfIXfAqeEa9kMz2KSMe+IwmEeB/95hp0LbzU8Ue4W/ucAM1sDxhZ+4WcrYAVoeafS4f61hLmgwU6q/2Gs6kZG0LivVDhIrC8ws/EjE7P2ELdoxu+w63VFVugGtlyMD0oZUnVU5POlXBG6xHL8pCV8QAGes52Ys1r2mCig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=VKtu3vRQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=VKtu3vRQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPQx44VHxz2yFW
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Aug 2026 20:31:52 +1000 (AEST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-49802c418b5so48113775e9.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Aug 2026 03:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787049109; x=1787653909; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KU+bDqYU/O9Dr1Oo3XPL7kKeSTUBEiouuUJWuvT/yEQ=;
        b=VKtu3vRQcrxUmt4ntcwavpELXtnlWEokjt6i7lQJn7J1O17HjUQpm+EqU6Tnv03ZUM
         TRCE4e24dZwCI8aP/84pGG+TUr4v9pIm32a10rz6jWo+vu5S/5rV3/KLPRPteNLwExqi
         1+briar+swxSE2GOYr4aQRgww/XXjx51umohZ0Und07EAWjshUYi0MbX6BXiuefCxvgw
         N0Nm417hwkhxpzPXv4VANs96+jhA8SUNrHAiBBHMmEN4tt8UTYsQAXnBQYV9TIuWBH+d
         Onxg4xwwmZSUEefL3E//El8Hpy3iydQZRAl7gW7eJfMzKjFo7Z6YrH59BajaRgK9RmgH
         TAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049109; x=1787653909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KU+bDqYU/O9Dr1Oo3XPL7kKeSTUBEiouuUJWuvT/yEQ=;
        b=BJBFAGN0v2IiVYnJ4GEcGP4Puu5nziqkbIPBwtHUXnYNC4Sep2k4qLftls54NUOE7d
         /CgXoBRGns72eizoeIh8IbJIsvv7Zv3CXgmxMQ3CSRweTl1P1RtXeNHeootVraYs0kk1
         kgmlB5irNQZVT5H6oodr0hmoMm/edUUalgHb7ne5qLyOA51IJswqdQTDepqlZYPDO2Wl
         iJsBz3OffcjqziDh2LwjJ400ayeeY+FgR3aCMdiTGD6Td0fZBDtUItLN7+6TGaouv3ND
         0wACOKqtl/v8K5Lg51aW6CDHr83hpWfI6ZQD2g49gDyl0QKOIWStNyxgtvkKMAy+z9cp
         ejYw==
X-Forwarded-Encrypted: i=1; AHgh+RrvLrAk5alfPIJGv7gSPYrn8f+uVad4oLUCpWDNxqqVWcOSrYmFXoC0+A/NdJpVZuqb/8aTCkVQqtUka2w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzHp9sD+iRRmp+8h0yjOFye/0Z4Ft8xx03UoGUpgNUy6QMysnsa
	yDas5SSSnd8vAY0aid/hC+OngFXxeZ2UXshKjrDpMRNUmGPtdCMgzbkv8cZjumQRQ20=
X-Gm-Gg: AR+sD11tlBuohxxeQhKobeEFashU4c/g1DWj+eWZ2ERyA2R3hW6L/4SMr/Xn7C6Bbtd
	H/wqqlMhN3NLT3pnLbCQZ51uUDcP4xoWK+l8I66DbUfvPbxFoz98tX1DJumiJu5rKoLKjlX4Jtx
	hGJ6W5mX0SD4F4xg38efYPpUu2i1loU74dsjnZfnVOtB9RGaimiyo924rN/KEyecqm3M8Ej2ipM
	0TfosYDzUC3xafQz15fbB+ibNBKbs1BV1UuoG0YDpQaxqcVJJjKvQto+HEVs/pRripOgy/Zj4Eu
	5ZrTXsoFCD7ILnciVMzM8XF6isJLTxqtEpiGKy1Ra9glVOiqR1gqc7gSAqXkvoY2l5LZi7MzfUx
	o+n83pFBc/Zh1WLC27pYe9x+/gyJ+j1YnvgMC0J5sFr5Q3M3/FBWnHW4IkhR9bvtIqNpSL47Lxp
	P2ejOd9MWPdMZCfVYxZilZgUzbwB468i3LRryBkecZ6OU6I8U0BMz4aRWm7Xb44F38eypRmKUZV
	rv6KJ9fVHyq3BfifU8K41elwrAJQqeFUYzF+kwO7Yjd/dqXiarVHpH5Wu0d
X-Received: by 2002:a05:600c:3b8f:b0:495:4491:b8c2 with SMTP id 5b1f17b1804b1-499906ce446mr411847085e9.3.1787049109066;
        Tue, 18 Aug 2026 03:31:49 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm246025575e9.0.2026.08.18.03.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:31:48 -0700 (PDT)
From: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 18 Aug 2026 10:29:17 +0000
Subject: [PATCH v6 4/6] mfd: aspeed-pci-core: add AST2600 PCIe BMC device
 driver
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
Message-Id: <20260818-aspeed-driver-v6-v6-4-fd7cc0b338ea@9elements.com>
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

Add support for UART over PCIe between ASPEED AST2600 BMC and
host. This is the host-side driver.

Based on ASPEED 6.18 Kernel SDK and trimmed down and changed to
MFD driver.

The AST2600 has two 8250-compatible register set usable over PCIe.
These act as two UARTs. As there is only a FIFO internally between both
ends, they are called Virtual UARTs. This patch adds both VUARTs as
plat_serial8250_port. This is the core driver in charge of setting up
MSI interrupts. It doesn't bind the whole PCIe resource to allow each
sub-driver to bind the needed addresses.

This is not added as a PCI 8250 UART device, but as a MFD driver, as this
host driver can be expanded upon for IPMI over KCS. It can also be used
in the future for custom BMC<->host communication with shared memory and
doorbell.

This host module should be the entry point for setting up all features
related to an AST2600 present on the PCI bus.

Notes on the implementation:
The host can't detect the VUART addresses, so they are forced to
0x3f8 and 0x2f8, as in the initial ASPEED driver.

The MSI vector index of VUART2 has been changed from 15 to 17.
The index 15 used in the initial driver was not working.

Tested:
Data path in both direction is tested on both VUARTs.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 MAINTAINERS                   |   6 +++
 drivers/mfd/Kconfig           |  12 +++++
 drivers/mfd/Makefile          |   2 +
 drivers/mfd/aspeed-pci-core.c | 115 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 135 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 562754f2d166..7ea6c7d4703e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4011,6 +4011,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/aspeed,*
 F:	drivers/crypto/aspeed/
 
+ASPEED PCI BMC DEVICE DRIVER
+M:	Grégoire Layet <git@gregoirelayet.com>
+M:	Tan Siewert <tan.siewert@9elements.com>
+S:	Maintained
+F:	drivers/mfd/aspeed-pci-core.c
+
 ASPEED PECI CONTROLLER
 M:	Iwona Winiarska <iwona.winiarska@intel.com>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 763ce6a34782..dd780f72d169 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2573,5 +2573,17 @@ config MFD_MAX7360
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_ASPEED_PCI_BMC_DEVICE
+	tristate "ASPEED BMC PCIe device"
+	depends on PCI
+	select MFD_CORE
+	help
+	  Host-side driver for the ASPEED AST2600 BMC PCIe device found on
+	  BMC expansion cards. Exposes two 8250-compatible VUART
+	  ports.
+
+	  If unsure, say N. Choose M here if this machine has an
+	  AST2600-based BMC expansion card on its PCIe bus.
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index dd4bb7e77c33..a364b1b5936b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -303,3 +303,5 @@ obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
 obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
 
 obj-$(CONFIG_MFD_LOONGSON_SE)	+= loongson-se.o
+
+obj-$(CONFIG_MFD_ASPEED_PCI_BMC_DEVICE)	+= aspeed-pci-core.o
diff --git a/drivers/mfd/aspeed-pci-core.c b/drivers/mfd/aspeed-pci-core.c
new file mode 100644
index 000000000000..2f299955bc1b
--- /dev/null
+++ b/drivers/mfd/aspeed-pci-core.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (C) ASPEED Technology Inc.
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/serial_8250.h>
+#include <linux/mfd/core.h>
+
+#define ASPEED_BMC_MULTI_MSI		32
+#define ASPEED_BMC_PCI_DEVICE_ID	0x2402
+#define ASPEED_BMC_REVISION_AST2700	0x27
+#define ASPEED_BMC_NR_VUART		2
+
+#define DRIVER_NAME "ast2600-pci-core"
+
+static const unsigned int vuart_msi_index[ASPEED_BMC_NR_VUART] = { 16, 17 };
+static const u16 vuart_port_addr[ASPEED_BMC_NR_VUART] = { 0x3f8, 0x2f8 };
+
+static struct plat_serial8250_port aspeed_uart_port[ASPEED_BMC_NR_VUART + 1] = {
+	{
+		.uartclk = 115200 * 16,
+		.iotype = UPIO_MEM32,
+		.type = PORT_16550A,
+		.flags = (UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE),
+		.regshift = 2
+	},
+	{
+		.uartclk = 115200 * 16,
+		.iotype = UPIO_MEM32,
+		.type = PORT_16550A,
+		.flags = (UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE),
+		.regshift = 2
+	},
+	{ 0 }
+};
+
+static const struct mfd_cell aspeed_bmc_cell = {
+	.name		= "serial8250",
+	.platform_data	= aspeed_uart_port,
+	.pdata_size	= sizeof(aspeed_uart_port),
+};
+
+static int aspeed_pci_bmc_device_setup_vuart(struct pci_dev *pdev)
+{
+	resource_size_t bar = pci_resource_start(pdev, 1);
+	unsigned int i;
+
+	for (i = 0; i < ASPEED_BMC_NR_VUART; i++) {
+		aspeed_uart_port[i].mapbase = bar + (vuart_port_addr[i] << 2);
+		aspeed_uart_port[i].irq = pci_irq_vector(pdev, vuart_msi_index[i]);
+	}
+
+	return 0;
+}
+
+static void aspeed_bmc_pci_free_irqs(void *pdev)
+{
+	pci_free_irq_vectors(pdev);
+}
+
+static int aspeed_pci_host_bmc_device_probe(struct pci_dev *pdev,
+					    const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	int rc = 0;
+
+	if (pdev->revision == ASPEED_BMC_REVISION_AST2700)
+		return dev_err_probe(dev, -ENODEV, "AST2700 detected but not supported\n");
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return dev_err_probe(dev, rc, "failed to enable device\n");
+
+	pci_set_master(pdev);
+
+	rc = pci_alloc_irq_vectors(pdev, ASPEED_BMC_MULTI_MSI, ASPEED_BMC_MULTI_MSI, PCI_IRQ_MSI);
+	if (rc < 0)
+		return dev_err_probe(dev, rc, "failed to allocate %d MSI vectors\n",
+				     ASPEED_BMC_MULTI_MSI);
+
+	rc = devm_add_action_or_reset(dev, aspeed_bmc_pci_free_irqs, pdev);
+	if (rc)
+		return rc;
+
+	aspeed_pci_bmc_device_setup_vuart(pdev);
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
+				    &aspeed_bmc_cell, 1, &pdev->resource[1],
+				    0, NULL);
+}
+
+static struct pci_device_id aspeed_bmc_dev_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASPEED, ASPEED_BMC_PCI_DEVICE_ID),
+		.class = PCI_CLASS_OTHERS << 16,
+		.class_mask = 0xFFFF00
+	},
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(pci, aspeed_bmc_dev_pci_ids);
+
+static struct pci_driver aspeed_host_bmc_dev_driver = {
+	.name		= DRIVER_NAME,
+	.id_table	= aspeed_bmc_dev_pci_ids,
+	.probe		= aspeed_pci_host_bmc_device_probe,
+};
+
+module_pci_driver(aspeed_host_bmc_dev_driver);
+
+MODULE_AUTHOR("Grégoire Layet <gregoire.layet@9elements.com>");
+MODULE_DESCRIPTION("Host-side driver for the ASPEED BMC PCIe device");
+MODULE_LICENSE("GPL");

-- 
2.54.0


