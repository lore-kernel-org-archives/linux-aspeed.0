Return-Path: <linux-aspeed+bounces-4740-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BD4C5B572
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Aug 2026 00:41:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNYtc1HP2z2y8F;
	Mon, 17 Aug 2026 10:41:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786694262;
	cv=none; b=ejmdyfD6A4KbjWX8VAe+nEHVt+pl9Kcz3P9yoN52BJ8p+M5o3qVhrGp6nOhsESslHKB5pduK94rl4EsrIfwEfnoo26v5DmHmVnpAc6kynRrg77cME4IL5Uo2Nf6oZIwJ45VB2LsBHD3lQPa4rEiK9fJUv0KNJxW+R60W0qIcAcwaynTKY1gH4LX+Xd/tBUorhpx56GSevQ2hGYYTTFPpH34qda8XGgrez6ZJ3fjv8jn9q7K4R/ruGqPRzTKvGBlS2ISWnSaG8x3eSwxZ1S1fG7RpKG0n4XV2vqL1uN9XVDUdHhgO0xXzUW0bnFU1lPQ23bCl3SEHqKtKlmh0AJOLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786694262; c=relaxed/relaxed;
	bh=mL4j5vM5lGTNjWISMmnHoD354a3SrDw7wyh5Y5wrwvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y34dAfcTxea8kcdq8xDl4MakVCEjmavVAa6bgpIkkayW8wcYLfuEapwK9pwsPD91v0hoSC4bNkqpCCUTYc+Uhs9zGNQ7lm06WwrJhH3aZ9rydpWbB5D0Qo+nWbEp3Xl2S5fNGb89QzGj5ahkZ1j7Zte3fq2ycT7jmbcWjX2FXoLVHJyKd09XBeeJkd5Njy7L1ygWs99hQ7WH2lvoztxcHhRqhglS4YCqKCWwdS5zfZ/GYB11vNRITs8ho2WT5IIyfbzpGBsK0d14X6zLmFMMvsP9JRiFiyVcMr0pbxq2AtkKD2VFiE7299dYRyQxBOCe5BEWh1Z7XcSxdrb9aFOgzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 434 seconds by postgrey-1.37 at boromir; Fri, 14 Aug 2026 17:57:41 AEST
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLvj12zvkz2y81;
	Fri, 14 Aug 2026 17:57:41 +1000 (AEST)
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowAC3ie2xyH5q21KeBQ--.63393S2;
	Fri, 14 Aug 2026 15:50:10 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>
Cc: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-fsi@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] fsi: aspeed: publish cfam_reset through driver groups
Date: Fri, 14 Aug 2026 15:50:08 +0800
Message-ID: <20260814075008.9031-1-pengpeng@iscas.ac.cn>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3ie2xyH5q21KeBQ--.63393S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF47XFW7XrWUur1kGFW8Xrb_yoW5uF4kpa
	97WFWYgr48Gr1fJayDJan2v3WF9w4rtrWUGr4fKw1S9asxAa4YqryxtrWIvF1xZFWrCF15
	Jr1Dt3yUuF4kZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-Originating-IP: [111.196.241.250]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The cfam_reset attribute currently gets created manually while probe is
still initializing the master. Its store callback expects device drvdata
and the master's mutex to be ready, and manual publication also requires
matching cleanup on every later failure and remove path.

Expose the attribute through the driver's default groups instead. The
driver core publishes those groups only after probe succeeds. Hide the
attribute when the optional reset GPIO is unavailable, while retaining
probe deferral and other GPIO acquisition errors.

Fixes: 4a851d714eade ("fsi: aspeed: Support CFAM reset GPIO")
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260615065944.34767-1-pengpeng@iscas.ac.cn/
- replace manual sysfs publication with driver-core groups and is_visible()
- preserve optional-GPIO and probe-deferral error semantics
- remove manual sysfs unwind paths

The probe/publication ordering was reviewed statically; no Aspeed FSI
hardware test was performed.

 drivers/fsi/fsi-master-aspeed.c | 38 ++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index aa1380cdff33..ac05e1a263ac 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -464,26 +464,42 @@ static ssize_t cfam_reset_store(struct device *dev, struct device_attribute *att
 
 static DEVICE_ATTR(cfam_reset, 0200, NULL, cfam_reset_store);
 
+static umode_t fsi_master_aspeed_attr_is_visible(struct kobject *kobj,
+						 struct attribute *attr, int n)
+{
+	struct fsi_master_aspeed *aspeed = dev_get_drvdata(kobj_to_dev(kobj));
+
+	if (!aspeed || !aspeed->cfam_reset_gpio)
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *fsi_master_aspeed_attrs[] = {
+	&dev_attr_cfam_reset.attr,
+	NULL,
+};
+
+static const struct attribute_group fsi_master_aspeed_group = {
+	.attrs = fsi_master_aspeed_attrs,
+	.is_visible = fsi_master_aspeed_attr_is_visible,
+};
+
+static const struct attribute_group *fsi_master_aspeed_groups[] = {
+	&fsi_master_aspeed_group,
+	NULL,
+};
+
 static int setup_cfam_reset(struct fsi_master_aspeed *aspeed)
 {
 	struct device *dev = aspeed->dev;
 	struct gpio_desc *gpio;
-	int rc;
 
 	gpio = devm_gpiod_get_optional(dev, "cfam-reset", GPIOD_OUT_LOW);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
-	if (!gpio)
-		return 0;
 
 	aspeed->cfam_reset_gpio = gpio;
-
-	rc = device_create_file(dev, &dev_attr_cfam_reset);
-	if (rc) {
-		devm_gpiod_put(dev, gpio);
-		return rc;
-	}
-
 	return 0;
 }
 
@@ -573,6 +589,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	rc = setup_cfam_reset(aspeed);
 	if (rc) {
 		dev_err(&pdev->dev, "CFAM reset GPIO setup failed\n");
+		goto err_release;
 	}
 
 	writel(0x1, aspeed->base + OPB_CLK_SYNC);
@@ -664,6 +681,7 @@ static struct platform_driver fsi_master_aspeed_driver = {
 	.driver = {
 		.name		= "fsi-master-aspeed",
 		.of_match_table	= fsi_master_aspeed_match,
+		.dev_groups	= fsi_master_aspeed_groups,
 	},
 	.probe	= fsi_master_aspeed_probe,
 	.remove = fsi_master_aspeed_remove,
-- 
2.50.1 (Apple Git-155)


