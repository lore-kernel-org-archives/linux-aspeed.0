Return-Path: <linux-aspeed+bounces-1710-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6CEC83F27
	for <linux-aspeed@archiver.kernel.org>; Tue, 15 Jul 2025 23:56:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhbg55KnWz3bn8;
	Wed, 16 Jul 2025 09:56:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752551029;
	cv=none; b=D3VqhexIi7bn1nwLWFlDxbQIJlHNay7C7zSvVG66aaUTQ73QupbBLRoOOeDmHWijMpzYp+sGyOnK7yyI9VbzeR/nyygMv9jpFtJoZbk0z+9JdHfJgSwMxVzRaKvRz0VnOm0oEsL3IDr8L9+93uGrzVv+ZD0wQFzhR1qMVRYCyam20m6XQxEPMl8yDjMD19NBHCevisKJme9VTRvzlXv7UMz+PjJO8Ef05VrBFMMiLzn+whNwnbiQMyQeU/am79xzmHEffwKCYuHv1KWixjaVb2f+1ulGlSIHw7onYJ/Aq8Rh7P4s/qDMlU4ZRU1Yui5dixAc1QbL9KFfeK8Wio7TcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752551029; c=relaxed/relaxed;
	bh=aMhHpk3FLl0dttTIgPrVeG6ZNiZ1kfm/TXpgwtc9uJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzLk15BZ0A94eH7+9dPs3TQgn1CpwmEySSELJ/FumfxcOWqnoHcTDG9gevTt0gvvnIRQ2m4YUKwBE3D4qotwGIpjGd0iLrPGjc63o3nfXJPAUo2OsVGAJ6uZBRmIHKRhnMvl02wOaNcmvuaSqm0nXvQ7rhszX1/9gAH6Iuu+KT+1iYKDn/MkxxMOpvBW8hNSZAclVJfhkIOYmzoSxlyj7BLjtqkBFpLIT+sG9B/+3um67olfSRXGKlaeiIf+M0JEtb08YLtPAsVIROPeAFbB7dKBxg9hP6RbHahyJ31Lw3H9f37gWtoqVtb8XZM+FDp4M3+Ddv+ranC+DRkg+pBgSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bh4mN5N4Qz3c8Y;
	Tue, 15 Jul 2025 13:43:48 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 15 Jul
 2025 11:43:21 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 15 Jul 2025 11:43:21 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-aspeed@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
	<linus.walleij@linaro.org>, <p.zabel@pengutronix.de>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v2 10/10] MAINTAINERS: Add ASPEED PCIe RC driver
Date: Tue, 15 Jul 2025 11:43:20 +0800
Message-ID: <20250715034320.2553837-11-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
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

Add maintainer for ASPEED PCIe RC driver.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ecb44458a7e..e1839dc240bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3696,6 +3696,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/aspeed,video-engine.yaml
 F:	drivers/media/platform/aspeed/
 
+ASPEED PCIE CONTROLLER DRIVER
+M:	Jacky Chou <jacky_chou@aspeedtech.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
+F:	Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-cfg.yaml
+F:	Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-phy.yaml
+F:	drivers/pci/controller/pcie-aspeed.c
+
 ASUS EC HARDWARE MONITOR DRIVER
 M:	Eugene Shalygin <eugene.shalygin@gmail.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.43.0


