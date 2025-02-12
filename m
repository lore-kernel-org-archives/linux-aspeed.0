Return-Path: <linux-aspeed+bounces-703-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F80C021A0
	for <linux-aspeed@archiver.kernel.org>; Wed, 12 Feb 2025 23:16:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtZ1p74Njz2yK7;
	Thu, 13 Feb 2025 10:16:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739395583;
	cv=none; b=bA0hRp2F7vsEWCbUe66DGqvQxkQwNxfukTfxZPbAgt0vScStCCfB8tnZN/aXFwICOgJpPv8m/2dM0ZuPv31N2qo9IzUL8zMYcLgax6Va6F19hTxWoaMiLuQz9+NlZseqUj3xcLoeR5+bbmKHIZslK2WrF9VPWE7NL3BH57mSWHseJirnO7QQfG3aKUlQJhjBeW/2mpMxKefiuTibC2nrRsH0Cllschr1B3trVhyag3lhk0WFoMchrPV5ZHPhdAM7Fih6+02noVQXza/FtEuXJORkYXAcXKLJxMfVm5bgxr8EOWox3HgzZALBgiWCn2SYEHH9Dp+YW6S8Gffa8tjq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739395583; c=relaxed/relaxed;
	bh=RKVnOyx1/VLC5hIczSELZnSDd/twEbt35BMvF5Yzcpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gk5PDWg/rQFwuPxOGM7Rk6aHNgj73cb6UxDqmLfk6gYlZEOPdSDV2r0gGlSaOFAAjjXaqynnr8duKmcwQoBlPbuKl8dcVNyGxzkTdPr+eHSDGaZNOMagORnwwmDnrcZlr5kjfVxVEXt0cBJ7cHk22BXLVxAgu5rXY5lm7Q9TVu/kho1AoagrYfLMHnwmxiL2thhRlEKN0H+CzTquijfI1P8srrDSR/DJv1bw/SBjh3Y9z+F7ZgfJaPoDbOiyTZkwQBfwJjPdn46bORIDJANhZg3igMd+zWpCxyOLmbW3UO0IE22wPqsnb7ct5mo13ObuP3QyfZ0NCIpvnITfq5soHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MByuZ7Bp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72d; helo=mail-qk1-x72d.google.com; envelope-from=chenyuan0y@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MByuZ7Bp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72d; helo=mail-qk1-x72d.google.com; envelope-from=chenyuan0y@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtWb13V3Sz2xps
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Feb 2025 08:26:20 +1100 (AEDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7c07b2110cbso548785a.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 12 Feb 2025 13:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739395577; x=1740000377; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKVnOyx1/VLC5hIczSELZnSDd/twEbt35BMvF5Yzcpg=;
        b=MByuZ7BpPqRocTd+F9DPOvs6pK0WIUcjRnyrZBWusPvG7cYtn3faRFgSlH0QX+AdCv
         TrRVJxeSKQ9FXqhTilGNNbQLyNYOqKYkd7TtTEcSqBXaSYYD/ber8uDg45WvY5I4HfCM
         TQyefmP+yRYbCT6qFnoRZSjJPnaAvns2qZ9YopMX8Bvh8W2UjOvBWj6KgL98Bq54cqC3
         Q0xBhAqGii3eiZM4PbA4mOdcaWeD6LZpIrITFsdQwAyqbPqoLNTLishNQmmMu3IojtXw
         Gd6L/rKO9KWI04lXIBQX6Us6aZbepFEhs0jD8HHxviFL/HeEBJChj/t5E4Rux/PfhcSe
         jNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739395577; x=1740000377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKVnOyx1/VLC5hIczSELZnSDd/twEbt35BMvF5Yzcpg=;
        b=bNHQysDaLBL3k/s6/BFmL9JHyaBE99RtQlZjg1NPVPP8EzZcx7x6JCD1Ew0iTgXSEZ
         Kdc1rO3mGOWdzVMR2RFp0mTbsZ1SeaNn3LbTjgv2UEoUzfSgi+/y/1UEaclGYP7vDpev
         BURuXQVSeVXIpDDeFN7PmTAGpQpsSI2FDF8oS5OLZWe5xGx82qy/wqasR9gTX/jQymNM
         L9j1UfFFY3bF1fjv4XH3Kwyuitf29tWvK8Hlh3aLb4943VN3raGUZ4exFuzb7Vjf9XKP
         efXoeC0NQ0zIlicvGMW3UX5kRbQazHinmg8A8ClOB4gg7fDWr0KODr3w1oDXoXhbn4cz
         M2EA==
X-Forwarded-Encrypted: i=1; AJvYcCVG8qh3CFqVlwUNDjbJqwYIsffgxLba1LK5q7cRlV4DE8zWhVNWnEVMUC7OSEMjIjo9DZYLfxV80uzgj5k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyfX7OPlOv6J7eJAVQx3sGPFfeVdD4JrLuXg9wr02AnUF1t7dB9
	jnJVYUeIywp82i8Md1PoKSxDNY2PzMGBt6mDLVWmmL0a7WScWqM=
X-Gm-Gg: ASbGncspCFH4dOFbSY/UgAQ+MAUeBbh488s+yWOlSTGvP6qFLzhTLdF3fN11Excf0GV
	zfs+NMA9OfBRbW3om8h+fl+98E/vv5iDrZazT390e08mPBMZ7qQlpUYgGwiNOPqBxc3ciKUg3XL
	yQJgg0btTx0lAJTxXz6MJm6cB/xbxYXdUnJKiV5W30PlwXXGhU1CIWiZEhs3NRJueZe/BZagoUL
	W2v/A2+tp0wYvuz7KaMEx2xK0mD88HdypAcA4la/HYg86M9Sa8BEfE+VWFqqHJgzwNbPUschPMO
	An51OrHuiJpm
X-Google-Smtp-Source: AGHT+IGd1Y0JnSACVaZOKyKB72nc3A5B1D1EcMp52cuNwxHCQGYLp7nvFvXTV7+ixgZOYHfw/YEdvw==
X-Received: by 2002:a05:620a:1926:b0:7be:3d02:b5e2 with SMTP id af79cd13be357-7c06fe307c4mr265815385a.6.1739395577321;
        Wed, 12 Feb 2025 13:26:17 -0800 (PST)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0728eb208sm148719985a.99.2025.02.12.13.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 13:26:16 -0800 (PST)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	richardcochran@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] soc: aspeed: Add NULL pointer check in aspeed_lpc_enable_snoop()
Date: Wed, 12 Feb 2025 15:25:56 -0600
Message-Id: <20250212212556.2667-1-chenyuan0y@gmail.com>
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

lpc_snoop->chan[channel].miscdev.name could be NULL, thus,
a pointer check is added to prevent potential NULL pointer dereference.
This is similar to the fix in commit 3027e7b15b02
("ice: Fix some null pointer dereference issues in ice_ptp.c").

This issue is found by our static analysis tool.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 9ab5ba9cf1d6..376b3a910797 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -200,6 +200,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
 	lpc_snoop->chan[channel].miscdev.name =
 		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+	if (!lpc_snoop->chan[channel].miscdev.name)
+		return -ENOMEM;
 	lpc_snoop->chan[channel].miscdev.fops = &snoop_fops;
 	lpc_snoop->chan[channel].miscdev.parent = dev;
 	rc = misc_register(&lpc_snoop->chan[channel].miscdev);
-- 
2.34.1


