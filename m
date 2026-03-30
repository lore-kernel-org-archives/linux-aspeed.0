Return-Path: <linux-aspeed+bounces-3797-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0560BFF4952
	for <linux-aspeed@archiver.kernel.org>; Mon, 30 Mar 2026 06:32:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkhHx4t8Sz2xpt;
	Mon, 30 Mar 2026 17:32:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774852349;
	cv=none; b=TvJIr5P2fqBaaO/G4xmLU6DD0UxMJ6UABAZ8oWsuNwBYKwKVJ2dlJRDVB8qPeEKThjJPnpcgmlWlcxIPazQ42aYdwS9QmXMVCbinI88oj9gebx4Ve4OZ7Pn2oy0gxetBLf6Sc6u+EKWtaMq5CBC1+WvF5vdM0uUtUmbKNV5VDavO9xiK5sgEYMttwpgIwcoX5JnKHxmcH1Lyn4qPxUhuxMnNGjHMSYPjOyKyo/+2szMbCeXxb/wzyIACs5qe/J87OxvMvhwxYk35sVW4NINiDtea6ltQbg62Mt1g2tWfLKK3ayHY+0+c+RGI7bqZSzaVQyqnPUt8XMcEbw1zOEbaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774852349; c=relaxed/relaxed;
	bh=OpCetiyBauYYAJ8SysJ96ijPY9Mk7kbQLyBHdlccLBI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=kkqTwEV2bAOePJWA+WGJc0dFbf7mO4pqGpIobgsc32ChlM1hxTEguG4x0x300xGS7MCSPgbqzsNH8mD2WLkMIrlSUFesKF/oA0V7uaZp/KdhyPGf2IuP30DjPV3KygjL+JE4Q7v8YuM6sXMeLzyVWDjWlJgMW7ctI52sCn3E/oc86TExrVQtirpLreqr+naq43Xuvav9j17DlD4iV71HgtcWuO2CPU+c8HDf4QDwS63E+xH8+M3atXiETL9BDIxs4ErAL1mJbfkX87b5+ACv1/L0S4uOqfGYDXHHeP+cSYWlxD2pLPMsT9VaKrnZ2C+levJSqdDhY8IcOKIWKxEtQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkhHw2Yfrz2xT6
	for <linux-aspeed@lists.ozlabs.org>; Mon, 30 Mar 2026 17:32:27 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 30 Mar
 2026 14:32:10 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 14:32:10 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v4 0/4] AST2700-A2 interrupt controller hierarchy and route
 support
Date: Mon, 30 Mar 2026 14:32:09 +0800
Message-ID: <20260330-irqchip-v4-0-3c0f1620cc06@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAOkYymkC/23MQQ6DIBCF4as0rEszgIJ21Xs0XSAOhUXVgiFtj
 HcvutHELt9kvn8iEYPHSK6niQRMPvq+y6M4n4hxunsi9W3ehAOXwKGkPryN8wNVqNEKqYoWa5K
 /h4DWf9bS/ZG383Hsw3cNJ7Zcj43EKNAGBAMEaaBSNx0HxHZE4y6mf5EllPiGBcgN84xtVTJuo
 G5Qir9Y7DDfYZGxkFKJ2pZKG3vA8zz/AChwD+EdAQAA
X-Change-ID: 20260205-irqchip-7eaef3674de9
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Paul Walmsley <pjw@kernel.org>,
	"Palmer Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"Alexandre Ghiti" <alex@ghiti.fr>, Thomas Gleixner <tglx@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774852330; l=5545;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=2YRtrcIEpOWrAdhNl8A+m416MZj9b+AOfhV4PMTCzGI=;
 b=leRN0msFH+xIpM4fUICSbtFYte3oLzDxzhAtPEcwoTq4GYx9ofeYmNq1hqsiK8ncZKawLKdXR
 PO4jDW9dHmlAR3HstgEdBKZWeixlFBiNRPhzwAzRydugWrpCWAniR8O
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The AST2700 SoC has undergone multiple silicon revisions (A0, A1, A2)
prior to mass production.

A0 laid the ground-work with a split controller design (INTC0 and
INTC1) used for early development and bring-up. The interrupt
architecture was substantially reworked in the A1 to introduce an
explicit routing model and clearer hierarchy, though the split
controllers remained. The A1 interrupt architecture is unchanged in A2.

A2 is the production design. A0 and A1 are pre-production silicon and
are no longer intended for deployment outside of ASPEED.

The existing binding and driver were written against A0 prior to the A1
rework. The A0 design directly wired INTC1 instances to INTC0, and
INTC0 to the GIC of the Primary Service Processor (PSP, a Cortex-A35).
The A0 binding and driver therefore do not account for the alternative
destinations of the Secondary and Tertiary Service Processors (SSP,
TSP) and BootMCU, or the necessary route selection logic present in the
production design.

With the above context, this series replaces the existing binding and
driver.

It is not necessary for projects to maintain support for A0 due to its
pre-production nature, and between Linux, U-Boot and Zephyr there are
no upstream devicetree users of the current binding.

The new binding uses localised interrupt numbers and models the
hardware connectivity between interrupt controllers using the
aspeed,interrupt-ranges property. It is introduced in a new file before
the existing binding is removed in order to keep the diff readable.

The INTC0 driver creates a hierarchical irqdomain under the selected
upstream interrupt controller and implements route resolution logic.
INTC1 driver instances defer route selection to INTC0 and expose a
linear interrupt namespace to their parent.

A brief history of related submissions
--------------------------------------

Some modifications to the existing binding were sent to the lists in
the past. Due to process choices the revisions were difficult to track.
They are listed below.

The approaches took several forms but ended in the minor adjustment in
v6 being applied. This enabled use of the A1 design but requires
assumptions about platform route configuration defined in firmware.
These assumptions are removed by this current series.

* [PATCH] dt-bindings: interrupt-controller: aspeed: Refine AST2700 binding description and example
  https://lore.kernel.org/all/20250714071753.2653620-1-ryan_chen@aspeedtech.com/

* [PATCH v2] dt-bindings: interrupt-controller: aspeed: Add parent node compatibles and refine documentation
  https://lore.kernel.org/all/20250715024258.2304665-1-ryan_chen@aspeedtech.com/

* [PATCH v3 0/2] irqchip: aspeed: Add AST2700 INTC debugfs support and yaml update
  https://lore.kernel.org/all/20250722095156.1672873-1-ryan_chen@aspeedtech.com/

* [PATCH v4 0/2] irqchip/ast2700-intc: Add AST2700 INTC debugfs support and yaml update
  https://lore.kernel.org/all/20250812100830.145578-1-ryan_chen@aspeedtech.com/

* [PATCH v5 0/3] AST2700 interrupt controller hierarchy support
  https://lore.kernel.org/all/20251022065507.1152071-1-ryan_chen@aspeedtech.com/

* [PATCH v6 0/1] Update correct AST2700 interrupt controller binding
  https://lore.kernel.org/all/20251030060155.2342604-1-ryan_chen@aspeedtech.com/

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v4:
- 3/4 fix warning: the frame size of 1296 bytes is larger than 1280 bytes
- Link to v3: https://lore.kernel.org/r/20260326-irqchip-v3-0-366739f57acf@aspeedtech.com

Changes in v3:
- 1/4 Squash patch 5/5 and 1/5.
- 1/4 modify wrap lines at 80 char.
- 1/4 modify maintainers name and email.
- 1/4 modify typo Sevice-> Service
- Link to v2: https://lore.kernel.org/r/20260306-irqchip-v2-0-f8512c09be63@aspeedtech.com

Changes in v2:
- Change suject to "AST2700-A2 interrupt controller hierarchy and route
  support".
- Describe timeline for (pre-)production design evolution and
  binding development to support the break in compatibility.
- fix "make dt_binding_check" compatible string consistance with
  example.
- Split KUnit coverage out of the main driver patch.
- Link to v1: https://lore.kernel.org/r/20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com

---
Ryan Chen (4):
      dt-bindings: interrupt-controller: Describe AST2700-A2 hardware instead of A0
      irqchip/ast2700-intc: Add AST2700-A2 support
      irqchip/ast2700-intc: Add KUnit tests for route resolution
      irqchip/aspeed-intc: Remove AST2700-A0 support

 .../interrupt-controller/aspeed,ast2700-intc.yaml  |  90 ----
 .../aspeed,ast2700-interrupt.yaml                  | 188 +++++++
 drivers/irqchip/.kunitconfig                       |   5 +
 drivers/irqchip/Kconfig                            |  23 +
 drivers/irqchip/Makefile                           |   3 +-
 drivers/irqchip/irq-aspeed-intc.c                  | 139 -----
 drivers/irqchip/irq-ast2700-intc0-test.c           | 473 +++++++++++++++++
 drivers/irqchip/irq-ast2700-intc0.c                | 584 +++++++++++++++++++++
 drivers/irqchip/irq-ast2700-intc1.c                | 282 ++++++++++
 drivers/irqchip/irq-ast2700.c                      | 106 ++++
 drivers/irqchip/irq-ast2700.h                      |  47 ++
 11 files changed, 1710 insertions(+), 230 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260205-irqchip-7eaef3674de9

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>


