Return-Path: <linux-aspeed+bounces-4636-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BE8C55ABF
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 23:59:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFnSk4rxVz2yh4;
	Thu, 06 Aug 2026 09:59:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785934993;
	cv=none; b=kJ5XUIiC5BUlBdpJVjSzmgdmLPk44Il1hCtXy2xEGvc1vziwALeyVBAalqCksprC/NRFdFzKYF5e9bg5smvShAwIhbM1HlSh+s7D9eKpbZkFAuBQ7Xli3BZqOqMyRbMrWi6V2BYgxG7j+cZIBadBWGHuEfCi+EnwgOJ6KFLTneh+nqPOU2EVayNO/WwPkWT8vYAX++02HoTBV99R8t8TBEXJrzG/e8tHcGtgc1GEiJjLkQ3DkVKsGuT1catoEq8MspB9GYuRKTIIJtuklLXpVUBbClk7o2/nTRq6BlwNHLcWNfSrmiYPxJL6jtIYFrBIX7HxBaSi3N4JZbkvhN/upQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785934993; c=relaxed/relaxed;
	bh=Qb9KsJmuphPj+EJzVvySOdWbA7tlqNj0bmjJR+xgdsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=il4egF1amwqQO95MQra0cUDfWGXgp6mevBXuMLggLSuYgN0M9LJ4OFzHbTwEVJE/bfsNiD0Zi1jijOrCxxmXlOEusT4/g4stsJX0LopIXDdzECPxuGcozLf6hx96OMftDkPZLEUBzeV1CQWFtZiQ2JXSNHCPgga+ZPaULh74NfvNjzjrzDjdTnkbARg6vtWDuXAOfZfpzz6X3XyBIKsrsuByRohxiF5fJKTiBIbJ6N8lQQ2qdbSOpKcG4mlEsy7agvDZrgEEhbY8KgHP2lg8+plu0hvCF8RIkVp/20a3m0qCLhDcRlklUTAfUaxGiOF+DL7rhPfExIIVFl61DUDV7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J+FODLMK; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J+FODLMK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFVvh4Xgfz2ySW
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 23:03:12 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E3D8860A8A;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96CF3C2BD05;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785934989;
	bh=0w+n+lPjz3WSPIo2NDXp6hSQIIS7CvZuDO3z2haGJjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J+FODLMKTmgNAeJBNptOobGpd/5SKQldBH9uAeSgQXEMGCbYd8erJtgiFIi5eh/9Y
	 e297kJ9EbnwWzwGwOXcmeMX6EcY7R3JKF8IVf6PDprc7yX0wPTNtTdntjHUVJrL71j
	 VCvrE26/xxpu6qi8Mywt/S1A9TLp72MQrT2GGhhyznXqvZSsozYm8ViF1Ld7X1B8TR
	 E0Qd5+NlZOYNiULbfro4CxeLGbVOLNf/UCjyr3/lIvwFnomKPrnYVcB8iMIT1iVJn6
	 JCaKCeeFrSNjqCn2jGvt89avEnFWL0o+kTOmewexsB19jH/W0MBfXClOl1Lv6+MJsE
	 huKr3GUWy6gBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8487CC55ABA;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Wed, 05 Aug 2026 21:02:39 +0800
Subject: [PATCH v4 11/12] ARM: dts: aspeed: anacapa: Simplify leakage GPIO
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
Message-Id: <20260805-anacapa-devlop-phase-devicetree-v4-11-5d67e0efa6c5@gmail.com>
References: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
In-Reply-To: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Rex Fu <rex.fu.amd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785934963; l=2439;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=vmghXUBmwzP2rgOwg7WGwWzuzw+iRgP5cEGqkIrQPXw=;
 b=lYkSmtdWOulgcjWFT7dVAobVXYRqBZUmA/Uo4cUne5jpvs8yitJrNubRm40QbbsJsSq6pEsCO
 ckmop/r0c2cAl/JhRTGpkewDg7Fcerimo/SQB3popOyIdrW3qtGvg8i
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



