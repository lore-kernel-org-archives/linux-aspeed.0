Return-Path: <linux-aspeed+bounces-3794-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016B510F3DC1
	for <linux-aspeed@archiver.kernel.org>; Sat, 28 Mar 2026 01:31:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjKjF1p0lz2yhZ;
	Sat, 28 Mar 2026 12:31:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774594767;
	cv=none; b=UBizqCB3J8+SruV82fESOY/w6WsEXWpazPRBvNrxiB1R/lQuXsb6aVPQsRJB2f5tIAVA7YHQrFNRbSclt0hi3IhYm08iD6C4cQxOUUhrOglaO9VhLqRVSdNtURtubizgYu5K2Kg9p3eXYKOlzB710G5p8RAsH2pLqSHitMJj55vFb+2db9AiT71cGL2kpKPtDaM931+B07jKrxD4fKfeVgoxnqmuHPVDuYyaJTrFT3/v/gmtcLEzTlUu3IVghPmFjV3goJrzveoCmT1148H6+dROim9QwXX7jo3WE5EYBaYMOpn3Af2he0tbIsgSBR+j3U+PSDxNDzZQbgb6a2Gh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774594767; c=relaxed/relaxed;
	bh=tXMwiY4jfkntgcj70RB19+Q8su/PxmKSW+o9I8NPDTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IWp987tncdmXygHzvRUYjWJpjmvlf6jiZM3YM5crDk+jBobnZbqto+feGrJ+33P0/7uEivRj75+XuHMUTtapw3VS9+/TbJxyrVt5Bt2SCkNlL2UvWyqg3+Op09w5ebPLzfdwI8qi31fscNYcNmjEIPvhhoWG+w2eH2xjtSJtsWLQ4FW5dPzwgJN7wAdJnepZrhfUdTWDID3apH+1bf0igzL40Y3rnyNNOl+Q/I0hEsM6gxH+gAc+4xpjvZgkIF99AbSYsVWY53bCK1W+0tZGD87zrRq/Vj9xDKmg/P2xcFGXpgMIyTV3KmRg8hT/h814MleZBmCOxRrTexW7XGFd/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rUIMEOJR; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+andy.chung.amd.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rUIMEOJR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+andy.chung.amd.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhs2Q2Bmfz30Vh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Mar 2026 17:59:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C9AE66132F;
	Fri, 27 Mar 2026 06:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71901C19423;
	Fri, 27 Mar 2026 06:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774594762;
	bh=+uYAGgoOPo8bLq2pJEoGgnHWXNq5+Y92SxzPmrm3lx0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=rUIMEOJRSYCB7RucQGG4PaxxD/Gxp+WS5WI2qbdgQUR2Tezsv5UaPTu5Sccjew3BX
	 /STHbYE7fN8R2g8rR/pcnMiqRXxf2EEhaqdzOyCCgBt2XP7lxC+8yh/N1f9oXGJr/5
	 dscnBFVUJrH1CyUTBjLG0OqxI+Vgs/9eEgtVn0zoxpDmQ8MBd+9Q9FCB2GE4cyIPlt
	 HERoddZgvkEx2+vGkrdfTxBaIFLj7XQ+k8K6tGE1mFvY1E/fGMwDNqDZwX7hLh7n+o
	 qLemUUVgm38RIIn76yV/h9dcnjRaXAmDvvjzhhORqyMhSDW6LXLWIosxV7zJJ7/4Xy
	 S+yHbeaC+gZvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6098610BA435;
	Fri, 27 Mar 2026 06:59:22 +0000 (UTC)
From: Andy Chung via B4 Relay <devnull+Andy.Chung.amd.com@kernel.org>
Date: Fri, 27 Mar 2026 14:59:16 +0800
Subject: [PATCH] ARM: dts: aspeed: anacapa: Enable MCTP and FRU for NIC
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
Message-Id: <20260327-dts_enable_nic_mctp-v1-1-5b5c05f4442c@amd.com>
X-B4-Tracking: v=1; b=H4sIAMMqxmkC/yXMQQrCMBBG4auUWRtoU5KAVxEJSfqrIxpLJopQe
 ndTu/wW7y0kKAyhY7dQwYeFX7lhOHSUbiFfoXhqJt1r24/aqamKRw7xAZ85+Weqs8JognHWxMF
 ZauVccOHv/3o675Z3vCPVbUXr+gP88bJ9dwAAAA==
X-Change-ID: 20260327-dts_enable_nic_mctp-e35a5765b176
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Andy Chung <andy.chung@amd.com>, Andy Chung <Andy.Chung@amd.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774594761; l=3825;
 i=Andy.Chung@amd.com; s=20260327; h=from:subject:message-id;
 bh=nPjZUWkxYiROesPBYSRnJtyY+ooYKRCOwqAAXx0E5II=;
 b=426Yu7gf6eNtDB2/x526jYc4Z1JqYnU4txLYevBKxAhEn8zHWmwRTqtXFJAuEiVW5EmT0Xyud
 qS5QpdP/rNHDPpoqYK3BCbkLuAfO8zBi5AI7c0GwHoMl+hQ/Ps7C6nE
X-Developer-Key: i=Andy.Chung@amd.com; a=ed25519;
 pk=X2gaHRnhU2q5hvMjkC6xmIcC03vKNvHY9CQRdsj9ecM=
X-Endpoint-Received: by B4 Relay for Andy.Chung@amd.com/20260327 with
 auth_id=696
X-Original-From: Andy Chung <Andy.Chung@amd.com>
Reply-To: Andy.Chung@amd.com

From: Andy Chung <Andy.Chung@amd.com>

Add the mctp-controller property to enable frontend NIC management
via PLDM over MCTP.
Also add EEPROM device for NIC FRU.

Signed-off-by: Andy Chung <Andy.Chung@amd.com>
---
Add the mctp-controller property to enable frontend NIC management
via PLDM over MCTP.
Also add EEPROM device for NIC FRU.
---
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 67 +++++++++++++++++++++-
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 221af858cb6b..138b081be049 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -584,38 +584,67 @@ eeprom@56 {
 // R Bridge Board
 &i2c10 {
 	status = "okay";
+	multi-master;
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9548";
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c10mux0ch0: i2c@0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
 		};
 		i2c10mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c10mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c10mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c10mux0ch4: i2c@4 {
 			reg = <4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c10mux0ch5: i2c@5 {
 			reg = <5>;
@@ -661,38 +690,72 @@ i2c10mux0ch7: i2c@7 {
 // L Bridge Board
 &i2c11 {
 	status = "okay";
+	multi-master;
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9548";
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c11mux0ch0: i2c@0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// FE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c11mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c11mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c11mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c11mux0ch4: i2c@4 {
 			reg = <4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
 		};
 		i2c11mux0ch5: i2c@5 {
 			reg = <5>;

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260327-dts_enable_nic_mctp-e35a5765b176

Best regards,
--  
Andy Chung <Andy.Chung@amd.com>



