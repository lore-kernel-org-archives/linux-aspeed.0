Return-Path: <linux-aspeed+bounces-4088-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0954CD4F57
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 May 2026 10:38:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKWNw6xK1z2xwH;
	Tue, 19 May 2026 20:38:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779187120;
	cv=none; b=kq8sR5wHJTZLKVO78l44wBMXFDHQPC0InNvZrKoB4TQ6p1c2sVZVuxpwidMgOI/oon1L4Az4bD0lbm1dHM+Fx5yVDIrknJdMsFjBhFH7aL1v9fAUj8vZjz8kA2tSSoqJMLbPH4/q3CMh4YknmzcsrxQDV6rShphLgu65JovRWRLFbSos/Dik0SF6fVsO26nvLIIuG40NBjgpNF6/58xrU7mFJDokyIMsxe5Ws11vgAT9xkZLehafMe6syxK/yz0Dxz8DtuXRj/h+FlDcj8liddCwfGBz1Ynn8bWAVnY2LwJfLF3C7JKP71ImY6m+EK5pF1L7o+BCZQvJRCbI0fTTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779187120; c=relaxed/relaxed;
	bh=FWtkLp/R5WFv80whuUO7KL0k05VJ7QqBO/vDoN3VrT0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=EosXEXRv3uFOSPdxEBJz4PDVE/849rth7SBwbtSSAryo1qX+6hENsnpCq5I0Tu82n012dUSj0RA3MsfDIbF7+r0fNj4Rdc3yUlBSyCDljHIE0jtxsECLsojQFEfpDVwN9BBAqQCy5ZQa79cMFlLk0/edI0LCE84UCDcCxaHnB3Ib134xjgTcAugipR5W6DhCnF3+JoFlGHQPrN8mnwdCBvaWWfhapZ9A8rN3Iihcp4u+lAQhVGaq32HZ+AFAESuA5LVRh1NxBJu2UhBcO8B1RglCsYGbMnoJqkmQPJq/shjW9kGYkoxv7zpY9TEhQDI9zND9sXCUwj6t7w4XDGyKRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKWNv4d7dz2xqv;
	Tue, 19 May 2026 20:38:38 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 19 May
 2026 18:38:20 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 19 May 2026 18:38:20 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v4 0/3] pinctrl: aspeed: Add AST2700 SoC1 support
Date: Tue, 19 May 2026 18:38:11 +0800
Message-ID: <20260519-pinctrl-single-bit-v4-0-5fe568a8ffde@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAJQ9DGoC/23NTQqDMBCG4atI1k3JTPztqvcoXcQ40QGrkoi0F
 O/eVCgu6vL9YJ55i0CeKYhL8haeFg48DjHSUyJsZ4aWJDexBSrMFQLIiQc7+14GHtqeZM2zbAy
 CdliirTIRDydPjp8bervH7jjMo39tPxb4rj9OH3ELSCVtrhy6ulTk6qsJE1Ezk+3OdnyIr7ng7
 miVHzoYnaKqoLTO1HkKh47enQyyQ0dHh6qiMakGBJX+Oeu6fgAMHxhKSQEAAA==
X-Change-ID: 20260211-pinctrl-single-bit-da213f282c95
To: Linus Walleij <linusw@kernel.org>, Tony Lindgren <tony@atomide.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Bartosz Golaszewski <brgl@kernel.org>, "Lee
 Jones" <lee@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
CC: <patrickw3@meta.com>, <linux-gpio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<BMC-SW@aspeedtech.com>, <openbmc@lists.ozlabs.org>, Andrew Jeffery
	<andrew@aj.id.au>, <linux-clk@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779187100; l=5847;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=L1iLfDQrZwxvnw6/O3AJV6ahyxO2sv21yD4ZkfxrN4k=;
 b=yZ+Y7S6UBimAwm6wBTS+wu7ylZooUUWR9axObgWXnkPI/Jy4ScwWNWwQ/oxN2gtcn+HpJoFaY
 ms+njnXKTm3CoP/9uIqxvjO8JBWuxqkTALyd4RU0IwVRomo0NoCI+tE
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Legacy ASPEED pin controllers have historically not had a coherent
register interface. Control fields often had no consistent mapping to
individual pins, and configuring a function frequently required
coordinating multiple control bits across several registers. As a
result, the existing ASPEED pinctrl drivers rely on complex macro
infrastructure to describe the dependencies between pins, functions,
and register fields.

The pin controller for SoC1 in the AST2700 breaks from this legacy
design.

For SoC1, each pin maps directly to a dedicated function field in the
SCU register space that determines the active mux function for that
pin. This results in a much more regular register layout compared to
previous generations.

While the behaviour is conceptually similar to pinctrl-single, the
register layout and configuration model differ enough that reusing
pinctrl-single directly is not practical. Therefore this driver is
implemented as a SoC-specific pinctrl driver using static data tables
to describe the register layout.

The binding reuses the standard pinmux and generic pin configuration
schemas and does not introduce any custom Devicetree properties.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Changes in v4:
- Fix SGMII0 mux register: SGMII0's control bit is at SCU47C[0],
  outside the contiguous pin-indexed MUX register range. Handle it as
  a special case in set_mux (analogous to PCIERC2_PERST) using
  field.mask = 0x1 to avoid clobbering adjacent bits in SCU47C.
- Use devm_pinctrl_register_and_init() and pinctrl_enable(): populate
  all groups and functions before enabling the controller, closing the
  race window where a consumer could observe zero groups/functions.
- pin_config_get: return -EINVAL when BIAS_DISABLE is not active; return
  -ENOTSUPP for BIAS_PULL_UP and BIAS_PULL_DOWN because the hardware
  has a single 1-bit enable/disable field per pin and pull direction
  cannot be read back from the register.
- Probe: preserve const qualification in the pinctrl_generic_add_group()
  pin array cast.
- Binding: retain additionalProperties: false for the state-node schema.
  The state-node properties block re-declares the four pincfg properties
  the hardware supports (bias-disable, bias-pull-up, bias-pull-down,
  drive-strength) and intentionally rejects all others.
  unevaluatedProperties: false was suggested as an alternative, but that
  would permit the full set of pincfg-node.yaml properties
  (input-schmitt-enable, slew-rate, etc.) even though the hardware does
  not support them. additionalProperties: false is the correct mechanism
  when the goal is to restrict the accepted properties to a known subset.
- Link to v3: https://lore.kernel.org/r/20260515-pinctrl-single-bit-v3-0-e97da4312104@aspeedtech.com

Changes in v3:
- Added pin configuration group support for AST2700 SoC1 by
  implementing `pin_config_group_get()` and `pin_config_group_set()`.
- Restricted AST2700 SoC1 `drive-strength` settings to the supported
  4/8/12/16 mA values in the pinctrl driver.
- Convert kernel-doc comment for aspeed_g7_soc1_drv_map to a regular
  comment to avoid kernel-doc warning reported by kernel test robot.
- Update the AST2700 SoC1 pinctrl binding to describe the `reg`
  property and require it.
- Allow standard pinconf properties in pin state nodes.
- Add a binding example for the AST2700 SoC1 pinctrl node.
- Add state-node description, function+groups dependency constraint,
  and oneOf groups/pins constraint to the binding, matching the SoC0
  binding style.
- Add pins enum (212 entries) to the binding to cover all physical pins
  that support per-pin configuration.
- Add UART modem-line signals as independent functions/groups:
  NCTS0/1/5/6, NDCD0/1/5/6, NDSR0/1/5/6, NDTR0/1/5/6,
  NRI0/1/5/6, NRTS0/1/5/6; remove those pins from UART0/1/5/6 groups.
- Add LTPI_PS_I2C0/1/2/3 functions/groups for I2C-over-LTPI;
  extend I2C0/1/2/3 functions with the new LTPI groups.
- Fix typo: rename RMII0RCKO/RMII1RCKO to RMII0RCLKO/RMII1RCLKO.
- Fix wrong index: rename DSGPM1 to DSGPM0.
- Kconfig: use "Aspeed G7 SoC1 pin control" to match neighbouring entries.
- pin_config_get: fix BIAS_DISABLE readback (val=!val must be skipped
  for BIAS_DISABLE since hardware bit=1 means pull disabled).
- set_mux: remove dead null check on grp; propagate regmap_update_bits()
  return value.
- gpio_request_enable: propagate regmap_update_bits() return value.
- Link to v2: https://lore.kernel.org/r/20260306-pinctrl-single-bit-v2-0-79918cfab641@aspeedtech.com

Changes in v2:
- Updated the series title to focus on AST2700 SoC1 support.
- Reworked implementation to use static SoC-specific layout tables
  instead of a generic packed-field model.
- Dropped the generic "pinctrl-packed" driver approach.
- Removed custom Devicetree properties.
- Updated binding to reuse standard pinmux and generic pin
  configuration schemas.
- Link to v1: https://lore.kernel.org/r/20260213-pinctrl-single-bit-v1-0-c60f2fb80efb@aspeedtech.com

---
Billy Tsai (3):
      dt-bindings: mfd: aspeed,ast2x00-scu: Support AST2700 SoC1 pinctrl
      dt-bindings: pinctrl: Add aspeed,ast2700-soc1-pinctrl
      pinctrl: aspeed: Add AST2700 SoC1 support

 .../bindings/mfd/aspeed,ast2x00-scu.yaml           |    1 +
 .../pinctrl/aspeed,ast2700-soc1-pinctrl.yaml       |  760 +++++++++
 drivers/pinctrl/aspeed/Kconfig                     |   14 +
 drivers/pinctrl/aspeed/Makefile                    |    1 +
 drivers/pinctrl/aspeed/pinctrl-aspeed-g7-soc1.c    | 1754 ++++++++++++++++++++
 5 files changed, 2530 insertions(+)
---
base-commit: e532a5a81d0db872acd2c0a92d2639580ca3da44
change-id: 20260211-pinctrl-single-bit-da213f282c95

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


