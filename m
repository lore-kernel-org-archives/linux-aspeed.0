Return-Path: <linux-aspeed+bounces-1371-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3D6C677C4
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 07:37:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHHYP150Pz307V;
	Wed, 11 Jun 2025 17:37:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749627433;
	cv=none; b=eUbWuKzzZiGJcJCKJFQdY79ZkXVhahsOluOnJsACg+eD/LEpJ8X3GZWyFhUQJI9v7Ng1H1NX4JpC4XFF1xDSYSfgySpVlbdsRzxU+p+MFJjwRGD9qkXX62S60pyZin6kpbRNWNjloObDIWu5/E7ByRXDLJEZQcPAwE+2RPf+5TihPLXBKstTxB/3ZrXttSeW0Xm3XnAZzkdoiW/kP+i9N1Gq32QFM52ZlBYJ0inHpfvBHgM4zAYzIcmDaIZghMyN7gTURqMV+o1KQfaLlKsAGbDQrj4B8yImQUgXULQe74W6331egLa7dNwONN4Ms/qyhx082LMsYrFhJCRleh6v5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749627433; c=relaxed/relaxed;
	bh=uhHYYcW5AIdgmbidQiL3tyyVv/3trFNCtIe4b6GxwOw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f8QilXNzTDydwNjQ5292iTAhPp1vCujUMDfpvYJbtHGLBqDeBt1du5wHSeOpnQ6vANtlswdxn67su3wC3pUirAxRNzXAqQGEifKachbXp9LmaoXNJoDYSL5I5J7p/8BHkfx92lIx6PZ6J93JkyDAtZSAbU2cf2XQE/8c52wRrGp6sqaR+k6RIP5ozGluvoPQCoyqJcUje6xf+xOS7H57tPk4jAnd3IQDnOujwM5h18ecs5MhSSA6ZJoHAj1Z9PkhBkAFJhnPwm3avV0tRGMTPcx0cW6bGUhgrCpFm4WQfFXbF0U6yeBf/tVivRNHKwOuzXW73wcYSQ05d9wlsEl1jQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 315 seconds by postgrey-1.37 at boromir; Wed, 11 Jun 2025 17:37:12 AEST
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHHYN1QcPz2yMt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 17:37:12 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 11 Jun
 2025 15:31:40 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 11 Jun 2025 15:31:39 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mo Elbadry <elbadrym@google.com>, "Rom
 Lemarchand" <romlem@google.com>, William Kennington <wak@google.com>, "Yuxiao
 Zhang" <yuxiaozhang@google.com>, <wthai@nvidia.com>, <leohu@nvidia.com>,
	<dkodihalli@nvidia.com>, <spuranik@nvidia.com>
Subject: [PATCH v10 0/3] Add support for AST2700 clk driver
Date: Wed, 11 Jun 2025 15:31:36 +0800
Message-ID: <20250611073139.636724-1-ryan_chen@aspeedtech.com>
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

This patch series is add clk driver for AST2700.

AST2700 is the 8th generation of Integrated Remote Management Processor
introduced by ASPEED Technology Inc. Which is Board Management controller
(BMC) SoC family. AST2700 have two SoC connected, one is SoC0, another
is SoC1, it has it's own scu, this driver inlcude SCU0 and SCU1 driver.

v10:
-aspeed,ast2700-scu.h:
-add SOC0_CLK_AHBMUX, SOC0_CLK_MPHYSRC, SOC0_CLK_U2PHY_REFCLKSRC,
 SOC1_CLK_I3C.
-clk-ast2700.c
-add #include <linux/auxiliary_bus.h>
-remove #include <soc/aspeed/reset-aspeed.h>
-use devm_auxiliary_device_create replace aspeed_reset_controller_register
-reset-aspeed.c:
-remove aspeed_reset_unregister_adev, aspeed_reset_adev_release,
 aspeed_reset_controller_register.
-compatible name change reset_aspeed.reset0/1 -> clk_ast2700.reset0/1
-remove reset-aspeed.h

v9:
-aspeed,ast2700-scu.h: no change.
add more clear commit description.
-clk-ast2700.c:
add inlcude bitfield.h
remove redundant clk_parent_data soc0_mpll_div8/soc0_ahb/uart13clk/
uart14clk/uart15clk/uart16clk/soc1_ahb/d_clk_sels

v8:
-aspeed,ast2700-scu.h: remove no use soc0 clock, add new clock
-clk-ast2700.c: remove include <linux/auxiliary_bus.h>,
include <linux/clk-provider.h>, include <linux/of_address.h>
-clk-ast2700.c: add include <linux/mod_devicetable.h>
-clk-ast2700.c: modify include <soc/aspeed/reset-aspeed.h> order before
dt-bindings
-clk-ast2700.c: modify define to be tabbed out space
-clk-ast2700.c: add union struct for each clk type
	union {
		struct ast2700_clk_fixed_factor_data factor;
		struct ast2700_clk_fixed_rate_data rate;
		struct ast2700_clk_gate_data gate;
		struct ast2700_clk_div_data div;
		struct ast2700_clk_pll_data pll;
		struct ast2700_clk_mux_data mux;
	} data;
-clk-ast2700.c: modify clk_data = device_get_match_data(dev);
-clk-ast2700.c: modify builtin_platform_driver_probe to 
arch_initcall(clk_ast2700_init)
-clk-ast2700.c: ast2700_clk_hw_register_hpll explain: scu010[4:2],
scu010[4:2] = 010, hpll force 1.8Ghz
scu010[4:2] = 011, hpll force 1.7Ghz
scu010[4:2] = 110, hpll force 1.2Ghz
scu010[4:2] = 111, hpll force 800Mhz
others depend on hpll parameter register setting.

v7:
-reset-aspeed.h: fix declare static inline aspeed_reset_controller_register
if the function is not used.

v6:
-patch-2: add reset-aspeed.h
-reset-aspeed: add include cleanup.h for guard()
-reset-aspeed: change ids name clk_aspeed to reset_aspeed
-reset-aspeed: move aspeed_reset_controller_register,
aspeed_reset_adev_release, aspeed_reset_unregister_adev from clk-ast2700.c
-reset-aspeed: drop base check, since it check in clk-ast2700.c
-clk-ast2700: sync each gate name from *clk to *clk-gate name.
-clk-ast2700: add CLK_GATE_ASPEED to diff clk_hw_register_gate and
ast2700_clk_hw_register_gate.

v5:
-patch-2 Kconfig: add select AUXILIARY_BUS
-reset-aspeed: #define to_aspeed_reset(p) turn into static inline function.
-reset-aspeed: modify spin_lock_irqsave to guard(spinlock_irqsave)
-reset-aspeed: remove unnecessary parentheses.
-clk-ast2700: use <linux/units.h> and refrain from define clk

v4:
-yaml: keep size-cells=<1>.
-merge clk,reset dt binding header with yaml the same patch.
-rename clk,reset dt binding header to aspeed,ast2700-scu.h
-reset-aspeed: update tables tabs sapces to consistent spaces.
-reset-aspeed: remove no use dev_set_drvdata.
-clk-ast2700: modify reset_name to const int scu in struct clk_data.
-clk-ast2700: use scu number in clk_data generate reset_name for reset
 driver register.
-clk-ast2700: fix pll number mix up scu0,scu1.
-clk-ast2700: update dt-binding clock include file.

v3:
-yaml: v2 missing send yaml patch, v3 add.
-yaml: drop 64bits address example.
-yaml: add discription about soc0 and soc1
-dt-bindings: remove (), *_NUMS, reserved.
-dt-bindings: remove dulipated define number.
-dt-bindings: merge clk and reset to be one patch.
-reset-aspeed: add auxiliary device for reset driver.
-clk-ast2700: modify reset to be auxiliary add.
-clk-ast2700: modify to be platform driver.
-clk-ast2700: modify each clk to const clk array.

v2:
-yaml: drop 64bits address example.
-yaml: add discription about soc0 and soc1
-dt-bindings: remove (), *_NUMS, reserved.
-dt-bindings: remove dulipated define number
-clk-ast2700: drop WARN_ON, weird comment.

Ryan Chen (3):
  dt-binding: clock: ast2700: modify soc0/1 clock define
  reset: aspeed: register AST2700 reset auxiliary bus device
  clk: aspeed: add AST2700 clock driver

 drivers/clk/Kconfig                           |    8 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-ast2700.c                     | 1138 +++++++++++++++++
 drivers/reset/Kconfig                         |    7 +
 drivers/reset/Makefile                        |    1 +
 drivers/reset/reset-aspeed.c                  |  253 ++++
 .../dt-bindings/clock/aspeed,ast2700-scu.h    |    4 +
 7 files changed, 1412 insertions(+)
 create mode 100644 drivers/clk/clk-ast2700.c
 create mode 100644 drivers/reset/reset-aspeed.c

-- 
2.34.1


