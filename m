Return-Path: <linux-aspeed+bounces-1143-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD03C36017
	for <linux-aspeed@archiver.kernel.org>; Mon, 31 Mar 2025 22:56:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZRRM33C83z2yf5;
	Tue,  1 Apr 2025 09:56:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::643"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743435621;
	cv=none; b=ZPjFiZtlXI1nubP1gkbodKGhraLW5io/eks/wUcnQ0Mme+8lwDnbPoLQa+Pne8ZDxYlZ0AhAhP26h6GOj7TpBNLeOwRx8+Be1O7eEHIWi/b4VXToI+qEhFViI84oAebKvCk+pSDdU4ZEfheeDHLP4THjYJcV/1BkQzfZRqb2PTmuraxfWQxUP3qTz8B3T7FwRvzipoD3Icyf7uKX6K9tKDdZhLbOe83kzzBNP9Wcw+NxI1uHBNw8WI2gkCWetUSOpBLgr8KAHWgOR6eNxP++FoA5LzXK3eyXPXd2Y30t31Z/me/C0T7mokChYjLHEw5nHKiObVHMhUUfOy2vA5qjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743435621; c=relaxed/relaxed;
	bh=XsAGRyWXlsCCSCYWQ6bHWQzVmNAffE9jxkExONXDaSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C1CqRXZt+Bsg3UPHM3fdaNRMkCyKw35g5pXf6qi9JAcoHAS9qd/vOI9KzwOnUm2I60oz7DAKChiFeFhFzQFus6MS54DnO/O2cZvIIuzYCeVAxLilytUtNrlxDNF+BtIoelcYmOF5ZUorEjrCNbQAjLK2wvW/HYUxAwwFIZs6gctvn0I7Obi4huw+f9XKZdBkLexeJ4FevuWo8RXkVTBBro6j1Xy8uJ/GVMogRN4SCYDWPM3f33sjEK/P6ZyL48rAOUVvqvCFRIk6WffVz+QZCcN18Cnbrm8SMJzokJ4jOjUJw3zOSBrCgtOfGVNkl/Irfy5aF1XjGtouWJ0UsMPHyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=O8HLaFdp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=O8HLaFdp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZRFh435qvz2ypV
	for <linux-aspeed@lists.ozlabs.org>; Tue,  1 Apr 2025 02:40:19 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-2264aefc45dso116162855ad.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Mar 2025 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743435617; x=1744040417; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XsAGRyWXlsCCSCYWQ6bHWQzVmNAffE9jxkExONXDaSk=;
        b=O8HLaFdpplrWcLt8miFCYSr1jcNHxitFdPCLgrYs25SvXJ2tCjQDjn/swj3atCOfEx
         ed1U5+hdYGf4i6XDUr5/lvkpQaDs+0CFRYZ0ttUdSQuAPe37aZ4qN1K4DL2Rzf1NvR1v
         5hOIKoEYecG3L+n7enk/sc6ck/ShC3tCmGcQFkpxCKGBhg4233VPZeg/K00b7pKsL91u
         ecQqXZ3THQmjbDHZ4TPK4i99q6jEfb8V7GpzE1aGPUMA33t1nmjmS/VtrMS31EKJPqiJ
         vUyS5+U6SuXQk+GjgjaaQPAcUQab1olhrzcl2CvpE6o8ju2OBSuj5HeOvjMQfVXs3nzL
         rPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743435617; x=1744040417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsAGRyWXlsCCSCYWQ6bHWQzVmNAffE9jxkExONXDaSk=;
        b=fIP4uUnuiOYOYX4KeyRMafmEjTORRij5Jj02JrojvTeltV/A2Pdi3so1wqLAsacTxU
         YcM95pk9qmtasi9LB3H1SWGsK+D4WQe8NRb9YpFnDajrERtEPAu8GA+PwUhdDYEmFakk
         +Xr9p/5PlrdRivdPcAyeMjdHsBCEF2gSuI0ZWKO31ky8jaq93vq/IbjwehwwRJBCY0a5
         GzIddzM7TNBh9g6uUJvG/q+J47AhrCc1n7brEqOCqCQFRA0+K6Qe0ddbkA7GyX9INGTu
         cu16DMLRsOORzvVyVynJxPFXKUmRG53m0YvL+u8S6MrYsh6Qi4Xqxj121yLe+LHoieUb
         5MGw==
X-Forwarded-Encrypted: i=1; AJvYcCVLZxF8ZZIqk25CrE7Ji5yHHpuO7c9yfSg8VGDgdxka3I2V1uofUn+6On0L4R+MH049GN9iO1fYVvvHC18=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzmxqi0dbJhfL2uRoPxAktgCuFavlW6AjjW/Y/ZEoha49qwPu14
	u04oFn0fE5iIYm8KX07eClmyMa+H62XBpaf63M9LgtUtxzW7kwXV
X-Gm-Gg: ASbGncsbau+CrXaqPdg0U7Sk8G17vvpaDnw7JpnWcxIYF4N+RiFPZ9nZPZ3gP8Grj6q
	U6BU5Q9nmUf+2G5PuSdo+sNdf+FST8Sc6O72cLmYO6J0PNokyircJU1Zk6Kaw4axuZVC51wVVfz
	uRzNy1tuWsJlNj9sPYyPLim3w0HEv1MQ06Q90j0g3M2K0FrrTuocabe1MALVMJbIWej99pudtc2
	Lp6hAZgqZiVbGj9LZQ7CYYZdPVUVV/m+1HZnweQmbTQ50qBmvN3p/3Rjaw0WGR5Q+CaC5d5ODqi
	Yjx3wrE7gBT0mFVHuXGPkrHjrZqHQVdmyCpQlEcTXKcVczFJ95IB3UC9SpOf4qTY+2xO1i8=
X-Google-Smtp-Source: AGHT+IHSO1Ey1kpUT8XPplPoBZfv20w+evu2v0hemvn7yrxYUmFkPgnracA41hSVN0cDgqnpaIbOJg==
X-Received: by 2002:a17:903:1a05:b0:223:619e:71da with SMTP id d9443c01a7336-2292fa1acb2mr167510495ad.49.1743435616821;
        Mon, 31 Mar 2025 08:40:16 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2293648e525sm44573135ad.32.2025.03.31.08.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:40:16 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: joel@jms.id.au
Cc: andrew@codeconstruct.com.au,
	bsdhenrymartin@gmail.com,
	gsomlo@gmail.com,
	arnd@arndb.de,
	u.kleine-koenig@baylibre.com,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] drivers/misc: Add NULL check in aspeed_lpc_enable_snoop
Date: Mon, 31 Mar 2025 23:40:02 +0800
Message-Id: <20250331154002.14128-1-bsdhenrymartin@gmail.com>
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

devm_kasprintf() returns NULL if memory allocation fails. Currently,
aspeed_lpc_enable_snoop() does not check for this case, leading to a NULL
pointer dereference.

The corrected code adds error checking and optimizes resource release logic
to ensure no memory or kernel resources are leaked in case of failure.

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V2 -> V3: The enhanced code introduces proper error handling and
improves resource cleanup mechanisms to prevent memory or kernel
resource leaks during failure scenarios.
V1 -> V2: Removed blank line between tags.

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 9ab5ba9cf1d6..b79365a34baa 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -200,11 +200,16 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
 	lpc_snoop->chan[channel].miscdev.name =
 		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+	if (!lpc_snoop->chan[channel].miscdev.name) {
+		rc = -ENOMEM;
+		goto err_free_fifo;
+	}
+
 	lpc_snoop->chan[channel].miscdev.fops = &snoop_fops;
 	lpc_snoop->chan[channel].miscdev.parent = dev;
 	rc = misc_register(&lpc_snoop->chan[channel].miscdev);
 	if (rc)
-		return rc;
+		goto err_free_fifo;
 
 	/* Enable LPC snoop channel at requested port */
 	switch (channel) {
@@ -221,7 +226,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		hicrb_en = HICRB_ENSNP1D;
 		break;
 	default:
-		return -EINVAL;
+		rc = -EINVAL;
+		goto err_misc_deregister;
 	}
 
 	regmap_update_bits(lpc_snoop->regmap, HICR5, hicr5_en, hicr5_en);
@@ -232,6 +238,12 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				hicrb_en, hicrb_en);
 
 	return rc;
+
+err_misc_deregister:
+	misc_deregister(&lpc_snoop->chan[channel].miscdev);
+err_free_fifo:
+	kfifo_free(&lpc_snoop->chan[channel].fifo);
+	return rc;
 }
 
 static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
-- 
2.34.1


