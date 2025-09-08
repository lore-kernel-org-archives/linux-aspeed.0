Return-Path: <linux-aspeed+bounces-2173-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDB5CAC582
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Sep 2025 00:34:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLPvh06pSz2yVP;
	Tue,  9 Sep 2025 10:34:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757318560;
	cv=none; b=WPEMt96gRGi0AxgpuHoEzqM2NdQIW9dM8FgD8aMqoXhZgqVXKDDRbRYJ4GZfxRZFJGIoXXnPBcQ4RFKyntvD1GzHllH3hUAB+W4LfsQv9lgeUg2ojGEqlAASxKYLCeZcNEXAS3qg5O6a3vVbivsaaKWBuYIboIlLyi8RDJkWsh6pDNWV7FH108eDVypBPyRplEDTj4CMwgW93usJ0ma1QvCfHPZs9nlW4vzbEBXHdM1hJdG6GP960uriDMumIZie/gDZgYcYLBWTeAtov5np/PT8/peOetAIiQdqaTK9NbW/zPhGLC5R9G7dplpY7qZdky/+LRPHHTFH/r3VetWpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757318560; c=relaxed/relaxed;
	bh=1m1HPXvt7ktVSLEbN3p8RtTbvarkVCnLkg7YZFQj7Rk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4hUTxdw1hFaG6FFzvWqdfWG9eGYQYyY3ZJaoJB1oT8U0GsRU88bzzr92x7wVKw5WxZlY3bUNlhl6dWgqR2YyDX2YqPGiEl2pCWIghLOL2ZKC+dmSr/28Ckaep2Yf/qOBnVNf3jndXyMsKV42A070CZqK7uhiYDszWneSV82WewL0kBfuZol9ZCNPHW188efafGfD/8SGAz8h6bYdscotJkbC1zg0/FsfZM5XXMFpQxN2N1bL5dfIPUL9cqEL84gxhfPDUSTtvq4YUY8K7W8UZCYglLNtEXjGB2QAu3lHuz8e3qgcY40W7utU1v8VVzIRL3AHsAm1EH3LUTt4cVg7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YQf5mw2z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YQf5mw2z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cKzvh0ZZnz2xPy
	for <linux-aspeed@lists.ozlabs.org>; Mon,  8 Sep 2025 18:02:40 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3421225b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 08 Sep 2025 01:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757318558; x=1757923358; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1m1HPXvt7ktVSLEbN3p8RtTbvarkVCnLkg7YZFQj7Rk=;
        b=YQf5mw2zM0cNDPrT9DQOKo1ntWjOFGWV35dT774SugoDc1mmfm76rdK1kEiWri9afh
         yLUH4RKCbbNHZsnEsFkCa3yTtrIjluJDIxW+xALxkNNPJgsWTqNi/qJDafGzkorh5WA0
         Phq2Jq6KdrR9N57PyCLD/2+CztA7ASbVIXd1XcHabihefDQmHt7kx0lS4js2bF616XVh
         ugxC7ow5+wNNx+DLxILSwvt8qufDnCIWNutHq/SppFOJZo1ygdaRORjBnlMpnmQMLSE8
         Tu808IL//hfUL3IjdAhgzQHZqqXuRfC5jPdKal4XZ/K6nMob/+moixdtNrf9nkixrNVr
         q5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757318558; x=1757923358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1m1HPXvt7ktVSLEbN3p8RtTbvarkVCnLkg7YZFQj7Rk=;
        b=ptOTzlKlpRAymvFj8Zr/2TjVAcn52MTcYzdhI3m1JOtuGQMyitzxqsMysBnb9zNyqc
         515QK+5TvOl5GFPln8vG/DlP6p9LIO98c3Qo8aXWHXXLqzKQ+IOApCL7aLaOCFvu5LSd
         0PluFEJh2KrSyGjoYFr9xOeC/tyMts/L28RO3cEbajIb5SPtA+7Gb1918PtquSvEXwwW
         fB92SBEThWDxU9bKoI1QnQbK6wZcQbty6VTUQE06yhLe6RWssQw+Qmy7gYSyLnLCVi67
         jUoY+x/HH2MdsY2PQG7Pr2xLiQKnkFEfB/jHDjESQXdOA5GPZV/NxctHV6+0cNaOUeWV
         dB2w==
X-Forwarded-Encrypted: i=1; AJvYcCUklok438aJL2CO0W85VmAlkkiwncTR6sy7UeuQLrie9UH0Px69RJqhzBjKWPYeZwEPdB8i+28EVAnt/kw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyGyPb2L962yBYDfzfI5GcMj2i+78WeqkCYOxHeOHkgAACI+FCL
	G3l7SLhp+159d7tVs5+kjLgIlBJKF4MyS9bkEnOxQqvQ3U+2hxEsreWI
X-Gm-Gg: ASbGncsUsfXo8hL9fKoRjfEgHns82GQUoVvN3yk3gnS+YuHkPvcitck4F6bO9Ew1fg5
	4zxWXYGocEIj3QjogxUFZnryMTUGueh9KYAZZ/2muBbq2r9uwemkeKNTvKFtNeBGq16jQfqucJ8
	oKlE77Hkk6kiF/b8ZYvUkF06QCu3ePF75hk8KETApWgwDJZG0fgq8FofzmmujudZ1615fh4nzD5
	XQXZ9bl9ipYHeiD0DVSZzdLjHfof28/8V9CK7hcHAkHb/P91lcJJciQMz3YUUlAW7R5baeinzzF
	u5K+jl/vQPkz/XZsZDICo1k5cX6NRaKnOdMv8riD7TEllYmLtLrwdZy0ddldvCDKe5DF3FERWQi
	BjRentZsU5VGTHTUZE2dn94eKZfc5YWXsqZL0p2Yt/XoArjYyahA68c8HRy0SaYhk4utjxeoMm3
	rZIf/wxTmIEF5QATmFc767SSgPOEzumdWJ6JygTp20cH38qaUniuuRTQxtzrXDE3YO4jyYVk2Gp
	IVCOS0gEyHvFXcB
X-Google-Smtp-Source: AGHT+IGGZJOWnBMUs56283wgft2cbmKqgdlDx4FfdiUkPllQ+scrxhIKHbQGrDZ1bM5Tn41ggy0nJQ==
X-Received: by 2002:a05:6a00:852:b0:772:736e:656c with SMTP id d2e1a72fcca58-7742e3b5b6bmr7614551b3a.5.1757318558156;
        Mon, 08 Sep 2025 01:02:38 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727bce1b58sm15186600b3a.9.2025.09.08.01.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:02:37 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] ARM: dts: aspeed: santabarbara: add sgpio line name for leak detection
Date: Mon,  8 Sep 2025 16:02:15 +0800
Message-ID: <20250908080220.698158-5-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250908080220.698158-1-fredchen.openbmc@gmail.com>
References: <20250908080220.698158-1-fredchen.openbmc@gmail.com>
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

Add leak-related line names for the SGPIO inputs that report chassis
leaks, so userspace can detect and handle leak events

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-santabarbara.dts  | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index de624f4a33f3..c86471fc6314 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1766,11 +1766,17 @@ &sgpiom0 {
 	"PRSNT_LEAK_CABLE_1_R_N","",
 	"PRSNT_LEAK_CABLE_2_R_N","",
 	"PRSNT_HDT_N","",
-	"","",
+	"LEAK_SWB_COLDPLATE","",
 	/*P0-P3 line 240-247*/
-	"","","","","","","","",
+	"LEAK_R3_COLDPLATE","",
+	"LEAK_R2_COLDPLATE","",
+	"LEAK_R1_COLDPLATE","",
+	"LEAK_R0_COLDPLATE","",
 	/*P4-P7 line 248-255*/
-	"","","","","","","","";
+	"LEAK_MB_COLDPLATE","",
+	"LEAK_PDB1_RIGHT_MANIFOLD","",
+	"LEAK_PDB1_LEFT_MANIFOLD","",
+	"LEAK_MB_MANIFOLD","";
 	status = "okay";
 };
 
-- 
2.49.0


