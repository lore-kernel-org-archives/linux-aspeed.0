Return-Path: <linux-aspeed+bounces-1023-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A13C35FFC
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 23:01:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGr7H6WK7z2yqF;
	Tue, 18 Mar 2025 10:01:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742180383;
	cv=none; b=MtgiPQtdL9NJfpC8JfOk8zzPm7c+NZrz+FJfJPqtaEByfrKiSbOS0YB7JuCZNAFdIqRlezqQ7qKhFk/enkhDymUWymUmj1RUM3oiJxeev4uHfRGesOZO2FoyHrV27+UjJDq+Glg6+vQGNUDCPbHNyUvLnm6N5jGzJS2WZI9pX3fSWEZHJ/YDKNNzqKpUZcYAGVtDsSFVC6XcWtqJDjw5hUOYy9WWnhJtZSY5zXVD4YVuT1MkrSDgNF3F89LVhwchuCNQqMNSPHpvaxhUQXTTKYoz5PRVZZ7SEd/dk6MRm7/9QgJ48krQEAONBdx2HEvRLeNk1X6s1PRdCH+LDKqCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742180383; c=relaxed/relaxed;
	bh=JrPG3yRXJLnLTaeCCT8HAn+1KswtQvNPBpLJfHiZXPY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iz9aERcqOJtO5OeaYAKxrZ7y8MWTZZNtwVWM4B3Tj54MIoHuxY1lVctuqJ1KjCT3BvkldkDRHTtkhs0rV/70QHZSRDLr51Zpy/1qKmlLeBjv0cI8oelKupVTYlfm8IqK22GKLmt1USTeGiCXimvpw4akMwF/d7BMfcM4A5qXnzo3sAQQ6Z1h1b1+oCMXjTeH63vMC0yB08T7g3RAHXiGnhWQ90ynh9D/4v1Dqx5cJmoT9HyvlFuuRGF6KDCMSrY18vV47vR9EI9wB2zNXqnE3/hdGhR0pNAzzfHhh6W5oKU7kKDl1c3OF+ExrdPOQ0p4+3qFCPsI2yT/ArVQG28avQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGKSt6YhLz2yGM
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Mar 2025 13:59:39 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 17 Mar
 2025 10:59:22 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 17 Mar 2025 10:59:22 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <ratbert@faraday-tech.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next 0/4] Add AST2600 RGMII delay into ftgmac100
Date: Mon, 17 Mar 2025 10:59:18 +0800
Message-ID: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In AST2600, the RGMII delay is configured in SCU.
Add the properties according ethernet-controller.yaml into AST2600 dts
and dtsi, and add these in the ftgmac100 driver and yaml to configure and
describe how to use.
Now, just support for AST2600 and the other platforms will be ignored
the RGMII delay setting according to compatible.

Jacky Chou (4):
  ARM: dts: aspeed-g6:add scu to mac for RGMII delay
  ARM: dts: ast2600-evb: add default RGMII delay
  dt-bindings: net: ftgmac100: add rgmii delay properties
  net: ftgmac100: add RGMII delay for AST2600

 .../bindings/net/faraday,ftgmac100.yaml       | 16 +++-
 .../boot/dts/aspeed/aspeed-ast2600-evb.dts    | 12 +++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  4 +
 drivers/net/ethernet/faraday/ftgmac100.c      | 88 +++++++++++++++++++
 drivers/net/ethernet/faraday/ftgmac100.h      | 12 +++
 5 files changed, 131 insertions(+), 1 deletion(-)

-- 
2.34.1


