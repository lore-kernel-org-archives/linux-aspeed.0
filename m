Return-Path: <linux-aspeed+bounces-1071-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A511C35FFA
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Mar 2025 16:50:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHvpC5vJnz2yrS;
	Thu, 20 Mar 2025 03:50:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742403011;
	cv=none; b=VK/08fzggvH2SuzHZ9Y1njx66dfQ0bIqcKab0kJcFjb6qnQqmd+W04hUgc1CUMvWw+7mbvEAIE6s0jJU8BCQbNeTPDUotNx5JA41JDc9lCFMhpo2Ufra1W+czDnuqSSzsgLLWLkATCUyjL2ze7pGySv8jyjs3jJ8wYA9SnyTrjLw2/IQKqg/BuIwVxa5P5hf7Zc5vlnFEbk439dV3nRjLnhlQTSO49RBNkO4uJMN/bLVtHJt6aUkwUIvLl+Lp19DjM6NmClLVa4ksWwGo0TcMoRbHTnhSxmS5OpkASpNlCAS+TSJN9H6c/vGqOQq2t5+9aiop+aPfJ3etEHwrngMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742403011; c=relaxed/relaxed;
	bh=2ngZTefyBGyxy77j50qn1xy3c/VWYHIJSa1eOUcrG18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXoEcMjfKqDDuMQyVkZp9hXkj9uOaF7wEay/ecInYX07lA9e9HCKyFuo3sPkWIqu5ihN9gDYlvfF/RQhR5xGor0tGZAThx6/VerWanNPd1VrNZab5AQsm3wcUi15DfEpvF21cX7gfefQ06JlZhQ29kOyZ5cO8z3Cv3Utw9p7x1UFyocrGRj0Yc9CuzNOkqTkNpe89zzuuzFWQm3ds+ULZd8zQQ3L/nCDvnmMkGA5bOmJ4enqlL3VkhfaLcVLlOatBHfCOAZNDuZGLEu7hZv10jcaZS9F/gLacuIft+/OeZV6AkQDmPI86Rr7MFzwvPyn5fk9ZieeD3PfjLgIf7tJeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WllrShUp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WllrShUp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHvpC1plNz2yqQ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 03:50:11 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso6968072a91.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Mar 2025 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742403010; x=1743007810; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ngZTefyBGyxy77j50qn1xy3c/VWYHIJSa1eOUcrG18=;
        b=WllrShUpYIeS+b6toeZrTF6p8YrnAgXiYV3B4CpsrYNPnUs316i3w0iKpL/6Yv7Oc0
         0z14fsJwLI8exZowAsQkLpLo7f7x0hsTvZaSZuH5fNDKTggINrzb5m68LB2FIbLrRSR4
         4i8m2ZnDVCi0teX3ONIYurc+Lg7iBg+F19KkgggnlLcDbzY3/7NYhij30iJFF8GxLPyo
         lUXtVMjCsx/sSjK3Ac+JPiCUgfocY9GLOel0wqeuUznAQGKfNSsOIKxxUUlPiYCVS3bQ
         iTA2v1RyA94CwiME0yLdfkb7Crn15sHIwUgV49W7aEsFuWXvyJVXhbEjKpVwsOQh8DfO
         tjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403010; x=1743007810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ngZTefyBGyxy77j50qn1xy3c/VWYHIJSa1eOUcrG18=;
        b=XRRv10iaectsHwIY4VtEkc2X6OFIE/u4IM11DCtexzdovHT0bFGnEVLicp+N8gVEg6
         gaUGgFLnvTbdlzEkQz1tRKO9M2fXN+ob7icwu0l2Je7z7AM/ZEbe6X6fUu4DT7LAslEd
         M/tvQJYqB5+IT9aPFZ75ZzNL2Tpcn6GZxXZDhAcQpvSMxhPCtcWFBLgs9+pdTxYPZUW1
         cr0mcyEgR8oLnn32JlLtsLzZyIw9//OzP928lwd0kumYUVHZQn3TYcVFek9916M/1m0R
         oSWES7cHabEsHyMikgpp7uJdJF+SGl70U3ZUS2SahtQwkB4Nd0hvIMQ944O5lKxd/4Vf
         RvEg==
X-Forwarded-Encrypted: i=1; AJvYcCXXV+sYDHK5D3AcuDaAIwii2WcVzuJ/c3hx/iTtPn6YR6D8o51Nm0AO6Zkc1yNRvRxxdIE4uaZpYw1KvT0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YysppfIaiAKpANx7WlkqD+OJdqLv4Zep+YMACCpSy87AMFZFRhV
	UBSd5gHoQm5DgnyeDHt2VOSmBTs3nWS/sBr3DG7XdvfAJH02XkvW
X-Gm-Gg: ASbGncvUehul/uF0Pppwj2a/baF/CZCvRFYcRoL7WmTuw3cAcY2Y+1FAdToTkf2uJzj
	8TtUoeG6YfAG0JEgav3yu5iAfr578MVz5rJRxuqCu1EbfUtIV0z8gZCKiQ2lrvQy5G7umvvQkMs
	pSjQSdczRfXiAGnyMp8xzjiHA68tBOuEY41pZ6tLBZj62vDH1QEfOfQx/WnmpBHhIKQy00p/QUH
	hnCmjhkpaZAqSM/Hkh5MN5mFfHK+oNfGhoAFEL8IYyIg/dOY+sfn/U+dkQVWo+d59+yrJeuxhWJ
	UPELXsEJ+e9f71pey43ki6muZ4ZVqkNJnh72aw1GqFqnC/kDog0X6azS9QpqCQakhxj+q/AGsoK
	Hcgk0qAVH9kgZfdAKQBnt5g==
X-Google-Smtp-Source: AGHT+IFGwL1CO1u75jugTjFaP80dxgbnUNCsFmdXJEhQH78p4+pXb4ZaZeDBowc1bD7HnapyTqrUtg==
X-Received: by 2002:a17:90b:1f8d:b0:2fe:e0a9:49d4 with SMTP id 98e67ed59e1d1-301bde5c92fmr5660572a91.2.1742403009662;
        Wed, 19 Mar 2025 09:50:09 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:50:09 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:28 +0800
Subject: [PATCH v4 7/8] ARM: dts: aspeed: catalina: Remove INA238 and
 INA230 nodes
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
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-7-7c34b8139014@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=2136;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=VwzUdaWLbo+jZAMlNm4WzSN7aYJ6nvuUMBx/RwUbPbs=;
 b=1PduDxVu6+2Hiajen7lyNzA2t/FUX66kkW39JkHz63PwJ6LEGPels3iXGsQqpTf6xSzmpoQo5
 dl6tas3CgarAn6iRvsJtEz9rFVlpmEKtZZjQMzQLy4qMpn7KMHhZtKO
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Remove INA238 and INA230 power sensor nodes from the device tree (DTS) due
to incompatibility with the second-source ISL28022, which shares the same
I2C address.

Move the driver probe to userspace to handle sensor dynamically.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 45 ----------------------
 1 file changed, 45 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index fb4b236d36c0..573701bb7fee 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -304,27 +304,6 @@ i2c30mux0ch7: i2c@7 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <7>;
-
-					power-sensor@40 {
-						compatible = "ti,ina230";
-						reg = <0x40>;
-						shunt-resistor = <2000>;
-					};
-					power-sensor@41 {
-						compatible = "ti,ina230";
-						reg = <0x41>;
-						shunt-resistor = <2000>;
-					};
-					power-sensor@44 {
-						compatible = "ti,ina230";
-						reg = <0x44>;
-						shunt-resistor = <2000>;
-					};
-					power-sensor@45 {
-						compatible = "ti,ina230";
-						reg = <0x45>;
-						shunt-resistor = <2000>;
-					};
 				};
 			};
 		};
@@ -492,35 +471,11 @@ power-sensor@22 {
 				compatible = "mps,mp5990";
 				reg = <0x22>;
 			};
-			power-sensor@41 {
-				compatible = "ti,ina238";
-				reg = <0x41>;
-				shunt-resistor = <500>;
-			};
-			power-sensor@42 {
-				compatible = "ti,ina238";
-				reg = <0x42>;
-				shunt-resistor = <500>;
-			};
-			power-sensor@44 {
-				compatible = "ti,ina238";
-				reg = <0x44>;
-				shunt-resistor = <500>;
-			};
 		};
 		i2c1mux0ch1: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x1>;
-
-			power-sensor@41 {
-				compatible = "ti,ina238";
-				reg = <0x41>;
-			};
-			power-sensor@43 {
-				compatible = "ti,ina238";
-				reg = <0x43>;
-			};
 		};
 		i2c1mux0ch2: i2c@2 {
 			#address-cells = <1>;

-- 
2.31.1


