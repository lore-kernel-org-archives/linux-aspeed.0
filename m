Return-Path: <linux-aspeed+bounces-1868-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24326C87FD3
	for <linux-aspeed@archiver.kernel.org>; Thu, 31 Jul 2025 22:12:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btNcX66fxz2yGY;
	Fri,  1 Aug 2025 08:12:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753999964;
	cv=none; b=YWkVJm6dC5bHsbmhFX2HkYcZbhMMT0SgdrllDFw/IIY2KXL+OdKil/Hz1KCHxs1xJTAvegHIdziYU3Yf242D6M09x2x/wTKW3+qPb+ioyVTnWEuP5SXQhil31j43hfDGv87d9ZCxSkWzx6GT5Oms26GgjFf7WMx0GUP+0rBTuec9+s1PYawigcJsFAUkFIJHagJA9UCXey1/aD5e135P+YZ7pEsVsa/0yjsa521NnQXwxVxuyS2WKMSJpl9kOVYTiWLMBY4ImvVTaz6zLm93BACJ1NHFcOiZrGCQufOZINLGKz/fPM1Uo6BNhDDEsmACsT1EZmNk8KPDghlt3AXabw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753999964; c=relaxed/relaxed;
	bh=LNB/USS/uG0h39FDRpJoXVY7f/FrpKXXBu/8vBC1B2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ivN+FAzdlZMDjxTSjLjzxaxNDuzewLieO+tMnD5ZwGaI2FmquWfoaox3NOQ3n19V0+xCXq5rIG6zjTKRSp9RRdDEDK3kCqyC0IBoXDISOe9HqWel1evKIzrooF4iLstN26Q2tD6E26BcELHWzOCmKF2RyVZpokzTck990zCwA4UVDNmMrYCY1fcvEossxQZh+yvTiFj9pj5HHTIhxOiJBcNVMIdRyT2k9QTNhP3xDPXa0QFk/guqzrNpU18Y2nzFtnuVpC094xHJTu+hZcMzEiMOjmMCE6fWOdxDz4hiCtSlbxigUSNe04ruM7DjG1m4m3gG44PHgb6P4c682s9/PA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z+a4eReZ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z+a4eReZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btNcW3FcMz2y06;
	Fri,  1 Aug 2025 08:12:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BDAF3462CB;
	Thu, 31 Jul 2025 22:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDCAC4CEF4;
	Thu, 31 Jul 2025 22:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999961;
	bh=iCHNz13YFPJI2rv/3E+irLxUkOjyMiI3w+ZxRLbSXwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z+a4eReZzye57rk5zFrxJ5GDtFDgGuQS/b9abZkgO+BdyRHsuYPzE3WLL+dcYEgru
	 j94N2eV/OcsgxYGafKlFM8lOU3JadX0QQEkZiuWyE6lgUeZ1+bOeGeEmbNxBMt0CVt
	 uwmxI8ja/wfpgU9w4/Es+PrIBob98dsT/GF9BSZGI3zACQ8psN6q0fwQ+SUedklnQX
	 Gf2iafV3MT9EgGbciiO9e2EaDtdOBQ+7KjMnHg7y9TxeN0WLxtoJUSS+TgJT4xmAf9
	 +bpMzIsYhbggtOZf4FpksBsDiXD0p7C8FhGuc8aYO/f1w1fpaXkj+UCgMbBdsUwu4n
	 eWSjQ+BzkpLMg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 31 Jul 2025 17:12:19 -0500
Subject: [PATCH 2/6] ARM: dts: aspeed: Drop "fsi-master" compatibles
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
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-dt-fsi-cleanups-v1-2-e7b695a29fc3@kernel.org>
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org
X-Mailer: b4 0.15-dev

The "fsi-master" compatible has been used inconsistently on FSI masters.
It doesn't have any real use or meaning, so it's easier to drop it
everywhere than add it where missing. It is also not documented by any
schemas (only .txt bindings).

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts     | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts      | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts      | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts    | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts     | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts       | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts       | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi                 | 4 ++--
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
index f42254ba6aeb..79c6919b3570 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
@@ -54,7 +54,7 @@ video_engine_memory: jpegbuffer {
 	};
 
 	fsi: gpio-fsi {
-		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
+		compatible = "aspeed,ast2500-cf-fsi-master";
 		#address-cells = <2>;
 		#size-cells = <0>;
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
index 370738572a55..87acbfc0a1b7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
@@ -63,7 +63,7 @@ sys_err {
 	};
 
 	fsi: gpio-fsi {
-		compatible = "fsi-master-gpio", "fsi-master";
+		compatible = "fsi-master-gpio";
 		#address-cells = <2>;
 		#size-cells = <0>;
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts
index 31ff19ef87a0..6c8b966ffccc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts
@@ -165,7 +165,7 @@ fan4 {
 	};
 
 	fsi: gpio-fsi {
-		compatible = "fsi-master-gpio", "fsi-master";
+		compatible = "fsi-master-gpio";
 		#address-cells = <2>;
 		#size-cells = <0>;
 		no-gpio-delays;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
index e5b8d07e7622..1b7c25e307bc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
@@ -77,7 +77,7 @@ attention {
 	};
 
 	fsi: gpio-fsi {
-		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
+		compatible = "aspeed,ast2500-cf-fsi-master";
 		#address-cells = <2>;
 		#size-cells = <0>;
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
index 45631b47a7b3..c7aa14034dc0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
@@ -55,7 +55,7 @@ identify {
 	};
 
 	fsi: gpio-fsi {
-		compatible = "aspeed,ast2400-cf-fsi-master", "fsi-master";
+		compatible = "aspeed,ast2400-cf-fsi-master";
 		#address-cells = <2>;
 		#size-cells = <0>;
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
index 2180fa9b6f24..3c03204869e7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
@@ -68,7 +68,7 @@ power {
 	};
 
 	fsi: gpio-fsi {
-		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
+		compatible = "aspeed,ast2500-cf-fsi-master";
 		#address-cells = <2>;
 		#size-cells = <0>;
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
index a0e8c97e944a..39d0fe46fd9e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
@@ -200,7 +200,7 @@ rear-id {
 	};
 
 	fsi: gpio-fsi {
-		compatible = "fsi-master-gpio", "fsi-master";
+		compatible = "fsi-master-gpio";
 		#address-cells = <2>;
 		#size-cells = <0>;
 		no-gpio-delays;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
index 8b1e82c8cdfe..89907b628b65 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
@@ -173,7 +173,7 @@ power-button {
 	};
 
 	fsi: gpio-fsi {
-		compatible = "fsi-master-gpio", "fsi-master";
+		compatible = "fsi-master-gpio";
 		#address-cells = <2>;
 		#size-cells = <0>;
 		no-gpio-delays;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
index 9904f0a58cfa..9b49b0aa8b35 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
@@ -96,7 +96,7 @@ hdd_fault {
 	};
 
 	fsi: gpio-fsi {
-		compatible = "fsi-master-gpio", "fsi-master";
+		compatible = "fsi-master-gpio";
 		#address-cells = <2>;
 		#size-cells = <0>;
 		no-gpio-delays;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..acdb6ae74b27 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -847,7 +847,7 @@ i2c: bus@1e78a000 {
 
 			fsim0: fsi@1e79b000 {
 				#interrupt-cells = <1>;
-				compatible = "aspeed,ast2600-fsi-master", "fsi-master";
+				compatible = "aspeed,ast2600-fsi-master";
 				reg = <0x1e79b000 0x94>;
 				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 				pinctrl-names = "default";
@@ -859,7 +859,7 @@ fsim0: fsi@1e79b000 {
 
 			fsim1: fsi@1e79b100 {
 				#interrupt-cells = <1>;
-				compatible = "aspeed,ast2600-fsi-master", "fsi-master";
+				compatible = "aspeed,ast2600-fsi-master";
 				reg = <0x1e79b100 0x94>;
 				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 				pinctrl-names = "default";

-- 
2.47.2


