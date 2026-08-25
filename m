Return-Path: <linux-aspeed+bounces-4855-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4963C61DBD
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Aug 2026 00:10:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hV4mx19Hpz2yYf;
	Wed, 26 Aug 2026 10:10:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787654928;
	cv=none; b=d7YGi59vhFs6wmYgViSinC4aMrUQAege2f4fc9CJjcI0cVg5N/VWDOairW/DRDpNz+YZmZQKlVggqUEUpFUbaZnAeX85DDT5wpLDqn2KT6RJUHpHc79c/9VlJ0bbHnXi6quvRz1BB3SQUxDC397lQmUh/p1n+3qxPAT6otx2MG9MJVVrzE4ABINQY3m6/xBXc/bSA1HtI6dFEJzS+D8sLomURUjEwR1w26nmUoA7V1JHx9M4u7ad4XPrAOk5VMif/dAsDEKQoLDwCnNmXiRPdOB/Ge10KrPmhylJrPOjj4pnnX2L27FRxh6OmZBCur2zKHH+XUWpgkLHOINH+WrrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787654928; c=relaxed/relaxed;
	bh=8vm/tFG0jcEdeszT5mc3nH/5Nm+jDbreu6jGo7uSg0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ndh5jTJZMrJEYReuwyOF8qf41u+bcbzH4b2dSE7OeK8tXqH67E5JhO9qLiQ9354Usu0N2s4X1d/XH0e1JHrngHM5klv/BeNpmvbNwWyDV5AIL+9vxgRKkZghVFRcujAIi82Mx7Px8TjJVAd92iX2jUTkpcsx+5mw5V5zRzLMNsO2gVdLjFiMZAv2Vz/Crgzdw+cqRvp1mmX2kyhHcQuwjUL7PBGJY3sU+rpocrne3rAlSSzfwis+IwSTHx1ZSawIQ2XGSB60S2I6gs1Ltjb5qqxZkGcdXWtllh5Uj9idiRfATGQBIsYpplyj7lkHXfw/z7H+6JFvKncnB+UWq5t56w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IUxwx70l; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IUxwx70l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTkzN089dz2yCs
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 20:48:47 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 28F7644FA9;
	Tue, 25 Aug 2026 10:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F15F2C32782;
	Tue, 25 Aug 2026 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787654921;
	bh=dj1B1hTIr0JbwjzIMS5vJwUU/R6EmWMLYvzeTP927xM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IUxwx70luGRlYFIibBUWPmYr0EHlvkOrOClbR8/Yj3bA+PYtrCRh3ko2HOIYPa0k8
	 eISZwUJYEOrgrgYtKynU2ImGSUvvvRftL6svjDRT4530SCqxvZu8hkaurIGy202Wt0
	 rppyYS7/blTHWLYmVT72m6zF1eD8MV59LaVenWydfe0UEzXmiac2kQj9RLc3YTcd42
	 RqkxLI9zuhVEzfEh6ZLFPYhvhvdk3/wyJXu2y59KfiVYx4rFglS+kIf4HSduX0ivdX
	 xAm6OX++FJUUtr7YA0j5vJhkBWeSS6yxY7H7BCJUluxu3phxpIqzKq/9/1+yge8SES
	 8OjzTYsIrHNEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA75C61DBD;
	Tue, 25 Aug 2026 10:48:40 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 25 Aug 2026 18:47:52 +0800
Subject: [PATCH v6 11/12] ARM: dts: aspeed: anacapa: Simplify leakage GPIO
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
Message-Id: <20260825-anacapa-devlop-phase-devicetree-v6-11-9059a2a279ce@gmail.com>
References: <20260825-anacapa-devlop-phase-devicetree-v6-0-9059a2a279ce@gmail.com>
In-Reply-To: <20260825-anacapa-devlop-phase-devicetree-v6-0-9059a2a279ce@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Rex Fu <rex.fu.amd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787654905; l=2439;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=XQDIFJln5LUr5je4HHMPl/KkFoydy7hdQv6lmXRo/nY=;
 b=JJh19acHLjk6BIqON54AAAJ6nyD0BvJmNb6ViLscQ/8AMPUHM5zo2qxzukGzxq1vXpnX1HRLl
 rJym+UyEozwDubZhvHJKaJGhhJ7VjojmhoM6Sp11os25nYIsPTSEqZ6
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
index 923954cff7a2..ce5aecc984c8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts
@@ -115,32 +115,32 @@ &sgpiom0 {
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



