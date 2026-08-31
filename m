Return-Path: <linux-aspeed+bounces-4891-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3022FC61DFD
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 00:04:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYmM2306Nz2y2S;
	Tue, 01 Sep 2026 10:04:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788184066;
	cv=none; b=E2lnu+a5Ah1UFV3t2IYEr4gvsAX9Xtjor3iwENT7oREMdq2gDF596Rhx60tbZ20tGSym2SsqHbgJGJGIuUfcRClUjKeAYYBwBfvkfep7HD/KZSmznMMhSk3OK2YVwuvtZmVom3kBvkxawjFVH6AtofNnO0HIDiTHJvy7cKqh+gbepB92AvT4VGI/PDjzXAz5mTgFdvQHDhGylzsh7CSE68XEYh8u3l+Ny8288xW8lyqcgPHGzv64EPh4x/xBp/mc9mu0NdQxaRfigg/EDfSeTKSiBaVTWKxE6iMd4Md4k4XqIEzRcOdndXECFsZvTpPudLmHE/uC5eM1YdAQz8cOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788184066; c=relaxed/relaxed;
	bh=EZphEP1aVBZVI+sCUTh5FGIjIPbG+M3yCoLuytV4vxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FPdFyfkGnnN27iVhvVXUFrmuqTRZlp4ahR96bVRGVbGJ6L+Z4bvOTuMdJaLd/lkh731O2ESSYfB8nQBwOAIEI5jDNBBo3C1FMDrc7w0KBZWou4cKdfD4FzU5JgsctjEFshYJkZIyKnyUJkn1zRgaxjjYoQqLr7g/57ZZqHQCuKEzybxTT/VFEodMYC3M7wS/kv6+L4KyU/1pBf9b4TY7STGonOiHfaTEfa7d+HXzOp2WS2weujS0hcCbL5lrwLjsIlbt1jtIoOFgAjz+CWCibkgeOfsJpFkq2CAqik+MVxER5QlM3mJg9ORfn5mlzxW1lWCFPUPLn5Yebf0m2N/btg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ksDlLMwp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=mike.quanta.115@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ksDlLMwp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=mike.quanta.115@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYVg51l7Kz2y2J
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 23:47:44 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cc147d86bebso4103702a12.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 06:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788184062; x=1788788862; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EZphEP1aVBZVI+sCUTh5FGIjIPbG+M3yCoLuytV4vxw=;
        b=ksDlLMwpIclJrehHMudNm4SDmAosXiLbcfuLvWx5SRH+JwvJrbmjSzNEzX1jB/Sfho
         cK3Rmb0f9Xd5yL5ahW2v9Zn0q+vbba1OCZCByvQl/vZcIPbUO7qVtTY1KMktKvUWyyNX
         LMwWMPD6k2xVAE/PDu/Zh1qIP2Wb9Fkv7u0PDEz6ZD2HAH+VkUt52LR9YzJCMAfHe31Y
         XwjkskUUhS0JD691HVkPP46lXF7rbiP5qSGdkVH7zMqtkEOccaQY4ST49TmJ8X1SVbGH
         0Srp2eNPke9HotkB3RjJKxkhwGWhlzStK/BuCdOAzZHyLs2eIxPMMDSdt2Ap7oZcvv0K
         u4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788184062; x=1788788862;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EZphEP1aVBZVI+sCUTh5FGIjIPbG+M3yCoLuytV4vxw=;
        b=o3p6mGQBpm1dge1o9SrfIjo38dOTB3uJmQXFifrrKSSfNQQIiJ9+lTqJ0wFIe84Goy
         /+seeIr2OQOFpbhQB0FkBfZaydqLmu/zkfoUL90TBUWunuc/AsD85AYObMUKV5YKIHfz
         xixR5CZkuHuLyojPsIAr1nvlJP/zI+ngAxHt/ZpVLQ6OxE+SzP24TEZ0uvgLedTKZcxd
         KbcbQ7SkSGOu+F6hLoxfpewiwW8FrtdCuUP/rUzLtiDgW89769Wgr5xIZsYIn9aeU29j
         Hx8GV7aeF+OK5vnbCIYG5ipZbi99sBusWl6j/MAJMUJpVarSi1oBq/kJIN3IDB8YOWo8
         RMKg==
X-Forwarded-Encrypted: i=1; AKwUvBzjRXddRiHLDzbCgNazF3PW7g3FeZr9tul3oqTgo1MtQ6b1UcZU31LSofhTrPeX6vX2fTByeznFpc8kMGo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nLsFF+5mtq1+B8AtrZfGNpIvTSrIKdHH4oPVsZsATUGfToRocl
	eHt8JTxYZQwc0hnIl77JVAXxIw7gsTRJeW8ZHyWLEoEL3y39uaIcp9YL
X-Gm-Gg: AYBFou2A2ZSpb2AfAa4HngIYX5OtXrxNKId3ca+rjGJcthlP4Du0Kt6Zo4g4Q9welTL
	yIGaNUW6YltTltNZlP+TG0dKxEHmegN0CfDhWBqwYyEcgSuwvK97qDqmgrkPOQRAY0Cddn9ursS
	go77+INXCq+fxjh4hX76paqkYret4Ulz6bhOcXhrz47OS9Mo201Xb61dYfDiIBf83J0DMWxAZhB
	/fJlrK1Pb3VCLuH0Q/mDjVDrvm/fwA0CuPyRYaHWlCySe7B9MLxQPcrBBaDEe0TsUvj+8EP+QVF
	AjHS5/tSof+0GTtVElUoOG5n9VY75T1vHu1EkqIVZEITFezBpcN435tmF2ki7N7yFVoZgO8nOG0
	fwJ4dMPcy8DKSXqV2u1YFYMuu3NTjYIaBZ7ge5EkOKaUfCSrxwTma0bDCdFTMhVlEBlumxrRNLb
	TPIs1CCZkcOEg7ryfXTukCyRL8XYYpiG6xnmF0DKtZuDMmb5vQSHWdLSGZHZTTyZaT0yVFzeO2p
	Mld7jBPJv+vxw9zPp9euAwSXhSB
X-Received: by 2002:a17:90b:1d0d:b0:398:9bd3:d6d1 with SMTP id 98e67ed59e1d1-398da6f3ec3mr6720331a91.11.1788184062144;
        Mon, 31 Aug 2026 06:47:42 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd5c34sm22051985a91.8.2026.08.31.06.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:47:41 -0700 (PDT)
From: Mike Hsieh <mike.quanta.115@gmail.com>
X-Google-Original-From: Mike Hsieh <mike_hsieh@quantatw.com>
Date: Mon, 31 Aug 2026 21:47:57 +0800
Subject: [PATCH] ARM: dts: aspeed: clemente: Remove nct3018y rtc node
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
Message-Id: <20260831-clemente-remove-rtc-v1-1-84fc5787a6bb@quantatw.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBQFrxJ/nWAKGV0lWtTvVR/KQiWC6O5Jq
 2EWMw9FBEGktngo4JIoh89SlQXxOvgFSqbsZLSpdWMrxRt2+AQVsB9XRmI1WTc7xw00j5TLM2C
 W+792/ft+WksGJmUAAAA=
X-Change-ID: 20260831-clemente-remove-rtc-d37f77c8e0cb
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Mik Lin <mik.lin@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Mike Hsieh <mike_hsieh@quantatw.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788184083; l=1130;
 i=mike_hsieh@quantatw.com; s=20260522; h=from:subject:message-id;
 bh=wbzWufdH1+05XeIF2UprLNnPXLOsM98m2VskYJzVc3M=;
 b=2dMXHa9BYQMJWRIeFy9+pcKa28XMr7eWy8ya+OnqUgbtTebVuhdxMyXh+CIHfidxvK2Vo6CpH
 UpkwbQS4uMCB4BS0St4Z0vIHonO6AJfchblqTsk+pnKP61dsaihR+Be
X-Developer-Key: i=mike_hsieh@quantatw.com; a=ed25519;
 pk=DRIErV0xX0KMBlR/irAsbuN4L3egitHbC8FHruUH4HE=

The Clemente platform has a second source RTC chip (PCF85053A) that
shares the same I2C address (0x6f) with the existing NCT3018Y.

Remove the statically defined nct3018y RTC node from the device tree.
The correct RTC driver will be dynamically detected and instantiated
from userspace/early-init script at runtime.

Signed-off-by: Mike Hsieh <mike_hsieh@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index 820d39a92974..51e90a4fba0e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -958,11 +958,6 @@ io_expander3: gpio@21 {
 			"",
 			"";
 	};
-
-	rtc@6f {
-		compatible = "nuvoton,nct3018y";
-		reg = <0x6f>;
-	};
 };
 
 &i2c7 {

---
base-commit: bd35c4d64a566319bb5a151384eb9dbdf4b44eb9
change-id: 20260831-clemente-remove-rtc-d37f77c8e0cb

Best regards,
-- 
Mike Hsieh <mike_hsieh@quantatw.com>


