Return-Path: <linux-aspeed+bounces-3049-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D23AD2F7D0
	for <linux-aspeed@archiver.kernel.org>; Fri,  5 Dec 2025 09:53:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dN6C36PvCz2xs7;
	Fri, 05 Dec 2025 20:53:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764928415;
	cv=none; b=XCHQLzsJRwX3FbCa3WHNV4d82jLt7NmwkISGwj+FHgIHg2cikcw1zxhlavfa5Bru/k80zsxXQpcWiJCkO1L4zP0yIGjv9Ip57/V8oqdhM5Iek4GVmxJ5KteHDh8A9mwoHPCtv5Q1RqOCMZF4EOI7arWaUzEnF27sbMGlVrlpQZH63pL52pEZ2jrDppS2Wt3BCio5R5fyvqj8Gj/WGUXyDDwIvDxP6Feow/m8pRNY8Ha/eIa4qJYezecfdhoZ2jzmQlpf92C6AZ9zz0Qoy0K0UO14ySVDkoF1w86HfCG6zyjsImqQdItS1njBqKSarh8bDpT9EHCG2d05C2XSaxOr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764928415; c=relaxed/relaxed;
	bh=Zjd9uKeUrH/8n0GoxqFfMhI9I2g88KVqRRO9AuIb7nA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UX0hpgMQWJfj3cKfkTdc84l9ix6ruaIGCFOOmtimVmsYvfI6+172+8oHsaPzdU0qIMvsR0XT7heZHhbDHTp/iJKnwdNz7NFjYRTYwJEgLCZyeLHXaFnCouWnuBRdJlJKc+Wo74jyBn1MSat3jQIJ1TYkffRhnYw6YWbiO72UEg2r3d5KoR55VXtq/ZI3WZT5HvPtYCc0garWz5i+ekTlstLzIfNwkvmjpU7BJqgFVJ5oPCrsyCTMFVVZ0tMw/1F03xzBNrZAivH/YNzFnGChPpqC5+yMFBBI9ML5GW6K3hX0hnIxctymdp32gzbbK1B4S57KqNMxJb/09ZpwdC7g5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dN6C32ff8z2xFn
	for <linux-aspeed@lists.ozlabs.org>; Fri, 05 Dec 2025 20:53:35 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 5 Dec
 2025 17:53:16 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Dec 2025 17:53:16 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 5 Dec 2025 17:53:18 +0800
Subject: [PATCH net-next v5 4/4] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
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
Content-Transfer-Encoding: 8bit
Message-ID: <20251205-rgmii_delay_2600-v5-4-bd2820ad3da7@aspeedtech.com>
References: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
In-Reply-To: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764928395; l=1846;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=YdhWtldgK+x4gz0hMpUXUNmL81whKPQJ/baoTpGSTTk=;
 b=sCc+O2uTD/qznlMODSf1TxSgDtU9PjhpDifIJ7Q88EGK7dkP2gvjivROwE/oZFNjuUtHbscBm
 pUOBS2ZQhXqASYAqoWbBUj94QfeAKh5A+cvqnMGAxv0RCVdqBiUIk3y
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

This change sets the rx-internal-delay-ps and tx-internal-delay-ps
properties to control the RGMII signal delay.
The phy-mode for MAC0–MAC3 is updated to "rgmii-id" to enable TX/RX
internal delay on the PHY and disable the corresponding delay
on the MAC.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
index de83c0eb1d6e..f8f0d5c98514 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
@@ -123,42 +123,54 @@ ethphy3: ethernet-phy@0 {
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
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy2>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii3_default>;
+
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
 };
 
 &mac3 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy3>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii4_default>;
+
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
 };
 
 &emmc_controller {

-- 
2.34.1


