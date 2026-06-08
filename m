Return-Path: <linux-aspeed+bounces-4199-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAC2CD6E79
	for <linux-aspeed@archiver.kernel.org>; Mon,  8 Jun 2026 23:51:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ8255zdmz2yRM;
	Tue, 09 Jun 2026 09:51:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930470;
	cv=none; b=K334ZFkrQyCLDI87n52YDbCKbyvtZ2yF49ZESK66ZoOvLEpNELaG5wt9U0T2jKZcfesoJNtIY9OahkVoSv8lTq42vVVL7Wk5wKu4T28WdgfGrCU7lJy3g8wzGdc4V5B0r0/ZI3+aZgEi3cFBklXzzzq5V1GXfiIjNF91pUjRiaqaM5mN3Hx3dHTvNYuEk5r8wbZ1ImaVQ1IicFSpEIXw5Vseh1KTBXNqlqOCXrI4Hvi5twj5rS1A10HOkQQ1GrW4VFfexOeyzwJO/2l/Ror+HES6gmKaXNNTu0/knTzGhticdoj/7I1qhHso3F5gC7wxa+S947adxJuKGzUL08VsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930470; c=relaxed/relaxed;
	bh=oSKKlCPm41pvMUdMrmydhlLiUs0iGWjoDgYMRyPMrdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mdpc1Cz6Z6A3GbQJ0568vAWGU8yRds7zzOEc4lwtMTAcjYQLHNorwbtWhV5glE34URos5kQy52k9dCYTyfkkt5SA0UBzTLihpY82SAHnCGjAG55x+fFuiIB8HVyOR3R2GaOjhD+PCLKYgKd2gg/l2YJxZx1Dw6SbRu42eIyeNJaoN/1I5Ak0c+nXKqxumbrXEFSVYlXgt88xU032Snhj9VlJKYIKeNQz+yKSEdgPL0SDBXQmKou1zwhgbAzIk5kV6Wmv0gG96q7pITGT+iGnl/oQiBdfdLNbyRCIW5NW/2bmZwn1iOgrUAVG9O1dB0ZCAn6xvsnx5n8zwpSaGhJsXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=KwmMFkkt; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=KwmMFkkt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYw6s61xhz3bsQ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Jun 2026 00:54:29 +1000 (AEST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-45ef5146b56so3442691f8f.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 08 Jun 2026 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1780930467; x=1781535267; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSKKlCPm41pvMUdMrmydhlLiUs0iGWjoDgYMRyPMrdw=;
        b=KwmMFkktxkp8Q4gQSH64Au8NnW+G0ohrJTRbt4IVT0S/GN21RKuMw7M6M7VasmiV0i
         7ydz9Xfg+kiszjTRPOY5tFYxyuzg2BBLQpk3m8cFlthDym46CrJQL7TSh5D4YBtZlj0D
         6sgPa1w8EFJPtrQcXwO/DOvgUkJJAMuaT7Bo0HBUAZfHVmqnsY3hzWG8aW17rXA+sOmA
         uQsULxdSnFIRzWUG2nko1UcHQS3nAOCpBctF7lbBI3c+0ncaenWKyLY8GZ5thoELUgh4
         XfS+gmeQRfN1ffmFsXPSRH6Pa0XZkeqUnyE7EEkwfPR1DZcDpf3/2HkOPu0tQasAPlBh
         yLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930467; x=1781535267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oSKKlCPm41pvMUdMrmydhlLiUs0iGWjoDgYMRyPMrdw=;
        b=NVQkfP+ekr3VfLZIJtNLImw/roz/VL9pS04HnDrjEBfw35TGzldShvsEtvr/efpeSG
         so6bDGmRRyP7hG6RvSvggAKAcx8xjQTinfVvtSKCBC7HIRRWFxlYE4tVYchvT7FXdeWQ
         WEh4t040hRKAdT4m5WwD3L37N5r3/fpJ+AQUyWxoPlkiSD1s7Y2/U1dg9+SX7llr68aD
         7CpaqWBjOfXH1yRt0O4XjR1I/jrL6ZuvMkeh2qnczjk/EVEGuppVmzItZjy04dJ20/7G
         j1ed85ndcOQMYvrFqs3fS7lF/5fnwONOmmbiggnJKrT1/C9O47l4oauCr7UI/KMFRnL0
         nHiw==
X-Forwarded-Encrypted: i=1; AFNElJ8bL+bsJi3lIPIKp8KSZaufnUzQmx2B9WR/ZaPZvh6c6fam3aH/q2g1YIxTsSgIaViogmG/LWc8g4WQTjc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz2uxUfHnwYdq8ZlnEEUgwSPaXvKBPfAKro20xYt6vf24RKKfpg
	dzsxiVUalaS+jCZ/sE6zOA78S16goNboLtP3uDZVE18iuPozHfgDqySOrAAi4R75TAk=
X-Gm-Gg: Acq92OFrML/EKce9q401Bb3a13D55WFMyNtv4P6r0FqzqEa9vwNiSkyvrF2ZtCmxdVV
	lyqUMj/Xa2PC6ntFLHpZn6tGi7S9f4qVWHvIfX5FTJNzgMhPlCvd/LVRdfY9m4ec+zL6rQl78zj
	izC/Ruq+CEleiS1z+gWX7kB+MakQJ26Ga73W4pNEtBQKRLGUl1qYHD1XQEYv9HkrsZoeFN/0kOi
	p3km7404g1kGLBDtV86Bsrcbe6rmvw1wfnn4rKWq0/MLvBV9LSYkURgYLSypZM/Mk6/g+l/eEtv
	02H9Mvc9/ToW/Ka8PEYQ9pGFtMKo9DQ6aRXktVz6oq6ulTr9MfVp8ZhaGrOMSUJVIKmMROPPU8j
	cZ2y+H2d7VDv1XdAVSrxePiG508GoGT+GPZufNyva8m7USQMHj7eCx4BPN2UvDnGbJDXmLdlLuq
	UtzUrq2PxLSqQd//4xQIMyWtXYrdpm7HuoNPGRMml6DZa+JbGYOfvEHlSMVUoc
X-Received: by 2002:a05:6000:4024:b0:45e:f7ae:d599 with SMTP id ffacd0b85a97d-46032dbeb2emr22113309f8f.25.1780930466854;
        Mon, 08 Jun 2026 07:54:26 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm56927851f8f.36.2026.06.08.07.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:54:26 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v2 2/2] soc: aspeed: add host-side PCIe BMC device driver
Date: Mon,  8 Jun 2026 14:51:23 +0000
Message-ID: <13d18d25f53e0a084a8c17219804b305d4667c6b.1780929570.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1780929570.git.gregoire.layet@9elements.com>
References: <cover.1780929570.git.gregoire.layet@9elements.com>
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

Taken from ASPEED 6.18 Kernel SDK

Add support for VUART over PCIe between BMC and host.
This add host side driver.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
Tested-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/soc/aspeed/Kconfig               |   8 +
 drivers/soc/aspeed/Makefile              |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c | 249 +++++++++++++++++++++++
 3 files changed, 258 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index 3e1fcf3c3268..5deefb64e8c7 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -11,6 +11,14 @@ config ASPEED_BMC_DEV
 	  Enable support for the ASPEED AST2600 BMC Device.
 	  This exposes the PCIe-to-LPC bridge of the BMC to the host over PCIe.
 
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
index fab0d247df66..3fd3f6d8d36e 100644
--- a/drivers/soc/aspeed/Makefile
+++ b/drivers/soc/aspeed/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_ASPEED_BMC_DEV)		+= aspeed-bmc-dev.o
+obj-$(CONFIG_ASPEED_HOST_BMC_DEV)	+= aspeed-host-bmc-dev.o
 obj-$(CONFIG_ASPEED_LPC_CTRL)		+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
 obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
diff --git a/drivers/soc/aspeed/aspeed-host-bmc-dev.c b/drivers/soc/aspeed/aspeed-host-bmc-dev.c
new file mode 100644
index 000000000000..7cb52a770fb6
--- /dev/null
+++ b/drivers/soc/aspeed/aspeed-host-bmc-dev.c
@@ -0,0 +1,249 @@
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
+static DEFINE_IDA(bmc_device_ida);
+
+#define VUART_MAX_PARMS	2
+#define MAX_MSI_NUM		8
+#define BMC_MULTI_MSI	32
+
+#define DRIVER_NAME "aspeed-host-bmc-dev"
+
+enum aspeed_platform_id {
+	ASPEED,
+};
+
+enum msi_index {
+	VUART0_MSI,
+	VUART1_MSI,
+};
+
+/* Match msi_index */
+static int ast2600_msi_idx_table[MAX_MSI_NUM] = { 16, 15 };
+
+struct aspeed_platform {
+	int (*setup)(struct pci_dev *pdev);
+};
+
+struct aspeed_pci_bmc_dev {
+	struct device *dev;
+	struct aspeed_platform *platform;
+	kernel_ulong_t driver_data;
+	int id;
+
+	unsigned long message_bar_base;
+	unsigned long message_bar_size;
+	void __iomem *msg_bar_reg;
+
+	struct uart_8250_port uart[VUART_MAX_PARMS];
+	int uart_line[VUART_MAX_PARMS];
+
+	/* Interrupt
+	 * The index of array is using to enum msi_index
+	 */
+	int *msi_idx_table;
+};
+
+static void aspeed_pci_setup_irq_resource(struct pci_dev *pdev)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
+
+	/* Assign static msi index table by platform */
+	pci_bmc_dev->msi_idx_table = ast2600_msi_idx_table;
+
+	if (pci_alloc_irq_vectors(pdev, 1, BMC_MULTI_MSI, PCI_IRQ_INTX | PCI_IRQ_MSI) <= 1)
+		/* Set all msi index to the first vector */
+		memset(pci_bmc_dev->msi_idx_table, 0, sizeof(int) * MAX_MSI_NUM);
+}
+
+static int aspeed_pci_bmc_device_setup_vuart(struct pci_dev *pdev)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	u16 vuart_ioport;
+	int ret, i;
+
+	for (i = 0; i < VUART_MAX_PARMS; i++) {
+		/* Assign the line to non-exist device */
+		pci_bmc_dev->uart_line[i] = -ENOENT;
+		vuart_ioport = 0x3F8 - (i * 0x100);
+		pci_bmc_dev->uart[i].port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+		pci_bmc_dev->uart[i].port.uartclk = 115200 * 16;
+		pci_bmc_dev->uart[i].port.irq =
+			pci_irq_vector(pdev, pci_bmc_dev->msi_idx_table[VUART0_MSI + i]);
+		pci_bmc_dev->uart[i].port.dev = dev;
+		pci_bmc_dev->uart[i].port.iotype = UPIO_MEM32;
+		pci_bmc_dev->uart[i].port.iobase = 0;
+		pci_bmc_dev->uart[i].port.mapbase =
+			pci_bmc_dev->message_bar_base + (vuart_ioport << 2);
+		pci_bmc_dev->uart[i].port.membase = 0;
+		pci_bmc_dev->uart[i].port.type = PORT_16550A;
+		pci_bmc_dev->uart[i].port.flags |= (UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE);
+		pci_bmc_dev->uart[i].port.regshift = 2;
+		ret = serial8250_register_8250_port(&pci_bmc_dev->uart[i]);
+		if (ret < 0) {
+			dev_err_probe(dev, ret, "Can't setup PCIe VUART\n");
+			return ret;
+		}
+		pci_bmc_dev->uart_line[i] = ret;
+	}
+	return 0;
+}
+
+static void aspeed_pci_host_bmc_device_release_vuart(struct pci_dev *pdev)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < VUART_MAX_PARMS; i++) {
+		if (pci_bmc_dev->uart_line[i] >= 0)
+			serial8250_unregister_port(pci_bmc_dev->uart_line[i]);
+	}
+}
+
+static int aspeed_pci_host_setup(struct pci_dev *pdev)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
+	int rc = 0;
+
+	/* Get Message BAR */
+	pci_bmc_dev->message_bar_base = pci_resource_start(pdev, 1);
+	pci_bmc_dev->message_bar_size = pci_resource_len(pdev, 1);
+	pci_bmc_dev->msg_bar_reg = pci_ioremap_bar(pdev, 1);
+	if (!pci_bmc_dev->msg_bar_reg)
+		return -ENOMEM;
+
+	if (pdev->revision < 0x27) {
+		/* AST2600 ERRTA40: dummy read */
+		(void)__raw_readl((void __iomem *)pci_bmc_dev->msg_bar_reg);
+	} else {
+		/* AST2700 not supported */
+		pr_err("AST2700 detected but not supported");
+		goto out_free0;
+	}
+
+	rc = aspeed_pci_bmc_device_setup_vuart(pdev);
+	if (rc) {
+		pr_err("Cannot setup Virtual UART");
+		goto out_free0;
+	}
+
+	return 0;
+
+out_free0:
+	pci_iounmap(pdev, pci_bmc_dev->msg_bar_reg);
+
+	return rc;
+}
+
+static struct aspeed_platform aspeed_pcie_host[] = {
+	{ .setup = aspeed_pci_host_setup },
+	{ 0 }
+};
+
+static int aspeed_pci_host_bmc_device_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct aspeed_pci_bmc_dev *pci_bmc_dev;
+	int rc = 0;
+
+	pr_info("ASPEED BMC PCI ID %04x:%04x, IRQ=%u\n", pdev->vendor, pdev->device, pdev->irq);
+
+	pci_bmc_dev = devm_kzalloc(&pdev->dev, sizeof(*pci_bmc_dev), GFP_KERNEL);
+	if (!pci_bmc_dev)
+		return -ENOMEM;
+
+	/* Get platform id */
+	pci_bmc_dev->driver_data = ent->driver_data;
+	pci_bmc_dev->platform = &aspeed_pcie_host[ent->driver_data];
+
+	pci_bmc_dev->id = ida_alloc(&bmc_device_ida, GFP_KERNEL);
+	if (pci_bmc_dev->id < 0)
+		return pci_bmc_dev->id;
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
+	/* Prepare IRQ resource */
+	aspeed_pci_setup_irq_resource(pdev);
+
+	/* Setup BMC PCI device */
+	rc = pci_bmc_dev->platform->setup(pdev);
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
+	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
+
+	if (pci_bmc_dev->driver_data == ASPEED)
+		aspeed_pci_host_bmc_device_release_vuart(pdev);
+
+	ida_free(&bmc_device_ida, pci_bmc_dev->id);
+
+	pci_iounmap(pdev, pci_bmc_dev->msg_bar_reg);
+
+	pci_free_irq_vectors(pdev);
+	pci_disable_device(pdev);
+}
+
+/**
+ * This table holds the list of (VendorID,DeviceID) supported by this driver
+ *
+ */
+static struct pci_device_id aspeed_host_bmc_dev_pci_ids[] = {
+	/* ASPEED BMC Device */
+	{ PCI_DEVICE(0x1A03, 0x2402), .class = 0xFF0000, .class_mask = 0xFFFF00,
+	  .driver_data = ASPEED },
+	{
+		0,
+	}
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
+static int __init aspeed_host_bmc_device_init(void)
+{
+	return pci_register_driver(&aspeed_host_bmc_dev_driver);
+}
+
+static void aspeed_host_bmc_device_exit(void)
+{
+	/* unregister pci driver */
+	pci_unregister_driver(&aspeed_host_bmc_dev_driver);
+}
+
+late_initcall(aspeed_host_bmc_device_init);
+module_exit(aspeed_host_bmc_device_exit);
+
+MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
+MODULE_DESCRIPTION("ASPEED Host BMC DEVICE Driver");
+MODULE_LICENSE("GPL");
-- 
2.51.2


