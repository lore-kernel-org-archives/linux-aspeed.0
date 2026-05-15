Return-Path: <linux-aspeed+bounces-4034-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7C5CD343F
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 May 2026 09:38:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH2Dk3dCMz2yGv;
	Fri, 15 May 2026 19:37:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778837878;
	cv=none; b=BcHc9br95/r6ICi+s83a8F+qNlAsrV1vf1cB3+0xMFlv1yrbDsW7ANVDqvFLxctGnA50K82Z9E+mkBhDa+IHv2vwwvuUJBROgt3vr9GqxbblIst4jSnhayGOC66sDg/BAyBMc1ewaZRm3RWzqUNTDi5v1CQOruVrpI96Ge76pvVMGUw0jscB1oaMJshOlHLY/exwpJGjepHEFmRFNbGAyVOPnabH7FM5Jt9Ra5FDoDm522hEQCEgneFODuvsHpxwSQEf9gknvoRcZh5NiJsREJfhgeR7Bj5Dhv7WXS9f+aFlUvc6Y5VmqX5Jy5frMLAfaNbHtgxMf0Ep2A3cfGAYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778837878; c=relaxed/relaxed;
	bh=MrfN8dQgOt22H79S4Y7zuJRD/bQw0K2TbMbb8UsDdCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=L2b7vv61AuO2/U2j/j4QtiiLtbr/7fiH0zW5oLbSAu6Nu5/oowLeC3z7WryILcJFlJYHuLdfHWXhlzzfwyR7hNZhAy5SAL7UjS47XLEhmaVS5khUnHwMLGQebnZRJxbCCKjY8qSk3tfOBqB7Zyi0Iq7S6mhxZixY8bgPBO4Sh4cZuMCflRZAeUZaav5Rr4mZQ44BdkfRvobJQplgua8VmDYVGvrU+mQM3l05J4b7JXWkl1PKTXljZ2W/WaEgHIOh85kN4ztFEmOQXNZS9KqnGizJwJ1O3WRMkzudUjkAMr1TGPChHI6vaho8xD2pWN868UJuFPCqhDUmKEB80ltPmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH2Dj51v6z2y8r;
	Fri, 15 May 2026 19:37:57 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 15 May
 2026 17:37:38 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 15 May 2026 17:37:38 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 15 May 2026 17:37:37 +0800
Subject: [PATCH v3 1/3] dt-bindings: mfd: aspeed,ast2x00-scu: Support
 AST2700 SoC1 pinctrl
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
Message-ID: <20260515-pinctrl-single-bit-v3-1-e97da4312104@aspeedtech.com>
References: <20260515-pinctrl-single-bit-v3-0-e97da4312104@aspeedtech.com>
In-Reply-To: <20260515-pinctrl-single-bit-v3-0-e97da4312104@aspeedtech.com>
To: Linus Walleij <linusw@kernel.org>, Tony Lindgren <tony@atomide.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Bartosz Golaszewski <brgl@kernel.org>, "Lee
 Jones" <lee@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
CC: <patrickw3@meta.com>, <linux-gpio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<BMC-SW@aspeedtech.com>, <openbmc@lists.ozlabs.org>, Andrew Jeffery
	<andrew@aj.id.au>, <linux-clk@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778837858; l=1555;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=3e2kITT6mFMbhyrdHoz++iCXINTieTn84213K9JqWRw=;
 b=c63j6UQwoTjC3Y/S6YzDoKfPWPa2BQxeTunc+5GteeHxgXPc+Ztm2TTsMdQsyBSew3ysX3guz
 opvV/w3x8xgDTiGrl60hdieDZoYpfTrYnmxAu/jmjWk03PGFSV6CHEc
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The AST2700 SoC integrates two interconnected SoC instances, each
managed by its own System Control Unit (SCU).

Allow the AST2700 SoC1 pin controller to be described as a child
node of the SCU by extending the compatible strings accepted by
the SCU binding.

There is no functional change to the SCU binding beyond permitting
the aspeed,ast2700-soc1-pinctrl compatible string.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

---
Note: The companion AST2700 SoC0 pinctrl series modifies the same
binding and has been applied to pinctrl/for-next. Linus Walleij noted
for the equivalent SoC0 MFD patch that it should be applied through the
MFD tree by Lee Jones, providing an Acked-by in the process [1]. The
same routing applies to this patch.

[1] https://lore.kernel.org/all/CAD++jL=3p9BvDgaot3=emM4Zn5jU-ZAUKtB4UwT1HzDiyzKq4Q@mail.gmail.com/
---
 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index a87f31fce019..b81c561d2a8c 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -87,6 +87,7 @@ patternProperties:
             - aspeed,ast2400-pinctrl
             - aspeed,ast2500-pinctrl
             - aspeed,ast2600-pinctrl
+            - aspeed,ast2700-soc1-pinctrl
 
     required:
       - compatible

-- 
2.34.1


