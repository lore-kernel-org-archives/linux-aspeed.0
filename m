Return-Path: <linux-aspeed+bounces-199-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07EEE77182
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 15:55:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8H9G6q4xz30WB;
	Fri, 13 Dec 2024 02:54:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734018898;
	cv=none; b=iqTQAuRe6+2CIn+XZJKj4PkIIi3pbC2yu6BrmxJ9gJiRXxild4sMC4W2oDU5PXSGtqNk8j1ufEmWLQbLtIoOo5DwsG4lJHFyLhNCaonmii5YpblFct+sjw+sopwzm36fW8eXcmzGa8rapMF+Ff2kmETPTBKqftSssBhbfrrF8E7n3sKPeVwFb72xTcYmh6ksEislKzQcbUWTDjo/K75eYZs9kbUvLWJaDDtw7GjZ2CA0R86tjxCjJZ/6//WtiLrEhP5iShFmZHvqrtUh1Z6qVUd0z6LXpDtq2AzgURbLP/hARhCD2Mu7bEj/W0yeT85y/JzFQbCKxGn9Fy6AWO81kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734018898; c=relaxed/relaxed;
	bh=0Gmy6qV1LwE2yQztvuvN1VPxCtOB/HT8J2meQGlVOrg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWJYU4tAmr3e4GPXqIpnFTRrQOAOiPV1vreylfJSetDGeX+sjXhBR3LLwTDk+5ZmXDpc2SSaraUnOzveu5+wQLroE2xaoF7CRgw0ug+43zzeAr4Z1qdmVRUZS2+IZBEKP50jViQwwZ0Ow9iKiGAAk+ccag1HuhSOFiyH2D6TIpTmJeOnX13ESFZMogFTgAG5KCrQhtQEVBZraS3TfWKv1YUle5hi9kYs2g/E3A6LCpsBrOdN8ximVc3BTN+B8BGCzb/0xwz2ZqeLyzcmV6rBXNj6CL2BnqhIzDcKDoecWeQnsPidxKd4/+aMpWwrNTkgpq5rkUEqsXSpYvt0ALN+zA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (unknown [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8H9F73mSz30W0
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 02:54:57 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 12 Dec
 2024 23:52:41 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 12 Dec 2024 23:52:41 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <tglx@linutronix.de>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
	<dmitry.baryshkov@linaro.org>, <konradybcio@kernel.org>,
	<neil.armstrong@linaro.org>, <johan+linaro@kernel.org>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <soc@lists.linux.dev>
Subject: [PATCH v3 2/6] dt-bindings: interrupt-controller: Fix the size-cells in ast2700-intc
Date: Thu, 12 Dec 2024 23:52:33 +0800
Message-ID: <20241212155237.848336-5-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
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


