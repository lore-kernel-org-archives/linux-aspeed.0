Return-Path: <linux-aspeed+bounces-1287-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526A4C3ABB2
	for <linux-aspeed@archiver.kernel.org>; Fri, 30 May 2025 04:11:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b7qYD6sQVz2xrb;
	Fri, 30 May 2025 14:11:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748518806;
	cv=none; b=JQHncUoc9+cmjqrWhv3i5YKVjs8+nHRf/OJCDRgtM86xAA1xh8yJpTnt+4bzyyynO4dfUv8IWS0iHn51Hce65rKMOoKykmozs67EeJXqrMxZMcFg6kewoEfv7zjczB3MDH6C/ZCpGYPnI2tLgFaTIUEIueNO54CS7vdcfMIcNzkTDNnGZSN4kRtymhbEgGJyN9nGhQxNtCNX3bih/pxMC2Uphml64WF0tTZWE1ZsAcEqXtqKPPWng6B2/ExZPz+vQe2Q4xTyWObYd6Yqr5wMEgGmWfV2Nvn9SO/gQKEjcVZdp7l7S3mGPNZ5GCQiKJ7KdtEkknrmsBRkpOiX5f0Jsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748518806; c=relaxed/relaxed;
	bh=oPJPluA2yPOrdl3Xx9YilnLVqcTIWj8u7ZCyZ4fkpT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jPpIOeIuk7G5/il9fYvc+KjRv2UasHbaw67ewjyowVPSVtXAITK87gkByv7uHXb3oB72vNFmKe6v8fsirF0dUN1ZmtyQjL6u+NYGmVoewD43SG/mnQ9Du2ekpxYRN0cToX7LkaecNuC2qROWWxJP6c7ZBIKeRItN/mzqALfrR/4pmPcIP7Ll31twJZ49JfeUnX2RtwzmIibhVoFxRLZ8RM0rStA+nr2/6lZcyGb+NK8BO2gwpc+X/PCkqh+hL1zPidNt37hrTUqKMJSImG0l07EYDymKm2baY5JqD26pSYp8mebAiGQEQ5tfSVRWrEWFj+SJmi+5pebvJAcYEAfD5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RGMUQ28a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=ankitchauhan2065@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RGMUQ28a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=ankitchauhan2065@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b7PYc4mQzz2xdg
	for <linux-aspeed@lists.ozlabs.org>; Thu, 29 May 2025 21:40:03 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-742c3d06de3so872383b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 29 May 2025 04:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748518801; x=1749123601; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oPJPluA2yPOrdl3Xx9YilnLVqcTIWj8u7ZCyZ4fkpT8=;
        b=RGMUQ28aYZO2xi3FAOHSGHtNcgjCBODIAaJGNcmCRssxmmU48WV4LJgxNpUrIlWemR
         inM8Q8TEJdqFLdgYNDSl8KPcr6y5xKkz1W9a9l7eYRLqmaKidaUGCZuoCgZlmEHnJcFE
         ef7ctVOva/C/78AQbE4Tlsfns9Omxp5Iu1Gw4zkzpcURJZGiIQ9/khOrN6dGhRoK0Za3
         uKT/HCUhUYtztvpP/D1hNF10fYlZXCf3369bUYzd0KsLITr4TURp+A/shVx6reHEHWhu
         xumNGhDQflhEwY4Lnz3HbpB/y6s5709y7c9sQ8VVGH1o4+wS4rpKP5m1VB0tU2Hzz1px
         zm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748518801; x=1749123601;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPJPluA2yPOrdl3Xx9YilnLVqcTIWj8u7ZCyZ4fkpT8=;
        b=vzA+ehNwJStGkOhG+XSGtLruof4x8Yo6U/rO0AN8LGbUrtIqtR4dgdSdL/NzKjqi/i
         lcHv7La0CHl6FNWq+ZkLAUzZtwd9o0yXSDcyLI7m7t27wa2ZtRnsOFlnFTeohpGYhn++
         CEwBlrFGuQrj7PNX+Jn+bg2kqpEC70u8y3UaKJtbbRxy0wXRJi8Afo+PfZPutHEJD5N0
         kMfb8G7ofhKu3ip6KQWA/WBcaBOCto0Db2ocnunc9fITAZXpJ5Tb/pvXHuE6DEreLUTd
         24uuJClfSj+S+ud2dvCLRwaxdFkppb61smeLrQsqKzwMiZ5PfHpKzzbj7VP3azUi30Kp
         AhsA==
X-Forwarded-Encrypted: i=1; AJvYcCXLOrQmwV/7n2Y3B+AD4I44yojfWUOof6A+2pGyayu42fLNPpdsosMRt3ItUxpNqeiK1xUlFDa5EfijHps=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyIJgTfbOWk19F9cFspXkiGnkreBmY2oteKB7fT5v8MbddvNEz2
	qqHfh7n5fDJSPlX4JKAJhoUwjvJDD2VieIfI5cXMm3SSLlgrNvkaJFUB
X-Gm-Gg: ASbGncssGNUB6Fgf/nLchL52O1bd0w1+rv7SnG7cQtX+py5Ib9Vfh+sL0EtIAjskSGN
	2U8Nnh1+66Y4aOMMpS2FfATk71TMb1ILNxqFFq6Bs87auu3jO5QeGZeTan3DCpQcc8q0RO+nMaH
	8MLALjr2Y6S8q4MWhhgyxJKMMNvZndTLTO4Rxj/wK3kX5GQ7UO59aPugElwCiKiruaNoHQWcWm8
	/lW8Je1/D/NyOqyj2Iy9ZWxGqzrDywkLH3u1Isb+BG52RsBr9dgCG2sO5g8d6WJl2cJYbWXXM6D
	cUSq/m6Hs462hW0w/3/zoO7QjJ1U92ECdleeLOGN8GVgMgw8djA7BjVI6yeArw==
X-Google-Smtp-Source: AGHT+IHsY236gxnL8+RzCtR1lcYX0dN2OvDWa0uStfgSddoIhXY7ZKQytFP78FPhrjNUwn+k17a6Hg==
X-Received: by 2002:a05:6a00:3cc1:b0:73e:235a:1fca with SMTP id d2e1a72fcca58-745fe06fccdmr31439493b3a.20.1748518800934;
        Thu, 29 May 2025 04:40:00 -0700 (PDT)
Received: from [127.0.1.1] ([2405:201:4042:d128:985:242f:9e00:e9db])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-747affafad4sm1137055b3a.116.2025.05.29.04.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 04:40:00 -0700 (PDT)
From: Ankit Chauhan <ankitchauhan2065@gmail.com>
Date: Thu, 29 May 2025 17:09:38 +0530
Subject: [PATCH] arm: lanyang: fix lable->label typo for lanyang dts
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
Message-Id: <20250529-lanyang-lable-fix-v1-1-8a2dcb48bda4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHlHOGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyNL3ZzEvEqgOJBOyknVTcus0DVINTZLSjNJNklLsVQC6isoSgUKg82
 Mjq2tBQCSvO3XYwAAAA==
X-Change-ID: 20250529-lanyang-lable-fix-0e36bf4c4fd9
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Ankit Chauhan <ankitchauhan2065@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748518785; l=1318;
 i=ankitchauhan2065@gmail.com; s=20250528; h=from:subject:message-id;
 bh=Pwx2fvfVuST5jQFNBNpRxios2r+c4w/jFunmwqAE8/8=;
 b=d2y3CSmsLFYARBUorhoa9UHNPHRgs1SOt+vaL0kiIzgUeRyL7d4SFTeJhA36lr0Dj7eCeapP7
 DhfUivnA5bwDarDO1DXOIoyLCyQs2t1CB4NaFSBRPc1KtiwWpufV1Od
X-Developer-Key: i=ankitchauhan2065@gmail.com; a=ed25519;
 pk=6qbMcLtF/2YGH1xAgdxEABYLcPtWnesHOBiHaoZEZrA=

Fix an obvious spelling error in the dts file for Lanyang BMC.
This was reported by bugzilla a few years ago but never got fixed.

Reported by: Jens Schleusener <Jens.Schleusener@fossies.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=205891

Signed-off-by: Ankit Chauhan <ankitchauhan2065@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
index 370738572a55b2498fff31a4aabf336cc41e1eac..8b9d382241ff11329fcbaca5a469aebb11fd3460 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
@@ -52,12 +52,12 @@ hdd_fault {
 			gpios = <&gpio ASPEED_GPIO(B, 3) GPIO_ACTIVE_HIGH>;
 		};
 		bmc_err {
-			lable = "BMC_fault";
+			label = "BMC_fault";
 			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_HIGH>;
 		};
 
 		sys_err {
-			lable = "Sys_fault";
+			label = "Sys_fault";
 			gpios = <&gpio ASPEED_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
 		};
 	};

---
base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
change-id: 20250529-lanyang-lable-fix-0e36bf4c4fd9

Best regards,
-- 
Ankit Chauhan <ankitchauhan2065@gmail.com>


