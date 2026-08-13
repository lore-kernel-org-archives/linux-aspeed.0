Return-Path: <linux-aspeed+bounces-4696-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E24C5DF64
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Aug 2026 06:43:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLG5H4PZVz2yqL;
	Thu, 13 Aug 2026 16:42:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786603379;
	cv=none; b=mhQADWoa4gnSCvO/B4hlAMihJxy7Zp5LmoSW1UXe1QoKihHpVDAjxIVPKmCVKfHHzJQUHUyFty5GHSl7RbIPlpX5UgXFju0m7BEsZhMieyAvTPkq+gdwTJYkL9RA4nTTiY6lppiLNNcJ+jtcecqbcJ3uutQIfqEMoVefgAs0Fbh9Uwl3pOOXppGIRDju0cZVQXyDiFFyoUVe2G7xgPHlP2DP2V/tFB7HDdhjEs+qt/zGm2di01q1lidv0QaHga4bfuu0e6Tr4Ly+65mFk9IOAOujI+fEc2s5chQsSfaRtWxhy4G6y4uhbd9x/0AfxzoBNu9XJvYOP9TwA7tZWEHATA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786603379; c=relaxed/relaxed;
	bh=4DvRcolxJFQZQro803cBP8dU4DY4mdGf3VxudjAxfQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Tja1yM5rGpMiFlczekXkYX2NRtRY83xZ1MIAtOf46NJjDGklHK/tJbzrl5Pso/tw5JbcMZTnGfFNdZbZbwSwGz76u2vlosJCV+rOoYuJDz1jF2cPN4AoO9nHRug4F2s+GaaCQJe370QAxzCZOiofQZLT2tQrViF7HGBzKY33Hbdj6sY/dUmBHufvlX4UYCFGv23GdTsoFVywWdbvrvDaLny+OxO7g+m+66tMVmXNXl9SyB1LSTFL6pRq6kFI3SZKBL7D64PSpfdXk2/WFO3Gi32tbHIgpqjrKtM652Dtqfz8PWixIzs+eqGpAvYv+xjqEnQYkSqoq4+6KJkcGyZ1MA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLG5G6K5Dz2y0B
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 16:42:58 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 13 Aug
 2026 14:42:33 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 13 Aug 2026 14:42:33 +0800
From: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
Date: Thu, 13 Aug 2026 14:42:31 +0800
Subject: [PATCH v2 1/2] dt-bindings: mfd: aspeed-lpc: Document lpcN alias
 for multi-instance SoCs
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
Message-ID: <20260813-upstream_kcs_multiple_lpc-v2-1-775b1db3fe95@aspeedtech.com>
References: <20260813-upstream_kcs_multiple_lpc-v2-0-775b1db3fe95@aspeedtech.com>
In-Reply-To: <20260813-upstream_kcs_multiple_lpc-v2-0-775b1db3fe95@aspeedtech.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Corey Minyard
	<corey@minyard.net>
CC: Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openipmi-developer@lists.sourceforge.net>,
	<jammy_huang@aspeedtech.com>, Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786603353; l=1505;
 i=yc_hsieh@aspeedtech.com; s=20260721; h=from:subject:message-id;
 bh=3fvCknCwajnOMYIUp1uHwU+nFkwRbCJkD6DOdmYgiUU=;
 b=lJEEEpMZkfLyqypXwFJYpwz/fUf8JftwyrAnNfp+GYgwm3Cf1mwyNicBdl/HnC68WExoj+3od
 blHG6vR3vJdDC2zKazkTFANN2cjJE18j3DnQ6oo+qggNIRpnIzCGWTr
X-Developer-Key: i=yc_hsieh@aspeedtech.com; a=ed25519;
 pk=7KnU2ozXGF2IATT+Hvu7RbRwPxBA3/b+zhfM+UsPJMs=

Some SoCs (e.g. AST2700) expose more than one physical LPC controller
instance. Downstream devices such as KCS channels need a stable,
globally-unique index derived from which LPC controller instance they
belong to, so document the "lpcN" alias convention on the LPC
controller node that lets DT authors assign a fixed index per
instance, mirroring the existing alias-based numbering convention used
by mmc/i2c/spi/serial.

Signed-off-by: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
---
 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
index cbc3a2485a2f..81c12e0fb312 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
@@ -35,6 +35,13 @@ description:
   configuration, therefore the host portion of the controller is exposed as a
   syscon as a means to arbitrate access.
 
+  On SoCs that expose more than one LPC controller instance, it is possible to
+  assign a fixed index to a given instance (and thus to downstream devices
+  such as KCS channels that must be uniquely identified system-wide) by
+  defining an "lpcN" alias for it in the /aliases device tree node. If no such
+  alias is present, the SoC is treated as having a single LPC controller
+  instance.
+
 properties:
   compatible:
     items:

-- 
2.34.1


