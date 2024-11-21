Return-Path: <linux-aspeed+bounces-160-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3DCD75BA2
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Nov 2024 02:53:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xv2qg3T9vz2ypV;
	Thu, 21 Nov 2024 13:53:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::35"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732157631;
	cv=none; b=nspzg4z856zaGZE0dWdKQUklD9vxzBT7/OmPHPfvpqJV3m4iNF+B0lQw7DoXVGv3KP/YHDEcOzw7PJU1P+pQeOoRgxh9PeMbByUePgT/u4UfvffpcsK0ACxS1LVd0gU6Ivlw80eNXnyXlRxLptFc8ozNkOt+4t6ZZTxMXP1pfgcfeaIfSLIXkecnbwn2kYyND+sJH2F0RtPXkOYx0d9zFqJ3q6wugrniGcd83pPrVSFzMeX7elH/IRtG9t0hFhFYPHH8yacsszT9o/I8+HG3pvQvY6NclIE/W3u4d0ZzbQ3iczFFJ+GqUPK8vo/9hwF9WBdyh1ItMRTROy2XqYQEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732157631; c=relaxed/relaxed;
	bh=1dXl5oVn1MSHtvZwlH+NvQIwSyHnFTQpHuAwir1q04Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=itNUP0nj+BXF6lL93wk7sBJd8As+rGcN07mBHaJxFp6yVvzOkUN5D5ATB3sIgFZUTdkCvSEM1gOloLvquabvQm0hRl+S3hPL9NjOQ8HJcVMPjJ/SFA2/Uv6bNdOZi9G2o3/xw3W8vY+1uPuF286t/HzVSc98pLpnydHjoqFwVDpd/6p3ZxzpMmNV1BjQwELa4mfbT2SA2xIgJMjWKg7pmKn17efCUDea6NTu8fkGD92MTG3VzN5+ZhT6C7BqTTnHM5Q1UHryadR55VHuEvjvwA8bit02uM8zVhJPtIjvzwtMUw/kalwHeOJfIagQXPnmnRN7C3aHOOIEqMLiEEihCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OuLsFdvj; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OuLsFdvj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xv2qf3j7Sz2ypP
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Nov 2024 13:53:50 +1100 (AEDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-2968322f5feso316768fac.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 18:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732157627; x=1732762427; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dXl5oVn1MSHtvZwlH+NvQIwSyHnFTQpHuAwir1q04Y=;
        b=OuLsFdvjH9U5HBh31MBXMCMPYNQWuhwu1EkHGphIF8ltGO4k9gXoLUl605qWWox2DD
         I+knCfPjhQzzZ7okBZ+gl+q59g1kvumQtxrsyneg/Piv2l5n1mWxcVSm1njPoFNwGdEs
         jg1F75pfuK/B1TeSSUASh6CjX6viVPjZKPe+hjJcytGqEaZOtGnHbhrKRaoQucY7C5oZ
         UZUS10OJeIqBJIaRjnFmtzrsKPQt+bm0B+QbvxRsBwSEyE/i/MSFzwyRClksGvqQ97ZY
         Emxw1Ardjfd9+RaO+YaBdHfyoXo28lDsiVZXNRAdRTtJ9cholJZ13iimvkHz/JSWtSck
         ww1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157627; x=1732762427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dXl5oVn1MSHtvZwlH+NvQIwSyHnFTQpHuAwir1q04Y=;
        b=PzSM3GpKGBiL1T8VYAPQeN0PPv4VgKQMLeL/zTyexU4FzvTMEec1lMyMdlj3FcgXS2
         s3k9o5PSu0jw2CNsMfq0QZGjPbahgLKgdzVeMZpd6VSZsDuttl6yjVF/GKZESIFtEK7c
         8gZkHP8t3hN4U0S29FwiHjZLtUrLykJjfiElizaveuljA+eRUi1okyKEtvGCEvmIKVzY
         hKk81ri6D6HLiEgT2Fi1EAFoT0uaCKYS0zlQGVcsD5d0VmmNfdGmu02S/EeycorXb/NH
         VB84lacIUt1DnKJSPvLRd7wRDeGfDKjxXd16ZIQvgpiGlAOsh69DC5VQQMaojrZj0+WB
         66gw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Goq3tRRvhaVxmwUTF6G3uBzHTXe424b5Edf93s9ErwUIWuQOTePgWCjuIW6ESDimmzqvfre/jxKo9J0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx54ZAV516FkNg8CkbVbZxrWI8eyrMTXvyyq6ZKVYKIxHHKnvgh
	RXPgvhTtbGDx3O9/GglgKAc4Juef1zx5+Q1nEIS+YtZVNwtpdZMY
X-Google-Smtp-Source: AGHT+IGfUxN+yNPBtbcXbTFe/qYk+jbA7fDrMhXuaqkExtEYuXDRgyQhDfpiy7nwzeimN/QIstDcWQ==
X-Received: by 2002:a05:6870:d24b:b0:270:1fc6:18 with SMTP id 586e51a60fabf-296d9a6957dmr5514274fac.3.1732157626867;
        Wed, 20 Nov 2024 18:53:46 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e309-7a4e-e779-1177-8427-3602.emome-ip6.hinet.net. [2001:b400:e309:7a4e:e779:1177:8427:3602])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64f5514sm285513a12.34.2024.11.20.18.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:53:46 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] ARM: dts: aspeed: Harma: add adc128d818
Date: Thu, 21 Nov 2024 10:53:23 +0800
Message-Id: <20241121025323.1403409-7-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
References: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
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
Content-Transfer-Encoding: 8bit

Add the ADC128D818 to bus 22 and bus 23 for voltage monitoring.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-harma.dts   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 58eba5fb6262..947622ead349 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -529,6 +529,19 @@ eeprom@54 {
 				compatible = "atmel,24c64";
 				reg = <0x54>;
 			};
+
+			adc@1d {
+				compatible = "ti,adc128d818";
+				reg = <0x1d>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
 		};
 		imux30: i2c@2 {
 			#address-cells = <1>;
-- 
2.25.1


