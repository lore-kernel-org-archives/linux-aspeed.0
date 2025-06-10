Return-Path: <linux-aspeed+bounces-1341-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A3FC5B552
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Jun 2025 17:04:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bGwBs5mj6z3blF;
	Wed, 11 Jun 2025 03:04:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749575093;
	cv=none; b=TYXZIPiSBbP/Zqiao0Ple0pksRuheFvmlNJ8Ec/gVzHYshFusZP0u7/Hvb62924m9tnDe4XboNfPu2WcPjpERASPkpUzSUi+UqUsxTdMWtsJayGQyesa+/B3VEGk51RIUczw+jEIXFNw9eIQiPuir/kz05s4s3G3+A6ERVT0LN0n/6rOT9jNjTyiPgaR6iey/9ixtd6S7exdRg0QHQsfO/nC4UXynl9NtN7hHiZtKYsL7jx96vm8CceDwf5ueB74gL6lkE4XbTLCW0Zi9TST6sl3ZWm32t01FNgXX6EZi+ZWTW9x3wqEbpEpmodTlWHcC9IxDGuncUyieENGn9OD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749575093; c=relaxed/relaxed;
	bh=l1SAMsGs37SGD+chia/RQyRlWwAaxqTB5CEOsEmZAX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V9CycaTThUmas2jUh7+3NI4dxtV0rUfLEaEz4UApCB2cOMxez0/GlkZt31r8brEKUPP9HyPjgtctJaOFRAVuaiPYepklDZdQgmf728/BlY+o0V5QnQeZw3ws6cdgLpAPgGJMZU9hb58u/QSEWsJAUMjtyQ4XEa7LERynN57nZU49cNS/gcLoCV4xq2gyAss/CW7/lKOTnA+3KPA0c2DMx9eQcrsqE1P4CvWpIS50+sNbw8PLKykOEXiXKfplfgAnjL8inKvEtJ/4NVLv9bVBzPQuQ1W+9Mff/we+yGBvmBcMzLDgovWXH+FeEd889+xI67nuI0mvnXGo/VxlTdchHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=evc+1ZJM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=evc+1ZJM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bGwBr3DMPz3bkg
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 03:04:51 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2353a2bc210so49886585ad.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749575088; x=1750179888; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1SAMsGs37SGD+chia/RQyRlWwAaxqTB5CEOsEmZAX0=;
        b=evc+1ZJMN4hnX6w29Z6RyHi8M1/DE6SItsDA9Q3RlkFlyhbO0kdcRFA9W0CRPSw0Nn
         KMeH1JA3VJcytxbFtPnLXJbkR6Qt3K1ato1kkBKuNSCR/aTmI9FNshqLhoYi5hWmK69M
         /bLjZPh3eT7ndavrUzmjnaykCrequBuUQIuv4br5XDnnjcz0fGhL/KNcfBWxsfQK7dyw
         SAXAV99LRDKyPKznfBxQNmiLh1TVsW376MIk77e0mjGCI7Y0guN7NlizKG3AraasgsAR
         0dK05mLHyEgMShUGuMk2daZl+XNVXn/0KtRWFPvCDl8pBsPV/ms8NNaY0nSx2CoD5vhX
         a2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749575088; x=1750179888;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1SAMsGs37SGD+chia/RQyRlWwAaxqTB5CEOsEmZAX0=;
        b=WRLso8e2N0lN3WiWoZsWf9jUO2LyQxNoXmL5OO5yBpB78NqDRJNQSJ8kpWywIlKayx
         AIkvGo/lhZkHKkNxM8qdNq3cYHocRzmS65xzvg5m/YHfPYT2+CUE3ZMH/df46o8u0RGu
         p4+MpKAcDYG8gYzPCynbqx9JE2GidXudrhUMN9w14T2NHk2/p5/KqAz3dbqmVZho60Og
         ko0C2I1iRkpYv4GEbvsljRqNZsMIh4NvdrRYWI/OR+yCIVBRi8EbK1A3UpNdTJ1CVTvr
         udY0AOrIb+0mctug9ZCUWP9OMBJsOmSae2mDs5RCMhXZN+qy0iRg8OpoK0KvyTT0NOTi
         YPVw==
X-Forwarded-Encrypted: i=1; AJvYcCVFSNVEfB5kot5IqhxW6FUNEmrhchGRq4Cw3Q7Ti5VXYPbjHSWEbL7cAtCqM01rdpGX64ww5mjhpUeRwMo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz3XOpqfWYMkEXaHoPmNMoZWdq5ucxXzLijjjAiPQhEihk2V1/R
	op9vaZTKYmWqxWeryenzAMut7EI37HGdXhb+Nx1MNyZiVSrH9GnrdCsj
X-Gm-Gg: ASbGncsUpxW6QAR14cE0DpQf/OWyRRzjYzGVdGMc/agTiDqxYcRWOeZODliFHCBDILv
	VaU0VtitWmyD+GybXcyAT6ZZcrKDsg2Z0iaa0PqKPQ38B/QM3S0waaBgmXcR7PLtAUp86o0EM0H
	bgAN178pO1Rs3Bge0Gia9xX3HhfsmMBwjNxiLh5YWRWhNxFqLi37n24XhO3GxMWZcCxBtRW6FBF
	RaesmmHghpWhajheuFSwkAJnlL5qUsWoCgkmNR2h+AE13qp1JezyxrYKiv4wlJCWINdegN1FKJk
	nhaAC9nnszgkddpnt27g0ZSR1Ew+t3wxtxncvO3s82lJzhdusi9kQywfADdNAkumvo+Ofz/VM57
	aWokRXKEkGujHXFHbnkIfrkYulIzhGX4ErhwhFOFWKec0zHjcMg==
X-Google-Smtp-Source: AGHT+IGN8fWm1wd/rYS+vEB4RxNmREuCEW79sACTf92qnjh+StZfwWgh0XTKc+e8n8+kZsmS0X1KRQ==
X-Received: by 2002:a17:902:c94c:b0:235:81c7:3c45 with SMTP id d9443c01a7336-23641b26eeamr523415ad.46.1749575086817;
        Tue, 10 Jun 2025 10:04:46 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034065edsm72958615ad.185.2025.06.10.10.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:04:46 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 11 Jun 2025 01:02:09 +0800
Subject: [PATCH] ARM: dts: aspeed: catalina: Enable MCTP for frontend NIC
 management
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
Message-Id: <20250611-catalina-mctp-i2c-10-15-v1-1-2a882e461ed9@gmail.com>
X-B4-Tracking: v=1; b=H4sIABBlSGgC/x3MSwqAMAwA0atI1gaa4v8q4qLWqAGt0hYRxLtbX
 L7FzAOBvXCALnvA8yVBDpdAeQZ2NW5hlCkZtNKlqojQmmg2cQZ3G08UbZEUUontWHNbFJUa5wZ
 SfXqe5f7P/fC+H35ZZLBpAAAA
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749575084; l=1422;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=FeGGqTV3hMLvtuAUwQjWTQyZXr9HDJB5RrZEzdTh77s=;
 b=lRWcKzdCWOshs6fYek3iMrxbKcUD0Q0b2Tn4RqRTi0y+t19th2ZR1mJJ/o5nxpConHX4xZfj9
 M55WJ2w/KdyB4EiBoVxPni3QOtFCBWVk2dtVdkjJqPvrVw6cQn81u4y
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add the `mctp-controller` property and MCTP nodes to enable support for
frontend NIC management via PLDM over MCTP.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Add the mctp-controller property and MCTP nodes to enable support for
frontend NIC management via PLDM over MCTP.
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 5fb67ad2d777..8d786510167f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -797,6 +797,12 @@ eeprom@56 {
 
 &i2c10 {
 	status = "okay";
+	multi-master;
+	mctp-controller;
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 
 	// OCP NIC0 TEMP
 	temperature-sensor@1f {
@@ -926,6 +932,12 @@ io_expander14: gpio@15 {
 
 &i2c15 {
 	status = "okay";
+	multi-master;
+	mctp-controller;
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 
 	// OCP NIC1 TEMP
 	temperature-sensor@1f {

---
base-commit: 4d75f5c664195b970e1cd2fd25b65b5eff257a0a
change-id: 20250611-catalina-mctp-i2c-10-15-9b7e94460bf8

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


