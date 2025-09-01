Return-Path: <linux-aspeed+bounces-2105-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A24CA0FFD
	for <linux-aspeed@archiver.kernel.org>; Mon,  1 Sep 2025 06:02:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cFdW65NYjz30MY;
	Mon,  1 Sep 2025 15:59:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756706386;
	cv=none; b=Z3uCOx73iBpdEU1JG5/eDL5dv3q+Rn+Bft+lneIq74E4rz/YpUdkaym8Fh+CV4BWlV0kr+kfOzl5qciA/XwJyukEYKleLooYc1f7qhaaIIJ54QRmi5tfdhnFWCIDuqFLZKwDBf/iC5gsOq5YJ350ion5VyM56CY/84l4uneUVr4smGb8CMACm3v/J9M6MJ1XByjDIsOOXzjZ6PiIArMDT6qVyk2E1MXo4Vz+qR7CkLIEHfzs/AP8ZfDDxsYVHKcCKDrctUWyJm2L9inqHxt1bSb0S2SQQO0LKCM1uSsx3dgkA8cgcmTFXSUSLa6XABKt+U8r6jAW4CbDX8pRC2lzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756706386; c=relaxed/relaxed;
	bh=SAz7rwvOgEDNc2OUzDXJfQ14R6W+UblCQ0lQjYE3OSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8fxhqDDq80GfPqIqLmU3WMRIWQZt6Sub+E8wI8YmevWWkAeiOk/UQ/VaTXK6bHOkMPTEEbSQshCU7V4TuJKRl747dRuKAq9Z/jVRwhJvNGgCnMWnjBSJyqi3ThWsqkCThGwXJ6DiBBEO3/W+bHMD9/YOHCT3DqPzoYsTCsIaBAmmxVP0BfPJsAh8rfAyIwSN3Fo7E3kCGcOfSeCgodrFx/2J2VfnkL2wqFxLrezAhu+KqebWUxWHhfSGhq/MyuaQLB1/wbQwa1EdckqLmkus1kg0HaJBOyVDWMocHaCJPctvjnRBNOUF/9ICNUtd4PcJypFqYrWOlo4lDf0QRlq1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cFdW61lKYz30Pg;
	Mon,  1 Sep 2025 15:59:46 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Sep
 2025 13:59:23 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Sep 2025 13:59:23 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <linus.walleij@linaro.org>, <p.zabel@pengutronix.de>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-phy@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH v3 10/10] MAINTAINERS: Add ASPEED PCIe RC driver
Date: Mon, 1 Sep 2025 13:59:22 +0800
Message-ID: <20250901055922.1553550-11-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
References: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
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
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcfbd11efef..178bfe82880d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3791,6 +3791,17 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/aspeed,video-engine.yaml
 F:	drivers/media/platform/aspeed/
 
+ASPEED PCIE CONTROLLER DRIVER
+M:	Jacky Chou <jacky_chou@aspeedtech.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
+F:	Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml
+F:	Documentation/devicetree/bindings/soc/aspeed/aspeed,ast2700-pcie-cfg.yaml
+F:	drivers/pci/controller/pcie-aspeed.c
+F:	drivers/phy/aspeed/pcie-phy-aspeed.c
+
 ASUS EC HARDWARE MONITOR DRIVER
 M:	Eugene Shalygin <eugene.shalygin@gmail.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.43.0


