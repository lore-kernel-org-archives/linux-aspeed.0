Return-Path: <linux-aspeed+bounces-4261-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC35CD98D2
	for <linux-aspeed@archiver.kernel.org>; Tue, 16 Jun 2026 03:30:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfXYp565Sz2yrX;
	Tue, 16 Jun 2026 13:30:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781580622;
	cv=none; b=g3cmE6yUgMMJC/iWB9V/geQNGnXp5YSy0S5Oikd/bdotBoJz/a/2JCzucOSQaMrmuacimInPsMV0PL7+Q/H1FQy+NHLyuXssPqn7XRLAv1kORXlniuP4g9ed8tRk7+jRnqA8KmcT2oYD6qyuPX2xO2/9Ut5hKTEt8uVEKwOfmpPjBRyidVvFObYxzhFZgAq2tH+gxdzhQ2UzGQG9T9INx8i2+pr7c7/w9J9wOfkbBydqT0nYIKihdkJ5P0J5PTC2l5VDbdgvWGbHA7fglMvSrWXsY7ooik04Jb8GedXfF8+mB+h6kRlIaX8eNF05TjrfC7XHMlqGh+l+wPO3Tvy4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781580622; c=relaxed/relaxed;
	bh=OoA5fcjHiDIQMSYoJiUkvrtob6g82mV1RciuPYwaVxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BBjqZKiCDsAXItxSR67xC2qVZT9BofvIsGzTJnBEwhF6vvrjunFqKHAkch8mH6CwEyJZEuiITu4hcxG3AtffXwm66RjQ4etw+T+kTn1kxFFCmp3yBGyZD/2cIzsmbJy4SFMYPvTluqBbojrulScCDTgM6kUfWcHCHRTpPa3ZisFJpcos0exKDReVh9690IZsZz80R55Qn7F6i7T2EdYNIAP/SWjwEhQgcqfHTmoADkeXExMCndJaQzhBJWfnMvGOfPIWJUKdLhbSnFN3pHImoAORfMe7xad35mC9Psgftr6oaRosUycl09goawp+uOH65TTS+XQQpHfAaOmNb4Jgzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfXYn6MScz3bwX;
	Tue, 16 Jun 2026 13:30:21 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 16 Jun
 2026 11:30:02 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 16 Jun 2026 11:30:02 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 16 Jun 2026 11:30:02 +0800
Subject: [PATCH 2/2] pinctrl: aspeed: Split TRST out of the AST2700 SoC1
 JTAGM1 group
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
Message-ID: <20260616-pinctrl-fix-v1-2-621036e45c7c@aspeedtech.com>
References: <20260616-pinctrl-fix-v1-0-621036e45c7c@aspeedtech.com>
In-Reply-To: <20260616-pinctrl-fix-v1-0-621036e45c7c@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Linus Walleij
	<linusw@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>
CC: <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Billy Tsai" <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781580602; l=1914;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=3g5Xwg8h1zZKhm3yigBW7k/XgEh1YvhsBXpVJn3jjYc=;
 b=8/rgiPAyR99n1WV2vAnALgdaOrGtS/4Pyejknog3mNZ6wbRX5G6acnNUpKvpkyOieYdOYck9k
 mkV47AQIGOhCU3adl3tEKUMaH7IRepbeciaAkhCja6uYFwxUU0eA1qV
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The JTAGM1 group includes the D12 ball carrying the TRST signal, but
TRST is optional for a JTAG master and the ball may be needed for other
functions on designs that do not wire it. With TRST embedded in the
group, such designs cannot use the JTAG master at all.

Move D12 into a new JTAGM1TRST group under the same JTAGM1 function so
TRST is muxed only when a board requests it. Boards that do use TRST
now need to select both the JTAGM1 and JTAGM1TRST groups.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g7-soc1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g7-soc1.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g7-soc1.c
index 50027d69c342..f8b4066699ce 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g7-soc1.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g7-soc1.c
@@ -1018,7 +1018,8 @@ PIN_GROUP(I3C6, AA22, AB20);
 PIN_GROUP(I3C7, AF18, AE19);
 PIN_GROUP(I3C8, AD20, AC20);
 PIN_GROUP(I3C9, AA21, AB21);
-PIN_GROUP(JTAGM1, D12, F10, E11, F11, F13);
+PIN_GROUP(JTAGM1, F10, E11, F11, F13);
+PIN_GROUP(JTAGM1TRST, D12);
 PIN_GROUP(LPC0, AF26, AF25, B16, D14, B15, B14, C17, B13, E14, C15);
 PIN_GROUP(LPC1, C16, C14, C11, D9, F14, D10, C12, C13, AE16, AE17);
 PIN_GROUP(LTPI, U25, U26, Y26, AA24);
@@ -1263,6 +1264,7 @@ static const struct pingroup aspeed_g7_soc1_groups[] = {
 	GROUP(I3C8),
 	GROUP(I3C9),
 	GROUP(JTAGM1),
+	GROUP(JTAGM1TRST),
 	GROUP(LPC0),
 	GROUP(LPC1),
 	GROUP(LTPI),
@@ -1528,7 +1530,7 @@ static const struct aspeed_g7_soc1_function aspeed_g7_soc1_functions[] = {
 	FUNC(I3C7, (1), "I3C7"),
 	FUNC(I3C8, (1), "I3C8"),
 	FUNC(I3C9, (1), "I3C9"),
-	FUNC(JTAGM1, (1), "JTAGM1"),
+	FUNC(JTAGM1, (1, 1), "JTAGM1", "JTAGM1TRST"),
 	FUNC(LPC0, (2), "LPC0"),
 	FUNC(LPC1, (2), "LPC1"),
 	FUNC(LTPI, (2), "LTPI"),

-- 
2.34.1


