Return-Path: <linux-aspeed+bounces-5095-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1EECA5FC4
	for <linux-aspeed@archiver.kernel.org>; Thu,  1 Oct 2026 03:29:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwHSx5FTxz2y2Z;
	Thu, 01 Oct 2026 13:29:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790825345;
	cv=none; b=M+C2fKkRnYC1KbMLiKR/RDS1FjppCB4sxhYUCpFcnGPWLc7JWX7m5BRww7cuUVEQzG+On33UXEO5GVD7ZeadgiUkhfC0So7aOdzXOYaMtZyCSGdkaFws0uFCWnc0N8Jj8KyxvPgXFFeOPfW2Pc0nl2kvtVIucrDS5tGMa0azU9rnnPXnKRHIv60C7mF0nKcQx/242Pse3W6EMeJrH2SmsgLqSbLmNMba+oAZtr4e/DoBmoKjRO8jGg/o1orHiWyDxMO3BZBj34b0psl1EvcDiNaKfWp5rFQzULAuwx3beaLxJv1vYlig6HhDsN9XNB3jKerMncWf9/eJD2x3F5ldVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790825345; c=relaxed/relaxed;
	bh=qjXowdpk9n74trVf4bFjKOhIzSQvO0hzJM33XCmqiBM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=etZ3iib/PLtGOjVTTezON9luRPRAp7ZZXqVKPC+ZWXQjQOUPJnJr+nr1vl2eiQwpOGudgm8e2+lvUJZHiykcnetaWtlfqhfVYwSwRAeS7gagnGd03VI11S+NDrJOwbTkZbz98MHKb36TlMU0WzbA1MV+Ri+HlvAALrbdTB7jJdQ/mdGg6lnyDxnq0Kxfzvnck6ZzXV65c7/o/tUr5kDv3Na26zQbcI7Q9DVKIonTzaOjzmq3ODXtBTDLG7b0+HeM4KzDg7StWbZvApWD+Ra0r51StQEUDNPhNn1aojFBLHDhqKMrkQ91N1OZWsflIeY4mFRb/Ue/mbUmHdeQz79ZUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwHSw2rvyz2xsW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Oct 2026 13:29:03 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 1 Oct
 2026 11:28:45 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 1 Oct 2026 11:28:45 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH 0/3] iio: adc: aspeed: Fix SCU lookup for multi-SCU AST2700
Date: Thu, 1 Oct 2026 11:28:43 +0800
Message-ID: <20261001-ast27xx-adc-upstream-v1-0-5ace57533418@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAGvTvWoC/x3MSQqAMAxA0atI1gbaKk5XERfVRs3CgaZKQby7x
 eVb/P+AkGcS6LIHPN0sfOwJOs9gWu2+ELJLBqNMpZXSaCWYOka0bsLrlODJbliUY+FaasjUI6T
 09DRz/Lf98L4fovR/emYAAAA=
X-Change-ID: 20261001-ast27xx-adc-upstream-34b3d9e8e27b
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790825325; l=1731;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=Qwwf1v0cP1lKAkuefRa4xK+nKzoRTdD8GOlUuQ48oL0=;
 b=2amv2tlwU+84A4Gia3y54ss8EMMFhAc0RUd99/JvaaoeO2sr60yhlMZBDIBaOiHLvUw0LSt9X
 Xw5hjObnlVOAlpS0coH5MYvmlHgyQ2hxpo6j3y4d9XPQhoOWK3uwAs+
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The ADC's reference-voltage trimming data lives in a SCU register. The
driver has always located that SCU with a global, name-based
device-tree search, which works as long as a platform only has a
single node named "syscon". AST2700 splits its SCU into two
instances, syscon0 and syscon1, that share that same node name and
differ only by label and unit address, so the lookup always resolves
to syscon0 even when the ADC's trimming data lives in syscon1.

This series adds an explicit "syscon" phandle property so multi-SCU
platforms can point the ADC at the right SCU, keeps the existing
global lookup as a fallback for single-SCU platforms and already
deployed device trees, and wires the new property up on AST2700.

Patch summary:
1. dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
2. iio: adc: aspeed: Use syscon phandle for trimming data when available
3. arm64: dts: aspeed: Add syscon phandle to AST2700 ADC nodes

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Billy Tsai (3):
      dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
      iio: adc: aspeed: Use syscon phandle for trimming data when available
      arm64: dts: aspeed: Add syscon phandle to AST2700 ADC nodes

 .../bindings/iio/adc/aspeed,ast2600-adc.yaml       | 28 ++++++++++++++++++++++
 arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi     |  2 ++
 drivers/iio/adc/aspeed_adc.c                       | 20 +++++++++++-----
 3 files changed, 44 insertions(+), 6 deletions(-)
---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261001-ast27xx-adc-upstream-34b3d9e8e27b

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


