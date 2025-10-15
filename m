Return-Path: <linux-aspeed+bounces-2467-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FF9CCD185
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Oct 2025 22:36:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cn5YP4CT2z305M;
	Thu, 16 Oct 2025 09:36:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760539166;
	cv=none; b=CqHXfBHxSmJwsUR3oYbG224wnXX4HilHLGzs2T4S+BRSUe17fOfmUBBFAHUrK3mVDRW/OFL+jNrw72S6I8xH2CFh1kaxBAYr440DFGgrIo+/HrvDzwEbbTjdkfzaBGiZpb/R/Qu1pfITjWKuoQsSJ5muxBMGExSvJkp5v0MQLe6rRDkGTmY8J8JCVP+ScJD0LCEuX8MhpHniaAmHUceDma+X22ovYecc5q7ikOcgz2UBZpwGJtrAvNGViz0Uhk12QVC6Q106gsAH0me9cEGU3eOZZxsvdSGirsROCNxHpHU9vDxZuSMCP+41ZZO9ZqDvXV+Gdr2Hd/MBSWxJUtpRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760539166; c=relaxed/relaxed;
	bh=J1qkiZNzj4i8upyPOuFU9biKPD/HSZhrQR/i5BB3FsY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MshqGamjmWmoyqE7AwaTwa0CSl5LCB8DAAT5qeMkybiKCGbnByUR1Za2F9kmbNPz3UiUhRkjh8CMQURZvFJ3mrRADVq6fR9wb3mtnJTUbQrvmXXqYePL28ee5y5QS73gAztWY94h0VmOzHys7x5/gGGTUD78Bb5GM2KBAS2ISI1A3RklTXDnZTm6jRLIgwv0r9wwFZS6JhLtoUjaEtbbXkLhabe22IY5fr15Cn8eWmBgZzi4gu2jZ2OJA42/bcvhJoOLNf7jWIvoiu5rVcwqG0i5+wU1nUbLFnItpCoRGjmymOx4cqxMevaVY1aDxbf1Oq0hD8VFp9/zQGYdydoHiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kIxmKn6P; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kIxmKn6P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmtyP56SLz3dHf
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 01:39:25 +1100 (AEDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso3039327a12.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539164; x=1761143964; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1qkiZNzj4i8upyPOuFU9biKPD/HSZhrQR/i5BB3FsY=;
        b=kIxmKn6PDxxER851/Z9JeLdhxjsTwBOHUDHVoPejVZxCGT8BH6xcvPRMo7l/9eJvU3
         y83rJsUMBUCezVM/Yh+SSY5O7m1F5t/94Gtk8WIdBh65rNCZTQWlf355kbohBou6Rxo2
         Zi2MOcTbTSdCqDk8GdmtgYpH+tMZzMoIEQlXWM2+VmqCeQaFHlNnGq8b5eF6IwOcXTWz
         Hs39ishMxjFGrSwdcO8+VCmyCaMR7CVNloV6rK0tXGlV0tBDT8MlvKXRJffhh9VNE1Im
         8ws5WlUHUEXyyChhkCRAV9sCMdSrGiEe3NR9woTGv/FMPzNO9472MIvTYV/e2ncr6ITN
         K80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539164; x=1761143964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1qkiZNzj4i8upyPOuFU9biKPD/HSZhrQR/i5BB3FsY=;
        b=d4rzZTqWfHjkmWsgWim2tbSJ31cIzwANlcTPbE8Zae7n7zIzOB1yctp2Dfj3lMTbjH
         m3R+8f8Wb8npVIkC2aZ4kCcwtN0zN12gtFYooRIBL7cVjWgjAVsGlAsQi0X+q/99cREf
         0N/FWinemDE7rRsIFHuzds5+jMx+8zhyiDPw/hLhtcIXO/fOYqb7KRdMcYLsU7RvzPsE
         Bx4Uiis3+hy6Z9dDmcJ2ShgMvl+4I8LONSy9IupuNEz+Ohn/74YbV56OeAqi7AFaHCV8
         7fcpIwKEnybQWuSkJNi4Mo4OsQDDu918ZgJGSpnFredIApTIZtq3Ms61aMBxH1WSROBz
         D3hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnJJVnJsEDkKyPA0XYRpNNrEO2VT+oa91lqJwRCdBOrbgJ4v2Pu64mjsIEXNW9LsNFKh3g014Ezb8Wzmc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzAD9TEffa9ICWb43nhmizNnPBhttmhhRtiJcCMy48al8RyMiE9
	Jbjrp7L+3i5fRZyooQdabt/QsrIXcasnn2sTvaq96Fo13iZ2WkkyhGB4
X-Gm-Gg: ASbGnctkWTrI4fIEA4B9AcPpm+Bv6briH8Jh+JGHiWjJPkhmV0uZlXAlgYYIa81a2mv
	+XV/WUhr1o5LimuqkFL2YOjViamxzni4z0I/PXpHgpJP5IgMg2AXnzvqgoahhQJx601p33JKvs1
	oYgDBOA0YJ6j4AeSt6rE2Gdt1D0TGpPeYj0h2vQTTty/OIM+f5CfQazpwv1kwA0eyOJi/BYAeTA
	PJON83PXLt7t+519HIIUmE74hWL6d0Ecd35qmUsDx/uS3d4R5TzO4ae/hbDDXtF7S7G/eIIVWqk
	nOGiGBCCGfZ6Rzz3yFYFRnCS+Bb6mhB+DAWarjwYHcI6/8hixB1vm0mTbzvN7XN1FxTf3Z8k++F
	ENxr4R7RxoiBS0pat6lhSj2InnfLvV8UdW0+AnAagRvTe1EKfWsxFSRH7xnBhkkUSTradlDSQv/
	ufaZXV5bh+u9HbdWlXVxVhaPaLpPOAYVTT2v/lVKcE
X-Google-Smtp-Source: AGHT+IGhJSIQPh1cVrCpB8ckttgUHuHIw4pB+GNjrgyyBubcVdnekxYCkMTZnEV3Ov7tT/KZdg62EA==
X-Received: by 2002:a17:903:286:b0:276:842a:f9a7 with SMTP id d9443c01a7336-290273a1725mr344577015ad.57.1760539163812;
        Wed, 15 Oct 2025 07:39:23 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm199853455ad.87.2025.10.15.07.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:39:23 -0700 (PDT)
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
Subject: [PATCH v4 1/7] ARM: dts: aspeed: santabarbara: Add blank lines between nodes for readability
Date: Wed, 15 Oct 2025 22:38:57 +0800
Message-ID: <20251015143916.1850450-2-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
References: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
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

Add missing blank lines between DT nodes to follow the devicetree coding
style and improve readability.

No functional changes.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../aspeed-bmc-facebook-santabarbara.dts      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 72c84f31bdf6..4adbf15d913f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -319,16 +319,19 @@ eeprom@53 {
 				reg = <0x53>;
 			};
 		};
+
 		i2c4mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
@@ -380,16 +383,19 @@ temperature-sensor@4e {
 				reg = <0x4e>;
 			};
 		};
+
 		i2c4mux0ch4: i2c@4 {
 			reg = <4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch5: i2c@5 {
 			reg = <5>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch6: i2c@6 {
 			reg = <6>;
 			#address-cells = <1>;
@@ -424,6 +430,7 @@ voltage-sensor@48 {
 				reg = <0x48>;
 			};
 		};
+
 		i2c4mux0ch7: i2c@7 {
 			reg = <7>;
 			#address-cells = <1>;
@@ -469,16 +476,19 @@ i2c5mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c5mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c5mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c5mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
@@ -503,6 +513,7 @@ voltage-sensor@48 {
 				reg = <0x48>;
 			};
 		};
+
 		i2c5mux1ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
@@ -513,6 +524,7 @@ temperature-sensor@48 {
 				reg = <0x48>;
 			};
 		};
+
 		i2c5mux1ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
@@ -542,6 +554,7 @@ power-monitor@45 {
 				shunt-resistor = <2000>;
 			};
 		};
+
 		i2c5mux1ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
@@ -663,6 +676,7 @@ temperature-sensor@48 {
 				reg = <0x48>;
 			};
 		};
+
 		i2c12mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
@@ -678,6 +692,7 @@ power-monitor@43 {
 				reg = <0x43>;
 			};
 		};
+
 		i2c12mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
@@ -695,6 +710,7 @@ power-monitor@41 {
 				shunt-resistor = <2000>;
 			};
 		};
+
 		i2c12mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
@@ -712,6 +728,7 @@ power-monitor@45 {
 				shunt-resistor = <2000>;
 			};
 		};
+
 		i2c12mux0ch4: i2c@4 {
 			reg = <4>;
 			#address-cells = <1>;
@@ -722,16 +739,19 @@ voltage-sensor@49 {
 				reg = <0x49>;
 			};
 		};
+
 		i2c12mux0ch5: i2c@5 {
 			reg = <5>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c12mux0ch6: i2c@6 {
 			reg = <6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c12mux0ch7: i2c@7 {
 			reg = <7>;
 			#address-cells = <1>;
-- 
2.49.0


