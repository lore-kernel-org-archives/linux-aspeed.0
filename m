Return-Path: <linux-aspeed+bounces-1083-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFDEC35FFF
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Mar 2025 15:24:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJTsC2c2zz2yrD;
	Fri, 21 Mar 2025 02:24:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742484287;
	cv=none; b=DOdjvubWwSW9UB7gvh3QTHrbsolDkXDZAoRzbepZNjygVBUtf38hXPH484s/arLZ3jDPA34wwkYb23iMK4LjXbEbguJSaY8Wvic1iB3oQEgHfvW9nHWqFpjEf6QTWV+Bo+tavqJ4UC9O1wVD1lt2/U8IH3uLUSnjvwfsUhFHGaVyBrI/vsHnPRV72XrJb0oyx8EDSAuUr3l9w+RwRLXCwm3B86KDlJjz//blYBpKC7hqBtvZIbKPOa3lYWUvIupwEF7/E/K5UdwToSgrqc8yXKQwqbziOgwSC4DWVLUZux2ct6T3kQR2wLBHK/MF2Ax7dbdLsoqImTlzKuKpnIVRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742484287; c=relaxed/relaxed;
	bh=BdO66wmJYQ3an/CxnUlug2JV7sb1pt8dsfeshj9bVHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ThpNTzY3CJFPb2pmwBdI6MrvZ4FzQH2m9z9QO44uDifY35c7w9GcaZa6lAlCFkaN/blCtM40n3WO+uJ+4ALXwrxa/lUc7SLp533iZon/UYE5BLSVYzAVdMI3ETZi0JWXtgcer240PN0fNTYZKFmpmkgM/4OA09y+N9uaBW+7Ker7qn++oWo53DD1ktFJ/yr0onVZWrb++a4+RCL8FhwA2pRFCv9m8BUGXjpieTimI7Vf7ROjE7QG62kiz443l/bnpcfoF8gYCV48d4tR5F0xB6swvtYAug+ZtQpwX9vlyU5leYZWacC9+47uiyUFaSdZEunbZOdCCDiXQhSYwpvwwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Tc36QgSR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Tc36QgSR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJTsB5NN8z2y8p
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 02:24:46 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-22398e09e39so19911935ad.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484285; x=1743089085; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdO66wmJYQ3an/CxnUlug2JV7sb1pt8dsfeshj9bVHI=;
        b=Tc36QgSRuvw81hE2Wk6QEXplpNpbcBF4UWAp4OBVaaGs8Ry/+9mnL60AtGN3YwhHuZ
         6ntyyGefHvpe1uPceKKl/EAvJzsfI6JtXDegzhupTSI4/c7gACzT/UmcGGH8Omb3iBBg
         gGkwYkRAk4BdKpIQ4jz1keM2uoAy1E7JijgBYRB1fpRQXRwQhxtPvfnVIodfqiFny+DD
         DO8HiKkKrxu1VdB0c2r4NcqUr/hV6JtJ90CxKN0H7NkASVvWEZ9DWWxONxNCNma4V2Vi
         IVzwrBCDfK+ZJYAK1CZ+Q3zKgcFKw96TlxYxlz8nxmLvxrRZmiS8S2KIeWFvo4pUqdpM
         akSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484285; x=1743089085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdO66wmJYQ3an/CxnUlug2JV7sb1pt8dsfeshj9bVHI=;
        b=UCsLk4v1+gLRH6zLElPuPx/UdHbJ0F/xPgOGvGZsUTREOXYBG/LMqiel9xfTBcUIyh
         srv3x8HJ7Eg751cP2iTM/pdDCXZcT1AWuXG5XYn+zLdwMUc/UwKIYPq9MrQcINpGmLKk
         qoNP6QoN4MAUINNM83MvBt/iVgv7k8cEbbbOkdUhuPpWLrfkyKzIN0svXqdKeQOYhKlb
         tBqX05XXQ8Ci20Gm113ft3JpF7KEDUcayPgCayA7nTyIviQw2I0cWl0JO8RXUfiLP2xt
         ghOLQfo9YqaWlcBes51TYfpoLehngAUv/1iZkgenMuZ7+936tdTV9bccIGfql7i1Pep7
         3Tdw==
X-Forwarded-Encrypted: i=1; AJvYcCVEDXHJe8XKXx/y6UhELaY9gUeTtR9UAtFXfcWfJ1+0A23WA+DC5FEraWvYj8kvBusBxqpZF6bgV5sZpx4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwRy7sspthBePpO6FLENf5Ve8lsP7l33IhsNHWgzflsZN/9yAVh
	UYTLATlQvrMCtBy5bwcwiWUmaPKtgw3pVeFnh44DNrayXnJ8uViD
X-Gm-Gg: ASbGnct5c5FNjO/2s+BkeeSMJskWZsQU5ZVM4/UkoDnCsqsPZ8PmRz7Ve1W1MgNwZFL
	rcQ/j9hp9ru917auC1KZsSTf1MrQujP85T2+lowudYuf6+JygW342/NEKaPZ8tCFQ5KuOTGiGoV
	FpaF4seX53k+DPIARvvsbN3vpIRP00Bzfrs/6zbLCctULLZCPseVt1EzHIOl4/v230InDBj2X+J
	I7VLAMB1z+xGSrI8HTrZdSeibcZYNrzomoJYDcNxEFpcF8titDEry9LcWWxGsR0fXp02Lq1xbsm
	Ihw6tdeNF6qnFRneb+5IR98fEXtdxNq8PSOlYCEOzwxnx0k3zUuhu8h1+yM3P+Rnkvkel8nnu9r
	dwcgsmB9kq8aAqtOlX4mFsw==
X-Google-Smtp-Source: AGHT+IE0FDg/RvatznD5nSPBO0u6iFrPVYdj39Zl3XVqmYw9j17E38UUu3Xc7F1pPw2qEsugW3y4Rg==
X-Received: by 2002:a17:903:320e:b0:223:fabd:4f99 with SMTP id d9443c01a7336-2265ed68d0dmr64182055ad.5.1742484284467;
        Thu, 20 Mar 2025 08:24:44 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:44 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:56 +0800
Subject: [PATCH v5 06/10] ARM: dts: aspeed: catalina: Add second source HSC
 node support
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
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-6-e161be6583a7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=979;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=bBJquWmbhZlBT0E9fzqTISanbT0nOLqq8zl6vtcWbDs=;
 b=nY7Z5IkRbcS1V5IGJjWbsZaB1Q3BvpU6kh56rBgCZUHC3bvVeo1uNTaxziEpT3fNRvoeEldAt
 plVdW1akqN3AcuEdgCyo2mqwpTyxRFgQu4v7AIIo8yta+XVuO35qHk9
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the XDP710 Hot-Swap Controller (HSC) to support
the Power Distribution Board (PDB) with a second-source configuration.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 9cbb296dcd9e..cf8a31b50074 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -562,6 +562,14 @@ i2c1mux0ch4: i2c@4 {
 			#size-cells = <0>;
 			reg = <0x4>;
 
+			power-monitor@13 {
+				compatible = "infineon,xdp710";
+				reg = <0x13>;
+			};
+			power-monitor@1c {
+				compatible = "infineon,xdp710";
+				reg = <0x1c>;
+			};
 			power-monitor@42 {
 				compatible = "lltc,ltc4287";
 				reg = <0x42>;

-- 
2.31.1


