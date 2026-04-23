Return-Path: <linux-aspeed+bounces-3953-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EE0FDEE58
	for <linux-aspeed@archiver.kernel.org>; Fri, 24 Apr 2026 01:02:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1vny06pBz2ydQ;
	Fri, 24 Apr 2026 11:02:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776972079;
	cv=none; b=f8tRqFtYNrXgf/6HMm4iStbPcm2qUZ1z71pG4yE5XL3EbTP8oe9M+AGodV0U/l5nu5sIuCLgfyYnYg+EcAUw5gH/xXrOTcSVfJvgFJ+KUwxyAK8fE6bn9LMSukQVmLVHttKGb6SsxzuYOeyRCNJKJbq99F4bPu4y3m9ehfuhLBx2b7ecluXSHnRMEQQ9mFVvgolkz+REran75zzMWxyGywBQ+bgNCnMqw5QNUCSSv7OKBatskfa+H2Err6MhSarh1DFJVGP2Y14Qjl8mRi+/3S4ImwMGzNs/N5gAa52T5eF9la1D0I2N20hpElMIpbeYv69J7ppO2boErKQFwqdtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776972079; c=relaxed/relaxed;
	bh=FD+mnSjT2GzzjnT7c/+m0+ys37kefIgr9Jgnl09Emew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxVwvLIiz9QhAXVQWU5w9+VmUSN2D3Y0Qyxi8PbOgJEE5RcB34CA2D+zEoBQK4+t5DofwFl544Y2GTC0tGKURVD62/us+DCuZtu3UlXFrJcRhI7inx5MwzgTKliUyWNb2tAYhuLPY12k0sZRg+elGsbijFrSpgL7fMOnUCeRmFqaTqmokkbkuPKxk3Bf1U0mlWedYZdJj5YgyZ4lY3ONY7/IaxiCkeb4oXhE0Z0C0q1tt6Wvtsl+FKrtnlUdGz88IDojWRnfp2goT0mkC4Uf2fW28TZtXy6wac2i7J3lqDG+aDLsE1juSJxSKNFTMNlMbDyJ7y/N/h4yl8hbEYfM0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CJ5mWRUT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CJ5mWRUT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1mCy4PQrz2yFm
	for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Apr 2026 05:21:17 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso4979501a91.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Apr 2026 12:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776972076; x=1777576876; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FD+mnSjT2GzzjnT7c/+m0+ys37kefIgr9Jgnl09Emew=;
        b=CJ5mWRUTSTe0vaN2tnq5y4c6xnD0frWE0N20yU8JVSYc3lFcI+mHOs4WSA1ZaStr3H
         1FHIj2jj2rT19JSq6hxOH3e13YQdJu+KRY8pJCmLBKpKqpyiXM/BBot9nXzdvMXvehLi
         FPSRp4H4Usa8jTa/4+qGRf3d9yViiRt17kHw9R8rQDcxqh8Wii1llQBq5rcmPA8Q0c8N
         2Mzw48NuXQDh19eMWRmLhKoHwulqqy9iHx5vRwtRtZJw1WsWM3zdG/Olx/gzMCnKd2la
         55XTDh4cEXgokySd2uRmMCxa1QAELvtVVynjgAm9Q3tpthmmfaNHp+KLHpM3cWZi4apK
         DWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776972076; x=1777576876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD+mnSjT2GzzjnT7c/+m0+ys37kefIgr9Jgnl09Emew=;
        b=QSK0tPk98vVz0B8N8GB2CEgpLDYSB69fZAHN//IOGsOQLsoeeNiciaXNsUzsglrTwB
         VdN7B1a80tovqxiXsvmAR9xALizRMdDKjXnlWYg1xJVfN9HgHzNpJVso8Eu9ykH3wrlh
         IHXqvbviIDGM0HLnwH9vFHTMlWVZThSwPThbJnbImjlvBQ3K0ncri+pTZd5yn/SSlkzJ
         L5MhvDL/y4mBtOHKAM6SCiL+a6vZ4v63DFy9pGhtT93D2F/yi5M9bhyD5ABIlfxFwQc0
         rTB4BTy/A9m8q5UrByJpR8cLEMyfFOR1vuo536xNEzBOmg17vn7qclCSrysJD2+9HU9u
         zpDA==
X-Forwarded-Encrypted: i=1; AFNElJ/YyuoRU7KVD/fv83MBBBMboyoa6a+s6YOHjzuHQ5KKDTRZoHwtQ9zCZMuIJHqBayV5hXXosYtbjRW+AVo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxxBYELSFGcUyRzH1YN6DbLEbj8DpWi1yWk9sAatS4x5i07yKX0
	6TFT6bRyfj+6n3Ao3kXHT96y6/SHZCwixRRTjEzCJ9mdlPeYYmL1zw1b
X-Gm-Gg: AeBDiesLd7vDWdA2U/4mai/LXu4aO2mzwaPUujP5qa7FN7D7RH/iaaJDOyAk6jvo4rr
	JcFroz5jmI1G9MJlP7qInYrFlJcWkIG5ygv6lr0pMJSE4lcdi7ydB2ld8mINJTnhvWJapQ8EJC3
	F3MjD7km/5VoU7IcCkgBniAomJLgcmsqoDPOdAEXRoVWAEGFCLpJNIAaIZ+tzZb6PXJhCArsS/f
	B4b6BkrCLIR7+AsTrpbCPkgWmfsQmzcJllu+cqACvX/h8gEiRj981vyv4cn93ykCJrD+uE0n5kO
	uvvlNjWaoEnQTf71X6tWBba2+k0JObd57Fsy5kCVs8suUIafAOne3NjsYUdhDRJ1oFFqHmMjoaB
	ng72RIOTq79NfaE/KLjnJ1qh4N4CNBXfHIquC3unMPd50fePyhnyXAo7bRadW9jLNSNk2Z/ItIK
	eromdrzn4cZ9TyofCE5pqhdf5SS+dk9Mp+VkOu2SMMT9jF3KRmbtW18UwsD260XCwDXKNJXulEG
	/+obw==
X-Received: by 2002:a17:90b:2892:b0:35e:5ae3:2993 with SMTP id 98e67ed59e1d1-36140462ae6mr27327818a91.15.1776972075908;
        Thu, 23 Apr 2026 12:21:15 -0700 (PDT)
Received: from LAPTOP-97G9G880.bbrouter ([106.51.151.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141898ebasm21101867a91.7.2026.04.23.12.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 12:21:15 -0700 (PDT)
From: root <karthiproffesional@gmail.com>
X-Google-Original-From: root <root@LAPTOP-97G9G880.localdomain>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: jdelvare@suse.de,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Thu, 23 Apr 2026 19:20:45 +0000
Message-ID: <20260423192045.5729-1-root@LAPTOP-97G9G880.localdomain>
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

From: Karthikeyan KS <karthiproffesional@gmail.com>

snoop_file_read() passes the userspace count directly to
kfifo_to_user() without clamping. The kfifo backing buffer is
2048 bytes (SNOOP_FIFO_SIZE), allocated from kmalloc-2k slab.
A read larger than 2048 bytes triggers a BUG under
CONFIG_HARDENED_USERCOPY:

  kernel BUG at mm/usercopy.c:99!

Reproducer:
  hexdump /dev/aspeed-lpc-snoop0

Fix by clamping count to SNOOP_FIFO_SIZE before the copy.

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Cc: stable@vger.kernel.org
Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index b03310c0830d..5b59e826cc68 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -125,6 +125,7 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
        if (ret == -ERESTARTSYS)
            return -EINTR;
    }
+   count = min(count, (size_t)SNOOP_FIFO_SIZE);
    ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
    if (ret)
        return ret;
-- 
2.34.1




