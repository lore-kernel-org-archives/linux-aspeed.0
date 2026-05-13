Return-Path: <linux-aspeed+bounces-4020-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE010CD37B6
	for <linux-aspeed@archiver.kernel.org>; Wed, 13 May 2026 05:32:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFhtR2Gvfz2xpp;
	Wed, 13 May 2026 15:32:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778650351;
	cv=none; b=Ul23CnJY3PQ+uF1q29Im7mavzIRbzTZ+h52igQJ3dE3gwN8MGV8feR2jnUGkrDDNUFqYuhNzB2EuaACb5tC53eh328b0k8WP7yKzx2ZcHlMLxaO85sKOA3XJC4fdZ3FUHbcmqr20Uf6SYmdy9K/NgwoQjz4IX43SFtt47egwAK2UDRJTEZtd979dzGXPiE5NZoHp95XjhcR1xQHRg6yAt4rdqxFrUw6p3kbg5slPDM+fDHIJvLtjsAe5/OpQn5IxpqXyTbvse3AAWAGONeianCbx8tQJVL7SwSSl9W0WZeX2qkxALYaa791Tm2Jm7gXh3oLiDOKHDH5d8oFshyKtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778650351; c=relaxed/relaxed;
	bh=9tscC4fABhqzy3I2ZsFm1SKcg9OLj/52lZacF489VnQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=KUX8DOtjVRDE0J+GENa13n1W1fjE2YihzFvyexvL+BhbykYm1aVnm5v5tb+Bg+dZcJPPDfivZSYNK9Ev/v96L0y+STSmQOSSRthtZ5unbtTeiGW1NcudJGkscNlbTeYEy2TSq/M8DHK631I010QEdcWf92FmSRlsISc6qmQx+Ln5Qb9GJloBxoKhAQ2F3+n+tkZJ9QW4fMcIsp5a18Jjfu/RDGAjHe2KlR+qQF5fHu6xX7SKpWB3o2O/IU/lM4d6yE77Blstaz5vktAum1JmLxy5oQtpY8rgBLrWLcX6Yb6M6kpKDWJNiG+N0wogosPfcM2kLKPxFC5Lpin6jlw/pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFhtP4m2fz2xn3;
	Wed, 13 May 2026 15:32:29 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 13 May
 2026 13:32:11 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 13 May 2026 13:32:11 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH RESEND v29 0/4] Add ASPEED AST2600 I2C controller driver
Date: Wed, 13 May 2026 13:31:59 +0800
Message-ID: <20260513-upstream_i2c-v29-0-fe9926964d55@aspeedtech.com>
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
Content-Transfer-Encoding: 8bit
To: <jk@codeconstruct.com.au>, <andriy.shevchenko@linux.intel.com>, Andi Shyti
	<andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Rayn Chen
	<rayn_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778650331; l=14961;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=ZmuLLZ+x/0Tay35OfOdTmE8jn4WWrRMZmoxNm6d9eks=;
 b=aS2knuT1DgyXGsVhx+8vnqvoqK8Yh2VawUY+RMii4s7XcX+agi9Q4n91QRbW04GgY+OD1K7ea
 jR7vc3YahT0DZPGIwF6qg0NysXz0mc0IC7ctpXwOqK+d5sbE7lzH95y
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

This series adds support for the AST2600 I2C controller “new register
set” implementation.

The AST2600 I2C controller introduces a revised register layout which
separates controller and target functionality into distinct register
blocks, and extends clock divider configuration and packet-based
transfer support compared to the legacy mixed register layout used on
earlier ASPEED SoCs.

The current driver implementation for the AST2600 I2C peripheral is
through the hardware's "compatibility mode", which exposes a register
set that matches the previous generation hardware (AST2500 and earlier).

Instead, add a driver that works in new-register-set mode, to allow the
new features, and will provide support for future hardware that will
not implement compatibility mode.

In order to support the new mode, we need a DT binding change to
reflect the reference to the global register set. Since the binding
still represents the same (AST2600 SoC) physical hardware, we continue
to use the existing compatible string of "aspeed,ast2600-i2c-bus".

However: since we're changing semantics for an existing binding, we
allow backwards compatibility by selecting on presence/absence of the
newly-added properties, and fall back to the old driver (ie., in
compatibility mode) when we detect a DT using the old binding spec.

Specifically:

- ast2600-i2c-bus nodes that provide the `aspeed,global-regs` property
  (present in the new binding and absent in the legacy binding) will be
  successfully probed by the new driver

- ast2600-i2c-bus nodes without `aspeed,global-regs` continue to use the
  existing driver (in legacy register mode), ensuring that platforms
  with the current DTBs remain functional

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v29:
- 2/4: remove aspeed,enable-dma properties.
- 3/4: update commit message remove transfer mode selection.
- 3/4: remove sysfs file.
- 3/4: remove define I2C_TARGET_MSG_BUF_SIZE and AST2600_I2C_DMA_SIZE.
- 3/4: remove buf_index in struct ast2600_i2c_bus.
- 3/4, 4/4: remove dma/byte mode, use buffer mode only.
- 4/4: fix race between unreg_target and IRQ handler.
- 4/4: move i2cs ier enable from ast2600_i2c_init to probe after master ier enable.
- Link to v28: https://lore.kernel.org/r/20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com

Changes in v28:
- 2/4: update commit message correspond with aspeed,enable-dma.
- 2/4: remove aspeed,transfer-mode and add aspeed,enable-dma property
  and description.
- 2/4: Fix aspeed,enable-dma description to reflect hardware capability
  rather than software behavior.
- 3/4: Separate xfer_mode_store into distinct parse and availability-check
  steps by introducing ast2600_i2c_xfer_mode_check().
- 3/4: fix tx dma memcpy source point address.
- 3/4: Use a temporary variable for devm_platform_get_and_ioremap_resource()
  to avoid storing an ERR_PTR in i2c_bus->buf_base; drop the redundant
  NULL assignment in the error path since i2c_bus is kzalloc()ed.
- 3/4: Add ABI documentation file
  Documentation/ABI/testing/sysfs-driver-ast2600-i2c.
- 4/4: fix typo condication -> condition.
- 4/4: fix compile error, when disable CONFIG_I2C_SLAVE.
- Link to v27: https://lore.kernel.org/r/20260324-upstream_i2c-v27-0-f19b511c8c28@aspeedtech.com

Changes in v27:
- 1/4 use aspeed,enable-dma instead aspeed,transfer-mode.
- 2/4 remove aspeed,transfer-mode selection instad aspeed,transfer-mode
- 2/4 add sysfs for xfer mode.
- Link to v26: https://lore.kernel.org/r/20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com

Changes in v26:
- 1/4: binding reworks based on review feedback
- Link to v25: https://lore.kernel.org/r/20260225-upstream_i2c-v25-0-9f4bdd954f3f@aspeedtech.com

Changes in v25:
- Use b4 to send series.
- Rebase on v7.0-rc1.
- Clarify cover letter and commit logs based on review feedback.
- Remove the i2c-aspeed-core multiplexer infrastructure and
  implement driver selection via conditional -ENODEV handling
  in individual probe() functions.
- 3/4: incorporate review feedback and refactor new driver
- Link to v24: https://lore.kernel.org/r/20251118014034.820988-1-ryan_chen@aspeedtech.com

Changes in v24:
- aspeed,ast2600-i2c.yaml
 - fix make dt_binding_check blank warning.
- Link to v23: https://lore.kernel.org/all/20251117025040.3622984-1-ryan_chen@aspeedtech.com/

Changes in v23:
- update typo patch (1/4) commit message.
- aspeed,ast2600-i2c.yaml
 - update reg and description.
- i2c-ast2600.c controller
 - replace ast2600_select_i2c_clock to ast2600_i2c_ac_timing_config.
- i2c-ast2600.c target
 - I2C_TARGET_MSG_BUF_SIZE 256 to 4096
 - remove blank line.
 - refine Master comment description to controller
- Link to v22: https://lore.kernel.org/all/20251112085649.1903631-1-ryan_chen@aspeedtech.com/

Changes in v22:
- update patch (1/4) commit message add dts example reason.
- aspeed,ast2600-i2c.yaml @patch (1/4)
 - rename ast2600-i2c.yaml to aspeed,ast2600-i2c.yaml.
 - update reg, clock-frequency description.
- aspeed,ast2600-i2c.yaml @patch (2/4)
 - aspeed,transfer-mode, aspeed,transfer-mode add for ast2600.
- i2c-aspeed-core.c,h @patch (3/4)
 - add i2c-aspeed-core allow both old and new device trees using the
   same compatible string "aspeed,ast2600-i2c-bus".
- Link to v21: https://lore.kernel.org/all/20251027061240.3427875-1-ryan_chen@aspeedtech.com/

Changes in v21:
- update patch (1/4) commit message
- i2c-ast2600.c
 - move rst to local variable in ast2600_i2c_probe().
- Link to v20: https://lore.kernel.org/all/20251021013548.2375190-1-ryan_chen@aspeedtech.com/

Changes in v20:
- ast2600-i2c.yaml
 - fix warning at make dt_binding_check.
- Link to v19: https://lore.kernel.org/all/20251020013200.1858325-1-ryan_chen@aspeedtech.com/

Changes in v19:
- Split AST2600 binding into its own YAML file
 - Removed `aspeed,ast2600-i2c-bus` from `aspeed,i2c.yaml`
 - Added `aspeed,global-regs` and `aspeed,transfer-mode` to AST2600 binding
- Link to v18: https://lore.kernel.org/all/20250820051832.3605405-1-ryan_chen@aspeedtech.com/

Changes in v18:
- refine patch (1/3) commit message (reason for commit not list.)
- i2c-ast2600.c
 - remove redundant reset_control_deassert in driver probe.
 - remove reset_control_assert(i2c_bus->rst) in driver remove.
- Link to v17: https://lore.kernel.org/all/20250814084156.1650432-1-ryan_chen@aspeedtech.com/

Changes in v17:
- move i2c new mode register and feature into driver commit message.
- aspeed,i2c.yaml
 - remove multi-master properties.
 - use aspeed,transfer-mode properties for aspeed,enable-byte/enable-dma.
-i2c-ast2600.c
 - rename dma_safe_buf to controller_dma_safe_buf.
 - fix ast2600_i2c_recover_bus return overflow warnings.
 - add ast2600_i2c_target_packet_buff_irq unhandle case.
 - add parameter "cmd" in ast2600_i2c_setup_dma_rx,
   ast2600_i2c_setup_buff_rx, ast2600_i2c_setup_byte_rx
 - use reset_control_deassert replace
   devm_reset_control_get_shared_deasserted.
 - useaspeed,transfer-mode properties for transfer mode setting.
 - change compatible = "aspeed,ast2600-i2cv2" to "aspeed,ast2600-i2c-bus".
- Link to v16: https://lore.kernel.org/all/20250224055936.1804279-1-ryan_chen@aspeedtech.com/

Changes in v16:
- aspeed,i2c.yaml: add aspeed,enable-byte properties for force byte mode.
- i2c-ast2600.c
 - change include asm/unaligned.h to linux/unaligned.h.
 - add reset timeout councter when slave active timeout.
 - modify issue i2c_recovery_bus before slave re-enable.
 - add aspeed,enable-byte properties.
- Link to v15: https://lore.kernel.org/all/20241007035235.2254138-1-ryan_chen@aspeedtech.com/

Changes in v15:
- i2c-ast2600.c
 - add include unaligned.h
 - rename all master -> controller, slave -> target.
 - keep multi-master to align property.
 - remove no used element in ast2600_i2c_bus.
- Link to v14: https://lore.kernel.org/all/20241002070213.1165263-1-ryan_chen@aspeedtech.com/

Changes in v14:
- aspeed,i2c.yaml
 - v13 change people reviewed-by tag, v14 fixed to original people tag,
   modify to Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 - struct ast2600_i2c_bus layout optimal.
 - ast2600_select_i2c_clock refine.
 - ast2600_i2c_recover_bus overridden fix.
 - dma_mapping_error() returned error code shadowed modify.
 - buffer register in a 4-byte aligned simplified
 - remove smbus alert
- Link to v13: https://lore.kernel.org/all/20240819092850.1590758-1-ryan_chen@aspeedtech.com/

Changes in v13:
 - separate i2c master and slave driver to be two patchs.
 - modify include header list, add bits.h include. remove of*.h
 - modify (((x) >> 24) & GENMASK(5, 0)) to (((x) & GENMASK(29, 24)) >> 24)
 - modify ast2600_select_i2c_clock function implement.
 - modify ast2600_i2c_recover_bus function u32 claim to
   u32 state = readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF);
- Link to v12: https://lore.kernel.org/all/20230714074522.23827-1-ryan_chen@aspeedtech.com/

Changes in v12:
- aspeed,i2c.yaml
 - add Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
- i2c-ast2600.c
 - update include by alphabetical order
 - make just a one TAB and put the last two lines on the single one
 - remove no used timing_table structre
 - remove enum explicit assinment
 - rewritten to avoid this and using loop in ast2600_select_i2c_clock
 - use GENMASK for most 0xffff
 - remove too many parentheses
 - use str_read_write replace read write string
 - remove redundant blank line after ast2600_i2c_bus_of_table
 - fix wrong multi-line style of the comment
 - use macro for i2c standard speeds
 - remove useless noise dev_info
- Link to v11: https://lore.kernel.org/all/20230430041712.3247998-1-ryan_chen@aspeedtech.com/

Changes in v11:
- aspeed,i2c.yaml
 - no change, the same with v10.
- i2c-ast2600.c
 - modify alert_enable from int -> boolean.
 - modify dbg string recovery -> recover.
 - remove no need to init 0.
 - remove new line after break.
 - remove unneeded empty line.
 - modify dma_alloc_coherent to dmam_alloc_coherent
 - modify probe nomem return dev_err_probe
 - modify i2c_add_adapter to devm_i2c_adapter
 - modify checkpatch: Alignment should match open parenthesis
 - modify checkpatch: braces {} should be used on all arms of this statement
 - modify checkpatch: Unbalanced braces around else statement
- Link to v10: https://lore.kernel.org/all/20230415012848.1777768-1-ryan_chen@aspeedtech.com/

Changes in v10:
- aspeed,i2c.yaml
 - move unevaluatedProperties after allOf.
 - remove extra one blank line.
- i2c-ast2600.c
 - no change, the same with v8.
- Link to v9: https://lore.kernel.org/all/20230405022825.333246-1-ryan_chen@aspeedtech.com/

Changes in v9:
- aspeed,i2c.yaml
 - backoff to v7.
  - no fix typo in maintainer's name and email. this would be another patch.
  - no remove address-cells, size-cells, this would be another patch.
 - use aspeed,enable-dma property instead of aspeed,xfer-mode selection.
 - fix allOf and else false properties for aspeed,ast2600-i2cv2.
- i2c-ast2600.c
 - no change, the same with v8
- Link to v8: https://lore.kernel.org/all/20230330073259.485606-1-ryan_chen@aspeedtech.com/

Changes in v8:
- aspeed,i2c.yaml
 - modify commit message.
 - Fix typo in maintainer's name and email.
 - remove address-cells, size-cells.
- i2c-ast2600.c
 - move "i2c timeout counter" comment description before property_read.
 - remove redundant code "return ret" in probe end.
- Link to v7: https://lore.kernel.org/all/20230327092524.3916389-1-ryan_chen@aspeedtech.com/

Changes in v7:
- aspeed,i2c.yaml
 - Update ASPEED I2C maintainers email.
 - use aspeed,enable-dma property instead of aspeed,xfer-mode selection.
 - fix allOf and else false properties for aspeed,ast2600-i2cv2.
- i2c-ast2600.c
 - remove aspeed,xfer-mode instead of aspeed,enable-dma mode. buffer mode
   is default.
 - remove aspeed,timeout instead of i2c-scl-clk-low-timeout-us for
   timeout setting.
- Link to v6: https://lore.kernel.org/all/20230226031321.3126756-1-ryan_chen@aspeedtech.com/

Changes in v6:
- remove aspeed,i2cv2.yaml, merge to aspeed,i2c.yaml -add support for
  i2cv2 properites.
- i2c-ast2600.c
 - fix ast2600_i2c_remove ordering.
 - remove ast2600_i2c_probe goto labels, and add dev_err_probe -remove
   redundant deb_dbg debug message.
 - rename gr_regmap -> global_regs
- Link to v5: https://lore.kernel.org/all/20230220061745.1973981-1-ryan_chen@aspeedtech.com/

Changes in v5:
- remove ast2600-i2c-global.yaml, i2c-ast2600-global.c.
- i2c-ast2600.c
 - remove legacy clock divide, all go for new clock divide.
 - remove duplicated read isr.
 - remove no used driver match
 - fix probe return for each labels return.
 - global use mfd driver, driver use phandle to regmap read/write.
- rename aspeed,i2c-ast2600.yaml to aspeed,i2cv2.yaml -remove bus-frequency.
- add required aspeed,gr
- add timeout, byte-mode, buff-mode properites.
- Link to v4: https://lore.kernel.org/all/20230201103359.1742140-1-ryan_chen@aspeedtech.com/

Changes in v4:
- fix i2c-ast2600.c driver buffer mode use single buffer conflit in
  master slave mode both enable.
- fix kmemleak issue when use dma mode.
- fix typo aspeed,i2c-ast2600.yaml compatible is "aspeed,ast2600-i2c"
- fix typo aspeed,i2c-ast2600.ymal to aspeed,i2c-ast2600.yaml
- Link to v3: https://lore.kernel.org/all/20220516064900.30517-1-ryan_chen@aspeedtech.com/

Changes in v3:
- fix i2c global clock divide default value.
- remove i2c slave no used dev_dbg info.
- Link to v2: https://lore.kernel.org/all/20220413101735.27678-1-ryan_chen@aspeedtech.com/

Changes in v2:
- add i2c global ymal file commit.
- rename file name from new to ast2600.
  aspeed-i2c-new-global.c -> i2c-ast2600-global.c
  aspeed-i2c-new-global.h -> i2c-ast2600-global.h
  i2c-new-aspeed.c -> i2c-ast2600.c
- rename all driver function name to ast2600.
- Link to v1: https://lore.kernel.org/all/20220323004009.943298-1-ryan_chen@aspeedtech.com/

---
Ryan Chen (4):
      dt-bindings: i2c: Split AST2600 binding into a new YAML
      dt-bindings: i2c: ast2600-i2c.yaml: Add global-regs properties
      i2c: ast2600: Add controller driver for AST2600 new register set
      i2c: ast2600: Add target mode support

 .../bindings/i2c/aspeed,ast2600-i2c.yaml           |   69 ++
 .../devicetree/bindings/i2c/aspeed,i2c.yaml        |    3 +-
 drivers/i2c/busses/Makefile                        |    2 +-
 drivers/i2c/busses/i2c-aspeed.c                    |    5 +
 drivers/i2c/busses/i2c-ast2600.c                   | 1148 ++++++++++++++++++++
 5 files changed, 1224 insertions(+), 3 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260223-upstream_i2c-ebd07f89739c

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>


