Return-Path: <linux-aspeed+bounces-4110-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAC8CD5BAC
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 May 2026 09:18:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLjW22PGlz2xSN;
	Thu, 21 May 2026 19:18:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779355086;
	cv=none; b=AVBdE1u0ymQadzMmOfy1Jk6vml7vQuEqra1yyhxL12fuL83tO3C7AdP4JsUPAgw7KfBHvWKWrh+18saPmxWa+TqGT9uVkTx18jqGA4tDIlKBxrmct6FQEzxGvaLdjW/3mAy5KHOQDdKOPpVKE56H7eB2HklW0FRTIn46zQ9ew/PtY2vqJf/dJFKGCBVHjZhugDdgkOAfM5jRITNkbzQQ7aNxVVBqd7HDfy4risAETk3PO2/C9spsou8NzJ7IDqPRnGyAkT4Et1mpexVmv9x47I19O7MFs6iXxE7PzTdMVfFm1GsbWbpoPruS3gXgVUuoCtd+OxeiXPQbpsirlRVvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779355086; c=relaxed/relaxed;
	bh=HztNOfgApkZBoP1iq3Qr9B/V1r4xoafa9iWlXDK1Q70=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=KOkFLr1xQY7hT2OobIA8qmi3g0GX26xdEoobbyR9KfvG2iyMgUE6WJayP/mbBdUFwrDpfU1yABbUe4c9JrWVuNW8ZFtvtrUTeqYH5az3OQNnuNQQ/jpMJJE+5Uq03s8FdNGW1sJ2ZeZh8UTb4Mls4kX+HzPry1AaacUfEa6/VjZ/ScyxznEEc9OPLPJlHk5v9iqG5qprk2EXGMsWQXRdMHxyH4Cw2C1swcoNZQGvgUparacp1/lIyT7ioF7E2X2a8yONud40B5hCDQVW1xYWaepXRYz/YiHNahKrddqdwOcQapRRD5Jzt/nzrYnX3BlY8T0cSzoQOx/jjFINznpoHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLjW105Swz2xGY;
	Thu, 21 May 2026 19:18:04 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 21 May
 2026 17:17:46 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 21 May 2026 17:17:46 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v5 0/3] pinctrl: aspeed: Add AST2700 SoC1 support
Date: Thu, 21 May 2026 17:17:43 +0800
Message-ID: <20260521-pinctrl-single-bit-v5-0-308be2c160fc@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIALfNDmoC/23NTWrDMBCG4asErauiGf1Eyqr3KF3I0igWpLaRj
 EkIvnuVQEmhWr4fzDN3Vqlkqux0uLNCW655nlrotwMLo5/OxHNszVCgEQjAlzyFtVx4zdP5Qnz
 IK48eQSa0GJxm7XAplPL1iX5+tR5zXedye/7Y4LH+crLHbcAFD0YkTIMVlIYPXxeiuFIY38P8z
 R7mhi9HCtN1sDlH58CG5AejoOvIl6NBdx3ZHHLH6JUEBKG6jvrruK6jmqMTaWO9TSnSP2ff9x9
 DU/d/kQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779355066; l=6532;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=1FO/h9Q68wl39xMGpvKy8BX+Cnza/44iE+NJvpqIVdE=;
 b=Dg8FGmSAZqlzGGhZvMlMhmpPNmfnr+FPYz892X8vyZ/wLjGQXH9HAFL536sj2kDItMBBw44Ko
 duBFiHJsPJ8AJ4Ca4l5agvBWnUQGDj7qDjM/VenCn7MvyyNg7TnSWpw
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
Changes in v5:
- pin_config_set: add comment explaining that PIN_CONFIG_BIAS_PULL_UP
  and PIN_CONFIG_BIAS_PULL_DOWN both map to "enable bias" because the
  hardware pull direction is fixed in silicon per pin.
- Remove custom aspeed_g7_soc1_get_group_pins() helper; replace with
  direct calls to pinctrl_generic_get_group_pins() in
  pin_config_group_get() and pin_config_group_set().
- MUX_FUNC_MASK: add comment explaining that the mask covers only
  bits [2:0] because bit 3 of each 4-bit per-pin slot is reserved
  read-only in the hardware and must not be written.
- Link to v4: https://lore.kernel.org/r/20260519-pinctrl-single-bit-v4-0-5fe568a8ffde@aspeedtech.com

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
 drivers/pinctrl/aspeed/pinctrl-aspeed-g7-soc1.c    | 1747 ++++++++++++++++++++
 5 files changed, 2523 insertions(+)
---
base-commit: 812e181385abef2fe3a138438326bce844ef7cf0
change-id: 20260211-pinctrl-single-bit-da213f282c95

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


