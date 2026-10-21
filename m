Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A3606A31E
	for <linux-aspeed@archiver.kernel.org>; Wed, 21 Oct 2026 02:10:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8XmV2Dyyz2xcB;
	Wed, 21 Oct 2026 13:10:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792548602;
	cv=none; b=PbUpIvRET5GQvnOhXAjA+n2jI2vqG/ejHoIqZklmm68AFDEUJXkApw7EeXAFKYm3uE002SKQT6UOpNQfmid99+Ktmsdt1/UvakC5kbrbjQJsDfbyvnsujLLZ5OMOSApWBxL6g1eH4ic2g+Vk598bHbtftITFO8aQCwlGIFlGXXAvvPEx91iTYrmqb3x6316/hd5kefkoWhdB6Hd2Ap1X4235ee28LuxE47bHq0EChHroPjih8Leo6XMUGP0XepOePiD3T7TiR6eLIVoJi4sc9EAJ8WFs6qQ/u7IjzNziouEKwYMsehXIpzyxmeRs0AB7L+k516UAtqlxFug4e0zY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792548602; c=relaxed/relaxed;
	bh=zTvHoWVK2MnY6BXYoqcKq7jXZ7I8mh27KAsKSWJ+yVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=KCcjY16zhXS23AC3HiempzKVHpRbwhGkU6GHGm3x/8lqxtKobocNPcDHVwdzTmIeseTQORVU014J8/c6C3s435pf6PQpkBuCExDNcGrRQh8jNYGnIOTrvgcVrgzK/Nzj9PBQqDnupW1deKFGkz/YTtsB65vFZ0qgQZ6cQXQ5YOGNGRL39HMUHejm16JEb03LY2A7vhPE8gZdN0rzuxps2N5uoozkzrencJEJQPJx1AQPtdnfjDMSSQtqCAqFdjh/Q0YQrZEIKP1jAQRibW9tmaROTdWGLo5vy7nhQZ1JpP+EhSQcRebDsYkbmAOU8V03YR59ZLbfRDrgJcxxB1xkeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8XmT0xVrz2xbN
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Oct 2026 13:10:00 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 21 Oct
 2026 10:09:44 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 21 Oct 2026 10:09:44 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 21 Oct 2026 10:09:39 +0800
Subject: [PATCH v4] arm64: dts: aspeed: Add syscon phandle to AST2700 ADC
 nodes
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261021-ast27xx-adc-dts-syscon-v4-1-4fab164f10b4@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAOIe2GoC/x3MPQqAMAxA4atIZgO1/qFXEYfSRM1SpRGpiHe3O
 H7Dew8oR2GFsXgg8iUqe8hoygL85sLKKJQN1tiuMrZCp6ftU0JHHulU1Fv9HnDwS0t9XTMZhhw
 fkRdJ/3ia3/cDMRTar2gAAAA=
X-Change-ID: 20261021-ast27xx-adc-dts-syscon-9cf5d733ed0e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792548584; l=1915;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=IZUjXmUfedJ5IwJ86vwzPPmrXl0gfhcW6O8UO+QoZco=;
 b=hpsOaG9Ce6jXRrKDFl/kBKvsWHyz/Sq5Ys08ygSSCBVLWf1flEZBUOpaFZRR4mkAg5IG+L1WX
 lJXwEwYjufqDQ7syQ+sp8bYGfbzkOpnagPjO5KBXdfl6Ddg2O37HL7T
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Point the ADC nodes at their own syscon1 so the driver can correctly
locate the reference-voltage trimming data on AST2700, where syscon0
and syscon1 share the same device-tree node name and would otherwise
resolve to the wrong SCU.

Fixes: e77bb5dc5759 ("arm64: dts: aspeed: Add initial AST27xx SoC device tree")
Assisted-by: LLM
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
This was patch 3/3 of "iio: adc: aspeed: Fix SCU lookup for multi-SCU
AST2700" (https://lore.kernel.org/r/20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com).
Jonathan has applied patches 1 and 2 to the testing branch of iio.git;
this resends patch 3 on its own, now with a Fixes tag, since the
driver falls back to the old global syscon lookup whenever this
property is absent, so patches 1 and 2 alone don't change AST2700's
behaviour without it.
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

---
base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
change-id: 20261021-ast27xx-adc-dts-syscon-9cf5d733ed0e

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


