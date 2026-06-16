Return-Path: <linux-aspeed+bounces-4263-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAD1CD8CA8
	for <linux-aspeed@archiver.kernel.org>; Tue, 16 Jun 2026 03:44:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfXsb5W6Gz3bwX;
	Tue, 16 Jun 2026 13:44:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781571017;
	cv=none; b=GG6ODH50mNNxCzYfC1G6boPc3HqOkVe7s09PjlhY6hrjo3wQ6uOQl78Kf++204Z3ZLj799BMAthQuzQYq0/xN4B4qwKShAQQiw2DW1d8GPUJxSeqZ6S3kgirCp2l5qH7FXNooVkOz6VLF9Vmsux/MnVtwBxygMe4rbk6bGsy+1jhcO8+G8jBIbENSlxyVW57uHpkbkmZNNwcUG8IkEilsmycHiKnqhKMGZm78zd/xD806+mdH7RQDzF4tFYVMrxF6QWP+ce4m+XTYE439ZQbCZhHt2EsSiY/9CuQx/YP5sWG0OfpNRbxJLK9p4raQc5WhFuwu0aE2nD1/n0kx3LUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781571017; c=relaxed/relaxed;
	bh=pZMBoFnXpmUC1rIKIT+HBdkKzCMsXIIlT8I1N8o5El8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fieuh/KaX3p7q4dNlfvW9rMSb1Ul8Dmr5cZgvxmtk2VljTbfnB5VW9vw6GpGa8dvhSbwwz4dJQEcJmtrMPprzNHX8zFMZqCXJtME2VqWK0Ndsh2cbVnF3KCAFEQLojKyoGmf6dYfpvcYlMr7V50t75zBsbmisEb6xdLNJS6sB4iLlrQxXKH6VINwfdOJVYusp+80WxRBWKIxzaEY9/qTB1Bmblq5FeBIUr68bwFqz9WGyrO3ggw0AnEXIVcRAaYMm7/mw9JnLcNWjkZzBDZNDxVg2PtbYafzmhM1pB7V0Fe71jxUvP7/0b2S3G0L9CWmqyYU8rz79eD2xhKZnYJ7Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfT1421zdz2yZZ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 16 Jun 2026 10:50:15 +1000 (AEST)
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAAXNdy8nTBq3o7eFA--.35485S2;
	Tue, 16 Jun 2026 08:50:04 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ulf Hansson <ulfh@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	linux-mmc@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] mmc: sdhci-of-aspeed: depopulate slots before disabling clock
Date: Tue, 16 Jun 2026 08:49:53 +0800
Message-ID: <20260616004953.3469-1-pengpeng@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAXNdy8nTBq3o7eFA--.35485S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4DJF15ArWUuw4ftrW7XFb_yoW8GrW7pF
	WxXFW8Kr47GF1rKFW7Ww1Du3W5K3WSyayxtrW5Gws5A3y3JryrKFn3GFyjqF4kAFZ7Aa1f
	XFn8Jay8CFnI9aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbtxhJUUUUU==
X-Originating-IP: [111.196.245.140]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

aspeed_sdc_probe() creates child slot devices one by one after enabling
the controller clock.  If a later slot creation fails, the already-created
slot devices remain registered while the parent probe returns an error.

Depopulate any created slot devices on probe failure and during remove,
before disabling the shared controller clock used by the slots.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index f5d973783cbe..3e941b176687 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -560,12 +560,14 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
 		if (!cpdev) {
 			ret = -ENODEV;
-			goto err_clk;
+			goto err_depopulate;
 		}
 	}
 
 	return 0;
 
+err_depopulate:
+	of_platform_depopulate(&pdev->dev);
 err_clk:
 	clk_disable_unprepare(sdc->clk);
 	return ret;
@@ -575,6 +577,7 @@ static void aspeed_sdc_remove(struct platform_device *pdev)
 {
 	struct aspeed_sdc *sdc = dev_get_drvdata(&pdev->dev);
 
+	of_platform_depopulate(&pdev->dev);
 	clk_disable_unprepare(sdc->clk);
 }
 
-- 
2.50.1 (Apple Git-155)


