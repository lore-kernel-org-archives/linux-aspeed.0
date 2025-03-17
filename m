Return-Path: <linux-aspeed+bounces-1020-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D67C35FF9
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 23:01:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGr7G0krsz2yGY;
	Tue, 18 Mar 2025 10:01:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742180385;
	cv=none; b=VeTEZPFHWHgD1jolzD6RRQTyNH774jer93/xl4uzeLpJLsV0FnWeYuYQ1/123+pcAPc3iJHg/VMyyAjK6xAStuUIpyholmRVl49fAw1BQgpoYtRlDIBGlD6y8cbs7e1xOmMnSbeyJPUYYtFtCK8VTUzB+lbVY9qO1fnIMjIJp0UWc+w0J+AsNTrkS7xyIdDvQAEjYHSpO7YzaUF7vINM9ZfX2DkIZOivxgMxE79xXSLnKnFJwG3aBLnroTtI0O4FUFuNo7KRiGDzXiNokstznLEZB1cLVZz/p2ikiGsQ3a3lx7VvcNyhlHLkHQrs4mVvXM4Ey79v7TQWsZW+5/yhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742180385; c=relaxed/relaxed;
	bh=hbW5gVH0/GMypEjK6NX6CcK7rWry03g6woQ7It58TtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Suu/tMxyKGIa8CLDv699uCj/PKqxAiqtLkQEbJmxJtd2UJKUOv8If6girnfbwCdtx2y1TQmGb4Qmw3QTMewBLOivC+8WemSUPcAE/G09F/CcXyPf/sH8Ypy3WYgLWAD1Vf0efb/UWPJNG75762VH32sta3268v7vYovXEpwh0/qZoeYO203JmQVYwuRgbdOcVf6DP6zIDYGo/lh89pi/7tktfBC8yZgNvsYE0sABDhlkI1+cNM1N09VpP6lS7LJrs7QX2mcItbFRIDukOWLX30y35kORjMGiivpxQIx7+ExLgRw2jmvuAVXfaiwqpRv4m+WYj+IcjF9QNWHFcaAYAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGKSw5Y31z2yRl
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Mar 2025 13:59:44 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 17 Mar
 2025 10:59:22 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 17 Mar 2025 10:59:22 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <ratbert@faraday-tech.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next 2/4] ARM: dts: ast2600-evb: add default RGMII delay
Date: Mon, 17 Mar 2025 10:59:20 +0800
Message-ID: <20250317025922.1526937-3-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
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

Use tx-internal-delay-ps and rx-internal-delay-ps to
configure the RGMII delay on MAC.
And add default value for AST2600 MAC in dts.
Refer to faraday,ftgmac100yaml to know how to configure
the RGMII delay.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
index de83c0eb1d6e..1db1f2a02d91 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
@@ -126,6 +126,9 @@ &mac0 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&ethphy0>;
 
+	tx-internal-delay-ps = <16>;
+	rx-internal-delay-ps = <10>;
+
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii1_default>;
 };
@@ -137,6 +140,9 @@ &mac1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&ethphy1>;
 
+	tx-internal-delay-ps = <16>;
+	rx-internal-delay-ps = <10>;
+
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii2_default>;
 };
@@ -147,6 +153,9 @@ &mac2 {
 	phy-mode = "rgmii";
 	phy-handle = <&ethphy2>;
 
+	tx-internal-delay-ps = <8>;
+	rx-internal-delay-ps = <4>;
+
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii3_default>;
 };
@@ -157,6 +166,9 @@ &mac3 {
 	phy-mode = "rgmii";
 	phy-handle = <&ethphy3>;
 
+	tx-internal-delay-ps = <8>;
+	rx-internal-delay-ps = <4>;
+
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii4_default>;
 };
-- 
2.34.1


