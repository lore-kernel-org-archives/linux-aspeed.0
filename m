Return-Path: <linux-aspeed+bounces-1103-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D95C35FF3
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Mar 2025 07:28:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJvFD0WzYz30MM;
	Fri, 21 Mar 2025 18:28:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742542112;
	cv=none; b=msDxVgOUi4YBhQVpqwRfZqFF36JH4DtR8OH8bHtnaptoT1T5KkaH0pOSVvKxkBzNjXwwzuW4zRElpe0lQK9la3aHg2NsAErmEM907WRegc9cDetD1Lh0qtPkECAjmZgIfKlxaYKv6Qh+dlZ1FEX50Ntel8AFbpx1U/pi0tY7cHZg61M4d3aFdCj+iUnCXl5Wz0tSFlq/6blnPmLSkMl/txpQXp2JqYA11yOCP9IUZq1OK2PMOMINwHAd88FTcS+fjcw4u7ZLeACFe+NNF1s4mEdYSolZfTPwNCHJBrDIWlyWXd2t5FCu38QE6tyWtu35XhiqeFNlw3EIPko9MEAY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742542112; c=relaxed/relaxed;
	bh=vsGnq8WpEGq8rItMy0um7W6pcAm/zbCWTBE+mh8Th8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWDoW0e+PzKWKA439pLmYxQBm0LrG13MiNJP64j5/rsM+3KJmwPu87Q0ggGsCkJ3fKr/663tY+RGPu4TQDQPOy4ERCK1Ssvqdn7mZHz38kUcDz9XdXqbCTJr23rFn+e0xyv/uzy+35rZ1hElcgi0LYcx7YDM9DtpltiYI0DYOcqNG14gDWLBB/X+TR6ca3WzD0MssglrS6EU7/cxg1MIY+jWGjWnZT8aePLwEnrOVB5h/gB2rHp6T7S5BDjOzxJrumiqHDGmxv0CWA2KYAToIwQQpJFaXe+L6gF+naazkdERSZpHDp4mLgaoUAMcFf9mal7sI9WwoQGPB0dCuHzGkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HtJBihqK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HtJBihqK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJvFC2RMQz2yrS
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 18:28:31 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-22403cbb47fso30818405ad.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 00:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542109; x=1743146909; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsGnq8WpEGq8rItMy0um7W6pcAm/zbCWTBE+mh8Th8U=;
        b=HtJBihqKPC0+5aPG3qt+8dBCWJuUfGr/K96ySqQfsd6rdDmStCvrPw9tBwLOqhKkrv
         Hq7hOqcBnF3/usX+9Ne5K0B6hic6pvGiYaRmyuYaASDEkKoWfy1gzbhPa5DTRBp7Ka2P
         Hc2HS/HPlzCtSfgaYC9yQ1whKNvtNoKwqWDniMW8CU1cl0KvXckC3JzO1TC5hvvg2ywu
         oWRX71d24QdkDVxYuRKeq5KsIdhC7NwOS6De4kZoHAMa++rKHZO/Dplw9wmdg+a859Hh
         S21y01ZQT0kJZNEB/bqoDkzWbfXgPGIyU7Kp29Zj5KGM/YLrWofzy0KZBoVWoLdxYB12
         WZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542109; x=1743146909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsGnq8WpEGq8rItMy0um7W6pcAm/zbCWTBE+mh8Th8U=;
        b=Fa1i+ehhMTlhl2q4S2ALbb8gcn8Ivh3slXzH6moZjEtMsqAXj/WSCUVWNF8m1H5QJ5
         XdvBZ3zW7d5bcfdfnb32rYIMXLI/MIEdTc6xljYe3F2jBZfU2cDpEUh8HgUDgv+ahPw3
         ptrFY99+FEXBWUjyYr84jMTf69n/thuHBDnbKrJQAT9KDmgtPr0fG9xrbWbD0SsnvgH2
         NNoprcrY7HGgGCqQVbpvtfK/YE5z2ZRue7bzqssYcyd1bYWDvPOmGGrwvVM+us1p62rC
         z/c7vnGRL4veI3Wx6dU5rGZNREB1oZvOoI2zNv1EcIYc2HoXVUUM4TioYMPkpe5mAIX5
         AErQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVdfGK1MkQ1sL471ow9Y0VFxUXWw0QWPkW0L+Vefbc8E0oAYC/140kW1Y+vOKi9JBk543T6MT6MHlYiDc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxKLIlOdyjF78Wt/iMLZOkOAeeXpdn66udugL7kUC7yj3vLcdJp
	LMQr3Ote9AQFD0XKYTEnnpy/mvx/fzcXythP9WK7O44RL+F6oXxx
X-Gm-Gg: ASbGncsFpaMB5XFM2LNEzm33SmOZrOOYmx+dgpZ1YTk8EXfuWTmZsqtdi/eqEwxU95r
	KhvPqxrd7MKj6MCfUiFInXJIVL2pYTyMGXwZEShs71zXNHLxyR8259WNj6dliSNOAmk8OWma1QN
	q67soJzVA0MTR4NwWivJoRK6I7TAznTeFiD+lJf1kglAeVhB9ghMofNMF+KfDEySB+5poHVVfBa
	8cvXUFLoKt9Fqj62QE004CpiiyWVDq6eZKVQl55ojtlRlWxgMU9h9eUoGnqzr2MGbIJcBKdNF7U
	1XSyQwz0yZVf2h9JFDgBXArVZISJkijhRvIK8S8kraxNkD2W0A6fKm05qRtsc7DfX386e2mX5UF
	bZHRE+jJQ8FYnqd18kRofFw==
X-Google-Smtp-Source: AGHT+IHZwkqqnNy+VPxGo4BdiCjiJgfTxT+uvqFaJnReF+y/mGA7CSLdbLFcCPQBoqccVKLmssYfMA==
X-Received: by 2002:a17:902:da82:b0:224:162:a3e0 with SMTP id d9443c01a7336-22780e2a37fmr35488305ad.49.1742542109028;
        Fri, 21 Mar 2025 00:28:29 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:28 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:02 +0800
Subject: [PATCH v6 01/10] ARM: dts: aspeed: catalina: Add IO Mezz board
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
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-1-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=1855;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=ZE8DMnDtK6GtXz/R29k12joihlo+gxEvbFhaGKQky3s=;
 b=hSNSRF8aykCJoZWrCIMBeG6atv69rGcfZy7cKck3omGOD07NUktdt5H/dVqsU4O70JCwkQyrQ
 FiGZEehi0WUDAuOve21El2ZnNN9uElK4xLudO4NPMRmsXKLjsDs8SN5
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
index c151984289bc..d5d99a945ee4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -198,6 +198,12 @@ i2c0mux0ch0: i2c@0 {
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
@@ -208,6 +214,12 @@ i2c0mux0ch2: i2c@2 {
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
@@ -299,6 +311,12 @@ i2c0mux3ch0: i2c@0 {
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
@@ -309,6 +327,12 @@ i2c0mux3ch2: i2c@2 {
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


