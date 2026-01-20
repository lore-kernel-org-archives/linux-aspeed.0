Return-Path: <linux-aspeed+bounces-3399-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA7ED2ED0F
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 Jan 2026 11:43:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwQSX3fnMz30Lv;
	Tue, 20 Jan 2026 22:43:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768909404;
	cv=none; b=XZF7lsBRnxObkSEiqTXwZ7V2/P6Seu2to9hqj7hebfF1bOHhZv0Xa7dat+hwsLDweu5Id165rWNXkLYLIo1NxprbI1ZGN+d0CAyuD92EBSF29tyvRempq1VmF3zI0ClkTZbSU/vOhqyTDI2PZ5uOva0XVg5h6R0qXNeeUpC9XqE1GwtgwM3Q3ZPliNlsnQra+097/1G1UUO3hJ0gnEk6nhSGQ8vO8PpSPrphlwZfqVMb2U4bwPmCzo3E57Zt/23/4wKvum3ck9cgGxrcjWjplGyvXvZ3yppoHExbEs5EoteMF/QjK/qRJ3MFQvgi2Jb7bZspHv2i7tO8ow2eV/Pjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768909404; c=relaxed/relaxed;
	bh=8Zjx5LVhTUye/03d8m5B5hk1BzOFI4k6PaOqx2Mbpng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EewrReveDKy8RcKUxPc0cjapQGxkdDUkTV2dP5EteX1Z0qiqX0+MLdzZXwz+X+zH+UgOmWk9Gw+JGlbsaLEGupQaykrOgx2H9YYe6YWFNNV7k2CAcVHd6ysXnaB0wW0Hy9y1u4TOF7xlPS/KOkyaUqNVkNZYYft7MBBnFQbLiF3z+CpLZpVOl94K+Ut+tssbZJk33a/WkXJTmx1P9uyqv4PeQCflCocXNcF8CEZZA1F3Hw+pl8J5gMOf0YNdFO26ERoeK8/W6f5N4NxklP65zGj6RNdjkw4bpFZQLc7SP81WeqRJmyLQAwRazY329RISvQafK5RkuUA++OO65m5AHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwQSW6w6jz2yFl;
	Tue, 20 Jan 2026 22:43:23 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Jan
 2026 19:43:05 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Jan 2026 19:43:05 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 20 Jan 2026 19:43:05 +0800
Subject: [PATCH v3 1/3] Add compatible strings for AST2700 pinctrl to the
 SCU binding.
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
Message-ID: <20260120-upstream_pinctrl-v3-1-868fbf8413b5@aspeedtech.com>
References: <20260120-upstream_pinctrl-v3-0-868fbf8413b5@aspeedtech.com>
In-Reply-To: <20260120-upstream_pinctrl-v3-0-868fbf8413b5@aspeedtech.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Linus Walleij" <linusw@kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>,
	"Bartosz Golaszewski" <brgl@kernel.org>
CC: Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>, <bmc-sw@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768909385; l=1240;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=DdyR9u8Qi85yC9mqQt4hcDY4TFfwnZrUdwlfhlwek5w=;
 b=F8UdHXQ2SCCgYDrPHtnGW0vHCdwhIeAO/iDaOKNIZc5owOxsuTO4H1VkhaN+KoLgCz93rIXF1
 fNnir68QwhsDrrouzcpxFcWoj0eDNpaB76o192k23IvHDUzpxZTbN13
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

AST2700 consists of two interconnected SoC instances. Each SoC has
its own pinctrl register block, which needs to be described
independently in the device tree.

Introduce "aspeed,ast2700-soc0-pinctrl" for the SoC0 pinctrl, which
follows the same usage model as the existing AST2600 pinctrl.

The SoC1 pinctrl registers follow a regular and predictable layout,
which allows describing them using an existing generic pinctrl
binding without introducing a new SoC-specific compatible string.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index da1887d7a8fe..ff6cf8f63cbc 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -87,6 +87,7 @@ patternProperties:
             - aspeed,ast2400-pinctrl
             - aspeed,ast2500-pinctrl
             - aspeed,ast2600-pinctrl
+            - aspeed,ast2700-soc0-pinctrl
 
     required:
       - compatible

-- 
2.34.1


