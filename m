Return-Path: <linux-aspeed+bounces-1382-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CD6C61CE7
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 08:05:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHJB618pcz3091;
	Wed, 11 Jun 2025 18:05:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749629134;
	cv=none; b=Qv2Y0Iv7cutVf8etF5ew+yB6FpnGYcNGCiYscfHZY5nzPtcuaWVMufAXYpmhwFZlo8YT5efrtth+1gAbBdiMKXOSH8G9ZsqYSg2U1qv81ZQvvb0suV6L2zYX4sdTfnhES1/mYLM/8g/5hst1rK4R55oQBAmogO+jeszCcVb4VKF/8+ReOPT9Rf2mczT059mGeCnfDUfmNLmSpzHEYdVS91zqjqjRrT9cmm449WP6FmHKZu5keMgVxnhez5CooKy6U48gqXejTxpLfyWfPgulrGAPvfvR0/zzdW25IQQtdx6b29+ZbKD7cgc0lGqCUrOhCjf2n2yJOwS8QdAkRV4i0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749629134; c=relaxed/relaxed;
	bh=fj1zenE5stas2VJD+6DRjlrRKD4iBr3hZsqLVnUv8iY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NX4MFmMBez+Oy/SZ26IpJ07287BqaA7fK2rPbLa1T0aya0h5/MJgJ4UtikSPq4UKEYb4RZaxTZmeQ21WQgQJ4CQr6av1uNySzOPj4ECPwcmYsUdoipoguW58UhEIaSYG9zma7gSu70QYNydqv6nG4tRYq5v8Nz42fIeOGTZ1BAtdm2SGfu/yhShYXQueRFfxtP1uNcbU7Hlq041yWSFeKBGZC7njIA+NhkeccS3AWnPNC48xso6m72OldCrnNFKKH0ZvBkEMrXwyUvIbcviUwqwWjxvUffNhLrNB673cUdqudH4qPCm2eZgEJz+P8++IS0M3TAyVlOwJRo62LPLcug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HgMp3skl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HgMp3skl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHJB53x9vz2yMt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 18:05:33 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-234fcadde3eso74664085ad.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749629131; x=1750233931; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj1zenE5stas2VJD+6DRjlrRKD4iBr3hZsqLVnUv8iY=;
        b=HgMp3skl4mLlKo88yeZHWDW39HuozfjBN0yGi9BQWSE0LhAZTW8SK0t3jmFZew+EHL
         dp7s98IbF4Byzd+iZP13AjE8eMtzYA5junEtig/ZHLzwKgxxbKNjW+Q7aO+1NGBmsTZT
         Ltq7U3EWi9M+3BwGRK/OoRe/I+C9XEpkdUBx0u+UIk3FMFeaYlgiaMcqRGwq3lmi8b1M
         6py7225iHJ9Do1hRWj7HpFLmkg0MggEM94Xxuo1TGy02j1KpbqQKcq50BThLaMv767oP
         DkaIdDcCLTKPOu311dSS4K8UqzP0guV4EQtF/LJoe0h9XHS8UojDxPsO98fktdhyYdyU
         qiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629131; x=1750233931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fj1zenE5stas2VJD+6DRjlrRKD4iBr3hZsqLVnUv8iY=;
        b=Zb+qrP+niK/Gi5plIEe3B01tP7uUQzOXJkAWsOplzT/lHgT1ascj0tT9/bzu0Qisc5
         y0gc+ktmi4EAcT+ci7bWNe/QRxp9k/uwk7PS3/m+BrfSH39Gbmku2g6uDKcmtGy6P7fq
         InNi+ZOoUVW3n8ABBy+ezWJCcRqqtbS9aoUjq3LUgUUiYGgkQq+e9cWrqeJFk9CdWOKm
         IOFRGpkXThGi5iYaJSuQTwUGl4iNilTrEWtfEyEbwFtGz6r21Pa42tfecm+bnd1g1cMb
         A9YVK0VyWmJUlFRXL+LBvQXKum3gBfrDSP/8xBaeCeDiz6HuKXX2oomaeefLly2GSDd9
         3XPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwBLqQo/1C0vOqkSU23J9xmc6M3Jv+7/4gbR/9YVgLps9z+IbnfrngrZ6QXPA43ug1QvqTTC0eIShlCcY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzqNwbl2ECAl1ItRuOFW1kuzqMxIO01Z2sLwypm9dvLGYQSi8Vl
	HcDZOBEOLbhTGwJ9U8GR6fERD9ZVzcgW60mtJ8reA9M9hqrLrAHIx+oD6d8+Ag==
X-Gm-Gg: ASbGnctf/yTHiY+wh02vb/XX7rks+kfoyqz/950eOacNXGd7n5Zs07eUnY+BW4BJ02x
	wr4hBZUkypZQGHw5KAUADGDcukM+dFRjXGf5IdDhpHLytRpC2IdDKeLvou4wWEYxDFE57zqC7r/
	UVYWFpOeye4oSerwoSoK1xarjk+rBU9UdPcfxUIv5+uFaTr4jpleJq2jstxaQt9mNgIyvk4qLnc
	9JVNmfkhPpTEKXml1rsYz+6mMTTFnqT8obP30ah+8m7FHjks2Ai3dxZpjeoLNeRJbxXDqBOhcTe
	bOPKia9vFYeCJ1Khu3Yl7NYil+YY+EtCBzc/Jzsx1HdBLxdQ6VnVOoBUi7uucPqM2I8NikZ7dIA
	jxvP6pZsYFQf7cUpVTZCQrqSqiFiwt/sdQdn5PJWZc5jWUIfEfe2XYTlPqtMhi9BaYBbJ11jClE
	RRtgqV7eDe7pcnu8hC
X-Google-Smtp-Source: AGHT+IGEE0NB+KOJm2lcRtePsnbhbM8oKjwg0jXC41etm70J3PNq57ezKYYToT/robpvQ8dfHs0VAQ==
X-Received: by 2002:a17:902:f645:b0:235:15f5:cc30 with SMTP id d9443c01a7336-23641a9aa11mr37444245ad.16.1749629131598;
        Wed, 11 Jun 2025 01:05:31 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e357-b8a8-7759-271d-6134-9aa3.emome-ip6.hinet.net. [2001:b400:e357:b8a8:7759:271d:6134:9aa3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2363ad90982sm21283835ad.220.2025.06.11.01.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:05:31 -0700 (PDT)
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
Cc: peteryin.openbmc@gmail.com
Subject: [PATCH v2 4/5] ARM: dts: aspeed: Harma: revise gpio bride pin for battery
Date: Wed, 11 Jun 2025 16:05:13 +0800
Message-Id: <20250611080514.3123335-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611080514.3123335-1-peteryin.openbmc@gmail.com>
References: <20250611080514.3123335-1-peteryin.openbmc@gmail.com>
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

Update the GPIO bridge pin configuration for the battery circuit
on the Harma platform to reflect the correct hardware design.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 25b873ace2ea..fb026c8fb0ee 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -643,7 +643,7 @@ &gpio0 {
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","led-identify-gate","",
 	/*V0-V7*/	"","","","",
-			"rtc-battery-voltage-read-enable","",
+			"","",
 			"","",
 	/*W0-W7*/	"","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
@@ -728,7 +728,7 @@ &sgpiom0 {
 	"presence-cmm","ac-control-n",
 	/*G0-G3 line 96-103*/
 	"FM_CPU_CORETYPE2","",
-	"FM_CPU_CORETYPE1","",
+	"FM_CPU_CORETYPE1","rtc-battery-voltage-read-enable",
 	"FM_CPU_CORETYPE0","",
 	"FM_BOARD_REV_ID5","",
 	/*G4-G7 line 104-111*/
-- 
2.25.1


