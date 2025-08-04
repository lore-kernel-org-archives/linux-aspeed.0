Return-Path: <linux-aspeed+bounces-1898-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495E2C87FDA
	for <linux-aspeed@archiver.kernel.org>; Mon,  4 Aug 2025 05:35:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwQHX5NSMz2yPS;
	Mon,  4 Aug 2025 15:35:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754285704;
	cv=none; b=UrDVADMzVREEaUDhI6njtrL2L64hCvivH5Qr2Vemy/wrcLCObLVt8UTuh6JSdBxiWAN/0Kle0UHPDY1n9k6e7KhAJsy381t+LnBHnpXHp3QexWsOaJKSHt8weagtn02kjhJGzBhKT1AA6LEhN5Tv0TLiAKdWg5+oa350KydnuQBGjQ3SYAyqwjjj36tteKD+APKXQntD8T6A092H/2Uk/SDpnxd00DHVQhWkgHKSXhK9wDfUSREtlgucV61cTcJFP4sWrz+O9Ix3RWx/RoGVdOR2sxc3fZAkace/LdY+L/v2ktHR6RYbmHPxY3ulB2yL7TSo2y1Na22QCasI2Ls6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754285704; c=relaxed/relaxed;
	bh=1av6ScHmYIhE4TSgdYd5qG12QWGJpMg78DKlxDfXV9U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMDHkgF6XUWkhyxk4CPEQNLLaYC169psZ6lPHJLLWlR3E9NvkaeDpz0bGuwQ5X0pKri/BwdW9CXB1umuMUBvrDH3wurJdk7jCCrvwGIe4qLBSFZbXMa7XtcvvUeURg2yEQg5Lwp0QKToBSr3JRZmpaIzGakX77MvDJIt0JcDBQjNnES27XpZqTTwpGpeapwX6rXuIOG5kDw4tx6cNwm1cbuCStS1iT/1Y0vy5rgx6mGvmVlsj373qcXV5wFBc9w2wvEFhJoq7YKpTR4ykuMT1IXZOi0C346NqTuR8/+c7NhAodyLKcuGDIwwICrFKjoZPBsjYrTQX4rcTUrujKKliQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwQHW4CMnz30Wn
	for <linux-aspeed@lists.ozlabs.org>; Mon,  4 Aug 2025 15:35:03 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 4 Aug
 2025 13:34:45 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 4 Aug 2025 13:34:45 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] dt-bindings: interrupt-controller: aspeed: add AST2700 SCU IC compatibles
Date: Mon, 4 Aug 2025 13:34:44 +0800
Message-ID: <20250804053445.1482749-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
References: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

- Add "aspeed,ast2700-scu-ic0,1,2,3" to the compatible
 list in aspeed,ast2500-scu-ic.yaml.
- Document support for AST27XX SCU interrupt controllers.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../interrupt-controller/aspeed,ast2500-scu-ic.yaml         | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml
index d5287a2bf866..d998a9d69b91 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2500-scu-ic.yaml
@@ -5,7 +5,7 @@
 $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2500-scu-ic.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Aspeed AST25XX and AST26XX SCU Interrupt Controller
+title: Aspeed AST25XX, AST26XX, AST27XX SCU Interrupt Controller
 
 maintainers:
   - Eddie James <eajames@linux.ibm.com>
@@ -16,6 +16,10 @@ properties:
       - aspeed,ast2500-scu-ic
       - aspeed,ast2600-scu-ic0
       - aspeed,ast2600-scu-ic1
+      - aspeed,ast2700-scu-ic0
+      - aspeed,ast2700-scu-ic1
+      - aspeed,ast2700-scu-ic2
+      - aspeed,ast2700-scu-ic3
 
   reg:
     maxItems: 1
-- 
2.34.1


