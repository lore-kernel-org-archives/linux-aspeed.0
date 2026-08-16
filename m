Return-Path: <linux-aspeed+bounces-4728-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03A3C5B572
	for <linux-aspeed@archiver.kernel.org>; Sun, 16 Aug 2026 04:56:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hN3bR3px5z2y83;
	Sun, 16 Aug 2026 14:56:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2605:2700:0:5::4713:9cab"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786856211;
	cv=none; b=BXrZhFV+KmLfJTP3QAOC0XY0s7SqCRf8bjpd9U6kwuYnOF7YSm/MgNdCYjtu0Rsm2+KHR1WWi7H3xhRX+2HkKHVrUcC58WG5S0aCREcCW0MSgTlZRGsWbkxtpqxxnQ1QtPJlcekxGupnwwiNJeFesw0FswcjJMWdajhoRBB4S6dmO7B8JSb5n2CHJl6TceMbxZa7y+0/jmnu1+N4I94Kp8vvh1rKycuygYRnpBD9T7B2lW1Xqgdf8dDE158ZoTuVfSkNjA8wdhJ8QjSDAG1wJGCOtc3KitT134mvyn4C9ogU3We4yhtLIz5zCo4OIiWlT9MqHcIWR8Nkec8Sek6hBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786856211; c=relaxed/relaxed;
	bh=SH81kaqs40gwxAAYK6f8GxK6WGlHqHpk/2gAgBEj770=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsJUNGdur1noUjllo5sb/LcKUTStZ00lOc+wU2YPSoGvYoOTMBwedwC+s7+ZvrSzGi69pKQadFxGP2C4j6OHoZef0YuKY+O6IcfQ6y3nmf+rOkQ5AYtFnooXb8tvCwbMiNuUdwH+Cxuu2H2eexlhEwNUGsFy/+CYu6p2T4qPR085tjrLXJp6RYGXR+tTyQt/tIyKWa+MOzEvLduRgVMFo7rJC20mJJ/GseUcIrr8oHTYkMWiFbnrvBwVEqiUBaq47UiI8G85sfWGHxSLntwBY5Dl5B6+nZGLvQUkJZqSiZ2OFlgu9H0kDTs4xgNo0kKs/OhVtRX+Xwr7bSto0yn5rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; dkim=pass (1024-bit key; unprotected) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.a=rsa-sha256 header.s=thorn header.b=ZjlFHuJf; dkim-atps=neutral; spf=pass (client-ip=2605:2700:0:5::4713:9cab; helo=thorn.bewilderbeest.net; envelope-from=zev@bewilderbeest.net; receiver=lists.ozlabs.org) smtp.mailfrom=bewilderbeest.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.a=rsa-sha256 header.s=thorn header.b=ZjlFHuJf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bewilderbeest.net (client-ip=2605:2700:0:5::4713:9cab; helo=thorn.bewilderbeest.net; envelope-from=zev@bewilderbeest.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 443 seconds by postgrey-1.37 at boromir; Sun, 16 Aug 2026 14:56:48 AEST
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hN3bN1Zl2z2xwM
	for <linux-aspeed@lists.ozlabs.org>; Sun, 16 Aug 2026 14:56:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1786855758;
	bh=SH81kaqs40gwxAAYK6f8GxK6WGlHqHpk/2gAgBEj770=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZjlFHuJfDQ2TepIAgft9Ee5sOxZappA4HKrXF7EdXh3p9oLlcHa/3wCqhUbm0axp/
	 O4zVHjBiwlxDsfGeBcS942tSyzKkeYydyunzRWbvhaKirGR8ItDJWyXWkha3HLRxvu
	 siEXmClJO9dDm6J51BZHy47IaDiKrGIXZgMFcCvY=
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:71d1:5c00::171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id CF3CF4C;
	Sat, 15 Aug 2026 21:49:17 -0700 (PDT)
Date: Sat, 15 Aug 2026 21:49:16 -0700
From: Zev Weiss <zev@bewilderbeest.net>
To: Tan Siewert <tan@siewert.io>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: add asrock x470d4u bmc
Message-ID: <8b7dcb07-2dfd-425f-8ff3-06114e45c676@hatter.bewilderbeest.net>
References: <20260812-ts-x470d4u-v3-0-c8e266f1663b@siewert.io>
 <20260812-ts-x470d4u-v3-2-c8e266f1663b@siewert.io>
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
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260812-ts-x470d4u-v3-2-c8e266f1663b@siewert.io>

Hi Tan,

Looks good overall to me, just a couple small notes below...

On Wed, Aug 12, 2026 at 01:28:27PM PDT, Tan Siewert wrote:
>The ASRock Rack X470D4U X470D4U is a single-socket X470-based microATX
>motherboard for Ryzen processors with an AST2500 BMC and either 32MB or
>64MB SPI flash.
>
>This mainboard exists in three known "flavors" which only differ in the
>used host NIC, the BMC SPI size and some parts that may be un-populated.
>
>To allow the use of the full SPI flash, add two trees, one of which has
>the 32M layout with the base config, and a 64M tree that includes the
>base tree.
>
>Signed-off-by: Tan Siewert <tan@siewert.io>
>---
> arch/arm/boot/dts/aspeed/Makefile                  |   2 +
> .../aspeed/aspeed-bmc-asrock-x470d4u-data64.dts    |  15 +
> .../boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts  | 381 +++++++++++++++++++++
> 3 files changed, 398 insertions(+)
>
>diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>index 6b68671f9379..e27d33e85fb2 100644
>--- a/arch/arm/boot/dts/aspeed/Makefile
>+++ b/arch/arm/boot/dts/aspeed/Makefile
>@@ -15,6 +15,8 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
> 	aspeed-bmc-asrock-paul-ipmi-card.dtb \
> 	aspeed-bmc-asrock-romed8hm3.dtb \
> 	aspeed-bmc-asrock-spc621d8hm3.dtb \
>+	aspeed-bmc-asrock-x470d4u.dtb \
>+	aspeed-bmc-asrock-x470d4u-data64.dtb \
> 	aspeed-bmc-asrock-x570d4u.dtb \
> 	aspeed-bmc-asus-kommando-ipmi-card.dtb \
> 	aspeed-bmc-asus-x4tf.dtb \
>diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u-data64.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u-data64.dts
>new file mode 100644
>index 000000000000..6f11aeab087c
>--- /dev/null
>+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u-data64.dts
>@@ -0,0 +1,15 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+
>+#include "aspeed-bmc-asrock-x470d4u.dts"
>+
>+/ {
>+	compatible = "asrock,x470d4u-data64-bmc", "aspeed,ast2500";
>+	model = "Asrock Rack X470D4U-series BMC (64MB store)";

Nit: for consistency with how they spell it, and (at least *most* of) 
the other aspeed-bmc-asrock-*.dts files, I'd suggest "ASRock" instead of 
"Asrock".  (And IMO s/store/flash/ would be a touch clearer.)

Also, looks like the other nearby DTS files pretty consistently have 
compatible & model in the opposite order, so matching that might be nice 
too.

>+};
>+
>+&fmc {
>+	flash@0 {
>+		/delete-node/partitions;
>+#include "openbmc-flash-layout-64.dtsi"
>+	};
>+};
>diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
>new file mode 100644
>index 000000000000..80fb2b7c1e0c
>--- /dev/null
>+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts

<snip>

>+
>+	fan@3 {
>+		/* FAN4 (6-pin) */
>+		reg = <0x03>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x03 0x0b>;
>+	};
>+
>+	fan@4 {
>+		/* FAN5 (6-pin) */
>+		reg = <0x04>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x04 0x0d>;
>+	};
>+
>+	fan@5 {
>+		/* FAN6 (6-pin) */
>+		reg = <0x05>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x05 0x0e>;
>+	};
>+};

Just to confirm, skipping channel 0xc here is intentional I assume?  
(Most other related platforms have them contiguously numbered, but not 
all, so another slight oddity wouldn't be too shocking.)


Thanks,
Zev


