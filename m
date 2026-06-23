Return-Path: <linux-aspeed+bounces-4285-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C7FCDB479
	for <linux-aspeed@archiver.kernel.org>; Tue, 23 Jun 2026 23:54:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glMNc4VnBz2yYK;
	Wed, 24 Jun 2026 09:54:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::343"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782224999;
	cv=none; b=DddnDRfw++bUZbwnhGcVxCVnqgXI+pLba1WpmZjYc+P33FpQ0jDHXYeRxHP7YjCCRlz9Py6cwydgaBaEa1jWL4msn+bgLyd2I7cKqo6g5mGsYTjnEHZakbdi0JyHH7SdtQiU9VlBWf6jf6yW/FHa5IkLeZdJYEJiwzy2emlxipYCH4+v6ET3gPYNHzD5fyCDFHYI7Ds3badI4WU/5q6awJFgcA+ebZuaJaDccUOaaKGKLNvxZkXXQRuLw0NBX/JiNFIlrN6v7VxXmxh1iUO1kAMeIolWoqZWoxcHLsL97oxOYZgQ02sj49VNTnC/DmYeV1b3ZwW1nD1PzfFEicyqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782224999; c=relaxed/relaxed;
	bh=FzFl26ddi0jEQXsVe9q4+m4rXNgAUesMeoLcq3/Soy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Au3bygYBl2axepi0gxdRQ3e8pvAh3bWniaDxNo2tF8GwRMpSOclduGM1X93UyG1zYjeRPKFMUTCsSTxUeK0JHSjvRa4wMKFEGNt6u7Gw1IME14Z0fzRItZqSXKmjtyU2DOSGpUpLvkUCj4Idk1/Z3lbQHq/UoWC0e/6uN0D48pcNGHmk73shazGJUuQ2gL3g9OJJhlaFRYqeE9Od9GFDsNJeCLV/B4+RlPnHbzE4GLlj6SvZXa6rl8V+s8AYecOVltGYrgbcBTRi8RKqz5PZS9w1WOeTbpJscla8oYcuA27JUMmBQrFvakXzEr5cByuIm6Jmb5W8F8u536Zdh0I4JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Ouy+bIeg; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Ouy+bIeg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl6sf3rGjz2xM7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Jun 2026 00:29:58 +1000 (AEST)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso58905365e9.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Jun 2026 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782224995; x=1782829795; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzFl26ddi0jEQXsVe9q4+m4rXNgAUesMeoLcq3/Soy8=;
        b=Ouy+bIeguK8+rN5VGttJO/6ac8/FkV+sG11ZD5GhYPd+ta6oBjbeXq6iUYjsoOm+kX
         wNBVERsW+J+a1xxz3k5A9aKByzhBWkaNZxdZGKOeVmDPR/UQxyj4PspuKUx309yREARj
         Vk7tjMdqfsxMXXHoliQzz7gRuEW0H1nzNxPthZmGSKokuFeppmfU7lSmOraj4GzXx8mv
         rxytZEzT/Tc2sLPUPcFxvZTUBsvhaq0nY0kaFOhRrz0VIbvLvhvOIj5yOc6mFtgQyjYc
         BmG0hoEHTz7pyUS4dfX9CFXszin7VbFisNO/M3kA+WizzKMlSD2wqpxBPO0//xugj7/i
         3gUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224995; x=1782829795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FzFl26ddi0jEQXsVe9q4+m4rXNgAUesMeoLcq3/Soy8=;
        b=HQ7Hju9BEFQWeAlJQgHOkAk5aDPyCMWjgsk47MLLqBP5gVwgH+TLb+Ex7l+GHszrXH
         PpXZwcseca9rFN6+JwMIovcUV5KyEJGqleEPagcnVBLCNZ9tlujoVXBXe76rVetsGh+w
         ANjJpc+1/sMVSnmsENEjmY+6VOcT2uEhuJk4LB9Vk2QHBCRJqu3APDIcphcdBxNPOLi2
         KKQ5K1BpfRHBC6p89HoTYjA/xVXnpb6m04NNepfJOnZPni+IeI+ZIsB7rQA5xsqxyRYk
         oGtFiMVpd3LH++sUfeGf6Q1YVQiFjyO6rYduB1quQrN7Lz86FlKiXAxiWzz+pxtj9XLN
         f1vQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vy64B21aBQWdeYHzGXC1xqU+YS/o96ajzA+KtsutFPNw514YwUp1ub086sDFZjo+yL9L4ANsAlk7TNPA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzu9AFJUEvhIrngYATzzPZ7BnLLRFkhA7rBI+dHS2rzg5hpqTs8
	JZD60KKKJ2l0fDo47dy01YqDyE4siwIf6OhgEuOFNg7js3MOF8YelZ4xwgM2p2azLgE=
X-Gm-Gg: AfdE7cmp63dvXORZ6/WEgRwVeNa7UgYBrbd2AEqIXhvvPSStnSZ9asMW0LyRVKO5wK4
	f6ZpwZv6Tv1ZSzcwxXX9oDY9jaF/lto9dMZSElgVKxDJuSGiZIa0Ppk+kDdJkuHy9suurAEQOYP
	t2kPDnWpZW45UgjGAQSe9wrXTBQtZEJG3MT7b2vmoB0QKaJeL9tl5ThQei99G+5pNVnxpIrZwvx
	kcag6pB2+2974XDXPGot5xOv1LtIxTSpT+SytJUGrmKiRqKLBbCvjczM5YeVz7ahUP39QK1UIdc
	kOX91a2vKV+kp4Zr1JfcMHtBbaB1ONF8FThWUQvglp5WvjGy6XNXyAuyyXuWVyTdmqOYazIfMcP
	a0RY3fNdYAqLbrrfL5gjsFHpgfcpixewN4lODRfIjDT137s9YNVEhwen6XimLloRICFqFhVfFj1
	UN81YdceQ+T/r0L0sxuHekG7huvOai31r4/H+n75gjkcnCwbltbe0uprAEg8kl2ZjzERgjrgVhA
	1+zPc2RZLre8I7IOFeNTmSJY/En
X-Received: by 2002:a05:600c:698c:b0:492:4c9e:c95d with SMTP id 5b1f17b1804b1-4925b3b21e1mr48666485e9.18.1782224995461;
        Tue, 23 Jun 2026 07:29:55 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm362507805e9.2.2026.06.23.07.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:29:55 -0700 (PDT)
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
Subject: [PATCH v3 5/7] soc: aspeed: add host-side PCIe BMC device driver
Date: Tue, 23 Jun 2026 14:25:43 +0000
Message-ID: <8746971524bf4186c9a393dab637ad4e27ce4563.1782224059.git.gregoire.layet@9elements.com>
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

Add support for VUART over PCIe between BMC and host.
This add host side driver.
This only support the AST2600.

Taken from ASPEED 6.18 Kernel SDK and trimmed down.

The host can't detect the VUART adresses, they are forced
at 0x3f8 and 0x2f8, similar from the initial ASPEED driver.

The MSI vector index has been changed for the VUART2 from 15 to 17.
The index 15 used in the initial driver was not working.

Data path in both direction is tested on both VUART.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
Tested-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/soc/aspeed/Kconfig               |   8 +
 drivers/soc/aspeed/Makefile              |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c | 183 +++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index 63a656449a1a..ebd023b10701 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -4,6 +4,14 @@ if ARCH_ASPEED || COMPILE_TEST
 
 menu "ASPEED SoC drivers"
 
+config ASPEED_HOST_BMC_DEV
+	tristate "ASPEED Host BMC Device"
+	depends on PCI
+	depends on SERIAL_8250
+	help
+	  Enable support for the ASPEED AST2600 BMC Device on the Host.
+	  This configure the PCIe and setup two 8250 compatible VUART ports.
+
 config ASPEED_LPC_CTRL
 	tristate "ASPEED LPC firmware cycle control"
 	select REGMAP
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
index 000000000000..3160b6aedb5b
--- /dev/null
+++ b/drivers/soc/aspeed/aspeed-host-bmc-dev.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (C) ASPEED Technology Inc.
+
+#include <linux/init.h>
+#include <linux/version.h>
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
+static int vuart_msi_index[2] = { 16, 17 };
+static int vuart_port_addr[2] = {0x3f8, 0x2f8};
+
+struct aspeed_pci_bmc_dev {
+	struct device *dev;
+	kernel_ulong_t driver_data;
+	int id;
+
+	unsigned long message_bar_base;
+
+	struct uart_8250_port uart[2];
+	int uart_line[2];
+
+	int *msi_idx_table;
+};
+
+static void aspeed_pci_setup_irq_resource(struct pci_dev *pdev)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
+
+	pci_bmc_dev->msi_idx_table = vuart_msi_index;
+
+	if (pci_alloc_irq_vectors(pdev, 1, BMC_MULTI_MSI, PCI_IRQ_INTX | PCI_IRQ_MSI) <= 1)
+		/* If pci_alloc fail, set all msi index to the first vector */
+		memset(pci_bmc_dev->msi_idx_table, 0, sizeof(vuart_msi_index));
+}
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
+	/* ASPEED BMC device shift adresses by 2 to the left */
+	vuart_ioport = vuart_ioport << 2;
+
+	uart->port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	uart->port.uartclk = 115200 * 16;
+	uart->port.irq = pci_irq_vector(pdev, pci_bmc_dev->msi_idx_table[idx]);
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
+		goto out_freeVUART1;
+
+	return 0;
+
+out_freeVUART1:
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
+	aspeed_pci_setup_irq_resource(pdev);
+
+	/* Setup BMC PCI device */
+	rc = aspeed_pci_host_setup(pdev);
+	if (rc) {
+		dev_err(&pdev->dev, "ASPEED PCIe Host device returned error %d\n", rc);
+		pci_free_irq_vectors(pdev);
+		pci_disable_device(pdev);
+		return rc;
+	}
+
+	return 0;
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
+	{ PCI_DEVICE(PCI_VENDOR_ID_ASPEED, PCI_BMC_DEVICE_ID), .class = 0xFF0000, .class_mask = 0xFFFF00,
+	  .driver_data = ASPEED },
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


