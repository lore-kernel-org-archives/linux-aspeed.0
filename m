Return-Path: <linux-aspeed+bounces-4104-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14494CD4F5B
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 May 2026 20:28:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKmTj5ssQz2yLB;
	Wed, 20 May 2026 06:28:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::12e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779158238;
	cv=pass; b=KRS9sYaJkasq5d6tfFD0RIM6a3GwA1wQpsDDqPegyTGBK9k9MzkMQ5Pj2RtWuZJVhD4xp2akniK1k2InJqEyB+lysC7H7vT7KpeQZhNUwXtJYlNyGpmdhvXYirLeGkE9SX0h/3lq2wubjfrFv0MbWkJPZ59K4XUxg4jb0AWQ3flcFPPC05t4DvQGRTPSFFUsb0p3ACAkvccZ3Ay8g9IRVXMifFhS1p0gBL1AMWSkgZJaaIckwRMW8qeDkOhBVIyRYRv+s0Wr1KOp182ZCVMsBzOGd/2k51cE51Z6icv/9ub8aWr4kLeN/fvCNW9OYGhW9veevHr+iXoqjAAU1klmGw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779158238; c=relaxed/relaxed;
	bh=osk2Ehf8gRIyxZePYTyc8VCEviTTE/FY5hyaPiqbhe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fcg07PzrcmZLn+nNAqwfhyf+S6ufY1ROze5sQsjQ1sWJYsH2rXfFXlDu6KQjvdgV15QEwX2NvU/hlkD2WPyLbrZ/zT/cchN9mzO360zx3jdNiDLa6fIcFyq493eAmrzZ10wmpSbXHpvg6eEeTs6LrUzIgT46ggRJzDlLlE+W5IFLnQi5xxLQzeW2mx4qBfK/vrPmRvh8xo2yvCw3nmxXPeN2nKbs9BEDcGj1phtf0nzkdERCua4cVt0TCYtemQvyOSF+mgCthiNzkkrwG4KaiF0vnq3qqAn0L86y/VZTMGY/CwNLzFPiZt4T7K2mDkERPec8Zcpg1BZOgniC7M4EuA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JCGSbbWT; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JCGSbbWT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKJjT1zYQz2xwH
	for <linux-aspeed@lists.ozlabs.org>; Tue, 19 May 2026 12:37:16 +1000 (AEST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5aa1b2327c8so3399169e87.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 19:37:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779158231; cv=none;
        d=google.com; s=arc-20240605;
        b=O/ErDEQHU23ZdJvruIRKNDfFNw2s96OYrcYG9adL5XaS1TvHamaaYsoonp5jHwo7hg
         o0VUJ7f/70D9jYvqFKiHJLtC1hoq3yTU5L7z/dqnjhDi8sg7+jYE5P7F1KHoVn471Vfv
         HQls2ti8wcYqNnJCFXCMJSx4fk1HOpZCze9dhZaJ31Ejoyia+EVly337nMnlkuQwcGvA
         XJ3DKxeYXp3gQd9haZd2ffGkfqOWD/6WbW3RdZ4RUHc13Ky44Axb+ZHArXiICtnWe2Pe
         UbAMccelzTA/19YsV5sRdtY0AGDKvhmfmLzwqdcKcRe4W2JzLcuw2yrv70PbJfmbYNqN
         0LHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=osk2Ehf8gRIyxZePYTyc8VCEviTTE/FY5hyaPiqbhe0=;
        fh=v1ZU5fNA3DwBasiBAsg1oh5YvBzQKQvpMsws8VBtfVw=;
        b=NcTdczjtOajf+LSVe4/WWFTn3NALxE92ONIMJxyJQCNKgp5YbGpAQxVftggwOhkhI6
         1kgQJh5wDt8xhBwOKY8Q0qn3UFIj4hhqsQtxSbBouR+vuWYvT0R0oXuFPL+/gKipYfZs
         9BOsmfbEjCX9UPHQq8EHnmmpzwXkpE0NxR8glYaGyFNpzSdo4hslRmqRRVWqpF9qKHVr
         I3pcHst6UZ/M7ofojptpuBJ38/ElkuWy6flcIa2DPS4g1j2PzN6MxNxag9lDyDlTDchW
         sOMVdJy2fXVE08D31W7siy9gNX8Qf57TB+DgdIBOBKd5X5GEU0YjLVduTgDLnusuBAfz
         N/dA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779158231; x=1779763031; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osk2Ehf8gRIyxZePYTyc8VCEviTTE/FY5hyaPiqbhe0=;
        b=JCGSbbWTr82vJGhjjfKU0hUgb1p0OZW/PptNRQYwTPsye4/nchnqbYrj3zeB4LSoT3
         /ljIpFibyidHIj2RCqfy0XyJdUgFVHsXQNICBK38TFxRrABiSr8oGF9FWj6VuSJ3/amO
         MF9H4DO3HaT/mJRnNVzoM1m2c5BNtQULS78DjkFX5vQUPO9OX+RpqmXiXAdT2EqErDB9
         PO3rprVti/Y9+wysrfhZ7DmIt5XOcED/86PIYo1n8SmBSSGvd4DGnnuzKJEzTEv60IKm
         K9F2+Xopll5IXUOP1HEfLtoRfGIdJ+tuL/EIj87uhS84lqA+Z2NbdXTr4XDC6xZeeQep
         MBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779158231; x=1779763031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=osk2Ehf8gRIyxZePYTyc8VCEviTTE/FY5hyaPiqbhe0=;
        b=c3JeDzCw0WTBSvu19eymMNKq7tSkxNLRbQrDybTdy9oqKRODoz+N1HEFu3uvTP9m2t
         AkQTJ98mvvyApsmK7vcUaITaFIh/ivBPb8OUIEpOj+Fpv5R5Cu4cjJtF2AZAyv0pV7Xi
         pwNeDXNteazG/w//5BS+P31eQf0n4H8rB61Hy5g2q1m/P4qos9MKGSBS6lMwqAJDMljB
         DSi1n7580RyFORjsX5iGR+CPPR5stCr7bTY5m4FbH+HWP3PJ7gQ+i3UcK44e7XdOguoO
         3nqlZntQ9AQcMOvjKbQ59k407qLyRDby2WdNlWoIUq3h0KlYdDnnE0LajHyG+LDsC4Tl
         Z4+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8i9dRUh6TGHrsGrvqMM9JNGzKUPw8CBA07cIOzQIGmx8sCrSbmNrACn21WHYPlon8GwvgW84N8jM7AOn4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw9ljmmVPAPhn0Lfb9j3l4jfwlqPXPhFNR7eg4Fcyyd1F7ygux1
	2YpsJ3jmg6A5hhBjgGjEI5JeBJ7tSQsgCFmeXM0Fd1hVAzuG5j9G+fE1Hrnre3pXatCt7FLCBgQ
	n7otu93vJRuoZkgOotN05wCX96r2VIEE=
X-Gm-Gg: Acq92OGauXLBd7apdrChWQR/3g/moPYO5zvnWYkfX/TNh0moycpIfdxYaeNtWqmaXcV
	vxEPBFbXZtBVfT7SKyz/22pi8stT7gJixKPbYL8OAOORMXHeBieWEsQXJ1jt9048PXJKcbdTm1y
	+hUH2+s917UvUO48wE3Xpzxu3O0MCl1C9LZU8xDc4FyP4if8KpZf+EmxKVJIn1tUqpYfik38gk9
	3EJHlMZ1K2NH7XzVtiaeJ8SOKyZHTUd5bem+rXk7xNCdn3LFcoHjX7x0dJjFYoyV/EiXhQVhclz
	ZzgbLtWG6Ue2WUA9rgw=
X-Received: by 2002:ac2:4c4d:0:b0:5a8:6eb1:2b6d with SMTP id
 2adb3069b0e04-5aa0e5ff9efmr5988946e87.9.1779158230936; Mon, 18 May 2026
 19:37:10 -0700 (PDT)
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
References: <20260424-ventura2_initial_dts-v4-0-806b00ea4314@gmail.com>
 <20260424-ventura2_initial_dts-v4-2-806b00ea4314@gmail.com> <39b9a80fe4f49d72cefb8d3f8f1bb3776b9c4226.camel@codeconstruct.com.au>
In-Reply-To: <39b9a80fe4f49d72cefb8d3f8f1bb3776b9c4226.camel@codeconstruct.com.au>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 19 May 2026 10:38:17 +0800
X-Gm-Features: AVHnY4L_ACrdGc2LQ0XNQXTmod_sZYgXyAIgA58NbObsT7ySTr5DgQWNhQf6H5M
Message-ID: <CAF7HswPn65kvTAyYDj_o=nSn3YhQhKqBaak7nt11x-8bZ7M6vg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 3:18=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Kyle,
>
> Firstly, are you trying to represent multiple revisions of the hardware
> design in this devicetree? I'm curious due to the 'legacy' labels
> below.
>
In the previous Ventura hardware generation, these pins were
 implemented as a set of direct, native physical GPIO signals. In the V2
 design, we introduced alternative interfaces and routed these paths
through the CPLD to convert them into GPIOs before reaching the
BMC.

We chose to retain the 'legacy' prefix to maintain backward
compatibility with our existing userspace software stack and scripts
that transitioned from the previous Ventura platform. Altering these
labels now would break compatibility with applications that rely on
these specific naming conventions. I will add comments in the DTS to
clarify this context.
> On Fri, 2026-04-24 at 17:30 +0800, Kyle Hsieh wrote:
> > Add linux device tree entry related to the Meta(Facebook) rmc-node.
> > The system use an AT2600 BMC.
> > This node is named "ventura2".
> >
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed/Makefile                  |    1 +
> >  .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 2925 ++++++++++++=
++++++++
> >  2 files changed, 2926 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspe=
ed/Makefile
> > index 9adf9278dc94..6b96997629d4 100644
> > --- a/arch/arm/boot/dts/aspeed/Makefile
> > +++ b/arch/arm/boot/dts/aspeed/Makefile
> > @@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> >       aspeed-bmc-facebook-minipack.dtb \
> >       aspeed-bmc-facebook-santabarbara.dtb \
> >       aspeed-bmc-facebook-tiogapass.dtb \
> > +     aspeed-bmc-facebook-ventura2.dtb \
> >       aspeed-bmc-facebook-wedge40.dtb \
> >       aspeed-bmc-facebook-wedge100.dtb \
> >       aspeed-bmc-facebook-wedge400-data64.dtb \
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts =
b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> > new file mode 100644
> > index 000000000000..8d4ddb473862
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> > @@ -0,0 +1,2925 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2023 Facebook Inc.
> > +/dts-v1/;
> > +
> > +#include "aspeed-g6.dtsi"
> > +#include <dt-bindings/i2c/i2c.h>
> > +#include <dt-bindings/gpio/aspeed-gpio.h>
> > +
> > +/ {
> > +     model =3D "Facebook Ventura2 RMC";
> > +     compatible =3D "facebook,ventura2-rmc", "aspeed,ast2600";
> > +     aliases {
> > +             serial2 =3D &uart3;
> > +             serial4 =3D &uart5;
> > +
> > +             /*
> > +              * i2c switch 0-0077, pca9548, 8 child channels assigned
> > +              * with bus number 16-23.
> > +              */
> > +             i2c16 =3D &i2c0mux0ch0;
> > +             i2c17 =3D &i2c0mux0ch1;
> > +             i2c18 =3D &i2c0mux0ch2;
> > +             i2c19 =3D &i2c0mux0ch3;
> > +             i2c20 =3D &i2c0mux0ch4;
> > +             i2c21 =3D &i2c0mux0ch5;
> > +             i2c22 =3D &i2c0mux0ch6;
> > +             i2c23 =3D &i2c0mux0ch7;
> > +
> > +             /*
> > +              * i2c switch 1-0077, pca9548, 8 child channels assigned
> > +              * with bus number 24-31.
> > +              */
> > +             i2c24 =3D &i2c1mux0ch0;
> > +             i2c25 =3D &i2c1mux0ch1;
> > +             i2c26 =3D &i2c1mux0ch2;
> > +             i2c27 =3D &i2c1mux0ch3;
> > +             i2c28 =3D &i2c1mux0ch4;
> > +             i2c29 =3D &i2c1mux0ch5;
> > +             i2c30 =3D &i2c1mux0ch6;
> > +             i2c31 =3D &i2c1mux0ch7;
> > +
> > +             /*
> > +              * i2c switch 4-0077, pca9548, 8 child channels assigned
> > +              * with bus number 32-39.
> > +              */
> > +             i2c32 =3D &i2c4mux0ch0;
> > +             i2c33 =3D &i2c4mux0ch1;
> > +             i2c34 =3D &i2c4mux0ch2;
> > +             i2c35 =3D &i2c4mux0ch3;
> > +             i2c36 =3D &i2c4mux0ch4;
> > +             i2c37 =3D &i2c4mux0ch5;
> > +             i2c38 =3D &i2c4mux0ch6;
> > +             i2c39 =3D &i2c4mux0ch7;
> > +
> > +             /*
> > +              * i2c switch 5-0077, pca9548, 8 child channels assigned
> > +              * with bus number 40-47.
> > +              */
> > +             i2c40 =3D &i2c5mux0ch0;
> > +             i2c41 =3D &i2c5mux0ch1;
> > +             i2c42 =3D &i2c5mux0ch2;
> > +             i2c43 =3D &i2c5mux0ch3;
> > +             i2c44 =3D &i2c5mux0ch4;
> > +             i2c45 =3D &i2c5mux0ch5;
> > +             i2c46 =3D &i2c5mux0ch6;
> > +             i2c47 =3D &i2c5mux0ch7;
> > +
> > +             /*
> > +              * i2c switch 8-0077, pca9548, 8 child channels assigned
> > +              * with bus number 48-55.
> > +              */
> > +             i2c48 =3D &i2c8mux0ch0;
> > +             i2c49 =3D &i2c8mux0ch1;
> > +             i2c50 =3D &i2c8mux0ch2;
> > +             i2c51 =3D &i2c8mux0ch3;
> > +             i2c52 =3D &i2c8mux0ch4;
> > +             i2c53 =3D &i2c8mux0ch5;
> > +             i2c54 =3D &i2c8mux0ch6;
> > +             i2c55 =3D &i2c8mux0ch7;
> > +
> > +             /*
> > +              * i2c switch 11-0077, pca9548, 8 child channels assigned
> > +              * with bus number 56-63.
> > +              */
> > +             i2c56 =3D &i2c11mux0ch0;
> > +             i2c57 =3D &i2c11mux0ch1;
> > +             i2c58 =3D &i2c11mux0ch2;
> > +             i2c59 =3D &i2c11mux0ch3;
> > +             i2c60 =3D &i2c11mux0ch4;
> > +             i2c61 =3D &i2c11mux0ch5;
> > +             i2c62 =3D &i2c11mux0ch6;
> > +             i2c63 =3D &i2c11mux0ch7;
> > +
> > +             /*
> > +              * i2c switch 13-0077, pca9548, 8 child channels assigned
> > +              * with bus number 64-71.
> > +              */
> > +             i2c64 =3D &i2c13mux0ch0;
> > +             i2c65 =3D &i2c13mux0ch1;
> > +             i2c66 =3D &i2c13mux0ch2;
> > +             i2c67 =3D &i2c13mux0ch3;
> > +             i2c68 =3D &i2c13mux0ch4;
> > +             i2c69 =3D &i2c13mux0ch5;
> > +             i2c70 =3D &i2c13mux0ch6;
> > +             i2c71 =3D &i2c13mux0ch7;
> > +
> > +             /*
> > +              * i2c switch 15-0077, pca9548, 8 child channels assigned
> > +              * with bus number 72-79.
> > +              */
> > +             i2c72 =3D &i2c15mux0ch0;
> > +             i2c73 =3D &i2c15mux0ch1;
> > +             i2c74 =3D &i2c15mux0ch2;
> > +             i2c75 =3D &i2c15mux0ch3;
> > +             i2c76 =3D &i2c15mux0ch4;
> > +             i2c77 =3D &i2c15mux0ch5;
> > +             i2c78 =3D &i2c15mux0ch6;
> > +             i2c79 =3D &i2c15mux0ch7;
>
> Can you please add comments justifying why all of these aliases are
> necessary given a number of them are for busses with no devices
> described under them?
These I2C aliases are pre-allocated because these empty channels are
 strictly reserved for future hardware feature expansions, which will
interface with add-on boards. I will add clear comments in the code to
justify their necessity in the next patch.
>
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial4:57600n8";
> > +     };
> > +
> > +     fan_leds {
> > +             compatible =3D "gpio-leds";
> > +
> > +             led-0 {
> > +                     label =3D "fcb0fan0_ledd1_blue";
>
> Given the labels are exposed to userspace and is something applications
> likely consume, is the double 'd' in led intentional?
Yes, the double 'd' in "ledd1" is intentional. It aligns with our hardware
 schematic design naming convention, where these specific onboard
indicators are designated as LEDD1, LEDD2, etc.
>
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander0 0 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-1 {
> > +                     label =3D "fcb0fan1_ledd2_blue";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander0 1 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-2 {
> > +                     label =3D "fcb0fan2_ledd3_blue";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander1 0 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-3 {
> > +                     label =3D "fcb0fan3_ledd4_blue";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander1 1 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-4 {
> > +                     label =3D "fcb0fan0_ledd1_amber";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander0 4 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-5 {
> > +                     label =3D "fcb0fan1_ledd2_amber";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander0 5 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-6 {
> > +                     label =3D "fcb0fan2_ledd3_amber";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander1 4 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-7 {
> > +                     label =3D "fcb0fan3_ledd4_amber";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander1 5 GPIO_ACTIVE_LOW>;
> > +             };
> > +     };
> > +
>
> ...
>
> > +
> > +&fmc {
> > +     status =3D "okay";
> > +     flash@0 {
> > +             status =3D "okay";
> > +             m25p,fast-read;
> > +             label =3D "bmc";
> > +             spi-max-frequency =3D <50000000>;
> > +             #include "openbmc-flash-layout-128.dtsi"
> > +     };
> > +     flash@1 {
> > +             status =3D "okay";
> > +             m25p,fast-read;
> > +             label =3D "alt-bmc";
> > +             spi-max-frequency =3D <50000000>;
>
> Perhaps include the alternate flash layout dtsi here?
The `flash@1` (`alt-bmc`) node is intentionally left unpartitioned
 without the layout DTSI.

In our dual-flash design, `flash@1` serves as the secondary/backup
flash chip. Keeping it without sub-partitions allows the kernel and
userspace tools to treat this flash as a single, contiguous raw MTD
device. This is required by our firmware update mechanism, which
flashes a single, full-size composite image directly to the entire
backup flash.

This structure follows the existing upstream pattern established in
`aspeed-bmc-facebook-yosemite5.dts`.
>
> > +     };
> > +};
> > +
> > +&peci0 {
>
> Can you please order the nodes alphabetically. P is not between F and
> G.
I will ensure all nodes are strictly sorted in alphabetical order in
the next version.
>
> > +     status =3D "okay";
> > +};
> > +
> >
>
> ...
>
> > +
> > +&i2c10 {
> > +     status =3D "okay";
> > +
> > +     legacy_prsnt_io_expander0: gpio@11 {
>
> Why 'legacy'?
>
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x11>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +             interrupt-parent =3D <&sgpiom0>;
> > +             interrupts =3D <40 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             gpio-line-names =3D
> > +                     "TRAY_PRSNT1_N_BUF_R", "TRAY_PRSNT2_N_BUF_R",
> > +                     "TRAY_PRSNT3_N_BUF_R", "TRAY_PRSNT4_N_BUF_R",
> > +                     "TRAY_PRSNT5_N_BUF_R", "TRAY_PRSNT6_N_BUF_R",
> > +                     "TRAY_PRSNT7_N_BUF_R", "TRAY_PRSNT8_N_BUF_R",
> > +                     "TRAY_PRSNT9_N_BUF_R", "TRAY_PRSNT10_N_BUF_R",
> > +                     "TRAY_PRSNT11_N_BUF_R", "TRAY_PRSNT12_N_BUF_R",
> > +                     "TRAY_PRSNT13_N_BUF_R", "TRAY_PRSNT14_N_BUF_R",
> > +                     "TRAY_PRSNT15_N_BUF_R", "TRAY_PRSNT16_N_BUF_R";
> > +     };
> > +
> > +     legacy_prsnt_io_expander1: gpio@12 {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x12>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +             interrupt-parent =3D <&sgpiom0>;
> > +             interrupts =3D <40 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             gpio-line-names =3D
> > +                     "TRAY_PRSNT17_N_BUF_R", "TRAY_PRSNT18_N_BUF_R",
> > +                     "TRAY_PRSNT19_N_BUF_R", "TRAY_PRSNT20_N_BUF_R",
> > +                     "TRAY_PRSNT21_N_BUF_R", "TRAY_PRSNT22_N_BUF_R",
> > +                     "TRAY_PRSNT23_N_BUF_R", "TRAY_PRSNT24_N_BUF_R",
> > +                     "TRAY_PRSNT25_N_BUF_R", "TRAY_PRSNT26_N_BUF_R",
> > +                     "TRAY_PRSNT27_N_BUF_R", "TRAY_PRSNT28_N_BUF_R",
> > +                     "TRAY_PRSNT29_N_BUF_R", "TRAY_PRSNT30_N_BUF_R",
> > +                     "TRAY_PRSNT31_N_BUF_R", "TRAY_PRSNT32_N_BUF_R";
> > +     };
> > +
> > +     legacy_prsnt_io_expander2: gpio@13 {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x13>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +             interrupt-parent =3D <&sgpiom0>;
> > +             interrupts =3D <40 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             gpio-line-names =3D
> > +                     "TRAY_PRSNT33_N_BUF_R", "TRAY_PRSNT34_N_BUF_R",
> > +                     "TRAY_PRSNT35_N_BUF_R", "TRAY_PRSNT36_N_BUF_R",
> > +                     "TRAY_PRSNT37_N_BUF_R", "TRAY_PRSNT38_N_BUF_R",
> > +                     "TRAY_PRSNT39_N_BUF_R", "TRAY_PRSNT40_N_BUF_R",
> > +                     "", "",
> > +                     "", "",
> > +                     "", "",
> > +                     "", "";
> > +     };
> > +
> > +     power-monitor@14 {
> > +             compatible =3D "infineon,xdp710";
> > +             reg =3D <0x14>;
> > +     };
> > +
> > +     legacy_pwrgd_io_expander1: gpio@15 {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x15>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +             interrupt-parent =3D <&sgpiom0>;
> > +             interrupts =3D <42 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             gpio-line-names =3D
> > +                     "TRAY_PWRGD17_N_BUF_R", "TRAY_PWRGD18_N_BUF_R",
> > +                     "TRAY_PWRGD19_N_BUF_R", "TRAY_PWRGD20_N_BUF_R",
> > +                     "TRAY_PWRGD21_N_BUF_R", "TRAY_PWRGD22_N_BUF_R",
> > +                     "TRAY_PWRGD23_N_BUF_R", "TRAY_PWRGD24_N_BUF_R",
> > +                     "TRAY_PWRGD25_N_BUF_R", "TRAY_PWRGD26_N_BUF_R",
> > +                     "TRAY_PWRGD27_N_BUF_R", "TRAY_PWRGD28_N_BUF_R",
> > +                     "TRAY_PWRGD29_N_BUF_R", "TRAY_PWRGD30_N_BUF_R",
> > +                     "TRAY_PWRGD31_N_BUF_R", "TRAY_PWRGD32_N_BUF_R";
> > +     };
> > +
> > +     legacy_pwrgd_io_expander2: gpio@16 {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x16>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +             interrupt-parent =3D <&sgpiom0>;
> > +             interrupts =3D <42 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             gpio-line-names =3D
> > +                     "TRAY_PWRGD33_N_BUF_R", "TRAY_PWRGD34_N_BUF_R",
> > +                     "TRAY_PWRGD35_N_BUF_R", "TRAY_PWRGD36_N_BUF_R",
> > +                     "TRAY_PWRGD37_N_BUF_R", "TRAY_PWRGD38_N_BUF_R",
> > +                     "TRAY_PWRGD39_N_BUF_R", "TRAY_PWRGD40_N_BUF_R",
> > +                     "", "",
> > +                     "", "",
> > +                     "", "",
> > +                     "", "";
> > +     };
> > +
> > +     legacy_leak_io_expander0: gpio@17 {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x17>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +             interrupt-parent =3D <&sgpiom0>;
> > +             interrupts =3D <46 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             gpio-line-names =3D
> > +                     "TRAY_LEAK_DETECT1_N_BUF_R", "TRAY_LEAK_DETECT2_N=
_BUF_R",
> > +                     "TRAY_LEAK_DETECT3_N_BUF_R", "TRAY_LEAK_DETECT4_N=
_BUF_R",
> > +                     "TRAY_LEAK_DETECT5_N_BUF_R", "TRAY_LEAK_DETECT6_N=
_BUF_R",
> > +                     "TRAY_LEAK_DETECT7_N_BUF_R", "TRAY_LEAK_DETECT8_N=
_BUF_R",
> > +                     "TRAY_LEAK_DETECT9_N_BUF_R", "TRAY_LEAK_DETECT10_=
N_BUF_R",
> > +                     "TRAY_LEAK_DETECT11_N_BUF_R", "TRAY_LEAK_DETECT12=
_N_BUF_R",
> > +                     "TRAY_LEAK_DETECT13_N_BUF_R", "TRAY_LEAK_DETECT14=
_N_BUF_R",
> > +                     "TRAY_LEAK_DETECT15_N_BUF_R", "TRAY_LEAK_DETECT16=
_N_BUF_R";
> > +     };
> > +
> > +     legacy_leak_io_expander1: gpio@18 {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x18>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +             interrupt-parent =3D <&sgpiom0>;
> > +             interrupts =3D <46 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             gpio-line-names =3D
> > +                     "TRAY_LEAK_DETECT17_N_BUF_R", "TRAY_LEAK_DETECT18=
_N_BUF_R",
> > +                     "TRAY_LEAK_DETECT19_N_BUF_R", "TRAY_LEAK_DETECT20=
_N_BUF_R",
> > +                     "TRAY_LEAK_DETECT21_N_BUF_R", "TRAY_LEAK_DETECT22=
_N_BUF_R",
> > +                     "TRAY_LEAK_DETECT23_N_BUF_R", "TRAY_LEAK_DETECT24=
_N_BUF_R",
> > +                     "TRAY_LEAK_DETECT25_N_BUF_R", "TRAY_LEAK_DETECT26=
_N_BUF_R",
> > +                     "TRAY_LEAK_DETECT27_N_BUF_R", "TRAY_LEAK_DETECT28=
_N_BUF_R",
> > +                     "TRAY_LEAK_DETECT29_N_BUF_R", "TRAY_LEAK_DETECT30=
_N_BUF_R",
> > +                     "TRAY_LEAK_DETECT31_N_BUF_R", "TRAY_LEAK_DETECT32=
_N_BUF_R";
> > +     };
> > +
> > +     legacy_leak_io_expander2: gpio@19 {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x19>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +             interrupt-parent =3D <&sgpiom0>;
> > +             interrupts =3D <46 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             gpio-line-names =3D
> > +                     "TRAY_LEAK_DETECT33_N_BUF_R", "TRAY_LEAK_DETECT34=
_N_BUF_R",
> > +                     "TRAY_LEAK_DETECT35_N_BUF_R", "TRAY_LEAK_DETECT36=
_N_BUF_R",
> > +                     "TRAY_LEAK_DETECT37_N_BUF_R", "TRAY_LEAK_DETECT38=
_N_BUF_R",
> > +                     "TRAY_LEAK_DETECT39_N_BUF_R", "TRAY_LEAK_DETECT40=
_N_BUF_R",
> > +                     "", "",
> > +                     "", "",
> > +                     "", "",
> > +                     "", "";
> > +     };
> > +
> > +     legacy_small_leak_io_expander0: gpio@1a {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x1a>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +             interrupt-parent =3D <&sgpiom0>;
> > +             interrupts =3D <44 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             gpio-line-names =3D
> > +                     "TRAY_SMALL_LEAK1_N_BUF_R", "TRAY_SMALL_LEAK2_N_B=
UF_R",
> > +                     "TRAY_SMALL_LEAK3_N_BUF_R", "TRAY_SMALL_LEAK4_N_B=
UF_R",
> > +                     "TRAY_SMALL_LEAK5_N_BUF_R", "TRAY_SMALL_LEAK6_N_B=
UF_R",
> > +                     "TRAY_SMALL_LEAK7_N_BUF_R", "TRAY_SMALL_LEAK8_N_B=
UF_R",
> > +                     "TRAY_SMALL_LEAK9_N_BUF_R", "TRAY_SMALL_LEAK10_N_=
BUF_R",
> > +                     "TRAY_SMALL_LEAK11_N_BUF_R", "TRAY_SMALL_LEAK12_N=
_BUF_R",
> > +                     "TRAY_SMALL_LEAK13_N_BUF_R", "TRAY_SMALL_LEAK14_N=
_BUF_R",
> > +                     "TRAY_SMALL_LEAK15_N_BUF_R", "TRAY_SMALL_LEAK16_N=
_BUF_R";
> > +     };
> > +
> > +     legacy_small_leak_io_expander1: gpio@1b {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x1b>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +             interrupt-parent =3D <&sgpiom0>;
> > +             interrupts =3D <44 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             gpio-line-names =3D
> > +                     "TRAY_SMALL_LEAK17_N_BUF_R", "TRAY_SMALL_LEAK18_N=
_BUF_R",
> > +                     "TRAY_SMALL_LEAK19_N_BUF_R", "TRAY_SMALL_LEAK20_N=
_BUF_R",
> > +                     "TRAY_SMALL_LEAK21_N_BUF_R", "TRAY_SMALL_LEAK22_N=
_BUF_R",
> > +                     "TRAY_SMALL_LEAK23_N_BUF_R", "TRAY_SMALL_LEAK24_N=
_BUF_R",
> > +                     "TRAY_SMALL_LEAK25_N_BUF_R", "TRAY_SMALL_LEAK26_N=
_BUF_R",
> > +                     "TRAY_SMALL_LEAK27_N_BUF_R", "TRAY_SMALL_LEAK28_N=
_BUF_R",
> > +                     "TRAY_SMALL_LEAK29_N_BUF_R", "TRAY_SMALL_LEAK30_N=
_BUF_R",
> > +                     "TRAY_SMALL_LEAK31_N_BUF_R", "TRAY_SMALL_LEAK32_N=
_BUF_R";
> > +     };
> > +
> > +     legacy_small_leak_io_expander2: gpio@1c {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x1c>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +             interrupt-parent =3D <&sgpiom0>;
> > +             interrupts =3D <44 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             gpio-line-names =3D
> > +                     "TRAY_SMALL_LEAK33_N_BUF_R", "TRAY_SMALL_LEAK34_N=
_BUF_R",
> > +                     "TRAY_SMALL_LEAK35_N_BUF_R", "TRAY_SMALL_LEAK36_N=
_BUF_R",
> > +                     "TRAY_SMALL_LEAK37_N_BUF_R", "TRAY_SMALL_LEAK38_N=
_BUF_R",
> > +                     "TRAY_SMALL_LEAK39_N_BUF_R", "TRAY_SMALL_LEAK40_N=
_BUF_R",
> > +                     "", "",
> > +                     "", "",
> > +                     "", "",
> > +                     "", "";
> > +     };
> > +
> > +     legacy_pwrgd_io_expander0: gpio@28 {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x28>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +             interrupt-parent =3D <&sgpiom0>;
> > +             interrupts =3D <42 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             gpio-line-names =3D
> > +                     "TRAY_PWRGD1_N_BUF_R", "TRAY_PWRGD2_N_BUF_R",
> > +                     "TRAY_PWRGD3_N_BUF_R", "TRAY_PWRGD4_N_BUF_R",
> > +                     "TRAY_PWRGD5_N_BUF_R", "TRAY_PWRGD6_N_BUF_R",
> > +                     "TRAY_PWRGD7_N_BUF_R", "TRAY_PWRGD8_N_BUF_R",
> > +                     "TRAY_PWRGD9_N_BUF_R", "TRAY_PWRGD10_N_BUF_R",
> > +                     "TRAY_PWRGD11_N_BUF_R", "TRAY_PWRGD12_N_BUF_R",
> > +                     "TRAY_PWRGD13_N_BUF_R", "TRAY_PWRGD14_N_BUF_R",
> > +                     "TRAY_PWRGD15_N_BUF_R", "TRAY_PWRGD16_N_BUF_R";
> > +     };
> > +
>
> ...
>
> > +
> > +&mdio0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&peci0 {
> > +     status =3D "okay";
> > +};
>
> Ah, so the earlier peci node is redundant. Can you please remove it?
Got it. I will remove the redundant peci0 node and ensure all nodes
 are strictly sorted in alphabetical order in the next version.
>
> Andrew

