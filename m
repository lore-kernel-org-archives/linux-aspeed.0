Return-Path: <linux-aspeed+bounces-2874-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE6BCCFA1E
	for <linux-aspeed@archiver.kernel.org>; Wed, 12 Nov 2025 10:12:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d5zjB4Bhqz2yv7;
	Wed, 12 Nov 2025 21:12:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762942334;
	cv=none; b=UYh437lyFaIBHEnwhTbG5o0vG8LJP3zUAKDJYIAtROK5pp+ErPzxp91VsloZwKUmLing2TlvwzzPiVjmysD9IdD5ZqVJnSK9paudXNyPb5OOwCKkbr8fOSF2TLXK0DVbV00oIFFGIFrfugay+/bWsyXOgrMF7kUKKHoZ7YhRN29qvuqteVqjC2gEXIKBTlQom6OVNwl6/bM79ePMTO4gtj5V7vLIY96efal9T4vimGbuqTUlCfJtOfeRD//2wzSPYCoYh8HrqnQHmVQO5OEAIWJu1rhY30s3kL1OFCJe6JCa9kwEandwhoc1xv0P/XTwfmmkq65RFS585Bc8NsLWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762942334; c=relaxed/relaxed;
	bh=5Y3qN1TgemousD4tjAd2pM/KEnt+ZiUPwkZ66AW8PW4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FXr1o2Bit5wxfsB5kvE0PNdGhYOs6bSARdy/OuGhXFZOE2cPTi6SxAj47ziDUbaK3J+aSE76olSe57Fp/nyD8ptyOKIDNCKpuLnBhBUDabJiLiPV+MJQP4A0yAZX7Ph+T3tp5xqmyW8aIuXURxW0oM5rsY+eLFKeSc/cpcMjT87okedprIPEGD1nPGwmxYhze6vjCvRmaNcZK6uwFN9VSvdK7zrDOUktciguzDZJhwKpBFoBeGrQ4jgsUNEbYl59eMp1owTCyVj8cTvmmaIf6sTHNL/hvk93tylNR89RFHOGMb8JRJiJUKe95lLz4YyomcBLJOdDqmaFsZwFt3qfVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d5zj93hdWz2yqP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 12 Nov 2025 21:12:12 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 12 Nov
 2025 18:11:57 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 12 Nov 2025 18:11:57 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, <bmc-sw@aspeedtech.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, <jk@codeconstruct.com.au>, Lee Jones
	<lee@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/4] Introduce ASPEED AST27xx BMC SoC
Date: Wed, 12 Nov 2025 18:11:53 +0800
Message-ID: <20251112101157.2149169-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This introduces initial support for the Aspeed AST27xx SoC and the AST2700
Evaluation Board (EVB) to the Linux kernel. The AST27xx is the 8th
generation Baseboard Management Controller (BMC) SoC from Aspeed,
featuring improved performance, enhanced security, and expanded I/O
capabilities compared to previous generations.

AST27xx SOC Family
 - https://www.aspeedtech.com/server_ast2700/
 - https://www.aspeedtech.com/server_ast2720/
 - https://www.aspeedtech.com/server_ast2750/

Bindings Dependencies:
 check with "make CHECK_DTBS=y W=1 arch/arm64/boot/dts/aspeed/ dtbs"

- scu/silicon-id: Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
- gpio: Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
Binding dependency patch:
- intc: Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml 
 - https://lore.kernel.org/all/20251030060155.2342604-2-ryan_chen@aspeedtech.com/
   (merged into the irq/drivers)

v8:
- Kconfig.platforms
 - update commit message and help description.
- aspeed-g7-a35.dtsi,aspeed-g7-common.dtsi,ast2700-evb.dts
 - change license using a dual license of MIT + GPL2.0+
 - add company copyright.
- merge original v7 patch(3/5) and (4/5) to 1 v8patch(3/4)
 - that can do build test with make CHECK_DTBS=y W=1 arch/arm64/boot/dts/aspeed/ dtbs

v7:
- remove aspeed,ast2x00-scu.yaml modify
- separate aspeed-g7.dtsi to aspeed-g7-a35.dtsi and aspeed-g7-common.dtsi
- move aliases to ast2700-evb.dts file

v6:
- rebased on v6.18-rc1
- aspeed,ast2x00-scu.yaml
 - fixed dt-binding yaml issuse report.

v5:
- modify ast27XX 7th generation description to 8th generation.
- aspeed.yaml
 - modify missing blank line.
- Kconfig.platforms
 - modify ast27XX 7th generation to 8th generation.

v4:
- make CHECK_DTBS=y arch/arm64/boot/dts/aspeed/ fix.
- modify commit message remove itemlize.
- remove modify aspeed,ast2700-intc.yaml patch.
- aspeed.yaml
 - Add AST2700 board compatible.
- aspeed-g7.dtsi
 - modify all size-cells from 1 to 2.
 - add serial aliases, gpio, mdio, uart0 ~ 14.
 - add firmware for optee, reserved memory for atf and optee.
 - modify cpu@0 to cpu0: cpu@0.
 - fix intc-ic for yaml dependency.
- ast2700-evb.dts
 - update stdout-path = "serial12:115200n8";

v3:
- https://lore.kernel.org/all/20241212155237.848336-1-kevin_chen@aspeedtech.com/
- Split clk and reset driver to other commits, which are in series of
  "Add support for AST2700 clk driver".
- For BMC console by UART12, add uart12 using ASPEED INTC architecture.

aspeed,ast2700-intc.yaml
- Add minItems to 1 to fix the warning by "make dtbs_check W=1".
- Add intc1 into example.

Kconfig.platforms
  - Remove MACH_ASPEED_G7.

Ryan Chen (4):
  dt-bindings: arm: aspeed: Add AST2700 board compatible
  arm64: Kconfig: Add ASPEED SoC family Kconfig support
  arm64: dts: aspeed: Add initial AST27xx SoC device tree
  arm64: configs: Update defconfig for AST2700 platform support

 .../bindings/arm/aspeed/aspeed.yaml           |   6 +
 arch/arm64/Kconfig.platforms                  |   6 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/aspeed/Makefile           |   4 +
 arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi | 154 ++++++++
 .../boot/dts/aspeed/aspeed-g7-common.dtsi     | 351 ++++++++++++++++++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |  31 ++
 arch/arm64/configs/defconfig                  |   1 +
 8 files changed, 554 insertions(+)
 create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7-common.dtsi
 create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts

-- 
2.34.1


