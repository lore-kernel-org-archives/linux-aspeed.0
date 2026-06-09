Return-Path: <linux-aspeed+bounces-4201-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708F8CD8C9D
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Jun 2026 02:47:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZCxm19fKz2xR4;
	Tue, 09 Jun 2026 12:47:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780973260;
	cv=none; b=Ke6se1S1Ez/9WYAKHbb65B+BtEiu0vCTQNkOl8npV+iqrOrHiJSppv3zTkh3KcOiT8wnFOTXk0GY4Q3IySwt764EB6MKJgigqaoTX+zprttAl1v07z9a5KrWu4ugJFJlgjnYkl3UgLQrH34Cuh3NWeZO+ncTRER1hxpb6Bjr8T359hwtl4D9xErKqNnmc4Sug2rhxeTTYPVYqO0mmHm1avL5LExeo9g3BgxqN0MHdtZLE/7XFKJ0IH3WZsCwkQBqkCjkoHmy6Z6ljILP6Fgts4R0QkAEfqP8ZSTHg24Sn2Zt5C+rLMoX0aJJYMTikh/wxLRUDkwXMCffFppY2l+b7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780973260; c=relaxed/relaxed;
	bh=SN97O3Mz6hD8IyyoGPgtEJRDjEfewZ/BJxl9K6OEWfE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ktcJlTk+huMMlKuEoTnUsZELaHs/w4XkLsDEkfcBXnGfUxeQR43vnL7qttrb72mxjsPNENCeF3JFWmJgInKNWc3T+lTp5MhdfTsuEl3WjCq/5jDN7x2421OeOFKn0u7cZXF1iA80+zky61n0CmjH6QoLA2SgKWyi5SQFF9WVsVS2tlk0JyY+QiXOqzAK911QN8mlvYdR+0DmZr4aR0Kl83F7yAtz/9VsA06BuhIpBRLY0P3sxKeCsTIdyauI84RXg2QXS5vB5y7ZbvzwxE1nJcaS4HdU31+J3+46+Hufb3iBlD2zNVPpq1lHSRRmBq+wC92tKJklc0bVTr7xFW2ABA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZCxk1MFVz2xM7
	for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Jun 2026 12:47:37 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 9 Jun
 2026 10:47:20 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 9 Jun 2026 10:47:20 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v9 0/4] Introduce ASPEED AST27xx BMC SoC
Date: Tue, 9 Jun 2026 10:47:17 +0800
Message-ID: <20260609-upstream_ast2700-v9-0-f631752f0cb1@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIALV+J2oC/x3MSwqAMAwA0auUrC2E4P8qIlI1ahZqaVQE8e4Wl
 28x84ByEFaozQOBL1HZt4gqMTAsbpvZyhgNhJQjYWZPr0dgt3ZODyoQbc4TDym5nqiEmPnAk9z
 /smnf9wOaBov0YgAAAA==
X-Change-ID: 20260205-upstream_ast2700-6efec42ab228
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, "Drew
 Fustini" <fustini@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<soc@lists.linux.dev>, <linux-riscv@lists.infradead.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>, Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780973240; l=6248;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=oYZVa0bsFQERUp7kyP1cnPeCWXK8Ze7hWamrAqEBEoc=;
 b=pQEgAFwbtlh85/ynBOEecEI9FD7ew2fniNbe1tJWv0MaDKz+27nuAj5pKsdFljy0sk8lTby7h
 zbfZWYkK2WECoe0AeNgV4TJnN0WVb8W+U5cPYz1jB4zKNjM5fHLbrDG
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

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

- scu/scu-ic/silicon-id: Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
- intc: Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-interrupt.yaml
- scu-ic: Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml
- pinctrl soc0: Documentation/devicetree/bindings/pinctrl/aspeed,ast2700-soc0-pinctrl.yaml
- pinctrl soc1: Documentation/devicetree/bindings/pinctrl/aspeed,ast2700-soc1-pinctrl.yaml
- gpio: Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
- sgpio: Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
- fmc/spi: Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
- mdio: Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
- sd/sdhci: Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
- usb-vhub: Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
- ehci: Documentation/devicetree/bindings/usb/generic-ehci.yaml
- uhci: Documentation/devicetree/bindings/usb/usb-uhci.yaml
- wdt: Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
- mailbox: Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
- adc: Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
- pwm-tach: Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
- fsi: Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v9:
- use b4 send
- rebase on linux-next
- split aspeed-g7-common.dtsi to aspeed-g7-soc0/1.dtsi
- update all interrupt-extend by use aspeed,ast2700-intc0/1 parent
- MAINTAINERS: add arch/arm64/boot/dts/aspeed/ entry
- Kconfig.platforms: reword ARCH_ASPEED help text
- cover: complete bindings dependencies list and fix intc binding path
- Link to v8: https://lore.kernel.org/all/20251112101157.2149169-1-ryan_chen@aspeedtech.com/

Changes in v8:
- Kconfig.platforms
 - update commit message and help description.
- aspeed-g7-a35.dtsi,aspeed-g7-common.dtsi,ast2700-evb.dts
 - change license using a dual license of MIT + GPL2.0+
 - add company copyright.
- merge original v7 patch(3/5) and (4/5) to 1 v8patch(3/4)
 - that can do build test with make CHECK_DTBS=y W=1 arch/arm64/boot/dts/aspeed/ dtbs
- Link to v7: https://lore.kernel.org/all/20251107055629.4075519-1-ryan_chen@aspeedtech.com/

Changes in v7:
- remove aspeed,ast2x00-scu.yaml modify
- separate aspeed-g7.dtsi to aspeed-g7-a35.dtsi and aspeed-g7-common.dtsi
-move aliases to ast2700-evb.dts file
-Link to v6: https://lore.kernel.org/all/20251022070543.1169173-1-ryan_chen@aspeedtech.com/

Changes in v6:
- rebased on v6.18-rc1
- aspeed,ast2x00-scu.yaml
 - fixed dt-binding yaml issuse report.
-Linke to v5: https://lore.kernel.org/all/20250901031311.1247805-1-ryan_chen@aspeedtech.com/

Changes in v5:
- modify ast27XX 7th generation description to 8th generation.
- aspeed.yaml
 - modify missing blank line.
- Kconfig.platforms
 - modify ast27XX 7th generation to 8th generation.
-Link to v4: https://lore.kernel.org/all/20250821080214.513090-1-ryan_chen@aspeedtech.com/

Changes in v4:
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
-Link to v3: https://lore.kernel.org/all/20241212155237.848336-1-kevin_chen@aspeedtech.com/

Changes in v3:
- Split clk and reset driver to other commits, which are in series of
  "Add support for AST2700 clk driver".
- For BMC console by UART12, add uart12 using ASPEED INTC architecture.
aspeed,ast2700-intc.yaml
- Add minItems to 1 to fix the warning by "make dtbs_check W=1".
- Add intc1 into example.
Kconfig.platforms
  - Remove MACH_ASPEED_G7.
-Link to v2: https://lore.kernel.org/all/20240802090544.2741206-1-kevin_chen@aspeedtech.com/

Changes in v2:
-Link to v1: https://lore.kernel.org/all/20250612100933.3007673-1-ryan_chen@aspeedtech.com/

---
Ryan Chen (4):
      dt-bindings: arm: aspeed: Add AST2700 board compatible
      arm64: Kconfig: Add ASPEED SoC family Kconfig support
      arm64: dts: aspeed: Add initial AST27xx SoC device tree
      arm64: configs: Update defconfig for AST2700 platform support

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    6 +
 MAINTAINERS                                        |    1 +
 arch/arm64/Kconfig.platforms                       |    6 +
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/aspeed/Makefile                |    4 +
 .../dts/aspeed/aspeed-evb-flash-layout-128.dtsi    |   32 +
 arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi      |  196 ++++
 .../boot/dts/aspeed/aspeed-g7-soc0-pinctrl.dtsi    |  225 ++++
 arch/arm64/boot/dts/aspeed/aspeed-g7-soc0.dtsi     |  230 ++++
 .../boot/dts/aspeed/aspeed-g7-soc1-pinctrl.dtsi    | 1113 ++++++++++++++++++++
 arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi     |  557 ++++++++++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts         |   65 ++
 arch/arm64/configs/defconfig                       |    1 +
 13 files changed, 2437 insertions(+)
---
base-commit: 6e845bcb78c95af935094040bd4edc3c2b6dd784
change-id: 20260205-upstream_ast2700-6efec42ab228

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>


