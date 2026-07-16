Return-Path: <linux-aspeed+bounces-4488-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCA6C44501
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jul 2026 02:34:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0xty0KKVz2yT0;
	Thu, 16 Jul 2026 12:34:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784169241;
	cv=none; b=fJYTU2GFb/hHg5jdsvxgoy23Uc0+7128lbBSBwNeb1LfKlilePs+xdUl7KVLHMZGWWFTnnVt+Nwm5oxsksp7s7LaTKrl5R10xYE8YAETFjfkSbahV/97Pzmc6sAUrJtRgMQ+cQabIgYwo3SBpCLF+fbTcb74P80ijQTFhBEUxTQG4CxPgpzCXCpAtY8EWK23XO0BRkA5ur7Pe4JkZKA1XvmUHXaIuuqPoWYmgHOekJGaO28J+KAOByWLQ/A1Us8UjQSIDrZSF4w5MRiX4Wa5A2HYLF1yujayt3WVX27rDLoqGdNJigpy1yW8zBJ09FACV5L9uN3Ic+F0uG7ZVv6jsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784169241; c=relaxed/relaxed;
	bh=ufvoepbkxBTccdbf849+Ndmklty3uX56AMakRenyADg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mC9rl4j7ofxuoQK3OqVPNlOxlHukIwq5ixl3uDtDp5uJhYNTRsR0/86rR/nXiqTODnvIs7bFyYLfofta5kekAoLsFy2kDagPqBx9MTGAQQM5XnzPEShWFoDPIhYaG5GYW7SamLWxxvJD3il8ytMRqF0g9mXUGUVYGJhOZ2V/g8Xnf/Oqi/1JIe53G691Cf/SlbgJqDc5sxf3Dfd9sz7liexJ6KaBg3akFn/i6J4ppep9PIFq8OONN8rkSio7gZ0D4m9egj/geQ41jVGBiLRU8/6sQv9U97K3MZSGtiIBjEVHSZOgJvFpd+iYnBkdp7XLCPDiRMcBv6F5dO2bjueuAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kOwPzAz3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kOwPzAz3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0xtw1s6Jz2xd2
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 12:33:59 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2cee9b74ee1so27160345ad.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jul 2026 19:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784169237; x=1784774037; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ufvoepbkxBTccdbf849+Ndmklty3uX56AMakRenyADg=;
        b=kOwPzAz34E2/yNgVEnvWWz0VgDK1+W32Toy0oPmaLggxsgN5FXQN9Y2yQleReT5VS2
         cHMsuYPzRn26jwhfUTKaZehpfD775k1ahBm4RkTjfjzHfWERHm5lP/FthwiBl5F82jyR
         qriTEFTFAetFgUTy7lEFlnrwkKG26uaWVD/bPuCvWJ5ikYxpJRxt7HGNQ7lQqe9wyvwN
         tm4hAz4s/0YHZsqZ0ryKB6ifdmK1esCvzgBRm9nSVoPDivL1ESMAAXPHCQgILfZhcQhL
         JHYDkgoSilAr+Q1nDSDLwJ3VUUZZ1fuu+FSHnYRuqpX+zQl1KDdO89ISx88gv/obuKah
         /I0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784169237; x=1784774037;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ufvoepbkxBTccdbf849+Ndmklty3uX56AMakRenyADg=;
        b=btbvVF8hgbFU9P8Y5BSudELIJ/NJHeiVRn+WpFY0j7T/kqCQeKt7vAk0Jv5I7lWbS0
         yTUn+12NH5WCTivhl0d6Cx1hxV7sjSUH/VqBk22bvoAomkHJec/y8oDFBJH3GcCBX9Ck
         Quky3JMxRNeKJ53UJdQH+Fzipju9ZSk3CmC0P+/HwRX3VOQ3I3x4K7oJO6pegCjYjaRf
         yDlc2oB6SNYSwQX9RWZ71kBUXdnlnhLJMVuQTo2sq8dx1RgvOVcLJnJVbP/PaDvNeHz0
         lJGmvg3ykrnzKjREZeHfQqZQc1zedNDwVFhtLLiNwAX73gPNwf6o16H9+Ps2krhpFXrW
         cQxg==
X-Forwarded-Encrypted: i=1; AHgh+Ro+L9HK+VAf4hN6SKfPPPm7Ds0stP3Ew66JZeu307SH3n9ZJW5nCCyhnMIhVE/tUWt/vTl4DR/sdaQB9B8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwUrBIZjGp+syBgQ4BN3grfqLphdBoGZxY5/2c35/OSrrjNDrOe
	T2iUJlT84ovnSUWR2NQSVrafxgMRSLZuMX8PSQpsin60vi2cbKSfhOoW
X-Gm-Gg: AfdE7cnj9+PRTasxq7V1UAqL5xyFkvAg6ghta4yEN8f41VCCkk2yy+ZIGdBqOOhGKpe
	OgyeAQw4yNvN7UJ+lvhze4+20hZBFPVM7gvlvbKQVjyT5qaceG90pKE7EIlOJ8Dg5WC+73rnqDf
	L0knPrSnxmyqxtsrsvL0uEP3fOfBSoy8wyFPgJdUJEe0AKMKbeq/a2Bd9LqCQA5so96Q9SrvBXb
	S3ida+wDHaKQ500e2vUNjl2+RnKnUo7rOiQiypImReSqt9raTZjvhrF6qfqKjz0yVEh7amsFdMc
	7zwX6YV5MykPERAmu9k6+2hoo78UQEhv9B4ARSpJ2M+jKN8RnjqXML6YqXbVmpEUfTgQ86UkS/U
	5QF2V7RsVMkx5eveYnSAXJVki+r4mKXh/wXzU2/YQ49V0uQ7ow/n867z2p8hBNSowYAKwW5SQV0
	1wtJHac/5t1FOz3M+y/GLdZRG5O2iLENWO59RNymR05HbhjxxUUU0PVrs=
X-Received: by 2002:a17:902:ef0c:b0:2ce:ed59:7044 with SMTP id d9443c01a7336-2cf03da0b8dmr49619015ad.30.1784169237122;
        Wed, 15 Jul 2026 19:33:57 -0700 (PDT)
Received: from [10.10.15.228] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf105bc642sm11540255ad.63.2026.07.15.19.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 19:33:56 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 16 Jul 2026 10:31:17 +0800
Subject: [PATCH] ARM: dts: aspeed: sanmiguel: fix PWRGD_RMC_N active-low
 hog configuration
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
Message-Id: <20260716-upstream-sanmiguel-fix-pwrgd-rmc-n-v1-1-8287b306e02a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHRCWGoC/yXNQQrCMBCF4auUWTvQdBGDVxEXSTrGERPDTFOF0
 rsbdfnB438bKAmTwmnYQGhl5WfpMIcB4s2XRMhzN0zjZMejsdiqLkI+o/qSOTV64JXfWF+SZpQ
 csaBxFENwzk5koYeqUJ/8Ts6Xv7WFO8XlW4Z9/wCZYzsfhgAAAA==
X-Change-ID: 20260716-upstream-sanmiguel-fix-pwrgd-rmc-n-18ecbb8862e6
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Mik Lin <Mik.Lin@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784169234; l=1357;
 i=potin.lai.pt@gmail.com; s=20260522; h=from:subject:message-id;
 bh=DcxIBTDfGFMcjuFLqAGUh8B8eNoT1j4rQhiygNTbZAU=;
 b=AQKaX++ClRwxml6UKIVBauBZJ8nnK2N/HuEGZjzFOYDNDs1nhvSfaa7KcbzWT81FNH/I24l0P
 Z/PKYqJgPqvCg8F7vsL5rVg7sxRe2+PIyfIT7ci50DeBG3axZfL98LE
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=j3/nMxzz1ZPpp1revghyZ8IqOnwi6RWfuxXN2XrNMRE=

GPIO 14 on the fio_ioexp (pca9555) controller corresponds to the
PWRGD_RMC_N signal, which is active-low.

The pwrgd-rmc-hog node currently specifies output-low for this GPIO
with GPIO_ACTIVE_LOW flags. Under Linux gpiolib, configuring an
active-low GPIO hog with output-low sets the logical value to inactive
(0), causing the subsystem to drive the physical line high.

Correct the hog configuration to output-high, which sets the logical
value to active (1), driving the physical pin low on boot as intended.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
index d7ed497d7227..ba71f1f9768a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
@@ -592,7 +592,7 @@ fio_ioexp: gpio@20 {
 		pwrgd-rmc-hog {
 			gpio-hog;
 			gpios = <14 GPIO_ACTIVE_LOW>;
-			output-low;
+			output-high;
 		};
 	};
 

---
base-commit: bd22661baff3295747e864c8647003e8eba46dd9
change-id: 20260716-upstream-sanmiguel-fix-pwrgd-rmc-n-18ecbb8862e6

Best regards,
--  
Potin Lai <potin.lai.pt@gmail.com>


