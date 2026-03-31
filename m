Return-Path: <linux-aspeed+bounces-3816-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44473FF60DB
	for <linux-aspeed@archiver.kernel.org>; Tue, 31 Mar 2026 07:32:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flKZF6ZmPz2ybQ;
	Tue, 31 Mar 2026 18:32:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774942325;
	cv=none; b=QZOlQcHEQXt+pYnT4ncZszBzW4XSCvCpqeeXN3mnHDEShe96T4mjQOzT8s0rQZN4C6c8MdMI00Li0CLt/STnoemJPBzyfjEGChhAa3uYS96LeqMoaSOPsWlT4YuEPUhk2fXvTDj63n74vqZG/dbLb1O5q39iW/kuBWQHvlts8ImF77wYxTddj1XDzI72/VQy+L68aVvCUAOu4gNCAZoLmNe3o5m68WrxECifShMHDyZmqyhhCOeH4eCDMIVdeEOvC+LdZyufzX79NR9JE8LrAFqO0uuI856Qxn9NeAOsH/+I7wjqQ0sGKJv55FCp09wmU0pBnQgpaYqWUYMjEdagwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774942325; c=relaxed/relaxed;
	bh=1booxj/4+s2/mOOmT994Kl+DJOj4mNF/QvMvMsul5xs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=DwmrCTgtceB63uts7ZJcK2gRlVJRQT0CZisxrqmF9HyhFJwCaIV6oiKuklu+SqhH+zV657Ft5y4WoVYJce3Ji+jWypOv/w1dOq/ssrIbNTcN4Dr43yiXkszrBIHKysCM5pLuciMmr6KhCwlF9XLA199P3tSbOCNugg24BPg67zvDcfYbcEFLQ/MgWWmlK/m90mCYYD+W85RPyt1NFE7bNHxUlsnvrl5asOUUPOt7r9h906GLDYmDeWLb1ApS6xNH3p7opnmI/6zhxu+eD/nyFNCwrvHHYbbDQUZ37F/7kzP7NpZVB0SVJ2RewygDlPkqljG6IAKtNUvcuPDy4l+ZwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flKZD6szgz2xSb;
	Tue, 31 Mar 2026 18:32:04 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 31 Mar
 2026 15:31:46 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 31 Mar 2026 15:31:46 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v5 0/3] pinctrl: aspeed: Add AST2700 SoC0 support
Date: Tue, 31 Mar 2026 15:31:15 +0800
Message-ID: <20260331-upstream_pinctrl-v5-0-8994f59ff367@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAEN4y2kC/2XOSw6CMBSF4a2Qji25hRaLI/dhCClwkZvwSluJh
 LB3CwMHOvwH58vZmENL6Ngt2pjFhRxNYwh1iVjdmfGJnJrQLIFEiUQo/pqdt2iGcqax9rbnuhW
 5alow+VWxMJsttvQ+yUcRurXTwH0XNl8IcpACUgki1jrRVy54RX2/lt4Zuhs3IzYe6y6up+EgO
 3J+sut5cpEHfDAZpJD9/1kkB24aidpUupI6/wWLfd8/v27IgfgAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774942306; l=4186;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=j/lCVMm5Ghps1IlCQohPFeP1bg8qFP/vfQXBUgF2UOk=;
 b=aOXMWn/+I2zqHn2S2EwLGvr8ir5DNMlD6PgJZepWEs/vXfsC4L+kWgAWP1OHArvvuGxfKb733
 xD7C1dHhGcoDg0e9exp7M/jZIyYUzKv1446iEQRgmDv6hJ0sE0R26uG
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

 .../bindings/mfd/aspeed,ast2x00-scu.yaml           | 117 ++++
 .../pinctrl/aspeed,ast2700-soc0-pinctrl.yaml       | 161 +++++
 drivers/pinctrl/aspeed/Kconfig                     |   9 +
 drivers/pinctrl/aspeed/Makefile                    |   1 +
 drivers/pinctrl/aspeed/pinctrl-aspeed-g7-soc0.c    | 710 +++++++++++++++++++++
 5 files changed, 998 insertions(+)
---
base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
change-id: 20251215-upstream_pinctrl-8f195df0a975

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


