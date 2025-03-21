Return-Path: <linux-aspeed+bounces-1110-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDAEC35FFF
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Mar 2025 07:28:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJvFY4d9zz30NY;
	Fri, 21 Mar 2025 18:28:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742542129;
	cv=none; b=fycKV1vJipbHpmQL3FwyXamBGFJdO+gZDDuCejHoN2H+XpMLku5U0CjKzZi8Vr3+MMFqrELOYw7o2E+SLEQFdh0eEn3hD4FXzVL3b1zNcik1hdnGBM6Pb2v8EGhKZoD0Wo4GUTYOpqBj/0GMQs79Ua3nNTBnZleTBGplTVtPGqosOR7Uetp9HBJtUSY09F8m7ihd5urAv50T5niQGZfSW0UHyp6dNhM5MkaRvYYJUbA+O1w09Z4hSzvIqgLcQAvolOSjYnH7DozrrQhbfTkU7Bm4Tt3CeN+yHUepOTEDwvTd8MmrxOhdumv481nZMzxSkOBy9CE0HatsCuUSA1VyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742542129; c=relaxed/relaxed;
	bh=6yYy4AbJx68HMcvUd81BZlBUUo2lt5qzF5zCFnIAXP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MAPsZ6yxkIzbpq02/4IWfdlGXIL69126qkUk2D0jOBwjyeXgl3JqfWHv7+0Vpe7QzlgmgMdFsBkeqwJVxlPq6ZQs8kWXP+Dnf5xj0cGkK1rXooqSqaULmPDctzqmpHKQGdxTRw0ncA4aS/1BJ21kUut3H+2gp3+oBq3Gff63dX7y6S3T+oRjCQ1ciDewe9n8Jur9dUCnGQGmUrEg4yQdFqqYqk3XpXnJC5oXC7wksbEqulDkgbjgpvmfbmNI9E8LUK4lZmgE5JNCVTnkdNd851wSCmH+cGjILZar8Nr966EqTFtFMMBeOmMxBBW+KnlERNIs3byQ2SSXWn57kP/XwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=F3OHoxXa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=F3OHoxXa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJvFY06JRz2yrS
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 18:28:48 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-22548a28d0cso4110205ad.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 00:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542127; x=1743146927; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yYy4AbJx68HMcvUd81BZlBUUo2lt5qzF5zCFnIAXP0=;
        b=F3OHoxXaPx1fP3P+5jXibaZXkfS4HsPL3blEkbC4gy+KF8BU9EqlLuVepYtXbqHeff
         I2LZAMxPPyN8kdCZxJ8PgS04fbkTkbYmyUvYvATUxfXIoWOk2Q9rBHa54F6eRE5XIQPc
         y1JqYAEy3JZugkFZdFRZLk8pY1wm/01EOcbcuhyJlhQgkDePXBerSd4EvE6bGhKrNYaH
         NwnZ+OGL93ehvVZxG26N2+eZ5VWUe/hLeRGCvOcVWinsur0LUoZDKMyNN69Je8lpp2Lv
         IpdmicgdjGQlswjb4ly2tHRjAepNMjZXtotg/+GypwkNE3uslXK8NQoD87xe79ypX9xI
         gAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542127; x=1743146927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yYy4AbJx68HMcvUd81BZlBUUo2lt5qzF5zCFnIAXP0=;
        b=ejp8gGu8wfRIkLA4uw7JEAEKRq/e2kfonXe7Cbh++oCW5pIDDRIDzlFDRPvFQuTF4u
         ghzvGbZwtyBdz3zXu0ddmJjmYGhlUkJkRS62e/BrhTOnFtc5A2YAHuXLJr2WrNBVbFLS
         JGhafq/RNJeycS4YFUb7QdVWzMtMdxIfc/Px2qTUsN1Jtdlj4lhN+HPMOpdbhqelcL3u
         m3HTxQt0FJB1JuOxbmIMjQRctp35/9a5lZ7guO331jG50Kgxv70fZgGclsY7LfdrMvrj
         JrSUWxX9V//PJC2FdsJN8y0Wr2XhZOKLTX79AJKNR6u/phnIZRidImYjqCuqbxfWOz3l
         XOEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdLkMaPH63zrIecN1vwJ9IXhS5u13BBNKSqAYCi2Dn//d1IJzVjsF27DmB9WJnXlVsmmPZYwNa1MJ/IwA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxAcB+Gz1gfarpthc7/pmY2Hc6uYVJ0N7OI/1oQeZTtU45xsXNT
	U5Jf4jKWvPzfAgGwYu+SCCTNyAEspjyN99PvcWTp0Nx89jip3zmj
X-Gm-Gg: ASbGnct4EBY2qOyponB8fLmmJw11SBn7+D8fEsHiJLIEJBe+iJ9hJiL68r93VM3VUMm
	ODSC7CPjvaGJq/mMeWzxQMntZk8WKYN7RtgAXRQ9OfFE9qT3ayrZCvybl0apqdIMr+a4QG6I/Vj
	Z23y6f8N6bSghHKvH3sWPDbqCqH73E8Gesq4Hf3mdmPRdF8so98K4lofCvA2wp/MFNuBQR1bfRv
	7NEwjjzfh/+JV0ycpdyd6O/AD73yaJt0pl7EioFBp/fIBWuQViFA13gSznLWMCvmDY6N0Zqc/q6
	gpRNJCOXQAbdq7JgkKibOc5IW+8VvUlTbfNL8snLXhEJgOZ3HPKIQnbce3En0wrYmaSgaOATrrE
	RiMAYZuNDnpiBpCqD5kZXQg==
X-Google-Smtp-Source: AGHT+IFz7z9DTULNmP+oLx3nWMYzi7RsllXSFyhzZAy2FVTHB5ZXzxdUyhyyOFfzLur+HYKAMXEW7w==
X-Received: by 2002:a17:902:d2d1:b0:224:24d5:f20a with SMTP id d9443c01a7336-22780e231a1mr42741185ad.48.1742542127003;
        Fri, 21 Mar 2025 00:28:47 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:46 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:09 +0800
Subject: [PATCH v6 08/10] ARM: dts: aspeed: catalina: Enable multi-master
 on additional I2C buses
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
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-8-4bd85efeb9b4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=1008;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=p/QorKJCn9XrFKbtYC8NvQNC1AWXOIPQaV8PshPU3mA=;
 b=hV+DOjonfukNtIa7vGCSR+jzs82NRq4/way8tjyiwrTKrV6clGwwNua5InfHy7waqGTVFHXvK
 faEslXcUhw7DyXaYrSgm5Z7hz5gKtrp0n1tFujFjX9XQSfpXo2jPHzU
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update the device tree to enable `multi-master` mode on I2C buses shared
between the host BMC and the NV module with HMC. This ensures proper bus
arbitration and coordination in multi-master environments, preventing
communication conflicts and improving reliability.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 6702be32918e..2dbb65db9250 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -815,6 +815,7 @@ ssif-bmc@10 {
 
 &i2c12 {
 	status = "okay";
+	multi-master;
 
 	// Module 1 FRU EEPROM
 	eeprom@50 {
@@ -825,6 +826,7 @@ eeprom@50 {
 
 &i2c13 {
 	status = "okay";
+	multi-master;
 
 	// Module 0 FRU EEPROM
 	eeprom@50 {

-- 
2.31.1


