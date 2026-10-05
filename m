Return-Path: <linux-aspeed+bounces-5134-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAB6CA5FCE
	for <linux-aspeed@archiver.kernel.org>; Mon,  5 Oct 2026 10:23:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hywSx3t50z2yDm;
	Mon, 05 Oct 2026 21:23:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791195793;
	cv=none; b=lMCycX5m8XDlSej4d7LbBeo1IXGcOidcOCpd0/6mYFH7j0C/Xtx28kAHom6jkw8kHNtOnyNGhS92BTGedIQH1yNpc5u+1IcNRCHpEfDcKmrqvQCHW4+JQoqZd9U5f1Yc9tYH13/fsqP0xDnIleXRmc6V9sgAOEUz11uQ56L+qyq08uiIxvLw0tJIL8Bn2Yb+AXkQrRaJOll0r1Z7fISMatanTL5jBPHTxQ6FSU3v/ntK26AD7YWK1et9c1m/VmHmtWt9UMNe3y+8JizqCJe2BBcpKzrP+dhxwWkr1rN2sJJLCoMiLOND/9lEniYS0vZ76bGXCew9obwsD405jMWPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791195793; c=relaxed/relaxed;
	bh=6RJDujfXEFwg4QgGccP2V2tPbp+Gh8YpraFdiMS9tZU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=NRJhkQHD7tPsVxqGGbcop4mnuJvbgnJlLMwDGMwmW0bjm4HB1IoPabXcxQkqdmERl4GAxqU3LKmp7FLfJcBIHaFW1l1jtrIUuq3Gy0o2fNjAve7FJnXK2iakjD0Ur03h8T/8qj3S3NVBvbvXIIlJMqL8CTqD7BBB9+hRtIYKiVnSQcn2uJOaQOJ8bWNqn2VCHRrF6ejI9bLxHRXLqucVx6lMIk8pxD17oy5L/18M2Scsf1Cv1VUpzQJVVaXujZI553KyzXFdN051n9eZIR7ItGXr6Itry/zHBw3hgcBab7SuviKWO0BgiCdaRRfqw1hsSNwfzcI2/ap8WF/TijDEew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hywSw3zKCz2y8G
	for <linux-aspeed@lists.ozlabs.org>; Mon, 05 Oct 2026 21:23:12 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 Oct
 2026 18:22:54 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 5 Oct 2026 18:22:54 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v3 0/3] iio: adc: aspeed: Fix SCU lookup for multi-SCU
 AST2700
Date: Mon, 5 Oct 2026 18:22:52 +0800
Message-ID: <20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAHx6w2oC/43NTQ6CMBCG4auQrq1ppxTQlfcwLsp0kC74SVsbD
 OHuFrYudPl+yTyzskDeUWDXYmWekgtuGnOoU8GwN+OTuLO5GQiopBCSmxChXhZuLPLXHKInM3B
 VtspeqCGoW5ZPZ0+dWw72/sjduxAn/z6+JLmvP8AkueDaIOlaK1XK5mbCTGQjYX/GaWC7muAfC
 bIE3QWlRhSiKr+kbds+ZsKNHwcBAAA=
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
	Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791195774; l=2794;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=MHyVw2ZKEJEd8TJ8ETLosBAMfdGwcfGP+L8N5MhXY2k=;
 b=PLwS/wCnfPxX+nADfgg1wNzPo70a7CAhsL3H7u0XTCfapXutbtsVxUdlgGbZIMhueQeui6wjq
 qx+KILeVT7sDxdsA2t22v1DM8uBIvsUffnY68eM7qAf/OcNxC7MPgsp
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The ADC's reference-voltage trimming data lives in a SCU register. The
driver has always located that SCU with a global, name-based
device-tree search, which works as long as a platform only has a
single node named "syscon". AST2700 splits its SCU into two
instances, syscon0 and syscon1, that share that same node name and
differ only by label and unit address, so the lookup always resolves
to syscon0 even when the ADC's trimming data lives in syscon1.

This series adds an explicit "aspeed,trim-syscon" phandle property so multi-SCU
platforms can point the ADC at the right SCU, keeps the existing
global lookup as a fallback for single-SCU platforms and already
deployed device trees, and wires the new property up on AST2700.

Patch summary:
1. dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
2. iio: adc: aspeed: Use syscon phandle for trimming data when available
3. arm64: dts: aspeed: Add syscon phandle to AST2700 ADC nodes

Assisted-by: LLM
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Changes in v3:
- Switch the LLM attribution trailer to "Assisted-by: LLM", the format
  required by Documentation/process/coding-assistants.rst, instead of
  naming the specific tool/model
- Move each patch's Signed-off-by to be the last trailer, after
  Assisted-by
- In patch 2, use dev_of_node() instead of dereferencing
  data->dev->of_node, and check the new property with
  of_property_present() before calling the non-optional
  syscon_regmap_lookup_by_phandle()
- Link to v2: https://lore.kernel.org/r/20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com

Changes in v2:
- Rename the new property to "aspeed,trim-syscon": a bare "syscon" is
  not a generic property per writing-bindings.rst, so follow its
  vendor,type-syscon convention
- Reword the property's description to state its purpose instead of
  restating the schema's required condition in prose
- Drop the extra AST2700 example added for the one new property
- Link to v1: https://lore.kernel.org/r/20261001-ast27xx-adc-upstream-v1-0-5ace57533418@aspeedtech.com

---
Billy Tsai (3):
      dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
      iio: adc: aspeed: Use syscon phandle for trimming data when available
      arm64: dts: aspeed: Add syscon phandle to AST2700 ADC nodes

 .../bindings/iio/adc/aspeed,ast2600-adc.yaml       | 17 +++++++++++++++
 arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi     |  2 ++
 drivers/iio/adc/aspeed_adc.c                       | 25 ++++++++++++++++------
 3 files changed, 37 insertions(+), 7 deletions(-)
---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261001-ast27xx-adc-upstream-34b3d9e8e27b

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


