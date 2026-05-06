Return-Path: <linux-aspeed+bounces-4001-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DA5CD342C
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 May 2026 08:07:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9SfF31p5z2yZ6;
	Wed, 06 May 2026 18:07:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778054837;
	cv=none; b=W1sT8IisoUWhwMn18MxRGgfwNuHjLJYoP4WNMyA1npINmQ1mp4JeNc4R1W0Gd1NLMndaAYRMjbQLojKCtXE2fVmyBb+yoXvetVBj8BNTT+mk/fsjZ6fY025CC1lM4fKVZvK7qgHaHaUYMwIU+RiJD4jum51J6Zhun2uo7UyTeVRqx/fg+E9oaUo+uV1fPkP08w0HiHJNCnFUmdsL/iBQDAEwOxOS/nam10YvNXZ6ukdQbkpgrJY3fuJCbjldSlBZ8vkWzY0pE3apKFUfD9mmNGtudUxQ+Ck1Fl7L00enXV62ei1LsneKE817JHUx5fk55ogV5Fpus7pbgskDabD8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778054837; c=relaxed/relaxed;
	bh=M4oWoGk5FMamzkRtGvAPiSdZoZ2kxV6KLHsujCKbzl0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ikQ7X5THiysgq3gqMshBvSddgzyRgWzaCREozs2hXNENfver7PHtoeTl+WYVQnXH+vKDbm68gaNiQV/gCTHEvL0q1zVniZd7JdkYfZcE7qtPnK+G76nTlDChPjAd51E+u1exW23+bctVpTt2q9mJR8qp8yciu9Oe0EwkAp7MXQWiMK3Wt2OfnIiirHyN9lfYKMFErDU9/PBKIO3QqUvnAFFaPndhNTNb5xr/iLA/nnTPPgZm7OibBg5ZJ/ZGzk1EDTWuCflg3llP3KW85AWk9rgdxRgiYGhiW7pkeDHGG3EVAzklA7GLdpJuA+qkmGAGXZS9ecsQ6cL6H9p3LeuUuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9SfC69Rnz2xdL;
	Wed, 06 May 2026 18:07:15 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 6 May
 2026 16:06:58 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 6 May 2026 16:06:57 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v9 0/3] pinctrl: aspeed: Add AST2700 SoC0 support
Date: Wed, 6 May 2026 16:06:17 +0800
Message-ID: <20260506-upstream_pinctrl-v9-0-0636e22343ad@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAHn2+mkC/23PS27DIBgE4KtErEvEm5+ueo+qirCBGsmxLaBWo
 8h3L86itRqWs5hPM3eUfYo+o9fTHSW/xhznqQbzckL9YKdPj6OrGTHCJGVU4q8ll+Tt9bLEqS9
 pxBCokS4Qa7REtbYkH+L3g3z/qDmk+YrLUDu/EDFEUMIFoWcABhpT3MVxvF1KtvHN5sV7V3w/n
 Pv5upNDzGVOt8fIVezwzijCiXreswpMsHXCg+2gE2D+g/uoVR4UThuKrAoYI4I0IXClm4r6UwQ
 VDUVVRRMTGGXaWc6bij4qrUe6Kk4zrRiTnKq2AgeFQUOBqvgOfDC2I8LAk7Jt2w9WyK1CEAIAA
 A==
X-Change-ID: 20251215-upstream_pinctrl-8f195df0a975
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Linus Walleij" <linusw@kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>,
	"Bartosz Golaszewski" <brgl@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
CC: Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>, <linux-clk@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778054817; l=6007;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=YK2Wy5TArrZ8E/puvT8mSuZPNnspgjU4Z/yVodNApPw=;
 b=dIQgNt+hRpPNkQ9h/KVZGz7oE8uyFGKEryX9zVF+3G6Os9cn7OSEI7YbaL2veoFBzp7Ib1XNl
 LhCJwmBnpMVATNCKoZ14BpZ5ZDZp1KfheiTQrSqea4SDHoAqoDPZ7Gb
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

AST2700 is composed of two interconnected SoC instances, each providing
its own pin control hardware. This series introduces bindings describing
the AST2700 pinctrl architecture and adds pinctrl driver support for the
SoC0 instance.

The bindings document the AST2700 dual-SoC design and follow common
pinctrl conventions, while the SoC0 driver implementation builds upon
the existing ASPEED pinctrl infrastructure.

---
Changes in v9:
- Use folded scalar (>) for the top-level description
- Replace backtick quoting with regular quotes in the state-node
  description text
- Add blank line between compatible and reg properties.
- Link to v8: https://lore.kernel.org/r/20260428-upstream_pinctrl-v8-0-eb8ef9ab0498@aspeedtech.com

Changes in v8:
- Clarify pinctrl state semantics by separating pinmux and pinconf
  constraints.
- Require `function` + `groups` for pinmux and make `groups`/`pins`
  mutually exclusive for pinconf.
- Simplify compatible matching for AST2700 SCU variants by using
  `enum` instead of `anyOf` with `const`.
- Fix AST2700 SoC0 VB mux expression function tags so `VB` can
  select the `VB0` and `VB1` groups.
- Link to v7: https://lore.kernel.org/r/20260416-upstream_pinctrl-v7-0-d72762253163@aspeedtech.com

Changes in v7:
- Fix schema validation error by ensuring if/then/else keywords are used
  correctly.
- Remove unnecessary restrictions on AST2700 SoC0 pinctrl pin configuration
  properties.
- Link to v6: https://lore.kernel.org/r/20260414-upstream_pinctrl-v6-0-709f2127da33@aspeedtech.com

Changes in v6:
- Restrict AST2700 SoC0 pinctrl pin configuration properties
  (`drive-strength` and `bias-*`) to `pins`-based state nodes in the
  binding schema.
- Move `memory-region` and `memory-region-names` in the AST2x00 SCU
  binding to top-level descriptions, and keep the conditional schema
  only to disallow them for non-AST2700 SCU0 compatibles.
- Add bias pull-up, pull-down, and disable support for AST2700 SoC0
  GPIO18A/GPIO18B pins in the pinctrl driver.
- Fix the USB2 Port B XH/XHP mux selector definitions to use the
  correct `PORTB_U2_XH_DESC` setting.
- Link to v5: https://lore.kernel.org/r/20260331-upstream_pinctrl-v5-0-8994f59ff367@aspeedtech.com

Changes in v5:
- Complete the AST2700 SCU0 binding and disallow child nodes that are
  not relevant for the hardware (p2a-control and smp-memram).
- Add examples for both the AST2700 SCU0 binding and the pinctrl binding,
  ensuring they are valid against the schema.
- Rework the pinctrl binding example to be self-contained and independent
  of the SCU binding.
- Reorder the binding patches so the pinctrl binding is introduced before
  the SCU binding update, allowing the SCU example to be added cleanly.
- Adjust the binding accordingly to restrict drive-strength to the
  supported values.
- Update the drive-strength table to match hardware-defined values.
- Link to v4: https://lore.kernel.org/r/20260306-upstream_pinctrl-v4-0-ad4e8ab8b489@aspeedtech.com

Changes in v4:
- Rename series title to "pinctrl: aspeed: Add AST2700 SoC0 support"
  to make it specific to SoC0.
- Remove unnecessary SCU example from bindings.
- Fix Makefile newline to avoid patch warning.
- Make pinctrl data structures const and align with existing Aspeed drivers.
- Sort the arrays and enums alphabetically.
- Minor cleanups for consistency, no functional changes.
- Link to v3: https://lore.kernel.org/r/20260120-upstream_pinctrl-v3-0-868fbf8413b5@aspeedtech.com

Changes in v3:
dt-bindings: pinctrl: aspeed: AST2700 pinctrl improvements
- Improved binding descriptions for SoC0 and SoC1 to better explain the
  AST2700 dual-SoC architecture with independent pin control blocks
- Switched from additionalProperties to patternProperties using the
  '-state$' suffix to restrict child node naming
- Removed per-binding examples based on review feedback
- Added additionalProperties: false at the top level for stricter schema
  validation
- Dropped the aspeed,ast2700-soc1-pinctrl binding, as the SoC1 pinctrl
  registers follow a regular layout and can be described using an
  existing generic pinctrl binding
- Updated the function and group enum lists to match the definitions
  used by the AST2700 pinctrl driver

dt-bindings: mfd: aspeed: Add AST2700 SCU example with pinctrl
- Added a complete AST2700 SCU0 example demonstrating pinctrl integration
- Example covers both pin function/group configuration and pin
  drive-strength settings
- Updated child node naming to use the '-state' suffix, following common
  pinctrl conventions

pinctrl: aspeed: AST2700 SoC0 driver improvements
- Refactored pin and signal declarations to use common ASPEED pinmux
  macros (SIG_EXPR_LIST_DECL_SEMG, SIG_EXPR_LIST_DECL_SESG, PIN_DECL_*)
- Added SCU010 register definition for hardware strap control
- Reworked code structure to better align with existing ASPEED pinctrl
  drivers

- Link to v2: https://lore.kernel.org/r/20250904103401.88287-1-billy_tsai@aspeedtech.com

Changes in v2:
- Update pinctrl aspeed binding files.
- Update the commit message for pinctrl binding patch.
- Link to v1: https://lore.kernel.org/r/20250829073030.2749482-1-billy_tsai@aspeedtech.com

---
Billy Tsai (3):
      dt-bindings: pinctrl: Add aspeed,ast2700-soc0-pinctrl
      dt-bindings: mfd: aspeed,ast2x00-scu: Describe AST2700 SCU0
      pinctrl: aspeed: Add AST2700 SoC0 support

 .../bindings/mfd/aspeed,ast2x00-scu.yaml           | 114 ++++
 .../pinctrl/aspeed,ast2700-soc0-pinctrl.yaml       | 188 ++++++
 drivers/pinctrl/aspeed/Kconfig                     |   9 +
 drivers/pinctrl/aspeed/Makefile                    |   1 +
 drivers/pinctrl/aspeed/pinctrl-aspeed-g7-soc0.c    | 749 +++++++++++++++++++++
 5 files changed, 1061 insertions(+)
---
base-commit: d56d5530300be5e3060c9fe2cac49f3404fcfcc5
change-id: 20251215-upstream_pinctrl-8f195df0a975

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


