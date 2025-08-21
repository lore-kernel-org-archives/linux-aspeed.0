Return-Path: <linux-aspeed+bounces-2018-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD96ACA0EF8
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Aug 2025 08:02:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6wlr1XzCz30T9;
	Thu, 21 Aug 2025 18:02:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755763352;
	cv=none; b=bkSr0hMbHWrC7wwLf9Z85wxltFLsmzelC7aHf93X5HPsbRPz+IEtuaBwXL0R1MgYopblFIx7DAGH3DKs+IKe5EzyM6Fx7h7dvnoMQjMErXgRJICogk+kMaM2K4Dlk8kokxiynI7w4wWDNo91c3/MUtEbO4bYd1x6JFNHSbGL27TnfPXcQqmogkXFpbZp/0668wmMZpdqHqAYmzQ4Il8BWmHtLyG5M0zPXMrzD3/W8/5F+YH2jmezz+mYAn0W03NN4IP4NaZZ1DmlaLn9rWIJQgEp1qh8MiIhwkpITu/f1JkOjp9JOPo4Rll3tef8Q5KGkMmai3OXGkVBXsi5to7UgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755763352; c=relaxed/relaxed;
	bh=Mbu+qZFER7pbiZrqt+tcMJho5bUY0SaQj4kdoKWEOe0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPW0CFk09V+iP/mOmH87A9MqVOkBEX1gpgUegIm6F3K5oCiPKL4AV3xdVYozBQ/1dC33ngRiB3Q7sOYdjs04Uo91yyzkoreianGHzo5hyjkeOvEnh8eQUpPp3Z1HfazMecK3UblaJZ34jg5J59egrDVx/5TE4oNLZ8AngN6PfWVJ+wxLizuoCWeD+Qnp6cYZEcRCE2lIxXZtb4NMP7QCN/jZ9g5/7SNe6XyO5IhcF99xcXSC9qh6Dz428gIddFT4k4MwsBaMnFAEgnyX9uWSIAHOtpSmqe80Io9Tc8zXiPpYfPWkoyI8rKcLmLlFQ6JiGtCa78VFXm8wr0QR+6gWvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6wlq530Sz2yhD
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Aug 2025 18:02:31 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 21 Aug
 2025 16:02:15 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 21 Aug 2025 16:02:15 +0800
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
Subject: [PATCH v4 1/5] dt-bindings: arm: aspeed: Add AST2700 board compatible
Date: Thu, 21 Aug 2025 16:02:10 +0800
Message-ID: <20250821080214.513090-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821080214.513090-1-ryan_chen@aspeedtech.com>
References: <20250821080214.513090-1-ryan_chen@aspeedtech.com>
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


