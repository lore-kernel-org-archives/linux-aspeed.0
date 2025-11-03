Return-Path: <linux-aspeed+bounces-2713-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F3FCCFA07
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Nov 2025 07:39:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0NlW6sfpz3bdQ;
	Mon,  3 Nov 2025 18:39:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762155591;
	cv=none; b=eku8WyaTkz4UDWVqWlxVOChYTBwePPQtoVVAQE7R/7pTMJBXw1tM6F+bVSLbor74jzpn/hjG78ViKaEoLk1yCeUfgMP1peI+2uwdqX1NrpcePRaWtHEJgJLWLOkE1o4orwoK9a5RmEAYkJX2ta0duuQ4P9M8a4j38O9THScUJJ5HOh12zJ6MJdvMguCHdSi+0Ji/9xFCYi+2xMrIrTdlEzPHeY7oIlWWxvGiBSyMA3xnEdiMzUke99KWHAWyg4uBJ6rNDoazcJktjdZZ54EY9/BfQ6zeYar+hHx4DivMsL81zGvf3a2+PsvDcsN1mpamyn9kpt/i78hlzIN/f27kwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762155591; c=relaxed/relaxed;
	bh=JjraDVrwO5JouhKbl3sTaWV/r6DuodeCeJJumE175Z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=d16VitI43Hv7WJgu1vREznjVRGq4vJ83RWPsMntY6Vxf/xQN9aPw0JmnfhXbygp5w9hL4N92NIKrWrskArXt8E6ii4Tj+RKZekfPbN9Oxltf7db5buY/UvfJT9ndhfS8FItl0ma7lkr6Gt3h0gfQgdMXQogbRZ2z1tM/LFHUsuA2cA6HCvs4k7eVpo7WCuKSCNeiUzYrqG3jblflq2jh3HM3kaaTvk/kZkLcYppFBRfmkZGGl8EOxd/2yYCUgekii46H6L59jPj9P3sclRhTR5w/Kxx5WsKmYEcGPa8NpYA00jzLzGpWmrIcJ+cO2f/mx/8lYZRlcLEKjvC/KuD+aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0NlW38nJz30RN
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Nov 2025 18:39:51 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 15:39:31 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 15:39:31 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 3 Nov 2025 15:39:18 +0800
Subject: [PATCH net-next v3 3/4] ARM: dts: aspeed: ast2600-evb: Configure
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
Message-ID: <20251103-rgmii_delay_2600-v3-3-e2af2656f7d7@aspeedtech.com>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
In-Reply-To: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762155571; l=2271;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=D/U7aUTz6z/QHFHv3P0N4H6OuKsjsPLhGP+PcDHLlOU=;
 b=aMF3deI9LuSsvBeuBzv70jyP/ygPrXTHgvU9R6tQTQEv5H1ingpCn7Um9WdCwFE/iXlI9Sw8D
 GvFzrKhbJF/BqUffIFY/fMCs3fnswkVfVHPsXckcONiCFeSxguJbNav
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

This change sets the rx-internal-delay-ps and tx-internal-delay-ps
properties to control the RGMII signal delay.
The phy-mode for MAC0–MAC3 is updated to "rgmii-id" to enable TX/RX
internal delay on the PHY and disable the corresponding delay
on the MAC.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 28 +++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
index de83c0eb1d6e..a65568e637bd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
@@ -121,44 +121,64 @@ ethphy3: ethernet-phy@0 {
 };
 
 &mac0 {
+	compatible = "aspeed,ast2600-mac01", "aspeed,ast2600-mac", "faraday,ftgmac100";
 	status = "okay";
 
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii1_default>;
+
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
+	scu = <&syscon>;
 };
 
 
 &mac1 {
+	compatible = "aspeed,ast2600-mac01", "aspeed,ast2600-mac", "faraday,ftgmac100";
 	status = "okay";
 
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy1>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii2_default>;
+
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
+	scu = <&syscon>;
 };
 
 &mac2 {
+	compatible = "aspeed,ast2600-mac23", "aspeed,ast2600-mac", "faraday,ftgmac100";
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy2>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii3_default>;
+
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
+	scu = <&syscon>;
 };
 
 &mac3 {
+	compatible = "aspeed,ast2600-mac23", "aspeed,ast2600-mac", "faraday,ftgmac100";
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy3>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii4_default>;
+
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
+	scu = <&syscon>;
 };
 
 &emmc_controller {

-- 
2.34.1


