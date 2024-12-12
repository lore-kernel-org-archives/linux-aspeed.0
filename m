Return-Path: <linux-aspeed+bounces-196-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758C1E7717F
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 13:34:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8D3V0jPsz30WT;
	Fri, 13 Dec 2024 00:34:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734010486;
	cv=none; b=m/Zkz8uaiKkut0S/GGVLHkbl9rNBxJA2v7pNbirTmOwopLC4tTS1hlzmRZ8+LqoEIU5qZ3q7yrFrkANi6PJvowzuhcNalcOd8cqIGJ/pwnaZCni8Dvb7BJO/MK/lSTHBsGOpyKtVm203mZUNPWxwpj+N94nbb4cpKranKI7jIYrDFNxAT74R/oIZfbn14MIcGI4WlcMOOod9uHKOnvQ9qvb42zb1NNy8vXYV93HtAoc0poLBO/jK+PEl/p/fTLQwO1+aM7OmoYFT06w7t96qdKD/6NZPRB8iegsIaAQC0o69CzSTlfaT70qgxjUI2/vBuWuL0Yrk6Z/rGxt9vfM9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734010486; c=relaxed/relaxed;
	bh=B+9a62ZNb/EWT2KZraUPUvnwvMhSxc9YsoXJSC42SEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IpECkXcn3LinVUEY8Wer6fGRORVFxc0FzGeeR3oXESxi0xpyACMFFMEcTqb13OBdDViB1YDkZ7Aw4Cg6a8kED9sbRa2aNFASZv6q3EL387W6L84nD9Wpt8YzVxWnUDTMUmL2kt05YTGsH5lbR1FnB7G8YDXVpYET5rBZHJd1LWRefqXSJE9lrid2cX42RkYth58PIhxyZQkvxCxmJSXq25yeqbdYexmMZrVs4OzzMhwN5/bowktKkQCT1o4lyCb2vokrCtxNvOtq8taEmpCMBYylym4APrJt0Ihd9l5nGs9ZgfP9qLwA0SXwL1QKcG4EJwJMnF/8shI/cJ8JWSG2UA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=avNvwW6b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=yangchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=avNvwW6b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=yangchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8D3S4Hflz30VL
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 00:34:44 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2163b0c09afso5367885ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Dec 2024 05:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734010481; x=1734615281; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+9a62ZNb/EWT2KZraUPUvnwvMhSxc9YsoXJSC42SEw=;
        b=avNvwW6b2+JVNvD7a95dl8XzdEhb6ISiWvKX40h/nvxQRFxsXrs8gGs9zkcIOIclXX
         LEVO8qgfjZtm3Za4CurHBWOVMD9LT47XmkgxVejpJ1o3fUXJ2xgqZ1v3FW5m/ykaqyUa
         UaYQIA3BVcK4vBlszvuY2RTD2ne2d4OLi00GEsHun5fTIFXLWSIGN/RCYx3EfzjR3rVE
         2XS4kgz+BLAst8GGovZYxTRXgdw6UsdV5dZzxfbr5GmrmsQJQB+e3LnldU9Vgmfh9J/9
         Pn2hCZLaeJyB7HAbEev+e9OkRAOMN25Mu5/Wiln/N7juS7mdK6oPD8IPXkxRX3MlJDKc
         MNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734010481; x=1734615281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+9a62ZNb/EWT2KZraUPUvnwvMhSxc9YsoXJSC42SEw=;
        b=DiJXfMBetSyT7SiRzpr2d7BdjlflPQSFKsGpH7Zedi/gMZtH0Y7gNvjBBTAeHbcXx7
         i3hzG0ww5v96lCn2g9VyOR8Fp/0mLdcTiqKlp7BPRbWzHU3nYaCP5ZniYV8pTIpT/U/k
         5BtMQYZvQeyr7G1VQDNCFMlcV79AiTyAEfA2BcfgW0InjA+Bh4QEqsSqf6WWpW7Ff2RT
         AMFwcrIyYh9rLoS16bOMVvPhed55Gj20+9svZxpu+7g974FXb/JZnBQlAKroKTm1uXZd
         y3OJZjHX1hYuNiT7ygfr2Rr9VuQ1HqfBiv15WOL6qxcLbWLIDUTMlDZVhR95AuXb2Kpn
         6i4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYONWYBs7Gkuz9iYo6vAhxRDVI3aih+sCAM9OlT6ixjKQYqtgXdZhZO7MgTle0+F8YcJiTPMLm+XdVrLc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzsa2yRzRsGZ2FJTQUaUqAjAJoJQS8zkmZsKF6uAv0vTa2mdhy6
	vZ+m4HOn8GJHMAAjgNSMJgPCggKe+Va5pKrr+yueg5aG7PdPxPCH
X-Gm-Gg: ASbGnctnfHF6rysKLca/5LWcEux9IKlTDrawri4ZZxV+MbY15chUG0yTHAjfEQ7qZgY
	xcMQ5lDH6pB9HsVmnW3gyesFVlIYznEgAha/eGlaama494eUZZwStbYTsvThsiuepkgAXxUWMmo
	7aw+X7rcv787XduZ6bUOFKQ1bM/ZrLfH/WIaIjTmPoPRmKHYJT1jbz58FMCFAVNjLKH9EwCfOet
	GVLvOWNASt3/gJz93ucnoOKGjImRZvtkpPvhmG+DNbc0w18cqZvvi1TFj4jiW1OZRGcvoU6XEFw
	NC+XymILr+ERzmVmhk1AAgr4RT8VOU9kMhdVmZGGpEEZjwG9ofoYNhMGMce0cloMxu7i20YBH9t
	Bixlx
X-Google-Smtp-Source: AGHT+IHy1BSLKHF/ez/arq9rOsDz9L+2JIM6hHhlvZ3suOhtFcy4XDdXZnNQNlk3OKOkub/hn6NdTQ==
X-Received: by 2002:a17:902:cec4:b0:216:5e6e:68b4 with SMTP id d9443c01a7336-2178aeed4c4mr63751705ad.46.1734010481565;
        Thu, 12 Dec 2024 05:34:41 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163562a838sm83390165ad.29.2024.12.12.05.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:34:41 -0800 (PST)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz,
	amithash@meta.com
Cc: Jerry.Lin@quantatw.com,
	yang.chen@quantatw.com
Subject: [PATCH v1 4/4] ARM: dts: aspeed: minerva: add second source RTC
Date: Thu, 12 Dec 2024 21:32:26 +0800
Message-Id: <20241212133226.342937-5-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
References: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
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
Content-Transfer-Encoding: 8bit

Add second source RTC on i2c bus 9.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 7fddbe833cc2..ef96b17becb2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -1292,6 +1292,11 @@ rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
+
+	rtc@68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
 };
 
 &i2c12 {
-- 
2.34.1


