Return-Path: <linux-aspeed+bounces-3655-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06825105F787
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Mar 2026 10:08:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXKv016nCz3cJk;
	Fri, 13 Mar 2026 21:08:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773396508;
	cv=none; b=OreYc8bx/FWd6zYHyJZQzRWCWVLVU1sL8z1ot3jdhxARlx3vsXmZjRlS1O6UAJ0KfV6v226lnG/i+dYkUy6KFHrZ+l428Rz85y+RE3RKyZHZglZecUcGSBK5PV8M5hSH+8riE2fBdziiIKwaJotMsPpi/x9f//5XxHcQmPmpHN4p9rjzFPkccylkWrqwaMFZ/y+AaNEkBB3caY6s2OJfFDHxXGXRsZU3mqLOPKJCtTcQ/FKnaX/XnhmahjAX669jfhUlfdXE+B+FQC7zs3lhFvlAKgC/NOMmPoJzmMUYRVE/OfgRkz7QxRHDY4VzYSahBr9yP+u64ASn3W0+YJOymg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773396508; c=relaxed/relaxed;
	bh=p/yfsVGqBSlh/KpcWWFFe7HwV9EjPFyV9HQe5IbEftw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=lcrKD9TFcYYDqgNboppdFaYdkeSw8XRITEnG7Rpz2TgidJnqiqSV9SQGbvqbI0OCkAfaKTXZCYUXd+AeBwXHRYNKC699Ilb/ZNh+C9KyW5niEYj+MnVVFastOGOQIy4DO7nyc/IxAEKYdHHTd0WlLj3/OwvDQM0FMVlkG/qxYNe0AYW0Lk2ueJtwrBxTJTbRd0EiNLErIp/5N91sHCJ9L7t0zhzM2+n/7UCmoLFvYrLMu9ANG6R63KdcH6dZFkaFvVYWiJ/9gc33AzrbYpTWvDUycg2rz/gZzYQXPyOQWSzRimm21EdWWhFYwt/ziFS2ZtabRnUd8IT4eHhZ+CjvYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXKty75DGz3cGf;
	Fri, 13 Mar 2026 21:08:26 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Mar
 2026 18:08:12 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Mar 2026 18:08:12 +0800
From: aspeedyh <yh_chung@aspeedtech.com>
Subject: [PATCH 0/7] soc: aspeed: Add AST2600 eSPI controller support
Date: Fri, 13 Mar 2026 18:07:35 +0800
Message-ID: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAOjhs2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Nj3dKC4pKi1MTc+NTigkzdFMu01EQzsxRDc3MjJaCegqLUtMwKsHn
 RsbW1AP7qydNfAAAA
X-Change-ID: 20260313-upstream_espi-d9fea66d1772
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <maciej.lawniczak@intel.com>, aspeedyh
	<yh_chung@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773396491; l=2464;
 i=yh_chung@aspeedtech.com; s=20260313; h=from:subject:message-id;
 bh=dv5zwPulTbWutjwEBbvd8aN2CQwO1vLki17npHgF3/4=;
 b=nUOuJPbhuALmHWWELdAretyV2JAWTCsPDyW/E3eLvLC97y+ASQ1g235rMs0BGU4fJxvyKdVgL
 cwCz7v+X4mJCXLF8vRruR+wjYb9b/KSTnmlsNy2EvAUjaSWkG6Uk8LW
X-Developer-Key: i=yh_chung@aspeedtech.com; a=ed25519;
 pk=o71dz0J8lpN+v0f3Mk4gT9PfVngADPC1Pex4aK6VigM=

This series adds initial support for the eSPI controller found on ASPEED
AST2600 BMC SoCs.

The series introduces a eSPI controller framework for ASPEED SoCs under
drivers/soc/aspeed/, adds AST2600-specific controller support for
peripheral and flash channels, defines the corresponding devicetree 
binding, and adds the AST2600 eSPI controller node to the SoC dtsi.

The driver is intended to support host-BMC communication over the BMC-side
eSPI slave controller present on AST2600 systems.

Patch summary:
1. dt-bindings: soc: aspeed: Add AST2600 eSPI controller
2. soc: aspeed: Introduce core eSPI controller support
3. soc: aspeed: Add AST2600 peripheral channel port I/O support
4. soc: aspeed: Add eSPI TAFS backend support
5. soc: aspeed: Add espi flash channel support
6. soc: aspeed: Add sysfs controls for flash LUN selection
7. arm: dts: aspeed: Add eSPI node for AST2600

This series has been tested on AST2600 platform with Intel's host eSPI
controller.

Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
---
aspeedyh (7):
      dt-bindings: soc: aspeed: Add AST2600 eSPI controller
      soc: aspeed: Introduce core eSPI controller support
      soc: aspeed: Add AST2600 peripheral channel port I/O support
      soc: aspeed: Add eSPI TAFS backend support
      soc: aspeed: Add eSPI flash channel support
      soc: aspeed: Add sysfs controls for flash backend selection
      arm: dts: aspeed: Add eSPI node for AST2600

 .../bindings/soc/aspeed/aspeed,ast2600-espi.yaml   |  74 +++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |  11 +
 drivers/soc/aspeed/Kconfig                         |   7 +
 drivers/soc/aspeed/Makefile                        |   1 +
 drivers/soc/aspeed/espi/Makefile                   |   1 +
 drivers/soc/aspeed/espi/aspeed-espi-comm.h         |  62 +++
 drivers/soc/aspeed/espi/aspeed-espi.c              | 618 +++++++++++++++++++++
 drivers/soc/aspeed/espi/aspeed-espi.h              |  63 +++
 drivers/soc/aspeed/espi/ast2600-espi.c             | 304 ++++++++++
 drivers/soc/aspeed/espi/ast2600-espi.h             | 302 ++++++++++
 drivers/soc/aspeed/espi/espi_storage.c             | 322 +++++++++++
 drivers/soc/aspeed/espi/espi_storage.h             |  32 ++
 12 files changed, 1797 insertions(+)
---
base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
change-id: 20260313-upstream_espi-d9fea66d1772

Best regards,
-- 
aspeedyh <yh_chung@aspeedtech.com>


