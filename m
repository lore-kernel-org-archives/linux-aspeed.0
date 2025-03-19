Return-Path: <linux-aspeed+bounces-1065-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEACC35FFA
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Mar 2025 16:49:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHvnw1R1tz2xCd;
	Thu, 20 Mar 2025 03:49:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742402996;
	cv=none; b=oR6oyKF1RDSo6Ipa5SfG2PaPZxQCoDQTZeUAUpuLY+jtptEcYGlYgJAoLwbIxWyIuff3cKzwqFgFMkojCrCHXAMm2hWl8dogH7bhkWVS2pUtHCe0QUPKIDiIIJbJybcFU+SPrJGHylDUVXUxPW7/YB3tov+qca4+w2WcZDu8c0G61vIE0EjNrPX/FjS2tSgMCEpZ7ZyFqLkEn8ut/jRJYoXx4tSpPKK7bjKtP6YAqkgisCXfcb7aLpb0Px1RXk5kZiq8NrzWQcIZp+Lct2eT0sQ00qsAUhU+AKAFBFIPDTWMcdYhJWSaRn79/4FSpJEcUjVJIPO5Bgw4swHvNNJW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742402996; c=relaxed/relaxed;
	bh=XyUIVOLZhlVIcgING8aBn5z7brc7JiCZIt0y5wEI684=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZEOZ3uAfzG9KBl/IDCv2TPFRZATp4DM36mDxj8X5t/qABDjPrGf49ffq3ySN2wMOzwmuGvxof11dhVd7SLlyRQoyKEsbCJCJxJSVX+SjUBrjZootAOfswQCGyGzV8DEkotcwaJZtX3ymyXisW7T3otR5q+G+/PztR0v37st3u3On+yQnU+KQoOdYNzbGWtKxH7QbTkMYsyC1UO8svSQMqOMmQl1PJYx53pijz1jUGehE+gXx5FRoyez4s7bbkTLl05Fh/mnnvuO+j1OMLzlPtAn6NPHaxfBcdpP0kmu/2xVQNKubobUcAhIs9njb9WQK3ra/dG+75nh7q6Cfv9TVaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=W0HpLGdz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=W0HpLGdz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHvnv3ZxDz2xGw
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 03:49:55 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-22423adf751so129634925ad.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Mar 2025 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742402993; x=1743007793; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XyUIVOLZhlVIcgING8aBn5z7brc7JiCZIt0y5wEI684=;
        b=W0HpLGdzTGSmr7ZM5Mwrn2jUP8fnPjmxAwv+2iRBqClm5efNTI7Lhz6CYn/qNEeyDO
         qc5CCPT7WohG02ws4uYU1MhVb0oz+YmM5DvmrjudTvwwDy05QCfz232Z1Xud5SuxkYLz
         v2xjRWDJDbovggYgT23GIPRsfBLDncDAIGd+O1Af/bDkS/gvTFgEgk3gnCYtGvh8uqBM
         Xpj7o/14v8pE6B8kUER9L28AoUi6tcRcmBC1ZvclWFnwyBECII1Jlx1hVm8FyZcRHJKH
         +er4G2fYWJalye2Mbs2gI1HH2gksTah8Oi/wbDT58re3khXVVr7X0/mulhpeF0euQrrG
         OqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742402993; x=1743007793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyUIVOLZhlVIcgING8aBn5z7brc7JiCZIt0y5wEI684=;
        b=AY3LnCt7p/7WoaDrk++gFA61F/o8rikurrOs5UkGj/2Q9tmb75vI+PRI59vEQOit4+
         x+Anj4Bh7h2bY6YSve7qpHzRcFjWXV5t6yQpIO7GaskEFpTJONsztTpn1bvyQ2ya345H
         9ccI3tKd0GL2ctCgAiAMibsn3MY0qE/sXCUxCpION+uPbHATLZyCr9ugnFPBNykMr+kj
         8A053uLisetk/3pO/tujZTGLpIDopG5Gq0LEB62+b1uwSAoei1Z2hMyc0ebMfd434XOk
         wh3z+QU0uta7aF9W4xlECvPPv7PP/UCf/q+6s91pXld4NX9NwKEXpnQGDU1lrC5SXVw5
         A1mA==
X-Forwarded-Encrypted: i=1; AJvYcCXGpZQ315brkQelnTHBcBOKoLtTAGW4/CziAv9P/JWFY46SFuCJ0ah8uThW9u4eSyjecBdrupAfOVvRut4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzJXBknDt5/ThbUNRf26icGKhmQD2flMM60y0Rjc209eOcvf/tz
	v9V9sUcLz9H/mIgv4n6bqzQd+eoSq8/ST49ADWsZUXKMk/LzPJT3
X-Gm-Gg: ASbGncu7lhiFoqqbmxjHdCLeotLFsF6JHemrgHT1DUZcr3C2X68XvbZLwUpgiu4lGpM
	BfI8gOGMQkBZURjB3GBrsQFPTlrX2p0gdMIiJfgpdcUdrX0ezKJAzWk2TJ7Vg/v7XvGgoiR+Gxd
	6PzAwvyhnM7bwIKwmvGscdS5O6n7ldtjynNYVDvC+9Yr34iLpHaI+4fFCVQBnfEXmetNpYk8vGg
	anQ9w9RsK7LtVeA2/wNKraX9jr3iN8RpRu249p3BiJ2XxNl2udibN49isSUzjsFrb5uMb9kCV9e
	yS2m9WPF6lgF+05qTMM2GzmV49OOwjeKNDBPpWz9qYUpqbWzv9+BhUfddGL4uSIFe6IuYptmdub
	Ex/5lZavli4PSvXvNNeOWMYAkqfLLglFf
X-Google-Smtp-Source: AGHT+IHhdqRvGiRnM02XFEBX0cT/Yyoc/AZdF4bSUHhB9t9As2aIDMWD+63C8qtFZMUEBd6evCXPOw==
X-Received: by 2002:a17:90b:268a:b0:2fe:9e6c:add9 with SMTP id 98e67ed59e1d1-301bde76a0cmr6126690a91.18.1742402993479;
        Wed, 19 Mar 2025 09:49:53 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:49:53 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:22 +0800
Subject: [PATCH v4 1/8] ARM: dts: aspeed: catalina: Add IO Mezz board
 thermal sensor nodes
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
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-1-7c34b8139014@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=1855;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=abmTlOlW8yHuHGZo8Vfx2BNiu7X70YAM3VxyVW2QeUw=;
 b=AmSie4wj+dx1uYqkqheVZm6XmYA2naDZizT1XoSzDVfNXANH9iEsSE+cuwJPhKnXlARR5KtMO
 rDRQS0FYu2gDx54jdp4YhRlS4Nnm9oDcaEvqWKEXcTvCS/FKw4BTONI
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add thermal sensor nodes for the IO Mezzanine (IO Mezz) board in the
Catalina platform device tree. These nodes enable temperature monitoring
for the backend NIC, improving thermal management and monitoring
capabilities.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 3822bb3c9243..75c3906d9654 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -190,6 +190,12 @@ i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			// IOB0 NIC0 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux0ch1: i2c@1 {
 			#address-cells = <1>;
@@ -200,6 +206,12 @@ i2c0mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			// IOB0 NIC1 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux0ch3: i2c@3 {
 			#address-cells = <1>;
@@ -361,6 +373,12 @@ i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			// IOB1 NIC0 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux3ch1: i2c@1 {
 			#address-cells = <1>;
@@ -371,6 +389,12 @@ i2c0mux3ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			// IOB1 NIC1 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux3ch3: i2c@3 {
 			#address-cells = <1>;

-- 
2.31.1


