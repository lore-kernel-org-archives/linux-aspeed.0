Return-Path: <linux-aspeed+bounces-3441-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB588D358CC
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Jan 2026 07:37:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1rb930xHz2xKh;
	Thu, 29 Jan 2026 18:37:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769672277;
	cv=none; b=VbXvy1KSX5eW9sildM73iAVEYxT4aYVNn3SQ3S5agRuL47b4yABOuzLNAM+8QSsppSbn81nwCL4hArwm6q9lgKglFzOPuYcz9I1njF56Fi103WDXSos8qENTV6cywrh/lk4UUPH+thPz8VYxr7YuTnJ0/4tcOrVqO+psvoOVDWzDpX5Jli/ReBAfbwrESQrTnB0lZAXcdnJFXoiG2/JqL+WxM4ydDk0IvH+9U6tJBdC5J0sfN7YAL4BLJY5aj4GSrGAF5bEXy9qPDjPm88gjBssrYgnHny9d1vFQVvMSVPeBoScZ4gtn/4wpsDwPkqy9yt4AkT8305PzzD/Y11cUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769672277; c=relaxed/relaxed;
	bh=fzuiYUZsutbfQijzdbBIi4mz1jthxhIUaA8wPvRL1e8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HjSH5HkGNZH+7S3CPNFSBLvLZiGMDaChFGKUkYbciM+YqsTeEc9d/t9MD4aOi5/eKR8/mY7U727Z1OL7DMIFGCzmV3I3uQT74uGZlXD1xPByXfn91ShL5SZVG11HcsddTLUnghtmjbyWFmatJ6sSQhRx2CLBCR2Y4KZZex72TtdRdiJxgo7Esc+un2e/cyKoPVwHjMdF6hNcxDweNKJMvYYSExC2vfloumQzSSEnVQL0PomWj9kg3zZIwMoXIEQ6bt3AqnRSQa65OwZZLmnlTmYe7GvWWDgWCQwGO3/mB8CCR7PT0ZBr21p1Qk5YVvcRudiF8Upv9MS8KOd8yBhceA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fTkuySXQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fTkuySXQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1rb85BnPz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Thu, 29 Jan 2026 18:37:56 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-81c72659e6bso635014b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Jan 2026 23:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769672274; x=1770277074; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fzuiYUZsutbfQijzdbBIi4mz1jthxhIUaA8wPvRL1e8=;
        b=fTkuySXQubOIfAaD8krUj68DD++JtyzP3tx+e5Xo++VRUqg8KOIyiOF1eYTYO7CXmq
         aN3eKTiw/u05FOYES1wbiU4+10BTnHlHeEYzy0OsCqGMzKBejvksI7mjF3OfmP5jlFVO
         gRxjY0CwyvFiYv7/LTUVY/RTySlex1jSL8BZO2GBekb2+0i8R5lNkMYqyB6f0WjLGXhz
         sqDxbKJYzaxBygP9jZIUcRsmWdGUo85RR2RgAqxUmqY8rAi99g26E4NaRFfgzcDt9y4J
         R1An/L+uNPZUZgM4PG9Eek5Tq+CQ/5V/1oNPlQdYvg9w3a8eh9LBh/655RnqcQiYHDvp
         QHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769672274; x=1770277074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzuiYUZsutbfQijzdbBIi4mz1jthxhIUaA8wPvRL1e8=;
        b=VGKyy4o7K5mm7N+7aa3265eclzMNvEhtanHkq0BJtX203JkBw4xPbqTM2JRuBPniwL
         UqrEiS4udWLGotM83ohdgmPn1mjfDAY8S23wcq9tgg3ubuqp1HnRMMqn0Kvuz3CyMrzX
         OINojvoR/SDLhw0/KrX866lIh/F4kSJAo/rLv4VwWpNY9COBwtWaWmBWVJaupb7PyiYG
         LXSRvYlrFlFwzCy5gOylNiJmoQxgEipRkk1ErF5AnDQOb7Co4qeikXxY7TlbhG9zrEUO
         Ub4pphzLGSrMhoqqVljIiwqROEr5F7M0CfgklMeHOB5/+WcUIlFa4QLvldvcDJfs6UnY
         gDqA==
X-Forwarded-Encrypted: i=1; AJvYcCUI7KrXPBLLFtEXVlpsOlBPxT+8JAO7BotpQhUG+Zgt4o7Q71yZfrzjtuxmnNQJFjVSOOvy4AQMqHXFQ2Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxw3uQ8UI0DCOtg4Xum6wz1SnL5/oCrVTio/pszETe+fejs/Xhx
	ocV/unMpqOYy8MKN2j8Cd6ATAUbZmURj7o4HUC01yudToeKw+Fk2MSf5yiAIg0ES
X-Gm-Gg: AZuq6aKRbkOdk3C8LEtpz7CWGSRcdkkzy9v0qZrnjnpERYIgr06eIlYdCmmDSqpDUNN
	7V47gHo10+WaS8Qi5dqWoTDL4ISf4USrTRLzKP5u6bxawLHwP3HUrbWK7ddLBiu3L+KpkfHcOKI
	ibeTSK1yG0Au1aK+/QOI+eWIE2Hc1fSM44IvO0QW2PMsIs5tkYgQBUjfc39f+IKo40om/3pdWEN
	R/Yju1hepqIIDzt1jeUwxaZgr4vGMax7Ah8YldBZrwR5NwT3YOIcoG3QrHiYjIpzk0rUrjYc2FN
	XDjQNJnaCs6Vq62V60Io97bNfplYBkG9bdj3GsAHsxo3w6rnlQ2887yXiNeslFkFxNosla29xvS
	epPOT8F6RsoFOR8oS+e9cM9ldYpL57rg0QWgoidyuusw4c2gIZqRJAD/BXJVl4gemQd2dny86ec
	9rhBIMUwcUHij7jSSdcMa87/OdT0fkCPUm5vdU2ms4HuIENx8+YHiCXSiGOyL9lojS2upia3Xs
X-Received: by 2002:a05:6a00:2402:b0:81f:4208:274f with SMTP id d2e1a72fcca58-82369186775mr7135794b3a.15.1769672273963;
        Wed, 28 Jan 2026 23:37:53 -0800 (PST)
Received: from fred-System-Product-Name (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bff93esm5142425b3a.41.2026.01.28.23.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 23:37:53 -0800 (PST)
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
Subject: [PATCH] ARM: dts: aspeed: santabarbara: Add swb cpld io expander
Date: Thu, 29 Jan 2026 15:37:48 +0800
Message-ID: <20260129073749.3155383-1-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.52.0
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

Add CPLD-simulated IO expanders for cable presence detection and 4 SPI
flash control. To resolve sideband pin shortages, one IO expander is
utilized to aggregate interrupt signals.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../aspeed-bmc-facebook-santabarbara.dts      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 0a3e2e241063..39f7fade8ff7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1335,6 +1335,39 @@ eeprom@50 {
 &i2c12 {
 	status = "okay";
 
+	ioexp0: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <148 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"IOEXP_21h_INT_N","","","",
+			"","","","",
+			"","","","",
+			"","","","";
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&ioexp0>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"PDB_PRSNT_J1_N","PDB_PRSNT_J2_N",
+			"PRSNT_NIC1_N","PRSNT_NIC2_N",
+			"PRSNT_NIC3_N","PRSNT_NIC4_N",
+			"SWB_PWR_FAULT_STATUS","",
+			"CBL_PRSNT_MCIO_0_N","CBL_PRSNT_MCIO_1_N",
+			"CBL_PRSNT_MCIO_2_N","CBL_PRSNT_MCIO_3_N",
+			"","","","";
+	};
+
 	gpio@27 {
 		compatible = "nxp,pca9555";
 		reg = <0x27>;
@@ -1349,6 +1382,21 @@ gpio@27 {
 			"SPI_MUX_SEL","","","";
 	};
 
+	gpio@28 {
+		compatible = "nxp,pca9555";
+		reg = <0x28>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"SCO_UART_MUX_SEL0","SCO_UART_MUX_SEL1",
+			"SPI_PROG_PL12_SEL","SPI_PROG_PL34_SEL",
+			"","","","",
+			"I3C_HUB_3_MUX_SEL_PLD","",
+			"SPI_PROG_PL12_EN_N","SPI_PROG_PL34_EN_N",
+			"SCO1_SPI_SEL","SCO2_SPI_SEL",
+			"SCO3_SPI_SEL","SCO4_SPI_SEL";
+	};
+
 	// SWB FRU
 	eeprom@52 {
 		compatible = "atmel,24c64";
-- 
2.52.0


