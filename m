Return-Path: <linux-aspeed+bounces-1086-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BCCC35FFF
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Mar 2025 15:24:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJTsM4Z1gz2yrD;
	Fri, 21 Mar 2025 02:24:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742484295;
	cv=none; b=Gix1u/MuoL3KlEoQnEkt5PiXVN1UPr/2GES0STGMfdzMY1JsIVhSu8Un6BZOyd0UNjlIw5D6oPKaACf5cIUNxYGEegoc0iDf72Q4MN/7lolUaRv0Zkvqi5gnEdb+BST/Y8NH3LU9fIVVADha5xzUcs5fxUUkaUvHMo5ufIeSDPLgBw1mTy4NRahqgGzAEeQvKA1+SI2OkHQtnFaHeT0ssN+Trm0ErFgjO4Xz94+Y9DX02Qyq4qFge8HvlLjMKWuTU3U2Z952S6vcUxiojTqAlMoPxE5sy1oi2bkv4y67rIWdXCELTjFSLFWiHtu8Caiix5/xBnSoHTBSZtIJZ9GXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742484295; c=relaxed/relaxed;
	bh=Kb43eZp0bmT9XV4NUKBfJXCRO8FE0/kL/olt+g/XIUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MqiqkK63gajUjny3POznfJjWlY7XrK1+xro1zICNa1aJAFXTm+QoGQe363cNF4xSzIc1ZO9ZS8M8e6ZpOZ3lMJC6LQeulWRl+z4N9xrMiOrdFldw7zkxMwfPhAMcIejJJSePxKzhvswELbkM0YF+zJupPNSPavPH/HEivLveN4jDN1Hi+5FBCSb+AQf9rqNYEZwzPSQagYTqej0sjWcWwQJY5xLdUYDFpBXTsyxqVACfJ4duX6w+Fp0DYHdVm+bRgIEwzOJDXKCjbxhNr2jof5YMDr2Faux0XtOozBjrnsogbQzmetzWis03ItZ2ItlC+p7ZR1PNj2a+VKC61WbaYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=T12YCV8M; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=T12YCV8M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJTsM04X3z2y8p
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 02:24:54 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2241053582dso22775115ad.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484293; x=1743089093; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kb43eZp0bmT9XV4NUKBfJXCRO8FE0/kL/olt+g/XIUA=;
        b=T12YCV8MIpKS13oEug4emIjyZG4W2Vkz4teAYqP1FRHZMaebWxgLKIysD7fpKCBgt1
         JLE23fBdGoCosQghXQ3UyoPmpcDyjBwgjKOIXwKzyKMrDl8Coir8b1w+rf4Ry4iT2W1R
         mcQkKwCfOvPtH9cLdRDiwCoedNS/BGkt1WIVDNp4/ideNAmVBAWejTZnJbpit5C+tri3
         TbER6eWZKQIzTPjIFokS/Io142IetI9VW3ZWHN3s5V82D05FPjgUbc59N++Jzd5jq+vY
         9mB9cCuI0fJ/WCG2JbVoo5MKwOlyqKENXWRYHPMMnNKrWUR4xjDaBsL+gcZwZ3m0r1js
         svhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484293; x=1743089093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kb43eZp0bmT9XV4NUKBfJXCRO8FE0/kL/olt+g/XIUA=;
        b=mclExMpIjO2b4HBX+yifWBjhgxft5IeYj3SxS2uLLLhHfnyqpp6R9Q35427i/eZ9Cq
         AJgn+dYLcFm7IAHvnkKxZLJYyj+mayFFuOcFSafOP0qVvo1O+IXr48OcgTH4vmOh8rsQ
         FKjQg2liZAgDcy62Bmd6TcIk81e+ibqBgsMb8rz63D7CXCEnjj/0qTqqj2NgjbsD5nX8
         HXHDvK5Mlh5RP8XNZnXk0H9NrnvZMci673ZWRfJMYQ6j0D/hbzJ1T9XqTUnrwjV/3wEP
         70/PQiKXGkKQawWRH6/v3xe+ps5XnlUn6ujZ87gNQqKO8Q8oBYmBsRrYsWe8LEOikyhc
         5Paw==
X-Forwarded-Encrypted: i=1; AJvYcCV6+iGn2az0KaRQ50ID4Zs7Cv6UQ5bT5hqjJWBcLwXb+58xdW8x2qs9QgX3jjENYky2jyYErCYt65i+wkM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxeraJDGIRITjRuUOv3YdJQCPJLmBufDZCnxpZCJPG2MdBoi8ik
	mnyuFYyYzLkyTATR0qDoCnAz8UiWLar7OqBe31IYNy84BY7l3DpDdTPgqg==
X-Gm-Gg: ASbGncvQYCLXn4Hk5UgmFiVtPu71mDtoz2xX5bfHGS4LLF5y7iLrXtOYtLMpAKFClRG
	tcOhOH4/YQH4V6MrPPUh+mjM24D4GCUflzNCZIBQhwnVrhqIlsJWK6LNzE/eib6pG2Ia1CQwUbU
	DkCrT7GF8Vprqzpjpt2A7U0kRbERh7cCzdTUsyfij1HfW7Wm57GaswPTH/eSc6GDvTeLdVpKnQg
	P/dFj7Ahgj7i9/36tRSqJrQfmSjP4k/5rALQIefjwR+NUpKdb8zKgsNPirVn4T/e3mZmlounbMs
	FnYuzWCozpi11o4k7OYk8FuDb6DPlci2GpZt7dWwlmYC6uRv9nN5g3g5zJ7OuSkrBjCTbqTUxyD
	8LPLm1iR06PBSW8fYSXTcQxeJVHZLAP4V
X-Google-Smtp-Source: AGHT+IHE92AmQP6pSQe4X5Gxq1K0w/g80wdi5cdppZrIPKVLtb+T7vCPI1VmndKmWdZXwXBLIpl/jg==
X-Received: by 2002:a17:902:c40a:b0:21f:7a8b:d675 with SMTP id d9443c01a7336-2264981d956mr117086675ad.4.1742484292652;
        Thu, 20 Mar 2025 08:24:52 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:52 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:59 +0800
Subject: [PATCH v5 09/10] ARM: dts: aspeed: catalina: Update CBC FRU EEPROM
 I2C bus and address
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
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-9-e161be6583a7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=1195;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=8Sc7+TmNtcYLYM8RQCVTgjvfsStUP1z0J+a5AZtpYRA=;
 b=/KhOPweORghlVtVjwU/eucupg8Thf8Xswg+01HtHScRvBcJV0CZqRNHJSG6xuAj/O2DZIQnHJ
 rpNwnn+DS2/C6KpcDvLKNTwchNFSz2tpuQnjFoOO6ZxJd3a+vsSPb70
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Revise the I2C bus and address for the Cable Backplane Cartridge (CBC)
FRU EEPROM in the Catalina device tree.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index abf15d322605..653afacc7af4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -822,6 +822,12 @@ eeprom@50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
+
+	// Secondary CBC FRU EEPROM
+	eeprom@54 {
+		compatible = "atmel,24c02";
+		reg = <0x54>;
+	};
 };
 
 &i2c13 {
@@ -834,18 +840,12 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
-	// Left CBC FRU EEPROM
+	// Primary CBC FRU EEPROM
 	eeprom@54 {
 		compatible = "atmel,24c02";
 		reg = <0x54>;
 	};
 
-	// Right CBC FRU EEPROM
-	eeprom@55 {
-		compatible = "atmel,24c02";
-		reg = <0x55>;
-	};
-
 	// HMC FRU EEPROM
 	eeprom@57 {
 		compatible = "atmel,24c02";

-- 
2.31.1


