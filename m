Return-Path: <linux-aspeed+bounces-3966-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66ACEFF885D
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Apr 2026 09:55:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4bQF0DlCz2yr4;
	Tue, 28 Apr 2026 19:55:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777370100;
	cv=none; b=odEyPmsdsNDrzm2OC9PHRGQ7B8oYP+GmuBYUWBTa5f1IjSfDfzC8UpntemyTcO3vOgPsyqjBwwk+z3QSnKhZHy8JVRTBw/dHvFjrT1SYhCjZG7Ys9XBpSFEBKLBot6QxOV2YqUR+GJS+AP3OOATqXKX8OXzTZV5mGT0xzW6+NzLMFIwv9bMb8oraS18CxM9IdaBzRXKTnfUH29TCe3TN+rkkSIRImP10suQuaTKtLrWQDGN1gtoek40RUBNZBzl8UF6Md1cFWNaBZ1a6LUNG+zz4C7I/gmO2U82EuHQ8H1LlKanwBUexbDgaSs3qvKlXi4VXp8lAMtFM2t47vtpZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777370100; c=relaxed/relaxed;
	bh=zx7TDcXU3J2Idf0+GKa+Mg8DvIpPQ2yEOMz9hP1Bmh4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ljhU6u1vhQKoSWx7wFNeGLcCqO1D2EBXsIyQJGs+1G6W8roe2ZynYyygvy2qXpZ9u2DIe12i5Efb/yZkQcfqAp+8DEIwR4FH5OqwTyyuECwfBvmOvs2at70++gZrCcwwIjMe1zabCV5snb5SppMd2+vEsIADU/FVkEtccQ50MQJFpPc0EgWGt4lieE+sC6e6DVB9x4Yg9tIq+GRC8Apu873BL3Bjshz5bHxoJNdk/EBgYu3ER5Wkz/CpBNmPNBev+U5uNR4pCATQGhvgpIOIgyuFu65nVfjFVp3yDnZu7wMCOynW7VlE8UW4knKryiJr05s0pRK6kDYMI7Jzkh3JiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4bQD0TxLz2yYy;
	Tue, 28 Apr 2026 19:54:59 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 28 Apr
 2026 17:54:41 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 28 Apr 2026 17:54:41 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v8 0/3] pinctrl: aspeed: Add AST2700 SoC0 support
Date: Tue, 28 Apr 2026 17:49:44 +0800
Message-ID: <20260428-upstream_pinctrl-v8-0-eb8ef9ab0498@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIALiC8GkC/23PS27DIBgE4KtErEvEz5uueo+qirCBGskvAbUaR
 b57cRZt1LCcxXyauaHsU/QZvZ5uKPkt5rjMNeiXE+oHO396HF3NiBIqgILAX2suydvpssa5L2n
 EOoARLhBrlEC1tiYf4vedfP+oOaRlwmWonV+IGMKBME7grDXVCgPu4jheLyXb+Gbz6r0rvh/O/
 TId5BBzWdL1PnLjB3wwkjAin/dsHBNsHffadrrj2vwHj1GbeFAYNBRRFW0MD8KEwKRqKvJP4cA
 biqyKIiZQoMpZxpqKelRaj1RVnKJKUioYyGdl3/cffVZ60MoBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777370081; l=5690;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=5g9C5IzH3BHVfX1VLs++p+p0Y+wfHM4gqEcZ1ACvo3Q=;
 b=b+rFKyBb7OY25D2LOaIZ8nVEt0mxlw2E3OA3xQtNA9EV/xBpo3YiaGzr/ma/s1tJhNC9JKn4o
 JtTCeUjV7KNARrHcoDO+dYNBr6wWkZhlT/IjaLPmJI4e9oJxK9nhoJa
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
 .../pinctrl/aspeed,ast2700-soc0-pinctrl.yaml       | 187 +++++
 drivers/pinctrl/aspeed/Kconfig                     |   9 +
 drivers/pinctrl/aspeed/Makefile                    |   1 +
 drivers/pinctrl/aspeed/pinctrl-aspeed-g7-soc0.c    | 749 +++++++++++++++++++++
 5 files changed, 1060 insertions(+)
---
base-commit: 8d50ba32c7a22179b8648433247e97d2e8563366
change-id: 20251215-upstream_pinctrl-8f195df0a975

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


