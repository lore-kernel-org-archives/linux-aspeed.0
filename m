Return-Path: <linux-aspeed+bounces-2027-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B4DCA0EFF
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Aug 2025 22:53:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7JWP3FFWz2xQ2;
	Fri, 22 Aug 2025 08:53:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755753973;
	cv=none; b=KZ/f7LjsYtKPoaJwKmRpmwxTWTX7ZlBOkwHH01lkltpghtMenF3LK4oJu63yZ+Lhi1A6BIx2umFJPN3pJxiJttq2F7tjg2gxp3VJE27w/nv2Ixjb/yBIg7FuNG0mnzTFnTfcv1cgfsc+Ok0UpHa9Q5bY1KqM4jLbfzCqFWiMaHagKgYrKjrTMtvb2vl+IRH+AfBSaIcVpfxA3fZxMsmWjjZSfYkBbcbcncSprMlPZuwFME0pOZvkgkPmm2plfaZLZOshraE+bvH3HeZyMsZt2UCkZyo8NjE7gg4TmltSCVAeoNCxHSZmoRc7UN8OBigSlUZrNYz7esmZ975I+1WBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755753973; c=relaxed/relaxed;
	bh=LiP5o2r6Mo1S84cq3k8Il687TcQ3VU1MlBiHABTYSqM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y4GNn28GHvcB+/pYqQQaHimNI/KUI450WiUmHqjmFZ0W1mWYe6GKVXEZ0yXwwlpX6XW0U4vID+pDtRzPDAz9PSHFDwhDRXKVnydU8Aq4tZfkDI//epvxuyRnCf/26tOqEEXBtQm4kGzXtT3WNmd2AkiHvKGypUurwy3u0NrcrXGcehqVQus9zMHfdz4OEswRAIwTf5L09dYNRxs3n1ih1/csLKY29nX51faxCjtWjlyjSspNYlTYSLMoiObrEZoZh36OJx0gwsxw2GSqH75E+xlF95K8w7PRivP9a+kIGG4qZjdNp+5P6U0U7GpPK8WHF0kAhNKMxRPRpazy/Tpbaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6sHS2DFwz2xPx
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Aug 2025 15:26:11 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 21 Aug
 2025 13:25:55 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 21 Aug 2025 13:25:55 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<howard_chiu@aspeedtech.com>, <arnd@arndb.de>, <andrew+netdev@lunn.ch>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<jacky_chou@aspeedtech.com>
Subject: [net] ARM: dts: aspeed: ast2600-evb: Correct phy-mode to rgmii-id
Date: Thu, 21 Aug 2025 13:25:55 +0800
Message-ID: <20250821052555.298860-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
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

According to the latest ethernet-controller.yaml.
Since there is no RGMII delay on AST2600 EVB, the phy-mode property of all
MACs change to "rgmii-id" mode.

Fixes: 4d338ee40ba8 ("ARM: dts: aspeed: ast2600-evb: Enable RX delay for MAC0/MAC1")
Fixes: 2ca5646b5c2f ("ARM: dts: aspeed: Add AST2600 and EVB")
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
index de83c0eb1d6e..c4964e536ed7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
@@ -123,7 +123,7 @@ ethphy3: ethernet-phy@0 {
 &mac0 {
 	status = "okay";
 
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
 
 	pinctrl-names = "default";
@@ -134,7 +134,7 @@ &mac0 {
 &mac1 {
 	status = "okay";
 
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy1>;
 
 	pinctrl-names = "default";
@@ -144,7 +144,7 @@ &mac1 {
 &mac2 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy2>;
 
 	pinctrl-names = "default";
@@ -154,7 +154,7 @@ &mac2 {
 &mac3 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy3>;
 
 	pinctrl-names = "default";
-- 
2.34.1


