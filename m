Return-Path: <linux-aspeed+bounces-4440-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3A9C43458
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jul 2026 23:21:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwYyD5GnXz2yf9;
	Thu, 09 Jul 2026 09:21:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783525125;
	cv=none; b=LlXJtpF2G/lw2qzWX/fkw9Fayh0anerGSFEEvj3oKz3a/YJPMSlK2wDnkdBs4Oeip/P89RT4Nc9HcwBSMAIbN+NAh3yDB/FbJtaoZegRrE2HHCmaHHfBZ7CleLOxfe+GFISqmrHxtJTwbD/OzL6V0RXM4Z4I/5qAPOO4CG0g4S53DbwHaFSlJiXg/Y1o0SUjUTr/+4r6+DC5mk9Coq8U6bm6kusXMCYe/wQlrBqDgtyTUGCPUA3c495lK+wpw3yAK+nNzQV52pkktgZSK6YS2M3p9Yq7d1jTE4yI5SIhG+XTnN0pvmPvRXQy6cShruADzDiUzyFy4v5IAtPb+anydg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783525125; c=relaxed/relaxed;
	bh=f1Rm+ycDLzcJTW5brmAbfPnl/20w3yUac+m/GbIIsJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQJ29N8Ww8foB5FNucLxzLataUPbgMV8dp3+Seqm/Xl1/CgRb2Vc4TpPgMXDTY9JmoyxGHX+jyPwr/RStnx5ZckGXVz4k4Ld9Ie5TQ64lSWrnaqBWG3Ob4lKa7Ts7ijfdEgzA1t+KbMyzvlFD8SuHb1WhXsIXSJHQGZxbx7GeERxKLLpf3I+R1zmxeIox6XrzCn3wbYNoRSYUGgh9zXztRoLc6+x9LUtnWGOQzxH53MhMoJKGhQqzsDXAXo0MlB7OnWKeV5yeovUrgYt3mt+6G+i7Pd9XdvMDeuJOz7soY3qAqUJQNIjqQInM6FSZ1eOFi6+tmthurJjQ6pSNTYCFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=NMLGvhnR; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::2; helo=mail-wm2-x02.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=NMLGvhnR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:31::2; helo=mail-wm2-x02.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x02.google.com (mail-wm2-x02.google.com [IPv6:2a00:1450:4864:31::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwMh41PkYz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Jul 2026 01:38:44 +1000 (AEST)
Received: by mail-wm2-x02.google.com with SMTP id 5b1f17b1804b1-493b9643ab5so1298075e9.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jul 2026 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783525121; x=1784129921; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f1Rm+ycDLzcJTW5brmAbfPnl/20w3yUac+m/GbIIsJs=;
        b=NMLGvhnRzyC2RcT6cWQOFO6XG/nxRscs0zCcXf624H/6DW4fqN2gqpj1fMvALGlm0J
         gW2zcWBqitSni16CujquPYKRVWeQDbCXy/FVw7JVsyFLqdOaXcuXfuiy/LpWfn2jsYqX
         ZnCZoE7vnvSVGQuTrzTzxh7jRrjVOUjLJFW/pcZs+U4Cr2KotWUEFYUYHpdZIIXH86Yu
         slBDb5Xob+Migk87DT6Ab7T6BlfXPHXaGfL9cnkRWhZXFr0Bsfw/0QcIRVt8EqJUJKlq
         mqQXs5kRfP0JQfMUKRnzA8wG6aaekhmgry8aLKVGU6VFGb+nmxDt90eC22YJkEVor028
         kltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525121; x=1784129921;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f1Rm+ycDLzcJTW5brmAbfPnl/20w3yUac+m/GbIIsJs=;
        b=YZZGlqeq3iQR+JEaJfxsR0/4SpzgIMo7K6Ou+MqDvKY+/9hwSF20lkPEbXTCWF4ouH
         3IA9PLU+FUw7XZGdXSs7SSm0WlqlaHKScPu64xYi7Cmky6q0LlOiHErTsB0SxK1INPOY
         SfG39X6PAA9p7oLnaHvwwMEtgcCxD04Usfict7Vx4dHrXNfa1Mk7V9AIBbaN1+oYCplS
         pSHBa/tnlC4kXgx5F9Qy3q2xJaMUHS0wrllNAdNztXLOTgSueAA3AE0D6qR/EIFbwREh
         I/kqeh1lqnFG4EY4otSx82qgFxU59uU9gVRba6dcx4QZ2nkaf7J5DR/7Q4RnN4A9QXtK
         BgMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rom5EMDY7VMivsxf9cnXLUzSDxPOsml/lwMRrarGRSJwDLn2lUJZTWUR2ieXQVFWg3Xvl7qj/p8uYNeSXg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYpbiKvXXloLXtcP4QQZ0S8/1WBFyMfG9IZpiNI9foUHNe1Epo
	N73giCBBjARFTq7tB/G+vuawQ7tF30MumaUrQ2MeU4grEXvDzRmEwH08emk57uhCiiw=
X-Gm-Gg: AfdE7ckfFaBBynORwyv8z94ELckZIRwkNSuigModDEWR2q0+jy7a4s8YtIkmon+U72B
	vYw2ufQOEsD4uf+bCGt5c5TXeaqicaarmf7uyvLXZc9hk1/LO2G+hvH3AhdC67h9QG0/2Qf1u7p
	9B++JijEXe5kn4TUF7kf1lxTpoOVn1g7To4okV2Fxs8MjZxMCLPh8Z8yHsPMKFT3lj0Rzeq4VKH
	UYv9xyRXEvR30MEIkIGGgknMnHF9DXTwV1sxChB9HWAler0rJmJtvMGjmDsMG3JyzJ9loeN02OX
	4UAYSjmE1sdO7fundjUpqnkyA9m0FybBEZUxUwsnI/OaQE32vAj3FlKdLCYsKhH8hxTzlf8RSQZ
	kKUjgKHLbCM4cH/NxuEHg3x0jItCK1pFpq/TiZB0/YTHa5pA/hlsTuauvVxOPK7D5+banxPNHOc
	vLGZPxlKHXzk1buyOTKLMQ2/ZF6yP6gPLgo0cOVuwNg2XKYJE64KVWzCCWaB0anhrKaXp/qiJ0Z
	mlT3oZTd1Xfys6hiydnpYrcCD2K
X-Received: by 2002:a05:600c:8b72:b0:493:c634:952 with SMTP id 5b1f17b1804b1-493e69b0dc8mr29860325e9.7.1783525121089;
        Wed, 08 Jul 2026 08:38:41 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44254136f8f.15.2026.07.08.08.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:38:40 -0700 (PDT)
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
Subject: [PATCH v4 5/7] soc: aspeed: add host-side PCIe BMC device driver
Date: Wed,  8 Jul 2026 15:35:57 +0000
Message-ID: <51e455417bdcfe608270c6cb2806b1fd971fb998.1783524645.git.gregoire.layet@9elements.com>
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

Add support for VUART over PCIe between BMC and host.
Add the host side driver.
Support only the AST2600.

Taken from ASPEED 6.18 Kernel SDK and trimmed down.

The host can't detect the VUART addresses, so force them to
0x3f8 and 0x2f8, as in the initial ASPEED driver.

Change the MSI vector index of VUART2 from 15 to 17.
The index 15 used in the initial driver was not working.

Data path in both direction is tested on both VUART.

This module is added in soc/aspeed as it's very soc specific.
This is not added as a PCI 8250 UART device as this host module can
be expanded upon for IPMI over KCS. It can also be used in the
future for custom BMC<->host communication with shared memory and doorbell.

This host module should be the entry point for setting up all features
related to an AST2600 present on the PCI bus.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/soc/aspeed/Kconfig               |  15 ++
 drivers/soc/aspeed/Makefile              |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c | 174 +++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index f579ee0b5afa..147a9033bdc4 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -55,3 +55,18 @@ config ASPEED_SOCINFO
 endmenu
 
 endif
+
+menu "ASPEED host-side drivers"
+	depends on PCI
+
+config ASPEED_HOST_BMC_DEV
+	tristate "ASPEED host-side BMC PCIe device"
+	depends on SERIAL_8250
+	help
+	  Host-side driver for the ASPEED AST2600 BMC PCIe device found on
+	  BMC expansion cards. Exposes two 8250-compatible VUART
+	  ports.
+
+	  If unsure, say N. Choose M to build aspeed-host-bmc-dev.
+
+endmenu
diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
index b35d74592964..c515e163eab7 100644
--- a/drivers/soc/aspeed/Makefile
+++ b/drivers/soc/aspeed/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ASPEED_HOST_BMC_DEV)	+= aspeed-host-bmc-dev.o
 obj-$(CONFIG_ASPEED_LPC_CTRL)		+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
 obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
diff --git a/drivers/soc/aspeed/aspeed-host-bmc-dev.c b/drivers/soc/aspeed/aspeed-host-bmc-dev.c
new file mode 100644
index 000000000000..e586d0505577
--- /dev/null
+++ b/drivers/soc/aspeed/aspeed-host-bmc-dev.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (C) ASPEED Technology Inc.
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+
+#define BMC_MULTI_MSI	32
+#define PCI_BMC_DEVICE_ID 0x2402
+
+#define DRIVER_NAME "aspeed-host-bmc-dev"
+
+enum aspeed_platform_id {
+	ASPEED,
+};
+
+static const int vuart_msi_index[2] = { 16, 17 };
+static const int vuart_port_addr[2] = {0x3f8, 0x2f8};
+
+struct aspeed_pci_bmc_dev {
+	unsigned long message_bar_base;
+
+	struct uart_8250_port uart[2];
+	int uart_line[2];
+};
+
+static int aspeed_pci_bmc_device_setup_vuart(struct pci_dev *pdev, int idx)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct uart_8250_port *uart = &pci_bmc_dev->uart[idx];
+	u16 vuart_ioport;
+	int ret;
+
+	/* Assign the line to non-exist device before everything is setup */
+	pci_bmc_dev->uart_line[idx] = -ENOENT;
+
+	vuart_ioport = vuart_port_addr[idx];
+	/* ASPEED BMC device shift addresses by 2 to the left */
+	vuart_ioport = vuart_ioport << 2;
+
+	uart->port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	uart->port.uartclk = 115200 * 16;
+	uart->port.irq = pci_irq_vector(pdev, vuart_msi_index[idx]);
+	uart->port.dev = dev;
+	uart->port.iotype = UPIO_MEM32;
+	uart->port.iobase = 0;
+	uart->port.mapbase = pci_bmc_dev->message_bar_base + vuart_ioport;
+	uart->port.membase = 0;
+	uart->port.type = PORT_16550A;
+	uart->port.flags |= (UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE);
+	uart->port.regshift = 2;
+
+	ret = serial8250_register_8250_port(&pci_bmc_dev->uart[idx]);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "Can't setup PCIe VUART%d\n", idx);
+		return ret;
+	}
+
+	pci_bmc_dev->uart_line[idx] = ret;
+
+	return 0;
+}
+
+static void aspeed_pci_host_bmc_device_release_vuart(struct pci_dev *pdev, int idx)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
+
+	if (pci_bmc_dev->uart_line[idx] >= 0)
+		serial8250_unregister_port(pci_bmc_dev->uart_line[idx]);
+}
+
+static int aspeed_pci_host_setup(struct pci_dev *pdev)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
+	int rc = 0;
+
+	pci_bmc_dev->message_bar_base = pci_resource_start(pdev, 1);
+
+	if (pdev->revision == 0x27) {
+		pr_err("AST2700 detected but not supported");
+		return -ENODEV;
+	}
+
+	rc = aspeed_pci_bmc_device_setup_vuart(pdev, 0);
+	if (rc)
+		return rc;
+
+	rc = aspeed_pci_bmc_device_setup_vuart(pdev, 1);
+	if (rc)
+		goto out_free_VUART0;
+
+	return 0;
+
+out_free_VUART0:
+	aspeed_pci_host_bmc_device_release_vuart(pdev, 0);
+
+	return rc;
+}
+
+static int aspeed_pci_host_bmc_device_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev;
+	int rc = 0;
+
+	pci_bmc_dev = devm_kzalloc(&pdev->dev, sizeof(*pci_bmc_dev), GFP_KERNEL);
+	if (!pci_bmc_dev)
+		return -ENOMEM;
+
+	rc = pci_enable_device(pdev);
+	if (rc) {
+		dev_err(&pdev->dev, "pci_enable_device() returned error %d\n", rc);
+		return rc;
+	}
+
+	pci_set_master(pdev);
+	pci_set_drvdata(pdev, pci_bmc_dev);
+
+	rc = pci_alloc_irq_vectors(pdev, BMC_MULTI_MSI, BMC_MULTI_MSI, PCI_IRQ_INTX | PCI_IRQ_MSI);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "aspeed_pci_setup_irq_resource() returned error %d\n", rc);
+		goto disable_device;
+	}
+
+	/* Setup BMC PCI device */
+	rc = aspeed_pci_host_setup(pdev);
+	if (rc) {
+		dev_err(&pdev->dev, "ASPEED PCIe Host device returned error %d\n", rc);
+		goto free_irq;
+	}
+
+	return 0;
+
+free_irq:
+	pci_free_irq_vectors(pdev);
+disable_device:
+	pci_disable_device(pdev);
+	return rc;
+}
+
+static void aspeed_pci_host_bmc_device_remove(struct pci_dev *pdev)
+{
+	aspeed_pci_host_bmc_device_release_vuart(pdev, 0);
+	aspeed_pci_host_bmc_device_release_vuart(pdev, 1);
+
+	pci_free_irq_vectors(pdev);
+	pci_disable_device(pdev);
+}
+
+static struct pci_device_id aspeed_host_bmc_dev_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASPEED, PCI_BMC_DEVICE_ID),
+		.class = 0xFF0000, .class_mask = 0xFFFF00,
+		.driver_data = ASPEED },
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(pci, aspeed_host_bmc_dev_pci_ids);
+
+static struct pci_driver aspeed_host_bmc_dev_driver = {
+	.name		= DRIVER_NAME,
+	.id_table	= aspeed_host_bmc_dev_pci_ids,
+	.probe		= aspeed_pci_host_bmc_device_probe,
+	.remove		= aspeed_pci_host_bmc_device_remove,
+};
+
+module_driver(aspeed_host_bmc_dev_driver, pci_register_driver, pci_unregister_driver);
+
+MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
+MODULE_DESCRIPTION("ASPEED Host BMC DEVICE Driver");
+MODULE_LICENSE("GPL");
-- 
2.54.0


