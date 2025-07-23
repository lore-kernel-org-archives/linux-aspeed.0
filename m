Return-Path: <linux-aspeed+bounces-1798-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7A6C87FCA
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:30:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnVjt085zz30T8;
	Thu, 24 Jul 2025 09:30:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753313425;
	cv=none; b=bSUs6dtOyB1+ADaBYH3cNWvS5srfutOLf5N2VfxSoI7Bt/UZ9R+SnYvYYLfYF+YNq6XgGJRbw3aEj8W354D8EMBS4yPFFADX7+o//JWXhqOfOea0hYEfIIXUB26bPOSzrvwCNRPc8Gn7dRPvL+2Fj3xwySvA+6tMbJe9E+R0Q0wAsfTdVHQOO36Mv3ZkG9VJU7FmCR5KAWgz0d0XFC6Swgr8/GHfIOP947TorLfN4w3AIQC4JWt1Eo3Rbqz3WDgQh3vaXkLRr61Efx9MP+adDgQwehZNZ9wTFSzOydSECyIHWv6XB1KPDpQs/yJxPUN5lOOblAXtY+j8+uOlLOehJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753313425; c=relaxed/relaxed;
	bh=ctQnw4T9aGCXVWE9viBmqQcA3jC8U36JYDmPl4dskAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2liaZN+0RXm8tsxzMw2Db8iKWtHm1LLl3jGuui03ZfQIBQrA280EQRM3mh3SqnZQyu8LgyLqe00KSJg0RE6CyOo0QXppmeDo0tdaa5Jt7/G+39NKZnacMDSza6DdblP4wvyZJJSplyIGiJciHhrHF5rjJAykhoTgSUo3FimPbi24kPraZgLXcf8CMrjiV3AUk6NewlLl1nssZ//GupMHicSb982byy+5t36JkZJRwTjo6qe7TfvgXOK+ZXXwfqfwzJx0Bu16yGY2uTnSo3yF+mWfzjtgnb6q4h+RaHgZvmOGgkOrUHpcSVd4D8rxhlKsuiJw/id062oM5uJZ+V7jA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=buqODqus; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=buqODqus;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnVjs1wx5z2xWc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 09:30:25 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-23f8bcce78dso3678255ad.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 16:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313423; x=1753918223; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctQnw4T9aGCXVWE9viBmqQcA3jC8U36JYDmPl4dskAY=;
        b=buqODqusfTPa+UzAzqkdsxrEiz1zgTvpNjnPjmfFoDLSmeKGak2tMxIkwQ0Uf5R8vO
         eLuPCaS3bu3MKDjizRVgZSdhfjrhpBy+21HRULtxv/HU8HRaeuYsokF9FW0ohroDMc53
         XJh+SGS1yHyutJbIbIg0WAoE/g3JVz7iyRTno2agKR5IPzamDhgRe5+RrTK9TpEUBOLT
         VAUO58BB+586cKOGJjSP1pKps2uB3VP8Mx2/w6B7miUe3YAXn24YZ2ErlJ8T6LOY8NNm
         OVTpEUlrcaEibzJPnUdKkZAXV/emZxFKT4du9qzZild2A7icA3Cylomo0pHPjakU5Fi1
         6mOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313423; x=1753918223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctQnw4T9aGCXVWE9viBmqQcA3jC8U36JYDmPl4dskAY=;
        b=MPpXwawlD34lT6gXIg7rKwuUoE8KLfSXWKPOC2j4J9CBhEamdDcDHsCZyLngRqy3eU
         wVN7/QRxHdNFqPYW7hYwj/wO098cTYORufKq7s1vlw6Ydt99JVvYJBDugwYzOSoxsQSB
         gI7g2lE528muST3bh+CZrcSutwX/oQENsH09FyE5b+rDrLE6CAklCtPDl+5u2pzw9t6w
         zxzuERt0oWPn3MEamhx27lCdNyk1Dmy99v0QZJyaUzTaThyl77HFYfy1/rUZ4o4/cth7
         McZlftXfh3QsvIDTcFUEpqiUTi6waC043EpdRyjvj7+3ev1wPleyNS2zd53PLuvSMepd
         Y4qg==
X-Forwarded-Encrypted: i=1; AJvYcCU+a+42+x6Cih/I6lKTOo4ZpNgHATLIUYg8eb6e518WPkncN4YJbSVpAzFNCzdxIEkO8yBNQYViONPvPnk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx+UuPBjcyL8QLNT4iK4d9KkZzTLPTBCA5YhuUySPp1n1+w/cZm
	TzjPkKPIloW6fUNIppxruUWg/NFYu4Jhrak1fNlnVPR1KG/9ZIxm8bX0
X-Gm-Gg: ASbGncuu+bdZuSh8cBpW72qcdXoxbLuHoMpZnCJJey9fU0KvJTqx5IXBp+svcCWK3bX
	2VOsTNfim5/Tc2gXR2OCZSjjrwrpstsq/sGrEtnKyJ7yWZs2SZBJiXYMw8so32oNfIcA2tEOx05
	zaJeMbmk0KH3o9X3QlusW8HWRiYDeQcLqlbTFJY5KUCCePfygmG91d7HusWMXdw2gTjcT9Llv3m
	Okp8s8gzzOTYBXCyiZyyfc8E+2btj6j9Q7zsJalkFl4m4T4zJ0r4dK9I4EJr9qsv8Wy8PDPTpdJ
	IfnYkx3QIJwzsVhJnAh1ZKzQXq2PKkpcdkbcBFMKPjfqh3KaoBN9whV6ZLJLuGZFvcRlmElikFo
	/D69J3Ih+kAA7g4gFzO4XrWNAS7rIK8yBAUSfr1NJomFsAJJTZcHF2ozhQpJxDqXWivOIvNbNjS
	Pp7yOFkTHnLw==
X-Google-Smtp-Source: AGHT+IHZCkMRvU1ebyh0sGVf2NLMMyqLlu90qCowRnMKoLmMxtKGnQfXhTbY0WtI4zdzMW1NJgaPSQ==
X-Received: by 2002:a17:903:40c9:b0:235:f77b:4b0e with SMTP id d9443c01a7336-23f981b40aamr66297385ad.41.1753313423090;
        Wed, 23 Jul 2025 16:30:23 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:22 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v3 02/13] ARM: dts: aspeed: fuji: Fix DTB warnings
Date: Wed, 23 Jul 2025 16:29:58 -0700
Message-ID: <20250723233013.142337-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
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

From: Tao Ren <rentao.bupt@gmail.com>

Remove redundant adm1278 properties from fuji dts.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2).

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
index f23c26a3441d..840d19d6b1d4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
@@ -248,8 +248,6 @@ imux16: i2c@0 {
 			adm1278@10 {
 				compatible = "adi,adm1278";
 				reg = <0x10>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				shunt-resistor-micro-ohms = <1500>;
 			};
 		};
@@ -577,8 +575,6 @@ imux67: i2c@3 {
 					adm1278@10 {
 						compatible = "adi,adm1278";
 						reg = <0x10>;
-						#address-cells = <1>;
-						#size-cells = <0>;
 						shunt-resistor-micro-ohms = <250>;
 					};
 				};
@@ -648,8 +644,6 @@ imux75: i2c@3 {
 					adm1278@10 {
 						compatible = "adi,adm1278";
 						reg = <0x10>;
-						#address-cells = <1>;
-						#size-cells = <0>;
 						shunt-resistor-micro-ohms = <250>;
 					};
 				};
-- 
2.47.3


