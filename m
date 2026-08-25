Return-Path: <linux-aspeed+bounces-4850-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22CAC61DB9
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Aug 2026 00:06:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hV4gH4hNXz2x98;
	Wed, 26 Aug 2026 10:06:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787654927;
	cv=none; b=kPWMp5hM6S9+9c6OIN+JbTIrF/IJ29BtfQDb/gt6wkCljGEeAib3K0G2l3xK/tKDQwevwmpYDP0vDJ5LIHw/2gCouNXyeIBCSg8UiciXjH0Oxmw4l3re0nJsP7wDa2AQIX+RP/+SkWZ0isgBFz66lVeLceTuHZsbjQ6v0Nx/1Qg4wI0BWf3brod6tjFtS0Id4vh6GobpHkTrFtKtxlIPjYpcaQGzK8dPo5/0gdEfhrYAzEp9n9iSIapy6g71QgndXe3XM/pZlvUgF9fncXOmkYPbhWK5xEM1iedK//BmjnrnjXLNV94M+isO9qnK4Lf7RF+WjEV1mF2eXgeHnlxHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787654927; c=relaxed/relaxed;
	bh=Tj9M/n7WtGJJQGjBJtmrJynwtO9r0cDKfRTR3sBGYmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AW28fQdiKQdEhsKKYmORdzVKUzaSEW/RMm38U8yEut+VuiibRNfbVS1I2iJdAZcqJQbPVeqo23tNhK7K5iZv1/5ZuK28B3V9dqphyS8xs4SufdJn9dnG/BrasLILQI7K7OWHjhIlvxNKUWwzHZl59o0qDShnshbtaGZcU1Wt4o1Yv3d9gUL3BRpk0AObu6q7qZ6heUXoba52F0L3sutqdBKnVDr4jxujdr7fj1VrWmO5oLoLlctIY15Pvw9yRLK9M2pUByVfM5E0otppunKV3FKu6Nwgit5AnAYa73+w43eM7OsQDq8G8pbvI2XCsGrkN1F2PJ9Pwl1BTbS+w0ZF3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ldg8AWTC; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ldg8AWTC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTkzL1kgCz2y2h
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 20:48:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D16A5431DF;
	Tue, 25 Aug 2026 10:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1390C2BCF6;
	Tue, 25 Aug 2026 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787654920;
	bh=x266lsRftT8i25oBXl2ssgbHQhGOw8P7oh+KboxNXTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ldg8AWTCDVogCcai4gszswCHs9eSDdODDdRjahUKw3ZX/AU+VXyQoXQxaTQ7mO15M
	 evp4etERmhZY400cY3ODC7ayCmsRTDTqmwweKSikykjssHTATj+x6kEn/8f/4Yj8nv
	 qTHSMLkk9gNZt+XkpvU07XKpWzMLT1Ajs0NMfNOMYbmrIYc5xQOTQJG9nGP0uXxmKT
	 YwwL5llv8UorvLq5tzlQBY1G/e44sRy6nPgVKUjTe0aaEcXEXzZQ2CwyO4kpralhr4
	 PpEDGyTxJY+2x0XM+pCnt90G41uWMD9MWgyKbuq7PA9tIeH5T9WsTn7yoI5arYBcGe
	 1WxesrBuTUjVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA3BC61DC2;
	Tue, 25 Aug 2026 10:48:40 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 25 Aug 2026 18:47:49 +0800
Subject: [PATCH v6 08/12] ARM: dts: aspeed: anacapa: Enable MCTP and FRU
 for NIC
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
Message-Id: <20260825-anacapa-devlop-phase-devicetree-v6-8-9059a2a279ce@gmail.com>
References: <20260825-anacapa-devlop-phase-devicetree-v6-0-9059a2a279ce@gmail.com>
In-Reply-To: <20260825-anacapa-devlop-phase-devicetree-v6-0-9059a2a279ce@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Andy Chung <Andy.Chung@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787654905; l=3240;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=dOnAmtbd66IVx7oXtqFQ1g3XoTMO1Ryg0F0x9FVbMP8=;
 b=ftyDPTkjdoGzotF4l5iWYs6uhTqylEgD5qyrES/Ylqri27+Dso7FI2I0uqGRiBcqYUp1nMkgc
 Dw7Lg2km/n5BgNptYTxctfAUFsGd5PPJiJW0yhYnmlyaZzPlc0+/kUh
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Andy Chung <Andy.Chung@amd.com>

Add the mctp-controller property to enable frontend NIC management
via PLDM over MCTP.
Also add EEPROM device for NIC FRU and reorder the I2C virtual bus
index accroding to the system silkscreen index.

Signed-off-by: Andy Chung <Andy.Chung@amd.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dts    | 137 +++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
index 7c641a79f63e..7fe8d279202a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
@@ -8,6 +8,25 @@ / {
 	model = "Facebook Anacapa BMC";
 };
 
+&{/aliases} {
+	i2c36 = &i2c11mux0ch5;
+	i2c37 = &i2c11mux0ch6;
+	i2c38 = &i2c11mux0ch7;
+	i2c39 = &i2c11mux0ch0;
+	i2c40 = &i2c11mux0ch1;
+	i2c41 = &i2c11mux0ch2;
+	i2c42 = &i2c11mux0ch3;
+	i2c43 = &i2c11mux0ch4;
+	i2c44 = &i2c10mux0ch1;
+	i2c45 = &i2c10mux0ch2;
+	i2c46 = &i2c10mux0ch3;
+	i2c47 = &i2c10mux0ch4;
+	i2c48 = &i2c10mux0ch5;
+	i2c49 = &i2c10mux0ch6;
+	i2c50 = &i2c10mux0ch7;
+	i2c51 = &i2c10mux0ch0;
+};
+
 // MB - PDB
 &i2c8 {
 	i2c-mux@72 {
@@ -56,6 +75,124 @@ eeprom@51 {
 	};
 };
 
+// R Bridge Board
+&i2c10 {
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	i2c-mux@71 {
+		/delete-property/ i2c-mux-idle-disconnect;
+
+		i2c10mux0ch1: i2c@1 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c10mux0ch2: i2c@2 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c10mux0ch3: i2c@3 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c10mux0ch4: i2c@4 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
+// L Bridge Board
+&i2c11 {
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	i2c-mux@71 {
+		/delete-property/ i2c-mux-idle-disconnect;
+
+		i2c11mux0ch0: i2c@0 {
+			mctp-controller;
+			// FE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch1: i2c@1 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch2: i2c@2 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch3: i2c@3 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch4: i2c@4 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
 // MB
 &i2c13 {
 	i2c-mux@70 {

-- 
2.34.1



