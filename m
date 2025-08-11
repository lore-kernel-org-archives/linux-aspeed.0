Return-Path: <linux-aspeed+bounces-1940-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1704CC87FDA
	for <linux-aspeed@archiver.kernel.org>; Mon, 11 Aug 2025 07:32:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c0mYZ2Qd6z2xK4;
	Mon, 11 Aug 2025 17:32:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754897538;
	cv=none; b=HWB2pn6/du+n4Vitq0wQ78yaG0PpntUtSQn0Zz7WWQUhElgLR1yxikOobn+EKz95J9xGZCqU4kZhjLvKjaljgi1cz8hpBM5Gvo9LZqqmT5LcfWGm32I/Ma4FGBMguV3nOV5aIllmtsKfOvkf2CD5QOXdY+qW1xNKsJ1yCN+8gN/yXMrBjVv01w9kB8xb00bN2w0hVJaXDmsyQ5FIW8WiS6rTXrLEXHtEWHnyHonrcWct9oBOF7VcGc2C73dIKewKP3JFYV0a4FEKS9qhkSJA/0YiNmHFkZnCsNdrtgMeZ3VNmD2C61PXnyhTEiWZZi3wuAKaZb/36QEYe1KLj3eRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754897538; c=relaxed/relaxed;
	bh=TiIt8rDf9PzwkCULipFjt5F74mFBlv9AMUVadk/6kZU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhT0LxpCKk1lgdR13g1Nyl/zYfe3E7Xi43nvcMv4PwoOwRqTTBMtxZ4X8CU3WISL9r2wLQBdoz1K6oZUBqPIWIQWZn8NCqBFsSS7UxyfK83y5cKEzjWhxnPYWq3csBVQKGe6fQNV1CQf1E0FuhXnHnDoURtlMXi0XQ0Sxq5H10L1ydfTNQwOvei8VvsLis7QiO3pBM2Yeypif54ii+n5Nso/Y5mEQ3U43FK99TdbsT5ZPYFjCVupLRyKSRLiQN/n80ooMeLdFr7YS7EP6uFAIc5GNdEJgJ/idBYHkfCoUUw+dbowd4/16gxA4TdElNTKl0b+Y20LWFH+erQFBCYb3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BMC4LodE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BMC4LodE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c0mYY4RGSz2xPv
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Aug 2025 17:32:17 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-24031a3e05cso26581765ad.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Aug 2025 00:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754897535; x=1755502335; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiIt8rDf9PzwkCULipFjt5F74mFBlv9AMUVadk/6kZU=;
        b=BMC4LodEPFv+ivQPeluX/PbIRegdhbutZ/RZviE7A+AOMjLi1+NX7Mhk29YyoxgAS2
         LiLgLgpqyhKZvemfc0WdOVuiJKK66/wSUJ3zHY6/3fB4d80wRJtsq5Q8JZ7W+i9wDQ0D
         ILLyPnJad4YpnrP33uf7p/O9aD7jNxTFO+vYXRME0j+DyrvaJX6DA3d860zf3VOuQqgd
         I29R+V3IFFi0aZtxV4Kc0EoiyOWfxGdRgwgXu+iLcAKBTAG/M7KC7xJE+RdWoGBHOch6
         rsR3l02dxbNJhBDdTNuxIByrV5DapY0Ew+/TWwQJUux1XMSHdoB8uQXquf6WsbacFIc3
         QQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754897535; x=1755502335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiIt8rDf9PzwkCULipFjt5F74mFBlv9AMUVadk/6kZU=;
        b=i2dizYVpNkC9o9U3iYhyFQO4wvFY9AT6BE1zDXCoKEpeg6efyuHFzvKFVsgL5GVn0H
         W2e0ArDMXyhLLcoRcbmRiNCK1tLOtIRgxL4EL/Lpan8FWrneS657214FACw7Xp29wGt3
         8iGtbwhhg77F3+bFUhFLeUeLno7z64hKNhYhEVS2gTp3AX86qQqi+2EAQcEWjytTWui3
         jXq1XH98hHYab4IBdg8Abs6/Qbomep7i3jfulxwQy2GZ4gjfa4oO8SJq1tLp9TmwITia
         GGhdI71oyTih3DyOWGoJXxlJf+SuLkJjOiYpXYoqbDVEbw3FG2rnt5UnI5o38+gOiZ46
         NGcw==
X-Forwarded-Encrypted: i=1; AJvYcCVnN86DA/4V8i2739JT4/yE8Bt9rksMmacD8L1i+1+vRr5Z2ZIpd0VMNngMXoxUzkCYRqgpBkTMcJXVkOk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxb0vIHZEtNHkHTidJ6bXmCl10Z5uMGgLFKqVhKy1sI7PDQtyig
	aHSDimG+J+oH1yxERs7JDfb2+fXgCNbTM1AP6Qy0tVn9NPMLftKiqZqD
X-Gm-Gg: ASbGncsdXSNDZgYZDU/20I69aUj3c/vGepBywPDU8Ao/Ug/TPJ9kJ5RBpDD0m+onq8Q
	Jw/Sm3NF6wNxC8JPUEt0ggW69b1bLRBJlFXVfTsMMUC7PKXBNBwP0DQYbSUAaY+65AZ//MZDxlB
	IK5Se3SmFpCAvl5Gw/QmK2jC8UKxwfR47nYEe7IVAAnXEH+xyVy4KZN9kbw593xzznrN8tM187D
	I0PNuoZpCs8DhNq+LBLw4ExibczfeXHVumjPPGVtAQYZnlFHGlLX3ROozV9XmSPOCvFDDa7vQIQ
	1pGh+gi2ZrkCk4pAEL8uMdU2Z8czmxsnr95eR474VGHITjGZ5gpFai9iVQ0JUhcIZIir5tXjekQ
	IIf6pWrPdNqgl7cMj25nEfRd75Kj553M7r4D4C9XWS+z2lAAfibYjD0rOK+hXA6l6pNgOoq33kk
	6WNflHXXA4H+w8Fw+YvCjKnvxII6DE
X-Google-Smtp-Source: AGHT+IGQHxLvRHaO5AnELd5J7hy0PgS8cem/4j+c/MAN4VOfDSifl4layNco3O50N4UNoO5r58BnCA==
X-Received: by 2002:a17:903:1acb:b0:23f:c5ba:8168 with SMTP id d9443c01a7336-242b0466eb6mr250081165ad.0.1754897535067;
        Mon, 11 Aug 2025 00:32:15 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e388-d3b1-e90a-ba63-d547-4584.emome-ip6.hinet.net. [2001:b400:e388:d3b1:e90a:ba63:d547:4584])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef59b2sm267624575ad.7.2025.08.11.00.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:32:14 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ARM: dts: aspeed: harma: add power monitor support
Date: Mon, 11 Aug 2025 15:32:06 +0800
Message-ID: <20250811073208.787063-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811073208.787063-1-peteryin.openbmc@gmail.com>
References: <20250811073208.787063-1-peteryin.openbmc@gmail.com>
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

Add INA238 device on I2C bus 4 for the PDB board power monitoring.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index b9a93f23bd0a..741d2d9b6d03 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -373,6 +373,12 @@ power-monitor@40 {
 		compatible = "infineon,xdp710";
 		reg = <0x40>;
 	};
+
+	power-sensor@45 {
+		compatible = "ti,ina238";
+		reg = <0x45>;
+		shunt-resistor = <500>;
+	};
 };
 
 &i2c5 {
-- 
2.25.1


