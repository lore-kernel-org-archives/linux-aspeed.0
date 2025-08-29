Return-Path: <linux-aspeed+bounces-2077-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381D0CA0FF0
	for <linux-aspeed@archiver.kernel.org>; Fri, 29 Aug 2025 21:13:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cD9wz4vFSz2yvv;
	Sat, 30 Aug 2025 07:13:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756502019;
	cv=none; b=eITZDhOMtHzOWhgKimA0fPaczr/m0EPYTpY+T+AZ0yHZkxhVmRR1Y2qcIlnGjr29MK7DVcLIc47m0aEeKnTP7C4EBERO/Z8yw+Jz72EivwUTogiR6BfahL0/Tm5KGHpYnKx3jphR4X9ES41zdy52ucjwtsN+9Im6lMqaKw3r4xLayPrEaBahig9KGWTKLgxw6JgsR/A0Ko+GhB1EU0A3zvkJWtqJlWlpIII+qviDyHRLFUpB+m7NWo6AMCiQDG8pCfp5XXRtgmQ2l9Md8pfSUtT2UPUk8ZZPy2TO5HHtISfo/xf8WnAYYREbnVmxuVvyR+2VrS4O9sYRd+vOoLSLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756502019; c=relaxed/relaxed;
	bh=jBRFXBOTZNtalyxQYje6lHR6qBaFS0kltKQZlJ6Krkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CJKSvCL2PYaeFbqDI/keSGJ4u2TjdRMUxy3r7BDCKx/8DxBk6Q9JrOo93JMuSxF5fDSMVUR6fQZ9Fgn1SkU1H2rRnO68v1wQhxGw452xNOD1s7/0P+1UGS7eNvhEopPLVRgP6R+zNjjE14S5G6Hm1PR8OxA4ckyJ8oZmCdPiXeGm5ERucIbQt1gPs2VglIDyvA+LD31QqVQqArjW0SdeGoGQ3VVtIiTC+y5vZW6eVw5UtuIna/1apoEuPlEhhNfQ/VxevsGs+5oEe9QQ2+d4bxKIoRUrnqlnvwfaVIqRNPNxDuFult4xdJeQmk90ayu3pf1YhaZXBiNrI0VkuadmcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t1XC+i7J; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t1XC+i7J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cD9wz0rbbz2yMw
	for <linux-aspeed@lists.ozlabs.org>; Sat, 30 Aug 2025 07:13:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 40E3F60142;
	Fri, 29 Aug 2025 21:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9429BC4CEF0;
	Fri, 29 Aug 2025 21:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756502017;
	bh=sbyw8T8JAdvdlkAq4zux1rD5z1Wak6PP9egfwjKNvFI=;
	h=From:To:Cc:Subject:Date:From;
	b=t1XC+i7JMTzBN6/YM6iXaXxS7ND02N38fa8g3j1r5h082lgjCMsr2HzDxexxBeJOm
	 jmMTeZcSldK/7MG4RwWhIiSweMqSNzncUGPerbH/X7m/kSwZNvPjtWs//EJG0oSdKX
	 rJ8p4XB3nx6rcRPvFH8Tf/AYy35sc7kE9cGob1NbMXN33Dl7O8eWgU9DTU9lFdwG5o
	 WCvmH7SowZYmgHQ6wk5CfvZmi6BZxJr/W1opkRFMeE3r22eiLsEkrUnM8tEp0Iut5V
	 ePbHt7lQzyusXkqHnfxgb0gXRKnffyBgWCTptVBtK4JBXQCwTFwzTShkA7pEzlUjGc
	 +KxTU45ry+h+A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: Drop syscon "reg-io-width" properties
Date: Fri, 29 Aug 2025 16:13:29 -0500
Message-ID: <20250829211330.1336274-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
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

The default width is 4 bytes for "syscon" devices, so "reg-io-width" is
redundant and can be dropped.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 1 -
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 2 --
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 2 --
 3 files changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
index 78c967812492..c3d4d916c69b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
@@ -356,7 +356,6 @@ vuart: serial@1e787000 {
 			lpc: lpc@1e789000 {
 				compatible = "aspeed,ast2400-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-				reg-io-width = <4>;
 
 				#address-cells = <1>;
 				#size-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 57a699a7c149..39500bdb4747 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -273,7 +273,6 @@ hace: crypto@1e6e3000 {
 			gfx: display@1e6e6000 {
 				compatible = "aspeed,ast2500-gfx", "syscon";
 				reg = <0x1e6e6000 0x1000>;
-				reg-io-width = <4>;
 				clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
 				resets = <&syscon ASPEED_RESET_CRT1>;
 				syscon = <&syscon>;
@@ -441,7 +440,6 @@ vuart: serial@1e787000 {
 			lpc: lpc@1e789000 {
 				compatible = "aspeed,ast2500-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-				reg-io-width = <4>;
 
 				#address-cells = <1>;
 				#size-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 61983feb2a4e..f8662c8ac089 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -382,7 +382,6 @@ rng: hwrng@1e6e2524 {
 			gfx: display@1e6e6000 {
 				compatible = "aspeed,ast2600-gfx", "syscon";
 				reg = <0x1e6e6000 0x1000>;
-				reg-io-width = <4>;
 				clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
 				resets = <&syscon ASPEED_RESET_GRAPHICS>;
 				syscon = <&syscon>;
@@ -572,7 +571,6 @@ peci0: peci-controller@1e78b000 {
 			lpc: lpc@1e789000 {
 				compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-				reg-io-width = <4>;
 
 				#address-cells = <1>;
 				#size-cells = <1>;
-- 
2.50.1


