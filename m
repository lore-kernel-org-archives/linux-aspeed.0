Return-Path: <linux-aspeed+bounces-4708-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D594AC5CFCF
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 00:46:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLk7C18bmz2yrf;
	Fri, 14 Aug 2026 10:46:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786622411;
	cv=none; b=VToConkv4Ih7zD1p9BXS68xXZ75OYvIg3wpfy6PVDMk97KWysgBebX2kWr6IAwCGm+SYjamgC47yeR4r61PXSDvDoewphZVngo36DafVEEwBdHaHxGm+91kJsKG3FBSsYYdUwcnNiC2202UCpF8Yd+kvgn5LAoxxb7gqO24V5FIhRM9M37SKB+FTHu+jsGNHx1LykKF/bdhTVY3tl5pZN0DnEZqx7+PD+ItUuh+cn6+xFcZ1+98SWY7dvDKwv4nc5UGpOKNovMq0wBvxE9EmWp3FqGd9zAt2+6x9rR6mpA7csy9wMISZihZtXbnG10PGUNdbwhM1kiq2qpsaXMUagA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786622411; c=relaxed/relaxed;
	bh=Qb9KsJmuphPj+EJzVvySOdWbA7tlqNj0bmjJR+xgdsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KG90h39Aem4IkWXAn5z2xGv+2AOzpUic2O7WZCasoaWvsdPYBPS5mhhiMqbmctz+PsUGswhsBlrDddc3gX/ylvWXokM6Jy8LKqR/99jtwStSr2rLBrdj4lIw8rTRaTh6vDuK7FzFewWau7+MzAkasrJNl95EyoYuz+rguqVWjhxypGZeClHucvPxzXGC2HUf4z7a0xendJ/TMh3PvIm7/10Vvk+mSiyCnxdXCWo6GCbu/3HeJfRWaARAacPGNTOZnrzSqW6qkM4j058NKjmoPuLGNzxbFpqvy5HmNFA1Dbruee2y9DfXBWx3gJtRVFtee7kc0n21Tr7EemvnbDFHew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Omx/1v+N; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Omx/1v+N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLP7D0ZQXz2ySS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 22:00:08 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 31F0C44205;
	Thu, 13 Aug 2026 12:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 645EAC32786;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786622401;
	bh=0w+n+lPjz3WSPIo2NDXp6hSQIIS7CvZuDO3z2haGJjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Omx/1v+NK+SEUZaeuGPngQg8GIpGTOqNf35ORjHSom5wLa+eTDjTIJn+CIceTE5Ln
	 XnLLTxFfFR6TR+Ippd6OaIhicdDjPGgPMyG6ZC5Ja0uR7c6lrBZn1Rt438FJvOSj0p
	 9fFiD5RAFRlze83FEZDfXCD5HN71rm8LT3YG+PE3DNDwhar29rpcGK4bnLRGFiM/rg
	 C5lwdTkh/mY5jLwdd4r7h0Bv/6zHNwohVpId/RRL3dj2QhujwYup81zAbEM8QXNB9O
	 m9Uwd0EXD7BOrkEiClA2i8RULCzIOMfbiTLm4BI1Dzsa32jXDfD8YWCH9oedDewEvH
	 wt/sSoke8cBbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F79C5DF6D;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Thu, 13 Aug 2026 19:59:41 +0800
Subject: [PATCH v5 11/15] ARM: dts: aspeed: anacapa: Simplify leakage GPIO
 line names
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
Message-Id: <20260813-anacapa-devlop-phase-devicetree-v5-11-c7058f63dc67@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622378; l=2439;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=vmghXUBmwzP2rgOwg7WGwWzuzw+iRgP5cEGqkIrQPXw=;
 b=pEFjHbiPWEuuAx+9aKAgOXonLGB9aaADwUMzcXOZvctDmNGlfeDK6UPme8VQqK7e1ouGlwKsb
 soUm2NLhSotCEnIOPDuSe0xobuTniSUSZ/Uqyk8hbrtbeoc2Y1Saz7W
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Rex Fu <rex.fu.amd@gmail.com>

Remove the board location suffixes from the leakage present GPIO line
names. The channel number is enough to identify each leakage present
signal.

Signed-off-by: Rex Fu <rex.fu.amd@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts | 28 +++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts
index f09dd1abe77d..f710046f79bc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts
@@ -111,32 +111,32 @@ &sgpiom0 {
 	"", "",
 
 	/* B0-B7 line 16-31 */
-	"Channel0_leakage_EAM3", "FM_CPU_FPGA_JTAG_MUX_SEL",
-	"Channel1_leakage_EAM0", "FM_SCM_JTAG_MUX_SEL",
-	"Channel2_leakage_Manifold1", "FM_BRIDGE_JTAG_MUX_SEL",
-	"Channel5_leakage_present_EAM1", "FM_CPU0_NMI_SYNC_FLOOD_N",
-	"Channel4_leakage_Manifold2", "BMC_AINIC0_WP_R2_L",
-	"Channel5_leakage_EAM1", "BMC_AINIC1_WP_R2_L",
-	"Channel6_leakage_CPU_DIMM", "CPLD_BUF_R_AGPIO330",
-	"Channel7_leakage_EAM2", "CPLD_BUF_R_AGPIO331",
+	"Channel0_leakage", "FM_CPU_FPGA_JTAG_MUX_SEL",
+	"Channel1_leakage", "FM_SCM_JTAG_MUX_SEL",
+	"Channel2_leakage", "FM_BRIDGE_JTAG_MUX_SEL",
+	"Channel5_leakage_present", "FM_CPU0_NMI_SYNC_FLOOD_N",
+	"Channel4_leakage", "BMC_AINIC0_WP_R2_L",
+	"Channel5_leakage", "BMC_AINIC1_WP_R2_L",
+	"Channel6_leakage", "CPLD_BUF_R_AGPIO330",
+	"Channel7_leakage", "CPLD_BUF_R_AGPIO331",
 
 	/* C0-C7 line 32-47 */
 	"RSVD_RMC_GPIO3", "RTM_MUX_L",
 	"LEAK_DETECT_RMC_N", "RTM_MUX_R",
 	"HDR_P0_NMI_BTN_BUF_R_N", "FPGA_JTAG_SCM_DBREQ_N",
-	"Channel6_leakage_present_CPU_DIMM", "whdt_sel",
+	"Channel6_leakage_present", "whdt_sel",
 	"R_EAM0_NIC_CBL_PRSNT_L", "JTAG_CPLD_TRST_R_N",
 	"R_EAM1_NIC_CBL_PRSNT_L", "",
 	"L_EAM0_NIC_CBL_PRSNT_L", "",
 	"L_EAM1_NIC_CBL_PRSNT_L", "",
 
 	/* D0-D7 line 48-63 */
-	"Channel0_leakage_present_EAM3", "",
-	"Channel1_leakage_present_EAM0", "",
-	"Channel2_leakage_present_Manifold1", "",
-	"Channel4_leakage_present_Manifold2", "",
+	"Channel0_leakage_present", "",
+	"Channel1_leakage_present", "",
+	"Channel2_leakage_present", "",
+	"Channel4_leakage_present", "",
 	"AMC_BRD_PRSNT_CPLD_L", "",
-	"Channel7_leakage_present_EAM2", "",
+	"Channel7_leakage_present", "",
 	"", "",
 	"", "",
 

-- 
2.34.1



