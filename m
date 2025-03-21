Return-Path: <linux-aspeed+bounces-1107-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A04C35FF3
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Mar 2025 07:28:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJvFQ326tz30MR;
	Fri, 21 Mar 2025 18:28:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742542122;
	cv=none; b=ZorHHb3glteK0A8FrZaXGmn+qMRHOErFufTQpf5ElgF17DpbS9S2i33j1HB3vQjDvDuawNtq6OQb03H9voyjaK5TAtud66FKFKESubTT5wB+RxLsyBAFLu8ZebPGE60kK5WgQQ9AD0C4gt9kAinX/3AmcZz110SZfKUrQBlPgkC/GvdDY3evSzw7y/DRHAqiprdFj9s6bdrJB8JEo2Wd8i6FugwtT+tudiOr7FRh4Y9q4InezP0tNc7xJ5hyw9yHH2PN5bPjIXe5Rdc9zNsvQ164FLRu1rKxGxDLqDhv+/bvTdg+L3maTyDwZvgQliZCfGkxB6wB1bDcy28KLMs0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742542122; c=relaxed/relaxed;
	bh=BS/TmVUgFRyZOyjVnszJqpF/8S31xxnZs1Y2Qe+EyN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bp83T+0989jGKbKNsmqwioLG9c9/KWwmZWTTlGB11570TZCEMbeCTtYaEgwlMJbHGCs0tdF9CfYu77cnlsTRCQmuyZH1cVApMErprJ+kvVwE0cTPVONFgmdrnJZs+XUtDpG6PKgcmY/kjld8GpkT3kQYL4RpKRDuDBPlynJOB9KLW0UsT4F/lXNDD/gi+rmwtqQ9PTIw4u5SZpcFb/2bjx8+QNE2rd+QXJa0dEfJIUFaAQWx3hyOZluzVqT/9R0iUFLa6XvHGvE2i/xEeO2GaLsjq3nD9X4QmOUCOfYgrpWRHaIBXf4ES+z9Qg1WopcEo2XxhHo1GwOfAvcimhqa3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Iw1zwQKR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Iw1zwQKR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJvFP4qhVz2yrS
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 18:28:41 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-224100e9a5cso31321885ad.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 00:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542119; x=1743146919; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BS/TmVUgFRyZOyjVnszJqpF/8S31xxnZs1Y2Qe+EyN0=;
        b=Iw1zwQKR2T2fWqctX37WNSqhUr9OVJhDplVFf1GTGq3/ipN2BRk0CYWgRqQa1aW6tP
         J4+lJiaKx2nrmxXiLOOfxMoUHoPZaVnxK1DIWOrfhLfyN6boD9mPSyxZDpukl+ZgqLSP
         56YCr7DEqd0XxUVyrZz2l9HX03DYIi9pj+4O2RuVmtebktyoxi0Dx8IqmkQX3jr0kyVO
         tC9sfr/AEmFXes+/nlwjZzex4nRGDU922HtRvFU7oUHBtesHSnn37UbsO2KG6ivfzq97
         XKJRcRXl23hqD6iDk11ZzGDoDT9QzRUry+Cc5eX0FziYZmhmrz8C3ldphhe+KdU3+Xtt
         4A/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542119; x=1743146919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BS/TmVUgFRyZOyjVnszJqpF/8S31xxnZs1Y2Qe+EyN0=;
        b=X571GTwXUVrr5lAiWe9kSxCtfqptL1obtfXH61BbF8L7sw2q9U4HDZcwHoHQR0tmhX
         G9kkZ5quJcGZOQi4sAV00owvqMgO3I6UQbIK8QhlCofHRhlUZ6Cwng94YzHT8Tl4WSdX
         CwaFZ+CtE7KBfOc4+G090E/SPjUpj5qcJrqILxzCbeT7sSfUq4GzB7FjpXHjEjgFYE6I
         8vhKjZb9557Zt7+iSU/bWAeX/ApI5I3pUvZc4mbYfIHhPOf0wOGxz4Nsc17Qw6ItlR8u
         SqgEGYSg1w6CgNMy4z+V1Xk7txv8mXOW0u2BixkIjZyxlYgEIuS5ZlGveq2xWiG24YmQ
         0XjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMN6lcbApp612yO01BY1KBRWLWOkK+17DDmvdCaZ8M85E7iL1zP3lqj+HZOAf/Sd+r6O0b/6k32s593Bg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx7Rj6mTgWu358J/0ghYxhwTGZArD4mz3MD03tljkgvsPFsbUfU
	xCgEEHDdCcVOmlfSqeG2gEuO49wms/gLHVpqJukJLYHrv+TdGpY0
X-Gm-Gg: ASbGncvAJRKHxETj0baYIJpjUya7mF/sKr1lhRyPMcQ0O0g5k8Ymj0VyxbL39OJiYBh
	rV5dt02Jv0j6mVvpBv1iqtjZ83Z0RlvLAkcooIRN04Iw9FsufG1Gp1dZVWrEELtY4xQ0+EhBChG
	KKnYKQMk/gqDUgOfUubbuHVKCn8SkGgW3VkdQe0CBeU77RC3JAerU68OR5wMxU6Mx7U1K+Jhk1E
	SEY/p+Uy0q5zjLbt5hhyoBCSu+w3hTlZkaB+vZ+VoC1QQt2IvwJe9zI9UBljTAhQF+m6DTWF/NN
	ODaIOptxFMzk6Q6nJuD8hMu4Vs2498UnBwRDo0rU3rh+FXmt0F5gWLalC9Nxy9qzOh5Y0zRp/sb
	D4v/aD8SJGN1t9O4V7hnlHw==
X-Google-Smtp-Source: AGHT+IHTntVL00x9Ot2AtrftECNKQGtuavdLeqMD3j9ehPfSEF0bdNza6lVh0Gk1ZXq42/xU5C0Akw==
X-Received: by 2002:a17:902:c949:b0:220:da88:2009 with SMTP id d9443c01a7336-22780e23fcfmr29362215ad.45.1742542119351;
        Fri, 21 Mar 2025 00:28:39 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:39 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:06 +0800
Subject: [PATCH v6 05/10] ARM: dts: aspeed: catalina: Add second source fan
 controller support
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
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-5-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=2501;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=2rDyUX5mX4sDiO8XhZEFmbAdAa78bSLytJVw4UPc5d4=;
 b=m3Q7dfRD9bnw8tKiRxDF+GNGHdX4hLaO9nLnypaLt9IE/146J8937vtLCgJBp6r36hqN448Ol
 LT8oNDoehWPB1MJzmGWlPMUq96YhNi1gl7ixdFUCAY2DOz8Rsp3Ymvp
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the NCT7363 fan controllers on the second-source
Power Distribution Board (PDB).

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 792b739b1103..f0c8aca152e7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -467,6 +467,82 @@ i2c1mux0ch2: i2c@2 {
 			#size-cells = <0>;
 			reg = <0x2>;
 
+			fanctl2: fan-controller@1 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x01>;
+				#pwm-cells = <2>;
+
+				fan-9 {
+					pwms = <&fanctl2 0 40000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+				fan-11 {
+					pwms = <&fanctl2 0 40000>;
+					tach-ch = /bits/ 8 <0x0b>;
+				};
+				fan-10 {
+					pwms = <&fanctl2 4 40000>;
+					tach-ch = /bits/ 8 <0x0a>;
+				};
+				fan-13 {
+					pwms = <&fanctl2 4 40000>;
+					tach-ch = /bits/ 8 <0x0d>;
+				};
+				fan-15 {
+					pwms = <&fanctl2 6 40000>;
+					tach-ch = /bits/ 8 <0x0f>;
+				};
+				fan-1 {
+					pwms = <&fanctl2 6 40000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+				fan-0 {
+					pwms = <&fanctl2 10 40000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+				fan-3 {
+					pwms = <&fanctl2 10 40000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
+			fanctl3: fan-controller@2 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x02>;
+				#pwm-cells = <2>;
+
+				fan-9 {
+					pwms = <&fanctl3 0 40000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+				fan-11 {
+					pwms = <&fanctl3 0 40000>;
+					tach-ch = /bits/ 8 <0x0b>;
+				};
+				fan-10 {
+					pwms = <&fanctl3 4 40000>;
+					tach-ch = /bits/ 8 <0x0a>;
+				};
+				fan-13 {
+					pwms = <&fanctl3 4 40000>;
+					tach-ch = /bits/ 8 <0x0d>;
+				};
+				fan-15 {
+					pwms = <&fanctl3 6 40000>;
+					tach-ch = /bits/ 8 <0x0f>;
+				};
+				fan-1 {
+					pwms = <&fanctl3 6 40000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+				fan-0 {
+					pwms = <&fanctl3 10 40000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+				fan-3 {
+					pwms = <&fanctl3 10 40000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
 			fanctl0: fan-controller@21{
 				compatible = "maxim,max31790";
 				reg = <0x21>;

-- 
2.31.1


