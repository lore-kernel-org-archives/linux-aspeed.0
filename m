Return-Path: <linux-aspeed+bounces-188-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928AAE77187
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 04:26:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y7zts0GF5z30Sy;
	Thu, 12 Dec 2024 15:26:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733888961;
	cv=none; b=Bf+OfWivzgJlNOp3P9PTe7qgUyIculiLoAnqYmmpMPldDQrlZOicp1bjwTjm2HQxagqwbb3rczdE8BW6Po2qLyRODOShCAXcojYnGg7koOnAwSiM/VNtI/gbREQxQYfcOBMN7H+Em2Fa2g6rCBO23paC6Pdds8astP1ZlAhaa2i+V3Znsh7hjquRiTBU4KWzITfRyReHQqUSuaq4sHOXWvHGx3JirbkZ6f5wZNxs1VvYcnsW6Z25P+AV0a/9xudakYaKsvRhv/vODjvw6SHDrAL7S/wrMGGiK+yAWPiYMQPzVxEkTmOdvJ4k7M8pLZ1UIiJxizyEIVAOAmhxhsB+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733888961; c=relaxed/relaxed;
	bh=F5SQ9JD2m8PwX2AyXJonB6lYI/RXq35sHgQ7Uk77VOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jtiB5GqN5co1KaBD3TIm8i6KNi78bMjfnZbb+SjJMXHIOXwVeFcDsGLcJJiASzp6s8JmSKxS/RSpzBHMlg6js0uMlxkU6Edv3Tl8UJsQ6Q/Mmo3qpecVXvx8T9MTEPTUcqvdDzmO2bECWX490hGd2D99CH4FanVcTfhjmUnVq1H3A76h+6+pxa9mnDGKK5OwJjExVjqqHxhs0fcmMWyGntBJC4UFA+vgV6Xf113ywA95NzNrfrEsY2l96k5PKH3QfUEjrYa7k4gknW+VL389cTQCebNRT6RFQHEOGp3PBiVTAfqUbOtQ/TYmOyAMgGGdOluLJobhk0UF0Ob4uDjUYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key; unprotected) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=CQQJitxM; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=joe@pf.is.s.u-tokyo.ac.jp; receiver=lists.ozlabs.org) smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=CQQJitxM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=pf.is.s.u-tokyo.ac.jp (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=joe@pf.is.s.u-tokyo.ac.jp; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y7M6Q6gNkz305P
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Dec 2024 14:49:16 +1100 (AEDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-728eedfca37so199374b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Dec 2024 19:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1733888954; x=1734493754; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F5SQ9JD2m8PwX2AyXJonB6lYI/RXq35sHgQ7Uk77VOQ=;
        b=CQQJitxMPQjpwXC/JqSAT7jZG8N9WSx+DF+URqiUFPRAI6XRkbjb1964yRCU3cIW00
         rEWcte269XGHECodzM+NhkOk9/8ytzk9BBMy1/xVjQE1haXiulIVUthuEMdQC9gl3LDo
         SZlURFA2AGJhgi7caQajvRCeJLSBSIDgLxVLjS8ywDCN3r5+diu60VMbvCtxJzyhl/IH
         9OeSublr4XQBTaHKEBMRel35s+85X1e9TnP+vBdMIN98nu1UF1rXLMHUr0Sn5D7iQY+n
         h2FQ4OTZj8AaS8d2z36OfFwVA/Exjg/SYsihX0wYhjmVi/gBxGJjzIcn/I/nUzTBdtzI
         e53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733888954; x=1734493754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5SQ9JD2m8PwX2AyXJonB6lYI/RXq35sHgQ7Uk77VOQ=;
        b=dXrUYiK2KOrQAUFh7h++TK4Etk7mu9QU+yz9Y/GnHQ3z2WxlpuBJl30DVxOuPI+F9N
         eLF91+TFjUkmwVGm+iskWL2aT8BX6yuhPMksL+ZeS4jaC3rmPly1HQZnFVjwL1/ET/l6
         rssIrHQW49W6GCnnkWPCVgBZEf4Yq2udrbUQMLERFFdgmp4fdqR2N/WznkE4TWZ0gPqs
         jaz9pxXUeiEXrEcd6nLqs2efP0nLxWVEX1OX1X0urEJjXXHePrBL9MyeSEEI4gOE+Nid
         BNoEPznJbX809P6T27uR4foFRnKuxcgfTr92HY3mhu1H9x5rQxbeqaneR3xhueNCjmHV
         ggGg==
X-Gm-Message-State: AOJu0YwoB3RmzvHgmPsQQ3y+/UJ9+TkJLv43CPzIBYgKiHIdwWKu2BiO
	OUoWrfReEVnXEMpcfJbRYn3zS4xE738SolIoR50q/1v4sCL65FXZPrBcBVEPjRY=
X-Gm-Gg: ASbGncuKbtuA85oMqb2JtWpoVsUGZ2MIt6kCO3ao/IVeI6ktiV2Ju4uTfcYNJSvicKn
	wzLTfzYrFjdO1Ls4t/Pb5QmLIugS2C41TyLdjNXEegE2OXpXsKFge5sJFhIn6lsFcTxABaT/5Zo
	QNRnrAMloRh6pAcFGLCt5Zm7O2dRFPTt6GBrWsFGHUx13xmg8lXa6DqDzy9mZBSjUq45fRG0kJY
	BtaQCT7Jrm+Wus6iTnZtOpRFU69sMY/v2van4D+ib3UzDwipSnE01HGY2QhbK/hRF6D6b0F2B4l
	27jgwuRfy7jBfeFNNbJDwaDpKFsjEdoz77hCl2Gv
X-Google-Smtp-Source: AGHT+IE5r05cswO2zejERKPHmzWQjUNg3n5OzpNASVNgcxLvtTCenFYT7AMzaOgerO1VqXvFK/yW+A==
X-Received: by 2002:a05:6a20:841d:b0:1e1:9ba5:80d8 with SMTP id adf61e73a8af0-1e1c1360eacmr2924632637.33.1733888953561;
        Tue, 10 Dec 2024 19:49:13 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd50e37084sm3283675a12.76.2024.12.10.19.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 19:49:13 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: linux-aspeed@lists.ozlabs.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v2] soc: aspeed: move switch statements before resource allocation and free kfifo on error
Date: Wed, 11 Dec 2024 12:49:08 +0900
Message-Id: <20241211034908.228734-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The switch statement in aspeed_lpc_enable_snoop() only depends on the
function argument channel, thus move it prior to any resource
acquisition. Also free the kfifo when misc_register() fails.

Fixes: 524feb799408 ("soc: add aspeed folder and misc drivers")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in V2:
- Move the switch statement before any resource allocation happens.
- Free the kfifo before returning an error.
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 34 ++++++++++++++-------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 9ab5ba9cf1d6..de308bc789ed 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -190,22 +190,6 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	const struct aspeed_lpc_snoop_model_data *model_data =
 		of_device_get_match_data(dev);
 
-	init_waitqueue_head(&lpc_snoop->chan[channel].wq);
-	/* Create FIFO datastructure */
-	rc = kfifo_alloc(&lpc_snoop->chan[channel].fifo,
-			 SNOOP_FIFO_SIZE, GFP_KERNEL);
-	if (rc)
-		return rc;
-
-	lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
-	lpc_snoop->chan[channel].miscdev.name =
-		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
-	lpc_snoop->chan[channel].miscdev.fops = &snoop_fops;
-	lpc_snoop->chan[channel].miscdev.parent = dev;
-	rc = misc_register(&lpc_snoop->chan[channel].miscdev);
-	if (rc)
-		return rc;
-
 	/* Enable LPC snoop channel at requested port */
 	switch (channel) {
 	case 0:
@@ -224,6 +208,24 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		return -EINVAL;
 	}
 
+	init_waitqueue_head(&lpc_snoop->chan[channel].wq);
+	/* Create FIFO datastructure */
+	rc = kfifo_alloc(&lpc_snoop->chan[channel].fifo,
+			 SNOOP_FIFO_SIZE, GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
+	lpc_snoop->chan[channel].miscdev.name =
+		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+	lpc_snoop->chan[channel].miscdev.fops = &snoop_fops;
+	lpc_snoop->chan[channel].miscdev.parent = dev;
+	rc = misc_register(&lpc_snoop->chan[channel].miscdev);
+	if (rc) {
+		kfifo_free(&lpc_snoop->chan[channel].fifo);
+		return rc;
+	}
+
 	regmap_update_bits(lpc_snoop->regmap, HICR5, hicr5_en, hicr5_en);
 	regmap_update_bits(lpc_snoop->regmap, SNPWADR, snpwadr_mask,
 			   lpc_port << snpwadr_shift);
-- 
2.34.1


