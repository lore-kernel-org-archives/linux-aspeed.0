Return-Path: <linux-aspeed+bounces-3468-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3100EE8304B
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Feb 2026 03:55:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4qQ74kFhz30Lw;
	Tue, 03 Feb 2026 14:55:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770090927;
	cv=none; b=fOPcBbKkGKcsulnFbjSFk0dxhPbce2eSqzMaK5JoNVs04+hcaSFjs1AlDKT2abasS0tBheyNeJRoCzY2H+BKx9bdW1NOCokF1x4holDHT0l3Fm7BjAtUZBI5dF2UJDL6j1JSysjBGkhToZTSymQzziItOGSz4iP8iDwth0EoDPDtMXSR5pMI0wudbrgpQ4j1FHIUy/oX2NGGf7SRPuA9OiNayN1i+FKpfXRx3zJ5mulpCZTmFQPMQ5L7CZ4yw/ID6x4foP8DXdXOB51vTkhF92PT/40Gs7P1mxEFoVQU3LdUlAYaqL2s/RVNDQoWdfBcnRjRhVR2tXHs6S5ytsAigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770090927; c=relaxed/relaxed;
	bh=C+RZfcth7vxLk3F23wpG7lF8kLp7QMay9kzSlavNfkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KD+9GOnBgx+7LjYhPgrRtGxw/MI8XHvKwLtxwIa77MdPUODBd0FozZ5LXJ6q88Dy4febHvqj7L4bjiFCS4V3Cppx4zec3TqTTwV5tNcZI7jXKO5wuAOSBCaiUgjboNmuNKbtgrohpRcjanfCdRb/xVi3aGDa/ASVQ+zQPYH+a8Qux93q7bMlQK3iSJqY/8nmbCCtS8A1hIAAZc3w0wTaVSNwHdMii6H7YojHm47Wz0xsWEMZyA7O5FXfNogGTu0O+uoZDK4+sCYv5vNoDvY4OD2AI3oRxWTFpybTB82wm1QpddoKOqniFk8IMCQCcgfwW9v4G8bshn/RQYuu5vmTZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4qQ70fN6z309y
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Feb 2026 14:55:27 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 11:55:11 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 11:55:11 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Tue, 3 Feb 2026 11:55:08 +0800
Subject: [PATCH 1/2] dt-bindings: soc: aspeed: add
 aspeed,ast2700nx-uart-routing compatible
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
Message-ID: <20260203-upstream_uart_routing-v1-1-6bd5dd75ee3b@aspeedtech.com>
References: <20260203-upstream_uart_routing-v1-0-6bd5dd75ee3b@aspeedtech.com>
In-Reply-To: <20260203-upstream_uart_routing-v1-0-6bd5dd75ee3b@aspeedtech.com>
To: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Oskar
 Senft" <osk@google.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Jammy Huang
	<jammy_huang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770090911; l=916;
 i=jammy_huang@aspeedtech.com; s=20251124; h=from:subject:message-id;
 bh=29cX7wLiEvG4nuiYCRISWCJL6gqUkOol7p8pKkxhJmA=;
 b=kQhySbgAx4A+uRYNmsCnwp3PcP3dXS7qxsxh6Qqka3k3mWwmHYWC/IpgObc7AOFm3/U0tvPlX
 RJhzRbIuEKfBnKcurBxw1SQa5FhMJi4+ttxz8LRdv+YdDm70/HFyxge
X-Developer-Key: i=jammy_huang@aspeedtech.com; a=ed25519;
 pk=E5YwijeJZZcuDR6srvwNlXrNHvLxwipUg3Mb/xxUF9o=

Add aspeed,ast2700n0-uart-routing and aspeed,ast2700n1-uart-routing
dedicated compatible for representing the Aspeed 7th generation.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml b/Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
index 51aaf34acb..6e0d63ca8b 100644
--- a/Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
+++ b/Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
@@ -31,6 +31,8 @@ properties:
           - aspeed,ast2400-uart-routing
           - aspeed,ast2500-uart-routing
           - aspeed,ast2600-uart-routing
+          - aspeed,ast2700n0-uart-routing
+          - aspeed,ast2700n1-uart-routing
   reg:
     maxItems: 1
 

-- 
2.34.1


