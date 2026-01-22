Return-Path: <linux-aspeed+bounces-3419-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37684C44500
	for <linux-aspeed@archiver.kernel.org>; Thu, 22 Jan 2026 08:40:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxZJN5LkLz2yFm;
	Thu, 22 Jan 2026 19:40:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769071220;
	cv=none; b=nfXjK6mIUiqx0wKjx7g7qS64HrSbvxuc9M0o7fAjguDrXP0D7LBoM+13oiQYUTbp9ZbOcCGWv0TrgxdwSQ8f65s21bU3KQ4FuLbVr5mtf4zXa2K+jcotcOtH2z0hngPvZVRn1L4eMlbo6eK/wgLfJJUqge/tSro8u+JmGnSA8Y7ekqawRyd1zThEpRyDTh6TxfVC5hbMQAOf9scCxFOmA99GeNEV2EFptrzmi/Of2y6IQxADbTRjQE80cPNNtuOMx9hiT/QpKrD79ReXHfXPvbFLsh2wnmMNDeD8IXpdIAQWnX3Dq9zCBkjs6WCY6Qvjde7Zv8s+SLtSiodxaMvq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769071220; c=relaxed/relaxed;
	bh=hpMnG7yo/s/EPaRILMIXawP8xxRqeEWUw6ffTIMdA+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZRMR4e29lgimCJFG3KGmj9eT6qH3nh5L07p6pJT9gk5UlWpQGBLCmB2/su9uoROEfylgrdLpRXFLd7wisdqPyRWVdXEAkW5Dye3f/wCq4RBy0a61WcKkbbPthLVn42x9EHCHCGRbnnFWcretiEX8pYuWasFilIvEa6cVC71hee0rWRX+gm8yvh2rYKYER+E6Sqlhl03gP30ZaNc/xdg3yBKArplMWeafTwTm28OguQdlkkVQLwEVev+hJ39/D0oypj4jl5qy5HtsvVgK5oKLe7wy333EjUD3sBUmS+xU/ksSf6771Kb7U3TH3PvppvVpx/YfnG3XVYwj+ksTK2a33Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=A4WnzsDi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=A4WnzsDi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxZJM2yH5z2xS5
	for <linux-aspeed@lists.ozlabs.org>; Thu, 22 Jan 2026 19:40:18 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2a09757004cso6571545ad.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 22 Jan 2026 00:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769071215; x=1769676015; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpMnG7yo/s/EPaRILMIXawP8xxRqeEWUw6ffTIMdA+E=;
        b=A4WnzsDiQnNoB107i72CQ+nezFNoClZESS28gOVSoXqtCagLQcci1abW0J7TvlgxFi
         RYUthWWnVzFir+aERxggKdjbkGmrVbZcl7ZT99YqqqfeFJELxFcnCxemRrle835OwCqr
         WrWwn5M42WMuuJfprMp9kjTp7dhg8AhwcYynfV8uKCtuTf55hx+Mvzpv7N+icqYP8z1L
         NexikkargduRwUJdJ+uB43t2hwm3EAoHkpqvJ+uQ5PgeA7y4x9a5lD7Je2tuwF8j/Rpt
         U28AVd21BD8i+z7gv4f8eIvUViSuUQm6/hmOfgonpNtGGMRItxU67rDAdUEq7Dq8kMpz
         cgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769071215; x=1769676015;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpMnG7yo/s/EPaRILMIXawP8xxRqeEWUw6ffTIMdA+E=;
        b=hdJEkF8RTmbcBFJmP/pDxeol1afHgT/+bLtqkEaP6KCC7e0e/CyaGK0X+2v0cLgvjV
         PPv0CAKLxKgKSr+tuXorQKGA18CKE/V5xV79ppNulPdJvIjie1tIvsUQjX962ljGg9xN
         0YyyNZFNR6ZSr6mWWCyNDpveEkNgxRWJDELutvakEetpglQyYSHXeFNbRDXYxuRFHs/g
         Ex1FryDrlLWtCObXFSIbUXb5Chj1ZhRoHwzXekfWXJzjDeqkd+IqC3IB5LqoTOHUw6Mp
         AsS91V09Az8BLEkuKxTYiWoK3WdufFXpNH2hty2PGdnOgD2/7FCns13okLG3CjPJscW/
         T+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXxBn76Sod39MSZmZ8Ke/yfZnrgIAPTy5nr7j+W6eNYthXBn644l7AOSd3qgyW2ac27SgfolGhXY7Y3Bw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx+83dmATBtcp8/mtB/0QDnXlWml86cqkAEpRm6ixoxLyBozlz8
	qLNFoj6Wvqs6+N+s8ZkzGq/bpbwLQvV6A6HNxdhzSEkK6Opj+fecCocj
X-Gm-Gg: AZuq6aKxJSek0sUGOtUIZJ0pqXzoA/6zza5kk9cIPa4qf0ROlPfKW6miG8x+NuBvvFA
	nHgQPEFM/5s6wLvkTH1kxkelT35Dt/7wOP6Z7Ybq5zwXXaD9PZ4I68TLaxvgJ2jhmePmyz9JOsz
	ahkQEvmfN1eZawF/GHj7vnnHe7m9aAh3ZKu2iQBGYfRPitxbpBhm8WRlS53cQS4vBdoe7mHpgFF
	Lq6iVS81eQRHiFrMj8UgSFQmsvdenAxLD3Aj0RYRmzfPDM6FHVXpNliJPiN4TggtOsnCXm+Od7a
	OsfH+5o1wZRUyMj2sz8WQHGOuDPweqL0YHyIl3eo0frCSIYVg09pLetLEjKbBlBdgucvHo/x7Ee
	0Md1mySOK5wE2O/6ZdjHTQOyt2F/jmLbI20xx1bV7V05g75GD7tPeAziGisjzLDi2Wn9uhMvTit
	j42dWaTfPPcUY/K591cZOMUDa3C2YszKRMYqexCkY9gGSBDX5V5eq7H1G4a8/KHRY=
X-Received: by 2002:a17:903:2b04:b0:2a0:c1fc:3de5 with SMTP id d9443c01a7336-2a7176c5798mr159612595ad.51.1769071215454;
        Thu, 22 Jan 2026 00:40:15 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7b03945c7sm38423085ad.102.2026.01.22.00.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 00:40:15 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 22 Jan 2026 16:37:56 +0800
Subject: [PATCH] soc: aspeed: soninfo: mask table entries for accurate SoC
 ID matching
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
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-soc_aspeed_name_fix-v1-1-33a847f2581c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOThcWkC/x2MQQqAIBAAvyJ7TsglIvpKhCy61R4ycSEC6e9Jx
 xmYqaBchBVmU6HwLSpXauA6A+GgtLOV2Biwx7F3iFav4Ekzc/SJTvabPJbGIWxEGKchQCtz4ab
 /67K+7wevLlqeZQAAAA==
To: Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Patrick Williams <patrick@stwcx.xyz>, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769071213; l=1296;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=NcA+4V/eKoD7laEnrtITGzEvL6h6C7wMkK//E+tf3IU=;
 b=rLkSU4ZR7LLrHUbxt3uEiBVvpobZHIDelmOZTOc6BulV862CLv2zf2tyIwEKQpsl0CCu7vUkh
 pdED0LZMfZGCPrqpPmWs9sJdqSz+cplTG8ilFHqfaN5x1F2PlHwB6nJ
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

The siliconid_to_name function currently masks the input silicon ID with
0xff00ffff, but compares it against unmasked table entries. This causes
matching to fail if the table entries contain non-zero values in the
bits covered by the mask (bits 16-23).

Update the logic to apply the 0xff00ffff mask to the table entries
during comparison. This ensures that only the relevant model and
revision bits are considered, providing a consistent match across
different manufacturing batches.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 drivers/soc/aspeed/aspeed-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 67e9ac3d08ec..a90b100f4d10 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -39,7 +39,7 @@ static const char *siliconid_to_name(u32 siliconid)
 	unsigned int i;
 
 	for (i = 0 ; i < ARRAY_SIZE(rev_table) ; ++i) {
-		if (rev_table[i].id == id)
+		if ((rev_table[i].id & 0xff00ffff) == id)
 			return rev_table[i].name;
 	}
 

---
base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
change-id: 20260122-soc_aspeed_name_fix-a64cfaa2d84c

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


