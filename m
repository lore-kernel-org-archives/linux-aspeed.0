Return-Path: <linux-aspeed+bounces-3833-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FA7CC6B1D
	for <linux-aspeed@archiver.kernel.org>; Fri,  3 Apr 2026 00:52:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn0YJ3LtVz2yYy;
	Fri, 03 Apr 2026 11:52:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775177524;
	cv=none; b=TnT0NSeyiV80ZAIQA0oMXsSkTOcG/E2UPz/vZeohhprAovNRmqUuEkOnKkDKRt8aJ7MdRC6+9mr665i3W58vq26KYXC5xM0wyuMJk2YWoq0SFBXi23/PzN4o4c4SqirGmpXaDFv8svXErtJC6+bR0F9WQxHmBtjYJJkMD52fkTdYwOpUs4LzVRFKImglR4NSqqUl4zJ+9AyZ1Mp2saMhwOJGAIPXw3EFKc7surrFXZyNIvMxMDv/2LzMYxz7iYT8o9uYvLx9/rAeodqmsPIlCZ1Dppr6uAnSvJPCyt3jAntgEYks9JJpFnISfK9if0po7aoMJpeW2eOIteQKDA4nBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775177524; c=relaxed/relaxed;
	bh=c0XcTKJSZv00lNgVXjUFXubjiKj+C90x3kNuWZLzTwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovWQs22kd38lO5f4bg4RU8sBHwMs64kokdnAA8ZaNZqbceCaw2MU/m1v9RbQiGza7g/m9LDceZl4h4aBrhBR3FAy8uW0Bt1zv6wZaJGpnkVQTGhHcLQCZqKLjv1/TonSgxCIpdwCMFl0i1R3iqaGpwBTDT2UztKorccR5Agv6Kzqb6/zEPnMlHAnFem1ogWGMqjAcJi2wOD5TPLh3Qwh7s4jsx48LHbJkbXq5yXP/ZHPnvp/mGsh0QRH6igp5qjMyETqSZBu7zxu/TL8HosIt8zwXnDoBTFN3y7us3pzJniHfHVKFmT8hDCT9qW5cG9utnjyOvaTEcPOaEUcHCDu1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KcK9zswB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KcK9zswB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn0YH54ZZz2xQD
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Apr 2026 11:52:03 +1100 (AEDT)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-2c156c4a9efso1817533eec.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 02 Apr 2026 17:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775177522; x=1775782322; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0XcTKJSZv00lNgVXjUFXubjiKj+C90x3kNuWZLzTwo=;
        b=KcK9zswBIDoGnXtSmSVcHLNZvT8kTsZv7zFWa1bz01u8hOydHxML1TLEZh4r2wKwDd
         T4EIg/XavrD8KPfb3MTOXsWiOLGR/lQ3VYoIPBo7u8xZa96kkSq2xo0EVQSVy8uy/C0d
         ZoC1lJkwayqWty8wcSLHVJapPbzbjsRNzKxXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177522; x=1775782322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c0XcTKJSZv00lNgVXjUFXubjiKj+C90x3kNuWZLzTwo=;
        b=abZGDkJl/bh+w2H7lj+23+FayFAsmudoyDI2U66UBCjh0l4nO/MX8P/gyRh6FmtNs3
         AR1YBau2xmJil6ATRMjeiFGOAO58EqvakhL9whAqGegWwamhOrizlzvEr28DO+JtsdVR
         /mh/SqG4B+/TuFBpdCfA15aDT643JSV3t5geUafXyTvj0P0KG3a//2XJqBESsylvZ/sP
         VuhoyBQ1vls9KGxfZfnOnx6F+2a16YmCRlnt3D7W63ZT9EVgkNRnyy8XAIizkvThJ4r2
         828oEOc2HUaUDGctkrZptXLynmlSnDExp03iPUlGpYR+BUDt7J9nE7TnFA951bbHpiHM
         TpyA==
X-Forwarded-Encrypted: i=1; AJvYcCVOODpoZfCU9Dt4mq62nJWlJ2DLHKZ+A1Oa2iWeTQJx6lCcitOmDH32Sz8Mk9nF9WMGEusaUd2V+TZ8n3I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxioqBEhd6urIc+BHEb6pCTj494mKupQimKKhIOronoLUykub8X
	CW7cdl82E2s8kmXJfar/qS3KpOG2rEEwC06LsRQDvlJVOGA1IH4I7SftAqwxKQFh1g==
X-Gm-Gg: AeBDiesQTyBmq7DuBo+wU6uk+BItVKgMVsywV+AE2sW5EGYsjRcjOs8qlLZUSnbQ7Za
	XXsSKKvFUqll/nVi9s9Q4Ry4l7MAhuAGrmwE9pbPNAkGsfAZolVG/4K0NBv4yLjAWoURE596bKF
	3JV/3IWgBDJgksIc5LU632Y9qAV7SeLT6EE+Yfo/1zxUBSov4MBD3RxP8zurXqbotxTnDfrFCq1
	kcYiNwXsNWDqcHLvGkerY2kFTo0UUUIFr9Ie8oSI6DKEWt4PBO6PNOuPu3cEpf18L25HvNec0ra
	DkMHn/lfI6uXM+Z+ZCjO0hZ82dgXovRjwKxB7zvqj7HQ77EyYu+SBruqFyVk365rVjd62+JkY8q
	uxP5bzSN8szFj0qyvfVWQvn/8orFRLGxC6YSGS3nhFvOSUY69amCje6c2X5UP2asyVX9/atIJty
	UXF9Wgk0MvFqkg3OCxAbZlYTVjg6LS/5MI86VSMqEVg3/ArlTIPyTcpAR2od8TYbySmrILypb2o
	Qb3kltQNbA=
X-Received: by 2002:a05:7300:2315:b0:2c8:b5e1:6b03 with SMTP id 5a478bee46e88-2cbfbf77d16mr618666eec.23.1775177521837;
        Thu, 02 Apr 2026 17:52:01 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:5db3:7542:a530:f43a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm3630074eec.5.2026.04.02.17.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:51:59 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	alexander.stein@ew.tq-group.com,
	andrew@codeconstruct.com.au,
	andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	astewart@tektelic.com,
	bhelgaas@google.com,
	brgl@kernel.org,
	broonie@kernel.org,
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
Subject: [PATCH v3 8/9] driver core: Replace dev->of_node_reused with DEV_FLAG_OF_NODE_REUSED
Date: Thu,  2 Apr 2026 17:49:54 -0700
Message-ID: <20260402174925.v3.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260403005005.30424-1-dianders@chromium.org>
References: <20260403005005.30424-1-dianders@chromium.org>
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
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

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
 include/linux/device.h                   | 6 +++---
 12 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 00005777c21f..a87bd40499b6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5282,7 +5282,7 @@ void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
 {
 	of_node_put(dev->of_node);
 	dev->of_node = of_node_get(dev2->of_node);
-	dev->of_node_reused = true;
+	set_bit(DEV_FLAG_OF_NODE_REUSED, &dev->flags);
 }
 EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);
 
diff --git a/drivers/base/pinctrl.c b/drivers/base/pinctrl.c
index 6e250272c843..62c228c75d50 100644
--- a/drivers/base/pinctrl.c
+++ b/drivers/base/pinctrl.c
@@ -24,7 +24,7 @@ int pinctrl_bind_pins(struct device *dev)
 {
 	int ret;
 
-	if (dev->of_node_reused)
+	if (test_bit(DEV_FLAG_OF_NODE_REUSED, &dev->flags))
 		return 0;
 
 	dev->pins = devm_kzalloc(dev, sizeof(*(dev->pins)), GFP_KERNEL);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d44591d52e36..5128ff7e5e78 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -856,7 +856,7 @@ struct platform_device *platform_device_register_full(
 	pdev->dev.parent = pdevinfo->parent;
 	pdev->dev.fwnode = pdevinfo->fwnode;
 	pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
-	pdev->dev.of_node_reused = pdevinfo->of_node_reused;
+	assign_bit(DEV_FLAG_OF_NODE_REUSED, &pdev->dev.flags, pdevinfo->of_node_reused);
 
 	if (pdevinfo->dma_mask) {
 		pdev->platform_dma_mask = pdevinfo->dma_mask;
diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index b8c48f9effbf..c2722d8bd98a 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -349,7 +349,7 @@ static int xpcs_plat_init_dev(struct dw_xpcs_plat *pxpcs)
 	 * up later. Make sure DD-core is aware of the OF-node being re-used.
 	 */
 	device_set_node(&mdiodev->dev, fwnode_handle_get(dev_fwnode(dev)));
-	mdiodev->dev.of_node_reused = true;
+	set_bit(DEV_FLAG_OF_NODE_REUSED, &mdiodev->dev.flags);
 
 	/* Pass the data further so the DW XPCS driver core could use it */
 	mdiodev->dev.platform_data = (void *)device_get_match_data(dev);
diff --git a/drivers/of/device.c b/drivers/of/device.c
index f7e75e527667..fd77295a8c0f 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -26,7 +26,7 @@
 const struct of_device_id *of_match_device(const struct of_device_id *matches,
 					   const struct device *dev)
 {
-	if (!matches || !dev->of_node || dev->of_node_reused)
+	if (!matches || !dev->of_node || test_bit(DEV_FLAG_OF_NODE_REUSED, &dev->flags))
 		return NULL;
 	return of_match_node(matches, dev->of_node);
 }
@@ -192,7 +192,7 @@ ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
 {
 	ssize_t sl;
 
-	if (!dev || !dev->of_node || dev->of_node_reused)
+	if (!dev || !dev->of_node || test_bit(DEV_FLAG_OF_NODE_REUSED, &dev->flags))
 		return -ENODEV;
 
 	sl = of_modalias(dev->of_node, str, len - 2);
@@ -254,7 +254,7 @@ int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *
 {
 	int sl;
 
-	if ((!dev) || (!dev->of_node) || dev->of_node_reused)
+	if ((!dev) || (!dev->of_node) || test_bit(DEV_FLAG_OF_NODE_REUSED, &dev->flags))
 		return -ENODEV;
 
 	/* Devicetree modalias is tricky, we add it in 2 steps */
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 9f8eb5df279e..197b60c5a660 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -38,7 +38,7 @@ int pci_set_of_node(struct pci_dev *dev)
 	struct device *pdev __free(put_device) =
 		bus_find_device_by_of_node(&platform_bus_type, node);
 	if (pdev)
-		dev->bus->dev.of_node_reused = true;
+		set_bit(DEV_FLAG_OF_NODE_REUSED, &dev->bus->dev.flags);
 
 	device_set_node(&dev->dev, of_fwnode_handle(no_free_ptr(node)));
 	return 0;
diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 7754baed67f2..cfbe9b615b88 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -39,7 +39,7 @@ static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
 		 * If we got here then the PCI device is the second after the
 		 * power control platform device. Mark its OF node as reused.
 		 */
-		dev->of_node_reused = true;
+		set_bit(DEV_FLAG_OF_NODE_REUSED, &dev->flags);
 		break;
 	}
 
diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index dab8f1ab4450..01d3139e1d87 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -143,7 +143,7 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	struct regulator_config cfg = {};
 
 	pdev->dev.of_node = pdev->dev.parent->of_node;
-	pdev->dev.of_node_reused = true;
+	set_bit(DEV_FLAG_OF_NODE_REUSED, &pdev->dev.flags);
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bq257xx_reg_data), GFP_KERNEL);
 	if (!pdata)
diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index e66408f23bb6..375ea7861134 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -2115,7 +2115,7 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	int ret, i, nregulators;
 
 	pdev->dev.of_node = pdev->dev.parent->of_node;
-	pdev->dev.of_node_reused = true;
+	set_bit(DEV_FLAG_OF_NODE_REUSED, &pdev->dev.flags);
 
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!regmap)
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index a12935f6b992..86c6003bbebb 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -74,7 +74,7 @@ static int serial_base_device_init(struct uart_port *port,
 	dev->parent = parent_dev;
 	dev->bus = &serial_base_bus_type;
 	dev->release = release;
-	dev->of_node_reused = true;
+	set_bit(DEV_FLAG_OF_NODE_REUSED, &dev->flags);
 
 	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 2ecd049dacc2..57048e3aa6bb 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -593,7 +593,7 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 		d->gadget.max_speed = USB_SPEED_HIGH;
 	d->gadget.speed = USB_SPEED_UNKNOWN;
 	d->gadget.dev.of_node = vhub->pdev->dev.of_node;
-	d->gadget.dev.of_node_reused = true;
+	set_bit(DEV_FLAG_OF_NODE_REUSED, &d->gadget.dev.flags);
 
 	rc = usb_add_gadget_udc(d->port_dev, &d->gadget);
 	if (rc != 0)
diff --git a/include/linux/device.h b/include/linux/device.h
index c2a6dba7a036..f6ca067bacca 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -482,6 +482,8 @@ struct device_physical_location {
  *		driver/bus sync_state() callback.
  * @DEV_FLAG_DMA_COHERENT: This particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
+ * @DEV_FLAG_OF_NODE_REUSED: Set if the device-tree node is shared with an
+ *		ancestor device.
  */
 enum struct_device_flags {
 	DEV_FLAG_READY_TO_PROBE,
@@ -491,6 +493,7 @@ enum struct_device_flags {
 	DEV_FLAG_DMA_OPS_BYPASS,
 	DEV_FLAG_STATE_SYNCED,
 	DEV_FLAG_DMA_COHERENT,
+	DEV_FLAG_OF_NODE_REUSED,
 };
 
 /**
@@ -570,8 +573,6 @@ enum struct_device_flags {
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
- * @of_node_reused: Set if the device-tree node is shared with an ancestor
- *              device.
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -678,7 +679,6 @@ struct device {
 
 	bool			offline_disabled:1;
 	bool			offline:1;
-	bool			of_node_reused:1;
 
 	unsigned long		flags;
 };
-- 
2.53.0.1213.gd9a14994de-goog


