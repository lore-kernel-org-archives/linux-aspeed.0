Return-Path: <linux-aspeed+bounces-1080-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3B4C28B30
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Mar 2025 15:24:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJTs35Nx8z305P;
	Fri, 21 Mar 2025 02:24:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742484279;
	cv=none; b=do8HjVvLRgXe923ufL0nT0f+J8dLbAvnUy/0Cm/2ieJmEixmbXItdyg8AZliHk0lbMsliuz+3byds9TWcrWwmG/tSAVf9G7bro+GXSW+Owmuqh7picxcE0tOw+LTfvfpoQs7lih3q05vOsDD9m0i55I2jtxM9FiBe0aOzRmJ+upDDYM4La6qWJjOMBL5Xv+RhODTUTiXfpvz+3zPvjJQ5HY5cSIlFXBtqgMtoeI8rE4H6JVHfqLRytWpb8CuuxzsPtmmtxYt5HgA2XDxeLq0NPqaw+nsXJd6x+O2574S3KJ0OLyIq0/y0Ht7cQhVmprxmAZKlpJ4YHlFdTvaJqh2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742484279; c=relaxed/relaxed;
	bh=05OyaXbL0WKbLYpImlnz0xJZmG54ud3JNw7Cj+unigE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AcjIIBB0IXHDimHmnQ042pOtgk3Vu/QC6mfoadvE4oHVpZBw1aVZlibhzCqcjzA7jFrZQ4MjVVDV7V8M/PtIu7lRKGeZN/YSTdEIYwID75G+WY5+9C8/7HJv9/S6axjTXm1HtpJTTWMHrXnOiCJjfXy74DjsJiQg86TM/J7/GKtY0AETKQm57JS1Mwb8j2vePRo0CZY+ScTThdEAYS0EQ6rWAPHMSPlcAn9qsb4ifQkaX8oed04aLJjav1fUKEDosqODDqXK0iSliZESLjke0PhFXm0jA2n0D74h8PYgWalRIPs20z1AoPy+8B4WyeNPzn+IiQRE7kyjPJMWqz9USQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Fg4LU8OW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Fg4LU8OW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJTs271l2z2y8p
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 02:24:38 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-225a28a511eso20990385ad.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484277; x=1743089077; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05OyaXbL0WKbLYpImlnz0xJZmG54ud3JNw7Cj+unigE=;
        b=Fg4LU8OWlI/EvSLzjTxiLFrw6VQmuEyeIgX6vQmnh+GmT8470fy5lEKA0FE+yK4Y3+
         0jGRD+JLvsqoh8w2vE1BMCbmkal8Wtphd8JMSi3k0vhC+5x/G2n4w4m2wub1Iz0ztUNk
         wwvYtG/+PVhZMynW4Eh9Hcx7Mh4Wze3PzuM7yiJ0zDBhgTQ/pIJt4qFnGwPPIZzd7jAQ
         8ZfScObmO7nYMG/csxBFOCuJN4jYicInEN9uCh5O0kX65Sv5b6ivbh4gAH+v6EhDHg5T
         fYWRcfIBdToV0Oo05vp1g8AncCmWVlpk/3Kn6fILh7KLn3ut9Na4zMmhreGdKirjTodi
         UllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484277; x=1743089077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05OyaXbL0WKbLYpImlnz0xJZmG54ud3JNw7Cj+unigE=;
        b=swrO9U3QBJrneZqqiV3wWx1rH3IwTskwD0RJunTk7wySJvrWTBBw6LuVg0SqroMrxG
         oUtUV7sN0VbBVbSzmgP8Jxi2ZPvRIRMbtydo79glM6mEl7S5Kg+9UxQp4XAIGLRlQ0ZZ
         shZRRMxCdm62t06Mc/W0t0WBwWtlUiUQT3qyM8lmoFTwBe2KyG4mJj82VMmKBGlMGsnI
         jAvZAV6/75ttL/4z97nbnB+PMAoZ3cxQKCY5pVHrDk7pLSMne6xyCWRsn+Nzxqnbxw+8
         lglEhRoLNptBZWzuBHI2/QjAPo8yN2ACuOVBsuSjA5v3NaecTiyEuaNyECKq4w9mugzH
         0jEA==
X-Forwarded-Encrypted: i=1; AJvYcCX0SzZ8sxfdNpKKj3fLNkHf0M5ZFfs8z0QC7SOFFVKj6FgBveg+ejJBKJ6ZIEZ/6R35tYCQvCfgdoG2Hfs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwvCqdgKJ6yGuys6/0YRmw792w0ea3Xh8XS3JhK8GiS3r1GzNJT
	N7ixHiWBz70375SmjnAfwHJJeQMQnf2zXO6USGr0YPi6XQPxeHjW
X-Gm-Gg: ASbGnctX+S7yFiLpUlSz7BRj4yxcdtY30YZ0/arUjy8am1CP1PJGXLOS7KczZ4Q+dQh
	/2QWoWnEdTVVTPhDpbfPbsVZvDYjyruxSov6p+FvHxSG+zeGftf8A7jcJjI8vqqvYiIGlJMO077
	CeKGCNjd28hpzo/I9fMcIy4Bl0pXSIudIL3Cc2vo/8LPw2uMNeVCgdSxUQGv50GovVGtXHFD4AK
	Zb+pJxONZ+rvtDXVuPrdFI56j2W2c95KPpSYwKcr6jaZjPWyD8wEsiJf0XDeABinldIbGBzuulU
	7/n8MhMPzOTgJOec1LYp66S+trulTjV5yZmjjL3NXkPJT3SZEdkM1wY67TUy08FwSxZM7rIBOE8
	SpNpo9+J9SPR/52XlAYVqrw==
X-Google-Smtp-Source: AGHT+IHj1hKtEvHY4K2obRAbNlNDdOGviaxrQInMcRrSsFARmQxza4ZWUoKeC3VbewMkZiKEd3E/Ew==
X-Received: by 2002:a17:902:e952:b0:21f:6fb9:9299 with SMTP id d9443c01a7336-22649a39147mr113462995ad.27.1742484276613;
        Thu, 20 Mar 2025 08:24:36 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:36 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:53 +0800
Subject: [PATCH v5 03/10] ARM: dts: aspeed: catalina: Add MP5990 power
 sensor node
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
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-3-e161be6583a7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=843;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=BbOh4hpBKP+yiYoTLN8aSP+ooMjZZlQ3ZAt1eegwZSA=;
 b=t3XeTPeMe/feqDs5kyWMJO1V/KGXDZV/e8pSivSrIpjBo0AGxGT5K/40MgRoH34PqMC2NE2Ao
 STCG4dYtDd7BiMAKbAO6DBcz7ALnIqU7gxBuIE9ZodGDZH1RkiU29DZ
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add a device tree node for the MP5990 power sensor to enable monitoring of
the P12V supplying power to the fans.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 307af99e833c..f5f47245796a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -428,6 +428,10 @@ i2c1mux0ch0: i2c@0 {
 			#size-cells = <0>;
 			reg = <0x0>;
 
+			power-sensor@22 {
+				compatible = "mps,mp5990";
+				reg = <0x22>;
+			};
 			power-sensor@41 {
 				compatible = "ti,ina238";
 				reg = <0x41>;

-- 
2.31.1


