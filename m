Return-Path: <linux-aspeed+bounces-3231-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC15E784BE
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:51:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dffMw1jJ7z2xKh;
	Mon, 29 Dec 2025 12:51:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.194
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766402831;
	cv=none; b=gkzXMK0aWwsst6ALrvhJRYdeQFih+qwwC5CmsxeLpGmPriKdh7EHTCIwZP6GwNOCyS6vUHRpi3qRCRXlt4EOlq0pYi7i2sKNlnlxihiiYMwAgunezy9pYXCt8OeaZElo6VKqH3MzfxFt2AhVncb//tzyYk3N2DAc6lXTnGOTtFXL8gGnhY8yLZLIti+6NeYMYImIfHMlzgHbiHA8k0kH8gkHzUYr97UzzMQzO3gM6bG8TYuTGnIfoNVV9bGMp/6SEeqpHbIuSLAu6YDJfuBP0NV8oC6IfDhgJDDexljahxHiwKH8fSxPPLyQolDGaIcOUi4sN3Zz0VQiIkb0lpfVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766402831; c=relaxed/relaxed;
	bh=YPgDvOrc6Z6FI66bGWH7nZrKKPg18xmDLr/yqLIfNcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H8CQrfVj8dVqEtYlpOzTww02/tkwn6NViQ9LqziAr4ImILmAkSU0Up/dX+A6TzoqI8Dgg6pQUQSSyRXh1zvme+s7NaittqyJCXDelmoPlJ5+dIAjDSb+15y0jcemR1NuvmtdiqaGRnIRtBUEnQvkunrxQlGC2b+OeGewLNIL+yjS/gB1HglY5nNagLnzeOXoqXnh5Iy60MhMg4saUoeYF4/5GBnwZ+qQ2FDkoLRLZsN1agc8H4qI8xsc85tOQDXjs6ZxkAvv8AxpIA7cRy6Gqi+aNQcWAKO453XBnhwntuJsaT+R3iJ+H0wE838sG63LefAj+5YqcuFk1FhNJafGuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hSA7gNgH; dkim-atps=neutral; spf=pass (client-ip=209.85.214.194; helo=mail-pl1-f194.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hSA7gNgH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.194; helo=mail-pl1-f194.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZbTB01HSz2xQK
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 22:27:09 +1100 (AEDT)
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a110548cdeso54036695ad.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 03:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402766; x=1767007566; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPgDvOrc6Z6FI66bGWH7nZrKKPg18xmDLr/yqLIfNcs=;
        b=hSA7gNgHb+ZaBqVVxLs2aFhtLcqGQsQmCR5nESrsIShiZ4aiElYKjvTjq38Q029JWM
         R6oPilRt5MmocZlYx5m2jwQmVTTzPXI+Uk2ma9qlRSaLOiUvZkDayGWHQ/uR1iQ0n1hz
         l2uvi2gjwUNsllHiLTvojUcjQ11i66/ulKf4VOA2ySwnCGstqhHpY5uKYjUMXI+IGTtN
         IFzFozTYD1MkN7v0kjMBjBShOkW/jvSGpGhlPFYVhb9JY3bgdQbY9Ia9fNnAnI7NVASj
         AsS4WmNXkhqY8FzdkTmdYk5ZYVVkDNya/Zfy3xhLNL1sPO7jePXQj3EsFv1S3Svx5arE
         hEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402766; x=1767007566;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPgDvOrc6Z6FI66bGWH7nZrKKPg18xmDLr/yqLIfNcs=;
        b=e86D1/GGIyCWtgwDv5YGvCHVR6esswPtjzGryl8u9unerlvwokUkdsmPQhpZ7ivgOc
         fuLq8thIuyWL4KQCnqp7KtkZO8M49qow4Zl96XUwageCKQ0QOeLM8dDWMxgl1WPpxz0L
         IBSoHgtJLdtZLc2+j+/OTAwck3tYwpBDCIzfnNm8FzdgWkUtyMjw6Kj9zSebhzsEaeX9
         NPJr20xt1GIuJwda1KbBqLqe8k4a3WGgG2LOjlT+Avu4XFXyoHJn/W8gTB3nS5y5PboY
         VsBXt2ZTs063bS+zlkCcFlS2iXhUgUw29WvfTlAUI0kDp3Qvsmo7FeQFhVyO/gTJSVu9
         w7Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUUd4AVuK0SGEZQIybAe3U5ZRdo9ABtpitI2ftQDj2HT8j/B1yE7ek/GXXuYoiBS1IQS7bdqNY0q49sev8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwgWd4tN8KvnFcFiL4qa4wmJEdb1l2xRGBK0sRxCCGEG8Sp9XX4
	dZ9KSoTOrHwLIPCvcgBLS47d7lPMlcbKUAjZ7QbNWmS6sdCk/gxQPWj0
X-Gm-Gg: AY/fxX4z2VeVYhxb7a5jYECKD2OKFeqk6efawj/G0cBmFCOdNxHRaMkLpZeKLiVoiHV
	wWeCSx8qOtbUZqmXtB5ApSLSzfkPW2G0SAPxuM2+3MVkRFzOoO+7JkppAPB4RknIVzGL27KTro6
	AN/CfsUx6fwX48W8CGUDXwA/lmHPU73Sj/EhchLeGAtiHXtDtlqIXyZCQINnF0uLGxLJDKxiafz
	SrlRtnIC/rWMOGDcI59U/N/jT3ePbkwAxDMsx3yWtWOEIy0XwEYtvn0ujmiT6tDU8sR+PoVaCJ9
	ARZ/JkfPgeKQPuia98N5jae/rWp1e2RDdSlTqhOJy2DVeqNmIgBbQZhtj/zLEUxp5mSVrwIPex2
	OHuAW7DAfD6Q6MhVzSxrPN9D1B5MpIHmlOu68tfDt62YLablqK+MW94iaoLlznuuZ/CfwO91Ifl
	InOA8ifGi8lwi/kRSbpAytKtkaRxP4eb6X82UIgip+pUBHos8SLDSyWtgvT1UXjK8+8mAk+NYVV
	N2DO+8zuAa4SeYODY7NEk9Xj3XZTnqINHhZPX2XuBHvQnO8PNNJhYDRJoCRJMrZN+mMQSlOYg+L
	xNqsYg5TnyH4
X-Google-Smtp-Source: AGHT+IFYHl6Ami/Fr/cAqd6c4FtIqedeodym7KvXuloCEE2tyym65FcGKbybdqQRLNMA5fqUBmjjcw==
X-Received: by 2002:a17:902:dac8:b0:2a0:ba6d:d0ff with SMTP id d9443c01a7336-2a2f223177dmr104463525ad.16.1766402766457;
        Mon, 22 Dec 2025 03:26:06 -0800 (PST)
Received: from 2001-b400-e3f4-8350-2c3b-65a6-c562-3201.emome-ip6.hinet.net (2001-b400-e3f4-8350-2c3b-65a6-c562-3201.emome-ip6.hinet.net. [2001:b400:e3f4:8350:2c3b:65a6:c562:3201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d74bb0sm93937725ad.88.2025.12.22.03.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:26:06 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Mon, 22 Dec 2025 19:25:29 +0800
Subject: [PATCH] ARM: dts: aspeed: yosemite5: add x4 E1.S expansion board
 I2C mux
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
Message-Id: <20251222-yv5_add_dvt_e1s_ioexp-v1-1-25ad202d2681@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKgqSWkC/x3MQQqAIBBA0avIrBN0MqiuEjFETjWbEg0porsnL
 d/i/wcSR+EEvXogcpYkx15gKwXzNu0ra/HFgAYbi4j6zg1N3pPPJ7FNJAdfQVvX1YaNa42robQ
 h8iLX/x3G9/0AXWt1MGcAAAA=
X-Change-ID: 20251222-yv5_add_dvt_e1s_ioexp-14930e048043
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Jackson Liu <Jackson.Liu@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766402763; l=1757;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=AYuzuGSC2KyBdpb8hlYBY4+KTfc8mfuG0hrKUlWN6X0=;
 b=iYN6qeY3wMD3HyqlgwpbWDH1W7gTGl8fAskNUaffziqK0UPHS3mck0rJ2kDDIHYmNBvQUCArK
 vhpDUVX53K3BPZiIFMuykl32cWhjNLAUTP99xQQnePiTvK7hwbhJd8v
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

The new hardware design adds two additional E1.S devices behind an
I2C mux at address 0x73 on bus 10. Add support for this mux in the
DTS device tree.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
Summary:
Revise linux device tree entry related to Meta (Facebook) Yosemite5.

Changes in v1:
- Add x4 E1.S expansion board I2C mux
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts   | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 2486981f3d6bd36f3fe780b21e834b85242f8aa9..87524892322c1388c146b33ac454018a31dad168 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -31,6 +31,8 @@ aliases {
 		i2c33 = &i2c30mux0ch1;
 		i2c34 = &i2c30mux0ch2;
 		i2c35 = &i2c30mux0ch3;
+		i2c36 = &i2c10mux0ch0;
+		i2c37 = &i2c10mux0ch1;
 		serial0 = &uart1;
 		serial2 = &uart3;
 		serial3 = &uart4;
@@ -702,6 +704,27 @@ eeprom@54 {
 		compatible = "atmel,24c128";
 		reg = <0x54>;
 	};
+
+	/* I2C MUX on E1S x4 board */
+	i2c-mux@73 {
+		compatible = "nxp,pca9543";
+		reg = <0x73>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c10mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
 };
 
 &i2c11 {

---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251222-yv5_add_dvt_e1s_ioexp-14930e048043

Best regards,
-- 
Kevin Tung <kevin.tung.openbmc@gmail.com>


