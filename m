Return-Path: <linux-aspeed+bounces-1857-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE84C87FC9
	for <linux-aspeed@archiver.kernel.org>; Tue, 29 Jul 2025 23:18:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsB9J527Jz30WT;
	Wed, 30 Jul 2025 09:18:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753780449;
	cv=none; b=KKBiUMTHUH3u03F5Z7OFyeceIInXMBKbAnjrur1Fw6M7VNAk6XFaXWG5BgpKkahf52/v7cIYy6cydH//EyTjP4Ouc96oC6I1lYPAw4+6miq7yzaEjZSMOvuBLGhs5tXAUUMKtpTlvZs0ilznJRhs0kZ+CJ1SG90mJNTmuJvd1zjnTt4ehA6/AUM52rz6lxHaDW41wM0hJZhhgHUdTV1hf3sYPjSmOjmJnyV6RSKiO6CPtC8U0WuusVnrprlgva6ocV3YqGkW8Mac0w2s5X0jAPQkBtEynz8f+fxzaBZnO+WAT3T30SYi1ab3tY2iQaXyGZrjT3QHilZl4GgCShhzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753780449; c=relaxed/relaxed;
	bh=FEtF7qEvsNXTmyOD1T2fZBfkSHd2BexV1VORoI+Vnis=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E03bkj2RKsVpwerW17sYJxuMW6jqJUpcwh4XEj8hWzrzbpokM+UKxMP43uYGAS2E2GRBojPNGMvRbgksupZle1VVoTbMoMDJZ/mn49RyHiDCj5rmgolavNzdj+EaZPVVf6jIc81LD4QsSctHbpE3iNkZ2zzJ3TMYTybriEYqFQDhWxdXH3L2CMh1JZr791TYrODAMNFVk2ai04NKL8rZN1qXrFvKrLqn/brONblAx0WV1I3mGCBKJjVa2di0rb09sn+nkfWxwMWMJ/k6JU0NJV4b3CDGmUbaK1TJDwNGDToqrM2OQ2I9lw1b1X3K7PQCMylqBq8R7e6hbY5T/Yy99Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gEXkDKWv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gEXkDKWv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4brqR43z1zz2xRq
	for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Jul 2025 19:14:08 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-7698e914cd2so794702b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Jul 2025 02:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780446; x=1754385246; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEtF7qEvsNXTmyOD1T2fZBfkSHd2BexV1VORoI+Vnis=;
        b=gEXkDKWvkI/IQOtA2ZhMtouQ9AbM2soiYpGqptJdxdp79LFp9SvKQYrnc6zkmW2eH7
         +9Xc9ng71nr3mtMFxJzkzopj4IV4jcTE2sV3khvdRw/qWBDOAe3F7NlVz8dqIWyFaRVC
         mMQ6jIlFOJIXNecKokcTN9S1XroQMuPZyJObe+TGDfWF0ZR0nWRakjyhbFPvYdB7dmNJ
         HK7nmVnDPMIjtwCjx7qlbPYT/voMlxtcNldPYLvyu5XDvzEIhL+XRok6RgB6MXxNcZy9
         pUxyR1MzTEfx+C0d3npJRR9DUeEmEdCZvUCLpb6zHzrA4TqTfOA/BziPtpUVmJ3lpw2l
         kTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780446; x=1754385246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEtF7qEvsNXTmyOD1T2fZBfkSHd2BexV1VORoI+Vnis=;
        b=fGztHqw43lWcyPqY+VdBqlpwJ1uvif4AvHQlleOew55nr3tKYMvsOtKxE8JxcAxKrW
         A2QNVZi2o0PCq3RkjnZPfcaiU3O8/Z4QDHKwJxMxIuOmxymLGIcqEzMpf8KIwnwLz8TE
         64MLGdBnU5S8CYLzrrPxx/DAPkFW1iDKxn5qYA/b2bHGfg9fWOWoS+E1x4+lKq+J52nT
         Yne54xyxNyMa6iFCi0miwiA0bb9IGjfSkactELrye43Lj51tBhziQap5mFabbyqrOYJw
         1vfyOZVBGKonvDhnlIwOdLuh7cybafZ5btj8sR+xx3YoNtcN9ruQ8SrMpppVBFR49FfA
         ZLMg==
X-Forwarded-Encrypted: i=1; AJvYcCVE/EVUSDXEUOUekEHxQ8gxmypCuN1srj62NNN1XqqNLGGdXm17I7ztTliPGLWjDnEVCAOLRVrrDQcVQzQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy5b75dBaU9FBR7GpBWlQ7xN9FkPFH8+jnsyAu6karkRWtKKUJ0
	L7S8tylqnH5Aw19V83arehFanUJWkwRLcRR6TX1uY5c8rlOsYfDzSfom
X-Gm-Gg: ASbGncvVl+j1tu2fYsx4D/ibjOF7wngR018iVt+9aiI2ie8CZOCinl1U2+Dxu481Obk
	/GxmdhMgEs9TOdzdK0ymGPWLCSl883q+O53vMBfjcyxggh3AOjSM7Yq4K96Sg0yDF+f75z8IrOA
	FmugMYxdbF5CeiNet7KuTMC0Ms04asQ7fA0d8Na57JQ12YUn30oYBdkCb3FD0YvNgeGmuol3wOD
	VLH8IGNq8n3BolPKkKsnxKq6CVK0CkAJBoO/QflOx52lCQ6S1MRCvQ04JqsX/19cRQgBTYqMMWN
	22h+XHUBtRvy1S69q7YN8Z4M7S9FllnZ0s4PvjL/6QqeihEZbgiYTv3cL4kx4tn0z+MdEZqiaer
	DiJ8HjZ9KP3vGMyLRcceWAVHdAKq/2Ke5IanUIT90SD1hfAW1hXKcCAWCLOddskEtMKr5aWWtxQ
	C46qnGUjEzKN3aSEl30zqZdN+hhgni1gslb+8wq1wWswwM1Qg=
X-Google-Smtp-Source: AGHT+IGZbRiJ4XM9/7SP0TbANTsh6WCA507Pa7WbbQuyrxdcEdrxbpHYh29JWvG1Csf/3GaK7l82Mw==
X-Received: by 2002:a05:6a20:7491:b0:21c:fbf0:21bb with SMTP id adf61e73a8af0-23d70171d80mr25597800637.24.1753780446288;
        Tue, 29 Jul 2025 02:14:06 -0700 (PDT)
Received: from fred-System-Product-Name.. (2001-b400-e38d-c586-0429-5c72-053d-8858.emome-ip6.hinet.net. [2001:b400:e38d:c586:429:5c72:53d:8858])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b06ddsm7528612b3a.121.2025.07.29.02.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:14:05 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] ARM: dts: aspeed: santabarbara: Adjust LED configuration
Date: Tue, 29 Jul 2025 17:13:45 +0800
Message-ID: <20250729091351.3964939-4-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
References: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
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

Add a new power fault LED on GPIOB5 and relocate the ID LED to GPIOQ4.
The ID LED is now driven by the CPLD, allowing it to reflect multiple
system states depending on CPLD logic.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts  | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index ed30f3bf61a4..c7eb30e5baad 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -94,7 +94,7 @@ led-0 {
 		};
 
 		led-1 {
-			label = "fp_id_amber";
+			label = "power_fault";
 			default-state = "off";
 			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
 		};
@@ -104,6 +104,12 @@ led-2 {
 			default-state = "off";
 			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
 		};
+
+		led-3 {
+			label = "fp_id_amber";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(Q, 4) GPIO_ACTIVE_HIGH>;
+		};
 	};
 
 	memory@80000000 {
-- 
2.49.0


