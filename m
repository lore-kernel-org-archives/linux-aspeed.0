Return-Path: <linux-aspeed+bounces-1398-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04434C61CE8
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Jun 2025 10:09:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHyv64PmJz2xYl;
	Thu, 12 Jun 2025 20:09:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749722994;
	cv=none; b=lTN2lAg2rFZ13GbmSmj7p8Prv8/X1p0zkZfesDGBnlqzem4DgKccojP+57PTimlwzwP7skIr8cA93838l0/ATAlYus1xQ8INqGqo/dBVXIY1KihrgAM4M0As5ND1VFan5f8qQqhSPHJYqsNAfk06AATfbTXoo1o4zwtw8Zs+MuTN6uVWg9MriOHFQ9DCy2XzhZ5D7Q+AFuEKHT8yUv8jO+1ZIhU7UdYoUiqjMDHMUcFWIIbfYYFmNrqWfr1R3icSh0XLj52/GU/UhQzUsVHGvtF08ThXRqVMPRy5MicTsfsJtqFsDVv5PC3bsWDXX7v0zfIXqUoY29nn9xsViVB7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749722994; c=relaxed/relaxed;
	bh=Mbu+qZFER7pbiZrqt+tcMJho5bUY0SaQj4kdoKWEOe0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkHw4BARmFW+gr/rE+vHEwcK8KMxeFjeqy2gPE1rGC7McVcT2IEe+y8pyNJ8V7PSPyqTTYZsFozMTmY4osLZQa/89c2NPw5TYgthxowumsjGD+igN+vvq8GzRp9Xy9Waqc07Qp+muAkHBT3ewPGsIe+4pWu9Q98tFSAcd/Qu+70y/WNHsno3OUgMJTakCPHFh59cgTLOuZWBlj2S8z400+6rNsoV+MhFOVnINNqQbAAkDF2nsdr0p1OLvxMXdJ0N+3Htqu3Y8BHAtj0cRE9h3gPSOuOLd1B40uGS9U/TNf2eAqRzc4Uqp2CqvDhBTVUorBYXk3FdBV9/ZA6vs6Zz2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHyv56qxGz2xPL
	for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Jun 2025 20:09:53 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 12 Jun
 2025 18:09:33 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 12 Jun 2025 18:09:33 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@google.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<soc@lists.linux.dev>, Mo Elbadry <elbadrym@google.com>, Rom Lemarchand
	<romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang
	<yuxiaozhang@google.com>, <wthai@nvidia.com>, <leohu@nvidia.com>,
	<dkodihalli@nvidia.com>, <spuranik@nvidia.com>
Subject: [PATCH v0 1/5] dt-bindings: arm: aspeed: Add AST2700 board compatible
Date: Thu, 12 Jun 2025 18:09:29 +0800
Message-ID: <20250612100933.3007673-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
References: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
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

Add device tree compatible string for AST2700 based boards
("aspeed,ast2700-evb" and "aspeed,ast2700") to the Aspeed SoC
board bindings. This allows proper schema validation and
enables support for AST2700 platforms.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..660529c81af9 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -102,5 +102,10 @@ properties:
               - quanta,s6q-bmc
               - ufispace,ncplite-bmc
           - const: aspeed,ast2600
+      - description: AST2700 based boards
+        items:
+          - enum:
+              - aspeed,ast2700-evb
+          - const: aspeed,ast2700
 
 additionalProperties: true
-- 
2.34.1


