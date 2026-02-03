Return-Path: <linux-aspeed+bounces-3467-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1180E8304A
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Feb 2026 03:55:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4qQ66yyRz30FD;
	Tue, 03 Feb 2026 14:55:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770090926;
	cv=none; b=Ha894SMzX3QwVLiy2N3TAro/4KrSWrpmoS+TEZy0VDgJVDorSlka+GcCxH9brHz4V1ASkH53XBySSVaTf9zOgb8i0mw1B5f2ddP4wsIhT1fF5klTsoX11WnxPQgUDxKgqEwhFmsn4BC8PCbN+83lNxKSAs+y30Gn3R6jtJb/zjD5ieXhtAltX4T1mvi7BDnlyH44mOeoOUdPVbstJRHq8ESy3uJo53bVpjqDWtyx40zc1Ztq//DK3NpNNCwxErYH29QAzb6BRFWEmO5XPz0cAYzSxNznVtZYtrcm55rafPWkga+IKjldcoco6+naYDolBadznS3syPHqOwsYyuXnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770090926; c=relaxed/relaxed;
	bh=Y4s+INty3nLSWeCUHgwjXD0p8aoK4dYIUQrkUXCb3Rc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=MhX+wzcstYvjX94XmQg5V3ejK552EUizxkLyAkSLkJZ39vHLYGELndPCLzLnTGPTvbJlfLU3tYJ7KUNHq7LIl9jeALsBcP+fCITFPoInmvWkSFxoY9gxQVebXlmTGhYMsKLqA33YJbnZwfenALM5ghJdnsgB3EPEcQrSTnCwOXRHszjveHPUcJWuGoUnset9uW8ACjZORdVegJOw+qr61NKDdldGV9x7ZIUnG2VNDqfwFIwAObLF/NB06Tgq2QaRughTNTDSpxdc8Q2KdWo70Uk4CjNnbxPrOn3DAIHKOvHXZ3qoogrzlSE6ReSDeR2LcQOrWh9dmZO3EwdMr689ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4qQ56tGdz309y
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Feb 2026 14:55:25 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 11:55:11 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 11:55:11 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
Subject: [PATCH 0/2] Add Aspeed G7 uart routing support
Date: Tue, 3 Feb 2026 11:55:07 +0800
Message-ID: <20260203-upstream_uart_routing-v1-0-6bd5dd75ee3b@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAJtxgWkC/x3MQQqAIBBA0avErBMcg4iuEhFaU80ii1EjkO6et
 HyL/zMEEqYAfZVB6ObApy/AuoJ5t34jxUsxGG1ajY1W6QpRyB5TshInOVNkvylsOuPQELrVQWk
 voZWf/zuM7/sBs5ewumcAAAA=
X-Change-ID: 20260130-upstream_uart_routing-1382b12e1bfb
To: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Oskar
 Senft" <osk@google.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Jammy Huang
	<jammy_huang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770090911; l=749;
 i=jammy_huang@aspeedtech.com; s=20251124; h=from:subject:message-id;
 bh=Yzxwwk1xNKZ8HQZTWD2jwu0MOFqIwNni2cmuV4TlO4E=;
 b=K4n9YOmkhu1fc21VIW0clRnhxsgFIt8wkaEXaoEFJCI1wcsRpPKCCrKPGFeenj1u4YQlTicXc
 E0/YRaMtDptBHLz6qMbzKsaVwZeXOhLmiXAj5vy1rmF3hVCs1TnLnYt
X-Developer-Key: i=jammy_huang@aspeedtech.com; a=ed25519;
 pk=E5YwijeJZZcuDR6srvwNlXrNHvLxwipUg3Mb/xxUF9o=

The Aspeed 7th generation SoC supports dual node. Which means there are
2 group of uart routing.
 * 0: uart0/1/2/3/9
 * 1: uart5/6/7/8/10

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
Chia-Wei Wang (1):
      soc: aspeed: uart-routing: Add AST27xx dual node support

Jammy Huang (1):
      dt-bindings: soc: aspeed: add aspeed,ast2700nx-uart-routing compatible

 .../bindings/soc/aspeed/uart-routing.yaml          |   2 +
 drivers/soc/aspeed/aspeed-uart-routing.c           | 424 +++++++++++++++++++++
 2 files changed, 426 insertions(+)
---
base-commit: 4d310797262f0ddf129e76c2aad2b950adaf1fda
change-id: 20260130-upstream_uart_routing-1382b12e1bfb

Best regards,
-- 
Jammy Huang <jammy_huang@aspeedtech.com>


