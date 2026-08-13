Return-Path: <linux-aspeed+bounces-4711-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB66DC5DF6D
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 00:46:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLk7D444Hz2yrS;
	Fri, 14 Aug 2026 10:46:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786622405;
	cv=none; b=YhynMeJeiE3dcVduJj8rm74UJ4bSjEyqWsRfmc8oabZwchiUm1YKnSk2jgl9mKGQNXP7FAvY7IwH34ik3/mfY+KzXXXVhdTUHpAEgj6w2A0yncHql/jyP35Uet4WIdt1mN8+PlGqiae9CLnm6yT91oVX2E81s9976BWZyX0U1WHLKd4ygsn3q4W9iFy5em4hK1kcFs8Uf7NTlRliFR3bdJ4BFvyITD/ktcOJTj91Q/pcTdZzH9tkQ1A3er8dgClBDNbgpkIJhA1orvXf0JL8kne8lArWxtQN/7KuvF6BufnbWT74Sxr9+ZzFQNn7O/UySQA51w624fb4/6TQuYM5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786622405; c=relaxed/relaxed;
	bh=z703ha9BCDZwd9WOBQAY2H7qH7O087rLCV8nVIAwz7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LGAthWXR09HcnfwveyGx3wxHd2tkCkTMMavbDELJLJ6u7WQU2qi1UsQpmZ2sJx/bJKipjmpbwlBnlv405Pt1O8QfxBLwBIJy3b6UR7ruC4ht3kuy7TrXGAgoPEEnm+TFsVTisqoPXPGs1K/NZIbthZlXQKcV29SL5GJNUmLzbCZ0xM4MvtzpjOSSmgjvIFfGIJDo0PhFqnbCtf2KR9/o+uPKIZXm+lZ23k6L+bKqexCJ+w0N3ei5w8uPtqAYFDLw+oXcUW8U5Mku5/X7eRkdXWljrUdeo2JhqeFBR00wLiI2hMGX3D55JQczoK7vSMrYPEiQ3+uGtuN8qvA/8pP2Mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lvkB3xA7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lvkB3xA7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLP774Djlz2ykf
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 22:00:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A0B2E4405D;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25CC0C32781;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786622400;
	bh=k65C478t9LS6ybUmJ6TjN8D7vgzFZCksmeumxEQZ8Wo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lvkB3xA7ZUggxd62T2EQdw29xvWCTWX6bJJz+bv5e3lV5Z5jjg4PIz44Z8PaKqAqe
	 URTHnHOZc4VJYwisaeW4yRbtSRot98AoINoaiUHClmGXbo1aZHTAD541JBgcqpC3IV
	 JLX2droK/jfcTpvsYfL3olU73L3YrAaQah23BFUlSdhP/APMRU/Jbc9o5RH1wQuG25
	 PWuA9UseUiPj8e3ZvrlvLXK++5hk1bjtJGO2qr5CZk0+Fhq9zlLuXAlRvJmAjT+3P0
	 GEGPeU8XxXdn2UyK/OjokxrglaGBOUoDXIdeuaEZLbDW5O5x4Dv87otw6K+WyOVVVX
	 Ky4+5mwTGH13Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A0C5CFDB;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Thu, 13 Aug 2026 19:59:37 +0800
Subject: [PATCH v5 07/15] ARM: dts: aspeed: anacapa: Align PDB fan GPIO
 numbering
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
Message-Id: <20260813-anacapa-devlop-phase-devicetree-v5-7-c7058f63dc67@gmail.com>
References: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
In-Reply-To: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Rex Fu <rex.fu.amd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622378; l=1875;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=3/IZc5ckSnwOY8uhbyA0jZSDZ3Dvh/PJORxqtTJG7yA=;
 b=Gi8/BUaK6w/lKB1qUOTSspYGZjOdu9INBp5iNvnYDcG7DCdDLt20S4ocFvStYtDvtxWDm9KIa
 26YnUygqETECBixfRo80FOtfZv9WwQ0KpDk9+SXwm+/70w3t5dDt6+y
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Rex Fu <rex.fu.amd@gmail.com>

Update the LPDB and RPDB fan GPIO line names to align with the platform
fan numbering scheme.

The LPDB fan GPIOs are named FAN0 through FAN4, while the RPDB fan GPIOs
are named FAN5 through FAN8. This keeps the GPIO line names consistent
with the fan inventory and platform-level fan numbering.

Signed-off-by: Rex Fu <rex.fu.amd@gmail.com>
Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dts    | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
index c7bffa7c6557..ff393ad7cdb7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
@@ -8,6 +8,39 @@ / {
 	compatible = "facebook,anacapa-bmc-evt2", "aspeed,ast2600";
 };
 
+// MB - PDB
+&i2c8 {
+	i2c-mux@72 {
+		i2c8mux0ch0: i2c@0 {
+			gpio@24 {
+				gpio-line-names =
+					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
+					"RPDB_PWRGD_P50V_HSC4_SYS_R",
+					"RPDB_PWRGD_P50V_STBY_SYS_BUF_R",
+					"RPDB_P50V_FAN5_R2_PG", "RPDB_P50V_FAN6_R2_PG",
+					"RPDB_P50V_FAN7_R2_PG", "RPDB_P50V_FAN8_R2_PG",
+					"", "RPDB_FAN5_PRSNT_N_R",
+					"", "RPDB_FAN6_PRSNT_N_R",
+					"RPDB_FAN7_PRSNT_N_R", "RPDB_FAN8_PRSNT_N_R",
+					"", "";
+			};
+		};
+		i2c8mux0ch1: i2c@1 {
+			gpio@24 {
+				gpio-line-names =
+					"LPDB_P50V_FAN0_R2_PG","LPDB_P50V_FAN1_R2_PG",
+					"LPDB_P50V_FAN2_R2_PG","LPDB_P50V_FAN3_R2_PG",
+					"LPDB_P50V_FAN4_R2_PG","LPDB_FAN0_PRSNT_N_R",
+					"LPDB_FAN1_PRSNT_N_R","LPDB_FAN2_PRSNT_N_R",
+					"LPDB_FAN3_PRSNT_N_R","LPDB_FAN4_PRSNT_N_R",
+					"","",
+					"","",
+					"","";
+			};
+		};
+	};
+};
+
 // SCM
 &i2c9 {
 

-- 
2.34.1



