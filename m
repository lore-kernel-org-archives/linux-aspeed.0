Return-Path: <linux-aspeed+bounces-1623-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DCAC83F03
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Jul 2025 18:35:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bY56X4V7wz2xlK;
	Fri,  4 Jul 2025 04:35:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751567716;
	cv=none; b=kWyUkyhiZXEQLMs+C7j6gPbirieqo61Z1OfEzFMsg2oL9wmg0gVJYhgTXRq3f25eiDLyBLWPBU8YmeWhI6wY6woXLtAarN2OVF3i2pJTtE1vSPOPUbdtGV/fRV46N5tgujPw+LYUX2IAUO697uKso8yV0SKOneT8ThrWpn2Mok9/DtQHTQ9xnJ30z4RhMXINazW1sPotrHwmBzzjVB9XnUNfNrLaWWUb8EUWD/armkzNvv7moK66I7jj0rlXwzEqJfRmWBOoDHOzmJ02YUfE8C3QJCUt0aVmQQKegACM8kmUO6NVBFRR6xseHnh1amqLtZtXdWZLQP7aQjqQukzXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751567716; c=relaxed/relaxed;
	bh=aS2qqHcm6zQyufR12sJ8du8H5X5aWLXjVp9+B4ePgGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TfwBhlcSu/NAeHr8SB6yVnElW61gsLqHotMtnoNmXDezGGSpmefF+bcfxdaY/LsZ/u+igdazW+ZpEj/BLUpwx4m+HqTyFkJ8CK/b/3MWsRIgCKvT67+gqEox4h7XB+iCHSQtnLtrZt/nEDv4oZ7UzATzhfjEVHSYXoq3dDseZnX3e8AFruhKAwQBavav7SkSJ++z6bCL1SI69QM/KYQMGWu2IvxCO+hG2HXZW+fYt7tjhBBai7nUzdH/pA8cF+XrGQi0OipDVGXCXM8Lc4KAN+D+PHnDkcJoB8PqrjwbfnxV/ttBuRgKUQJUICPvjK3L0pheTgu45F3q+HCIo4fYKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RUzjlcwo; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RUzjlcwo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bY56W5lHQz2xjQ
	for <linux-aspeed@lists.ozlabs.org>; Fri,  4 Jul 2025 04:35:15 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5FB6261151;
	Thu,  3 Jul 2025 18:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD4AC4CEE3;
	Thu,  3 Jul 2025 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567713;
	bh=g2Jp3nFdzDCpqkTRi8VIAw0hMS6wPtk21mPBmhu++tY=;
	h=From:To:Cc:Subject:Date:From;
	b=RUzjlcwoLNijbmZtgaC063oZlSftT7OSR304vJ9hQCLhQ2N7gpBcQugMFgMqt+Yw8
	 K0LHrYDwbktvSF8uFo7QgTyp+FqIsgQxyJYXlxCXumvxcgO66j3jGYMGwgJ5bEWxQh
	 YkDA9rcwST1+/KaSOXbpWehG/bBuswMqtL4k1+4uE0tIbI7UjWa36WMpRurUt6JNAX
	 J13miDVT7bMAWypLXEhgcMU0O9+pgPcBRpGq8VzNSL5HOGaXu3MzU6IGEPJjGIBG3F
	 8EECS6h72sov1okm2KGFkgHYYVLPhg6jjk+EkRQ1uB3u1OBNlxwsY7+FlItcfocorJ
	 bfuhlI35Ki8qw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] soc: aspeed: Use of_reserved_mem_region_to_resource() for "memory-region"
Date: Thu,  3 Jul 2025 13:35:07 -0500
Message-ID: <20250703183508.2074735-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
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

Use the newly added of_reserved_mem_region_to_resource() function to
handle "memory-region" properties.

The error handling is a bit different. "memory-region" is optional, so
failed lookup is not an error. But then an error in
of_address_to_resource() is treated as an error. However, that
distinction is not really important. Either the region is available
and usable or it is not. So now, it is just
of_reserved_mem_region_to_resource() which is checked for an error.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 14 +++-----------
 drivers/soc/aspeed/aspeed-p2a-ctrl.c | 14 +++-----------
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
index ee58151bd69e..b7dbb12bd095 100644
--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/regmap.h>
@@ -254,17 +255,8 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, lpc_ctrl);
 
 	/* If memory-region is described in device tree then store */
-	node = of_parse_phandle(dev->of_node, "memory-region", 0);
-	if (!node) {
-		dev_dbg(dev, "Didn't find reserved memory\n");
-	} else {
-		rc = of_address_to_resource(node, 0, &resm);
-		of_node_put(node);
-		if (rc) {
-			dev_err(dev, "Couldn't address to resource for reserved memory\n");
-			return -ENXIO;
-		}
-
+	rc = of_reserved_mem_region_to_resource(dev->of_node, 0, &resm);
+	if (!rc) {
 		lpc_ctrl->mem_size = resource_size(&resm);
 		lpc_ctrl->mem_base = resm.start;
 
diff --git a/drivers/soc/aspeed/aspeed-p2a-ctrl.c b/drivers/soc/aspeed/aspeed-p2a-ctrl.c
index 6cc943744e12..3be2e1b1085b 100644
--- a/drivers/soc/aspeed/aspeed-p2a-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-p2a-ctrl.c
@@ -19,7 +19,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -334,7 +334,6 @@ static int aspeed_p2a_ctrl_probe(struct platform_device *pdev)
 	struct aspeed_p2a_ctrl *misc_ctrl;
 	struct device *dev;
 	struct resource resm;
-	struct device_node *node;
 	int rc = 0;
 
 	dev = &pdev->dev;
@@ -346,15 +345,8 @@ static int aspeed_p2a_ctrl_probe(struct platform_device *pdev)
 	mutex_init(&misc_ctrl->tracking);
 
 	/* optional. */
-	node = of_parse_phandle(dev->of_node, "memory-region", 0);
-	if (node) {
-		rc = of_address_to_resource(node, 0, &resm);
-		of_node_put(node);
-		if (rc) {
-			dev_err(dev, "Couldn't address to resource for reserved memory\n");
-			return -ENODEV;
-		}
-
+	rc = of_reserved_mem_region_to_resource(dev->of_node, 0, &resm);
+	if (!rc) {
 		misc_ctrl->mem_size = resource_size(&resm);
 		misc_ctrl->mem_base = resm.start;
 	}
-- 
2.47.2


