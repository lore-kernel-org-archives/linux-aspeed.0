Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680F606A891
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=erGcS59I
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPzCc2PYJz3bX3;
	Thu, 12 Nov 2026 09:46:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.105.4.254 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794391448;
	cv=pass; b=ZKkPwmj2wE5R1teDMhAonTCk6n3gGQWkST9b8gihP2UMJSG3SBqq/A4PO9k8Kbiyb2W+vAGUwrh11PowDmkxRx34YR3EcHYXKHE+4wnEwFeeYX+iF2TS3erJBx8MDfqOV/YznO2PQlvmbbVeCzVWnrXHm8341mXxgh+rtkBolw/2cd1FtimyhvXqOaSCnqxr8LHaKj3sq3HLjXVlqMb3kn1pg4WqvCrqTLcBIF+j4pJrEml3sbNsqRsjyFpVBunR8SPQFiUIg9ub4Bcsuw4y/09f6eKj2nCUWYrREtmF/RScSe46Qe26ejZnxMsWNzzph3utRfZqgUspUDb7XX/aGw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794391448; c=relaxed/relaxed;
	bh=LERhbt5Ytdc1ar8GQ07npP5kbNMAPKzHwGZphCtzgew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gn2CZlKFYkpIHHy9nlvML7ZU9Q+sK6jR9esu8AeBlnpocLU/bXSorbVZxUjBHBIsCzI9RE5Q3JeB2Y3dk62YcgYivlpxWMvk97KUnBZxCb4fbgaLl7xcC787yFHUA0Jg3ULpBt8OJvGg8oVdM6S4JhfoOBAjt1yw7HmKyTKTdryIiubt/obkmZayfUEIcxbv9hsnOS0O4UOL9CS5oC7WQ+XNsoIEHUdwKKp11SnfYe9NRSWMh8HtHW37HYU67lWHGb8cVmXj1iiZq0/v9bIon+sgP76CJrqs1Q/AZY7A93Ld8PMhKgh5nGArP6zhYjnsOvUWR0H087YD7QiL7DoJoQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=erGcS59I; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+eric.yang.wiwynn.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=erGcS59I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+eric.yang.wiwynn.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPfHq6TPJz2yDD
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 21:04:07 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 09FFD63C1E;
	Wed, 11 Nov 2026 10:04:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794391444;
	b=ENq6XChdbDLF1JaAvQwDGna7DJL5Xd8McgeltnnZqrz/Vxcw3ZAxSsDm+StvFsw/Kqlg
	 xw+621TPLXl0bX7IafGupbJUclk7URLqxBS6NsfQpCGXke3Cqq8b9URWmvYPZqQU3rDAa
	 8/5jRZ+kbxvuGGEmsYNkdlJtpqkWlyNCM9+CIyqmG1vHXgS0wsD+unYANFhtVfg3VF9YQ
	 7g6qvdTKRJILP7l8CQTcTPA4S1k0CY0fqNbYNaf7Ty89QXbAdNclFgsvDgtmrJYxz/U5D
	 RUFhyK4CGg1dEpx9CASC4V6tYyyS3tZABZnHPUa5ewOpLdwF+yJ8+/C+s8tuTiYPBTg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794391444;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=LERhbt5Ytdc1ar8GQ07npP5kbNMAPKzHwGZphCtzgew=;
	b=zVWRF5YLBahFkpHOy27bVTANsVO4rnFZwq/ehsDeZUHeCzQF04/D74AKjPad3DHYsLfY
	 8axNndbBHKiQVhZRuQshaAAeEXBY79Zpio2VRui7fDq/28JD1LmalfMdP2UcjmnyuS4QH
	 /tViVCrg6cmxHtK5LvGllTvQdHsOD1zaAhYzOD5f9puWszuCT5TIbuZnkpxkVrQzQNFWA
	 RYmtBaZWW+ck/g8wuTmlB3bvnxjsYwcNkRgq6nz6j1OazhJFj16bzVMJu+FU779Akun15
	 jHSqq/cOUjpPzBhwr5d1WjCVaEs0cljBtMP8VFnWuIX/fU+UPRDpgKPpTUrFJ/sugrw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 293001F00A0E;
	Wed, 11 Nov 2026 10:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794391444;
	bh=LERhbt5Ytdc1ar8GQ07npP5kbNMAPKzHwGZphCtzgew=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=erGcS59ItktfZQvpSga90WTUkr0BM3wtiQdlaPLLxwCA8YjSI5FDbY/8Bbmyp4A8q
	 muYzMDEj8teuRZURdrm3jZWCQvZVbiiUx7sM8q7wQ+ch/ud7KcTScVqyH4qG/dKEV3
	 O3p7t5nkttCuCfK9hBfyQjUDPu3z6NIIAkjYPNLIMI3Yw1/aooBuzH0kLZjByhSEZa
	 qhF5bEscz+b9vDdZjNp4nzeQG7eTkYVgbT1ZELgiWBm/8VWb1qrycnuZq5LS+FVY1w
	 WPggkOwMxOX45Mh1nJjSYD4T0kBlJdX/feSBv/ASdC9nzeaZwBC2brnY50V1AeR10z
	 Dsisy3ovVBxEg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 714EE48F1A;
	Wed, 11 Nov 2026 10:04:03 +0000 (UTC)
From: Eric Yang via B4 Relay <devnull+eric.yang.wiwynn.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 10:04:03 +0000
Subject: [PATCH v2] ARM: dts: aspeed: yosemite4: Remove Floating Falls
 board nodes
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-yv4-remove-ff-nodes-v2-1-aab5516c4305@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJI99GoC/22NywrCMBBFf6XM2pEkfYS68j+ki9hM2gHbSCLBU
 vLvxoI7l+fAPXeHSIEpwqXaIVDiyH4toE4VjLNZJ0K2hUEJ1UkpatxSg4EWnwidw9VbitiTElI
 0VtWdgrJ8BnL8Pqq3ofDM8eXDdpwk+bW/Xvu3lyRKNEYLbfpW67u+Tovhx3n0Cww55w+UQAn4t
 gAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, patrick@stwcx.xyz
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Sean He <sean.he.wiwynn@gmail.com>, Eric Yang <eric.yang.wiwynn@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794391442; l=4734;
 i=eric.yang.wiwynn@gmail.com; s=20260911; h=from:subject:message-id;
 bh=jDtTAj/Xi/uCMH8VnoQE52JIB7Rtfet3e3fs7uQ9GG0=;
 b=6j7fFHyE16rD+I6wFBU7rNrZH/Pwk6/JFc/Y3u8ad9ZoOEw7fAPq7vrc5Bz0zsEb6/Y5QpAIa
 1QFhsb/whLGBRd3X59J73KJHRCK+S8p23PaaS/yGQggi07DZxhbFqCW
X-Developer-Key: i=eric.yang.wiwynn@gmail.com; a=ed25519;
 pk=XYQiwgPZNUCt1JCbsO7zX8ODEiRKocz7fYwt+aWnXBs=
X-Endpoint-Received: by B4 Relay for eric.yang.wiwynn@gmail.com/20260911
 with auth_id=1023
X-Original-From: Eric Yang <eric.yang.wiwynn@gmail.com>
Reply-To: eric.yang.wiwynn@gmail.com
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sean He <sean.he.wiwynn@gmail.com>

The Floating Falls (FF) board connects to the Sentinel Dome through a
connector and carries a PCA9537 GPIO expander at address 0x49 and a FRU
EEPROM at address 0x50 on each slot I2C bus. No system currently in use
has an FF board, and its connector on the Sentinel Dome is not populated,
so these addresses never acknowledge: the pca953x driver fails to probe
the eight PCA9537 nodes on every boot and the at24 driver does not bind
to the eight EEPROM nodes. Remove the nodes so that the devicetree
matches the actual hardware.

Signed-off-by: Sean He <sean.he.wiwynn@gmail.com>
Signed-off-by: Eric Yang <eric.yang.wiwynn@gmail.com>
---
The changelog was drafted with an AI assistant (Claude Code) and
reviewed by the submitter.
---
Changes in v2:
- Reworded the commit message: the FF board is a separate board, no
  system in use has it, and its connector is not populated
- Dropped the verification paragraph
- Link to v1: https://lore.kernel.org/r/20261105-yv4-remove-ff-nodes-v1-1-aa707a9577b7@gmail.com
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts   | 96 ----------------------
 1 file changed, 96 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index e4172be84..4c7c96ce4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -604,18 +604,6 @@ imux16: i2c@0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			gpio@49 {
-				compatible = "nxp,pca9537";
-				reg = <0x49>;
-				gpio-controller;
-				#gpio-cells = <2>;
-			};
-
-			eeprom@50 {
-				compatible = "atmel,24c128";
-				reg = <0x50>;
-			};
-
 			eeprom@51 {
 				compatible = "atmel,24c128";
 				reg = <0x51>;
@@ -631,18 +619,6 @@ imux17: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			gpio@49 {
-				compatible = "nxp,pca9537";
-				reg = <0x49>;
-				gpio-controller;
-				#gpio-cells = <2>;
-			};
-
-			eeprom@50 {
-				compatible = "atmel,24c128";
-				reg = <0x50>;
-			};
-
 			eeprom@51 {
 				compatible = "atmel,24c128";
 				reg = <0x51>;
@@ -658,18 +634,6 @@ imux18: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			gpio@49 {
-				compatible = "nxp,pca9537";
-				reg = <0x49>;
-				gpio-controller;
-				#gpio-cells = <2>;
-			};
-
-			eeprom@50 {
-				compatible = "atmel,24c128";
-				reg = <0x50>;
-			};
-
 			eeprom@51 {
 				compatible = "atmel,24c128";
 				reg = <0x51>;
@@ -685,18 +649,6 @@ imux19: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			gpio@49 {
-				compatible = "nxp,pca9537";
-				reg = <0x49>;
-				gpio-controller;
-				#gpio-cells = <2>;
-			};
-
-			eeprom@50 {
-				compatible = "atmel,24c128";
-				reg = <0x50>;
-			};
-
 			eeprom@51 {
 				compatible = "atmel,24c128";
 				reg = <0x51>;
@@ -726,18 +678,6 @@ imux20: i2c@0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			gpio@49 {
-				compatible = "nxp,pca9537";
-				reg = <0x49>;
-				gpio-controller;
-				#gpio-cells = <2>;
-			};
-
-			eeprom@50 {
-				compatible = "atmel,24c128";
-				reg = <0x50>;
-			};
-
 			eeprom@51 {
 				compatible = "atmel,24c128";
 				reg = <0x51>;
@@ -753,18 +693,6 @@ imux21: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			gpio@49 {
-				compatible = "nxp,pca9537";
-				reg = <0x49>;
-				gpio-controller;
-				#gpio-cells = <2>;
-			};
-
-			eeprom@50 {
-				compatible = "atmel,24c128";
-				reg = <0x50>;
-			};
-
 			eeprom@51 {
 				compatible = "atmel,24c128";
 				reg = <0x51>;
@@ -780,18 +708,6 @@ imux22: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			gpio@49 {
-				compatible = "nxp,pca9537";
-				reg = <0x49>;
-				gpio-controller;
-				#gpio-cells = <2>;
-			};
-
-			eeprom@50 {
-				compatible = "atmel,24c128";
-				reg = <0x50>;
-			};
-
 			eeprom@51 {
 				compatible = "atmel,24c128";
 				reg = <0x51>;
@@ -807,18 +723,6 @@ imux23: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			gpio@49 {
-				compatible = "nxp,pca9537";
-				reg = <0x49>;
-				gpio-controller;
-				#gpio-cells = <2>;
-			};
-
-			eeprom@50 {
-				compatible = "atmel,24c128";
-				reg = <0x50>;
-			};
-
 			eeprom@51 {
 				compatible = "atmel,24c128";
 				reg = <0x51>;

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-yv4-remove-ff-nodes-9e20104d2362

Best regards,
-- 
Eric Yang <eric.yang.wiwynn@gmail.com>



