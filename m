Return-Path: <linux-aspeed+bounces-2035-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E26CA0EFF
	for <linux-aspeed@archiver.kernel.org>; Fri, 22 Aug 2025 06:15:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7VKQ660Hz3cYH;
	Fri, 22 Aug 2025 16:15:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755843306;
	cv=none; b=fq6fwL8u5Cq5v3XGGbp3q7Z9rhaOU99E6yGoYP24gSCMJOSFVW/+pn9eCQX1F4N9PkoZ6AB3Cwz04r8y1NxOvmfsDeZwUm25EQ1gUqcVC1P8kJuuQSw2np/CJpXewP0GVkLhA0BxQt8Vgru4Vdasq3GBJ26E5V7F0ynGE7WxkDJP42uNWUm+xdEWKOTE8mjaQp/qxCVl9HUDgmgzhVHx0qPXRagVjJZUlvIbFlpz7H8r1L2ag/t7vP6UnozxtSfA7uaAn6jXvtrYOZHeci+CCzbFdUEYxseDHwWXLOU0wLyemqwKpaNSsnIHBu9q/Tp9MCOprOER19wgeBuVmpZeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755843306; c=relaxed/relaxed;
	bh=OY4GJHvVYK+N5LUJGUaOnp3q0oNX2or2mbmIQLdKleU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ped+OMwxWIpWK+sKMczD3xKYxU2ai1DXHmOtXdLid39TEjxMiOL/Oa9irIHjRKdV0/TDp/MG9i1eN0Ff86fQIfvgfqDd9ye1ycB2JIYa7qeW2B6E29Sng0tcbpb3SAQa1YaiwuZ1x7YBpbHewIv8l22ycMRKtWFGUIobrUiiS5oHMIROaPfaBEDgMLy3hhX1zge42LSKerM9KrbpMlRqDECDzPM6TTCumDmf8ADK9x1H+uI4146glj38cpHHo/DuEnKNcrYCBLBF/Ypq5PXizMQpceL4n8FWty29r0m0GuYFkrYAJCZGXaJgTSmDLvtMDLTEr2Far+KUh0je72l3lQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lJS9aRQP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lJS9aRQP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7VKQ1gsPz30MY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 22 Aug 2025 16:15:06 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-244580591b0so14314595ad.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Aug 2025 23:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755843304; x=1756448104; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OY4GJHvVYK+N5LUJGUaOnp3q0oNX2or2mbmIQLdKleU=;
        b=lJS9aRQPdJWiIrM9Ismt0vpyBqMG6Iu6EMpP4WNEp609m1Ujmivgv4v1wZpkaNgevv
         7NYuFvyb3QEl478MCWLwA7ORwhaZfCujLqhfDygIJ7zR91kMLfLjp8rxvWpCr8xONupJ
         c5v7PuqsW9blAGj46S7dHHZrT7xbm2kYurUjvsuVZsBs6gO4xtvQAlUfZwQe8Bsa06nI
         +9YBiqYe9OU23YEqLtuGROCD65PuAkNf5mASE6axsarMU+v9aKFcla4WmoNSOJZLOBCV
         Z3iRvxpr2Cu+EV5K09Fjaxrd6ZQNJSHesJvuFDDG2rdkzdGtWwJlQuqEjOfsA/OuWNg9
         C9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755843304; x=1756448104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY4GJHvVYK+N5LUJGUaOnp3q0oNX2or2mbmIQLdKleU=;
        b=wQAuVFxrxrSG+JnNw7GFArzGAvDyPLRxhSjKUJh60yOsjsAQ/gRsx7YBE5rhq7EykN
         gPnvy0hO8df8DHPANTjny/ihtQN1+MAZbuhaiiONE4T2rHoYHF4d8ElWyLADdawUwrHK
         UJsL1ylkLwzELL3V5reTIeyL/tSgwa82Vu5mtmBIG2RWNpqCkpNvlcLp8Wl36nDKragh
         6sdzGihLmph0BOQ9uWE+jUfgFz9kWrIP70ZM7uGFo4sbryP6qdGKUQcfVEW1aKkvBKmL
         FTaSkNYF6IM9YqpyvKkje/tWrRWpSM1Bi0oqtEO2dn2muhHPuRJuWhgD4tFtJp/Cpgkh
         gIlw==
X-Forwarded-Encrypted: i=1; AJvYcCVtKwfAO5K1b9Uk69hHDhee0YEsAgm9qouRg9lX303dvlL7H7g7+SLToNc6MkiQmW/e529FL3alJAW4u6A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzRVCpLV6yWWUNjDcFYDtsQks1+oIPk4YhwOlKZGuEmspvaxgrZ
	HKKPCY30ZSbITBZ8/OZljoaD8p97b1PyB+PlNqSZP0yHSv61ieK3gz43
X-Gm-Gg: ASbGncsC2aVxYKHLQvAxce+8joGlbbjy4hv0PQj9v4ojeDof0Wqkhwcqhw63ckip6U3
	haIrZLOpcT+rAPnQcZp76P/e2e/VvRjuHkr+kzW/3kf9MZfOptv48Mh/+8trC+bb5RlTIGcJU/7
	RgpSLNIRTkJeZW7Bt+MMD7W2BCJbFCDJqppG0ZuLSH12Z5HFVyCMSr4jBZmGOgcIULDJM/5Pav4
	82c1cz0MIblCrtGV98PtqZyuLUwW/jqmaDc7NUCJgxiEYNyYedx33+CyCvbHXfrA+0KCV1hTVhx
	Yt7dHduDUVvIhCLKlU3oz8PO57V/LD+5FR6QLroU5uNe9V6fwAZeEdbS7Lxw6mnFL9qQVHIrCaR
	VgqhvT04Xq3e4w8VPs+q34tPPPH+p1MhO9BIJeDSvkKdIL56x500oPZKHeTKqYKDMR/X9i/fJHa
	0LMEe2DKD4zq6cLVlKBPS9n49rEZui
X-Google-Smtp-Source: AGHT+IEX8roGyBHGJ/i9ej1bGUzipkk+L88noriLAZ1+JU3Yv/i6WVdaBF5O/2TerwAvPB7SMxG8mg==
X-Received: by 2002:a17:903:2ac8:b0:234:986c:66bf with SMTP id d9443c01a7336-2462edd7d39mr20587355ad.11.1755843304375;
        Thu, 21 Aug 2025 23:15:04 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e35d-8041-a0f2-62d1-f7aa-e5b7.emome-ip6.hinet.net. [2001:b400:e35d:8041:a0f2:62d1:f7aa:e5b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246181c48c1sm28660385ad.116.2025.08.21.23.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:15:04 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: aspeed: harma: revise gpio name
Date: Fri, 22 Aug 2025 14:14:52 +0800
Message-ID: <20250822061454.2610386-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822061454.2610386-1-peteryin.openbmc@gmail.com>
References: <20250822061454.2610386-1-peteryin.openbmc@gmail.com>
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

Update GPIO label definitions in the device tree to reflect the correct
power and control signal names. This includes:

- Rename "fcb0-activate" to "fcb1-activate" and "fcb2-activate"
- Add labels for:
  - power-p3v3-standby
  - power-p1v8-good
  - power-pvdd33-s5
  - power-pvdd18-s5
  - power-asic-good
  - power-12v-memory-good

- Replace unnamed GPIOs with appropriate labels such as:
  - irq-pvddcore0-ocp-alert
  - irq-pvddcore1-ocp-alert

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 741d2d9b6d03..81278a7702de 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -234,7 +234,7 @@ gpio@12 {
 		"","",
 		"","",
 		"","",
-		"","fcb1-activate",
+		"","fcb2-activate",
 		"","";
 	};
 };
@@ -308,7 +308,7 @@ gpio@12 {
 		"","",
 		"","",
 		"","",
-		"","fcb0-activate",
+		"","fcb1-activate",
 		"","";
 	};
 };
@@ -698,14 +698,14 @@ &sgpiom0 {
 	"","",
 	/*A4-A7 line 8-15*/
 	"","power-config-asic-module-enable",
-	"","power-config-asic-power-good",
-	"","power-config-pdb-power-good",
+	"power-p3v3-standby","power-config-asic-power-good",
+	"power-p1v8-good","power-config-pdb-power-good",
 	"presence-cpu","smi-control-n",
 	/*B0-B3 line 16-23*/
 	"","nmi-control-n",
-	"","nmi-control-sync-flood-n",
-	"","",
+	"power-pvdd33-s5","nmi-control-sync-flood-n",
 	"","",
+	"power-pvdd18-s5","",
 	/*B4-B7 line 24-31*/
 	"","FM_CPU_SP5R1",
 	"reset-cause-rsmrst","FM_CPU_SP5R2",
@@ -749,7 +749,7 @@ &sgpiom0 {
 	/*F4-F7 line 88-95*/
 	"presence-asic-modules-0","rt-cpu0-p1-force-enable",
 	"presence-asic-modules-1","bios-debug-msg-disable",
-	"","uart-control-buffer-select",
+	"power-asic-good","uart-control-buffer-select",
 	"presence-cmm","ac-control-n",
 	/*G0-G3 line 96-103*/
 	"FM_CPU_CORETYPE2","",
@@ -801,7 +801,7 @@ &sgpiom0 {
 	"asic0-card-type-detection2-n","",
 	"uart-switch-lsb","",
 	"uart-switch-msb","",
-	"","",
+	"power-12v-memory-good","",
 	/*M4-M7 line 200-207*/
 	"","","","","","","","",
 	/*N0-N3 line 208-215*/
@@ -809,7 +809,10 @@ &sgpiom0 {
 	/*N4-N7 line 216-223*/
 	"","","","","","","","",
 	/*O0-O3 line 224-231*/
-	"","","","","","","","",
+	"","",
+	"irq-pvddcore0-ocp-alert","",
+	"irq-pvddcore1-ocp-alert","",
+	"","",
 	/*O4-O7 line 232-239*/
 	"","","","","","","","",
 	/*P0-P3 line 240-247*/
-- 
2.43.0


