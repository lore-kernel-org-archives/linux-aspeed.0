Return-Path: <linux-aspeed+bounces-1953-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB37ECA0EE0
	for <linux-aspeed@archiver.kernel.org>; Wed, 13 Aug 2025 23:53:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c2QBM39Lnz3cYR;
	Thu, 14 Aug 2025 09:51:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755066803;
	cv=none; b=Lq+lh37ZujZPGeXUdll+J49DwipOmggqBRseSfeaoXDPFBvldBOShSnWd7L3YKnwThjUy+SGn6QFF13IzTgD8PYmI5oGjplYt6ULdQ3IRrcXLis1x4d/qhE7TZ85dz/SP4ca8McXNYBzonc6y/h2FSShzfcrswOqsQah6Ns2+ttJtNNH/IWtlvc9ltjcWCnDlosZ5FtvRHC8kpFwtMDfUFxUa5X2nvg53Q9Db4MsFz4ylTizb2ku+zRu3z4DijnOjPldOgdtfdc5g2e9hA4lJ6s5q7bx6L2Eej+pfkXUe4DZHY0wCRGOVR8oU96oJoGqvHn+kifuyQNI1Qh5W779YA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755066803; c=relaxed/relaxed;
	bh=T3mFXKfIUYSJav2Nwa5QdQol2Z1tDuQn3BjGEDu8NPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDWnGqjoo3l24Ckd2irFyzfprVebXQhlY3ZhlfoxD1do3c7zmbsjKKnHOYZ86dxXsEaDZEkF1zmoFqWlklKQLYRaRPx/b2QzwDInwL+EXtDx5hn5LscRZUWODgzSoEhGsPPPj+UYXlmp7O0wLQrxFsH/4kq8clAxxAZPMhR5pwOtnaWq8M1vxhjyc8POfDpaAM1kWV9dfUzJROg4yFHHnz8NjvzitlE4L5Wx7i+Ik2wdYXvEGNr/EiS3+3kVDwjjuF06MGRTcZz52gX0T1d9obq/4atAG/ntRWmOfF2DKG5EdFielebzmKYWCQ8avwinuAhCiZRJEkq0uxok07ngVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c1z8f2Bqyz30Vs
	for <linux-aspeed@lists.ozlabs.org>; Wed, 13 Aug 2025 16:33:22 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 13 Aug
 2025 14:33:01 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 13 Aug 2025 14:33:01 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Po-Yu
 Chuang <ratbert@faraday-tech.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<taoren@meta.com>, <bmc-sw2@aspeedtech.com>
Subject: [net-next v2 3/4] ARM: dts: aspeed: ast2600evb: Add delay setting for MAC
Date: Wed, 13 Aug 2025 14:33:00 +0800
Message-ID: <20250813063301.338851-4-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
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

We use the rx-internal-delay-ps and the tx-internal-delay-ps to
configure the RGMII delay. And change the phy_mode of MAC0 and MAC1 to
"rgmii-id" to enable the TX/RX internal delay on PHY side. MAC0 and
MAC1 configure on the edge delay.
Keep the phy_mode of MAC2 and MAC3 to "rgmii". The RGMII delay of MAC2
and MAC3 can generate the delay to meet clock center, so we just add the
delay property to let driver to configure 2ns delay.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
index de83c0eb1d6e..dc4d437a39ed 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
@@ -123,22 +123,28 @@ ethphy3: ethernet-phy@0 {
 &mac0 {
 	status = "okay";
 
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii1_default>;
+
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
 };
 
 
 &mac1 {
 	status = "okay";
 
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy1>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii2_default>;
+
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
 };
 
 &mac2 {
@@ -149,6 +155,9 @@ &mac2 {
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii3_default>;
+
+	rx-internal-delay-ps = <2000>;
+	tx-internal-delay-ps = <2000>;
 };
 
 &mac3 {
@@ -159,6 +168,9 @@ &mac3 {
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii4_default>;
+
+	rx-internal-delay-ps = <2000>;
+	tx-internal-delay-ps = <2000>;
 };
 
 &emmc_controller {
-- 
2.43.0


