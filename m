Return-Path: <linux-aspeed+bounces-3535-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19935EEC2A8
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Feb 2026 23:00:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKbsg3mMCz3c9M;
	Tue, 24 Feb 2026 10:00:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771845485;
	cv=none; b=moeV+2ZtYUojWmxcYmWjOOCHRpsU4iBRUOKGa+d9LzbK8HtSfMneY5hnCDqk6jrJEbkUWSWycol6mmkUye52x5AE5UXOeLNh25JbZ31F9GwTQQdFsWGfRe3K6RQ0e1ET/mpPvIQ//4m7zLupU53rl3EZ9IbO3losgPFE4moX4ik5yNMtMO+utK/Nt1TdRbgMNs9yYcJdbhEVTEBJhw8SpjlGPBpvLWacchYD3u0YmSfRIfSTYXaMGia1VNb3hVmLgVZifLYPEqSQN5Qldg8wrC7slICWfpF/zU6quVy0toIV1EutE/OIv6HZNlnPMlR5ARLxVfi/sc1Vp730Q2THfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771845485; c=relaxed/relaxed;
	bh=dsiXdpbaxodmPACgXw5goRGzebyloA1ZJqj/0ZU8ngs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4Mlcy81vXZ51U+INlfGPwFKdomyT0sbGT8tIppkxeag91F6pLdW8yp3BkzloE1AGee+gLoNfn+vPQ3BYG1/EOxhHb1JoKc8/0V5jN4lEIhrliOKuUov2CbzC6zDTcIwaqgqe3ko9E4BT+VuwG5UDTohPVZRKMK7CqrqXqb/lX3ctiscIcifVJknVmW85otBiuxEGMkufvtUp85Tjp7/Kow2ZRCt1I3zOZqr7DlLszEaunkEO9eRJ3dh2J0hnI011PrJuqxUaSu+J3QdOoTvuIlvZfiHPuCD2ymAzbgFnQH2YpBxTSV9ic7fjH/2H46F2KPKaxoEJ1pxFaCZ4fo3Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eC0dQSIp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eC0dQSIp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKJHd0VtHz2xN8
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 22:18:05 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2a871daa98fso29364785ad.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 03:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771845483; x=1772450283; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsiXdpbaxodmPACgXw5goRGzebyloA1ZJqj/0ZU8ngs=;
        b=eC0dQSIp9Sh8A88uPjrKI1rbZsv2tybKSNmpvca6/07M3+d+E129YKTrtXlYUdJNVI
         VyPt9x184L6cxWKx+XG1txrtbPZYoRonxkSDqLMpTEZZiWO6EJkCrQcDa5jEXVSqgtlc
         eOBeoDPdoke3M7h6H/LSk2HhiXYbwkdPoO0h0uY3OQ/uGBKI/kCCuAcZFUWno3l5c/4v
         VimpTlmM46793e+NC7GoRpDr6A2tbq/TPzGyLcH0gJ1Ct3vHdEAxhPgGMH07CxWzqX3S
         TCMilk8KhMf3d7fqVXISXXDhF1MEkNT57rLtC1i3KIA1ayQ0C5kSyThohyq3wzpDQ7h/
         nzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845483; x=1772450283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dsiXdpbaxodmPACgXw5goRGzebyloA1ZJqj/0ZU8ngs=;
        b=Rnv4frq+zUb1N+hU3GJbE5zs6Fm+WAPBTDavcbZEhBqfQ3gXBjt+15DhCqqR83DNsk
         iwP16umeVyEs2VsK15Tm0cw72ReixbfmLoP0M3exrl95Phr23L9FG/IDfMLcxSN9qnx1
         WWhEayBRelLKEJ37jm7O25bn4ok0FA4TANbenxFT/zJ0f2kVvUcfUF3wg1DNYovZkKro
         uPSonraiR2UA5Neu72mCfx4IDsXeByP9z2ggwnI4EkSIE+byHBhzUO/ui7obh91y6X7J
         OIQj0xuq7T33UMXM/aDLyS2z6Pxtndh3uSzCundkNEDruj1UYncjhnEEZF/27me1XBUy
         UBzA==
X-Forwarded-Encrypted: i=1; AJvYcCVHSI6OD9lKlPGLPMWo62x/uBG6D0vi4zQHaNYMNHtT1WmM+xMPT4hNjA0UgJorF2QGVNpyLEuxHZzGSOw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwaWE1yVsaAtoA/IlUJY778JHZypBjc8ZZkjMB23Kuici5ugCFY
	veMK3PyS0e8CVDivcvey4rFi3vimGGTdtDo/icD2N+8rGX0ImuJOA2PG
X-Gm-Gg: ATEYQzxyBMrhp5TiAQwgpQG6znyAaTmJHE0URxasRu/5IJn0qLEjnVSU9DQutc64XWO
	8npsMssuoAUiaIn/1FtpH/XgbAXexoW0Ombooe6hbuckyaMb4rUmR39JmJhOrN1qU54Nus4bKHy
	flnDiMU32ih+K9+KuXXKWGncxrzMrkhdr+fr4JDeJFYJYURACXHnhqBneHF76zx1h8NF/xyT0EF
	rJU3PH7S1guZmMa+dNw+5X1FsNnDr70ArbXnmbYGxbJXWYMLZb1117tsxh/VKpBrTuA2IlOKHAV
	LS0lEMOA+6QzE+lbwW8klCtkeDRq7Z0BmPdABRgLFcCeq7Rqr03n7Sc8Pz4FXd21335nSNM2+T6
	pZo8WyoDY3OfPj4062LWt5qP+Kc/LE8bT/Fp5DPP+uQ7w3qH0YPh+mUkuLpK3fzzsW4xX3Lbt3l
	4ToTNArXPsPxiaYH+3hRcZqDx0kxsHFZGTTmscNPVOWx2VHj1H8xb8La3aDEdVS8YVwSw4bvcPy
	d7p1MPFRIgMBepc/ODXwFEOVekG+eZjZAU6K94FSewIwXY3ZfjMpLnKvfBfSqXsv/GkBZmvZMCA
	cslReRS1SqrWLzbIr+N8
X-Received: by 2002:a17:902:e787:b0:2a9:3396:738 with SMTP id d9443c01a7336-2ad74547d8dmr68921545ad.44.1771845483320;
        Mon, 23 Feb 2026 03:18:03 -0800 (PST)
Received: from 2001-b400-e3a6-b683-040b-c296-04cb-fbc3.emome-ip6.hinet.net (2001-b400-e3a6-b683-040b-c296-04cb-fbc3.emome-ip6.hinet.net. [2001:b400:e3a6:b683:40b:c296:4cb:fbc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74d36911sm71799335ad.0.2026.02.23.03.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:18:03 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Mon, 23 Feb 2026 19:17:40 +0800
Subject: [PATCH v5 8/8] ARM: dts: aspeed: yosemite5: Fix host0-ready and
 add POST end GPIO
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
Message-Id: <20260223-yv5_revise_dts-v5-8-fc913e902488@gmail.com>
References: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
In-Reply-To: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Jackson Liu <Jackson.Liu@quantatw.com>, 
 Daniel Hsu <Daniel-Hsu@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771845456; l=1455;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=P2i4RUSnuTwM4qMzIUSQxtFSgvom7jEQkHy1XI4WFDM=;
 b=xv1Y03YbiEGXzcYHlj+4WLx07xcTFFPqHjWjBt42NZFVYg2dQGoaEw8BUJyJHNk2KzYXQtGWo
 e9qYUFJnNgUAxrU41c+DOpPaQt8tuH+8pHoEkA/x1JumLrfVuYun4Yt
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Rename the unused PWRGD_CPU_PWROK_2 line to host0-ready and move the
previous host0-ready GPIO to FM_BIOS_POST_CMPLT_N.

The "host0-ready" line name is used by OpenBMC phosphor-state-manager
to determine whether the host firmware is running. The previous DTS
incorrectly mapped host0-ready to the POST end signal, causing
incorrect host firmware detection.

Map host0-ready to the correct power-good signal and use
FM_BIOS_POST_CMPLT_N as the POST end indicator.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index f590ec6e00c48afe4ade1fb98011780ac0570e7c..beb971eadbe53b5d9fa49252a41bf7484a8e32da 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -929,8 +929,8 @@ &sgpiom0 {
 	/*bit0-bit7*/
 	"PWRGD_CPU_PWROK","SGPIO_RSTBTN_OUT",
 	"PWRGD_CPU_PWROK_1","SGPIO_BMC_READY",
-	"PWRGD_CPU_PWROK_2","IBB_BMC_SRST",
-	"host0-ready","FM_I3C_SPD_AH_SEL_R",
+	"host0-ready","IBB_BMC_SRST",
+	"FM_BIOS_POST_CMPLT_N","FM_I3C_SPD_AH_SEL_R",
 	"PCIe_HP_BOOT","FM_I3C_SPD_IP_SEL_R",
 	"PCIe_HP_DATA","FM_JTAG_BMC_MUX_S0_R",
 	"PCIe_HP_NIC","FM_JTAG_BMC_MUX_S1_R",

-- 
2.53.0


