Return-Path: <linux-aspeed+bounces-22-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AA2D0BB6A
	for <linux-aspeed@archiver.kernel.org>; Thu, 24 Oct 2024 07:16:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XYxzH2VD1z2yNs;
	Thu, 24 Oct 2024 18:16:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729754171;
	cv=none; b=ewJPxxSkH+TrnfzmKAxLK03iB+f+TiQjtfgJg7DR/5pN3k27p+i9cNBZG6FAo1Wq/CHzFSjisPyATpviSKloqLc7qzDRF1VXt0yFzhLNtEiSv1LFWnQ1s1gUQ6a67v9fVNs9CEK/Jb+vGoNHB+uvtQF/SxSQGPIGLhk9mUPHMOTlk2+GY8PF9LMXsXh4m3lwLoDy1osE1TpPM2PB2LsoGP6Xj/G/uS0vJoUCucTaVZrGQsDlBCG+2087jPZbyVx+oK1nvfp/2jJKXf6JUYP9fx2VBcTo/gaPvX5ueyizOs60XgQt/q69RSYseHcP+f03A4gJIV36ev5exHtdgk5d3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729754171; c=relaxed/relaxed;
	bh=NV4BJB1hebCHxZfRKBVABAwnVrIkc01gp5Jshymh+3M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C79/cYwqTiFQ0SyrXS1Eo8cCg5kM05EnswjOn9WUpTRCgf9TheWWlr2WMUNO77PktlhNdhvhPEHSha+uKaBXpzkLq3SdPZ3ZJ57myu5rLR+FMeWRenAe7lbljbVO3XCxdHUlrh6kJ2CwSZeb6hZbRuYQC10fwG59mIj0y7mymuf411wzkKkAG1cXhU4JOOl23swGzfWLv24v1/8rDuhp73jo55d3ZldGPmeDjHpZejIUTyPaJ0JeETVjcgKVVlGjGtPcKXwCKjQROgAzTK2FVgFp6Wf7fNJY8x2BY/BKwONgu/uNk10uY3FUk/C8SC3oI7D+9J7aXDgU3fjYR2Ting==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XYxzG4TxMz2yF4
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Oct 2024 18:16:10 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 24 Oct
 2024 15:15:48 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 24 Oct 2024 15:15:48 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <ukleinek@kernel.org>,
	<billy_tsai@aspeedtech.com>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v1 1/2] hwmon: (aspeed-g6-pwm-tacho): Extend the #pwm-cells to 4
Date: Thu, 24 Oct 2024 15:15:47 +0800
Message-ID: <20241024071548.3370363-2-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add an option to support #pwm-cells up to 4. The additional cell is used
to enable the WDT reset feature, which is specific to the ASPEED PWM
controller.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Change-Id: Iefcc9622ac3dc684441d3e77aeb53c00f2ce4097
---
 .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
index 9e5ed901ae54..0cc92ce29ece 100644
--- a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
@@ -31,7 +31,11 @@ properties:
     maxItems: 1
 
   "#pwm-cells":
-    const: 3
+    enum: [3, 4]
+    description: |
+      The value should be 4 to enable the WDT reload feature, which will change the duty cycle to
+      a preprogrammed value after WDT/EXTRST#.
+      The range for the fourth cell value supported by this binding is 0 to 255.
 
 patternProperties:
   "^fan-[0-9]+$":
@@ -69,3 +73,22 @@ examples:
         pwms = <&pwm_tach 1 40000 0>;
       };
     };
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+    pwm_tach: pwm-tach-controller@1e610000 {
+      compatible = "aspeed,ast2600-pwm-tach";
+      reg = <0x1e610000 0x100>;
+      clocks = <&syscon ASPEED_CLK_AHB>;
+      resets = <&syscon ASPEED_RESET_PWM>;
+      #pwm-cells = <4>;
+
+      fan-0 {
+        tach-ch = /bits/ 8 <0x0>;
+        pwms = <&pwm_tach 0 40000 0 128>;
+      };
+
+      fan-1 {
+        tach-ch = /bits/ 8 <0x1 0x2>;
+        pwms = <&pwm_tach 1 40000 0 160>;
+      };
+    };
-- 
2.25.1


