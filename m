Return-Path: <linux-aspeed+bounces-186-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006D9E7717F
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Dec 2024 07:30:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y6r4b3N2cz2ysB;
	Tue, 10 Dec 2024 18:30:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733815855;
	cv=none; b=iMuzZlBNibg9QstkmC5IfK5V7TAJQTDhKC+j4y7VO4C0GmtHWm85ygc6DfQzrQORTEtB+OmB0+uXOPbDuRqGuySOV5zhmtlWJRZipYajd7+jByy/fFTddj9HhLUpi0frqFmYZ9Cw3vY0raly/VGTDxDt5N5fEBleWijyPkl+4CHU41XnadxbDKIWAK8CgTiqB124wiEPlss2n84rCdZcXJLgINJDZJAMcZm4IXGRAE9xXHeEH9haDYPECl2v+j2+Pgks83eH8ccIh0hlRAuhUKFkxKWbkqqrn9E3kW5iC4e1QW2FY6sZjxQUivxLtUZ08+AFHbf61WjtaY9q01pRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733815855; c=relaxed/relaxed;
	bh=0Gmy6qV1LwE2yQztvuvN1VPxCtOB/HT8J2meQGlVOrg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dE+an+mqIx+HKHgAcRax+4wLScAcvZiaxLKmp/2ia2+IHCk8eUlGonuYgnDFFXIkr9xVoVFFJdoRI8bV454LdFDavKRIsnLDdSXHbXjAaOHsP3NUk07evpntNk3B5xHXzg/z2TFDm8YIVcRv04nYAESDzxLm/+VC49O/lgn9KJaJ8Ephryig+Ji6Xx+s4z5KzIofDp9EJ4WcGQMTFyLEjz3l6QxNvp3BlmmsJjPyuanJL1895NVrZ/5I+TSh880On/ZGIC1w96gmLplkVdWqXHcSQ8gTtNbhK6+K4Z7OWQufvz+gKLbCy5S+gxvtkitevTRizqW6qIXcHhkKfy/eTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y6r4Z1WhHz2ynj
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Dec 2024 18:30:53 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 10 Dec
 2024 15:24:12 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 10 Dec 2024 15:24:12 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH] dt-bindings: interrupt-controller: Fix the size-cells in ast2700-intc
Date: Tue, 10 Dec 2024 15:24:09 +0800
Message-ID: <20241210072409.1429725-1-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
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

It is no need to let size-cells to 2 for the ASPEED AST27XX INTC. Modify
the ast2700-intc example usage.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 .../bindings/interrupt-controller/aspeed,ast2700-intc.yaml    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
index 55636d06a674..69503aa638fb 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
@@ -69,11 +69,11 @@ examples:
 
     bus {
         #address-cells = <2>;
-        #size-cells = <2>;
+        #size-cells = <1>;
 
         interrupt-controller@12101b00 {
             compatible = "aspeed,ast2700-intc-ic";
-            reg = <0 0x12101b00 0 0x10>;
+            reg = <0 0x12101b00 0x10>;
             #interrupt-cells = <2>;
             interrupt-controller;
             interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1


