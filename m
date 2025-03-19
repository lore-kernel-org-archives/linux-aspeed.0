Return-Path: <linux-aspeed+bounces-1069-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97145C35FFA
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Mar 2025 16:50:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHvp805sBz2yyx;
	Thu, 20 Mar 2025 03:50:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742403007;
	cv=none; b=iz1aSiGcOro1eats7znS3Uq3ShdBYV0oJX5sskpLszaMbECKbsEECJAg5ZGXxCgdityEwlFF0BtzjPksndxeegH13yVlvfqPgqu6U2JdiYbYzlnB6V9XKMCnSIF6h8F2FYQBmysaPubshSrkuqbsvtEvbVf6OEgxOHG6YDHYVhgC2ikeusnkjUytzgPEFraZqWPPCzkwwvYfgth0jqcpqlw7IfZXEdb4kFalKgxmTpCPJ0N4nsngePNr6tBM/3gO6xH9guXqIFj2XSD/EpYr72uxSNDaC1C3x2NWUHe3ggdMq8SSpLUveGnZvVt3d7mvlo5VF7w4z0q3Z/4P9SyvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742403007; c=relaxed/relaxed;
	bh=NtDV2qePoVhIO7myU7o4OO3ITr/ClHLDVz8qgdkxKAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hPjIJXQHsaNCFUH+QsFYdEe4xmfgkQSli5Gim8AbzJITqef53x+hSFMWKpjOlBoMam1BXTBc0qwGWWJRuLdj7JM4RkeGvqLFX4L9duK0+qooDohYpEn1YVyXwIWxcULgVS3bbUmtbqQ+BDbdTdZj8I0PXVopO+xN/8kHvCtflqmiKBTx/E66qTyS8n9UEcxkI5VgDVqvLX+7Idp/qDxht4Wx0SN53O3cpp8TORYkf3FR9k7/oi46NiTSBHWBRV+DoO5j5IJ33At2jMFKKkGr73oFwNZ+yhZ5V+XZijaCMh0NsuVCC9RzD4FwXeevH07H7MinCUR5wjbCmo/G2YuI7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AKLECC1o; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AKLECC1o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHvp72Dpsz2yrp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 03:50:07 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-225df540edcso21922355ad.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Mar 2025 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742403004; x=1743007804; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtDV2qePoVhIO7myU7o4OO3ITr/ClHLDVz8qgdkxKAk=;
        b=AKLECC1oGYXkA75fc/18nL9b34Eu9zEL2s6fm+TkTgpWzzyq02upqGm+HR6M48Ekyk
         ooxR4izyAlbNKXE+vJPo7HXvNr1TJiT3Vy+UgTZ2apArhlzitlJPrNT0vPiAcgqJM1Oc
         /25vvEeK3NycZZq0txidiOfHmL+397gRxEAZEh7PkPO8oqNL1W5YrOqOQycztkpEO4Ve
         zQH26+2SAtYf2nbzVRIFxQ9lrWytKyA7s4AZIzcNcIxBOUthcoIGRIGtIiR3iMiCw8FC
         RMXag0WhzAtbWhYE3PiORpg4Al6eApvVCFzxXmIfmj1KPEXqMJUvh39QriwfhpMmNM/D
         HStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403004; x=1743007804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtDV2qePoVhIO7myU7o4OO3ITr/ClHLDVz8qgdkxKAk=;
        b=cIFoPyeCO49R6l3UCWhKXQ41463a7JFEDP6qzOvsUv3HgbCnI3TMMxfQGbiYbS1OAa
         a8UXO21ZKz0SIhaDf/GKrXJopyunHHXMftE3VLIr2Sw+wYiAoUwgpqYE8xKDIN4b6fBw
         4lObpT7t7bw1cfBv14UVM5uhexCs612nDT0z9wEIPQrKI3Hx8px3ecTzZBRbCfDHHU/x
         CRw1OOmLy5DdAt73bp5rQriYor/JRg3f6/4hBkEO2JiZjbz3u/tJM1Bb5lQhs60ajZhj
         ZIU3u8wqiS+GWAPO9hjJltn5ME+MSJLGQGqhHClETlVaKHNbJLlfXLXSH96Hm467J2K3
         zVKw==
X-Forwarded-Encrypted: i=1; AJvYcCX9YHI70NRq5RVgJyrAAvu6zJz9YrYCmHBkVGsl2qu85le8AuGZoCrH87KX6Gzuy3a9NEIRxbcXwDeUz50=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyRrK2KBDu0HRComGmaJFEnmyOPo0JtIlPWbLSsrQrqp6bKxLqR
	D0urc1KaIHnQcyNszaLP442nKFhSGJgNG12EhqXmMXqfrgVK9NEr
X-Gm-Gg: ASbGncv0oicuvtknMNAa+ezWfr9r+HazEkYguJ3eH8y0v5TGlXsdTuD30GcRPEWYbYg
	0omNkEsDo+q2VRkHxk6jNW+rmvYWSjYaIcz+Q6UdCEvb/Gi+dMInWCQjse0hE+8j/wZx69LlW39
	OSY0i1wWb/hCy/0opJc9aue1/6XF7zuLJqihy6dc8ZuvhOIbLzhluB3ud8UB7qEGYtKjQ85ERdc
	9UJasdeLSg84UZmqa9Q+UzuqJfq53cxtN0RqIxJj0yMwkspXMeFmoX1ANtv3qBJnVRpQvfoH4bj
	qKSNLQa4EYhMMDmo3b89CwSxhjm2kFSp8k91VWMi+k4EJXgMqVj4VT/4GHhScpE/xLK0wGJnWkh
	qoRmdFEUp/EiJDcfCaIn89a9HA+ZhgtCZ
X-Google-Smtp-Source: AGHT+IFN4xqZ1OLU99SGczgLx2oieKzcfT0iY6TvB3Y4MQWRTtuA9YjNQIktJCnp+uH4ztiFhzc8GA==
X-Received: by 2002:a17:90b:2dc7:b0:2fa:21d3:4332 with SMTP id 98e67ed59e1d1-301d43a269cmr281466a91.12.1742403004071;
        Wed, 19 Mar 2025 09:50:04 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:50:03 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:26 +0800
Subject: [PATCH v4 5/8] ARM: dts: aspeed: catalina: Add second source fan
 controller support
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
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-5-7c34b8139014@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=2445;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=h3bH8SXx0sv5QPMnsoufX0caq8JBi/sA4S632p7NQak=;
 b=FByKFEmN9gtAF1PY9hztEVRBx/ZpnMOF38icLce2VbtLLN3YjWOo+vR6jPl0ZMfIInOn+oiMg
 xOHUPTmqUKEAHo/98tsXfXF43X1ak7YIUHl+IJ1W2/Ac0Z4hscbZBn6
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the NCT7363 fan controllers on the second-source
Power Distribution Board (PDB).

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 0b513829f2de..e11be815a6af 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -527,6 +527,82 @@ i2c1mux0ch2: i2c@2 {
 			#size-cells = <0>;
 			reg = <0x2>;
 
+			hwmon0: hwmon@1 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x01>;
+				#pwm-cells = <2>;
+
+				fan-9 {
+					pwms = <&hwmon0 0 40000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+				fan-11 {
+					pwms = <&hwmon0 0 40000>;
+					tach-ch = /bits/ 8 <0x0b>;
+				};
+				fan-10 {
+					pwms = <&hwmon0 4 40000>;
+					tach-ch = /bits/ 8 <0x0a>;
+				};
+				fan-13 {
+					pwms = <&hwmon0 4 40000>;
+					tach-ch = /bits/ 8 <0x0d>;
+				};
+				fan-15 {
+					pwms = <&hwmon0 6 40000>;
+					tach-ch = /bits/ 8 <0x0f>;
+				};
+				fan-1 {
+					pwms = <&hwmon0 6 40000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+				fan-0 {
+					pwms = <&hwmon0 10 40000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+				fan-3 {
+					pwms = <&hwmon0 10 40000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
+			hwmon1: hwmon@2 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x02>;
+				#pwm-cells = <2>;
+
+				fan-9 {
+					pwms = <&hwmon1 0 40000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+				fan-11 {
+					pwms = <&hwmon1 0 40000>;
+					tach-ch = /bits/ 8 <0x0b>;
+				};
+				fan-10 {
+					pwms = <&hwmon1 4 40000>;
+					tach-ch = /bits/ 8 <0x0a>;
+				};
+				fan-13 {
+					pwms = <&hwmon1 4 40000>;
+					tach-ch = /bits/ 8 <0x0d>;
+				};
+				fan-15 {
+					pwms = <&hwmon1 6 40000>;
+					tach-ch = /bits/ 8 <0x0f>;
+				};
+				fan-1 {
+					pwms = <&hwmon1 6 40000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+				fan-0 {
+					pwms = <&hwmon1 10 40000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+				fan-3 {
+					pwms = <&hwmon1 10 40000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
 			pwm@21{
 				compatible = "maxim,max31790";
 				reg = <0x21>;

-- 
2.31.1


