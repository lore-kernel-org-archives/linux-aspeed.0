Return-Path: <linux-aspeed+bounces-4100-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC27CD4F54
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 May 2026 20:28:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKmSc4rGRz2xwH;
	Wed, 20 May 2026 06:27:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::236" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779158840;
	cv=pass; b=eqxBf0yky2TvBJBCGlYbvF9IJNxDnAV94qaXpkQPd13UMHwOVmn34lzWrdCHSTeQMMXb1xHGr1JKm8tdlmyljzBc3DO3l7aNtswVp0Sv0W950tQFuwbsqgR2oawKM2KF+081ONBvdLS3AsAoiT3/UZEpdun41Y4lHOEhAoVSgrdK1pq3TH7zYS5IeqbGUqLgCp3yJwb9AiHVoMyS3NEynVId/hycPhLZ3YynXtHmTLgSt+hNtz6l2rd3yZpTfdaQUF7MNodTu2Bjadu10zxh72iDPQkO7uCHYwNbdozP/oXXjwbmSNjkuF2j/HR2J1A/qkJkKrcQffxju/KuVECcGQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779158840; c=relaxed/relaxed;
	bh=RQP6saiiXAQJTpPARLrRFM0Ns2dwyXRFEWBvIe0BZcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NshDl8bgk6gyuPOOF6LDl/k9Jn76eBk2Xg9HfGWcYoda7aJfYzVeP3v+vo8VwfveqvJ3EK5hkKsJx2qfq+wfEVaJJNR97jzDNT9OSKwniHZ+1n468ykK9Rm1ZpD1Euh2ksfUYTpnm0NUb8AFRjF3IZlgzFjkVsGKBB+QkqptghkqTpZlJVXyM0vV6t4twT7VOTV/R3FFUgINP8jctpHQsPO51uDpOAJBOBoxZzpkT9ha235VTnsPsN9INrsApIFi2llXgtLuN9GCvBOt2NJ0hs/7rczMZ2HmnwoYetr4RLUf9nTVEFYmo0zO0OiuNIGqt5U8063Fi41NTp5cRfy9Lg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iuFOSGCR; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::236; helo=mail-lj1-x236.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iuFOSGCR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::236; helo=mail-lj1-x236.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKJx22TTkz2xwH
	for <linux-aspeed@lists.ozlabs.org>; Tue, 19 May 2026 12:47:17 +1000 (AEST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-394413a63d3so26332241fa.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 19:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779158834; cv=none;
        d=google.com; s=arc-20240605;
        b=bzsUDGHeVnt5Z0bYUNDCSORKj8KxTJeSaabKBJUEXwhIMed9TwyU0rW2WqpT8IT1Vk
         CUcIPa6QaHR++jGPJCuM8pEGH+TOlNbw9HRhSKKAsyP40xM0m2rT6+Hs3qZEU3q7rO2Q
         3CxwRGs1EeTzYUi5wJZSOarFxES8u7R27Bk6oIbTK+o3EJHGPc8VQ5gVtmlkjAl4E9bz
         SbVqkSsYHt+SEZMy28UlXgB9/6+QkEnfUqe/KN8KgXwfUfQQGVevO6oNkCL56525KhSY
         SwIpd/XxQTpgxY7+RgPocwqs323dJsYyd7knMSOjmeszdnSCAkSkuQMLnqsTKo84Dr5k
         l20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RQP6saiiXAQJTpPARLrRFM0Ns2dwyXRFEWBvIe0BZcE=;
        fh=n3gRv+Lbrg1c+s3aRD/Ib6Wn3eCjwHpXxmdAJa8oQDw=;
        b=XwbBm8UgSeYP8l4ygMqYAJZ6CeM93au9zv4YqWtU+nGklEHIQhxjwLbO9mKFBn42+O
         kVCoBKRrO9lsAqxYpWXXVgrnwB1CmN9r5WWxggFFxIBebn0mQY1AedOzcVTmYU0M8iwb
         9Xcp0Uid/1GM6Ur1dO8Mlo26I/SuIy2OzfDTZLUFxrd25A1IE5S131sq6aDiqnfGqUUr
         4L0ztFPw2W6uNqPxM1ZMtoN41N0eV/2doyeLNL/QGuwrPVkYdLcjDKTDvCyyoL36fQNv
         H5OvmNO76mWtYaa/RIghkueXaHqjEJNti/OAXbe1uK8QvwMBZSpYddktKX/zSdEGAMJ8
         GPVg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779158834; x=1779763634; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQP6saiiXAQJTpPARLrRFM0Ns2dwyXRFEWBvIe0BZcE=;
        b=iuFOSGCRvfafE5WjZrzs2gcIXu3X68AV0sR1TP8++onesKpN2u4IyLVppaNY546vIC
         ATPfoVDeel0BO03lEOyk5Z2Qb215sYvS7lXI6WfTtf5zFQQg4sebs2Yr2YHRRq8EtahU
         1KPjhizlrjSAlhawSi473M/BES+kS776bdMkiE8+ZPxsPgVKYCwukCoRhVCSxISurvex
         A7iSvHfVwDN2GiSqGiT9yjDqlyZA2/+LudkgzniJ+VXJGV9yopKb1z25VSqjWwaVITCF
         PsDvCLXLEtpAS9GD0OmXlcCpQQfY8VuWL2IItQXg5nUvWnGII7IDBXNXp6jIWKJxw496
         f+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779158834; x=1779763634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQP6saiiXAQJTpPARLrRFM0Ns2dwyXRFEWBvIe0BZcE=;
        b=JXkCbO5oWuctdFsupPG/+A6hfmmrj5cuUjbm4vFsynEmr3pLMaDOxjfMNB/G8DTOKz
         /KnE0jJK8WeIhSaBSNLyIFdw3nxLz0B51dhIIjVDOFbMp39ILQad/e5uFl3bXyajU3pu
         D+SBfhy+06dO1bJNq1iKp0lNi+nAJi9kKfQ2xYDpTTH4bOFn1Eb3uO0NA9gajSWVdq64
         jo+6VTFKb6HpeRVPoWRsiwtlpAEU9N03VaVH0wgB+WRQ61ATNJdZ/roNpUltDFSM+o0a
         alkqppBR0EssUBUhIvLATmxJd1/EUfM9DGIaq7JNYZ2qlpBw5eCZioqeqj8EcQjE5nTh
         Kd8A==
X-Forwarded-Encrypted: i=1; AFNElJ8GAZEGYJNSTz5mppHWRrI25/l9AyUeffpiCKnrGWFuOnZYSY3Q7pjd2ur2Oe9Y/XiAS8OADB8xCy3ZVGk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyBXd+qhdE/DK2QLue2fsPpYL1JWpTaf8DNjBbkO4y/bYWJ7B84
	0joVHoqIlI04XtNuac5LHO5kElRvb3ZaAsHYSV6Krdn0lrih4jKrA1G9EOFi0HgagJ5oiaoieDt
	tKVOJQuj/K4WjYiwomL3wqOaArve2tuk=
X-Gm-Gg: Acq92OE9wULvgZ1OAD4Q9MXSkz+/KL4SEmRfbt4H3+wRdjQi9f8bLKvx54zzUfbGDNH
	Zsg1agca6HnBdLB0ciiTdCFz1tNOv7j3eOOiRFF4EjR35DXtT3S/q6eFbQJG5uweswZLnzLmFMJ
	dwui5EcOevxtIshUqE60ppN4AkPbeO35hLLo7qUBU1E+ZjYVoyeSzFF/fpAObkNNaUUgcbuSIdr
	rVdM1F8Ud8Gy8VRmiZMX4P8y/RyOpqSELizRmsfDMGa7uK47e0l6+fFoQtnd111InKlLScGCMll
	xw9W2tIaRK/Adak9LW4=
X-Received: by 2002:a2e:bc20:0:b0:38a:45d6:c246 with SMTP id
 38308e7fff4ca-39561c36019mr54660351fa.8.1779158833823; Mon, 18 May 2026
 19:47:13 -0700 (PDT)
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
 <20260424-ventura2_initial_dts-v4-2-806b00ea4314@gmail.com>
 <39b9a80fe4f49d72cefb8d3f8f1bb3776b9c4226.camel@codeconstruct.com.au> <CAF7HswPn65kvTAyYDj_o=nSn3YhQhKqBaak7nt11x-8bZ7M6vg@mail.gmail.com>
In-Reply-To: <CAF7HswPn65kvTAyYDj_o=nSn3YhQhKqBaak7nt11x-8bZ7M6vg@mail.gmail.com>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 19 May 2026 10:48:19 +0800
X-Gm-Features: AVHnY4KpR8_SQLN5ycWULCDf5UkEJu74K_EZDZzPg05Smr9riqQITU4BSYjRqBM
Message-ID: <CAF7HswNLqxZA2-2Mh49zk+mV=oTbyw4UrmJTVe3HESZqCL9rGg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, May 19, 2026 at 10:38=E2=80=AFAM Kyle Hsieh <kylehsieh1995@gmail.co=
m> wrote:
>
> On Mon, May 18, 2026 at 3:18=E2=80=AFPM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >
> > Hi Kyle,
> >
> > Firstly, are you trying to represent multiple revisions of the hardware
> > design in this devicetree? I'm curious due to the 'legacy' labels
> > below.
> >
> In the previous Ventura hardware generation, these pins were
>  implemented as a set of direct, native physical GPIO signals. In the V2
>  design, we introduced alternative interfaces and routed these paths
> through the CPLD to convert them into GPIOs before reaching the
> BMC.
>
> We chose to retain the 'legacy' prefix to maintain backward
> compatibility with our existing userspace software stack and scripts
> that transitioned from the previous Ventura platform. Altering these
> labels now would break compatibility with applications that rely on
> these specific naming conventions. I will add comments in the DTS to
> clarify this context.
Please allow me to add a crucial hardware detail to my previous
 explanation regarding the 'legacy' prefix.
I missed mentioning the most important point: on this specific ventura2
board, we actually have two distinct sets of IO expanders physically
present at the same time to support both new and older tray interfaces.

The new design utilizes the PCA9698 at gpio@40, which is already
labeled as prsnt_io_expander0. However, to maintain hardware
backward compatibility with older trays, the board also physically
retains the previous PCA9555 expanders at gpio@11.

Therefore, since the prsnt_io_expander0 label is already occupied, the
legacy_ prefix is strictly necessary to avoid
devicetree label collisions and to explicitly differentiate the two
physical hardware paths.

I will make sure this hardware context is clearly documented in the
DTS comments in the v5 patch.

> > On Fri, 2026-04-24 at 17:30 +0800, Kyle Hsieh wrote:
> > > Add linux device tree entry related to the Meta(Facebook) rmc-node.
> > > The system use an AT2600 BMC.
> > > This node is named "ventura2".
> > >
> > > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/aspeed/Makefile                  |    1 +
> > >  .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 2925 ++++++++++=
++++++++++
> > >  2 files changed, 2926 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/as=
peed/Makefile
> > > index 9adf9278dc94..6b96997629d4 100644
> > > --- a/arch/arm/boot/dts/aspeed/Makefile
> > > +++ b/arch/arm/boot/dts/aspeed/Makefile
> > > @@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> > >       aspeed-bmc-facebook-minipack.dtb \
> > >       aspeed-bmc-facebook-santabarbara.dtb \
> > >       aspeed-bmc-facebook-tiogapass.dtb \
> > > +     aspeed-bmc-facebook-ventura2.dtb \
> > >       aspeed-bmc-facebook-wedge40.dtb \
> > >       aspeed-bmc-facebook-wedge100.dtb \
> > >       aspeed-bmc-facebook-wedge400-data64.dtb \
> > > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dt=
s b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> > > new file mode 100644
> > > index 000000000000..8d4ddb473862
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> > > @@ -0,0 +1,2925 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +// Copyright (c) 2023 Facebook Inc.
> > > +/dts-v1/;
> > > +
> > > +#include "aspeed-g6.dtsi"
> > > +#include <dt-bindings/i2c/i2c.h>
> > > +#include <dt-bindings/gpio/aspeed-gpio.h>
> > > +
> > > +/ {
> > > +     model =3D "Facebook Ventura2 RMC";
> > > +     compatible =3D "facebook,ventura2-rmc", "aspeed,ast2600";
> > > +     aliases {
> > > +             serial2 =3D &uart3;
> > > +             serial4 =3D &uart5;
> > > +
> > > +             /*
> > > +              * i2c switch 0-0077, pca9548, 8 child channels assigne=
d
> > > +              * with bus number 16-23.
> > > +              */
> > > +             i2c16 =3D &i2c0mux0ch0;
> > > +             i2c17 =3D &i2c0mux0ch1;
> > > +             i2c18 =3D &i2c0mux0ch2;
> > > +             i2c19 =3D &i2c0mux0ch3;
> > > +             i2c20 =3D &i2c0mux0ch4;
> > > +             i2c21 =3D &i2c0mux0ch5;
> > > +             i2c22 =3D &i2c0mux0ch6;
> > > +             i2c23 =3D &i2c0mux0ch7;
> > > +
> > > +             /*
> > > +              * i2c switch 1-0077, pca9548, 8 child channels assigne=
d
> > > +              * with bus number 24-31.
> > > +              */
> > > +             i2c24 =3D &i2c1mux0ch0;
> > > +             i2c25 =3D &i2c1mux0ch1;
> > > +             i2c26 =3D &i2c1mux0ch2;
> > > +             i2c27 =3D &i2c1mux0ch3;
> > > +             i2c28 =3D &i2c1mux0ch4;
> > > +             i2c29 =3D &i2c1mux0ch5;
> > > +             i2c30 =3D &i2c1mux0ch6;
> > > +             i2c31 =3D &i2c1mux0ch7;
> > > +
> > > +             /*
> > > +              * i2c switch 4-0077, pca9548, 8 child channels assigne=
d
> > > +              * with bus number 32-39.
> > > +              */
> > > +             i2c32 =3D &i2c4mux0ch0;
> > > +             i2c33 =3D &i2c4mux0ch1;
> > > +             i2c34 =3D &i2c4mux0ch2;
> > > +             i2c35 =3D &i2c4mux0ch3;
> > > +             i2c36 =3D &i2c4mux0ch4;
> > > +             i2c37 =3D &i2c4mux0ch5;
> > > +             i2c38 =3D &i2c4mux0ch6;
> > > +             i2c39 =3D &i2c4mux0ch7;
> > > +
> > > +             /*
> > > +              * i2c switch 5-0077, pca9548, 8 child channels assigne=
d
> > > +              * with bus number 40-47.
> > > +              */
> > > +             i2c40 =3D &i2c5mux0ch0;
> > > +             i2c41 =3D &i2c5mux0ch1;
> > > +             i2c42 =3D &i2c5mux0ch2;
> > > +             i2c43 =3D &i2c5mux0ch3;
> > > +             i2c44 =3D &i2c5mux0ch4;
> > > +             i2c45 =3D &i2c5mux0ch5;
> > > +             i2c46 =3D &i2c5mux0ch6;
> > > +             i2c47 =3D &i2c5mux0ch7;
> > > +
> > > +             /*
> > > +              * i2c switch 8-0077, pca9548, 8 child channels assigne=
d
> > > +              * with bus number 48-55.
> > > +              */
> > > +             i2c48 =3D &i2c8mux0ch0;
> > > +             i2c49 =3D &i2c8mux0ch1;
> > > +             i2c50 =3D &i2c8mux0ch2;
> > > +             i2c51 =3D &i2c8mux0ch3;
> > > +             i2c52 =3D &i2c8mux0ch4;
> > > +             i2c53 =3D &i2c8mux0ch5;
> > > +             i2c54 =3D &i2c8mux0ch6;
> > > +             i2c55 =3D &i2c8mux0ch7;
> > > +
> > > +             /*
> > > +              * i2c switch 11-0077, pca9548, 8 child channels assign=
ed
> > > +              * with bus number 56-63.
> > > +              */
> > > +             i2c56 =3D &i2c11mux0ch0;
> > > +             i2c57 =3D &i2c11mux0ch1;
> > > +             i2c58 =3D &i2c11mux0ch2;
> > > +             i2c59 =3D &i2c11mux0ch3;
> > > +             i2c60 =3D &i2c11mux0ch4;
> > > +             i2c61 =3D &i2c11mux0ch5;
> > > +             i2c62 =3D &i2c11mux0ch6;
> > > +             i2c63 =3D &i2c11mux0ch7;
> > > +
> > > +             /*
> > > +              * i2c switch 13-0077, pca9548, 8 child channels assign=
ed
> > > +              * with bus number 64-71.
> > > +              */
> > > +             i2c64 =3D &i2c13mux0ch0;
> > > +             i2c65 =3D &i2c13mux0ch1;
> > > +             i2c66 =3D &i2c13mux0ch2;
> > > +             i2c67 =3D &i2c13mux0ch3;
> > > +             i2c68 =3D &i2c13mux0ch4;
> > > +             i2c69 =3D &i2c13mux0ch5;
> > > +             i2c70 =3D &i2c13mux0ch6;
> > > +             i2c71 =3D &i2c13mux0ch7;
> > > +
> > > +             /*
> > > +              * i2c switch 15-0077, pca9548, 8 child channels assign=
ed
> > > +              * with bus number 72-79.
> > > +              */
> > > +             i2c72 =3D &i2c15mux0ch0;
> > > +             i2c73 =3D &i2c15mux0ch1;
> > > +             i2c74 =3D &i2c15mux0ch2;
> > > +             i2c75 =3D &i2c15mux0ch3;
> > > +             i2c76 =3D &i2c15mux0ch4;
> > > +             i2c77 =3D &i2c15mux0ch5;
> > > +             i2c78 =3D &i2c15mux0ch6;
> > > +             i2c79 =3D &i2c15mux0ch7;
> >
> > Can you please add comments justifying why all of these aliases are
> > necessary given a number of them are for busses with no devices
> > described under them?
> These I2C aliases are pre-allocated because these empty channels are
>  strictly reserved for future hardware feature expansions, which will
> interface with add-on boards. I will add clear comments in the code to
> justify their necessity in the next patch.
> >
> > > +     };
> > > +
> > > +     chosen {
> > > +             stdout-path =3D "serial4:57600n8";
> > > +     };
> > > +
> > > +     fan_leds {
> > > +             compatible =3D "gpio-leds";
> > > +
> > > +             led-0 {
> > > +                     label =3D "fcb0fan0_ledd1_blue";
> >
> > Given the labels are exposed to userspace and is something applications
> > likely consume, is the double 'd' in led intentional?
> Yes, the double 'd' in "ledd1" is intentional. It aligns with our hardwar=
e
>  schematic design naming convention, where these specific onboard
> indicators are designated as LEDD1, LEDD2, etc.
> >
> > > +                     default-state =3D "off";
> > > +                     gpios =3D <&fan_io_expander0 0 GPIO_ACTIVE_LOW>=
;
> > > +             };
> > > +
> > > +             led-1 {
> > > +                     label =3D "fcb0fan1_ledd2_blue";
> > > +                     default-state =3D "off";
> > > +                     gpios =3D <&fan_io_expander0 1 GPIO_ACTIVE_LOW>=
;
> > > +             };
> > > +
> > > +             led-2 {
> > > +                     label =3D "fcb0fan2_ledd3_blue";
> > > +                     default-state =3D "off";
> > > +                     gpios =3D <&fan_io_expander1 0 GPIO_ACTIVE_LOW>=
;
> > > +             };
> > > +
> > > +             led-3 {
> > > +                     label =3D "fcb0fan3_ledd4_blue";
> > > +                     default-state =3D "off";
> > > +                     gpios =3D <&fan_io_expander1 1 GPIO_ACTIVE_LOW>=
;
> > > +             };
> > > +
> > > +             led-4 {
> > > +                     label =3D "fcb0fan0_ledd1_amber";
> > > +                     default-state =3D "off";
> > > +                     gpios =3D <&fan_io_expander0 4 GPIO_ACTIVE_LOW>=
;
> > > +             };
> > > +
> > > +             led-5 {
> > > +                     label =3D "fcb0fan1_ledd2_amber";
> > > +                     default-state =3D "off";
> > > +                     gpios =3D <&fan_io_expander0 5 GPIO_ACTIVE_LOW>=
;
> > > +             };
> > > +
> > > +             led-6 {
> > > +                     label =3D "fcb0fan2_ledd3_amber";
> > > +                     default-state =3D "off";
> > > +                     gpios =3D <&fan_io_expander1 4 GPIO_ACTIVE_LOW>=
;
> > > +             };
> > > +
> > > +             led-7 {
> > > +                     label =3D "fcb0fan3_ledd4_amber";
> > > +                     default-state =3D "off";
> > > +                     gpios =3D <&fan_io_expander1 5 GPIO_ACTIVE_LOW>=
;
> > > +             };
> > > +     };
> > > +
> >
> > ...
> >
> > > +
> > > +&fmc {
> > > +     status =3D "okay";
> > > +     flash@0 {
> > > +             status =3D "okay";
> > > +             m25p,fast-read;
> > > +             label =3D "bmc";
> > > +             spi-max-frequency =3D <50000000>;
> > > +             #include "openbmc-flash-layout-128.dtsi"
> > > +     };
> > > +     flash@1 {
> > > +             status =3D "okay";
> > > +             m25p,fast-read;
> > > +             label =3D "alt-bmc";
> > > +             spi-max-frequency =3D <50000000>;
> >
> > Perhaps include the alternate flash layout dtsi here?
> The `flash@1` (`alt-bmc`) node is intentionally left unpartitioned
>  without the layout DTSI.
>
> In our dual-flash design, `flash@1` serves as the secondary/backup
> flash chip. Keeping it without sub-partitions allows the kernel and
> userspace tools to treat this flash as a single, contiguous raw MTD
> device. This is required by our firmware update mechanism, which
> flashes a single, full-size composite image directly to the entire
> backup flash.
>
> This structure follows the existing upstream pattern established in
> `aspeed-bmc-facebook-yosemite5.dts`.
> >
> > > +     };
> > > +};
> > > +
> > > +&peci0 {
> >
> > Can you please order the nodes alphabetically. P is not between F and
> > G.
> I will ensure all nodes are strictly sorted in alphabetical order in
> the next version.
> >
> > > +     status =3D "okay";
> > > +};
> > > +
> > >
> >
> > ...
> >
> > > +
> > > +&i2c10 {
> > > +     status =3D "okay";
> > > +
> > > +     legacy_prsnt_io_expander0: gpio@11 {
> >
> > Why 'legacy'?
> >
> > > +             compatible =3D "nxp,pca9555";
> > > +             reg =3D <0x11>;
> > > +             gpio-controller;
> > > +             #gpio-cells =3D <2>;
> > > +             interrupt-parent =3D <&sgpiom0>;
> > > +             interrupts =3D <40 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +             gpio-line-names =3D
> > > +                     "TRAY_PRSNT1_N_BUF_R", "TRAY_PRSNT2_N_BUF_R",
> > > +                     "TRAY_PRSNT3_N_BUF_R", "TRAY_PRSNT4_N_BUF_R",
> > > +                     "TRAY_PRSNT5_N_BUF_R", "TRAY_PRSNT6_N_BUF_R",
> > > +                     "TRAY_PRSNT7_N_BUF_R", "TRAY_PRSNT8_N_BUF_R",
> > > +                     "TRAY_PRSNT9_N_BUF_R", "TRAY_PRSNT10_N_BUF_R",
> > > +                     "TRAY_PRSNT11_N_BUF_R", "TRAY_PRSNT12_N_BUF_R",
> > > +                     "TRAY_PRSNT13_N_BUF_R", "TRAY_PRSNT14_N_BUF_R",
> > > +                     "TRAY_PRSNT15_N_BUF_R", "TRAY_PRSNT16_N_BUF_R";
> > > +     };
> > > +
> > > +     legacy_prsnt_io_expander1: gpio@12 {
> > > +             compatible =3D "nxp,pca9555";
> > > +             reg =3D <0x12>;
> > > +             gpio-controller;
> > > +             #gpio-cells =3D <2>;
> > > +             interrupt-parent =3D <&sgpiom0>;
> > > +             interrupts =3D <40 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +             gpio-line-names =3D
> > > +                     "TRAY_PRSNT17_N_BUF_R", "TRAY_PRSNT18_N_BUF_R",
> > > +                     "TRAY_PRSNT19_N_BUF_R", "TRAY_PRSNT20_N_BUF_R",
> > > +                     "TRAY_PRSNT21_N_BUF_R", "TRAY_PRSNT22_N_BUF_R",
> > > +                     "TRAY_PRSNT23_N_BUF_R", "TRAY_PRSNT24_N_BUF_R",
> > > +                     "TRAY_PRSNT25_N_BUF_R", "TRAY_PRSNT26_N_BUF_R",
> > > +                     "TRAY_PRSNT27_N_BUF_R", "TRAY_PRSNT28_N_BUF_R",
> > > +                     "TRAY_PRSNT29_N_BUF_R", "TRAY_PRSNT30_N_BUF_R",
> > > +                     "TRAY_PRSNT31_N_BUF_R", "TRAY_PRSNT32_N_BUF_R";
> > > +     };
> > > +
> > > +     legacy_prsnt_io_expander2: gpio@13 {
> > > +             compatible =3D "nxp,pca9555";
> > > +             reg =3D <0x13>;
> > > +             gpio-controller;
> > > +             #gpio-cells =3D <2>;
> > > +             interrupt-parent =3D <&sgpiom0>;
> > > +             interrupts =3D <40 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +             gpio-line-names =3D
> > > +                     "TRAY_PRSNT33_N_BUF_R", "TRAY_PRSNT34_N_BUF_R",
> > > +                     "TRAY_PRSNT35_N_BUF_R", "TRAY_PRSNT36_N_BUF_R",
> > > +                     "TRAY_PRSNT37_N_BUF_R", "TRAY_PRSNT38_N_BUF_R",
> > > +                     "TRAY_PRSNT39_N_BUF_R", "TRAY_PRSNT40_N_BUF_R",
> > > +                     "", "",
> > > +                     "", "",
> > > +                     "", "",
> > > +                     "", "";
> > > +     };
> > > +
> > > +     power-monitor@14 {
> > > +             compatible =3D "infineon,xdp710";
> > > +             reg =3D <0x14>;
> > > +     };
> > > +
> > > +     legacy_pwrgd_io_expander1: gpio@15 {
> > > +             compatible =3D "nxp,pca9555";
> > > +             reg =3D <0x15>;
> > > +             gpio-controller;
> > > +             #gpio-cells =3D <2>;
> > > +             interrupt-parent =3D <&sgpiom0>;
> > > +             interrupts =3D <42 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +             gpio-line-names =3D
> > > +                     "TRAY_PWRGD17_N_BUF_R", "TRAY_PWRGD18_N_BUF_R",
> > > +                     "TRAY_PWRGD19_N_BUF_R", "TRAY_PWRGD20_N_BUF_R",
> > > +                     "TRAY_PWRGD21_N_BUF_R", "TRAY_PWRGD22_N_BUF_R",
> > > +                     "TRAY_PWRGD23_N_BUF_R", "TRAY_PWRGD24_N_BUF_R",
> > > +                     "TRAY_PWRGD25_N_BUF_R", "TRAY_PWRGD26_N_BUF_R",
> > > +                     "TRAY_PWRGD27_N_BUF_R", "TRAY_PWRGD28_N_BUF_R",
> > > +                     "TRAY_PWRGD29_N_BUF_R", "TRAY_PWRGD30_N_BUF_R",
> > > +                     "TRAY_PWRGD31_N_BUF_R", "TRAY_PWRGD32_N_BUF_R";
> > > +     };
> > > +
> > > +     legacy_pwrgd_io_expander2: gpio@16 {
> > > +             compatible =3D "nxp,pca9555";
> > > +             reg =3D <0x16>;
> > > +             gpio-controller;
> > > +             #gpio-cells =3D <2>;
> > > +             interrupt-parent =3D <&sgpiom0>;
> > > +             interrupts =3D <42 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +             gpio-line-names =3D
> > > +                     "TRAY_PWRGD33_N_BUF_R", "TRAY_PWRGD34_N_BUF_R",
> > > +                     "TRAY_PWRGD35_N_BUF_R", "TRAY_PWRGD36_N_BUF_R",
> > > +                     "TRAY_PWRGD37_N_BUF_R", "TRAY_PWRGD38_N_BUF_R",
> > > +                     "TRAY_PWRGD39_N_BUF_R", "TRAY_PWRGD40_N_BUF_R",
> > > +                     "", "",
> > > +                     "", "",
> > > +                     "", "",
> > > +                     "", "";
> > > +     };
> > > +
> > > +     legacy_leak_io_expander0: gpio@17 {
> > > +             compatible =3D "nxp,pca9555";
> > > +             reg =3D <0x17>;
> > > +             gpio-controller;
> > > +             #gpio-cells =3D <2>;
> > > +             interrupt-parent =3D <&sgpiom0>;
> > > +             interrupts =3D <46 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +             gpio-line-names =3D
> > > +                     "TRAY_LEAK_DETECT1_N_BUF_R", "TRAY_LEAK_DETECT2=
_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT3_N_BUF_R", "TRAY_LEAK_DETECT4=
_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT5_N_BUF_R", "TRAY_LEAK_DETECT6=
_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT7_N_BUF_R", "TRAY_LEAK_DETECT8=
_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT9_N_BUF_R", "TRAY_LEAK_DETECT1=
0_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT11_N_BUF_R", "TRAY_LEAK_DETECT=
12_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT13_N_BUF_R", "TRAY_LEAK_DETECT=
14_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT15_N_BUF_R", "TRAY_LEAK_DETECT=
16_N_BUF_R";
> > > +     };
> > > +
> > > +     legacy_leak_io_expander1: gpio@18 {
> > > +             compatible =3D "nxp,pca9555";
> > > +             reg =3D <0x18>;
> > > +             gpio-controller;
> > > +             #gpio-cells =3D <2>;
> > > +             interrupt-parent =3D <&sgpiom0>;
> > > +             interrupts =3D <46 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +             gpio-line-names =3D
> > > +                     "TRAY_LEAK_DETECT17_N_BUF_R", "TRAY_LEAK_DETECT=
18_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT19_N_BUF_R", "TRAY_LEAK_DETECT=
20_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT21_N_BUF_R", "TRAY_LEAK_DETECT=
22_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT23_N_BUF_R", "TRAY_LEAK_DETECT=
24_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT25_N_BUF_R", "TRAY_LEAK_DETECT=
26_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT27_N_BUF_R", "TRAY_LEAK_DETECT=
28_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT29_N_BUF_R", "TRAY_LEAK_DETECT=
30_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT31_N_BUF_R", "TRAY_LEAK_DETECT=
32_N_BUF_R";
> > > +     };
> > > +
> > > +     legacy_leak_io_expander2: gpio@19 {
> > > +             compatible =3D "nxp,pca9555";
> > > +             reg =3D <0x19>;
> > > +             gpio-controller;
> > > +             #gpio-cells =3D <2>;
> > > +             interrupt-parent =3D <&sgpiom0>;
> > > +             interrupts =3D <46 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +             gpio-line-names =3D
> > > +                     "TRAY_LEAK_DETECT33_N_BUF_R", "TRAY_LEAK_DETECT=
34_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT35_N_BUF_R", "TRAY_LEAK_DETECT=
36_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT37_N_BUF_R", "TRAY_LEAK_DETECT=
38_N_BUF_R",
> > > +                     "TRAY_LEAK_DETECT39_N_BUF_R", "TRAY_LEAK_DETECT=
40_N_BUF_R",
> > > +                     "", "",
> > > +                     "", "",
> > > +                     "", "",
> > > +                     "", "";
> > > +     };
> > > +
> > > +     legacy_small_leak_io_expander0: gpio@1a {
> > > +             compatible =3D "nxp,pca9555";
> > > +             reg =3D <0x1a>;
> > > +             gpio-controller;
> > > +             #gpio-cells =3D <2>;
> > > +             interrupt-parent =3D <&sgpiom0>;
> > > +             interrupts =3D <44 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +             gpio-line-names =3D
> > > +                     "TRAY_SMALL_LEAK1_N_BUF_R", "TRAY_SMALL_LEAK2_N=
_BUF_R",
> > > +                     "TRAY_SMALL_LEAK3_N_BUF_R", "TRAY_SMALL_LEAK4_N=
_BUF_R",
> > > +                     "TRAY_SMALL_LEAK5_N_BUF_R", "TRAY_SMALL_LEAK6_N=
_BUF_R",
> > > +                     "TRAY_SMALL_LEAK7_N_BUF_R", "TRAY_SMALL_LEAK8_N=
_BUF_R",
> > > +                     "TRAY_SMALL_LEAK9_N_BUF_R", "TRAY_SMALL_LEAK10_=
N_BUF_R",
> > > +                     "TRAY_SMALL_LEAK11_N_BUF_R", "TRAY_SMALL_LEAK12=
_N_BUF_R",
> > > +                     "TRAY_SMALL_LEAK13_N_BUF_R", "TRAY_SMALL_LEAK14=
_N_BUF_R",
> > > +                     "TRAY_SMALL_LEAK15_N_BUF_R", "TRAY_SMALL_LEAK16=
_N_BUF_R";
> > > +     };
> > > +
> > > +     legacy_small_leak_io_expander1: gpio@1b {
> > > +             compatible =3D "nxp,pca9555";
> > > +             reg =3D <0x1b>;
> > > +             gpio-controller;
> > > +             #gpio-cells =3D <2>;
> > > +             interrupt-parent =3D <&sgpiom0>;
> > > +             interrupts =3D <44 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +             gpio-line-names =3D
> > > +                     "TRAY_SMALL_LEAK17_N_BUF_R", "TRAY_SMALL_LEAK18=
_N_BUF_R",
> > > +                     "TRAY_SMALL_LEAK19_N_BUF_R", "TRAY_SMALL_LEAK20=
_N_BUF_R",
> > > +                     "TRAY_SMALL_LEAK21_N_BUF_R", "TRAY_SMALL_LEAK22=
_N_BUF_R",
> > > +                     "TRAY_SMALL_LEAK23_N_BUF_R", "TRAY_SMALL_LEAK24=
_N_BUF_R",
> > > +                     "TRAY_SMALL_LEAK25_N_BUF_R", "TRAY_SMALL_LEAK26=
_N_BUF_R",
> > > +                     "TRAY_SMALL_LEAK27_N_BUF_R", "TRAY_SMALL_LEAK28=
_N_BUF_R",
> > > +                     "TRAY_SMALL_LEAK29_N_BUF_R", "TRAY_SMALL_LEAK30=
_N_BUF_R",
> > > +                     "TRAY_SMALL_LEAK31_N_BUF_R", "TRAY_SMALL_LEAK32=
_N_BUF_R";
> > > +     };
> > > +
> > > +     legacy_small_leak_io_expander2: gpio@1c {
> > > +             compatible =3D "nxp,pca9555";
> > > +             reg =3D <0x1c>;
> > > +             gpio-controller;
> > > +             #gpio-cells =3D <2>;
> > > +             interrupt-parent =3D <&sgpiom0>;
> > > +             interrupts =3D <44 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +             gpio-line-names =3D
> > > +                     "TRAY_SMALL_LEAK33_N_BUF_R", "TRAY_SMALL_LEAK34=
_N_BUF_R",
> > > +                     "TRAY_SMALL_LEAK35_N_BUF_R", "TRAY_SMALL_LEAK36=
_N_BUF_R",
> > > +                     "TRAY_SMALL_LEAK37_N_BUF_R", "TRAY_SMALL_LEAK38=
_N_BUF_R",
> > > +                     "TRAY_SMALL_LEAK39_N_BUF_R", "TRAY_SMALL_LEAK40=
_N_BUF_R",
> > > +                     "", "",
> > > +                     "", "",
> > > +                     "", "",
> > > +                     "", "";
> > > +     };
> > > +
> > > +     legacy_pwrgd_io_expander0: gpio@28 {
> > > +             compatible =3D "nxp,pca9555";
> > > +             reg =3D <0x28>;
> > > +             gpio-controller;
> > > +             #gpio-cells =3D <2>;
> > > +             interrupt-parent =3D <&sgpiom0>;
> > > +             interrupts =3D <42 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +             gpio-line-names =3D
> > > +                     "TRAY_PWRGD1_N_BUF_R", "TRAY_PWRGD2_N_BUF_R",
> > > +                     "TRAY_PWRGD3_N_BUF_R", "TRAY_PWRGD4_N_BUF_R",
> > > +                     "TRAY_PWRGD5_N_BUF_R", "TRAY_PWRGD6_N_BUF_R",
> > > +                     "TRAY_PWRGD7_N_BUF_R", "TRAY_PWRGD8_N_BUF_R",
> > > +                     "TRAY_PWRGD9_N_BUF_R", "TRAY_PWRGD10_N_BUF_R",
> > > +                     "TRAY_PWRGD11_N_BUF_R", "TRAY_PWRGD12_N_BUF_R",
> > > +                     "TRAY_PWRGD13_N_BUF_R", "TRAY_PWRGD14_N_BUF_R",
> > > +                     "TRAY_PWRGD15_N_BUF_R", "TRAY_PWRGD16_N_BUF_R";
> > > +     };
> > > +
> >
> > ...
> >
> > > +
> > > +&mdio0 {
> > > +     status =3D "okay";
> > > +};
> > > +
> > > +&peci0 {
> > > +     status =3D "okay";
> > > +};
> >
> > Ah, so the earlier peci node is redundant. Can you please remove it?
> Got it. I will remove the redundant peci0 node and ensure all nodes
>  are strictly sorted in alphabetical order in the next version.
> >
> > Andrew

