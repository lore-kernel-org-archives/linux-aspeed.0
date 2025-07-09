Return-Path: <linux-aspeed+bounces-1678-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39393C83F1A
	for <linux-aspeed@archiver.kernel.org>; Sat, 12 Jul 2025 02:49:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bfCjH5Q53z2yRD;
	Sat, 12 Jul 2025 12:49:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752044912;
	cv=none; b=fkhFjWal/uFsuKzi26fUnMfeHQ5eLiYrSkCkxjo3krn2155b9AUob1z2NXyz42WsC86otI6XShdAAmxQ3hU2Qsx+TEA/04EVlPs+zzuJV3xQKNUsCr3iKhu4s7PaYqDLxAJbc/7/LgaBo5MnrQ/JFSgBou5JF2G9d8WsgR4tWxE2MkqhyKp3m64TFc8sdIkZjpNPZJHimvMTWgbPx+hQnBoypTE7ajxKN4RXk8ue4LszkqWaN5MJt0OOUOhin4XDqX1fn9TkBH/K1gCKfMHHXCD3C3RF2wLUAghsqmqgbUnRxd4TF6HGdRkDEUqi7PV2XoJDV5Q+1IDKrvQR6cxiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752044912; c=relaxed/relaxed;
	bh=L5aVq/3R+TO39VZnaYyNfuw2TEpvJHPkg6OoIlFOqNQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KoPF0sBDv99jZGRbthsDjp58COQ+Uaqa0JMV1M0hgF9nfygd00w+fohy8FHYa5f9UUqNiXbNrrXt+q6JXte2qvQfIS33IQSaCjEYPFly1ByMJDJ7dB4oz5swVystaArFeJAg9i1wH/kdgHR3DA4ejImetGbLpM5icMSrS3/YdCRTiCgtn9M/xXtgBm5+zletTYkS6B1+SERqUyCpLAseqGf8eVcimOdC/pppyJbVTG7ItES410bkNfgq0CR5iTI2UuHVnFlzhxCIdXJp7CnUleMJmSdjDJ2io4UDcP5fBsEvY6ouPI1b6lsVkOGG42x2QTblnsfq11y47KTiFua0FA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bcTbL3fLmz2xQ5
	for <linux-aspeed@lists.ozlabs.org>; Wed,  9 Jul 2025 17:08:27 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 9 Jul
 2025 15:08:09 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 9 Jul 2025 15:08:09 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
	<u.kleine-koenig@baylibre.com>, <hkallweit1@gmail.com>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next v4 0/4] net: ftgmac100: Add SoC reset support for RMII mode
Date: Wed, 9 Jul 2025 15:08:05 +0800
Message-ID: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
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

This patch series adds support for an optional reset line to the
ftgmac100 ethernet controller, as used on Aspeed SoCs. On these SoCs,
the internal MAC reset is not sufficient to reset the RMII interface.
By providing a SoC-level reset via the device tree "resets" property,
the driver can properly reset both the MAC and RMII logic, ensuring
correct operation in RMII mode.

The series includes:
- Device tree binding update to document the new "resets" property.
- Addition of MAC1/2/3/4 reset definitions for AST2600.
- Device tree changes for AST2600 to use the new reset properties.
- Driver changes to assert/deassert the reset line as needed.

This improves reliability and initialization of the MAC in RMII mode
on Aspeed platforms.

Jacky Chou (4):
  dt-bindings: net: ftgmac100: Add resets property
  dt-bindings: clock: ast2600: Add reset definitions for MAC1 and MAC2
  ARM: dts: aspeed-g6: Add resets property for MAC controllers
  net: ftgmac100: Add optional reset control for RMII mode on Aspeed
    SoCs

 .../bindings/net/faraday,ftgmac100.yaml       | 21 ++++++++++++---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  4 +++
 drivers/net/ethernet/faraday/ftgmac100.c      | 26 +++++++++++++++++++
 include/dt-bindings/clock/ast2600-clock.h     |  2 ++
 4 files changed, 50 insertions(+), 3 deletions(-)

---
v4:
  - Added more useful commit messages to faraday,ftgmac100.yaml.
v3:
  - Fixed allOf in faraday,ftgmac100.yaml.
v2:
  - Added restriction on resets property in faraday,ftgmac100.yaml.
---

-- 
2.34.1


