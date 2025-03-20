Return-Path: <linux-aspeed+bounces-1078-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1A5C36001
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Mar 2025 15:24:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJTry0yMzz2yrD;
	Fri, 21 Mar 2025 02:24:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742484274;
	cv=none; b=P5raw8oSFej6tHyKCDh8gAs2vxCrYMv/U6QxV4acq+nr+Ia5a/ySoZqW9cY+qyQ2pAw2UnIVtuKaXY5nOcDTHEdw1IBemFvijtN6+b6SpHBtj4ySIApFCIxNqi6DV9ExZ/0UlyK25KSi4muwCXhenfyB3b5rLkLuhEM3d8P9UifS6fwJtKx2l8DZdHm92Qgs16qjYJ/HjN+8NJlrDNwX2W/o+YJdS4owilf8j2WIUC9WKBTX15zv0HugLO+uDeu+o/CLF9rhezCtxXqrB6X2ckjhF7NzVWmDhXDgwoa9rwO87uVtXN5Uik9Jgj8gH/MnpcyIvfRW2zl8mCWi94itvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742484274; c=relaxed/relaxed;
	bh=vsGnq8WpEGq8rItMy0um7W6pcAm/zbCWTBE+mh8Th8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khB+15HwV624rrctU9Yo1JJi62UvLWUagf69HsCWXVIWIx/QaMq5ZWUeP8OZh8eyQI+zJe/9CzXV9/basgB/D+IoEkwOy4lelGXp5rpElvBDQJakxOg3xJomhJv+VTkeUtDzP3aOyc4IfmGqtv3ErFRrRIChiOxxTnLSUgO0FmSc87y5EJnBNQo4XrveHya3EVOwmnTB3jb/Qo1OY70HD/S14YgPQBbSujp0LacU8IxhP7IIeWwTnxo7c/1484LfyLjpAmDKym8i87lt9TyXbpfGfdVb+O/55GFTwBqiTMV1qT+br7Ej/b7+oE9YMDHJ0G0m6nlI3SZWehOL5iIdtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=H98z9l0F; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=H98z9l0F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJTrx2y71z3050
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 02:24:33 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2235189adaeso18909125ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484271; x=1743089071; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsGnq8WpEGq8rItMy0um7W6pcAm/zbCWTBE+mh8Th8U=;
        b=H98z9l0FOXtQvBobGRaLsgCoUsTtL7bVe1kMpQe6iVq+50pYqEkV2uuyNnhj94eVfs
         pyyJgAZkR6wl7cKQcn4JgEMmtR+EAyzgrzuf7XirBU8hd177CH7wPvz7Ou0tn6XZWYvG
         BzlgHShkyl2z0E0+HtFGxH1gCdCUK0Vh//+Uc58w2n/sLcyD/aHj+MAxUPkbm2+R7ur6
         7cGSuH6L87UXFzIRvRVtf+5woopKspjJpJkDuX6JoCf4PQdJ2lAAX0RIoXoRrXCWdoAt
         9y5FtHTFlWLYrJz4pTu9KVL7T8/zrAruvEBjrggy/qCZEA4liIL4Xg9rL0QBxh+I4pa+
         0+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484271; x=1743089071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsGnq8WpEGq8rItMy0um7W6pcAm/zbCWTBE+mh8Th8U=;
        b=Sf+VnNcAT0NV/4054YExlH+sX6DeT3q2rt6e72W8OtsP/sItR0ZZLYtuaOfWC9+kD4
         JodNaH+KtcMRen7Sznv+6j8zyrrM3elVyOG6vEpCTimgQv8vJZs/lKecA4L7eYPX+EZx
         jedzZbpfKvyuHAsoNcu480M7EGLLmrqKdP33pZ/V0ZbiF3X1cz8XGfsKohop4S3WLVn3
         EryK8KTQ8zH9fYFlo8sgm1AQWEjZKqIyv06hDtDxR4eEzDXLp/CtW8QDDADx1dOSkB9A
         s444x53TY0eQglx/vmI0g+98ohxQH/pDskYqXngFXU8j3qDQpTPCy3RGDfTvWd1FdS8P
         AQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1PYp5/Ly/SQNXGqlHY2eKna5PJv59NzqQtWYoovFan+A4Qv8YiiA4NS+lSQF/cg82v7jyXXmq3nC8Y1s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx5x2G6VDNP2mRHhKaWZNUgs4nUJ1nqKzhP+2e5DhqgvksyEyOd
	XfKbs3DTbPCkYm/nzxXU927oNGvxAnRHMTB5X9X01Oj9hjlYVx3p
X-Gm-Gg: ASbGncuY5oQQHmwQThr4xedI5EfcrgfsDVcHisrH2ImIrWXw4TthvJEUfL5kHh7yFp4
	zlckX4lGLq1+/Ya/FLRShoMDvTExdYXQ4LHacSNwx4YcShT0np+h5IJvUIH7lnxwYylLHg/paJo
	aJUmXiYNUBG9jMigimnnHFmoY3fwxu2nCu7IX1VPsrhQShFwPHiiY2AqcJvjMqcUNz+jDN/G4qq
	oWiIyE1tRUifjCnUU5wVr+xVMaTamSQP0pxFI89rmFSwDxbOXTOAB8TjB4EB98Cy75nSCCfYYGy
	IEdb6CtbKqapuHh4Vy9Y1hSxoAdS7dAZfywHwqx5qGFkErxy93BUpFSF+QzxKgcV2W5KHqKf4NQ
	bELOy/PpsxnTfHmgXjzbASQ==
X-Google-Smtp-Source: AGHT+IHybFC0zN/Rzgp2ZChfKI2Jk8hE5XOcGV4Y15RoIluk7IS4EwemASEKGtRKwRtujb5+46zkqw==
X-Received: by 2002:a17:903:187:b0:223:3394:3a2e with SMTP id d9443c01a7336-2265e7184aamr45865045ad.18.1742484271343;
        Thu, 20 Mar 2025 08:24:31 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:30 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:51 +0800
Subject: [PATCH v5 01/10] ARM: dts: aspeed: catalina: Add IO Mezz board
 thermal sensor nodes
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
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-1-e161be6583a7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=1855;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=ZE8DMnDtK6GtXz/R29k12joihlo+gxEvbFhaGKQky3s=;
 b=Pwk8Uh+93j9LYHavxQFQIFiCHCzIOTgKNDNj8/fEYsR7crev46E2mLJvCsTSj93JoySx9CQyj
 71O0JM47JzTC8DBcfN6GeGIo64SJdL0YhGdfdK5V451j7FQ9RYGGpZD
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add thermal sensor nodes for the IO Mezzanine (IO Mezz) board in the
Catalina platform device tree. These nodes enable temperature monitoring
for the backend NIC, improving thermal management and monitoring
capabilities.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index c151984289bc..d5d99a945ee4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -198,6 +198,12 @@ i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			// IOB0 NIC0 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux0ch1: i2c@1 {
 			#address-cells = <1>;
@@ -208,6 +214,12 @@ i2c0mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			// IOB0 NIC1 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux0ch3: i2c@3 {
 			#address-cells = <1>;
@@ -299,6 +311,12 @@ i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			// IOB1 NIC0 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux3ch1: i2c@1 {
 			#address-cells = <1>;
@@ -309,6 +327,12 @@ i2c0mux3ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			// IOB1 NIC1 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux3ch3: i2c@3 {
 			#address-cells = <1>;

-- 
2.31.1


