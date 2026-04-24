Return-Path: <linux-aspeed+bounces-3957-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C906FF885C
	for <linux-aspeed@archiver.kernel.org>; Sat, 25 Apr 2026 06:21:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2fqL2ZKnz2xlr;
	Sat, 25 Apr 2026 16:21:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777058496;
	cv=none; b=kj0YrLfQmxOqFPNr2qvIS8nPDSqg2dwXzX9f3SUcYE9QJGkJWf8ah2II9en76VwIIYYzbMXzILkzotpbXbEbR7/b3lqcTOujqKK4Cqmeia/26Hs5A7QCvlMBHorH8boBmdx1/ksyyjo97ddGec8fv2rIc8qGkCqVKLXgVdRHfn5mJbZEdIYKEA8DaWuv9UOTbMNmHByRHz0NxW7qXUFfJc7zZSUEluwlLQQMgSuX3U2Q86wqnojFHVxOD/ihROCKTeaPGRs96UrarQy53qASETDU4hOhhHO1w2mxO9KzmND6083BaSepO2J0UzTjnUGSGfMt+r36WqevrMl+wAqWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777058496; c=relaxed/relaxed;
	bh=k6USWqzxI0jM4EWyxXaWQt3NHyv17GP4tTS/7ZdRfRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBOam7Ul7ZSL0kTlxgJsw2+3fasJ4FCj9SYC2fYJuNKQP95sxCe8/7Yi8TDwA7WztxYFwFPISnflNrh00oMg0ouNcfYHTX/H8M2pkiDHxdTA6S9j/MyCLaYgv8wU8qw8ijcayXdV7XlyEI5MKEiF4gVB0jR4ahnuJ4iIrbhZcnvKkDjViFjQWLkvsoRzuy+8UDEuq4wR1hEjq74UiISlHXQRL14X1Cjoeylw+59axbHLMF/rEG/icKLMDg5G/5Xb6VXNu9TQqmhoV/1MSlaaQmDDNm43SJ9Z7ARADBW+JgQR+/yPqJAhS0/MSXOI3LUqU60MWf6PYZCiw/Xb99O4CA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HELYr7RA; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HELYr7RA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2N9p6HLtz2xTh
	for <linux-aspeed@lists.ozlabs.org>; Sat, 25 Apr 2026 05:21:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777058495; x=1808594495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=igrutGezSuzZAGGdKVZw0ZWhiP2YVfHqPjUihN+3d9Y=;
  b=HELYr7RA0eaizxwDnjbsZQu1GBvjTsQND9z7Vb7o36PrrioYS00zIbve
   sv9u1NsJ2KoOmrpA4cOkBkmYihschLlU9rIK3u+7d+sslw3BgX5l6qMVn
   gw9mcZyHjmnJ89oMnwOBgwFjwAejhbRgLJDB+cv7w68W0ohPN2WiKEiTV
   oUqQejLChZDrkJptfsIvKVyYGjNoKdMWQQkimyV2wjg+P6xEY6406IuTX
   ACky8tNpxV03+6wP2qhgt0lEDirjZNxl1G9ABOO5sWqmTMuviSVwPD7Zy
   dF9GWajNDfpnzUqoHVmcVGb2du6hbKw57zvMhkSVXEteMvFhZcprAIOVH
   A==;
X-CSE-ConnectionGUID: T+22ZhXiTLq7031KpEDpoQ==
X-CSE-MsgGUID: XxD7JPkRQ2CgukUBFaYdHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="77208281"
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="77208281"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 12:21:34 -0700
X-CSE-ConnectionGUID: 0i4T82T9R4Se7VH6clDffg==
X-CSE-MsgGUID: 5ROZTlgFQOGzMWBiVQpnaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="232040492"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 12:21:30 -0700
From: Dawid Glazik <dawid.glazik@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawid.glazik@linux.intel.com,
	maciej.lawniczak@intel.com,
	Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH v4 1/3] ARM: dts: aspeed-g6: move i2c controllers directly into apb node
Date: Fri, 24 Apr 2026 22:20:59 +0200
Message-ID: <7c7010a87bb70b9e2abdadfea76d41cdcb88a82f.1777058942.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777058942.git.dawid.glazik@linux.intel.com>
References: <cover.1777058942.git.dawid.glazik@linux.intel.com>
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

We currently have the apb's mapping of the i2c controller space as a
labelled mostly-empty node:

  apb {
    i2c: bus@1e78a000 {
      ranges = <...>;
    };
  }

... and then define the contents of the i2c block later:

  i2c: {
    i2c0: i2c-bus@80 {
      reg = <0x80 0x80>;
    };
    i2c1: i2c-bus@100 {
      reg = <0x100 0x80>;
    };
  }

Krzysztof mentions[1] that isn't convention though, with the top-level
simple-bus being empty and linked via the label. So, drop the label
usage and move the i2c bus definition into the simple-bus node directly
under the apb:

  apb {
     bus@1e78a000 {
      ranges = <...>;

      i2c0: i2c-bus@80 {
        reg = <0x80 0x80>;
      };
      i2c1: i2c-bus@100 {
        reg = <0x100 0x80>;
      };
    };
  }

This will allow us to be consistent when we add new definitions for the
i3c nodes, which would require the latter format.

Link: https://lore.kernel.org/linux-devicetree/c5331cf8-7295-4e6a-ba39-e0751a2c357e@kernel.org/ [1]
Suggested-by: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
---
v3:
 - pick up series after two years
 - rebase on top of latest tree and solve conflicts
 - as agreed with Jeremy off-list, he said I can take authorship of this going forward
v2:
 - new patch: reorganise i2c nodes before adding new-format i3c nodes
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 452 ++++++++++++------------
 1 file changed, 225 insertions(+), 227 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 189bc3bbb47c..f5641128614f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -835,11 +835,235 @@ uart9: serial@1e790300 {
 				status = "disabled";
 			};
 
-			i2c: bus@1e78a000 {
+			bus@1e78a000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges = <0 0x1e78a000 0x1000>;
+
+				i2c0: i2c@80 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x80 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c1_default>;
+					status = "disabled";
+				};
+
+				i2c1: i2c@100 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x100 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c2_default>;
+					status = "disabled";
+				};
+
+				i2c2: i2c@180 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x180 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c3_default>;
+					status = "disabled";
+				};
+
+				i2c3: i2c@200 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x200 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c4_default>;
+					status = "disabled";
+				};
+
+				i2c4: i2c@280 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x280 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c5_default>;
+					status = "disabled";
+				};
+
+				i2c5: i2c@300 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x300 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c6_default>;
+					status = "disabled";
+				};
+
+				i2c6: i2c@380 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x380 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c7_default>;
+					status = "disabled";
+				};
+
+				i2c7: i2c@400 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x400 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c8_default>;
+					status = "disabled";
+				};
+
+				i2c8: i2c@480 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x480 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c9_default>;
+					status = "disabled";
+				};
+
+				i2c9: i2c@500 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x500 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c10_default>;
+					status = "disabled";
+				};
+
+				i2c10: i2c@580 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x580 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c11_default>;
+					status = "disabled";
+				};
+
+				i2c11: i2c@600 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x600 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c12_default>;
+					status = "disabled";
+				};
+
+				i2c12: i2c@680 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x680 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c13_default>;
+					status = "disabled";
+				};
+
+				i2c13: i2c@700 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x700 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c14_default>;
+					status = "disabled";
+				};
+
+				i2c14: i2c@780 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x780 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c15_default>;
+					status = "disabled";
+				};
+
+				i2c15: i2c@800 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x800 0x80>;
+					compatible = "aspeed,ast2600-i2c-bus";
+					clocks = <&syscon ASPEED_CLK_APB2>;
+					resets = <&syscon ASPEED_RESET_I2C>;
+					interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+					bus-frequency = <100000>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c16_default>;
+					status = "disabled";
+				};
 			};
 
 			fsim0: fsi@1e79b000 {
@@ -870,229 +1094,3 @@ fsim1: fsi@1e79b100 {
 };
 
 #include "aspeed-g6-pinctrl.dtsi"
-
-&i2c {
-	i2c0: i2c@80 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x80 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c1_default>;
-		status = "disabled";
-	};
-
-	i2c1: i2c@100 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x100 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c2_default>;
-		status = "disabled";
-	};
-
-	i2c2: i2c@180 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x180 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c3_default>;
-		status = "disabled";
-	};
-
-	i2c3: i2c@200 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x200 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c4_default>;
-		status = "disabled";
-	};
-
-	i2c4: i2c@280 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x280 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c5_default>;
-		status = "disabled";
-	};
-
-	i2c5: i2c@300 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x300 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c6_default>;
-		status = "disabled";
-	};
-
-	i2c6: i2c@380 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x380 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c7_default>;
-		status = "disabled";
-	};
-
-	i2c7: i2c@400 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x400 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c8_default>;
-		status = "disabled";
-	};
-
-	i2c8: i2c@480 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x480 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c9_default>;
-		status = "disabled";
-	};
-
-	i2c9: i2c@500 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x500 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c10_default>;
-		status = "disabled";
-	};
-
-	i2c10: i2c@580 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x580 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c11_default>;
-		status = "disabled";
-	};
-
-	i2c11: i2c@600 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x600 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c12_default>;
-		status = "disabled";
-	};
-
-	i2c12: i2c@680 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x680 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c13_default>;
-		status = "disabled";
-	};
-
-	i2c13: i2c@700 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x700 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c14_default>;
-		status = "disabled";
-	};
-
-	i2c14: i2c@780 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x780 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c15_default>;
-		status = "disabled";
-	};
-
-	i2c15: i2c@800 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x800 0x80>;
-		compatible = "aspeed,ast2600-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB2>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-		bus-frequency = <100000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2c16_default>;
-		status = "disabled";
-	};
-};
-- 
2.43.0


