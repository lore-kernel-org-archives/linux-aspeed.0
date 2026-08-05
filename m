Return-Path: <linux-aspeed+bounces-4628-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B76C55ABF
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 23:58:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFnRr0Mrlz303D;
	Thu, 06 Aug 2026 09:58:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785935000;
	cv=none; b=AwA/LgZ3PGSdWpf6dhvFzPE4r5QwDCJXs+bLTUhGeVJtazQfYS10n324YQ1x/yBqpB6AXzIGc9dNlteDrtgUZg9q9iL+vMXSDTlk1Nz8afHhkoiUJ+zpdPBAD9fRzWbGr80CXIZZbLMCxC63nCc1a+j/O0OUve7bVUr0c+NOMx51oW/QNjvt+v89vqCtwuenzjreXGmQOc5khQZJ2UxzIMzggUmwJ8Urs/rkd6pGb35fqG2uiSs9N0SefYeUD6imLNXVNSrO+qnEejJfkN3+FBTWinwP5Ul0nV5VGh1TEjmkRdlUtALHd5+gGwNIMvlkSjpgkWEh6FtnFBZjxTth6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785935000; c=relaxed/relaxed;
	bh=zpq+fvaxWT022GHhy9WEKHR6+wO3c39jKiNTeZbbOZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nL6chNMBFPgQv8RgfS8nStHlfIRDKgcplDeYdhmngwLJoSWrtunEYvshAgKjynsSEWshyMrD38lnsulKvv4peVVrOQctokQiTGAz0ETFcrQ98FB2rLM+JujxVBhwN8siF14e4DPfNl3VI13ebK1Lca4GYyIm5lFcBtg1xgjV5iUuwhAcGubyopyvph4KAN6TlbTlCg1EOocM56muJDJVKiDiKwGOEy/N956nKR6MoFkyK2KEguCCeNFi0kx+mk0JZAExib/p4leFLztsymP6J3cmt2VVsoaWa3gMKZVtKaE12Tsw7dy/+zUkz+uS7Ee2WQQizeHBBnipQo7vpB1vuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LpzPpe+C; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LpzPpe+C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFVvq4qwsz2yMl
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 23:03:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 75CC443B70;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5657CC2BCFB;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785934989;
	bh=U/VelihwE9/Y5DyVuu89kZaY6Foh61jZ62a+Hvygccg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LpzPpe+CglNuxiT2pA5APAQP3umTEsbMMl5KOL0dAnhHgDmHgy0u5px872FsO3gY9
	 ejAE5kJY5R+CbefIjHM9sZpBklvujVmGnwcZlMkIrFP3a24nWguJWNQ8JDgzOJfMA/
	 ynbhErm7MmznT3x24isy4/GHKj4kd8Gi+TSvGwom59qYf2m9/EAUtJWVtg7j5w/oUW
	 J0jwlaiEp88NFlKcyFXankhFNP8TNoOQoMR65wod26W97bzpOBUsjqo9cPob/WhoE/
	 H08LMnIKXW52/QCrL6Il3B4v3yKuY+y/d0V7tULk8FVvJjCkKWBNKQvsmlFmeiInKw
	 IhNZODu55LCDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45330C56205;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Wed, 05 Aug 2026 21:02:36 +0800
Subject: [PATCH v4 08/12] ARM: dts: aspeed: anacapa: Enable MCTP and FRU
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
Message-Id: <20260805-anacapa-devlop-phase-devicetree-v4-8-5d67e0efa6c5@gmail.com>
References: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
In-Reply-To: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Andy Chung <Andy.Chung@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785934963; l=3214;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=BGZCKTF8QAag1qskLE0ofPzySUEOSMb3NZgJbIMmwIo=;
 b=MpjikqOMq7zVXHAewpVwjarArr7otF1/OoOdZn2NtUC0MBbZ2MTzXrXKWYlc58Cq8PNSO30Fk
 uc7L3qxtYXqAKMDtrJBwbimeTtMwDSdYRLMzclKn5H+D1fnXnWJcYt/
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



