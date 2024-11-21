Return-Path: <linux-aspeed+bounces-165-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEF0D75BB8
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Nov 2024 04:36:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xv56940SQz2ynn;
	Thu, 21 Nov 2024 15:36:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732163793;
	cv=none; b=XZfTAe2BNgvVYEKxistc5iD91DrKfuPjsWrwA89nHrCM3CPl2TjJ21IrJeZ0mRyESNWgx30ZCl9Pz4plsZ8unL7f5KVumdilMV/E+uvirXVb77vYmXcC2utE/TvPsX8UO79mbXlvbSMREKRSrN+G8wr2kGMjVcQX9DnBJBsrN00t4siBlgD8ObEmsH876zItE6bFCc3mIFVDm2t0YHS0yrcm9Pa+znMM4H7VdFp8RYWQbjd/LngOCX3xENaBQ9VLykT8Rs2rnOhtgyovkPdTiPqcUAT388+Bt2agcaDsxdG4jiZDSkkQpSoPy5Pen8rJj/doMdZcXpJhWfDzXq3YTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732163793; c=relaxed/relaxed;
	bh=UevInCocN2jLKEDjfdowPnnjzWJX7MTz3LcpvW+drFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eRF4h8ev45eI1XhsWxlHcnsknNgun+ylT6jy1JdJDBuUY4SLBOJ/W43jVK/N1q6E3JTbC+zjnQqiLHiRm2f2z75Owpp9aFwEgAlKGkEEGdOioOLD2OH7Ij1wFPf6NXVLXQQh2NcEH8zbWwpe2iQQnQSfu9LE7jYlb0vZUwRd7Jh7uOEJbhikpVSeW4Co2nfUhJm8j8CmkKjA9h32Q3Q/B7NooaDe+dMy2EE6jIWGVYwRylBxQkz2ismrTDTrclElJFnID0pZMlcSGJoOKFsUc9s+2JJO8itKgdP5txqGoZHhijQWdqvF4pYm+u4y5+ofS9FENi0Mpo/bs5gSlSehdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=a+hzQblT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=a+hzQblT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xv5683qcjz2xgQ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Nov 2024 15:36:32 +1100 (AEDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-71815313303so242668a34.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 20:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732163789; x=1732768589; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UevInCocN2jLKEDjfdowPnnjzWJX7MTz3LcpvW+drFw=;
        b=a+hzQblTGSIuuKyxX+YUPLLcQKxqsgGF7dLOmMP7FPmid0nvcPycyu5TzNW2tYOB1r
         uvqPsxggGxg2xDyAM2zjkYQxCCLFcWGwfGib5YG7Ff88HjbVuYFswAzKMKXBVWioaKmU
         EE2NFXQxJclZBVRQvlj995eLksPC2TZPdUL46IgNlih4BywwVtMbGPkgKJv/v0g5Ms9o
         I3JDKRlhxrE1OlmmDGQDImSzmdgIE/b6DCKZiW5+e74tPAItVUHAIQG70msMPAUTWSJ6
         daI6AuZPjIhKbtvJD2ZW1zCWOP9QYA5DvgMiwP4yHl8iKoYLZfmOc+OYtr9UKK/md6Fz
         RlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732163789; x=1732768589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UevInCocN2jLKEDjfdowPnnjzWJX7MTz3LcpvW+drFw=;
        b=JlHB9/vOATE0KKBWK6oELdNRQLw/Vp0vY5/JOZVoGfP9t7zBm0j5mKvr49kTH+KsFK
         pmcw9ppv82rsJt8lgUg5Upfzas3I8ocxtumKuBQXus8RttQHiLD4t6dW19fWTiBu0wKD
         Nz33cziiF246LwpyRqlcGJSYZRD1nWLW/Rmvfz2M/ZaObeOAy5Rw0BtjON4G11KJ7cv6
         zmjTetwXJlgMp2i2Iwlkifrs2lL9DXvg1ku+dy4r8asj5BDiUHKSD4g2ujxLUx8SOoNn
         u1LiNCqvFqyJJt8M9U84/ewufG9L8ZdtVU3wmpV3qRJb8fwmndzmIPf/6/MLqZjJwxoR
         /XqA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8cvEZnp6A1AYaSpStfHvEJnshyOTpXQAdpkwWAGs3izhQ8LJZndNPP9fBJ7+q9cwjo/8rRoFlajCwOI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywr2tE9SGLbjudmfEovkdB0K+sNDu7dwdzHk+M0Ag3WCRuM91D7
	TsJhlWD6UDfWL1AbUvCMHWEApzeeyNVZWD9/DCkkZVhP9loTwMQc
X-Gm-Gg: ASbGncu8tQNPAi2FsKTjgKHD/b4yXDYJLnHz6UP7d6CDw56blWAD3WrttYS0MLi3r/o
	TOkfYPcSbqE+qblhg5owGdA8HM1OUq80ZsmiFTU9zDbFFBKqHEHYkFSCePU/8dbmW0ekPAX79wU
	I/KwDb/IbEhcoUMqTNq4a4e/x73tWUGG/VZ34R8Y8bVuPwWnDhkCmZOZbSvofxkYBSBRN3brTns
	y5JzOURX94sc/3zJgA/KjzHqz8VWzqcs4JS3kY2u8RR3CFqZQ1BMdleuOn3XF9PXG1pNXOnljpp
	MqVYvkWllW+4onbP0T9avoilWZI=
X-Google-Smtp-Source: AGHT+IFYTyomNdCSLziTz63F7jtI4CB0+d1D5UH4XVfUDTPgCy5dwnmNsWJzd0JPw6TAiKDObmCxpw==
X-Received: by 2002:a05:6830:1d9b:b0:718:9cc8:21db with SMTP id 46e09a7af769-71ab30c4f0amr5652274a34.2.1732163789165;
        Wed, 20 Nov 2024 20:36:29 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64e11fcsm402013a12.15.2024.11.20.20.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 20:36:28 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 21 Nov 2024 12:34:05 +0800
Subject: [PATCH 2/2] ARM: dts: aspeed: catalina: remove interrupt of GPIOB4
 form all IOEXP
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
Message-Id: <20241121-catalina-dts-20241120-v1-2-e4212502624b@gmail.com>
References: <20241121-catalina-dts-20241120-v1-0-e4212502624b@gmail.com>
In-Reply-To: <20241121-catalina-dts-20241120-v1-0-e4212502624b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732163781; l=1368;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=I2TP3r7v3bLpFaASEk3sitwyGaaE/KErFzQTxqzcCSo=;
 b=1yz+R+1F2tRf1pVQwB6b7UeGDBov/eQD2XeNyCVW4Aclu7N2Co//7rjd8jIyruIhsTFPDzw8z
 z76ouhV+ffXA2njqam7obRW7ftWNKN7mOYdL3UeH1CCZx0L1vuDxXCO
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

We notice this interrupt pin always keep low, it cause BMC stuck at boot
up until kernel disabling IRQ of this GPIO pin.

Remove the interrupt of GPIOB4 pin from all IOEXP for now to avoid BMC
get stuck.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 417c0d12635c..3822bb3c9243 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -593,8 +593,6 @@ io_expander0: gpio@20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(B, 4) IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	// Module 1 IOEXP
@@ -603,8 +601,6 @@ io_expander1: gpio@21 {
 		reg = <0x21>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(B, 4) IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	// HMC IOEXP
@@ -613,8 +609,6 @@ io_expander2: gpio@27 {
 		reg = <0x27>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(B, 4) IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	// Module 0 EEPROM

-- 
2.31.1


