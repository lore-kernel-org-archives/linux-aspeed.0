Return-Path: <linux-aspeed+bounces-5103-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E07CA5FA5
	for <linux-aspeed@archiver.kernel.org>; Thu,  1 Oct 2026 09:50:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwRxY3T3hz30FB;
	Thu, 01 Oct 2026 19:50:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790848257;
	cv=none; b=MbuLUsz3LKXUICw9jyefnya3Ke8fPL+wEzzWROzF70FGQqIKq3Obhi+4d669Prwzt5WEJ0pXAyg0sJSx0K64WIZL9H5q+Ds36yaWJPoa0VnfEnrkXkV/XvaJg4SZ47w/V+hQGFj6iw4qRSc6oGOopOXjyz8OoNSNnYCdKcDBPMhwKRawoZYIevEOT/0yNTkPT5HBlJLWfeaT53xoq44CnbCQ9rbXirolPsPu+VN0+XoIXOhuSLBtvoz55WVSXQrLUIAGkJ5htPN52JlbGiEXuciRVHUwuyHuyJL8gso7zNgO8iLyljAfH5e7RrOKu42ssPELQlfMrFmdwh1n9YyEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790848257; c=relaxed/relaxed;
	bh=baABEeaxcYdQ8TlWwTQRHr3sE/GZyDzYF/X+s2D1Klk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TfwJ2jIFLrGYC8IPbMBJ5aNJghH9vmCOrvSJi0KkV5Hepu3poWQuVHMeEweCYJSyc5D35BVaKQ01kQ6UoARCAsjKBZe3UhCZxC4NJ446WVwWeKqKOtX8eVbYtX5ErBhNWB2ammKLCP725CpxnT+3iYmgcGWsAfEsRm12nqLlaZ2YU5xBsXDsgf/CgR6ymVulyRcGB6w9Rc8zlrUwKuhb17/7pZ+vPT5eHFGMFZygnzyNHtwn9hLSKU0miImvjMCYJ2vKdVkLLYnbUdvCHSiVoxBC2R5hAcYtgTinpUxaY0yZB1X71xg6domYbdMAxG/kr2IwO6e8t4jdN3X0fssxBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwRxX5MYjz2y2Z
	for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Oct 2026 19:50:56 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 1 Oct
 2026 17:50:36 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 1 Oct 2026 17:50:36 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 1 Oct 2026 17:50:38 +0800
Subject: [PATCH v2 3/3] arm64: dts: aspeed: Add syscon phandle to AST2700
 ADC nodes
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
Message-ID: <20261001-ast27xx-adc-upstream-v2-3-2f9c15cc0064@aspeedtech.com>
References: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
In-Reply-To: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Ryan Chen" <ryan_chen@aspeedtech.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>,
	Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790848236; l=1214;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=2QkJzNzBC5TteyA4kAerBTf8TT9nUDrvrpbSjV4H9a0=;
 b=yiizZMGtjvqkSIgdptP/Ct9Hes4UXKOm05/DB4hUFN/XzSN5u4DOmmzjaq4YCWFo2f5PK58zI
 MUMjI+nnSspDYdYKtnBV4tH0blekWXA+nQLg6ZQTR/spz6z0d6BclXu
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Point the ADC nodes at their own syscon1 so the driver can correctly
locate the reference-voltage trimming data on AST2700, where syscon0
and syscon1 share the same device-tree node name and would otherwise
resolve to the wrong SCU.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Assisted-by: Claude:claude-sonnet-5
---
 arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
index bc990f79e693..053673cc4b8e 100644
--- a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
@@ -246,6 +246,7 @@ adc0: adc@14c00000 {
 		clocks = <&syscon1 SCU1_CLK_AHB>;
 		resets = <&syscon1 SCU1_RESET_ADC>;
 		interrupts-extended = <&intc1 80>;
+		aspeed,trim-syscon = <&syscon1>;
 		#io-channel-cells = <1>;
 		status = "disabled";
 	};
@@ -256,6 +257,7 @@ adc1: adc@14c00100 {
 		clocks = <&syscon1 SCU1_CLK_AHB>;
 		resets = <&syscon1 SCU1_RESET_ADC>;
 		interrupts-extended = <&intc1 80>;
+		aspeed,trim-syscon = <&syscon1>;
 		#io-channel-cells = <1>;
 		status = "disabled";
 	};

-- 
2.34.1


