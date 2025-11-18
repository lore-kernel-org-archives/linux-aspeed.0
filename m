Return-Path: <linux-aspeed+bounces-2947-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6B4CF2562
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Nov 2025 22:06:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9zGF0nnBz2yvM;
	Wed, 19 Nov 2025 09:06:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763463216;
	cv=none; b=EAID7ATrYns1Be5LrAOdjpGj8TjzKhIHs37FT/a8JvDO9tFZ/is/vX0IfDN/X4Nju/Ta2Hzx3VbFrhHN7gMRtb/Unw++Tm8Fmn+qkjgxjaMIWFIeebCiyxd7Oy/vTfnLOP4r7Tt6SCsuFvUYVk1gxNLQs/gZQtH08Q94xylrarq1icUCXZotN5WpJDW61bXHZV3clF18K465Jy/Iliy3GxwQBSX00kPFCxry/d3nCJe9Z/b6oW2Y98MpbykU9nsJ9QgVMsgCQ7YLai3lOzQK2SzG6q0bAgrynT5xr7Bn5lLCkPpu4nx34vFmdIPhJGOeWkglFeDtece5HTG0enezzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763463216; c=relaxed/relaxed;
	bh=jrmpJ7r5olEuuHW8bES57a8T6LK6exu5hSOQkrAzRxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YG9Td3fN7N2RnYDhKS6422zPAGUIDZ2WoU6b3ueOBvOc+dWgn9lKTrrEbu0URJvYza+5OegFax0sVOGP+IKl8df1JWBrzUqJ3HhND4BjVqD9YLuj+SijMBhMMNy0+rggl6RgtZPTooz2K1tlVChH7k1tvh6rpNyMSpzzbuXHIEzv+BeEBEiKooRrPFLIpEnW2zK+SiaSClCzh30wkKKVxgzNlJSByI7tZy3hYcUTNQBTN9+iEE0grc+tx+Wn9SS7WF6Cbz30w+8FgRxaz3on5drHsstG3zeSbckjlwdifrLYDf94j6iA7RXZVYcCbjHGfMjeUdW7HWfLXIwgJuMfdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VY4reabj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VY4reabj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9hL80xDsz2xqr
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Nov 2025 21:53:35 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-343ee44d89aso7671851a91.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Nov 2025 02:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763463214; x=1764068014; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrmpJ7r5olEuuHW8bES57a8T6LK6exu5hSOQkrAzRxY=;
        b=VY4reabjP717NHyuhw5YcqylUQIXuYoQ8w1ZZUFpIP+BWp/M8elUSBEs8MLXTAszca
         4M5kr3NvStjs52X76vFMgIkx/4mxjTR7bVmdARbyqVhVINfc+Rlf+0p0236nktnFOJ9l
         UwOc2ehP0R8/Xj8AzbLyjIGdyAd8/62Njk5sCnb/Ztav+BOuuJtx9uufBOqO6/TBTn2t
         rKaGcNmFCxxyCtWv+fjdNqWSjhJCxyGnrD5UybURsP6ZUeoLQ4CiSbnVCuEPFEk3dx76
         NYIC5WJbZgg63Ky5q0/9BeXXWNc/IminGuqsSEi0vbDcD25QC9X+Nr6sKlJ08Mx/5KwX
         Ujqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763463214; x=1764068014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jrmpJ7r5olEuuHW8bES57a8T6LK6exu5hSOQkrAzRxY=;
        b=BdR0jPrDlyQ5YOzFn0VHzXAt37zxqcaJV/uSKyltHVfOKTxWxRN1/0NhNgBlyqcewh
         4xhkyron6ep5VdnAgTStfxpyqtfqE1cMeFHQ6/O14cvVPXW0a2ua5j7DAJHTyTJLeOJe
         pGTT6v2BVGDiPsk6IiyEhvaL8EeK8Ayvp5WRl/T7pd8J0CaO097ytbNOLJyIeshuDNm3
         PH7C3nEs1Na+eMNBTpH2PoYTvoBb02bBOr+MZdf4+xovsW0qrEDrYLs4/e5+4chTIZka
         M+ARWmbkftuDEh/VsuA+ABgQcrCRKuO3QnkRDPmCzJn8dLiCjf+Nj9bKmJrq8uHKX1iL
         8GhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdYxny7Zsf+lHKG73cDWMd2a4TPyPpmW/XEn62t3aR1YguTXxTVjeO6IZTyPlsru/MgpGIweDVMkHYNC4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx9Rd+F7CRdjcq6YN1NWWTsLCGgVgl0YO9P7GuF8icfGAzbX9mZ
	ReiuPnb/tnqO/flHzaMd58QxyrWlI1PKOTRRa2WnP3UFh4m/bseaIswi
X-Gm-Gg: ASbGnctjW+/tTdyEPJfutAvebAy2gCLQpurq4napPD7c23j18Tsge41lr0QKoISosSm
	Vd9uYls2er1JA3PS1F8vMgT6Y5ZvtWLeL22/EMwb1fmug15mU9iURHM1LH3GsWQQy9TnfSOvqvX
	7kiHyFuAmqm+o+7oyfweb7yZ9HTlphUQZENrWswX7BR75mlCZ7cyiQKY8V0M3mdIVj+hUEtLwnP
	+1oIt+ZWUjhTrpLkdZT8z7K8R+Xp2kr5u6TX+IjyDhPKZ6TjQoBV8S8gtp7ljaSws07y14S5k6f
	bXubP6tJJ/azl+eOknSmDGU2+kvXWjZWPgb5NxUHcU6jFm4oK8Enfq8cE0li78FXsGUQFgbyuLi
	2GcYW6QFRcgnPCJYYxs9yY72qQSDzBY/2JIB1LGadPY/SBK8M3AC9epnhByXF6qFBM1YouFcKlV
	xV2y482O0XmkRKOxOOHwkw4IHynBtTKg6Vfeu3JNjNj+vuTiZtMHt50yKUzVhdgwgG5M7J4lUno
	Ylx3dok2dXf79ZTc/TZxU9VtOxmZ6v4TDsVnmnVONMDfVLzJ014qVHpjYRwVUtYD81chFmXJw00
	4kS06t+UqXG5XaGX1WyH
X-Google-Smtp-Source: AGHT+IF2voj8h6VBZFwIEhidYuX7kxZ+HtyxeIJgX87w+aBlexyKiWI8vQ8KfVgjLMBTqVzQwR2WDw==
X-Received: by 2002:a17:90b:564b:b0:339:a243:e96d with SMTP id 98e67ed59e1d1-343fa796a3emr15961735a91.36.1763463213843;
        Tue, 18 Nov 2025 02:53:33 -0800 (PST)
Received: from 2001-b400-e30c-5507-a914-c4dd-0879-41e4.emome-ip6.hinet.net (2001-b400-e30c-5507-a914-c4dd-0879-41e4.emome-ip6.hinet.net. [2001:b400:e30c:5507:a914:c4dd:879:41e4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924be368bsm16274111b3a.9.2025.11.18.02.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:53:33 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Tue, 18 Nov 2025 18:53:18 +0800
Subject: [PATCH 1/3] ARM: dts: aspeed: yosemite5: Increase i2c4/i2c12 bus
 speed to 400 kHz
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-yv5_revise_dts-v1-1-fcd6b44b4497@gmail.com>
References: <20251118-yv5_revise_dts-v1-0-fcd6b44b4497@gmail.com>
In-Reply-To: <20251118-yv5_revise_dts-v1-0-fcd6b44b4497@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763463207; l=1020;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=V8hyqVc8AxjSIpi8Rf3ei8SCie7TL3OVm+o7PWaDSjI=;
 b=yTLo22srLoWN9l+075TqUif2qS7lg3gob+kFc4OjeXJUO/YBHZ72RwuTKPHKn3l6CUs3SlW4+
 J6OpEW19//0Aq9exBxEepLLubirjgzAcXrA2O791MxNZOKzZMQ6ItH3
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Configure i2c4 and i2c12 to operate at 400 kHz instead of 100 kHz.
This update aligns the bus settings with the hardware capabilities
and improves MCTP communication performance.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 2486981f3d6bd36f3fe780b21e834b85242f8aa9..7991e9360847532cff9aad4ad4ed57d4c30668a0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -231,6 +231,7 @@ sbtsi@4c {
 &i2c4 {
 	multi-master;
 	mctp-controller;
+	clock-frequency = <400000>;
 	status = "okay";
 
 	mctp@10 {
@@ -782,6 +783,7 @@ adc@4b {
 &i2c12 {
 	multi-master;
 	mctp-controller;
+	clock-frequency = <400000>;
 	status = "okay";
 
 	mctp@10 {

-- 
2.51.2


