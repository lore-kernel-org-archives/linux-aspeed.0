Return-Path: <linux-aspeed+bounces-2174-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A00CAC582
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Sep 2025 00:34:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLPvm4zHkz2yr9;
	Tue,  9 Sep 2025 10:34:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757318558;
	cv=none; b=dpmsLrgtFNeAKGRWa3SKYSBVtkSGqpQaXmx4JxO5QkMGyY55pnnjLO0k0BRq87Mo7fVtO7j59Cep/7iUHDwOvKcSK0nDdw4wG4llBzBKE3BTUbaL5YHyWRJo6xJ6lVmEtuUKpWkGma10xSVwtx7S+TWqT7R+ImVIk3F0Q5LZR3Y4I/p6eKI/cbB8/Ge6CZAfOhpbNo3ydIbYaQqB7NgFhal9OIM0CsvMIp2eODqrD2q5ggVKyRpGLhUHEJrFWKlXI2/YYC2ws/g1u9H7HXAvnJhO44dqEOMw2+cetjxdtdR7/Ofq/H2AK6VXCLowoc4ur/gGF4D6iff183A9y5D4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757318558; c=relaxed/relaxed;
	bh=7L/8llJEdSIG4Nfg2l+GvW6TEBvITMkZd39Mo6ER7CQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3wiMdqcl+zDB9GPKxNwsxADV3pyAG6EDrvAghEvxrcPAtlNv4f81x+sVhf/d84qAGjY8c5AcYNkD7mDmVsRrDykLlgjcSoNY0X3BPN2XYnOql640ZSlM3s5KsgpuHlV1TJWOoQng6IS0A8bWTNEWuYsUuVh4/J7wmUgs5Cc4qDMgL9oLt91tZ70A8s+qARylUj1EcA9rOx/k7pQ60iUyrFWeiEsplJ9509mAG/g0d//itlaAK2J2LvSZWeSddUVb/MPaj0nC63lLZNtFyck+ImDPjfaeT7c023MGvAV+B66AIAraTKhPz9hlQrqMTicHzfalhSwDGBdNkSJn7Md3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=G2O1wEbJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=G2O1wEbJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cKzvd3lC8z2xPy
	for <linux-aspeed@lists.ozlabs.org>; Mon,  8 Sep 2025 18:02:37 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7742adc1f25so1342544b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 08 Sep 2025 01:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757318555; x=1757923355; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7L/8llJEdSIG4Nfg2l+GvW6TEBvITMkZd39Mo6ER7CQ=;
        b=G2O1wEbJtp+w2JAVbQOtTPn373aOovcZqFHrNS07g8fccRPiMdfP0K5fR7wMhO6VzO
         U+a4V1csOjBW3cMphSZx+rYnBgpeu1hvPZgWBgragTaUSe691BrBSq/EF++p2N7ywv4V
         Y/+k7EVbffgsFsuzZRfZUFKlNPIwPQy/ydN0o7WtNy//+nLqeuPHZ5WSYI9kQzB6y2t5
         KA1gyOdvSKdieVVhjv3bxneTTR8oFTWlj3k9YQN6HThYTbLtZ2TiQcPw/c1BvhG3HzG5
         KXJUwMwDJTaNMYTiq4ayXfvXMNtyHxRyHQYqZ5upmtk8cA6Gae7wzye631WCHNpbjoTF
         gTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757318555; x=1757923355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7L/8llJEdSIG4Nfg2l+GvW6TEBvITMkZd39Mo6ER7CQ=;
        b=FnJ46YX1P+CxR5V3jOJXPQoQfOT/GjdY+sGshUmjOYp4UA7bL6KpTfUOE3zCwREHIB
         JLxfJv6jNj/fP708GootqtBynEUqqmJTzGwdJQOrTBnWKy08j1N7u49ZC8isg7FgZfm9
         0DIMiTtn9FEH5jwn0m6MVrsXBzKtq4sf5Pwwy9FXu09Roq5mDSmGZx/ghMAJJ6dEPVgi
         g2AtH4lFNgcsT1l6DwxsOqdEKQqyZJ1R0O9lnfutyvBKGwHgM13+sisrD+nP+LIMMOpP
         neK63vWc+z3lnSStlyCo61+wjF497+9pzK1TZ+6Q3zAxjRdVAstrl9Yla74pvdrr7kW5
         +5+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCHI0lhcoiD1zsKPlFx8TnwLu6FHDln6A+T4E6nlNdDlYCckXMk/U/TSBD8DTOY3tD13Mlbij7EbzeBQs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzXI17Pg7BJaY9rncKawZzkoWeVHqg0bvuoBQuJwL6lf5vn5mV4
	NnXGTsShyNF9oD1opKEP6znuGRPSs9bjlpZ7vOtHMkpvIVHCSTwFk9Sy
X-Gm-Gg: ASbGncv0efX/YKzmY5WdMCZTnDMoh/wqfL12ixQ7Uo8bxVU+gUv/2IwACOFeb4iy8Ut
	3S3QDROxwX5+b59l5VPaMVBfwN8WCNu7/mjsUePqnx0lP8xFKEHZ/KgO5K3cAy+HrhOtXb/HXKc
	/A1BGvTjOyW3gaTi4zCMb61v1xDCSMjBfglVvQBXGhLVpqOjW39XZscDxFaJUX04tCTJw2ZmDJI
	cizCNIbGH3dv/ikBdHVrSj638N/7JcadugZJqgcvd1d7GU67KKo+h+2jQhGKwfpdbc7Esa3NVhp
	46SLEnLQ4Cy5ZBKWHfapCRjfFO75XGb8qHNUNsEBCyUFopz1OhpzyTd6gdOhanFAlxOlfSQON1Q
	x8DyW32qAa0Rxlj50djDe2JgfNDCYL3NK5VPF1sEa9uclzFmCw4rAj1uStQYfBeV+c9gTLFUdCU
	MRRBmLkmlsQ2PE/TP2h/L+gINJniGySFQDnSNILmm05BOysGKodGob+BguNMS87LxJmzWaEdrMT
	ew5+Q==
X-Google-Smtp-Source: AGHT+IGboyEkG9gWXFOkl88XKtiOMptf6/1xvI87ICp5Zjmw//pmeh9e60nsTnkc1Awdr15nSl0vZg==
X-Received: by 2002:a05:6a00:181e:b0:774:1be4:dced with SMTP id d2e1a72fcca58-7742dccafdbmr9530181b3a.9.1757318555079;
        Mon, 08 Sep 2025 01:02:35 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727bce1b58sm15186600b3a.9.2025.09.08.01.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:02:34 -0700 (PDT)
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
Subject: [PATCH v3 3/4] ARM: dts: aspeed: santabarbara: Adjust LED configuration
Date: Mon,  8 Sep 2025 16:02:14 +0800
Message-ID: <20250908080220.698158-4-fredchen.openbmc@gmail.com>
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

Update LED definitions to match changes in the hardware spec. Add a
power-fault LED on GPIOB5 and relocate the ID LED to GPIOQ4 via the
CPLD. The ID LED now shares the power LED: it blinks when ID is active
and otherwise indicates power state with logic controlled by the CPLD.
Retain the 'fp_id_amber' label so /sys/class/leds/fp_id_amber remains
valid for existing users.

Add a 'bmc_ready_noled' LED on GPIOB3 with GPIO_TRANSITORY to ensure its
state resets on BMC reboot.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-santabarbara.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index a453f8dc6b36..de624f4a33f3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -94,7 +94,7 @@ led-0 {
 		};
 
 		led-1 {
-			label = "fp_id_amber";
+			label = "power_fault";
 			default-state = "off";
 			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
 		};
@@ -104,6 +104,17 @@ led-2 {
 			default-state = "off";
 			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
 		};
+
+		led-3 {
+			label = "fp_id_amber";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(Q, 4) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-4 {
+			label = "bmc_ready_noled";
+			gpios = <&gpio0 ASPEED_GPIO(B, 3) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
+		};
 	};
 
 	memory@80000000 {
-- 
2.49.0


