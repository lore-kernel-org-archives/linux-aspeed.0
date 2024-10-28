Return-Path: <linux-aspeed+bounces-38-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D21D13590
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Oct 2024 02:48:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XcHrd4CrCz2xJy;
	Mon, 28 Oct 2024 13:48:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730083713;
	cv=none; b=DLCAwTa6bSPs9DULp/d9Ko+REwfJlxM3chh8MPMW09OWGWy8G7dRilVN5OJIGLhpnyYVLfulI/D2HnDUTdwf0gU+f2hTy0SzFjZFS47nt+fNjBXD6W2/4ZiiHaFbKTca44FkFIHXJ20b/BFuwIn+VkPetLgVg82WgBed6u8astVA0BQ9ViZEQfTbir+MoOzfNAuZIULKmeExZXX+m9tX1V0PYZEDnnolwayoZ6UihHL62umoWtKSyOXmFxJ9ZV5Tg6IEe+Icxim3PQLxlwvZj32/OK8xs+gofr3Ae8xTfeiZMvaYK53xIsSY2FMsnxpC3SlE/ohBnRwlGVNyamlvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730083713; c=relaxed/relaxed;
	bh=+qnT/VJPfq/wikjmpBAQism7qboXf+iSdeubgEuKVlc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8HxSw1IlSve4f5HKjEE0uXKxeER1b1nP2Srxo7v9CV1XIoBFOqhCyEYzrbpl1zhfrfBRcOIUzh6nCsvNHrSTV0HsCYO3EmWLFkLDQq7tuuoqQqlJQ4VW1J0rI4z5ny4KJxsrKhAhb+M6woLWndJF+E38C33iVJTA+eIgnxctUdX/Us4TBkqLtbzB/4FbHrLF6Ro0iX7FPl5NfpZqozxiedbcO4X3cP0185z65dqRsiDSgtifGpQ7VHS4Eg+ISjSBlq7G62NL/Z4l8ijwAIAMYglVEF0sjzhX1I06hN6yTDv09b9tgRhyGoQ3ELQ+F1KYqTqT8ZKEOQVrNMjj+ynnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XcHrc6YhPz2xG5
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Oct 2024 13:48:32 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 28 Oct
 2024 10:48:13 +0800
Received: from aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 28 Oct 2024 10:48:13 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <patrick@stwcx.xyz>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<wim@linux-watchdog.org>, <linux@roeck-us.net>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
CC: <Peter.Yin@quantatw.com>, <Patrick_NC_Lin@wiwynn.com>,
	<Bonnie_Lo@wiwynn.com>, <DELPHINE_CHIU@wiwynn.com>, <bmc-sw@aspeedtech.com>,
	<chnguyen@amperecomputing.com>
Subject: [PATCH v2 1/3] ARM: dts: aspeed: Add WDT controller into alias field
Date: Mon, 28 Oct 2024 10:48:11 +0800
Message-ID: <20241028024813.2416962-2-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028024813.2416962-1-chin-ting_kuo@aspeedtech.com>
References: <20241028024813.2416962-1-chin-ting_kuo@aspeedtech.com>
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

Add WDT controller into alias field. After that, WDT index,
used to distinguish different WDT controllers in the driver,
can be gotten by using of_alias_get_id dts API.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 2 ++
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 3 +++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
index 78c967812492..d8b4136d0ca0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
@@ -29,6 +29,8 @@ aliases {
 		serial3 = &uart4;
 		serial4 = &uart5;
 		serial5 = &vuart;
+		watchdog0 = &wdt1;
+		watchdog1 = &wdt2;
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 57a699a7c149..4dd220bca617 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -30,6 +30,9 @@ aliases {
 		serial3 = &uart4;
 		serial4 = &uart5;
 		serial5 = &vuart;
+		watchdog0 = &wdt1;
+		watchdog1 = &wdt2;
+		watchdog2 = &wdt3;
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..c0a47c795fff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -40,6 +40,10 @@ aliases {
 		mdio1 = &mdio1;
 		mdio2 = &mdio2;
 		mdio3 = &mdio3;
+		watchdog0 = &wdt1;
+		watchdog1 = &wdt2;
+		watchdog2 = &wdt3;
+		watchdog3 = &wdt4;
 	};
 
 
-- 
2.34.1


