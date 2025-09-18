Return-Path: <linux-aspeed+bounces-2282-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85E6CA1013
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 22:56:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSWG93RGcz2xns;
	Fri, 19 Sep 2025 08:56:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758188627;
	cv=none; b=D1p5en95v/Eqqy0HkObmXsF6ZMwJwdsVt7y6usOgv6aNIPseN1d5fWG3q8lHxTNTR//U/C21nDbQvuXYSMaj3KyylnWyS+ag6NJQCJwX0aZjXcw3X+WTzjwhA3pBUwm2bEcRVb9GQSe3N81QtB30LLgJQXX4Swkq0P0quDX6IhK9Zc7mHhVDDmFcIzxaCYRRq+GIuHZGayL/ryJuyO1JB5i5G0OrVzBTDAIOhvkcZmV6lqv498n9JYWgQ96W7Z5kVNxIxTl5Ii8x7CAaFEm1fN1xHRg4WkRc6/15CHOd/LiJOCLMuVNwbsq1fq/ZieLfUKGup88yxFilKQmnqy7/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758188627; c=relaxed/relaxed;
	bh=kk2Hrw+IHUis21BiwjLiEv7+4Iu+IibQiFHb8JNRLIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GJ7GOOsLcvzDiuEAvtwrYTAmeYK9PTaMuwyMaQiwdbm3zwi8KHMMjOrz+HMeRXsSZaG4PLcTXn1xGSRyOtctzWeMDZOTN/9azcn5ZfMtkEQxtd2wmQeyAHOeciGKNFqJFh9ccWY7nhUC0jeMl3baziJzWWyWi2CCtF4ZMANFPTEoFB+ND9pAPk8yaCqOdcRmps2R+ivgbKItzfOFhiN/LyfkV9o+szS/5U7Er7Y/vF9HpOvQP4GyAfOVuyxQVqRpHMM9aPiCvgj1UPwj58l4dHaKvmGPTCJpXBSsgCxgDCpyY3d8pbRZ7n5U6lcr4kul0L8MSm53ExBxn/QqywTdsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eJVq9Jso; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eJVq9Jso;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cS9gk2hLSz2yGM
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 19:43:45 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-329b760080fso583600a91.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 02:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758188623; x=1758793423; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kk2Hrw+IHUis21BiwjLiEv7+4Iu+IibQiFHb8JNRLIM=;
        b=eJVq9Jso23R29JKTy1WT6F4Qvh8u/hkbsL1MjZp/fSOPz8xlKWVOPNLzRQLNMJ7yU/
         gaXMr1JMPZRTH00xSjSjzf50iMTpZmGTnwvgEra43p0fwAf/vI1FxxFz/kTLmbtx1+4d
         tSIt4HctjmfW/2/NQAXgSWBeLbBfa3o6g+/D64bLQ+jMuP3tNWnyW4WM0VkhZH7nf2ox
         bDb7q6VH/MWti1H37kpFGbZNcPZ2JlAxGM0PfCmRm2jgoCy4HP+YtwHjsefc/I9sPKlp
         Eg8BVFFMNvQQCeZbtd9KGkrfwSKd+4kIzP3G13WBNb5hmmSeXd/tMQybzkp5OIE+smxY
         0mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188623; x=1758793423;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kk2Hrw+IHUis21BiwjLiEv7+4Iu+IibQiFHb8JNRLIM=;
        b=lSfs8gruz+lYAY61hQMJkqor/VAQGNMZl+KaFekJScZWBzNaCHP2z7yyQz17ixDPs8
         fY5yZNa9QCyM3q5USn/j/5dmXk2rXRm9eqv5evnT1dXDcC5qiz5+AHDFAF2OzN1WLQcG
         9ZN/NWGf7/7JReMQw9A+C09qS3JXFdthu4IRLZ/qwrXzp/iTpo8N5LQ/uD1yLl5+uUHY
         zshlLhZQuB/sX+LKwlbphuPzvkNLYreCb/MOPYemRK7F4sq5TkZ+5v8aqWs/dvKPcx+j
         H+YO5Ki+Au3WO3jlhTAbLVXLa7IGq/Gs5e0P2rC1VEIzXGiUMyOR6vfhq/CVx3mJe1Oe
         C0rw==
X-Forwarded-Encrypted: i=1; AJvYcCVmKEq7NscR10Q/ZwYyByyOGm7eihkH1Ux5a7EGXd3XgfFV5Xno9La5D7n8WTJ8S9APTvQIO/iv5BY5+bI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+fJVfIW2rSYz1GM03r9nlWuhIyGMdp4wDpxIMH0r0E0t5CiUz
	lfGKgu9yjvrdYw+oSJM+r+mLI7AIbtRZtL6dU1H5Xe18o3RQ2DmeeuYP
X-Gm-Gg: ASbGncvXUpXGpTiDkIz2vGLoqiYHZPG4fjDVotHG2u1FWr1bBRg5Y/zamDOJJ0lGwjX
	5OrHWYX7Kc/L7R9ZRkMSuf1bJuU5X0TnP5l74fsEi4NcVRVE+dn/nGgKA6NeaOkx+KbmY86GQny
	mFmefibZvjnBPYI1tGsiA3Tns4uEJPtiKzhE1qFbeIkEg/CWrPrMxvvyeN3bvEyH8eSQgh7cs2b
	MpBeLx8FYRNMuwA7DKqa+xxw64SLLY+ntZPMbb3WVxbVd5ebHwTTaFaZmxTviqh9bhwIv/eXgT5
	TaW24z2haVVT3aWZGCXNY4QqwiLPZczOcythPURhKmhFNHmpjPJXfaTrIZryC9X0h/KVjwuG30U
	4X48x79/iBqkDju2Zznw9ZQ8CiOAOSzf7Jqooju1JFcofzmg4UJgtLHkMcmey3MFup9YQuFiO9k
	2x8Q==
X-Google-Smtp-Source: AGHT+IEgGE0BeH1F+4LDtstgR4GzT3dQ/vnKSyQ7aIVQt/aTAyZb2ZsVJWml9L1MieY7rFzbad5a2A==
X-Received: by 2002:a17:90b:4c12:b0:32e:5b07:15dd with SMTP id 98e67ed59e1d1-32ee3ec22b6mr6516497a91.1.1758188623083;
        Thu, 18 Sep 2025 02:43:43 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed276d2f8sm4886810a91.24.2025.09.18.02.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:43:42 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
Date: Thu, 18 Sep 2025 17:43:06 +0800
Subject: [PATCH] ARM: dts: aspeed: clemente: add MCTP over I2C support
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
Message-Id: <20250918-leo-dts-transceiver-v1-1-3e2580325edc@gmail.com>
X-B4-Tracking: v=1; b=H4sIACnUy2gC/x3MQQqEMAxG4atI1gZsZWD0KuKitL8zAamSiAjSu
 1tcfov3bjKowGhsblKcYrLlCtc2FP8h/8CSqsl3/tMN7ssrNk6H8aEhW4ScUEaKvUMfvQsL1XJ
 XLHK912ku5QHFt0+wZQAAAA==
X-Change-ID: 20250918-leo-dts-transceiver-edc31e3c21af
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758188620; l=2154;
 i=leo.jt.wang@gmail.com; s=20250618; h=from:subject:message-id;
 bh=nVDRdbCkjgVW2Hem9dJFdrSJ8lRD2Z2Fl11Ez5/qXTc=;
 b=gGwy/tJbdh92kaL3iGxdJ0l55f8lVj/pdra8VUU6oBnNsmqeDhiUPxiVekZn/UwIGlSAduWaT
 s65s9f5gLsNBz2gYwdLOzqRJ9FmS9d3xS2QLQLwQXoz1a7on5CCimYt
X-Developer-Key: i=leo.jt.wang@gmail.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

Enable MCTP communication on the Meta Clemente BMC board:

- Add an MCTP I2C controller node at address 0x10 on I2C0
- Mark selected I2C mux channels as MCTP controllers
- Remove unused "i2c-mux-idle-disconnect" properties

This allows MCTP devices to be discovered and used for
management communication on the Clemente platform.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index a614f947dafc9a6628c3f3d45b62ff3ca9d2b618..a2f0ed6e7bbefbdcec33f7ddebdf2de62adec164 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -269,18 +269,23 @@ &gpio1 {
 
 &i2c0 {
 	status = "okay";
+	multi-master;
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9546";
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 		};
 
 		i2c0mux0ch1: i2c@1 {
@@ -332,6 +337,7 @@ i2c0mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 		};
 
 		i2c0mux0ch3: i2c@3 {
@@ -457,12 +463,12 @@ i2c-mux@75 {
 		reg = <0x75>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 		};
 
 		i2c0mux3ch1: i2c@1 {
@@ -514,6 +520,7 @@ i2c0mux3ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 		};
 
 		i2c0mux3ch3: i2c@3 {

---
base-commit: c65261717599d419e9c683d85f515d3ca2261549
change-id: 20250918-leo-dts-transceiver-edc31e3c21af

Best regards,
-- 
Leo Wang <leo.jt.wang@gmail.com>


