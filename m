Return-Path: <linux-aspeed+bounces-2712-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36DBCCFA06
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Nov 2025 07:39:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0NlW2DQqz3bd8;
	Mon,  3 Nov 2025 18:39:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762155591;
	cv=none; b=HnIg3P1NWlhrouefopA/cU0TPj+NE4Rdbu37tUvskgmtPf9JxTpRXbQja9j7lBtNCp5AzA4U6f1up/QfhHCEh4CgzfLLgmj1pi7G7kKFR/zRvKjL46r5LcJpje2H/MVv+NYfSIQbkqyKv4iAjl9AmVVO2N35Dns5jYW+IcI0njlAY2qPBnu2nyC/53MPMSGEGmhhgZPOqdq7Iu8OYDbA26YOU+1Os2Qov/nkJ+ozN4x1Ya5uIZcDVAdjzDWXXpoUz0cSfEneMymfcNp1CGrxCjP4mFWg11ow4l/iPTKfPjsVMfF7LONtN4ejW5SRBEYBbISuNc1osgA+mf96U7IgvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762155591; c=relaxed/relaxed;
	bh=wp2WDiudwvT5ki5hoQN+cr7FSLljgCWFchp5K+G54v8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=To/yL1lbz8FnL+XFpd8C3GZDqTqfaNHxxfV4+HoBFvyMm8XLIEYuAKPPDnNPnn4xBzivg+GLXdFNx2uKEL+6cdb45mBOfpczVOFR+eHo1u+8hcQqNMycig9oORzfJszybbmdwHcO/PddUuIFW5yy6zqupcbZu0zza8IzQ4QRiEbKe8y9zujOdFwGOg9BHvQnibAFWRT0r1bRGQ2fawwJ5sw1yKnqPBqb1GNa/ZpfNMgDRghpSu9sw0hjmYnmRsu1+8jcMcawZ5sp5iVZoppmmVDZSR6JFWOclnaF/q6gpO3honNlMJ9Z8mc+SzPYL6sVQWpVDbzdSlFcCWBmPpj0Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0NlV5ntmz30RN
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Nov 2025 18:39:50 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 15:39:31 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 15:39:31 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 3 Nov 2025 15:39:17 +0800
Subject: [PATCH net-next v3 2/4] ARM: dts: aspeed-g6: Add ethernet alise
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
Message-ID: <20251103-rgmii_delay_2600-v3-2-e2af2656f7d7@aspeedtech.com>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
In-Reply-To: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762155571; l=772;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=K+lA41x5DitnWJV0QR7dvh8A8xDGnA4qbW5y81EFvPQ=;
 b=m0RI1d6GHfXKir20yR72B2X9RyMjrez/e3doka6ugD+gQWdxw80MR8blx4QzFEmNQW9/N0TWW
 R0Jj8dSlViACFq6BGfKQuE5EpDnPtyRwDP2jylOoeHMtZgiqa1wEA9b
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

For RGMII delay configuration, MAC0 and MAC1 use register SCU0x340,
while MAC2 and MAC3 use SCU0x350.
The Ethernet aliases are added to help identify the corresponding
MAC index.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index f8662c8ac089..03ad566a4ce8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -40,6 +40,10 @@ aliases {
 		mdio1 = &mdio1;
 		mdio2 = &mdio2;
 		mdio3 = &mdio3;
+		ethernet0 = &mac0;
+		ethernet1 = &mac1;
+		ethernet2 = &mac2;
+		ethernet3 = &mac3;
 	};
 
 

-- 
2.34.1


