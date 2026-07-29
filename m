Return-Path: <linux-aspeed+bounces-4586-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863A4C53200
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Jul 2026 11:43:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h99Sm6jqFz2yjp;
	Wed, 29 Jul 2026 21:43:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785325400;
	cv=none; b=A+WCua1pAtuUzctWi55IWLC+xkpLuPlpPdtO1+NgfMRAQJXwVCDnQeZgUCtonilcX/VkhRSGigZDyDIx6Z/wqxUwrDweBkx1/UNMSSeXlysSv/2IW7A40mbWmqMvdSoS683ESp+Saivpg0Ncz68YM4mCn/43rNOJAnBzQlMkiyAO3LPQwPC5ZMCHoAWx5Etl+twPONGKiSjvTKbcwg/ZG+k1hf8cpt41uZkjajEs+IFolmPh1OS8wYxojOJcNqMqbCmjj4kYGhdPsc68R0qrHa02HJ+ZDS2uCcMaYS/9zVlLiHFXKUzwY8ak133wi3GGBIqwCVdQmRtD6DIMGXSDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785325400; c=relaxed/relaxed;
	bh=gUdqR2Hxxm0m0RqPyLuS7KiUs0HH+0wvNQWmKBLU3XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtRA+/1MjgqwkDpeQs9u1q6b6ntMcfJOV+yCxRrQya73ZNJAsaVp5yXtS7FkhrSZmAE9Zo4HhOEkFa/N5+8M8izqSf7OxJakQhTF6u6dQRKBeGu2CfQQBLmDLXFF6qpubA2VWssqSva4NSLKAkfc1yOWxzP/BptVUKO81lM1iRwWVWsfauXVxesDlLXV3XMgP/qq6NCArVOJkWtC9U9Fvt3eeHjQyMxchri6ZBgXTrRGzOOeFdDTtdHAPsMqXSEsvSHg8POu45mWOAcn/Kv0Z88aUDf1AVt6ulHf9aSXEMaG3nZnGLhbcJEY/riFJ1fX5FN+FnZ+//Zb2TskYKQVFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KsScEX4T; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KsScEX4T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h99Sm2N5Yz2xnp
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 21:43:20 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-848643382fcso963692b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Jul 2026 04:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785325398; x=1785930198; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gUdqR2Hxxm0m0RqPyLuS7KiUs0HH+0wvNQWmKBLU3XU=;
        b=KsScEX4Tgy4n/4HL/AnbQIfLRPZd6ZY4SEye2h8rYW4QcSj/aVI2zJUfp/AiaxP3xV
         rm/4ctP9Clw5SxlTMWqtBxTq0zb2r46sRyHMPpJg8vEeY1gp8vUwweg5y/jEXTUF8WBA
         5Vr1o9WkoBCU45NuB6ycHava9DijuIaCzoE3dzr8Fm/EAY5HeRu9BkvzzaQvI8xtkgLx
         BhNS3r96zEMKxRbaUNrYYw4ESaXYqRbqpnY/Iw8bND2OSOb++8S/3HSpNcq3omvIREmd
         6AU4i5SnWccpSpiCggSfQV6hqOAG422iAa2M0qfqP8DJo1WMUL10LjPD5Ts5dBUuKkrz
         M7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785325398; x=1785930198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gUdqR2Hxxm0m0RqPyLuS7KiUs0HH+0wvNQWmKBLU3XU=;
        b=i/KasE6KyDXV+t67LPIb/q+dshJ2/yB33u2ne/3sMblCxqQSNJqqEJmpVsdvET3qQ3
         XKhIeT+j26DzRRLfTmVtkTKqecPhv6UmXvVp4fHhMda14S6eWa/GtkBpwZzL90IZrsz0
         if1YejRwHXMidI5+kAN8TymgG9KDnoTTPkoV2VybrSux/VsdNvrrvlBghcUAj4+mc8eU
         VW1SYjQo67KLQArPxEnV34ht3RJaxXRvJ7oLCQ3Asv3ySWC+dh9mUfsZwu3brTKiP2jA
         5665iip4+nX37mTZ4+JQvdGId9cBNgZ4XfkbkSZ5JonNGzEPGhhRnXiUzwf09pdnL0R9
         TGNw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9oTeta2KvFznvz2KYBhJ53CvZugRQfeI0ng+ISaLS8XDfSZ/mg3OQTwdSGsimtiqvPDw7tTDzkNstRyU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwSSPKjgHJa2ocI6BGdqiqFCeqMkzDx+yEWYD9iU3KWjX+oUjyu
	65I+TuI87PuUrZIJgCreWWHGdXKVxGzXE6KVpohgXO8I/7a9b66qIwB8
X-Gm-Gg: AR+sD10lO5Gk8R7Dp1oa5tbfdlJ/VJlmrjX32HgMla9qibJO8ZCgNX6924G1WWGf+ww
	Qa3uiZCV/qTInBq5hCXvE665E/1tX6fE+iJJTVXwPhNPWSSFImYIseyR3t9b/2nu8UspvctaO/h
	Irhv6Oi3Mky6JFjWObCQDn+g4tdT0UyyZfJQfFWGcVpkbtYbUl8SMUoVhfen56bU2rgB81Lh2Wk
	uZvFx7TUKVl9d2Hzc3VQQ7x5x4JBHWYRnlN3t4BO74Y4tBpfg1b3y0wdDggUTlKh+uwG7uK8xnT
	9SS3If0913rY1QOIBpyXz3nwPDzuXH8vjDeiIVsyhJ6rBjhHTMspXIhzJhvQmqJpnINnkrBcjdM
	nmP+JM+ds3bxKvORCXgoT+GBSrX1B1iloos7mWUAL3+BaKo74/d/LQeGHeVmF0IHhSZ/a03daOU
	eXazXTreSITemixrov50o2MVgo3sgJZ30iq1Hn7MMU+t6c+ko8I8dunOYjnyexhwQFX4DROUd5J
	bRYKab3nHtT1k7NMUQ1EpLjId12qetYzS0=
X-Received: by 2002:a05:6a00:2e84:b0:84e:1a9d:d879 with SMTP id d2e1a72fcca58-84e93246ae3mr6928584b3a.28.1785325398098;
        Wed, 29 Jul 2026 04:43:18 -0700 (PDT)
Received: from cosmo-ubuntu-2404.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03cbd1csm1263532b3a.53.2026.07.29.04.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 04:43:17 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH v2 4/4] ARM: dts: aspeed: bletchley: Add second source ISL1208 RTC
Date: Wed, 29 Jul 2026 19:43:12 +0800
Message-ID: <20260729114312.3947300-5-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729114312.3947300-1-chou.cosmo@gmail.com>
References: <20260729114312.3947300-1-chou.cosmo@gmail.com>
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

Add alternative ISL1208 RTC at address 0x6f to support boards populated
with the ISL1208 instead of the primary PCF85263 at 0x51.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index 3da1cf9bbb99..01dbbda3e4b6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -1269,6 +1269,11 @@ eeprom@56 {
 		compatible = "atmel,24c64";
 		reg = <0x56>;
 	};
+
+	rtc@6f {
+		compatible = "isil,isl1208";
+		reg = <0x6f>;
+	};
 };
 
 &i2c7 {
-- 
2.43.0


