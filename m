Return-Path: <linux-aspeed+bounces-1087-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F61C35FFF
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Mar 2025 15:25:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJTsT3247z3055;
	Fri, 21 Mar 2025 02:25:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742484297;
	cv=none; b=SMfVNjDp9A3l4ChpRq3uRDNibtw0WHrq3LDGHeCdaGBodb4gwcVLqVGq5FXEHtzfDXaMv8F3thEwCh/XfjQFKPFnbhDIARnTjKoASFkJ/x+2UMTs1q7/8C5d+5cor88sm4i+nBSDVxu8U8ZC7zS6FEvnTC6BE2lE8SHerv4KlJg93Omm459A1G5EeTXMZ+kqfoP8XMijPyDE/QTKqgjKVvmu8Q4d69UVohNYSBAvk8XHNq4zizewg906xIs2+Bp87lc/L+cCm3z3DkeEFvqslZzQyZUnuKb3gYTjRfp+Wjj124CqAqVP2YR2a0xPmlBkVggEzr/FR/VmMu64SDbVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742484297; c=relaxed/relaxed;
	bh=778YCnhGu8OwS5VD6l1aN21sioD9+bOBBeqngUJxkTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3QMGKHJ8v088HIuAkr0e31HxI5hTP/c5V4XzOuZhjdM6AeUS5cwPU04PLWRngDqLCYydTWD8RkucFYjeNl3Sn9joWyuzn3ZszECSkXBMBodnSJklKNGgVscnYLSrLwrJa4O1Z55afTAjxjkT2ZAtm9web2i6vTQ//miSJ6DNvkO8Y0pcKxiox2pNcnVOX/DCLzaoz8PWf2v5SBl4gjYF0KOeCv0AEfnvw62KAAAxFTDebfTo5fxTkQ8bGrZfv2xeAHxsKq+ep9nfscvjbE6KkM4oD3Rj06SpEBnZey2+JffPv+fV6SM+1y8QUbDpZFrd5E8p5G92mdkMKc31YKJDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HBjX4t4R; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HBjX4t4R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJTsP1SMJz2y8p
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 02:24:57 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2235189adaeso18919655ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484295; x=1743089095; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=778YCnhGu8OwS5VD6l1aN21sioD9+bOBBeqngUJxkTg=;
        b=HBjX4t4R196PrLc0U3PGlEj7IKHmIYmnamUTDR9YRQ+bkzKk0TkHkyjXT8fYBY5Mhe
         I+HMRSojZHNTHgjvnIPQVa3dtWnf8Mn0WL9wVUHDZZo6JmT9J0ZqpjWWGQhGsqfIUbm6
         K0BjK8Cz4NjCHvep9AkBw06Tfgtr/yVniSEeAYhe3BmBY0J6UQQFGpQsrRoXBwjhrWFC
         8LwX4SlLV/vD8sm1+LvohpdIsJun3K/x1go30R7czU7JWNAJeQHOoCVhARhjbuLChOqI
         sb6Xs1VDSo5n44GgHwmBk4BWEMUaxSv7vBeDRJHpC5ktq8skV1M/GmYcDmV70/AETjpe
         RfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484295; x=1743089095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=778YCnhGu8OwS5VD6l1aN21sioD9+bOBBeqngUJxkTg=;
        b=trwfcF19An3yHciwFmyAskniUDnZDA0P510Y/bvhg4cljcuJoVkJj4ChJzbLuWtYOi
         pUNN4dA8/lUBZDoYaiQiHRP17yLLX2RRa6disEjSexwN0hdTmKjO/sp5EpN3vogXeb6Z
         KXOxP+sE+yEi8z5JrlF1IQH+NLpt5HstukOwOYPVOCIB3gpZ7RLuhLBqkFtU+5lgn8b8
         TmRsAhjKEZT26cI1z+UOvYz9lKzKjYXX8S2gsEckNMdCljZZvsS3VTpR17JW+9kxSCxe
         Yu1lKBCbDtkF8qZ5nEzPAzQbBiJCdCGWEvmWacnRUkGPjblcCVfiFK8BkhdkX1dVHZ1K
         D1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBX94Bhc75kGna89OGOEQwVaDet3PFRpV7yC/jUxohYzELYr33oZ206MKCyGZiYsIB46Ak4LGgGV0d9eY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyIJMxuGNX6ToUVxhwOGYGxxYB8NxyN9wD1URVbdvYi+iYwJPya
	jeTpediFAZiyUBfCzsjvARHGhJdKWqkvggy4ZISlFFJQRnmap7Zb
X-Gm-Gg: ASbGnctgNETVTWVcdgAO7KbjV5k0xdU+5QxULqq2UMWPI3+ZcMmt3xWynhpPPjz9IAp
	mw1dueOE8AaHSwI4JUj/IZiYEAC4dbzW4iQPHUKr7disFM3XnrfRGvZja+y5lt4OL9DM8cFKNZU
	lwJq3NTAwNf6Hu4U6A+aCCgHghZ7cNsQ5vpzqzdAFPPyj+1jY+cIbdo+aqCsYGrldX0BVYCiX3g
	Kyx8LGnLscmyP1PXUYNeD5U2qyZ2kFJh+wfj5V48M6+99UGWer6Sl8uB41KHMFQsWMDyU+gVPpf
	Gop4Fr4swmW8gnBFXi0PoonHUbDtg6PuXF3Embz9bj4DKWm34PQZx5K9zNrDrcATehBdGasUcF1
	1GCw+upJRjaLuAWvp1jzfIQ==
X-Google-Smtp-Source: AGHT+IEm0o3IjdN4CK7bI1ZR5Cl6pbpHzpKB84eZ6aOsv2wGsYmuyJSpIXKgRxVZphiibOVU45xSMQ==
X-Received: by 2002:a17:903:228d:b0:220:ff82:1c60 with SMTP id d9443c01a7336-2265e6d467bmr56146505ad.14.1742484295352;
        Thu, 20 Mar 2025 08:24:55 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:54 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:22:00 +0800
Subject: [PATCH v5 10/10] ARM: dts: aspeed: catalina: Enable MCTP support
 for NIC management
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-10-e161be6583a7@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=1803;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=mctbch+3SZnEdii4zFZGF0Iv2O1sUwEaKoFRoL6RcjM=;
 b=sqz6o+Uq8neZCbmc+XIXb5EqpCCu/Sv7ukNsWuZdglpzn1ESmULH+w516OO76HCLaZ4morgBT
 FpcXpZ2i6XdARxIH0ltRokrlXGjzJ9Dyv/tnxJ3kxTdAhSEYff8vmD+
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add the `mctp-controller` property and MCTP nodes to enable support for
backend NIC management via PLDM over MCTP.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 653afacc7af4..6eb6c5889113 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -186,18 +186,23 @@ flash@1 {
 
 &i2c0 {
 	status = "okay";
+	multi-master;
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9546";
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 
 			// IOB0 NIC0 TEMP
 			temperature-sensor@1f {
@@ -214,6 +219,7 @@ i2c0mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 
 			// IOB0 NIC1 TEMP
 			temperature-sensor@1f {
@@ -305,12 +311,12 @@ i2c-mux@75 {
 		reg = <0x75>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 
 			// IOB1 NIC0 TEMP
 			temperature-sensor@1f {
@@ -327,6 +333,7 @@ i2c0mux3ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 
 			// IOB1 NIC1 TEMP
 			temperature-sensor@1f {

-- 
2.31.1


