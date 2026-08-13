Return-Path: <linux-aspeed+bounces-4700-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD3DC5B572
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 00:39:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLjzB134gz2yrL;
	Fri, 14 Aug 2026 10:39:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786622410;
	cv=none; b=E/wQ7OgKixyxE38YQ55dXuekmJLu/SP3mjCqyg5QyFXzyqNnFwEPF7x8HEr22GmE6AUmy2kiLkdp6OJaA8hOk0nmXMMGzt0pYGIJVA4Xbd2VRJrJuP0zDDX9tW6hW8EDksiDJ66CbDIvw2EM4wrc0LzIhktw7EBVN6M280iUbg00b/WGBpf8Azrt/lzF3FLZW3gsiYcpsWf5s0PsUa1IbODgtPP6Qc/dzi4WD/XwhtFOZSucFXoNaLBUR7wfZIrIof+2DdQ+wV+RRjLwUhsxUFa+72oE5yeF2c+S5NESI8Gt3+OpXgIYW8w9XpN/HH/6VHVhT2neakFyHMI3QXQ5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786622410; c=relaxed/relaxed;
	bh=zpq+fvaxWT022GHhy9WEKHR6+wO3c39jKiNTeZbbOZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KWJpPrl+oZXBRuFpb/WHRJqF+vA8D09igqKSbLfJqb0jgMti/FFd7fuij/Q9A+S+b2CPMhB/L9n2WfFgjt8wgBXjipLlpDoJZ947Hx400U5doCWXvZZofVtGsO6DxMA9PnTwoKOIof/qv1xYlmF5e1irgp0A9QoG7c5+JgeyNMPvn9JzNQfGHB1jm/cDTGIzmJxbMT+3IoIroMfQmmmplxakP6D0yOMhxlCilridmEFPizH3xjNloI3xXJCU8SBvUC+uNMAiPJBFnl0KXzA7ClQ+NVwTW0chm5eaF9MU7czoy1MtKvn0wGkiZZh8VsIyF0q8cCNp9OD5nar1T+BwXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j+KMOlEy; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j+KMOlEy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLP7B2zbxz2ykf
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 22:00:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E21B84408A;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B776C2BCFA;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786622400;
	bh=U/VelihwE9/Y5DyVuu89kZaY6Foh61jZ62a+Hvygccg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j+KMOlEy+u60KRacqH0Q+y62+8kT6IomOsLPPe8Yyk6gEoDjvWp0qlDPBB4hAXC64
	 pYpGhihgkxdK6WRNK7QVF9z6Bvtb/r71W8jbzTAhsC61V1Oj3lr4lO4aqcWMBjQ7c/
	 k+W0fix1lXhW4mDhf6o416yg2yVLBERRrWgsQYcR2o1BbfaK7pKLCzVYCmTLYJ7SLs
	 sWvS1T3LhhKnR4lZHXOVzuStlcmhhq74KuOavqdhQk4tF7pnjXiCfJrN22Icde/2gA
	 g6a6oibg8UkPIT/YMdjkY3RStAMLLj6U99bb5njJ8gcUP5Y7IoI1barNv0kAF5hBsa
	 HLvx57NNVaDMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1855EC5DF6A;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Thu, 13 Aug 2026 19:59:38 +0800
Subject: [PATCH v5 08/15] ARM: dts: aspeed: anacapa: Enable MCTP and FRU
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
Message-Id: <20260813-anacapa-devlop-phase-devicetree-v5-8-c7058f63dc67@gmail.com>
References: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
In-Reply-To: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Andy Chung <Andy.Chung@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622378; l=3214;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=BGZCKTF8QAag1qskLE0ofPzySUEOSMb3NZgJbIMmwIo=;
 b=tRnCdt4HSTs3hCltmEhSl2IJBUqZkdHlCNGz1d1Sabm22vJGqKb75T93B8qcX0xc4HkM3vwlY
 ISTLQn7AdYgCzKvzR3UwUsQynWFKP2PSEpnvc/tFoR7VwEn963jPVMO
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
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dts    | 119 +++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
index ff393ad7cdb7..703284721224 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
@@ -8,6 +8,25 @@ / {
 	compatible = "facebook,anacapa-bmc-evt2", "aspeed,ast2600";
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
@@ -55,6 +74,106 @@ eeprom@51 {
 	};
 };
 
+// R Bridge Board
+&i2c10 {
+	multi-master;
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
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+		i2c10mux0ch2: i2c@2 {
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+		i2c10mux0ch3: i2c@3 {
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+		i2c10mux0ch4: i2c@4 {
+			mctp-controller;
+			// BE NIC FRU
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
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+		i2c11mux0ch1: i2c@1 {
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+		i2c11mux0ch2: i2c@2 {
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+		i2c11mux0ch3: i2c@3 {
+			mctp-controller;
+			// BE NIC FRU
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+		i2c11mux0ch4: i2c@4 {
+			mctp-controller;
+			// BE NIC FRU
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



