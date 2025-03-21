Return-Path: <linux-aspeed+bounces-1111-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895F1C35FF3
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Mar 2025 07:28:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJvFc1qgfz30Ns;
	Fri, 21 Mar 2025 18:28:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742542132;
	cv=none; b=e0H3ufXXAZ4PC7TOh7vhAB9xAkEnSMkYNz2oIZNc7ri2Ez2Vc1O66AsLE4OwmR2oMpnA541HttLgwN1cCqduYfgpUqO4QFAlW9nt1PKdEHm/A34fhi5ggWyLsWZ56as+MgbygFJnM5N6gE3Wgyzkfavh4AwmNHyTV9YA6m7UxXY1Jmf30JbTMjJtbaOjiMsPcVF/2ztOHeWqSTS1/xoulYf9M/jnEJ0WDoNiWA6uyMFowzo7CIZUg1/M6gLbbQzjEZY9iIXMeVjlKygxebWvyUHOLodhhOp7S3bz8QuuijnCAQ2bP8ogWuf1GieGOBrvqzKWIQogLshOPv66OXccPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742542132; c=relaxed/relaxed;
	bh=rjCNidD1nDVnXFrMlTY1ibBRmDZZuKdhhSQi5Z6zBTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FC/rVdIOmVzpu9WdBMM7VdBLKICtRz+IrRRj8QTEUPv8f5sVOeQJ9Vf10UlkhIt+008YjZhhr9wyrSXw4yb4JExRl1VJLzz5Ko/quy9JyYVWx/D/YXe0odznP5KeYwjxGHMZ2xF162IES4vKC6Lkg3NbxZwbIlM3kSzGPFMC8yzUxxNJ+tUjebgISgInXU1DydfhFMTXAApiiMBzzaRkjQPBf/advlS/ZHSQq9Kf0JaSLHYIgHNxbH06+mIfhj8a8LZQRPZuqvM4KT6JKUhK8I6jRkGqAqG/DldhmNK9mQwg9AhoKZFhTcQxDJ1LsKVeWGI0kY+Jq/6Nt9/JvprTzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gPsdaRwZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gPsdaRwZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJvFb4Mr4z2yrS
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 18:28:51 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2235189adaeso31197895ad.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542129; x=1743146929; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjCNidD1nDVnXFrMlTY1ibBRmDZZuKdhhSQi5Z6zBTI=;
        b=gPsdaRwZk30XJCgoWx39OtxKy75FQmJO6t1uPeOF20JjyfGgbnecSV4+zDs1Q/EqCf
         +oUlqdn2A3Pu8EefSqhVfaewspavok8IgXvkpwD4+BvYbmpOjKn8EORqbi/lVo5Ts2Gl
         HUiTDmR5EfDWQPff3TESeceMmFwOXRzKMGAprKve59QwDGHfjhxPddhDsIjbyvcNHH7v
         d94YDNJ43bPiVuOv/yc8IuYlsbrIRgCjpHHn6VPXh4ISSvXctN7g/kLyY9ZcaTfStjAL
         XbYXp0gYYFHwRpSWHbQUM3oK7zzzSEq4TReSPoHdP/fh+g9e1VcQNIRjqJ1x6OQsqi+X
         cluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542129; x=1743146929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjCNidD1nDVnXFrMlTY1ibBRmDZZuKdhhSQi5Z6zBTI=;
        b=JhybUApI/+/dCg8GXybz+Yn6x1E0n2+xc96hK+7zpKvIFqRwhbb27UDSMHhsZgcyyl
         vZknU5xTpfpkwNcsk378afVDTSWQsQYUInywhJl7bKkMxSQUDVgB7aMx6371vGKoFoJX
         KzJflKaWyYvJFi/Qj2bOrryz9qDc2jUnxvgsOb7PZqJuiwgeCwGytw1EnhSxmm+i0FF7
         RgKAimSPV4Icmnlqpk6Z6E6PC1BTdSDMtWHgyLxNJo3AF4HmO6GD7ZNTZq0ReG99YOJf
         CiTWrIgbzJOi9X/O6fOrEMVHIpYU/DGvgBfmFtkHh4x2810xOU0UFW9H+Yc6fyuTkSVk
         wfsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDM0xpuYddX+WK9bYLyoG3q+EnVQjiGvT6H6UC3HEnYSNVbQTNXJ6Za4+xWvoUL8t6LlYXrxIIU+lq0oA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzD6dCMXL+1LI0mEVHpcosdTxEtTWv95UKnwu6NLx1S7q4eY/ff
	LY8+5n1u+SN5rNoHGxFRqJkZKx/AasBGnlg6RpCpG+z7Nchzs1eJ
X-Gm-Gg: ASbGncu0DwJY5zucPKItxGiNiX4gLrmsSYcI8fEc74cKpii7f7HaR+USfeJQBJgnCot
	QnCLmYEVwa9v5RpYooW6Z4KYvX0FWmW8WFMAMbPFa4h2dWxMG7gSemW9ncxn6tuwc8P9O98ghZ6
	wDOuocicbu6r0LJz0XNfCrL2+KZJo0T36lesmxnupK5coEGaePmJG0yRGeeIb6ygszERhTJLnvO
	C9wYy1v5wp9c0GiGdyNqOGctOLtGiH/ix1k/L7gJqixvMhGJvryAHANzjO3PfrW+d5HFHnpBlNm
	qoR00JK+KbdHxkU7ByUHg51obDH6SH03pfdeflXAHtvXG25hMy2rvyoAqOfSay+6sM/3fgk2J9S
	k9ZZB2XKuUpj2BVVZa5Qvog==
X-Google-Smtp-Source: AGHT+IEdlfdB78rjOGHfq1n06+OQDqD/5ZuI1NfpzlDEeEQ5t3Eg0NaxY/M0zpNx0tr+GcFTGiQYdQ==
X-Received: by 2002:a17:903:1c6:b0:221:8568:c00f with SMTP id d9443c01a7336-2265e24eddcmr97780925ad.0.1742542129526;
        Fri, 21 Mar 2025 00:28:49 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:49 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:10 +0800
Subject: [PATCH v6 09/10] ARM: dts: aspeed: catalina: Update CBC FRU EEPROM
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
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-9-4bd85efeb9b4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=1195;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=cwszt1VFQnP0f7obJVwFKJMah6f154vn4FcRq3Og9tY=;
 b=PJ4/r/ExlbEASIzj9UpkcDwcf+n+oj5TVo2Q1L3mJAQismWdHDQBLOQI4WoHNFtfXbLtQp6uP
 xhND1kGpY+ECVHJ8UZIChY5h1TLViPhywg/CVC83hJq95l2mDtw16Dp
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Revise the I2C bus and address for the Cable Backplane Cartridge (CBC)
FRU EEPROM in the Catalina device tree.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 2dbb65db9250..a6a2dd725266 100644
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


