Return-Path: <linux-aspeed+bounces-1105-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DCDC35FFF
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Mar 2025 07:28:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJvFJ68Z1z30MY;
	Fri, 21 Mar 2025 18:28:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742542116;
	cv=none; b=i8U749Z9zWCPlUndVGspGgimqz0ExhGRIYe+NlUn4OQcAZnWI2lrm1Bg+fsy2N7MCqNF8csYB/UnpAZ757HdTfNgGdnMP7bkifyR+n/Wpk91vnw4SVBrGR+7D51Mzf62dy30LZQ6YFwniDqSgKB+wHZMOw9eYB6AU6jhZxtlF9HAADkrbZFt68iPZxXk7IvHE0Y6sWBKxFqO+SWL1zTrKSHo9L0nXHsOlCl4MSjfB4pxk/5JBdYkDPPEHnbk3jIpv6QmibyxafVQDj6EC+3pSNQoG6D897nGGe1q/bj2S7N2Iv0c1SPWH6ALHZYQzFtdUcuvir4N1qO+enLiYGgK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742542116; c=relaxed/relaxed;
	bh=05OyaXbL0WKbLYpImlnz0xJZmG54ud3JNw7Cj+unigE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GDOe3avSKQsVZWimX5Rz+l+wWwg7i62elR7ccJYld+WEEru2t2JNqAKtlVzCYdiMPMjTLqKrCgjOAVFJiT74or6tnaOpmc4HFYaO0nrH+Ft/82K+qaPIUleAlSlDmCbBrK0jTJR8o5qPiRSclZvScvomEwFkFCYSlhd1h3lulbr0TOcOare9L843XtQxNR81YgWVOMCOQxV3euTxhuEdr2zMsT2D5sQHpS37/nQa1ZY4FftGOPvbE7FlJsMI5SBTsbKij1JIV33ppMCIahwZYIfC+gJIuHQz4iimfbYjMqEYf+chh2A12CBZPRfn3hCEtUsE0nh2fVerfGATc+BUiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Tp9wOIo5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Tp9wOIo5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJvFJ1lW9z2yrS
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 18:28:36 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-223f4c06e9fso27490455ad.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 00:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542114; x=1743146914; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05OyaXbL0WKbLYpImlnz0xJZmG54ud3JNw7Cj+unigE=;
        b=Tp9wOIo5Vk0g8P29+5BH1i5GOgfK5s0ed1AL0eYbazNg1l4yKqwbv/u0XfkuW4hb+5
         klIN91ARP/P7+r9QPl6i3RNl5ucukw10xMuhKoZIHFJggbZngphq1f8h30VuJhACQSbs
         sRG9HHD3x2EScG6MMu+iWy7wxOcw0Lb96F1cEzVKB6QGHXJ6Di9s6AEPytf9GDhYUQM6
         W0eahRHt2RK/LvuT7kylzictsl9yhHXuONdTPtWzsHkg+lCGd7hGAm+Y5sPBrQfnDp4e
         PJal0fIpC5zOb4JZfsYhS4xDHhL96YDFnoJ5gguz9KQ+cJ1cHGzLRHqBAXO7MMGe0WwA
         1j0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542114; x=1743146914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05OyaXbL0WKbLYpImlnz0xJZmG54ud3JNw7Cj+unigE=;
        b=WUGwCx5GtjJRxBLMeKvayNO27Yw1nqIJcC0/Pg4lq+e8JakxTsxNWLlOx8j7ACl20d
         EUyiPIDWpdhhc71JkwQVmPdwNytAHWkEfCQk9zG1288LsIcfQLtweQ53+7SPHkym0YsI
         JIGl8J/WpjSkx91r/Mpp/JiAuyLeeA/sNDfuHxNvsTWxI+vsFRnsKkgsTi9bxefeNsUk
         CKCR483hPnc/cqvs4Tnt3lV+LJeIITmpgVEGrPbS8kbVVd6igP8emakb3PYSPj9jc8jc
         OhtgDPD9m1nSJ2DzDzyAQ8dL1yt6BKiVOZ+VWVe3g3WBlh0bIjgGaSpuJE8gJTIgerm0
         yTRg==
X-Forwarded-Encrypted: i=1; AJvYcCXYfN8FCjVb4pDaNthewv8Cmswh5AWiLMYQwvy+SwZsXaQzWBwINBoULJwxPljUGsqArM2q1XpJRVYcYDM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy436vHawhgOHKFfQxclwHEl4v2EEw94FSa4zx99PI3Zy0DuNxk
	GtCX2U2iIcDCwpK/o8Hk84aLEDvBdx7hy3mqYiuNroMLh6Tfl1KW
X-Gm-Gg: ASbGnctYu1h++PZHf57698qU1PBroqRnjs1G6H93EIi68TGy/yGffjWxe716lOENELC
	xrlm7f8UAZ3hK6Qm/qKDoFUS7BXrD9tIDYL79BOQ7+ZDr3q39LZeklVVpQYoW1359cvY5sYlt82
	lJhk7byb8EnpE/Zeuq1qgGERiXf1og42didN2FatgNXqB7WdvyqJv5NsI6mlT/J86bT7/TR2BDG
	JUA8KKhAL3X4tmh//iDWrYUQMQJFsFyzmSGWBrnOh5qu8bdcq1Gg98Tei3DO/0AEUwgx9R/SDaz
	4RctePQgqLlkNm8POBVmjh9QnKHYlmt3BmnMFZOBrQj+n8LLeaBs70f/Y06EDCF6eIBingF0+Kj
	0bjtynLahVJjZ3NRzz1/mhQ==
X-Google-Smtp-Source: AGHT+IF6B0melgd9ZTHhX9+OmeXv+v7h26IaVqxBaObXnrdTWrN/Qr4WVVvrYpXTWtPK3QkHwoGXhg==
X-Received: by 2002:a17:902:dac3:b0:21f:58fd:d215 with SMTP id d9443c01a7336-2265e6babf6mr99928505ad.11.1742542114211;
        Fri, 21 Mar 2025 00:28:34 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:33 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:04 +0800
Subject: [PATCH v6 03/10] ARM: dts: aspeed: catalina: Add MP5990 power
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
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-3-4bd85efeb9b4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=843;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=BbOh4hpBKP+yiYoTLN8aSP+ooMjZZlQ3ZAt1eegwZSA=;
 b=2JhrlSHvGwiwqPQm1ccY/be+hyH045aFSjhPcwPOkWU6/+9JxEdpWxKu3JcXk8yp85n579LF+
 KNdtNGtkVReCfztW3E/Ip078gcE0yYTcAo+88IyGSxSDQ0th+cDxzBZ
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


