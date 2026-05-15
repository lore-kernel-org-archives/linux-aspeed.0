Return-Path: <linux-aspeed+bounces-4033-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0F8CD343F
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 May 2026 09:38:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH2Dj4FLmz2xqv;
	Fri, 15 May 2026 19:37:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778837877;
	cv=none; b=m6/Vh1/VTyDVBLNwVrjFFFLTYXrp0hBlglivr1Dkn3tGTxZ3TH/t+XCBfHIrr73QDybJHZJLKqDcK8m6aInU4gGcZ1xgFf1+iGvdTScNd+7sAxnUeqGEqqC+rOzgzkFUDIroEWGHSXJtrvf0+Wcjpincd4+yDtHV3htAdWlWWB5YxAcaRWLKUv2o9LmSnvjdk2Xp6NMbOeGsyE4yflYz/QvvENzqmgkDOYuSXTpgROjmguVeN+sgPLBsaBMVhvset3QlHU4KEXHlhZNt95kEWkDq0RqNV//Cs7fjxN/WZyDCrOlAPgR5ExzlcFW4cqCyAPTe/h2QIulFtoHtmDMbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778837877; c=relaxed/relaxed;
	bh=nz40TiFNC9+ht1LjUoKBL2ZBUTaGeJKCxbuiHSpIf2s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=kZjsFRCue8JyyUhXVDICIa5N5y9qh7AzpnuCwMzxMh4D2JNTnU1VFhzDSaXwfvfcr1c2uon0aMfDx6HlxdoVJQYp3JuF03wE2dGqc2TnncdhR4qSQIQjVYwofes/DLu2Q0YudPr37bq7dCqtBQX55q4aPjH40HnMxmcdRNQ6fAZnsi7lKZG4nI7DTJqQyIERpd2f3I8P/lsY3hVDT4mjzw0M6yTDTEXAEvi9FY4+isPf5EiosarxsTxU4PXOAFJeUQlfZjftNtqpN+abjoUk3WQGzRzGc9xQ7YZLy31etIHpsU7FrzezPewgOZcVyBi8pDt0rnioVo5L8R8URh/lyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH2Dh1Vqfz2xHF;
	Fri, 15 May 2026 19:37:55 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 15 May
 2026 17:37:38 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 15 May 2026 17:37:38 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v3 0/3] pinctrl: aspeed: Add AST2700 SoC1 support
Date: Fri, 15 May 2026 17:37:36 +0800
Message-ID: <20260515-pinctrl-single-bit-v3-0-e97da4312104@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAGDpBmoC/23NQQ6CMBCF4auQrq1pp4rgynsYF6VMYRIspG0aD
 eHuFhLjQpb/S+abmQX0hIFdi5l5TBRodDnUoWCm165DTm1uBgJKAVLyiZyJfuCBXDcgbyjyVoN
 UFiow9Znlw8mjpdeG3h+5ewpx9O/tR5Lr+uXUHpckF9yUwoJtKoG2uekwIbYRTX8045OtZoKfo
 0S560B2LnUtK2N1U57kn7MsyweU7CU4AQEAAA==
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
	<billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778837858; l=4269;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=9Cn9pDIuyFA9O7PKzEDGkjk/BPWLh9Gxh6Xx0JghGi0=;
 b=GkjgcF1HK1mq+U56PeB/4J8NkQ8iJNGyrh5Cu984mgNvSqUvhC42xoHRoQtJ3QGQZlqDRIlzz
 +L1gv+Tlej5DXm/LV7HbijCAWqOKfNlEhvJszrkCnwAgTa5+TLPmcJc
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
 drivers/pinctrl/aspeed/pinctrl-aspeed-g7-soc1.c    | 1732 ++++++++++++++++++++
 5 files changed, 2508 insertions(+)
---
base-commit: e532a5a81d0db872acd2c0a92d2639580ca3da44
change-id: 20260211-pinctrl-single-bit-da213f282c95

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


