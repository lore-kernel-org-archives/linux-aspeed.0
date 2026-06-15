Return-Path: <linux-aspeed+bounces-4257-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB4FCD98D6
	for <linux-aspeed@archiver.kernel.org>; Mon, 15 Jun 2026 08:02:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf2dh5sT4z30gJ;
	Mon, 15 Jun 2026 18:02:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781507113;
	cv=none; b=LC/dge6+uW8+ibpQqSJxZEJfamPuyMYHPBwG0/7150IUiT9kEWbHVAOzzjbnYEeu2t8yi9umcrCTnQ/fW9QVV53pcqpqm7qawXuNnKnMcS5eseYyHpmGDSE1Rj8dUliukH6dqR3Qt43xU4tGxOex3EZ88OSaI76Lg+C3sczEG4srY200rRiJadNTo8BZEefAIAKn9T4TAKpaExLxEiztk0V3qSjzdrFmtMt6IZHFdo7iyc+0pqLXDt72y6qf1NjRwb3tGWk/yLs8HAMxh5W6UoUMDeDSHNQ9sdOKtINZCTaIBQiKWfn7SX8aNpOxQ7ZtxqyAQH9LIxWO7/EcLwlOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781507113; c=relaxed/relaxed;
	bh=gwjKJbogDdVACFgqntDi9pGhUoR/9LsudPgTXNmAMMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n6Rkp/e8//u3MdyJDQEKrn5WBEVy4u2FKdvIGeaN0zt7hyxmNkJnAncTW3tv65vCmz3qlZeQEPvNXWUIPWwUmQDRIa8AxibArJQTDyBVGE+VL16+V9i4bB9fmzGbyPfETy9kjSNNkT7/i8erM+02bXWYeQA4wyX/S8Uyr22IdVriAKO8JOsQ6PBXlBExDi1teCdkxX8EaRhUEQ09YeXkU04p0Dxu1fWfMPOrv25ZBJK2Tlv/Yz8hEFW2rf/FhhboXZiXV82cF8q21b53tYPaCCH1TSoZei4iX8iW/zMTqVRkZZDJ2qaI23JWgNUA+0PrIIkQLXY0xrxYrMazHtQ2Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 310 seconds by postgrey-1.37 at boromir; Mon, 15 Jun 2026 17:05:11 AEST
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf1N75YC5z2xls;
	Mon, 15 Jun 2026 17:05:11 +1000 (AEST)
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowADXYQXloi9qSxaUEw--.63904S2;
	Mon, 15 Jun 2026 14:59:49 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-fsi@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: pengpeng@iscas.ac.cn
Subject: [PATCH] fsi: aspeed: publish cfam_reset after drvdata is ready
Date: Mon, 15 Jun 2026 14:59:44 +0800
Message-ID: <20260615065944.34767-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
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
X-CM-TRANSID:zQCowADXYQXloi9qSxaUEw--.63904S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCryrCry3Kr1DZFyDZFy3twb_yoW5XrW5pa
	y3WFWFgr48Gr4Fg34kJ3Wqvw1fX3y5tayUJrWxGw4xuasIy34YqryxJrWxXF4fZrWkCF1S
	kF1Ut3yruF4UtF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDOz
	3UUUUU=
X-Originating-IP: [111.196.245.140]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

setup_cfam_reset() creates the cfam_reset sysfs file. Its store callback
gets struct fsi_master_aspeed from device drvdata and locks
aspeed->lock.

The file is currently created before dev_set_drvdata() and before the
mutex is initialized, so a sysfs write during probe can dereference
missing drvdata or use an uninitialized mutex. The file is also not
removed on later probe failure or device removal.

Initialize drvdata and the mutex before publishing cfam_reset, remember
whether the file was created, and remove it on unwind and remove.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/fsi/fsi-master-aspeed.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index aa1380cdff33..5c8806c4027d 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -25,6 +25,7 @@ struct fsi_master_aspeed {
 	void __iomem		*base;
 	struct clk		*clk;
 	struct gpio_desc	*cfam_reset_gpio;
+	bool			cfam_reset_file;
 };
 
 #define to_fsi_master_aspeed(m) \
@@ -483,6 +484,7 @@ static int setup_cfam_reset(struct fsi_master_aspeed *aspeed)
 		devm_gpiod_put(dev, gpio);
 		return rc;
 	}
+	aspeed->cfam_reset_file = true;
 
 	return 0;
 }
@@ -570,6 +572,9 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 		goto err_free_aspeed;
 	}
 
+	dev_set_drvdata(&pdev->dev, aspeed);
+	mutex_init(&aspeed->lock);
+
 	rc = setup_cfam_reset(aspeed);
 	if (rc) {
 		dev_err(&pdev->dev, "CFAM reset GPIO setup failed\n");
@@ -620,9 +625,6 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	aspeed->master.term = aspeed_master_term;
 	aspeed->master.link_enable = aspeed_master_link_enable;
 
-	dev_set_drvdata(&pdev->dev, aspeed);
-
-	mutex_init(&aspeed->lock);
 	aspeed_master_init(aspeed);
 
 	rc = fsi_master_register(&aspeed->master);
@@ -640,8 +642,11 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	return 0;
 
 err_release:
+	if (aspeed->cfam_reset_file)
+		device_remove_file(&pdev->dev, &dev_attr_cfam_reset);
 	clk_disable_unprepare(aspeed->clk);
 err_free_aspeed:
+	dev_set_drvdata(&pdev->dev, NULL);
 	kfree(aspeed);
 	return rc;
 }
@@ -650,6 +655,8 @@ static void fsi_master_aspeed_remove(struct platform_device *pdev)
 {
 	struct fsi_master_aspeed *aspeed = platform_get_drvdata(pdev);
 
+	if (aspeed->cfam_reset_file)
+		device_remove_file(&pdev->dev, &dev_attr_cfam_reset);
 	fsi_master_unregister(&aspeed->master);
 	clk_disable_unprepare(aspeed->clk);
 }
-- 
2.50.1 (Apple Git-155)


