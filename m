Return-Path: <linux-aspeed+bounces-4893-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98137C61DD3
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 11:36:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ3hc3n7Gz2xlv;
	Tue, 01 Sep 2026 21:36:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788262560;
	cv=none; b=BTR/PyJ7ewL1cGsy/ROCgSxM9wJnWu6YQ3Jpwb70pE9MyOdPExKXcnV9ERJjvNK4jVDpx9fduwQO92Vah5OI7bvapZe+rm2bmtuLd1gywidNKdomIYGVnolfQIkBc+LZaL11nCYyWP1ENRz93XNv9/OXnFrSnMM0IIRIqwdcoAUSXsSFlu5kFo/UBbr+FKiDqiQe6KdmLMpK+/DzDhjSwCNLShl45ILgXKWCUISuFgCo0CKk0Sepa0cEa3ORFKyxtox1t7tmle4BFKXPQMjLeCNskmBvq/QelKgqGQHY35MhcAomInBt4gDrjwWLw17YrUslJiE05BAX72A4Y0WboA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788262560; c=relaxed/relaxed;
	bh=PvAHqlfp2Va7fwQM0312kl0agAB45qLgeukn/CeQshg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=TJCFnK3BP/sjjGGIUVatVKGtO5nu8qAm2cdnfCMSTfpmnfLhkWt5mwsig9f7oZXEG1UBU6F3nRC1pnEjR1nh6QxufTzWXzMKzfJ07vTVUa7rIhK8oQ1CCXS/nBfstrprm0RFA/9zZSKrsbnIQsICRleyTbLUlKZYI6EJ5T1gv49IiuJomWsUW68fRDsYlY5j92Vwq2N5YxcqXHPKsrXJRp2udunZFgsQ9Ueszm4KpwQns+lc8al1dzs50UfjGgyplqKuQ1u52hys1jjEXb059Ok0/+WIIr+dLIVvu8Zj9mstmDwflCj2GJ29ULJlvPLyM1CEOeyKN5ZPkiYapobz5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ3hZ3K2Dz2xBK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 21:35:57 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 1 Sep
 2026 19:35:38 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 1 Sep 2026 19:35:38 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH 0/8] i3c: mipi-i3c-hci: Add Aspeed AST2700 support
Date: Tue, 1 Sep 2026 19:35:27 +0800
Message-ID: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAH+4lmoC/x3MPQqAMAxA4atIZgNpLBa8ijj0J2oWlVZEEO9uc
 fyG9x4oklUKDM0DWS4tum8Vpm0grn5bBDVVAxP35IzFYFG7iGtU9OVkR4TBJ8e9MEUyUMMjy6z
 3Px2n9/0ATBpH5GQAAAA=
X-Change-ID: 20260714-b4-i3c-hci-ast2700-bad726e20c01
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788262538; l=4156;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=6FNYMuIcfyXeEFAvGyrxQVzcQ7QcTPfutEiaqj247O8=;
 b=JSuRqICd5+CuJSS7QslnzoOY4wJMdTnNieoLv80R4Qr4ynq8wNsYgtHhu6eQ+Cu1kZLMZXUUV
 13DizEFAJhPC9hSC7Mq9LSrlAsyAWsET0ZmxCzLeRRAszNc+16zTndV
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The Aspeed AST2700 SoC integrates an I3C host controller based on the
MIPI I3C HCI v1.1 programming model, extended with an in-house control
block and a PHY programming window. Both extra register regions are
advertised through a standard HCI vendor extended capability. This
series teaches the existing mipi-i3c-hci driver to drive the AST2700
controller without forking the driver.

The AST2700 specifics are expressed in two ways:

 - Deviations from generic HCI protocol behavior are expressed as
   individual quirks in the match data: the existing
   HCI_QUIRK_DMA_ABORT_REQUIRES_PIO_RESET, plus three new quirks for
   address-indexed DAT slots (HCI_QUIRK_DAT_INDEX_IS_ADDR), 64-bit DMA
   addressing (HCI_QUIRK_DMA_64BIT) and clearing the TX start threshold
   in DMA mode (HCI_QUIRK_TX_START_THLD).

 - Everything that depends on the ASPEED vendor capability actually
   being present -- programming the vendor register blocks (master
   mode init, PHY timing, the interrupt summary path, the IBI
   termination threshold and the DAA index registers), and selecting
   the IRQ handler and IRQF_SHARED at request_irq() time -- is keyed to
   is_aspeed(), a single explicit check set from the devicetree
   compatible in probe().

Generic MIPI I3C HCI controllers are unaffected.

The series is organised as follows:

 - Patch 1 documents the devicetree binding.

 - Patches 2-4 add the generic HCI quirks AST2700 needs --
   address-indexed DAT slots, 64-bit DMA addressing, and clearing the
   TX start threshold in DMA mode -- with no AST2700-specific code yet;
   nothing sets these quirks until patch 5.

 - Patch 5 ties it together: it recognizes the ASPEED vendor extended
   capability, brings the controller up for transfers (master mode,
   PHY timing, reset/clock resources, the interrupt summary path,
   master clock stall), and enables the quirks from patches 2-4 plus
   HCI_QUIRK_DMA_ABORT_REQUIRES_PIO_RESET for the
   "aspeed,ast2700-i3c-hci" compatible.

 - Patch 6 adds the IBI termination threshold, a safeguard against a
   misbehaving device that never terminates a payload IBI on its own.

 - Patches 7-8 tune bus behaviour: PIO TX queue utilization, and the
   PHY's built-in pull-ups for boards without external resistors.

Tested on an AST2700 EVB: the controller probes in DMA/PIO mode,
completes DAA and runs CCC, IBI and private transfers.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Billy Tsai (8):
      dt-bindings: i3c: Document the AST2700 I3C controller
      i3c: mipi-i3c-hci: Support address-indexed DAT slots
      i3c: mipi-i3c-hci: Add a quirk for 64-bit DMA addressing
      i3c: mipi-i3c-hci: Add a quirk to clear the TX start threshold
      i3c: mipi-i3c-hci: Add support for the AST2700 I3C controller
      i3c: mipi-i3c-hci: Program AST2700 IBI termination threshold
      i3c: mipi-i3c-hci: Improve AST2700 PIO TX queue utilization
      i3c: mipi-i3c-hci: Support the AST2700 internal pull-ups

 .../bindings/i3c/aspeed,ast2700-i3c-hci.yaml       | 133 +++++++
 drivers/i3c/master/mipi-i3c-hci/Makefile           |   2 +-
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c           |  56 ++-
 drivers/i3c/master/mipi-i3c-hci/core.c             | 229 ++++++++++--
 drivers/i3c/master/mipi-i3c-hci/dat.h              |   5 +-
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c           |  63 +++-
 drivers/i3c/master/mipi-i3c-hci/ext_caps.c         |  15 +
 drivers/i3c/master/mipi-i3c-hci/ext_caps.h         |   1 +
 drivers/i3c/master/mipi-i3c-hci/hci.h              |   3 +
 drivers/i3c/master/mipi-i3c-hci/pio.c              | 122 ++-----
 drivers/i3c/master/mipi-i3c-hci/pio.h              | 109 ++++++
 drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.c    | 383 +++++++++++++++++++++
 drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h    | 191 ++++++++++
 13 files changed, 1167 insertions(+), 145 deletions(-)
---
base-commit: 97f3c8379f91af507cbc3d491b87633f0583febc
change-id: 20260714-b4-i3c-hci-ast2700-bad726e20c01

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


