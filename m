Return-Path: <linux-aspeed+bounces-3461-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C76E7FDF3
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Feb 2026 22:55:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4hkl40zpz3bjN;
	Tue, 03 Feb 2026 09:54:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770013878;
	cv=none; b=k/lRaNvxBdK8BuEgFxMQInm5yRGKthsxAZZo3PCEH+7qgxt/9qQW2GvUPZwBOCzQKbTgqcL5tCJ1IdvGpQKVEc0gAoFtof+Annu+1m8lPfQ6avD1oQ70a1TKt22LhbrNruxvc6vpU5tvtsXda4fQkA77e9dunSyH1YBt7CKITzMsZAV9a0mzd2HVGhLKHq/RoXK39DfoydpBS1utD7VGjfzmUP9lzSFVD70KKbY6i4kWsNV8A1bEpLk109Cqmuua6g9sEQcb5CkxFhns8Att1WltoK+UvkZvAG43EEd12Z1exaZ8QUFYB7QGbKZ1OSW6LrlYalI7ub51y4fe2Ik6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770013878; c=relaxed/relaxed;
	bh=sv3rE1ysKqQy3NPOcV7JVfxCOKmaA0B89vDL2+rHKJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oMykonX5NdAXtJi3ijExrvEMbaKINw4cE7NfCjPTr9ah183W9VpdGQtm9DT/b10YK0ibG6Dpx5EDvREXosh6JANSiaBUztqIW49NFuovkITNlsUaiUa4qH8+58szOpwbgh1kIYdgs4/K7vbEzShC1kuBI5QJrHndVHwkMxwjSqUdpPr9d1J3tbzCZEe2bF5f+divAmBwDSASiIbm0Zh+lu/wsFeE8B0rrw9RTbObHU6+Wv1WF6bAazAZcZheW/t8T9Mm705th6DNpdG3iC9OA7wUOw2rrV6PmjTtmJvsJJObOS1ULLy/Cw4cd1e0C0llETNszQ//Zw3H6sMZm2aDZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=G9W9Mzkf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=G9W9Mzkf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4GwP4ssYz30BR
	for <linux-aspeed@lists.ozlabs.org>; Mon, 02 Feb 2026 17:31:16 +1100 (AEDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c0c24d0f4ceso1571090a12.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 01 Feb 2026 22:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770013875; x=1770618675; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sv3rE1ysKqQy3NPOcV7JVfxCOKmaA0B89vDL2+rHKJA=;
        b=G9W9Mzkfh+Gbc6scbBBLC+kNLKzqgeHyngkoBJkhT9Kp3uH8iGonc2wqF2SPxG2lCv
         +dHAEiWjjAj2d6MA4aQCmd42T0K0LiNfnS1aFnxESpW5E2FCeWcPw1x0uLmAxdEv5hsS
         VF2e/+kpgX6WMLZNm/Jg6Oe0P+claqo2su7bGNrizXKxsXcyoAEwvV3XvMoYm9XLVgAd
         ADwEw48dWml07MmpTuFs+TSZDcrP5Jyn4KIDy8+XVGnl5GQlXFYPqi3jJ3NNCeH8LCvI
         KSkBrLj+55vwnyEXoYAa0AolEPy2XAULjFkawP8XaIqbe0FNCMeTcCLNW5lAYQZxaTd/
         t7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770013875; x=1770618675;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sv3rE1ysKqQy3NPOcV7JVfxCOKmaA0B89vDL2+rHKJA=;
        b=b2FG6BP81l9vx2soRTk1D0ynAxJ6aPa5Gn80hDkyjUIFl5GlrIjtEYhRh9Ts6eDCLl
         wWcRsqWoOThr/uAXoB4EBsm2HSReKeJrcGRvxARppN21qdufF+yMKYpIsUmwbrtmtR2I
         Bgu5cU7NuZ2Bwl7lXHdWnvJ/SkxSo/awBVC+d+EYKWc4KSAvDh007D8n56QyD0DFUcNE
         gN5uHVA5ov+tgogY0IA9OCQVi9cbgv4h0lno2Ypr4pW7Edshx4/rrTDm3x8JWknxFc+u
         ihAqOjgSTSCbQLqu6qH9+GrvaMTgIL1YhgjoFgC5ptPeV223bP4mnnQaaESlqs0n9mI3
         7DCA==
X-Forwarded-Encrypted: i=1; AJvYcCUmcha26H0TR5pHgljsuJMhl1MIvcAvwD3BFmUuq8KqpclVsg05QQovh85KystGlcQwx67j3JIHRmrVmY4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy1kCUx+DrfHhsW7CFKtrMLsxH+6JTMejUuuHxt2ufsOKfKlg1l
	vgLl7uQhgzCH6tH+I1ollDOjoGxWTx2z2YKEDNdi1eyj4EMfZ/qm/daC
X-Gm-Gg: AZuq6aKhePBuyv5w/dZf/q5ItdFZN29EKvzWyoeqjeegThHhP6K73JpVZwYBJXG7RO1
	Gj22GJXWgmly89HQXBv2O9miGiTXKrqDJVdrQec/JGGQlQUS+JfxPVX0n+0EfrB9RWjEeKKtHD/
	XWNCdAl69olQ8np9oSUwonbEkLuhpZYZQFnGvFKN0xH3S7oNxSytAr68FdzqTtX29saW6U0Nd50
	32jMg/nBO13oz3Q4oj5N2LEgALAo3Dr/8wgpCuPd2JEit7pZ+TaQ1k4bpeq6cFsSPXOg1eXk/4/
	GydQcLmrS+Ra27FQIGhG18ts5Yt2zsYiDTIJlXi8S1vsoIjiHVcdM10xsZfJ9lDu8y/wY4Ynjpw
	qkIyWoMIEnhiIHumUh7TPomkEtji+mhHYysa4lu5EX3MLH/G7BTb9NZC7icxwLoXbg8sr/gVMTw
	RUybepqWk=
X-Received: by 2002:a17:90b:1d8e:b0:341:88d5:a74e with SMTP id 98e67ed59e1d1-3543b3b0485mr10527577a91.29.1770013874627;
        Sun, 01 Feb 2026 22:31:14 -0800 (PST)
Received: from [127.0.1.1] ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642add5199sm12618288a12.31.2026.02.01.22.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 22:31:14 -0800 (PST)
From: Colin Huang <u8813345@gmail.com>
Date: Mon, 02 Feb 2026 14:31:09 +0800
Subject: [PATCH] ARM: dts: aspeed: anacapa: add new sgpio line names
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
Message-Id: <20260202-anacapa-dts-sgpio-v1-1-a3a7b0b087f0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKxEgGkC/x2MMQqAMAwAvyKZDdRiHfyKOMQ21ixtaUQE8e8Wl
 4Mb7h5QrsIKc/dA5UtUcmoy9B34g1JklNAcrLGTaUBK5KkQhlNRY5GMPLLZyHnrg4PWlcq73P9
 zWd/3A/yELQpjAAAA
X-Change-ID: 20260202-anacapa-dts-sgpio-e4e0ba5c2cd5
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Colin.Huang2@amd.com, Carl.Lee@amd.com, Peter.Shen@amd.com, 
 Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770013872; l=2902;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=rcsDqb46gaG3yFjHYrMozn3xXMZ6ng4if68dtMxMODg=;
 b=h0rG6nZWmvlMA1n0nv/vBTwPtlPrvH/aJySv3L2Cbby17HWgvqZhBr+hvbyix1LQVLmKOioT+
 p3TXHipXdM+AM4KQqBcgXkHTkppTmXNIFOmRPtf1WG5Iu/BXOecASMs
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=

Updated items:
- Add BMC_AINIC0_WP_R2_L and BMC_AINIC1_WP_R2_L
- Place LEAK_DETECT_RMC_N in the correct slot
- Add PRSNT_NFC_BOARD_R
- Add IRQ_NFC_BOARD_R and RSMRST_N
- Add DC_OFF, EAM_MOD_PWR_GD_TIMEOUT, CPLD_AMC_STBY_PWR_EN
- Add FM_MAIN_PWREN_RMC_EN_ISO

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
The following changes are included:
- Add BMC_AINIC0_WP_R2_L and BMC_AINIC1_WP_R2_L
- Correct placement of LEAK_DETECT_RMC_N
- Add PRSNT_NFC_BOARD_R
- Add IRQ_NFC_BOARD_R and RSMRST_N
- Add DC_OFF, EAM_MOD_PWR_GD_TIMEOUT, CPLD_AMC_STBY_PWR_EN
- Add FM_MAIN_PWREN_RMC_EN_ISO
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts   | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 221af858cb6b..37bccf64c77b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -852,15 +852,15 @@ &sgpiom0 {
 	"Channel1_leakage_EAM0", "FM_SCM_JTAG_MUX_SEL",
 	"Channel2_leakage_Manifold1", "FM_BRIDGE_JTAG_MUX_SEL",
 	"Channel3_leakage", "FM_CPU0_NMI_SYNC_FLOOD_N",
-	"Channel4_leakage_Manifold2", "",
-	"Channel5_leakage_EAM1", "",
+	"Channel4_leakage_Manifold2", "BMC_AINIC0_WP_R2_L",
+	"Channel5_leakage_EAM1", "BMC_AINIC1_WP_R2_L",
 	"Channel6_leakage_CPU_DIMM", "",
 	"Channel7_leakage_EAM2", "",
 
 	/* C0-C7 line 32-47 */
-	"RSVD_RMC_GPIO3", "", "", "",
+	"RSVD_RMC_GPIO3", "", "LEAK_DETECT_RMC_N", "",
+	"", "", "", "",
 	"", "", "", "",
-	"LEAK_DETECT_RMC_N", "", "", "",
 	"", "", "", "",
 
 	/* D0-D7 line 48-63 */
@@ -893,7 +893,7 @@ &sgpiom0 {
 	"PWRGD_CHIL_CPU0_FPGA", "",
 	"PWRGD_CHEH_CPU0_FPGA", "",
 	"PWRGD_CHAD_CPU0_FPGA", "FM_BMC_READY_PLD",
-	"", "",
+	"PRSNT_NFC_BOARD_R", "",
 
 	/* H0-H7 line 112-127 */
 	"PWRGD_P3V3", "",
@@ -922,7 +922,8 @@ &sgpiom0 {
 	"BRIDGE_R_MAIN_PG_R", "",
 	"BRIDGE_L_STBY_PG_R", "",
 	"BRIDGE_R_STBY_PG_R", "",
-	"", "", "", "",
+	"IRQ_NFC_BOARD_R", "",
+	"RSMRST_N", "",
 
 	/* K0-K7 line 160-175 */
 	"ADC_I2C_ALERT_N", "",
@@ -956,7 +957,9 @@ &sgpiom0 {
 	"AMC_STBY_PGOOD_R", "",
 	"CPU_AMC_SLP_S5_R_L", "",
 	"AMC_CPU_EAMPG_R", "",
-	"", "", "", "",
+	"DC_OFF", "",
+	"EAM_MOD_PWR_GD_TIMEOUT", "",
+	"CPLD_AMC_STBY_PWR_EN", "",
 
 	/* O0-O7 line 224-239 */
 	"HPM_PWR_FAIL", "Port80_b0",
@@ -966,7 +969,7 @@ &sgpiom0 {
 	"FM_CPU0_THERMTRIP_N", "Port80_b4",
 	"PVDDCR_SOC_P0_OCP_L", "Port80_b5",
 	"CPLD_SGPIO_RDY", "Port80_b6",
-	"", "Port80_b7",
+	"FM_MAIN_PWREN_RMC_EN_ISO", "Port80_b7",
 
 	/* P0-P7 line 240-255 */
 	"CPU0_SLP_S5_N_R", "NFC_VEN",

---
base-commit: 26705fad17bd111f062f4208df2dd60e7a9c2ecd
change-id: 20260202-anacapa-dts-sgpio-e4e0ba5c2cd5

Best regards,
-- 
Colin Huang <u8813345@gmail.com>


