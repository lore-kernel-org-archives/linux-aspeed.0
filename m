Return-Path: <linux-aspeed+bounces-2942-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECD1CEBF92
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Nov 2025 09:12:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9f5C3QZ1z2yjm;
	Tue, 18 Nov 2025 20:12:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763457135;
	cv=none; b=j4kbppfYXkB7H3gxi+tRPdHB6yeEBR/w+OkkMrTFTKSxx1hNIIadHlrUjizyZQzjAgje/sxZfXHw2jUIt2I6NsTdBfTRS9BPiwVZzqgt0X9zJ4XS5JKAqL/DuM4UnQWSk8uGwmJpleMIbdhyaNbrUJgNOZV1DrgxFJRkLKXVD4n3Hk0RfE3VuAtU37lc/oAnXtafaHU6AqGn9J7VTwhsf5943vguf1cDU4DSMUydwVYSVSD4UvsC9pET6W2vjwgTFizj/pX52BgXd4uDm7L542C30t97oU0cYUpdWOqNvb4V54iX0lWToYwUfBc1MrJZst0OQbH3bLh/Y72HJ03HYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763457135; c=relaxed/relaxed;
	bh=YbpLaP1/u9cTEhTUk+jb1o2MR0IEib61EGdgk57uIJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=V/hZFxXz8jbF8DXowhePwLUNOa0crLQNzOoXyfhdTeSNpu4MpuCur5taRIwt6l9efUlqxyk+yLEqJM6CqR8XuNgmBO6/rkjIEnkO/DkjvZsXpijlKxNzl9a7hUTwNAfenT9vcu8aWCkIbYoOfxRJ0O76Fhc9ZbAeGtDACY8x3o41QyBJctct9YKidX9fiXuunfYEB73zZRekRN1jr6gC2ZP/K1PVmyOyvntHtvmLV2PF/ZTtLprwNzk4PmbJ0cX6BgW8PqKmNA6CutI7++MsWbdS4sJUCE6ipP75+1YzMIZDoiraEIYyimQoAeF+s2s0IB1dV+2txLFqCEla4ydylw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9f5B759xz2xnk
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Nov 2025 20:12:14 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 18 Nov
 2025 17:11:54 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 18 Nov 2025 17:11:54 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 18 Nov 2025 17:11:53 +0800
Subject: [PATCH v2 1/2] dt-bindings: hwmon: Add AST2700 compatible
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
Message-ID: <20251118-upstream_pwm_tach-v2-1-4d9bc13d34f9@aspeedtech.com>
References: <20251118-upstream_pwm_tach-v2-0-4d9bc13d34f9@aspeedtech.com>
In-Reply-To: <20251118-upstream_pwm_tach-v2-0-4d9bc13d34f9@aspeedtech.com>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763457114; l=1208;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=JDmEdUnkLF6RVLRvaEnIBn8tkpVakmNeGiFD6QBSMrw=;
 b=8hgzFz80poWkTppmHKaWIGpC5XxmS85p6j19TgPcrTxzasWNqRjDMan1sQ0vBR20yVoaI1F0g
 v9sbXH76B8SB59L/vZT5imGr4CNq+63pF566kVLXsJGbcFFgxi47Pxq
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Adds support for the AST2700 PWM/Tach controller by extending the
compatible string enumeration in the device tree binding.

The AST2700 PWM/Tach hardware is compatible with the existing binding
schema and requires no additional properties or modifications beyond
the new compatible string.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml          | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
index 9e5ed901ae54..8b579321915f 100644
--- a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
@@ -18,9 +18,13 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - aspeed,ast2600-pwm-tach
-
+    oneOf:
+      # AST2700 with fallback to AST2600
+      - items:
+          - const: aspeed,ast2700-pwm-tach
+          - const: aspeed,ast2600-pwm-tach
+      # Only AST2600
+      - const: aspeed,ast2600-pwm-tach
   reg:
     maxItems: 1
 

-- 
2.34.1


