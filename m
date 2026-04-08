Return-Path: <linux-aspeed+bounces-3872-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2449D10FC45F
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Apr 2026 22:54:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frdgL2gVSz2xc8;
	Thu, 09 Apr 2026 08:54:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775677325;
	cv=none; b=g/XUR2W8MPPFcxFNFoOcTywnF6YeLkdVFAMxDIdb7/qAuiMxqqEHpKDTXdZzVF6uigcG6Zel+BBTC5RFwjlirk6vzmQV1FYfVOez0Ilw+5b3odQaeXFgJ6o5dKF9awxY0VgjoKjRpN3687ENjqMt0upeC8eWMvduWG+UlaB7wgVyl8+9EmCmpn3qoqD6SwTc46lJMybV8pWr80lIah0CIiv5c38knv3fDS3UAnztAV1sZDNjmjgh0oqBHVpPPu0ZU+dVAM/N2mOmr1Cd7uKf60DtpxjNbJ7fFiCwFfJptXRCpBjlVLUx2MOKMP0QffaS8DWgt6VTuiQ2yt9xIpe8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775677325; c=relaxed/relaxed;
	bh=JHj7gjj1D1yA/EFj38EA0iN8+3lz3HIFKmJ7PEWQ+Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDQAKyVwttGFMQmIEMYmMvRbL8E+6Xe64qd9s4KIJ1rLwlmKKuzbZtfsdfQzUmz1mRNXBXrKSKw9J0YSVUAUL47TtrXkqvhUSWo3Dgx+6N/m+n5uivKQIdCYz5vsRrjVlPDrRH9OPBA2dSPvO4Dw/e84kajuwnfwDogEbro2bbtD2Zlf61A6w24FtymD0F5h3Bcos29TcjWQJAOikL0oF/SzDnBsUy4e/RVemjK5IF/VLYFcKMKMHxOWyTMDMHYChaMjgBtoJRrG5pNmszCnBzJyRKaGLgmU+jlASbrHPvIic52lHZ2p4pP7w2deyJ4Mkkg04jaetrwFzn0SYJAcUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pt+AS4ks; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pt+AS4ks;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frYNr31C6z2yC9
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Apr 2026 05:42:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775677325; x=1807213325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k7GFqr8iVjM9fGnPESeuAJUAMk8q27E6YsZrl96Pn0w=;
  b=Pt+AS4ksgHZlI7rfJ1qrtjSnUpzcv3r5awS43YVqOy2RJfW5Rjj6ua1Q
   7eFBkpo05iGsV+14C0eEiuuQ9/zEo3b8XZ8zRGXKCgj+7Vq17zpxiCYB7
   F/md2QsPY2AHcuixdLdRbMBl6lHeYB/08LjPH67OZPnfq8bjnky6bX+Qa
   XVPBsaV2rWwNLWdpngW3hO0QYMpeyd04lffJMPY3BK1JEe0Y40ssxJX9P
   Jlo5ypSv1PaZWkUN7C0J7YxFbkrCl7OFfBMitCr65OUxhSBX1nHmoPe88
   u5xFiqOMHXwvg56moSeEFAhGD8Hq1mvIsYnPPlGhmW/W79cKJyN9+ik8A
   A==;
X-CSE-ConnectionGUID: dLFZLA8tQua9wG0Kc4FpSw==
X-CSE-MsgGUID: LyR5+jzySA2TBtuKyoop0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88056914"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="88056914"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 12:42:04 -0700
X-CSE-ConnectionGUID: ZxCq1cQ/T3Kj4nHh+MIksg==
X-CSE-MsgGUID: Zc7l3OXLRPOe5SNMKJ1z6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="222053368"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 12:42:00 -0700
From: Dawid Glazik <dawid.glazik@linux.intel.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org
Cc: linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>,
	Dawid Glazik <dawid.glazik@linux.intel.com>,
	Maciej Lawniczak <maciej.lawniczak@intel.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH v3 2/3] ARM: dts: aspeed-g6: Add nodes for i3c controllers
Date: Wed,  8 Apr 2026 22:34:34 +0200
Message-ID: <51c4bdc02b45f67a0e32610a228091e137c135a6.1775679285.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775679285.git.dawid.glazik@linux.intel.com>
References: <cover.1775679285.git.dawid.glazik@linux.intel.com>
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
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Add the i3c controller devices to the ast2600 g6 common dts. We add all
6 busses to the common g6 definition, but leave disabled through the
status property, to be enabled per-platform.

Originally-by: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
---
v3:
 - add i3c aliases
 - rebase on top of latest tree and solve conflicts
 - as agreed with Jeremy off-list, he said I can take authorship of this going forward
v2:
 - use inline bus representation, without the i3c: label
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 97 +++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index f5641128614f..f986fcbed604 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -29,6 +29,12 @@ aliases {
 		i2c13 = &i2c13;
 		i2c14 = &i2c14;
 		i2c15 = &i2c15;
+		i3c0 = &i3c0;
+		i3c1 = &i3c1;
+		i3c2 = &i3c2;
+		i3c3 = &i3c3;
+		i3c4 = &i3c4;
+		i3c5 = &i3c5;
 		serial0 = &uart1;
 		serial1 = &uart2;
 		serial2 = &uart3;
@@ -1066,6 +1072,97 @@ i2c15: i2c@800 {
 				};
 			};
 
+			bus@1e7a0000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x1e7a0000 0x8000>;
+
+				i3c_global: i3c-global@0 {
+					compatible = "aspeed,ast2600-i3c-global", "syscon";
+					reg = <0x0 0x1000>;
+					resets = <&syscon ASPEED_RESET_I3C_DMA>;
+				};
+
+				i3c0: i3c@2000 {
+					compatible = "aspeed,ast2600-i3c";
+					reg = <0x2000 0x1000>;
+					#address-cells = <3>;
+					#size-cells = <0>;
+					clocks = <&syscon ASPEED_CLK_GATE_I3C0CLK>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i3c1_default>;
+					interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+					aspeed,global-regs = <&i3c_global 0>;
+					status = "disabled";
+				};
+
+				i3c1: i3c@3000 {
+					compatible = "aspeed,ast2600-i3c";
+					reg = <0x3000 0x1000>;
+					#address-cells = <3>;
+					#size-cells = <0>;
+					clocks = <&syscon ASPEED_CLK_GATE_I3C1CLK>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i3c2_default>;
+					interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+					aspeed,global-regs = <&i3c_global 1>;
+					status = "disabled";
+				};
+
+				i3c2: i3c@4000 {
+					compatible = "aspeed,ast2600-i3c";
+					reg = <0x4000 0x1000>;
+					#address-cells = <3>;
+					#size-cells = <0>;
+					clocks = <&syscon ASPEED_CLK_GATE_I3C2CLK>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i3c3_default>;
+					interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+					aspeed,global-regs = <&i3c_global 2>;
+					status = "disabled";
+				};
+
+				i3c3: i3c@5000 {
+					compatible = "aspeed,ast2600-i3c";
+					reg = <0x5000 0x1000>;
+					#address-cells = <3>;
+					#size-cells = <0>;
+					clocks = <&syscon ASPEED_CLK_GATE_I3C3CLK>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i3c4_default>;
+					interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+					aspeed,global-regs = <&i3c_global 3>;
+					status = "disabled";
+				};
+
+				i3c4: i3c@6000 {
+					compatible = "aspeed,ast2600-i3c";
+					reg = <0x6000 0x1000>;
+					#address-cells = <3>;
+					#size-cells = <0>;
+					clocks = <&syscon ASPEED_CLK_GATE_I3C4CLK>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i3c5_default>;
+					interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+					aspeed,global-regs = <&i3c_global 4>;
+					status = "disabled";
+				};
+
+				i3c5: i3c@7000 {
+					compatible = "aspeed,ast2600-i3c";
+					reg = <0x7000 0x1000>;
+					#address-cells = <3>;
+					#size-cells = <0>;
+					clocks = <&syscon ASPEED_CLK_GATE_I3C5CLK>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i3c6_default>;
+					interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+					aspeed,global-regs = <&i3c_global 5>;
+					status = "disabled";
+				};
+			};
+
 			fsim0: fsi@1e79b000 {
 				#interrupt-cells = <1>;
 				compatible = "aspeed,ast2600-fsi-master";
-- 
2.43.0


