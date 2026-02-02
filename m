Return-Path: <linux-aspeed+bounces-3462-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21321E7FDF3
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Feb 2026 22:55:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4hl45s5mz30MY;
	Tue, 03 Feb 2026 09:54:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769999378;
	cv=none; b=XI1cLNOUzuP/EolHLJHBnSl1jEoirqbWMVMkQuuDbC8IAwE6A7ArqX6Bcs+zu1vOJIl/Ss/kcTiCkFbVXhDHijXZTW/rhq1KNH+sl0Su2aGfLQXJ5wBK6vSzCGhNtYkbujNfGJ3apu1orQmH1OgiEFPIHQui9GgzkB8U5KjbnXrLKSCbvLokuh8UAwz+IGphQoqEPx8PZr0HgoPYQvWx/Dtqbl96hcEO4KX+pLWAHdlrSJlnaPq9lC/Plf7qTUZFTTmeW7L+L4OP+HL2tE3yjnUQdGPKwuQE6x75KvjNOhvglzWtM/SzQ+w3W2Um5IQaPS3Dt8pvXdQcLw4nehGMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769999378; c=relaxed/relaxed;
	bh=bnoxyPKF+Rg8GiRVLp5t4eHLstchzXA+8KDyAQ1KtpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dROTH8ygVyugawYiQMxGYfmcdr1BBuMrslspaZ/JkNDEA6Jf1qSFyaEMtt2+5K2y9Y5PObieH6/Yup3JvmSFDHk0UXPiqN4hATaZgz59IgaFPAGLJNBpiay3hwGY9yI1FhrAxqkTJTWM+cH1SVmfxA9M/IcY4T6b4AJUyh6Mv2kgsjsiXb5HJFFEnrjWDaeGd2YcxxILkoO7W0NjacQ0PmQ8KhW3SKsmES+0QPb09LY4Sr17AHrwtw7a6/sw7AH3BcvzStdWGKhByAKJxVOgw7CQloAdkPn7uotrV2TWQ0VP2m1bNZ5cmOusJW18N/7nUHHom1jToQQmY05SoT2elw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L4MM8flN; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+dirkchen.amd.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L4MM8flN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+dirkchen.amd.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f49YW5gYVz309N
	for <linux-aspeed@lists.ozlabs.org>; Mon, 02 Feb 2026 13:29:35 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4A4A74034A;
	Mon,  2 Feb 2026 02:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 207E1C4CEF7;
	Mon,  2 Feb 2026 02:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769999373;
	bh=/3ftTjYL9LKJOXS5WEGQ0d26TpXZp1EuCYw55ljuW48=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=L4MM8flNYr9Lbq6j7XSlI9aj2uqqSx7+X2B5pf+kPBfQh+Zzt9rkgNWCBO07pf7k2
	 t8X+q08BqvJX0MI8NCWAY3LXv54sAKWybUNzBJirkTMyksU6VuBMlr9ZBrLZ3ISb9d
	 LYvQb5chkC8jv2hnH8xjuRSWRZU6WQhqz3g5TVHlMienjnKq5Hp43bvRyGZHkAUIBe
	 /qV5DHEyHj8FPL3JLLceZpdh6ruNwLRWxQUcpOjA8Ml0mjUrI6h5pTRaVQUqnp11bl
	 EvoQYtEkkxVp20fMZjcCBY2CJu68qhyKJfqwqh79ahfJgyc6Hi0hN7vDtBh6l0PZnd
	 EnE1VZwzWimIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C9FE6528B;
	Mon,  2 Feb 2026 02:29:32 +0000 (UTC)
From: Dirk Chen via B4 Relay <devnull+dirkchen.amd.com@kernel.org>
Date: Mon, 02 Feb 2026 10:29:31 +0800
Subject: [PATCH] ARM: dts: aspeed: anacapa: Add retimer EEPROMs
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
Message-Id: <20260202-b4-anacapa-dts-fix-v1-1-20d4b0114854@amd.com>
X-B4-Tracking: v=1; b=H4sIAAoMgGkC/x2MQQqAMAwEvyI5G6hVFP2KeEhrqrnU0ooI4t8NX
 gZmYPeBwlm4wFQ9kPmSIkdUaeoK/E5xY5RVHayxvVGg65AieUqE61kwyI3WDCHwSK0zHnSYMmv
 +T+flfT8yIKM9ZAAAAA==
X-Change-ID: 20260202-b4-anacapa-dts-fix-207ffe9a3b0c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Dirk Chen <dirkchen@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769999372; l=1234;
 i=dirkchen@amd.com; s=20260202; h=from:subject:message-id;
 bh=7UiIsc+JRhKInxcNGMi5RJgMeig8fwCF34V25zBzaew=;
 b=HGTsrHSELPFy//GaIT4xCbcD3IxgB5enkX4xOed+Zt76V75ZNZQ64nOSSHnJjSMBUOjfvCB/4
 hI4PMdUVGWHAtomTjdx/g4w4bDKOJ/GG9o7vnEZsj2t4I6+xPqEA2+p
X-Developer-Key: i=dirkchen@amd.com; a=ed25519;
 pk=NBIyLsVg/YYtGLruq9XLdLWx2PP/1MH4jDDQ1V+7wes=
X-Endpoint-Received: by B4 Relay for dirkchen@amd.com/20260202 with
 auth_id=622
X-Original-From: Dirk Chen <dirkchen@amd.com>
Reply-To: dirkchen@amd.com

From: Dirk Chen <dirkchen@amd.com>

Add Atmel 24C2048 EEPROMs on i2c0 and i2c1 to support retimer
configuration. Follow the same compatible string usage as the
Facebook Harma platform to maintain consistency across Meta boards.

Signed-off-by: Dirk Chen <dirkchen@amd.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 221af858cb6b..b8d248d99d7c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -328,6 +328,12 @@ i2c0mux0ch3: i2c@3 {
 			#size-cells = <0>;
 		};
 	};
+
+	eeprom@50 {
+		compatible = "atmel,24c2048";
+		reg = <0x50>;
+		pagesize = <128>;
+	};
 };
 
 // R Bridge Board
@@ -362,6 +368,12 @@ i2c1mux0ch3: i2c@3 {
 			#size-cells = <0>;
 		};
 	};
+
+	eeprom@50 {
+		compatible = "atmel,24c2048";
+		reg = <0x50>;
+		pagesize = <128>;
+	};
 };
 
 // MB - E1.S

---
base-commit: 4c87cdd0328495759f6e9f9f4e1e53ef8032a76f
change-id: 20260202-b4-anacapa-dts-fix-207ffe9a3b0c

Best regards,
-- 
Dirk Chen <dirkchen@amd.com>



