Return-Path: <linux-aspeed+bounces-3841-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57833FB5173
	for <linux-aspeed@archiver.kernel.org>; Mon,  6 Apr 2026 23:25:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqQRx5B5mz2yft;
	Tue, 07 Apr 2026 09:25:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775517949;
	cv=none; b=LL7Ao9owEwdA65+AX+XBn9D/MxBMUJQdQUaaR0cKBwyc95b2QVCIoa/m7OhEWYZtA73ucJ64bxaxuSP9TqzIhhK2VDj2msXpT5GslArcyBSChAuM9JFl8voMVeXpxPzTGMAXCEUs5Ra9xG1bWQ1PvEevKx1RJOAaoKHMfxyfe3ufvuCE589mUmfCMnTzW9CdcEPBycvbteqVmhRNFDRuy3boBCyrHVvJuJwkpuXO+yiaW7DD4hFTfLAZlxtQPaphuJDydHmK0AH71ud5eXSO4SdyK0gOn6CYvpSw5Y3DYfJhXQrxHyZ9XRZa6weQ0NzP4EUgzDcw/i/87v4XB7HgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775517949; c=relaxed/relaxed;
	bh=ZXh4AAlJDAdDMt/mfgmqe7SUyEdUcOFGra/HATmG4Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rm0GREJCtPqyO9wYtAHgt45nq3+HQV4wh0NeRi2aIP4QsqJCRPL+5o7sk/+QwD9GKkahWKi2Fw+S/tZeXbnS98who/2fR/tKBnDgCGJPxGlL01bfYI1xlKXtfqLoLFTIYkGyQh8PAak5DSSm6fZpbeb2j38qw3BIxZk+MacHcQ5Q9Wgc+itOQvZBDL9vjKAo4EZ/CoFhzrQLnaPIC6fft8X6neYdnbFADSf/GH/0mkS9roYZkxsVPRwT2GxrhSQ+WQYKiIjsl06G9ILV57ordXCj5ZFg0OLpNy62Q2fX9de9nSLFddS0Oyp8NS3GMUUnI2iGbPQo4apYb5Xl2TQSMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KqGc7yzW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KqGc7yzW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqQRw6KgXz2yfs
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 09:25:48 +1000 (AEST)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-2c15849aa2cso5682217eec.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Apr 2026 16:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775517947; x=1776122747; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXh4AAlJDAdDMt/mfgmqe7SUyEdUcOFGra/HATmG4Zg=;
        b=KqGc7yzWxCvOq4oQFbwp9cdvWJVrovnR1wLVYlRUtJT+s8uY82YUBdvW1ebak2RoNR
         qIVN8JaiUxNWcL7ep8i9Wnjh9AQCTJwdEiZalPZwwz/R+gxuwfhDOL+oqvsmmP7D8PeU
         RGoP4WTTU/iJYWsDWPs5ggMzPX2pscgPmFwpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775517947; x=1776122747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXh4AAlJDAdDMt/mfgmqe7SUyEdUcOFGra/HATmG4Zg=;
        b=ffKoE6Gr28fd6bAys0YE9qELq7Q5ClNlXBN9rK6rLmhywRi4DeVBjwYqo0uR22FUdg
         HxaOspndj5qs7DNNSPmGiBdGcTxWuuiEze4GVce9U7FWTldCNBAUlvMrkfC5FoIj9WtG
         HG+udheXZ1yRwaZ9w3gFf9xbpEpI+spUouWmZvgM2ooNy08t9d7Ev4t6LlqHiRpxsm3y
         D05ydvHAzbhDBTwnsHyr2WZZDht3FXdnuJh1BTNw/ket1tXN5M9DbPAPORtAqviY2FW6
         Cz8T+T930CdQbNVE0gFqepYbCB2MiW+dlpfwTjtzdKjh6KLPCDRw88L5KXSCWaCDfhRB
         liDg==
X-Forwarded-Encrypted: i=1; AJvYcCVxN2glhrXgfqPh0FDo0q/3MOFZz3l0JZ5RdprPn5tmnjGq88TUrpwSk3ynMrZe/gM8CuHTUyIuVJufRVc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxk/qVYagapm6L64JIqUeYP7VO81UFBlIVWcSupGrhg40qtE7lX
	XNXdfGMFcUvUtbHSnaUdGaH+VvPUghGaodV3fMBUdt1qbh8x8KuUjBsz4sCFl48Lkg==
X-Gm-Gg: AeBDieuR5ynXtdI+cArjdgT3ZtP2KrH40+Pp/OQzYmA73/s6BYir05VjgKFtO8Chv1Y
	ULYhYfPyvj2hzKobpLgjuq7/oXcDGv04qJAOU5nh6u8ruquQJifm/xARO2f15E1/sJLLHdDaTu1
	WNg3/L/zywYH9ZAczCxIolm4cY/52pGVGIrenvnIfaureV+VUmtoOEvOZPDaBmu0FGxQYMkESnE
	NLrCbYWXcKJYE859jBp7r75ocRDnkfhE1LhKrW8mnJTDB8JfMSyCvSrYTkLTIMPMosjyrKOa/zG
	wHnOWmJx/VHZSWQTMfpUyqrQdMNgIwr96EEpATL4axL7bKjYgh0RUZXpc/ZChV7Kmik+OgyJHYn
	qNsf0hAGDxEqTa2Ulz4J5CBail2KKLxmOLbwPSlMJvSv02UtTfEaZs1/vrT7d83hXXO7QntmI08
	JuFzrt+3OK8lUQQyO6d4QcXFXhaRQ7bc404knkVHhbQwTVGjJa5UORUMWYTY77NKlwtzls5W9/z
	kKeabsVfg==
X-Received: by 2002:a05:7300:d509:b0:2c7:2cac:8123 with SMTP id 5a478bee46e88-2cbf99ec1d3mr6819121eec.4.1775517946892;
        Mon, 06 Apr 2026 16:25:46 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:c071:3b78:5a5:824a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca760b0518sm14730975eec.0.2026.04.06.16.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:25:45 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	maz@kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	alexander.stein@ew.tq-group.com,
	andrew@codeconstruct.com.au,
	andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	astewart@tektelic.com,
	bhelgaas@google.com,
	brgl@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	driver-core@lists.linux.dev,
	hkallweit1@gmail.com,
	jirislaby@kernel.org,
	joel@jms.id.au,
	kees@kernel.org,
	kuba@kernel.org,
	lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	mani@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	robh@kernel.org
Subject: [PATCH v5 8/9] driver core: Replace dev->of_node_reused with dev_of_node_reused()
Date: Mon,  6 Apr 2026 16:23:01 -0700
Message-ID: <20260406162231.v5.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260406232444.3117516-1-dianders@chromium.org>
References: <20260406232444.3117516-1-dianders@chromium.org>
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

In C, bitfields are not necessarily safe to modify from multiple
threads without locking. Switch "of_node_reused" over to the "flags"
field so modifications are safe.

Cc: Johan Hovold <johan@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

(no changes since v4)

Changes in v4:
- Use accessor functions for flags

Changes in v3:
- New

 drivers/base/core.c                      | 2 +-
 drivers/base/pinctrl.c                   | 2 +-
 drivers/base/platform.c                  | 2 +-
 drivers/net/pcs/pcs-xpcs-plat.c          | 2 +-
 drivers/of/device.c                      | 6 +++---
 drivers/pci/of.c                         | 2 +-
 drivers/pci/pwrctrl/core.c               | 2 +-
 drivers/regulator/bq257xx-regulator.c    | 2 +-
 drivers/regulator/rk808-regulator.c      | 2 +-
 drivers/tty/serial/serial_base_bus.c     | 2 +-
 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 2 +-
 include/linux/device.h                   | 7 ++++---
 12 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8a83d7c93361..30825bf83234 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5283,7 +5283,7 @@ void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
 {
 	of_node_put(dev->of_node);
 	dev->of_node = of_node_get(dev2->of_node);
-	dev->of_node_reused = true;
+	dev_set_of_node_reused(dev);
 }
 EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);
 
diff --git a/drivers/base/pinctrl.c b/drivers/base/pinctrl.c
index 6e250272c843..0bbc83231234 100644
--- a/drivers/base/pinctrl.c
+++ b/drivers/base/pinctrl.c
@@ -24,7 +24,7 @@ int pinctrl_bind_pins(struct device *dev)
 {
 	int ret;
 
-	if (dev->of_node_reused)
+	if (dev_of_node_reused(dev))
 		return 0;
 
 	dev->pins = devm_kzalloc(dev, sizeof(*(dev->pins)), GFP_KERNEL);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d44591d52e36..199e6fb25770 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -856,7 +856,7 @@ struct platform_device *platform_device_register_full(
 	pdev->dev.parent = pdevinfo->parent;
 	pdev->dev.fwnode = pdevinfo->fwnode;
 	pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
-	pdev->dev.of_node_reused = pdevinfo->of_node_reused;
+	dev_assign_of_node_reused(&pdev->dev, pdevinfo->of_node_reused);
 
 	if (pdevinfo->dma_mask) {
 		pdev->platform_dma_mask = pdevinfo->dma_mask;
diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index b8c48f9effbf..f4b1b8246ce9 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -349,7 +349,7 @@ static int xpcs_plat_init_dev(struct dw_xpcs_plat *pxpcs)
 	 * up later. Make sure DD-core is aware of the OF-node being re-used.
 	 */
 	device_set_node(&mdiodev->dev, fwnode_handle_get(dev_fwnode(dev)));
-	mdiodev->dev.of_node_reused = true;
+	dev_set_of_node_reused(&mdiodev->dev);
 
 	/* Pass the data further so the DW XPCS driver core could use it */
 	mdiodev->dev.platform_data = (void *)device_get_match_data(dev);
diff --git a/drivers/of/device.c b/drivers/of/device.c
index f7e75e527667..be4e1584e0af 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -26,7 +26,7 @@
 const struct of_device_id *of_match_device(const struct of_device_id *matches,
 					   const struct device *dev)
 {
-	if (!matches || !dev->of_node || dev->of_node_reused)
+	if (!matches || !dev->of_node || dev_of_node_reused(dev))
 		return NULL;
 	return of_match_node(matches, dev->of_node);
 }
@@ -192,7 +192,7 @@ ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
 {
 	ssize_t sl;
 
-	if (!dev || !dev->of_node || dev->of_node_reused)
+	if (!dev || !dev->of_node || dev_of_node_reused(dev))
 		return -ENODEV;
 
 	sl = of_modalias(dev->of_node, str, len - 2);
@@ -254,7 +254,7 @@ int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *
 {
 	int sl;
 
-	if ((!dev) || (!dev->of_node) || dev->of_node_reused)
+	if ((!dev) || (!dev->of_node) || dev_of_node_reused(dev))
 		return -ENODEV;
 
 	/* Devicetree modalias is tricky, we add it in 2 steps */
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 9f8eb5df279e..1f9b669abdb0 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -38,7 +38,7 @@ int pci_set_of_node(struct pci_dev *dev)
 	struct device *pdev __free(put_device) =
 		bus_find_device_by_of_node(&platform_bus_type, node);
 	if (pdev)
-		dev->bus->dev.of_node_reused = true;
+		dev_set_of_node_reused(&dev->bus->dev);
 
 	device_set_node(&dev->dev, of_fwnode_handle(no_free_ptr(node)));
 	return 0;
diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 7754baed67f2..72963a92362a 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -39,7 +39,7 @@ static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
 		 * If we got here then the PCI device is the second after the
 		 * power control platform device. Mark its OF node as reused.
 		 */
-		dev->of_node_reused = true;
+		dev_set_of_node_reused(dev);
 		break;
 	}
 
diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index dab8f1ab4450..40e0f1a7ae81 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -143,7 +143,7 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	struct regulator_config cfg = {};
 
 	pdev->dev.of_node = pdev->dev.parent->of_node;
-	pdev->dev.of_node_reused = true;
+	dev_set_of_node_reused(&pdev->dev);
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bq257xx_reg_data), GFP_KERNEL);
 	if (!pdata)
diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index e66408f23bb6..8297d31cde9f 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -2115,7 +2115,7 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	int ret, i, nregulators;
 
 	pdev->dev.of_node = pdev->dev.parent->of_node;
-	pdev->dev.of_node_reused = true;
+	dev_set_of_node_reused(&pdev->dev);
 
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!regmap)
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index a12935f6b992..5f23284a8778 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -74,7 +74,7 @@ static int serial_base_device_init(struct uart_port *port,
 	dev->parent = parent_dev;
 	dev->bus = &serial_base_bus_type;
 	dev->release = release;
-	dev->of_node_reused = true;
+	dev_set_of_node_reused(dev);
 
 	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 2ecd049dacc2..8b9449d16324 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -593,7 +593,7 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 		d->gadget.max_speed = USB_SPEED_HIGH;
 	d->gadget.speed = USB_SPEED_UNKNOWN;
 	d->gadget.dev.of_node = vhub->pdev->dev.of_node;
-	d->gadget.dev.of_node_reused = true;
+	dev_set_of_node_reused(&d->gadget.dev);
 
 	rc = usb_add_gadget_udc(d->port_dev, &d->gadget);
 	if (rc != 0)
diff --git a/include/linux/device.h b/include/linux/device.h
index 5b0fb6ad4c72..a79865a212e9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -483,6 +483,8 @@ struct device_physical_location {
  *		driver/bus sync_state() callback.
  * @DEV_FLAG_DMA_COHERENT: This particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
+ * @DEV_FLAG_OF_NODE_REUSED: Set if the device-tree node is shared with an
+ *		ancestor device.
  */
 enum struct_device_flags {
 	DEV_FLAG_READY_TO_PROBE = 0,
@@ -492,6 +494,7 @@ enum struct_device_flags {
 	DEV_FLAG_DMA_OPS_BYPASS = 4,
 	DEV_FLAG_STATE_SYNCED = 5,
 	DEV_FLAG_DMA_COHERENT = 6,
+	DEV_FLAG_OF_NODE_REUSED = 7,
 
 	DEV_FLAG_COUNT
 };
@@ -573,8 +576,6 @@ enum struct_device_flags {
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
- * @of_node_reused: Set if the device-tree node is shared with an ancestor
- *              device.
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -681,7 +682,6 @@ struct device {
 
 	bool			offline_disabled:1;
 	bool			offline:1;
-	bool			of_node_reused:1;
 
 	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
@@ -715,6 +715,7 @@ __create_dev_flag_accessors(dma_skip_sync, DEV_FLAG_DMA_SKIP_SYNC);
 __create_dev_flag_accessors(dma_ops_bypass, DEV_FLAG_DMA_OPS_BYPASS);
 __create_dev_flag_accessors(state_synced, DEV_FLAG_STATE_SYNCED);
 __create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
+__create_dev_flag_accessors(of_node_reused, DEV_FLAG_OF_NODE_REUSED);
 
 #undef __create_dev_flag_accessors
 
-- 
2.53.0.1213.gd9a14994de-goog


