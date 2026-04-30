Return-Path: <linux-aspeed+bounces-3993-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E13CD13DE
	for <linux-aspeed@archiver.kernel.org>; Fri,  1 May 2026 00:02:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6B6l5gwTz2xll;
	Fri, 01 May 2026 10:02:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777585500;
	cv=none; b=BzzD7ewmuQcuxK36t3Glt43d9+rxgmQ7pSRNxVXjbUqnnnNwe3tf1DjJKnHShTzCUrLlJQK/3EpQu7WEPfpp5v7TX0/b80ucVeog2hvtyi4UrqdT8ok/+92jNYReXARfHS2yWMWS/4Khqz9nV1hT60+2YcjvJWnq/gutizySmPl8VA7Qy+5YYWlbVT4aj9Hc7y8GXYYKvFAurPxIZdXjc+7l7g4ySuouIZ+7/ol0SGQc7Wnlo2n/nzk9s2l1q0/GU9EWsMXKhmyj1qWRFut2fiX8rt88+N2LNVBIbhoHJfKEu1hWytRhzdgLJOxSdQbeNwRc2162gUZYHRojCXFW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777585500; c=relaxed/relaxed;
	bh=bQCwDq3sQ26sd63X6ePOXo1fZCw68NQUIbjTHLE+tbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lK0yvwsQJiu/6BbyJqQWXiqgXk+DCdsW+9ghifnU2mF7r/VqDtMw2T9ZI3Yb9iY+73x0S0ifDrwN3l/x9MleYCpDuFF3jNcfKP6ZLbDAJ2Qjfiike+1qgOreIGv3QDTUssD5IaIj4cbUiUrLIpZ+oTkEWIMdPoo6KCdPuS1u7HOn/VISZcv5jmpf0rAUp9NwPq04wL2b6b5W9u52G8OOSylNNMGRSbBMFgWGtCQ7AEtEJCpIrFXbmmTYLI4QkNx9yKfkficD4ADYEN1qlAuvvSWem5mNxYDsvPNvzq/xuhjCfymtMyjJpmGCEmclgP8OJAZ7EEycMggpA0LAB0YBjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gapp.nthu.edu.tw; dkim=pass (2048-bit key; unprotected) header.d=gapp-nthu-edu-tw.20251104.gappssmtp.com header.i=@gapp-nthu-edu-tw.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=LFkNyQrv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=ku.loong@gapp.nthu.edu.tw; receiver=lists.ozlabs.org) smtp.mailfrom=gapp.nthu.edu.tw
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gapp.nthu.edu.tw
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gapp-nthu-edu-tw.20251104.gappssmtp.com header.i=@gapp-nthu-edu-tw.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=LFkNyQrv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gapp.nthu.edu.tw (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=ku.loong@gapp.nthu.edu.tw; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g674T5ztRz2xlL
	for <linux-aspeed@lists.ozlabs.org>; Fri, 01 May 2026 07:44:56 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-82faf871346so907194b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Apr 2026 14:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gapp-nthu-edu-tw.20251104.gappssmtp.com; s=20251104; t=1777585493; x=1778190293; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bQCwDq3sQ26sd63X6ePOXo1fZCw68NQUIbjTHLE+tbU=;
        b=LFkNyQrvLZBkcoiVEdbEpLSa4hjWfcyUkhiYCnZLWA7EqV7zLbeQ6dInPsP8oCEYY7
         htg07OoZYMyLmgaGQDU/VOx2LJRZ5A9a6e7MMQ7rcDOEeopGu9Abbny5sck1v90brZeE
         GPiylfvzZffIJ6UGqq8D6NVLcuMKOrpitGz04qD1LVpBapXP20ISjxmEzclUleZqgNQ5
         2xjYkMzPLZcI2jmpc/HhLZdIkSXyqRKOiZBQOvC5wJzxRpxHkT2lCENuNuVFeJ9uNaMl
         QxhAQedcX0jRBXgiajqov94fklTpkl9MPwSZ5OKaAOVCML92bWc2M5Cplv3PnRbx01jP
         z7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777585493; x=1778190293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQCwDq3sQ26sd63X6ePOXo1fZCw68NQUIbjTHLE+tbU=;
        b=kU0TToCHe4yuukXTDwUJlB5rLq4vRh1SROY6boTwd8kC7Mx5TL8P4UP9b5tLEVsQL6
         HbmtmwviNksMRAgFFbU/J6A6Exatv2u8j0++Ad7qZsjKb9IxxYGGFTIdsxEhLawgnbVp
         lpEJ5+Aqn6ilOHW+MjrkKKoo/S5FNmI0xUwBwIcld5Z+7KH/TbPaCUzYzYpYdae84xSe
         r8Kq8Ki0f+WCWeM3b2A+7WsTcbg5HvffWKDoe4mp01aUVj5zlxFWe7JEb4DvdXp8QmR0
         WrPu2zug9wfl9M5J7FCy5ja7j+HPQbJhPxB8lXpm/jjKQGNDSfGG21seBQ0p+Yo3oQbQ
         b8zg==
X-Forwarded-Encrypted: i=1; AFNElJ8RC2f4bUcB49fqnXQrIYzkhlKI92eduy78we2+l+T12CKrShmcutOTgoSWCPmpP3WvSJyc8xUqtLSRXAY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YydwLDvYfRtEuMI1ku2gSbflmBtN3o43Z55u8InRbxuGOSX/ZZe
	YV4VUXf0t+cbRmOAl4GYdSNVziJehZGCHRaz43vD27EAu4Zr2vS3Ui0Yneg35oZXw50=
X-Gm-Gg: AeBDiesoAn6NXtoINacl3o/8FxIv7HboH65L2rQkGi4DX+N297yQiXuw5HeZk/THBvY
	fl8QDrCutF6gYHYJAmaKJQu8dB+RoPL9Ni4BNh0PYBsN3xVjCCAEgDhhWZGCjtJTaQFBGk9Ip9P
	huaXJa1Ybf48a9Afta7TBz0nl8YHEAK/y4mGdhU0o1Sp6sF4YH+IkCAJUNcQl6cnmaZolCyiDh1
	uzevEAGLjlCynr46MBkdjqIXBjY9M5+2sa8WRade+gjAH0N9u6H1NRikgyS2Ai8IEEIim1tBXuT
	OlM2DIg2UUyGroYexAnsH/SktkfgrD2YenPla+mFUGblz4zWywhbhaNFZGIIXM1ga5AHJw4lxX1
	lOboVfzSimPOwYDJOPDOfOlJImFd8jWiGe6VkBIToLsxsX/LXp7eUTKAzPtEba2ONo5kuhReiI0
	AKL2lFGWGqfkQ/5QnVzvi3wxbpovzHF012N9sEJvl7CtA4piW7EIJlF8RFZxcYtZIJ8mTQAeV9s
	1aDvT7P4notlSMsk3olgfoQxPy/p+exIyaGzm0Q534ckyXFj2K+ULku5A1OV71XVTk+D3mGXx4=
X-Received: by 2002:a05:6a00:3e02:b0:82f:8a29:e3e0 with SMTP id d2e1a72fcca58-834fdc670d2mr5521973b3a.42.1777585492724;
        Thu, 30 Apr 2026 14:44:52 -0700 (PDT)
Received: from tomato-cultivator-HP-ZBook-15-G6.. (2001-b400-e3d4-7301-ab51-ca4d-694a-59f2.emome-ip6.hinet.net. [2001:b400:e3d4:7301:ab51:ca4d:694a:59f2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b864c7sm640774b3a.59.2026.04.30.14.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:44:52 -0700 (PDT)
From: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
To: eajames@linux.ibm.com,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: ninad@linux.ibm.com,
	linux-fsi@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
Subject: [PATCH] fsi: aspeed: convert cfam_reset to DEVICE_ATTR_WO()
Date: Fri,  1 May 2026 05:43:27 +0800
Message-ID: <20260430214327.17099-1-ku.loong@gapp.nthu.edu.tw>
X-Mailer: git-send-email 2.43.0
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

Replace manual DEVICE_ATTR() definition with DEVICE_ATTR_WO()
for the write-only cfam_reset attribute.

No functional change.

Signed-off-by: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
---
 drivers/fsi/fsi-master-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index aa1380cdff33..3b4a0e821c08 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -462,7 +462,7 @@ static ssize_t cfam_reset_store(struct device *dev, struct device_attribute *att
 	return count;
 }
 
-static DEVICE_ATTR(cfam_reset, 0200, NULL, cfam_reset_store);
+static DEVICE_ATTR_WO(cfam_reset);
 
 static int setup_cfam_reset(struct fsi_master_aspeed *aspeed)
 {
-- 
2.43.0


