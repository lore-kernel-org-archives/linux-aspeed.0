Return-Path: <linux-aspeed+bounces-1926-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF160C87FCB
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 23:52:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4by6YN4DHcz3bgw;
	Thu,  7 Aug 2025 09:52:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::131"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754445573;
	cv=none; b=ReZ5dmAsnorykWqNzF+bBX/aZVG9e86FDNu4EI2NGpZ86upLbfqnilhWtIVEOTNpfuqoc3aPNoB8l1JvVil0PRYciYwX7uryESxwbK1nwxSjE7s9cwzRP1HwO5nTUDBxlHDFUfj2DPnicbTxpERTx4ksunZGwHr2+x3KUcmVwIZq3GnMLMrF5GnfYnkupeIluOPaoL554ebz3kcWYgBG2Ybne1olJBDx9CT9KYx32qdcvwL0imP4ZeD9SWSMmlziSu9gRM3OwYjjZdOwBxnXst+Q/5UzSGig/5PHirGq0BjRNgceHD1nPLqlapivhq31zCT3fLamofzg7JkJtNxJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754445573; c=relaxed/relaxed;
	bh=T/cWf6KdxAQn9lw1SOs9M4TTY3PmTHnYG6Qu4JYHLSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lt+y+bY4MgIBKrpbfOeaQ5mbMQaEtpuvle1wfANcjsEDoz2YLrMDvckBdZnfftAFk67B61JJVYlqPfPNLYsdJ75sqnv4l+nU57qRtmVnDGfdVjwCiFpuAImmIKtgk6lWQAp+9oIA0JLqCzt6DroLrRh8yxVzayeQrGnkKJIl6aHNwoRT6Ht7i2BZarHyawCdEp3RC7lsAocH9bSeZ16EsXblOw5ul+Hmvl3uw4+2pOy7oG9QVCYaNPm7NostFBzzyu1gvzw3Ax/drDvo8wLoJN/UZ8Q4xUYrBxSCO6/YxXjDYD56d9fz0vy8gA9mo9By/LyCLO8mTDAEOgV3qcUq0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=jB9ZSpAf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::131; helo=mail-il1-x131.google.com; envelope-from=elbadrym@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=jB9ZSpAf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::131; helo=mail-il1-x131.google.com; envelope-from=elbadrym@google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxYPt6KZsz30WY
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Aug 2025 11:59:30 +1000 (AEST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3e40df3c68fso86645ab.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 05 Aug 2025 18:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754445567; x=1755050367; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/cWf6KdxAQn9lw1SOs9M4TTY3PmTHnYG6Qu4JYHLSw=;
        b=jB9ZSpAfAp4PBUkbkycPS4g3onkwJk6a2E/HdJKL4ny8JDGJoP+deKgEQpna0D7DSG
         QPcAsDM8hsQqrd0J0O1FmssrJZqg9xijyCXXmpqkNdyRRtYHBfNGxtzmtIdWWImuOvIP
         Hp8V65KgU0e8QcUmPOuKkuEa7SfNtRRe4bGZR9MG6ULGhq/RV4AVmYqIm+YGrKcywA57
         gmWPR3MqcJBOf/4KiyFU29WZgzAja1XbYmh27UeersfRhswcq5nqpJQobx/cHfpA1Y1s
         WzBkZ67EoDnMabf2uZQ7zOF4YAFmqD7jGi6e7iY3cBfzN07+VP5t31XqBPzXCLDxZvht
         +8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754445567; x=1755050367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/cWf6KdxAQn9lw1SOs9M4TTY3PmTHnYG6Qu4JYHLSw=;
        b=krkNXWxmvSnwOU63sKCv9lSp9ySniKCZ8m9YqLz+7QTs6yWrduM4MUD7/UVS6Uc3jy
         ire3jPwIhKB9qN+Amkepz1Y1H7i20dvK8riC2SA9cUUm4XSXxN2ZIRie7RvBClerYq2p
         iGhfjQyk0R1761kbLyizyGlEsErBert7B8wFkp0prJ+orcu3JxQ+AGW50QJNnxb4nwGQ
         MyUTlnrXItYdriPe5aGRbRvcOU0UliDdXidzjJNiqMfjPchUDHXHy20iPHp6TRKTG0EX
         dLVWGGa6gxexokpvogw39n8TzrRVqLDfIMxlzSS6Whme2b6jWV09rkYJPJiMXEfxlZv+
         sgXg==
X-Forwarded-Encrypted: i=1; AJvYcCVPCKj/2tDPj4edQCwnbvUd3vYyTP0XMLF+rAjdE6L8AHalgI3Rk5D0lS+/CtXUcAgkTNayztW+hp49ykM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YygruruTfGYUIe9vl2COddWJ0uIs7e9yG7EBYMTChigfDm0Z8AH
	M44BoCqoQhVUwX6wUfvh9wF3Q56lTJaq9ujMs2mWvlmtrNPaRaIj/m8bD2RMbZk7Ms2la8ytkp+
	TZuAov9lgYeuEbbXGNV4ZGpvcWVnYx33sM5goOtFZ
X-Gm-Gg: ASbGncs2o4SdKiGZnAZbFggnX0vgunsvSbWQ6RrI0z+dxgmb4U/IkP1C1TWvX9lL7dx
	H/AGs9F8C4Z5nPjMczSycb/nBATQ628Km2h2iD+gzJmtGuDDSRK+JN3QYJP/XF0Rt25GGluxIEy
	yLmj8YaIbIvLOACb78WiqAnPwlVGbVfMgCrKMI9IYqtptR8+zWYUmSm6jY7JOLYwX7N9IQlgkvx
	DWBGw21aaGuEfeq
X-Google-Smtp-Source: AGHT+IEFFm1rxH12mN2j0uzpjBvJNtce+Z+fcJeIHOy73lsbBCMLI9ZBUJInbqOT4VOdCHGxU/sW+TNQjDPx7x7B458=
X-Received: by 2002:a05:6e02:2581:b0:3e2:9b62:faba with SMTP id
 e9e14a558f8ab-3e51b6fff5dmr1548945ab.7.1754445566287; Tue, 05 Aug 2025
 18:59:26 -0700 (PDT)
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
References: <20250708052909.4145983-1-ryan_chen@aspeedtech.com>
 <20250708052909.4145983-4-ryan_chen@aspeedtech.com> <OS8PR06MB7541E7FCB367AE610EBBE121F249A@OS8PR06MB7541.apcprd06.prod.outlook.com>
In-Reply-To: <OS8PR06MB7541E7FCB367AE610EBBE121F249A@OS8PR06MB7541.apcprd06.prod.outlook.com>
From: Mo Elbadry <elbadrym@google.com>
Date: Tue, 5 Aug 2025 18:59:14 -0700
X-Gm-Features: Ac12FXyjxsTIOGKMqPvxVKe5oatl7QQ96y7fbLDNQmC8DbPWxMzGLkxap3Ceajs
Message-ID: <CAOO6b=tO5mpJR_9GWv91T1ooZ9WHvWOe2ExWxz6CeWcXSMOgCg@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rom Lemarchand <romlem@google.com>, 
	William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>, 
	"wthai@nvidia.com" <wthai@nvidia.com>, "leohu@nvidia.com" <leohu@nvidia.com>, 
	"dkodihalli@nvidia.com" <dkodihalli@nvidia.com>, "spuranik@nvidia.com" <spuranik@nvidia.com>
Content-Type: multipart/alternative; boundary="000000000000c23214063ba8b02c"

--000000000000c23214063ba8b02c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Kernel Maintainers,
I hope this email finds you well.

If I may ask, what do we need to do to move this patch forward?

Thank you for your help,
Mo

On Tue, Jul 8, 2025 at 11:41=E2=80=AFPM Ryan Chen <ryan_chen@aspeedtech.com=
> wrote:

> Hello Stephen,
>         sorry to bother you, do you have time to review this patch?
> Ryan
>
> > -----Original Message-----
> > From: Ryan Chen <ryan_chen@aspeedtech.com>
> > Sent: Tuesday, July 8, 2025 1:29 PM
> > To: Ryan Chen <ryan_chen@aspeedtech.com>; Michael Turquette
> > <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Philipp
> Zabel
> > <p.zabel@pengutronix.de>; Joel Stanley <joel@jms.id.au>; Andrew Jeffery
> > <andrew@codeconstruct.com.au>; Rob Herring <robh@kernel.org>; Krzysztof
> > Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> > linux-clk@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-aspeed@lists.ozlabs.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Mo Elbadry <elbadrym@google.com>; Rom
> > Lemarchand <romlem@google.com>; William Kennington <wak@google.com>;
> > Yuxiao Zhang <yuxiaozhang@google.com>; wthai@nvidia.com;
> > leohu@nvidia.com; dkodihalli@nvidia.com; spuranik@nvidia.com
> > Subject: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
> >
> > Add AST2700 clock controller driver and also use axiliary device
> framework
> > register the reset controller driver.
> > Due to clock and reset using the same register region.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  drivers/clk/Kconfig       |    8 +
> >  drivers/clk/Makefile      |    1 +
> >  drivers/clk/clk-ast2700.c | 1138
> > +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1147 insertions(+)
> >  create mode 100644 drivers/clk/clk-ast2700.c
> >
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig index
> > 19c1ed280fd7..10b67370f65d 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -288,6 +288,14 @@ config COMMON_CLK_ASPEED
> >         The G4 and G5 series, including the ast2400 and ast2500, are
> > supported
> >         by this driver.
> >
> > +config COMMON_CLK_AST2700
> > +     bool "Clock driver for AST2700 SoC"
> > +     depends on ARCH_ASPEED || COMPILE_TEST
> > +     help
> > +       This driver provides support for clock on AST2700 SoC.
> > +       The driver is responsible for managing the various clocks
> required
> > +       by the peripherals and cores within the AST2700.
> > +
> >  config COMMON_CLK_S2MPS11
> >       tristate "Clock driver for S2MPS1X/S5M8767 MFD"
> >       depends on MFD_SEC_CORE || COMPILE_TEST diff --git
> > a/drivers/clk/Makefile b/drivers/clk/Makefile index
> > 42867cd37c33..3d911b81149c 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -63,6 +63,7 @@ obj-$(CONFIG_COMMON_CLK_FSL_SAI)    +=3D clk-fsl-sai.=
o
> >  obj-$(CONFIG_COMMON_CLK_GEMINI)              +=3D clk-gemini.o
> >  obj-$(CONFIG_COMMON_CLK_ASPEED)              +=3D clk-aspeed.o
> >  obj-$(CONFIG_MACH_ASPEED_G6)         +=3D clk-ast2600.o
> > +obj-$(CONFIG_COMMON_CLK_AST2700)     +=3D clk-ast2700.o
> >  obj-$(CONFIG_ARCH_HIGHBANK)          +=3D clk-highbank.o
> >  obj-$(CONFIG_CLK_HSDK)                       +=3D clk-hsdk-pll.o
> >  obj-$(CONFIG_COMMON_CLK_K210)                +=3D clk-k210.o
> > diff --git a/drivers/clk/clk-ast2700.c b/drivers/clk/clk-ast2700.c new
> file mode
> > 100644 index 000000000000..c6d77e3f4ace
> > --- /dev/null
> > +++ b/drivers/clk/clk-ast2700.c
> > @@ -0,0 +1,1138 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2024 ASPEED Technology Inc.
> > + * Author: Ryan Chen <ryan_chen@aspeedtech.com>  */ #include
> > +<linux/auxiliary_bus.h> #include <linux/bitfield.h> #include
> > +<linux/clk-provider.h> #include <linux/io.h> #include
> > +<linux/mod_devicetable.h> #include <linux/of_platform.h> #include
> > +<linux/platform_device.h> #include <linux/slab.h> #include
> > +<linux/units.h>
> > +
> > +#include <dt-bindings/clock/aspeed,ast2700-scu.h>
> > +
> > +#define SCU_CLK_12MHZ        (12 * HZ_PER_MHZ)
> > +#define SCU_CLK_24MHZ        (24 * HZ_PER_MHZ)
> > +#define SCU_CLK_25MHZ        (25 * HZ_PER_MHZ)
> > +#define SCU_CLK_192MHZ       (192 * HZ_PER_MHZ)
> > +
> > +/* SOC0 */
> > +#define SCU0_HWSTRAP1                0x010
> > +#define SCU0_CLK_STOP                0x240
> > +#define SCU0_CLK_SEL1                0x280
> > +#define SCU0_CLK_SEL2                0x284
> > +#define GET_USB_REFCLK_DIV(x)        ((GENMASK(23, 20) & (x)) >> 20)
> > +#define UART_DIV13_EN                BIT(30)
> > +#define SCU0_HPLL_PARAM              0x300
> > +#define SCU0_DPLL_PARAM              0x308
> > +#define SCU0_MPLL_PARAM              0x310
> > +#define SCU0_D0CLK_PARAM     0x320
> > +#define SCU0_D1CLK_PARAM     0x330
> > +#define SCU0_CRT0CLK_PARAM   0x340
> > +#define SCU0_CRT1CLK_PARAM   0x350
> > +#define SCU0_MPHYCLK_PARAM   0x360
> > +
> > +/* SOC1 */
> > +#define SCU1_REVISION_ID     0x0
> > +#define REVISION_ID          GENMASK(23, 16)
> > +#define SCU1_CLK_STOP                0x240
> > +#define SCU1_CLK_STOP2               0x260
> > +#define SCU1_CLK_SEL1                0x280
> > +#define SCU1_CLK_SEL2                0x284
> > +#define SCU1_CLK_I3C_DIV_MASK        GENMASK(25, 23)
> > +#define SCU1_CLK_I3C_DIV(n)  ((n) - 1)
> > +#define UXCLK_MASK           GENMASK(1, 0)
> > +#define HUXCLK_MASK          GENMASK(4, 3)
> > +#define SCU1_HPLL_PARAM              0x300
> > +#define SCU1_APLL_PARAM              0x310
> > +#define SCU1_DPLL_PARAM              0x320
> > +#define SCU1_UXCLK_CTRL              0x330
> > +#define SCU1_HUXCLK_CTRL     0x334
> > +#define SCU1_MAC12_CLK_DLY   0x390
> > +#define SCU1_MAC12_CLK_DLY_100M      0x394
> > +#define SCU1_MAC12_CLK_DLY_10M       0x398
> > +
> > +enum ast2700_clk_type {
> > +     CLK_MUX,
> > +     CLK_PLL,
> > +     CLK_HPLL,
> > +     CLK_GATE,
> > +     CLK_MISC,
> > +     CLK_FIXED,
> > +     DCLK_FIXED,
> > +     CLK_DIVIDER,
> > +     CLK_UART_PLL,
> > +     CLK_FIXED_FACTOR,
> > +     CLK_GATE_ASPEED,
> > +};
> > +
> > +struct ast2700_clk_fixed_factor_data {
> > +     const struct clk_parent_data *parent;
> > +     unsigned int mult;
> > +     unsigned int div;
> > +};
> > +
> > +struct ast2700_clk_gate_data {
> > +     const struct clk_parent_data *parent;
> > +     u32 flags;
> > +     u32 reg;
> > +     u8 bit;
> > +};
> > +
> > +struct ast2700_clk_mux_data {
> > +     const struct clk_parent_data *parents;
> > +     unsigned int num_parents;
> > +     u8 bit_shift;
> > +     u8 bit_width;
> > +     u32 reg;
> > +};
> > +
> > +struct ast2700_clk_div_data {
> > +     const struct clk_div_table *div_table;
> > +     const struct clk_parent_data *parent;
> > +     u8 bit_shift;
> > +     u8 bit_width;
> > +     u32 reg;
> > +};
> > +
> > +struct ast2700_clk_pll_data {
> > +     const struct clk_parent_data *parent;
> > +     u32 reg;
> > +};
> > +
> > +struct ast2700_clk_fixed_rate_data {
> > +     unsigned long fixed_rate;
> > +};
> > +
> > +struct ast2700_clk_info {
> > +     const char *name;
> > +     u8 clk_idx;
> > +     u32 reg;
> > +     u32 type;
> > +     union {
> > +             struct ast2700_clk_fixed_factor_data factor;
> > +             struct ast2700_clk_fixed_rate_data rate;
> > +             struct ast2700_clk_gate_data gate;
> > +             struct ast2700_clk_div_data div;
> > +             struct ast2700_clk_pll_data pll;
> > +             struct ast2700_clk_mux_data mux;
> > +     } data;
> > +};
> > +
> > +struct ast2700_clk_data {
> > +     struct ast2700_clk_info const *clk_info;
> > +     unsigned int nr_clks;
> > +     const int scu;
> > +};
> > +
> > +struct ast2700_clk_ctrl {
> > +     const struct ast2700_clk_data *clk_data;
> > +     struct device *dev;
> > +     void __iomem *base;
> > +     spinlock_t lock; /* clk lock */
> > +};
> > +
> > +static const struct clk_div_table ast2700_rgmii_div_table[] =3D {
> > +     { 0x0, 4 },
> > +     { 0x1, 4 },
> > +     { 0x2, 6 },
> > +     { 0x3, 8 },
> > +     { 0x4, 10 },
> > +     { 0x5, 12 },
> > +     { 0x6, 14 },
> > +     { 0x7, 16 },
> > +     { 0 }
> > +};
> > +
> > +static const struct clk_div_table ast2700_rmii_div_table[] =3D {
> > +     { 0x0, 8 },
> > +     { 0x1, 8 },
> > +     { 0x2, 12 },
> > +     { 0x3, 16 },
> > +     { 0x4, 20 },
> > +     { 0x5, 24 },
> > +     { 0x6, 28 },
> > +     { 0x7, 32 },
> > +     { 0 }
> > +};
> > +
> > +static const struct clk_div_table ast2700_clk_div_table[] =3D {
> > +     { 0x0, 2 },
> > +     { 0x1, 2 },
> > +     { 0x2, 3 },
> > +     { 0x3, 4 },
> > +     { 0x4, 5 },
> > +     { 0x5, 6 },
> > +     { 0x6, 7 },
> > +     { 0x7, 8 },
> > +     { 0 }
> > +};
> > +
> > +static const struct clk_div_table ast2700_clk_div_table2[] =3D {
> > +     { 0x0, 2 },
> > +     { 0x1, 4 },
> > +     { 0x2, 6 },
> > +     { 0x3, 8 },
> > +     { 0x4, 10 },
> > +     { 0x5, 12 },
> > +     { 0x6, 14 },
> > +     { 0x7, 16 },
> > +     { 0 }
> > +};
> > +
> > +static const struct clk_div_table ast2700_hclk_div_table[] =3D {
> > +     { 0x0, 6 },
> > +     { 0x1, 5 },
> > +     { 0x2, 4 },
> > +     { 0x3, 7 },
> > +     { 0 }
> > +};
> > +
> > +static const struct clk_div_table ast2700_clk_uart_div_table[] =3D {
> > +     { 0x0, 1 },
> > +     { 0x1, 13 },
> > +     { 0 }
> > +};
> > +
> > +static const struct clk_parent_data soc0_clkin[] =3D {
> > +     { .fw_name =3D "soc0-clkin", .name =3D "soc0-clkin" }, };
> > +
> > +static const struct clk_parent_data pspclk[] =3D {
> > +     { .fw_name =3D "pspclk", .name =3D "pspclk" }, };
> > +
> > +static const struct clk_parent_data mphysrc[] =3D {
> > +     { .fw_name =3D "mphysrc", .name =3D "mphysrc" }, };
> > +
> > +static const struct clk_parent_data u2phy_refclksrc[] =3D {
> > +     { .fw_name =3D "u2phy_refclksrc", .name =3D "u2phy_refclksrc" }, =
};
> > +
> > +static const struct clk_parent_data soc0_hpll[] =3D {
> > +     { .fw_name =3D "soc0-hpll", .name =3D "soc0-hpll" }, };
> > +
> > +static const struct clk_parent_data soc0_mpll[] =3D {
> > +     { .fw_name =3D "soc0-mpll", .name =3D "soc0-mpll" }, };
> > +
> > +static const struct clk_parent_data axi0clk[] =3D {
> > +     { .fw_name =3D "axi0clk", .name =3D "axi0clk" }, };
> > +
> > +static const struct clk_parent_data soc0_ahbmux[] =3D {
> > +     { .fw_name =3D "soc0-ahbmux", .name =3D "soc0-ahbmux" }, };
> > +
> > +static const struct clk_parent_data soc0_uartclk[] =3D {
> > +     { .fw_name =3D "soc0-uartclk", .name =3D "soc0-uartclk" }, };
> > +
> > +static const struct clk_parent_data emmcclk[] =3D {
> > +     { .fw_name =3D "emmcclk", .name =3D "emmcclk" }, };
> > +
> > +static const struct clk_parent_data emmcsrc_mux[] =3D {
> > +     { .fw_name =3D "emmcsrc-mux", .name =3D "emmcsrc-mux" }, };
> > +
> > +static const struct clk_parent_data soc1_clkin[] =3D {
> > +     { .fw_name =3D "soc1-clkin", .name =3D "soc1-clkin" }, };
> > +
> > +static const struct clk_parent_data soc1_hpll[] =3D {
> > +     { .fw_name =3D "soc1-hpll", .name =3D "soc1-hpll" }, };
> > +
> > +static const struct clk_parent_data soc1_apll[] =3D {
> > +     { .fw_name =3D "soc1-apll", .name =3D "soc1-apll" }, };
> > +
> > +static const struct clk_parent_data sdclk[] =3D {
> > +     { .fw_name =3D "sdclk", .name =3D "sdclk" }, };
> > +
> > +static const struct clk_parent_data sdclk_mux[] =3D {
> > +     { .fw_name =3D "sdclk-mux", .name =3D "sdclk-mux" }, };
> > +
> > +static const struct clk_parent_data huartxclk[] =3D {
> > +     { .fw_name =3D "huartxclk", .name =3D "huartxclk" }, };
> > +
> > +static const struct clk_parent_data uxclk[] =3D {
> > +     { .fw_name =3D "uxclk", .name =3D "uxclk" }, };
> > +
> > +static const struct clk_parent_data huxclk[] =3D {
> > +     { .fw_name =3D "huxclk", .name =3D "huxclk" }, };
> > +
> > +static const struct clk_parent_data uart0clk[] =3D {
> > +     { .fw_name =3D "uart0clk", .name =3D "uart0clk" }, };
> > +
> > +static const struct clk_parent_data uart1clk[] =3D {
> > +     { .fw_name =3D "uart1clk", .name =3D "uart1clk" }, };
> > +
> > +static const struct clk_parent_data uart2clk[] =3D {
> > +     { .fw_name =3D "uart2clk", .name =3D "uart2clk" }, };
> > +
> > +static const struct clk_parent_data uart3clk[] =3D {
> > +     { .fw_name =3D "uart3clk", .name =3D "uart3clk" }, };
> > +
> > +static const struct clk_parent_data uart5clk[] =3D {
> > +     { .fw_name =3D "uart5clk", .name =3D "uart5clk" }, };
> > +
> > +static const struct clk_parent_data uart4clk[] =3D {
> > +     { .fw_name =3D "uart4clk", .name =3D "uart4clk" }, };
> > +
> > +static const struct clk_parent_data uart6clk[] =3D {
> > +     { .fw_name =3D "uart6clk", .name =3D "uart6clk" }, };
> > +
> > +static const struct clk_parent_data uart7clk[] =3D {
> > +     { .fw_name =3D "uart7clk", .name =3D "uart7clk" }, };
> > +
> > +static const struct clk_parent_data uart8clk[] =3D {
> > +     { .fw_name =3D "uart8clk", .name =3D "uart8clk" }, };
> > +
> > +static const struct clk_parent_data uart9clk[] =3D {
> > +     { .fw_name =3D "uart9clk", .name =3D "uart9clk" }, };
> > +
> > +static const struct clk_parent_data uart10clk[] =3D {
> > +     { .fw_name =3D "uart10clk", .name =3D "uart10clk" }, };
> > +
> > +static const struct clk_parent_data uart11clk[] =3D {
> > +     { .fw_name =3D "uart11clk", .name =3D "uart11clk" }, };
> > +
> > +static const struct clk_parent_data uart12clk[] =3D {
> > +     { .fw_name =3D "uart12clk", .name =3D "uart12clk" }, };
> > +
> > +static const struct clk_parent_data uart13clk[] =3D {
> > +     { .fw_name =3D "uart13clk", .name =3D "uart13clk" }, };
> > +
> > +static const struct clk_parent_data uart14clk[] =3D {
> > +     { .fw_name =3D "uart14clk", .name =3D "uart14clk" }, };
> > +
> > +static const struct clk_parent_data soc1_i3c[] =3D {
> > +     { .fw_name =3D "soc1-i3c", .name =3D "soc1-i3c" }, };
> > +
> > +static const struct clk_parent_data canclk[] =3D {
> > +     { .fw_name =3D "canclk", .name =3D "canclk" }, };
> > +
> > +static const struct clk_parent_data rmii[] =3D {
> > +     { .fw_name =3D "rmii", .name =3D "rmii" }, };
> > +
> > +static const struct clk_parent_data hclk_clk_sels[] =3D {
> > +     { .fw_name =3D "soc0-hpll", .name =3D "soc0-hpll" },
> > +     { .fw_name =3D "soc0-mpll", .name =3D "soc0-mpll" }, };
> > +
> > +static const struct clk_parent_data mhpll_clk_sels[] =3D {
> > +     { .fw_name =3D "soc0-mpll", .name =3D "soc0-mpll" },
> > +     { .fw_name =3D "soc0-hpll", .name =3D "soc0-hpll" }, };
> > +
> > +static const struct clk_parent_data mphy_clk_sels[] =3D {
> > +     { .fw_name =3D "soc0-mpll", .name =3D "soc0-mpll" },
> > +     { .fw_name =3D "soc0-hpll", .name =3D "soc0-hpll" },
> > +     { .fw_name =3D "soc0-dpll", .name =3D "soc0-dpll" },
> > +     { .fw_name =3D "soc0-clk192Mhz", .name =3D "soc0-clk192Mhz" }, };
> > +
> > +static const struct clk_parent_data psp_clk_sels[] =3D {
> > +     { .fw_name =3D "soc0-mpll", .name =3D "soc0-mpll" },
> > +     { .fw_name =3D "soc0-hpll", .name =3D "soc0-hpll" },
> > +     { .fw_name =3D "soc0-hpll", .name =3D "soc0-hpll" },
> > +     { .fw_name =3D "soc0-hpll", .name =3D "soc0-hpll" },
> > +     { .fw_name =3D "soc0-mpll_div2", .name =3D "soc0-mpll_div2" },
> > +     { .fw_name =3D "soc0-hpll_div2", .name =3D "soc0-hpll_div2" },
> > +     { .fw_name =3D "soc0-hpll", .name =3D "soc0-hpll" },
> > +     { .fw_name =3D "soc0-hpll", .name =3D "soc0-hpll" }, };
> > +
> > +static const struct clk_parent_data uart_clk_sels[] =3D {
> > +     { .fw_name =3D "soc0-clk24Mhz", .name =3D "soc0-clk24Mhz" },
> > +     { .fw_name =3D "soc0-clk192Mhz", .name =3D "soc0-clk192Mhz" }, };
> > +
> > +static const struct clk_parent_data emmc_clk_sels[] =3D {
> > +     { .fw_name =3D "soc0-mpll_div4", .name =3D "soc0-mpll_div4" },
> > +     { .fw_name =3D "soc0-hpll_div4", .name =3D "soc0-hpll_div4" }, };
> > +
> > +static const struct clk_parent_data sdio_clk_sels[] =3D {
> > +     { .fw_name =3D "soc1-hpll", .name =3D "soc1-hpll" },
> > +     { .fw_name =3D "soc1-apll", .name =3D "soc1-apll" }, };
> > +
> > +static const struct clk_parent_data ux_clk_sels[] =3D {
> > +     { .fw_name =3D "soc1-apll_div4", .name =3D "soc1-apll_div4" },
> > +     { .fw_name =3D "soc1-apll_div2", .name =3D "soc1-apll_div2" },
> > +     { .fw_name =3D "soc1-apll", .name =3D "soc1-apll" },
> > +     { .fw_name =3D "soc1-hpll", .name =3D "soc1-hpll" }, };
> > +
> > +static const struct clk_parent_data uartx_clk_sels[] =3D {
> > +     { .fw_name =3D "uartxclk", .name =3D "uartxclk" },
> > +     { .fw_name =3D "huartxclk", .name =3D "huartxclk" }, };
> > +
> > +#define FIXED_CLK(_id, _name, _rate) \
> > +     [_id] =3D { \
> > +             .type =3D CLK_FIXED, \
> > +             .name =3D _name, \
> > +             .data =3D { .rate =3D { .fixed_rate =3D _rate, } }, \
> > +     }
> > +
> > +#define PLL_CLK(_id, _type, _name, _parent, _reg) \
> > +     [_id] =3D { \
> > +             .type =3D _type, \
> > +             .name =3D _name, \
> > +             .data =3D { .pll =3D { .parent =3D _parent, .reg =3D _reg=
, } }, \
> > +     }
> > +
> > +#define MUX_CLK(_id, _name, _parents, _num_parents, _reg, _shift,
> _width)
> > \
> > +     [_id] =3D { \
> > +             .type =3D CLK_MUX, \
> > +             .name =3D _name, \
> > +             .data =3D { \
> > +                     .mux =3D { \
> > +                             .parents =3D _parents, \
> > +                             .num_parents =3D _num_parents, \
> > +                             .reg =3D _reg, \
> > +                             .bit_shift =3D _shift, \
> > +                             .bit_width =3D _width, \
> > +                     }, \
> > +             }, \
> > +     }
> > +
> > +#define DIVIDER_CLK(_id, _name, _parent, _reg, _shift, _width,
> _div_table) \
> > +     [_id] =3D { \
> > +             .type =3D CLK_DIVIDER, \
> > +             .name =3D _name, \
> > +             .data =3D { \
> > +                     .div =3D { \
> > +                             .parent =3D _parent, \
> > +                             .reg =3D _reg, \
> > +                             .bit_shift =3D _shift, \
> > +                             .bit_width =3D _width, \
> > +                             .div_table =3D _div_table, \
> > +                     }, \
> > +             }, \
> > +     }
> > +
> > +#define FIXED_FACTOR_CLK(_id, _name, _parent, _mult, _div) \
> > +     [_id] =3D { \
> > +             .type =3D CLK_FIXED_FACTOR, \
> > +             .name =3D _name, \
> > +             .data =3D { .factor =3D { .parent =3D _parent, .mult =3D =
_mult,
> .div =3D _div, } }, \
> > +     }
> > +
> > +#define GATE_CLK(_id, _type, _name, _parent, _reg, _bit, _flags) \
> > +     [_id] =3D { \
> > +             .type =3D _type, \
> > +             .name =3D _name, \
> > +             .data =3D { \
> > +                     .gate =3D { \
> > +                             .parent =3D _parent, \
> > +                             .reg =3D _reg, \
> > +                             .bit =3D _bit, \
> > +                             .flags =3D _flags, \
> > +                     }, \
> > +             }, \
> > +     }
> > +
> > +static const struct ast2700_clk_info ast2700_scu0_clk_info[]
> __initconst =3D {
> > +     FIXED_CLK(SCU0_CLKIN, "soc0-clkin", SCU_CLK_25MHZ),
> > +     FIXED_CLK(SCU0_CLK_24M, "soc0-clk24Mhz", SCU_CLK_24MHZ),
> > +     FIXED_CLK(SCU0_CLK_192M, "soc0-clk192Mhz", SCU_CLK_192MHZ),
> > +     FIXED_CLK(SCU0_CLK_U2PHY_CLK12M, "u2phy_clk12m",
> > SCU_CLK_12MHZ),
> > +     PLL_CLK(SCU0_CLK_HPLL, CLK_HPLL, "soc0-hpll", soc0_clkin,
> > SCU0_HPLL_PARAM),
> > +     PLL_CLK(SCU0_CLK_DPLL, CLK_PLL, "soc0-dpll", soc0_clkin,
> > SCU0_DPLL_PARAM),
> > +     PLL_CLK(SCU0_CLK_MPLL, CLK_PLL, "soc0-mpll", soc0_clkin,
> > SCU0_MPLL_PARAM),
> > +     PLL_CLK(SCU0_CLK_D0, DCLK_FIXED, "d0clk", NULL,
> > SCU0_D0CLK_PARAM),
> > +     PLL_CLK(SCU0_CLK_D1, DCLK_FIXED, "d1clk", NULL,
> > SCU0_D1CLK_PARAM),
> > +     PLL_CLK(SCU0_CLK_CRT0, DCLK_FIXED, "crt0clk", NULL,
> > SCU0_CRT0CLK_PARAM),
> > +     PLL_CLK(SCU0_CLK_CRT1, DCLK_FIXED, "crt1clk", NULL,
> > SCU0_CRT1CLK_PARAM),
> > +     PLL_CLK(SCU0_CLK_MPHY, CLK_MISC, "mphyclk", mphysrc,
> > SCU0_MPHYCLK_PARAM),
> > +     PLL_CLK(SCU0_CLK_U2PHY_REFCLK, CLK_MISC, "u2phy_refclk",
> > u2phy_refclksrc, SCU0_CLK_SEL2),
> > +     FIXED_FACTOR_CLK(SCU0_CLK_HPLL_DIV2, "soc0-hpll_div2", soc0_hpll,
> 1,
> > 2),
> > +     FIXED_FACTOR_CLK(SCU0_CLK_HPLL_DIV4, "soc0-hpll_div4", soc0_hpll,
> 1,
> > 4),
> > +     FIXED_FACTOR_CLK(SCU0_CLK_MPLL_DIV2, "soc0-mpll_div2", soc0_mpll,
> > 1, 2),
> > +     FIXED_FACTOR_CLK(SCU0_CLK_MPLL_DIV4, "soc0-mpll_div4", soc0_mpll,
> > 1, 4),
> > +     FIXED_FACTOR_CLK(SCU0_CLK_MPLL_DIV8, "soc0-mpll_div8", soc0_mpll,
> > 1, 8),
> > +     FIXED_FACTOR_CLK(SCU0_CLK_AXI0, "axi0clk", pspclk, 1, 2),
> > +     FIXED_FACTOR_CLK(SCU0_CLK_AXI1, "axi1clk", soc0_mpll, 1, 4),
> > +     DIVIDER_CLK(SCU0_CLK_AHB, "soc0-ahb", soc0_ahbmux,
> > +                 SCU0_HWSTRAP1, 5, 2, ast2700_hclk_div_table),
> > +     DIVIDER_CLK(SCU0_CLK_EMMC, "emmcclk", emmcsrc_mux,
> > +                 SCU0_CLK_SEL1, 12, 3, ast2700_clk_div_table2),
> > +     DIVIDER_CLK(SCU0_CLK_APB, "soc0-apb", axi0clk,
> > +                 SCU0_CLK_SEL1, 23, 3, ast2700_clk_div_table2),
> > +     DIVIDER_CLK(SCU0_CLK_UART4, "uart4clk", soc0_uartclk,
> > +                 SCU0_CLK_SEL2, 30, 1, ast2700_clk_uart_div_table),
> > +     DIVIDER_CLK(SCU0_CLK_HPLL_DIV_AHB, "soc0-hpll-ahb", soc0_hpll,
> > +                 SCU0_HWSTRAP1, 5, 2, ast2700_hclk_div_table),
> > +     DIVIDER_CLK(SCU0_CLK_MPLL_DIV_AHB, "soc0-mpll-ahb", soc0_mpll,
> > +                 SCU0_HWSTRAP1, 5, 2, ast2700_hclk_div_table),
> > +     MUX_CLK(SCU0_CLK_PSP, "pspclk", psp_clk_sels,
> > ARRAY_SIZE(psp_clk_sels),
> > +             SCU0_HWSTRAP1, 2, 3),
> > +     MUX_CLK(SCU0_CLK_AHBMUX, "soc0-ahbmux", hclk_clk_sels,
> > ARRAY_SIZE(hclk_clk_sels),
> > +             SCU0_HWSTRAP1, 7, 1),
> > +     MUX_CLK(SCU0_CLK_EMMCMUX, "emmcsrc-mux", emmc_clk_sels,
> > ARRAY_SIZE(emmc_clk_sels),
> > +             SCU0_CLK_SEL1, 11, 1),
> > +     MUX_CLK(SCU0_CLK_MPHYSRC, "mphysrc", mphy_clk_sels,
> > ARRAY_SIZE(mphy_clk_sels),
> > +             SCU0_CLK_SEL2, 18, 2),
> > +     MUX_CLK(SCU0_CLK_U2PHY_REFCLKSRC, "u2phy_refclksrc",
> > mhpll_clk_sels,
> > +             ARRAY_SIZE(mhpll_clk_sels), SCU0_CLK_SEL2, 23, 1),
> > +     MUX_CLK(SCU0_CLK_UART, "soc0-uartclk", uart_clk_sels,
> > ARRAY_SIZE(uart_clk_sels),
> > +             SCU0_CLK_SEL2, 14, 1),
> > +     GATE_CLK(SCU0_CLK_GATE_MCLK, CLK_GATE_ASPEED, "mclk-gate",
> > soc0_mpll,
> > +              SCU0_CLK_STOP, 0, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU0_CLK_GATE_ECLK, CLK_GATE_ASPEED, "eclk-gate", NULL,
> > SCU0_CLK_STOP, 1, 0),
> > +     GATE_CLK(SCU0_CLK_GATE_2DCLK, CLK_GATE_ASPEED, "gclk-gate", NULL,
> > SCU0_CLK_STOP, 2, 0),
> > +     GATE_CLK(SCU0_CLK_GATE_VCLK, CLK_GATE_ASPEED, "vclk-gate", NULL,
> > SCU0_CLK_STOP, 3, 0),
> > +     GATE_CLK(SCU0_CLK_GATE_BCLK, CLK_GATE_ASPEED, "bclk-gate", NULL,
> > +              SCU0_CLK_STOP, 4, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU0_CLK_GATE_VGA0CLK,  CLK_GATE_ASPEED,
> > "vga0clk-gate", NULL,
> > +              SCU0_CLK_STOP, 5, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU0_CLK_GATE_REFCLK,  CLK_GATE_ASPEED,
> > "soc0-refclk-gate", soc0_clkin,
> > +              SCU0_CLK_STOP, 6, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU0_CLK_GATE_PORTBUSB2CLK, CLK_GATE_ASPEED,
> > "portb-usb2clk-gate", NULL,
> > +              SCU0_CLK_STOP, 7, 0),
> > +     GATE_CLK(SCU0_CLK_GATE_UHCICLK, CLK_GATE_ASPEED, "uhciclk-gate",
> > NULL, SCU0_CLK_STOP, 9, 0),
> > +     GATE_CLK(SCU0_CLK_GATE_VGA1CLK, CLK_GATE_ASPEED, "vga1clk-gate",
> > NULL,
> > +              SCU0_CLK_STOP, 10, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU0_CLK_GATE_DDRPHYCLK, CLK_GATE_ASPEED,
> > "ddrphy-gate", NULL,
> > +              SCU0_CLK_STOP, 11, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU0_CLK_GATE_E2M0CLK, CLK_GATE_ASPEED,
> > "e2m0clk-gate", NULL,
> > +              SCU0_CLK_STOP, 12, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU0_CLK_GATE_HACCLK, CLK_GATE_ASPEED, "hacclk-gate",
> > NULL, SCU0_CLK_STOP, 13, 0),
> > +     GATE_CLK(SCU0_CLK_GATE_PORTAUSB2CLK, CLK_GATE_ASPEED,
> > "porta-usb2clk-gate", NULL,
> > +              SCU0_CLK_STOP, 14, 0),
> > +     GATE_CLK(SCU0_CLK_GATE_UART4CLK, CLK_GATE_ASPEED,
> > "uart4clk-gate", uart4clk,
> > +              SCU0_CLK_STOP, 15, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU0_CLK_GATE_SLICLK, CLK_GATE_ASPEED, "soc0-sliclk-gate=
",
> > NULL,
> > +              SCU0_CLK_STOP, 16, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU0_CLK_GATE_DACCLK, CLK_GATE_ASPEED, "dacclk-gate",
> > NULL,
> > +              SCU0_CLK_STOP, 17, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU0_CLK_GATE_DP, CLK_GATE_ASPEED, "dpclk-gate", NULL,
> > +              SCU0_CLK_STOP, 18, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU0_CLK_GATE_E2M1CLK, CLK_GATE_ASPEED,
> > "e2m1clk-gate", NULL,
> > +              SCU0_CLK_STOP, 19, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU0_CLK_GATE_CRT0CLK, CLK_GATE_ASPEED, "crt0clk-gate",
> > NULL,
> > +              SCU0_CLK_STOP, 20, 0),
> > +     GATE_CLK(SCU0_CLK_GATE_CRT1CLK, CLK_GATE_ASPEED, "crt1clk-gate",
> > NULL,
> > +              SCU0_CLK_STOP, 21, 0),
> > +     GATE_CLK(SCU0_CLK_GATE_ECDSACLK, CLK_GATE_ASPEED, "eccclk-gate",
> > NULL,
> > +              SCU0_CLK_STOP, 23, 0),
> > +     GATE_CLK(SCU0_CLK_GATE_RSACLK, CLK_GATE_ASPEED, "rsaclk-gate",
> > NULL,
> > +              SCU0_CLK_STOP, 24, 0),
> > +     GATE_CLK(SCU0_CLK_GATE_RVAS0CLK, CLK_GATE_ASPEED,
> > "rvas0clk-gate", NULL,
> > +              SCU0_CLK_STOP, 25, 0),
> > +     GATE_CLK(SCU0_CLK_GATE_UFSCLK, CLK_GATE_ASPEED, "ufsclk-gate",
> > NULL,
> > +              SCU0_CLK_STOP, 26, 0),
> > +     GATE_CLK(SCU0_CLK_GATE_EMMCCLK, CLK_GATE_ASPEED,
> > "emmcclk-gate", emmcclk,
> > +              SCU0_CLK_STOP, 27, 0),
> > +     GATE_CLK(SCU0_CLK_GATE_RVAS1CLK, CLK_GATE_ASPEED,
> > "rvas1clk-gate", NULL,
> > +              SCU0_CLK_STOP, 28, 0),
> > +};
> > +
> > +static const struct ast2700_clk_info ast2700_scu1_clk_info[]
> __initconst =3D {
> > +     FIXED_CLK(SCU1_CLKIN, "soc1-clkin", SCU_CLK_25MHZ),
> > +     PLL_CLK(SCU1_CLK_HPLL, CLK_PLL, "soc1-hpll", soc1_clkin,
> > SCU1_HPLL_PARAM),
> > +     PLL_CLK(SCU1_CLK_APLL, CLK_PLL, "soc1-apll", soc1_clkin,
> > SCU1_APLL_PARAM),
> > +     PLL_CLK(SCU1_CLK_DPLL, CLK_PLL, "soc1-dpll", soc1_clkin,
> > SCU1_DPLL_PARAM),
> > +     PLL_CLK(SCU1_CLK_UARTX, CLK_UART_PLL, "uartxclk", uxclk,
> > SCU1_UXCLK_CTRL),
> > +     PLL_CLK(SCU1_CLK_HUARTX, CLK_UART_PLL, "huartxclk", huxclk,
> > SCU1_HUXCLK_CTRL),
> > +     FIXED_FACTOR_CLK(SCU1_CLK_APLL_DIV2, "soc1-apll_div2", soc1_apll,
> 1,
> > 2),
> > +     FIXED_FACTOR_CLK(SCU1_CLK_APLL_DIV4, "soc1-apll_div4", soc1_apll,
> 1,
> > 4),
> > +     FIXED_FACTOR_CLK(SCU1_CLK_UART13, "uart13clk", huartxclk, 1, 1),
> > +     FIXED_FACTOR_CLK(SCU1_CLK_UART14, "uart14clk", huartxclk, 1, 1),
> > +     FIXED_FACTOR_CLK(SCU1_CLK_CAN, "canclk", soc1_apll, 1, 10),
> > +     DIVIDER_CLK(SCU1_CLK_SDCLK, "sdclk", sdclk_mux,
> > +                 SCU1_CLK_SEL1, 14, 3, ast2700_clk_div_table),
> > +     DIVIDER_CLK(SCU1_CLK_APB, "soc1-apb", soc1_hpll,
> > +                 SCU1_CLK_SEL1, 18, 3, ast2700_clk_div_table2),
> > +     DIVIDER_CLK(SCU1_CLK_RMII, "rmii", soc1_hpll,
> > +                 SCU1_CLK_SEL1, 21, 3, ast2700_rmii_div_table),
> > +     DIVIDER_CLK(SCU1_CLK_RGMII, "rgmii", soc1_hpll,
> > +                 SCU1_CLK_SEL1, 25, 3, ast2700_rgmii_div_table),
> > +     DIVIDER_CLK(SCU1_CLK_MACHCLK, "machclk", soc1_hpll,
> > +                 SCU1_CLK_SEL1, 29, 3, ast2700_clk_div_table),
> > +     DIVIDER_CLK(SCU1_CLK_APLL_DIVN, "soc1-apll_divn", soc1_apll,
> > +                 SCU1_CLK_SEL2, 8, 3, ast2700_clk_div_table),
> > +     DIVIDER_CLK(SCU1_CLK_AHB, "soc1-ahb", soc1_hpll,
> > +                 SCU1_CLK_SEL2, 20, 3, ast2700_clk_div_table),
> > +     DIVIDER_CLK(SCU1_CLK_I3C, "soc1-i3c", soc1_hpll,
> > +                 SCU1_CLK_SEL2, 23, 3, ast2700_clk_div_table),
> > +     MUX_CLK(SCU1_CLK_UART0, "uart0clk", uartx_clk_sels,
> > ARRAY_SIZE(uartx_clk_sels),
> > +             SCU1_CLK_SEL1, 0, 1),
> > +     MUX_CLK(SCU1_CLK_UART1, "uart1clk", uartx_clk_sels,
> > ARRAY_SIZE(uartx_clk_sels),
> > +             SCU1_CLK_SEL1, 1, 1),
> > +     MUX_CLK(SCU1_CLK_UART2, "uart2clk", uartx_clk_sels,
> > ARRAY_SIZE(uartx_clk_sels),
> > +             SCU1_CLK_SEL1, 2, 1),
> > +     MUX_CLK(SCU1_CLK_UART3, "uart3clk", uartx_clk_sels,
> > ARRAY_SIZE(uartx_clk_sels),
> > +             SCU1_CLK_SEL1, 3, 1),
> > +     MUX_CLK(SCU1_CLK_UART5, "uart5clk", uartx_clk_sels,
> > ARRAY_SIZE(uartx_clk_sels),
> > +             SCU1_CLK_SEL1, 5, 1),
> > +     MUX_CLK(SCU1_CLK_UART6, "uart6clk", uartx_clk_sels,
> > ARRAY_SIZE(uartx_clk_sels),
> > +             SCU1_CLK_SEL1, 6, 1),
> > +     MUX_CLK(SCU1_CLK_UART7, "uart7clk", uartx_clk_sels,
> > ARRAY_SIZE(uartx_clk_sels),
> > +             SCU1_CLK_SEL1, 7, 1),
> > +     MUX_CLK(SCU1_CLK_UART8, "uart8clk", uartx_clk_sels,
> > ARRAY_SIZE(uartx_clk_sels),
> > +             SCU1_CLK_SEL1, 8, 1),
> > +     MUX_CLK(SCU1_CLK_UART9, "uart9clk", uartx_clk_sels,
> > ARRAY_SIZE(uartx_clk_sels),
> > +             SCU1_CLK_SEL1, 9, 1),
> > +     MUX_CLK(SCU1_CLK_UART10, "uart10clk", uartx_clk_sels,
> > ARRAY_SIZE(uartx_clk_sels),
> > +             SCU1_CLK_SEL1, 10, 1),
> > +     MUX_CLK(SCU1_CLK_UART11, "uart11clk", uartx_clk_sels,
> > ARRAY_SIZE(uartx_clk_sels),
> > +             SCU1_CLK_SEL1, 11, 1),
> > +     MUX_CLK(SCU1_CLK_UART12, "uart12clk", uartx_clk_sels,
> > ARRAY_SIZE(uartx_clk_sels),
> > +             SCU1_CLK_SEL1, 12, 1),
> > +     MUX_CLK(SCU1_CLK_SDMUX, "sdclk-mux", sdio_clk_sels,
> > ARRAY_SIZE(sdio_clk_sels),
> > +             SCU1_CLK_SEL1, 13, 1),
> > +     MUX_CLK(SCU1_CLK_UXCLK, "uxclk", ux_clk_sels,
> > ARRAY_SIZE(ux_clk_sels),
> > +             SCU1_CLK_SEL2, 0, 2),
> > +     MUX_CLK(SCU1_CLK_HUXCLK, "huxclk", ux_clk_sels,
> > ARRAY_SIZE(ux_clk_sels),
> > +             SCU1_CLK_SEL2, 3, 2),
> > +     GATE_CLK(SCU1_CLK_MAC0RCLK, CLK_GATE, "mac0rclk-gate", rmii,
> > SCU1_MAC12_CLK_DLY, 29, 0),
> > +     GATE_CLK(SCU1_CLK_MAC1RCLK, CLK_GATE, "mac1rclk-gate", rmii,
> > SCU1_MAC12_CLK_DLY, 30, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_LCLK0, CLK_GATE_ASPEED, "lclk0-gate",
> > NULL,
> > +              SCU1_CLK_STOP, 0, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_LCLK1, CLK_GATE_ASPEED, "lclk1-gate",
> > NULL,
> > +              SCU1_CLK_STOP, 1, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_ESPI0CLK, CLK_GATE_ASPEED,
> > "espi0clk-gate", NULL,
> > +              SCU1_CLK_STOP, 2, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_ESPI1CLK, CLK_GATE_ASPEED,
> > "espi1clk-gate", NULL,
> > +              SCU1_CLK_STOP, 3, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_SDCLK, CLK_GATE_ASPEED, "sdclk-gate",
> > sdclk,
> > +              SCU1_CLK_STOP, 4, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_IPEREFCLK, CLK_GATE_ASPEED,
> > "soc1-iperefclk-gate", NULL,
> > +              SCU1_CLK_STOP, 5, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_REFCLK, CLK_GATE_ASPEED,
> > "soc1-refclk-gate", NULL,
> > +              SCU1_CLK_STOP, 6, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_LPCHCLK, CLK_GATE_ASPEED, "lpchclk-gate",
> > NULL,
> > +              SCU1_CLK_STOP, 7, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_MAC0CLK, CLK_GATE_ASPEED,
> > "mac0clk-gate", NULL,
> > +              SCU1_CLK_STOP, 8, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_MAC1CLK, CLK_GATE_ASPEED,
> > "mac1clk-gate", NULL,
> > +              SCU1_CLK_STOP, 9, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_MAC2CLK, CLK_GATE_ASPEED,
> > "mac2clk-gate", NULL,
> > +              SCU1_CLK_STOP, 10, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_UART0CLK, CLK_GATE_ASPEED,
> > "uart0clk-gate", uart0clk,
> > +              SCU1_CLK_STOP, 11, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_UART1CLK, CLK_GATE_ASPEED,
> > "uart1clk-gate", uart1clk,
> > +              SCU1_CLK_STOP, 12, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_UART2CLK, CLK_GATE_ASPEED,
> > "uart2clk-gate", uart2clk,
> > +              SCU1_CLK_STOP, 13, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_UART3CLK, CLK_GATE_ASPEED,
> > "uart3clk-gate", uart3clk,
> > +              SCU1_CLK_STOP, 14, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_I2CCLK, CLK_GATE_ASPEED, "i2cclk-gate",
> > NULL, SCU1_CLK_STOP, 15, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C0CLK, CLK_GATE_ASPEED, "i3c0clk-gate",
> > soc1_i3c,
> > +              SCU1_CLK_STOP, 16, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C1CLK, CLK_GATE_ASPEED, "i3c1clk-gate",
> > soc1_i3c,
> > +              SCU1_CLK_STOP, 17, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C2CLK, CLK_GATE_ASPEED, "i3c2clk-gate",
> > soc1_i3c,
> > +              SCU1_CLK_STOP, 18, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C3CLK, CLK_GATE_ASPEED, "i3c3clk-gate",
> > soc1_i3c,
> > +              SCU1_CLK_STOP, 19, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C4CLK, CLK_GATE_ASPEED, "i3c4clk-gate",
> > soc1_i3c,
> > +              SCU1_CLK_STOP, 20, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C5CLK, CLK_GATE_ASPEED, "i3c5clk-gate",
> > soc1_i3c,
> > +              SCU1_CLK_STOP, 21, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C6CLK, CLK_GATE_ASPEED, "i3c6clk-gate",
> > soc1_i3c,
> > +              SCU1_CLK_STOP, 22, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C7CLK, CLK_GATE_ASPEED, "i3c7clk-gate",
> > soc1_i3c,
> > +              SCU1_CLK_STOP, 23, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C8CLK, CLK_GATE_ASPEED, "i3c8clk-gate",
> > soc1_i3c,
> > +              SCU1_CLK_STOP, 24, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C9CLK, CLK_GATE_ASPEED, "i3c9clk-gate",
> > soc1_i3c,
> > +              SCU1_CLK_STOP, 25, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C10CLK, CLK_GATE_ASPEED,
> > "i3c10clk-gate", soc1_i3c,
> > +              SCU1_CLK_STOP, 26, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C11CLK, CLK_GATE_ASPEED,
> > "i3c11clk-gate", soc1_i3c,
> > +              SCU1_CLK_STOP, 27, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C12CLK, CLK_GATE_ASPEED,
> > "i3c12clk-gate", soc1_i3c,
> > +              SCU1_CLK_STOP, 28, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C13CLK, CLK_GATE_ASPEED,
> > "i3c13clk-gate", soc1_i3c,
> > +              SCU1_CLK_STOP, 29, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C14CLK, CLK_GATE_ASPEED,
> > "i3c14clk-gate", soc1_i3c,
> > +              SCU1_CLK_STOP, 30, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_I3C15CLK, CLK_GATE_ASPEED,
> > "i3c15clk-gate", soc1_i3c,
> > +              SCU1_CLK_STOP, 31, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_UART5CLK, CLK_GATE_ASPEED,
> > "uart5clk-gate", uart5clk,
> > +              SCU1_CLK_STOP2, 0, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_UART6CLK, CLK_GATE_ASPEED,
> > "uart6clk-gate", uart6clk,
> > +              SCU1_CLK_STOP2, 1, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_UART7CLK, CLK_GATE_ASPEED,
> > "uart7clk-gate", uart7clk,
> > +              SCU1_CLK_STOP2, 2, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_UART8CLK, CLK_GATE_ASPEED,
> > "uart8clk-gate", uart8clk,
> > +              SCU1_CLK_STOP2, 3, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_UART9CLK, CLK_GATE_ASPEED,
> > "uart9clk-gate", uart9clk,
> > +              SCU1_CLK_STOP2, 4, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_UART10CLK, CLK_GATE_ASPEED,
> > "uart10clk-gate", uart10clk,
> > +              SCU1_CLK_STOP2, 5, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_UART11CLK, CLK_GATE_ASPEED,
> > "uart11clk-gate", uart11clk,
> > +              SCU1_CLK_STOP2, 6, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_UART12CLK, CLK_GATE_ASPEED,
> > "uart12clk-gate", uart12clk,
> > +              SCU1_CLK_STOP2, 7, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_FSICLK, CLK_GATE_ASPEED, "fsiclk-gate",
> > NULL, SCU1_CLK_STOP2, 8, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_LTPIPHYCLK, CLK_GATE_ASPEED,
> > "ltpiphyclk-gate", NULL,
> > +              SCU1_CLK_STOP2, 9, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_LTPICLK, CLK_GATE_ASPEED, "ltpiclk-gate",
> > NULL,
> > +              SCU1_CLK_STOP2, 10, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_VGALCLK, CLK_GATE_ASPEED, "vgalclk-gate",
> > NULL,
> > +              SCU1_CLK_STOP2, 11, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_UHCICLK, CLK_GATE_ASPEED,
> > "usbuartclk-gate", NULL,
> > +              SCU1_CLK_STOP2, 12, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_CANCLK, CLK_GATE_ASPEED, "canclk-gate",
> > canclk,
> > +              SCU1_CLK_STOP2, 13, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_PCICLK, CLK_GATE_ASPEED, "pciclk-gate",
> > NULL,
> > +              SCU1_CLK_STOP2, 14, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_SLICLK, CLK_GATE_ASPEED, "soc1-sliclk-gate=
",
> > NULL,
> > +              SCU1_CLK_STOP2, 15, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_E2MCLK, CLK_GATE_ASPEED,
> > "soc1-e2m-gate", NULL,
> > +              SCU1_CLK_STOP2, 16, CLK_IS_CRITICAL),
> > +     GATE_CLK(SCU1_CLK_GATE_PORTCUSB2CLK, CLK_GATE_ASPEED,
> > "portcusb2-gate", NULL,
> > +              SCU1_CLK_STOP2, 17, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_PORTDUSB2CLK, CLK_GATE_ASPEED,
> > "portdusb2-gate", NULL,
> > +              SCU1_CLK_STOP2, 18, 0),
> > +     GATE_CLK(SCU1_CLK_GATE_LTPI1TXCLK, CLK_GATE_ASPEED,
> > "ltp1tx-gate", NULL,
> > +              SCU1_CLK_STOP2, 19, 0),
> > +};
> > +
> > +static struct clk_hw *ast2700_clk_hw_register_hpll(void __iomem *reg,
> > +                                                const char *name, cons=
t
> char *parent_name,
> > +                                                struct ast2700_clk_ctr=
l
> *clk_ctrl) {
> > +     unsigned int mult, div;
> > +     u32 val;
> > +
> > +     val =3D readl(clk_ctrl->base + SCU0_HWSTRAP1);
> > +     if ((readl(clk_ctrl->base) & REVISION_ID) && (val & BIT(3))) {
> > +             switch ((val & GENMASK(4, 2)) >> 2) {
> > +             case 2:
> > +                     return
> devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> > NULL,
> > +                                                            0, 1800 *
> HZ_PER_MHZ);
> > +             case 3:
> > +                     return
> devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> > NULL,
> > +                                                            0, 1700 *
> HZ_PER_MHZ);
> > +             case 6:
> > +                     return
> devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> > NULL,
> > +                                                            0, 1200 *
> HZ_PER_MHZ);
> > +             case 7:
> > +                     return
> devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> > NULL,
> > +                                                            0, 800 *
> HZ_PER_MHZ);
> > +             default:
> > +                     return ERR_PTR(-EINVAL);
> > +             }
> > +     } else if ((val & GENMASK(3, 2)) !=3D 0) {
> > +             switch ((val & GENMASK(3, 2)) >> 2) {
> > +             case 1:
> > +                     return
> devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> > NULL,
> > +                                                            0, 1900 *
> HZ_PER_MHZ);
> > +             case 2:
> > +                     return
> devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> > NULL,
> > +                                                            0, 1800 *
> HZ_PER_MHZ);
> > +             case 3:
> > +                     return
> devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> > NULL,
> > +                                                            0, 1700 *
> HZ_PER_MHZ);
> > +             default:
> > +                     return ERR_PTR(-EINVAL);
> > +             }
> > +     } else {
> > +             val =3D readl(reg);
> > +
> > +             if (val & BIT(24)) {
> > +                     /* Pass through mode */
> > +                     mult =3D 1;
> > +                     div =3D 1;
> > +             } else {
> > +                     u32 m =3D val & 0x1fff;
> > +                     u32 n =3D (val >> 13) & 0x3f;
> > +                     u32 p =3D (val >> 19) & 0xf;
> > +
> > +                     mult =3D (m + 1) / (2 * (n + 1));
> > +                     div =3D (p + 1);
> > +             }
> > +     }
> > +
> > +     return devm_clk_hw_register_fixed_factor(clk_ctrl->dev, name,
> > +parent_name, 0, mult, div); }
> > +
> > +static struct clk_hw *ast2700_clk_hw_register_pll(int clk_idx, void
> __iomem
> > *reg,
> > +                                               const char *name, const
> char *parent_name,
> > +                                               struct ast2700_clk_ctrl
> *clk_ctrl) {
> > +     int scu =3D clk_ctrl->clk_data->scu;
> > +     unsigned int mult, div;
> > +     u32 val =3D readl(reg);
> > +
> > +     if (val & BIT(24)) {
> > +             /* Pass through mode */
> > +             mult =3D 1;
> > +             div =3D 1;
> > +     } else {
> > +             u32 m =3D val & 0x1fff;
> > +             u32 n =3D (val >> 13) & 0x3f;
> > +             u32 p =3D (val >> 19) & 0xf;
> > +
> > +             if (scu) {
> > +                     mult =3D (m + 1) / (n + 1);
> > +                     div =3D (p + 1);
> > +             } else {
> > +                     if (clk_idx =3D=3D SCU0_CLK_MPLL) {
> > +                             mult =3D m / (n + 1);
> > +                             div =3D (p + 1);
> > +                     } else {
> > +                             mult =3D (m + 1) / (2 * (n + 1));
> > +                             div =3D (p + 1);
> > +                     }
> > +             }
> > +     }
> > +
> > +     return devm_clk_hw_register_fixed_factor(clk_ctrl->dev, name,
> > +parent_name, 0, mult, div); }
> > +
> > +static struct clk_hw *ast2700_clk_hw_register_dclk(void __iomem *reg,
> > const char *name,
> > +                                                struct ast2700_clk_ctr=
l
> *clk_ctrl) {
> > +     unsigned int mult, div, r, n;
> > +     u32 xdclk;
> > +     u32 val;
> > +
> > +     val =3D readl(clk_ctrl->base + 0x284);
> > +     if (val & BIT(29))
> > +             xdclk =3D 800 * HZ_PER_MHZ;
> > +     else
> > +             xdclk =3D 1000 * HZ_PER_MHZ;
> > +
> > +     val =3D readl(reg);
> > +     r =3D val & GENMASK(15, 0);
> > +     n =3D (val >> 16) & GENMASK(15, 0);
> > +     mult =3D r;
> > +     div =3D 2 * n;
> > +
> > +     return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,
> 0,
> > +(xdclk * mult) / div); }
> > +
> > +static struct clk_hw *ast2700_clk_hw_register_uartpll(void __iomem *re=
g,
> > +                                                   const char *name,
> const char
> > *parent_name,
> > +                                                   struct
> ast2700_clk_ctrl *clk_ctrl) {
> > +     unsigned int mult, div;
> > +     u32 val =3D readl(reg);
> > +     u32 r =3D val & 0xff;
> > +     u32 n =3D (val >> 8) & 0x3ff;
> > +
> > +     mult =3D r;
> > +     div =3D n * 2;
> > +
> > +     return devm_clk_hw_register_fixed_factor(clk_ctrl->dev, name,
> > +                                              parent_name, 0, mult,
> div);
> > +}
> > +
> > +static struct clk_hw *ast2700_clk_hw_register_misc(int clk_idx, void
> > __iomem *reg,
> > +                                                const char *name, cons=
t
> char *parent_name,
> > +                                                struct ast2700_clk_ctr=
l
> *clk_ctrl) {
> > +     u32 div =3D 0;
> > +
> > +     if (clk_idx =3D=3D SCU0_CLK_MPHY) {
> > +             div =3D readl(reg) + 1;
> > +     } else if (clk_idx =3D=3D SCU0_CLK_U2PHY_REFCLK) {
> > +             if (readl(clk_ctrl->base) & REVISION_ID)
> > +                     div =3D (GET_USB_REFCLK_DIV(readl(reg)) + 1) << 4=
;
> > +             else
> > +                     div =3D (GET_USB_REFCLK_DIV(readl(reg)) + 1) << 1=
;
> > +     } else {
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> > +     return devm_clk_hw_register_fixed_factor(clk_ctrl->dev, name,
> > +                                                parent_name, 0, 1, div=
);
> > +}
> > +
> > +static int ast2700_clk_is_enabled(struct clk_hw *hw) {
> > +     struct clk_gate *gate =3D to_clk_gate(hw);
> > +     u32 clk =3D BIT(gate->bit_idx);
> > +     u32 reg;
> > +
> > +     reg =3D readl(gate->reg);
> > +
> > +     return !(reg & clk);
> > +}
> > +
> > +static int ast2700_clk_enable(struct clk_hw *hw) {
> > +     struct clk_gate *gate =3D to_clk_gate(hw);
> > +     u32 clk =3D BIT(gate->bit_idx);
> > +
> > +     if (readl(gate->reg) & clk)
> > +             writel(clk, gate->reg + 0x04);
> > +
> > +     return 0;
> > +}
> > +
> > +static void ast2700_clk_disable(struct clk_hw *hw) {
> > +     struct clk_gate *gate =3D to_clk_gate(hw);
> > +     u32 clk =3D BIT(gate->bit_idx);
> > +
> > +     /* Clock is set to enable, so use write to set register */
> > +     writel(clk, gate->reg);
> > +}
> > +
> > +static const struct clk_ops ast2700_clk_gate_ops =3D {
> > +     .enable =3D ast2700_clk_enable,
> > +     .disable =3D ast2700_clk_disable,
> > +     .is_enabled =3D ast2700_clk_is_enabled,
> > +};
> > +
> > +static struct clk_hw *ast2700_clk_hw_register_gate(struct device *dev,
> const
> > char *name,
> > +                                                const struct
> clk_parent_data *parent,
> > +                                                void __iomem *reg, u8
> clock_idx,
> > +                                                unsigned long
> clk_gate_flags, spinlock_t
> > *lock) {
> > +     struct clk_gate *gate;
> > +     struct clk_hw *hw;
> > +     struct clk_init_data init;
> > +     int ret =3D -EINVAL;
> > +
> > +     gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> > +     if (!gate)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     init.name =3D name;
> > +     init.ops =3D &ast2700_clk_gate_ops;
> > +     init.flags =3D clk_gate_flags;
> > +     init.parent_names =3D parent ? &parent->name : NULL;
> > +     init.num_parents =3D parent ? 1 : 0;
> > +
> > +     gate->reg =3D reg;
> > +     gate->bit_idx =3D clock_idx;
> > +     gate->flags =3D 0;
> > +     gate->lock =3D lock;
> > +     gate->hw.init =3D &init;
> > +
> > +     hw =3D &gate->hw;
> > +     ret =3D clk_hw_register(dev, hw);
> > +     if (ret) {
> > +             kfree(gate);
> > +             hw =3D ERR_PTR(ret);
> > +     }
> > +
> > +     return hw;
> > +}
> > +
> > +static void ast2700_soc1_configure_i3c_clk(struct ast2700_clk_ctrl
> > +*clk_ctrl) {
> > +     if (readl(clk_ctrl->base + SCU1_REVISION_ID) & REVISION_ID)
> > +             /* I3C 250MHz =3D HPLL/4 */
> > +             writel((readl(clk_ctrl->base + SCU1_CLK_SEL2) &
> > +                     ~SCU1_CLK_I3C_DIV_MASK) |
> > +                            FIELD_PREP(SCU1_CLK_I3C_DIV_MASK,
> > +                                       SCU1_CLK_I3C_DIV(4)),
> > +                    clk_ctrl->base + SCU1_CLK_SEL2); }
> > +
> > +static int ast2700_soc_clk_probe(struct platform_device *pdev) {
> > +     const struct ast2700_clk_data *clk_data;
> > +     struct clk_hw_onecell_data *clk_hw_data;
> > +     struct ast2700_clk_ctrl *clk_ctrl;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct auxiliary_device *adev;
> > +     void __iomem *clk_base;
> > +     struct clk_hw **hws;
> > +     char *reset_name;
> > +     int ret;
> > +     int i;
> > +
> > +     clk_ctrl =3D devm_kzalloc(dev, sizeof(*clk_ctrl), GFP_KERNEL);
> > +     if (!clk_ctrl)
> > +             return -ENOMEM;
> > +     clk_ctrl->dev =3D dev;
> > +     dev_set_drvdata(&pdev->dev, clk_ctrl);
> > +
> > +     spin_lock_init(&clk_ctrl->lock);
> > +
> > +     clk_base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(clk_base))
> > +             return PTR_ERR(clk_base);
> > +
> > +     clk_ctrl->base =3D clk_base;
> > +
> > +     clk_data =3D device_get_match_data(dev);
> > +     if (!clk_data)
> > +             return -ENODEV;
> > +
> > +     clk_ctrl->clk_data =3D clk_data;
> > +     reset_name =3D devm_kasprintf(dev, GFP_KERNEL, "reset%d",
> > +clk_data->scu);
> > +
> > +     clk_hw_data =3D devm_kzalloc(dev, struct_size(clk_hw_data, hws,
> > clk_data->nr_clks),
> > +                                GFP_KERNEL);
> > +     if (!clk_hw_data)
> > +             return -ENOMEM;
> > +
> > +     clk_hw_data->num =3D clk_data->nr_clks;
> > +     hws =3D clk_hw_data->hws;
> > +
> > +     if (clk_data->scu)
> > +             ast2700_soc1_configure_i3c_clk(clk_ctrl);
> > +
> > +     for (i =3D 0; i < clk_data->nr_clks; i++) {
> > +             const struct ast2700_clk_info *clk =3D
> &clk_data->clk_info[i];
> > +             void __iomem *reg;
> > +
> > +             if (clk->type =3D=3D CLK_FIXED) {
> > +                     const struct ast2700_clk_fixed_rate_data
> *fixed_rate =3D
> > +&clk->data.rate;
> > +
> > +                     hws[i] =3D devm_clk_hw_register_fixed_rate(dev,
> clk->name,
> > NULL, 0,
> > +
> fixed_rate->fixed_rate);
> > +             } else if (clk->type =3D=3D CLK_FIXED_FACTOR) {
> > +                     const struct ast2700_clk_fixed_factor_data *facto=
r
> =3D
> > +&clk->data.factor;
> > +
> > +                     hws[i] =3D devm_clk_hw_register_fixed_factor(dev,
> clk->name,
> > +
> factor->parent->name,
> > +                                                                0,
> factor->mult, factor->div);
> > +             } else if (clk->type =3D=3D DCLK_FIXED) {
> > +                     const struct ast2700_clk_pll_data *pll =3D
> &clk->data.pll;
> > +
> > +                     reg =3D clk_ctrl->base + pll->reg;
> > +                     hws[i] =3D ast2700_clk_hw_register_dclk(reg,
> clk->name,
> > clk_ctrl);
> > +             } else if (clk->type =3D=3D CLK_HPLL) {
> > +                     const struct ast2700_clk_pll_data *pll =3D
> &clk->data.pll;
> > +
> > +                     reg =3D clk_ctrl->base + pll->reg;
> > +                     hws[i] =3D ast2700_clk_hw_register_hpll(reg,
> clk->name,
> > +
>  pll->parent->name, clk_ctrl);
> > +             } else if (clk->type =3D=3D CLK_PLL) {
> > +                     const struct ast2700_clk_pll_data *pll =3D
> &clk->data.pll;
> > +
> > +                     reg =3D clk_ctrl->base + pll->reg;
> > +                     hws[i] =3D ast2700_clk_hw_register_pll(i, reg,
> clk->name,
> > +
> pll->parent->name, clk_ctrl);
> > +             } else if (clk->type =3D=3D CLK_UART_PLL) {
> > +                     const struct ast2700_clk_pll_data *pll =3D
> &clk->data.pll;
> > +
> > +                     reg =3D clk_ctrl->base + pll->reg;
> > +                     hws[i] =3D ast2700_clk_hw_register_uartpll(reg,
> clk->name,
> > +
> pll->parent->name, clk_ctrl);
> > +             } else if (clk->type =3D=3D CLK_MUX) {
> > +                     const struct ast2700_clk_mux_data *mux =3D
> &clk->data.mux;
> > +
> > +                     reg =3D clk_ctrl->base + mux->reg;
> > +                     hws[i] =3D
> devm_clk_hw_register_mux_parent_data_table(dev,
> > clk->name,
> > +
>  mux->parents,
> > +
>  mux->num_parents, 0,
> > +
>  reg, mux->bit_shift,
> > +
>  mux->bit_width, 0,
> > +
>  NULL, &clk_ctrl->lock);
> > +             } else if (clk->type =3D=3D CLK_MISC) {
> > +                     const struct ast2700_clk_pll_data *misc =3D
> &clk->data.pll;
> > +
> > +                     reg =3D clk_ctrl->base + misc->reg;
> > +                     hws[i] =3D ast2700_clk_hw_register_misc(i, reg,
> clk->name,
> > +
>  misc->parent->name, clk_ctrl);
> > +             } else if (clk->type =3D=3D CLK_DIVIDER) {
> > +                     const struct ast2700_clk_div_data *div =3D
> &clk->data.div;
> > +
> > +                     reg =3D clk_ctrl->base + div->reg;
> > +                     hws[i] =3D devm_clk_hw_register_divider_table(dev=
,
> clk->name,
> > +
>  div->parent->name, 0,
> > +                                                                 reg,
> div->bit_shift,
> > +
>  div->bit_width, 0,
> > +
>  div->div_table,
> > +
>  &clk_ctrl->lock);
> > +             } else if (clk->type =3D=3D CLK_GATE_ASPEED) {
> > +                     const struct ast2700_clk_gate_data *gate =3D
> &clk->data.gate;
> > +
> > +                     reg =3D clk_ctrl->base + gate->reg;
> > +                     hws[i] =3D ast2700_clk_hw_register_gate(dev,
> clk->name,
> > gate->parent,
> > +                                                           reg,
> gate->bit, gate->flags,
> > +
>  &clk_ctrl->lock);
> > +
> > +             } else {
> > +                     const struct ast2700_clk_gate_data *gate =3D
> &clk->data.gate;
> > +
> > +                     reg =3D clk_ctrl->base + gate->reg;
> > +                     hws[i] =3D devm_clk_hw_register_gate_parent_data(=
dev,
> > clk->name, gate->parent,
> > +                                                                    0,
> reg, clk->clk_idx, 0,
> > +
> &clk_ctrl->lock);
> > +             }
> > +
> > +             if (IS_ERR(hws[i]))
> > +                     return PTR_ERR(hws[i]);
> > +     }
> > +
> > +     ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> > clk_hw_data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     adev =3D devm_auxiliary_device_create(dev, reset_name, (__force v=
oid
> > *)clk_base);
> > +     if (!adev)
> > +             return -ENODEV;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct ast2700_clk_data ast2700_clk0_data =3D {
> > +     .scu =3D 0,
> > +     .nr_clks =3D ARRAY_SIZE(ast2700_scu0_clk_info),
> > +     .clk_info =3D ast2700_scu0_clk_info,
> > +};
> > +
> > +static const struct ast2700_clk_data ast2700_clk1_data =3D {
> > +     .scu =3D 1,
> > +     .nr_clks =3D ARRAY_SIZE(ast2700_scu1_clk_info),
> > +     .clk_info =3D ast2700_scu1_clk_info,
> > +};
> > +
> > +static const struct of_device_id ast2700_scu_match[] =3D {
> > +     { .compatible =3D "aspeed,ast2700-scu0", .data =3D &ast2700_clk0_=
data
> },
> > +     { .compatible =3D "aspeed,ast2700-scu1", .data =3D &ast2700_clk1_=
data
> },
> > +     { /* sentinel */ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, ast2700_scu_match);
> > +
> > +static struct platform_driver ast2700_scu_driver =3D {
> > +     .probe =3D ast2700_soc_clk_probe,
> > +     .driver =3D {
> > +             .name =3D "clk-ast2700",
> > +             .of_match_table =3D ast2700_scu_match,
> > +     },
> > +};
> > +
> > +static int __init clk_ast2700_init(void) {
> > +     return platform_driver_register(&ast2700_scu_driver);
> > +}
> > +arch_initcall(clk_ast2700_init);
> > --
> > 2.34.1
>
>

--000000000000c23214063ba8b02c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Kernel Maintainers,<div>I hope this=C2=A0email finds =
you well.</div><div><br></div><div>If I may ask, what do we need to do to=
=C2=A0move this patch forward?</div><div><br></div><div>Thank you for your =
help,</div><div>Mo</div></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 8, 2025 at 11:41=
=E2=80=AFPM Ryan Chen &lt;<a href=3D"mailto:ryan_chen@aspeedtech.com">ryan_=
chen@aspeedtech.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Hello Stephen,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sorry to bother you, do you have time to review=
 this patch?<br>
Ryan<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Ryan Chen &lt;<a href=3D"mailto:ryan_chen@aspeedtech.com" target=
=3D"_blank">ryan_chen@aspeedtech.com</a>&gt;<br>
&gt; Sent: Tuesday, July 8, 2025 1:29 PM<br>
&gt; To: Ryan Chen &lt;<a href=3D"mailto:ryan_chen@aspeedtech.com" target=
=3D"_blank">ryan_chen@aspeedtech.com</a>&gt;; Michael Turquette<br>
&gt; &lt;<a href=3D"mailto:mturquette@baylibre.com" target=3D"_blank">mturq=
uette@baylibre.com</a>&gt;; Stephen Boyd &lt;<a href=3D"mailto:sboyd@kernel=
.org" target=3D"_blank">sboyd@kernel.org</a>&gt;; Philipp Zabel<br>
&gt; &lt;<a href=3D"mailto:p.zabel@pengutronix.de" target=3D"_blank">p.zabe=
l@pengutronix.de</a>&gt;; Joel Stanley &lt;<a href=3D"mailto:joel@jms.id.au=
" target=3D"_blank">joel@jms.id.au</a>&gt;; Andrew Jeffery<br>
&gt; &lt;<a href=3D"mailto:andrew@codeconstruct.com.au" target=3D"_blank">a=
ndrew@codeconstruct.com.au</a>&gt;; Rob Herring &lt;<a href=3D"mailto:robh@=
kernel.org" target=3D"_blank">robh@kernel.org</a>&gt;; Krzysztof<br>
&gt; Kozlowski &lt;<a href=3D"mailto:krzk%2Bdt@kernel.org" target=3D"_blank=
">krzk+dt@kernel.org</a>&gt;; Conor Dooley &lt;<a href=3D"mailto:conor%2Bdt=
@kernel.org" target=3D"_blank">conor+dt@kernel.org</a>&gt;;<br>
&gt; <a href=3D"mailto:linux-clk@vger.kernel.org" target=3D"_blank">linux-c=
lk@vger.kernel.org</a>; <a href=3D"mailto:linux-arm-kernel@lists.infradead.=
org" target=3D"_blank">linux-arm-kernel@lists.infradead.org</a>;<br>
&gt; <a href=3D"mailto:linux-aspeed@lists.ozlabs.org" target=3D"_blank">lin=
ux-aspeed@lists.ozlabs.org</a>; <a href=3D"mailto:devicetree@vger.kernel.or=
g" target=3D"_blank">devicetree@vger.kernel.org</a>;<br>
&gt; <a href=3D"mailto:linux-kernel@vger.kernel.org" target=3D"_blank">linu=
x-kernel@vger.kernel.org</a>; Mo Elbadry &lt;<a href=3D"mailto:elbadrym@goo=
gle.com" target=3D"_blank">elbadrym@google.com</a>&gt;; Rom<br>
&gt; Lemarchand &lt;<a href=3D"mailto:romlem@google.com" target=3D"_blank">=
romlem@google.com</a>&gt;; William Kennington &lt;<a href=3D"mailto:wak@goo=
gle.com" target=3D"_blank">wak@google.com</a>&gt;;<br>
&gt; Yuxiao Zhang &lt;<a href=3D"mailto:yuxiaozhang@google.com" target=3D"_=
blank">yuxiaozhang@google.com</a>&gt;; <a href=3D"mailto:wthai@nvidia.com" =
target=3D"_blank">wthai@nvidia.com</a>;<br>
&gt; <a href=3D"mailto:leohu@nvidia.com" target=3D"_blank">leohu@nvidia.com=
</a>; <a href=3D"mailto:dkodihalli@nvidia.com" target=3D"_blank">dkodihalli=
@nvidia.com</a>; <a href=3D"mailto:spuranik@nvidia.com" target=3D"_blank">s=
puranik@nvidia.com</a><br>
&gt; Subject: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver<br>
&gt; <br>
&gt; Add AST2700 clock controller driver and also use axiliary device frame=
work<br>
&gt; register the reset controller driver.<br>
&gt; Due to clock and reset using the same register region.<br>
&gt; <br>
&gt; Signed-off-by: Ryan Chen &lt;<a href=3D"mailto:ryan_chen@aspeedtech.co=
m" target=3D"_blank">ryan_chen@aspeedtech.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/clk/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 8 +=
<br>
&gt;=C2=A0 drivers/clk/Makefile=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 drivers/clk/clk-ast2700.c | 1138<br>
&gt; +++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 3 files changed, 1147 insertions(+)<br>
&gt;=C2=A0 create mode 100644 drivers/clk/clk-ast2700.c<br>
&gt; <br>
&gt; diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig index<br>
&gt; 19c1ed280fd7..10b67370f65d 100644<br>
&gt; --- a/drivers/clk/Kconfig<br>
&gt; +++ b/drivers/clk/Kconfig<br>
&gt; @@ -288,6 +288,14 @@ config COMMON_CLK_ASPEED<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The G4 and G5 series, including the a=
st2400 and ast2500, are<br>
&gt; supported<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0by this driver.<br>
&gt; <br>
&gt; +config COMMON_CLK_AST2700<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool &quot;Clock driver for AST2700 SoC&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on ARCH_ASPEED || COMPILE_TEST<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0This driver provides support for clock on =
AST2700 SoC.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0The driver is responsible for managing the=
 various clocks required<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0by the peripherals and cores within the AS=
T2700.<br>
&gt; +<br>
&gt;=C2=A0 config COMMON_CLK_S2MPS11<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;Clock driver for S2MPS1X/S5M8=
767 MFD&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on MFD_SEC_CORE || COMPILE_TEST diff=
 --git<br>
&gt; a/drivers/clk/Makefile b/drivers/clk/Makefile index<br>
&gt; 42867cd37c33..3d911b81149c 100644<br>
&gt; --- a/drivers/clk/Makefile<br>
&gt; +++ b/drivers/clk/Makefile<br>
&gt; @@ -63,6 +63,7 @@ obj-$(CONFIG_COMMON_CLK_FSL_SAI)=C2=A0 =C2=A0 +=3D c=
lk-fsl-sai.o<br>
&gt;=C2=A0 obj-$(CONFIG_COMMON_CLK_GEMINI)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 +=3D clk-gemini.o<br>
&gt;=C2=A0 obj-$(CONFIG_COMMON_CLK_ASPEED)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 +=3D clk-aspeed.o<br>
&gt;=C2=A0 obj-$(CONFIG_MACH_ASPEED_G6)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=
=3D clk-ast2600.o<br>
&gt; +obj-$(CONFIG_COMMON_CLK_AST2700)=C2=A0 =C2=A0 =C2=A0+=3D clk-ast2700.=
o<br>
&gt;=C2=A0 obj-$(CONFIG_ARCH_HIGHBANK)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=
=3D clk-highbank.o<br>
&gt;=C2=A0 obj-$(CONFIG_CLK_HSDK)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D clk-hsdk-pll.o<br>
&gt;=C2=A0 obj-$(CONFIG_COMMON_CLK_K210)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 +=3D clk-k210.o<br>
&gt; diff --git a/drivers/clk/clk-ast2700.c b/drivers/clk/clk-ast2700.c new=
 file mode<br>
&gt; 100644 index 000000000000..c6d77e3f4ace<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/clk/clk-ast2700.c<br>
&gt; @@ -0,0 +1,1138 @@<br>
&gt; +// SPDX-License-Identifier: GPL-2.0<br>
&gt; +/*<br>
&gt; + * Copyright (c) 2024 ASPEED Technology Inc.<br>
&gt; + * Author: Ryan Chen &lt;<a href=3D"mailto:ryan_chen@aspeedtech.com" =
target=3D"_blank">ryan_chen@aspeedtech.com</a>&gt;=C2=A0 */ #include<br>
&gt; +&lt;linux/auxiliary_bus.h&gt; #include &lt;linux/bitfield.h&gt; #incl=
ude<br>
&gt; +&lt;linux/clk-provider.h&gt; #include &lt;linux/io.h&gt; #include<br>
&gt; +&lt;linux/mod_devicetable.h&gt; #include &lt;linux/of_platform.h&gt; =
#include<br>
&gt; +&lt;linux/platform_device.h&gt; #include &lt;linux/slab.h&gt; #includ=
e<br>
&gt; +&lt;linux/units.h&gt;<br>
&gt; +<br>
&gt; +#include &lt;dt-bindings/clock/aspeed,ast2700-scu.h&gt;<br>
&gt; +<br>
&gt; +#define SCU_CLK_12MHZ=C2=A0 =C2=A0 =C2=A0 =C2=A0 (12 * HZ_PER_MHZ)<br=
>
&gt; +#define SCU_CLK_24MHZ=C2=A0 =C2=A0 =C2=A0 =C2=A0 (24 * HZ_PER_MHZ)<br=
>
&gt; +#define SCU_CLK_25MHZ=C2=A0 =C2=A0 =C2=A0 =C2=A0 (25 * HZ_PER_MHZ)<br=
>
&gt; +#define SCU_CLK_192MHZ=C2=A0 =C2=A0 =C2=A0 =C2=A0(192 * HZ_PER_MHZ)<b=
r>
&gt; +<br>
&gt; +/* SOC0 */<br>
&gt; +#define SCU0_HWSTRAP1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x010<br>
&gt; +#define SCU0_CLK_STOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x240<br>
&gt; +#define SCU0_CLK_SEL1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x280<br>
&gt; +#define SCU0_CLK_SEL2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x284<br>
&gt; +#define GET_USB_REFCLK_DIV(x)=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((GENMASK(23=
, 20) &amp; (x)) &gt;&gt; 20)<br>
&gt; +#define UART_DIV13_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 BIT(30)<br>
&gt; +#define SCU0_HPLL_PARAM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x300<br>
&gt; +#define SCU0_DPLL_PARAM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x308<br>
&gt; +#define SCU0_MPLL_PARAM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x310<br>
&gt; +#define SCU0_D0CLK_PARAM=C2=A0 =C2=A0 =C2=A00x320<br>
&gt; +#define SCU0_D1CLK_PARAM=C2=A0 =C2=A0 =C2=A00x330<br>
&gt; +#define SCU0_CRT0CLK_PARAM=C2=A0 =C2=A00x340<br>
&gt; +#define SCU0_CRT1CLK_PARAM=C2=A0 =C2=A00x350<br>
&gt; +#define SCU0_MPHYCLK_PARAM=C2=A0 =C2=A00x360<br>
&gt; +<br>
&gt; +/* SOC1 */<br>
&gt; +#define SCU1_REVISION_ID=C2=A0 =C2=A0 =C2=A00x0<br>
&gt; +#define REVISION_ID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GENMASK(23, 16)=
<br>
&gt; +#define SCU1_CLK_STOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x240<br>
&gt; +#define SCU1_CLK_STOP2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x260<br>
&gt; +#define SCU1_CLK_SEL1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x280<br>
&gt; +#define SCU1_CLK_SEL2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x284<br>
&gt; +#define SCU1_CLK_I3C_DIV_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 GENMASK(25, =
23)<br>
&gt; +#define SCU1_CLK_I3C_DIV(n)=C2=A0 ((n) - 1)<br>
&gt; +#define UXCLK_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GENMASK(1,=
 0)<br>
&gt; +#define HUXCLK_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GENMASK(4, 3)<b=
r>
&gt; +#define SCU1_HPLL_PARAM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x300<br>
&gt; +#define SCU1_APLL_PARAM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x310<br>
&gt; +#define SCU1_DPLL_PARAM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x320<br>
&gt; +#define SCU1_UXCLK_CTRL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x330<br>
&gt; +#define SCU1_HUXCLK_CTRL=C2=A0 =C2=A0 =C2=A00x334<br>
&gt; +#define SCU1_MAC12_CLK_DLY=C2=A0 =C2=A00x390<br>
&gt; +#define SCU1_MAC12_CLK_DLY_100M=C2=A0 =C2=A0 =C2=A0 0x394<br>
&gt; +#define SCU1_MAC12_CLK_DLY_10M=C2=A0 =C2=A0 =C2=A0 =C2=A00x398<br>
&gt; +<br>
&gt; +enum ast2700_clk_type {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CLK_MUX,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CLK_PLL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CLK_HPLL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CLK_GATE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CLK_MISC,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CLK_FIXED,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DCLK_FIXED,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CLK_DIVIDER,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CLK_UART_PLL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CLK_FIXED_FACTOR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CLK_GATE_ASPEED,<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct ast2700_clk_fixed_factor_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct clk_parent_data *parent;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int mult;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int div;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct ast2700_clk_gate_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct clk_parent_data *parent;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 flags;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 bit;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct ast2700_clk_mux_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct clk_parent_data *parents;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int num_parents;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 bit_shift;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 bit_width;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 reg;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct ast2700_clk_div_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct clk_div_table *div_table;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct clk_parent_data *parent;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 bit_shift;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 bit_width;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 reg;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct ast2700_clk_pll_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct clk_parent_data *parent;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 reg;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct ast2700_clk_fixed_rate_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned long fixed_rate;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct ast2700_clk_info {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const char *name;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 clk_idx;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 type;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0union {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ast2700_clk_fi=
xed_factor_data factor;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ast2700_clk_fi=
xed_rate_data rate;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ast2700_clk_ga=
te_data gate;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ast2700_clk_di=
v_data div;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ast2700_clk_pl=
l_data pll;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ast2700_clk_mu=
x_data mux;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} data;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct ast2700_clk_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct ast2700_clk_info const *clk_info;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int nr_clks;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const int scu;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct ast2700_clk_ctrl {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct ast2700_clk_data *clk_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spinlock_t lock; /* clk lock */<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct clk_div_table ast2700_rgmii_div_table[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x0, 4 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x1, 4 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x2, 6 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x3, 8 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x4, 10 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x5, 12 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x6, 14 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x7, 16 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct clk_div_table ast2700_rmii_div_table[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x0, 8 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x1, 8 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x2, 12 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x3, 16 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x4, 20 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x5, 24 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x6, 28 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x7, 32 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct clk_div_table ast2700_clk_div_table[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x0, 2 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x1, 2 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x2, 3 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x3, 4 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x4, 5 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x5, 6 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x6, 7 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x7, 8 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct clk_div_table ast2700_clk_div_table2[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x0, 2 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x1, 4 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x2, 6 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x3, 8 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x4, 10 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x5, 12 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x6, 14 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x7, 16 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct clk_div_table ast2700_hclk_div_table[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x0, 6 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x1, 5 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x2, 4 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x3, 7 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct clk_div_table ast2700_clk_uart_div_table[] =3D {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x0, 1 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0x1, 13 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ 0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct clk_parent_data soc0_clkin[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-clkin&quot;, .name =3D =
&quot;soc0-clkin&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data pspclk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;pspclk&quot;, .name =3D &quo=
t;pspclk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data mphysrc[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;mphysrc&quot;, .name =3D &qu=
ot;mphysrc&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data u2phy_refclksrc[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;u2phy_refclksrc&quot;, .name=
 =3D &quot;u2phy_refclksrc&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data soc0_hpll[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-hpll&quot;, .name =3D &=
quot;soc0-hpll&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data soc0_mpll[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-mpll&quot;, .name =3D &=
quot;soc0-mpll&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data axi0clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;axi0clk&quot;, .name =3D &qu=
ot;axi0clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data soc0_ahbmux[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-ahbmux&quot;, .name =3D=
 &quot;soc0-ahbmux&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data soc0_uartclk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-uartclk&quot;, .name =
=3D &quot;soc0-uartclk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data emmcclk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;emmcclk&quot;, .name =3D &qu=
ot;emmcclk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data emmcsrc_mux[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;emmcsrc-mux&quot;, .name =3D=
 &quot;emmcsrc-mux&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data soc1_clkin[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc1-clkin&quot;, .name =3D =
&quot;soc1-clkin&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data soc1_hpll[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc1-hpll&quot;, .name =3D &=
quot;soc1-hpll&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data soc1_apll[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc1-apll&quot;, .name =3D &=
quot;soc1-apll&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data sdclk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;sdclk&quot;, .name =3D &quot=
;sdclk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data sdclk_mux[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;sdclk-mux&quot;, .name =3D &=
quot;sdclk-mux&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data huartxclk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;huartxclk&quot;, .name =3D &=
quot;huartxclk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uxclk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uxclk&quot;, .name =3D &quot=
;uxclk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data huxclk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;huxclk&quot;, .name =3D &quo=
t;huxclk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart0clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart0clk&quot;, .name =3D &q=
uot;uart0clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart1clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart1clk&quot;, .name =3D &q=
uot;uart1clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart2clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart2clk&quot;, .name =3D &q=
uot;uart2clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart3clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart3clk&quot;, .name =3D &q=
uot;uart3clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart5clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart5clk&quot;, .name =3D &q=
uot;uart5clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart4clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart4clk&quot;, .name =3D &q=
uot;uart4clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart6clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart6clk&quot;, .name =3D &q=
uot;uart6clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart7clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart7clk&quot;, .name =3D &q=
uot;uart7clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart8clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart8clk&quot;, .name =3D &q=
uot;uart8clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart9clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart9clk&quot;, .name =3D &q=
uot;uart9clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart10clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart10clk&quot;, .name =3D &=
quot;uart10clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart11clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart11clk&quot;, .name =3D &=
quot;uart11clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart12clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart12clk&quot;, .name =3D &=
quot;uart12clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart13clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart13clk&quot;, .name =3D &=
quot;uart13clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart14clk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uart14clk&quot;, .name =3D &=
quot;uart14clk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data soc1_i3c[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc1-i3c&quot;, .name =3D &q=
uot;soc1-i3c&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data canclk[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;canclk&quot;, .name =3D &quo=
t;canclk&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data rmii[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;rmii&quot;, .name =3D &quot;=
rmii&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data hclk_clk_sels[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-hpll&quot;, .name =3D &=
quot;soc0-hpll&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-mpll&quot;, .name =3D &=
quot;soc0-mpll&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data mhpll_clk_sels[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-mpll&quot;, .name =3D &=
quot;soc0-mpll&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-hpll&quot;, .name =3D &=
quot;soc0-hpll&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data mphy_clk_sels[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-mpll&quot;, .name =3D &=
quot;soc0-mpll&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-hpll&quot;, .name =3D &=
quot;soc0-hpll&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-dpll&quot;, .name =3D &=
quot;soc0-dpll&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-clk192Mhz&quot;, .name =
=3D &quot;soc0-clk192Mhz&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data psp_clk_sels[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-mpll&quot;, .name =3D &=
quot;soc0-mpll&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-hpll&quot;, .name =3D &=
quot;soc0-hpll&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-hpll&quot;, .name =3D &=
quot;soc0-hpll&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-hpll&quot;, .name =3D &=
quot;soc0-hpll&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-mpll_div2&quot;, .name =
=3D &quot;soc0-mpll_div2&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-hpll_div2&quot;, .name =
=3D &quot;soc0-hpll_div2&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-hpll&quot;, .name =3D &=
quot;soc0-hpll&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-hpll&quot;, .name =3D &=
quot;soc0-hpll&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uart_clk_sels[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-clk24Mhz&quot;, .name =
=3D &quot;soc0-clk24Mhz&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-clk192Mhz&quot;, .name =
=3D &quot;soc0-clk192Mhz&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data emmc_clk_sels[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-mpll_div4&quot;, .name =
=3D &quot;soc0-mpll_div4&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc0-hpll_div4&quot;, .name =
=3D &quot;soc0-hpll_div4&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data sdio_clk_sels[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc1-hpll&quot;, .name =3D &=
quot;soc1-hpll&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc1-apll&quot;, .name =3D &=
quot;soc1-apll&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data ux_clk_sels[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc1-apll_div4&quot;, .name =
=3D &quot;soc1-apll_div4&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc1-apll_div2&quot;, .name =
=3D &quot;soc1-apll_div2&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc1-apll&quot;, .name =3D &=
quot;soc1-apll&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;soc1-hpll&quot;, .name =3D &=
quot;soc1-hpll&quot; }, };<br>
&gt; +<br>
&gt; +static const struct clk_parent_data uartx_clk_sels[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;uartxclk&quot;, .name =3D &q=
uot;uartxclk&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .fw_name =3D &quot;huartxclk&quot;, .name =3D &=
quot;huartxclk&quot; }, };<br>
&gt; +<br>
&gt; +#define FIXED_CLK(_id, _name, _rate) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[_id] =3D { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D CLK_FIXED, =
\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D _name, \<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D { .rate =3D=
 { .fixed_rate =3D _rate, } }, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +#define PLL_CLK(_id, _type, _name, _parent, _reg) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[_id] =3D { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D _type, \<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D _name, \<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D { .pll =3D =
{ .parent =3D _parent, .reg =3D _reg, } }, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +#define MUX_CLK(_id, _name, _parents, _num_parents, _reg, _shift, _wi=
dth)<br>
&gt; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[_id] =3D { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D CLK_MUX, \<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D _name, \<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.mux =3D { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.parents =3D _parents, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.num_parents =3D _num_parents, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.reg =3D _reg, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.bit_shift =3D _shift, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.bit_width =3D _width, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +#define DIVIDER_CLK(_id, _name, _parent, _reg, _shift, _width, _div_t=
able) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[_id] =3D { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D CLK_DIVIDER=
, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D _name, \<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.div =3D { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent =3D _parent, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.reg =3D _reg, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.bit_shift =3D _shift, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.bit_width =3D _width, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.div_table =3D _div_table, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +#define FIXED_FACTOR_CLK(_id, _name, _parent, _mult, _div) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[_id] =3D { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D CLK_FIXED_F=
ACTOR, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D _name, \<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D { .factor =
=3D { .parent =3D _parent, .mult =3D _mult, .div =3D _div, } }, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +#define GATE_CLK(_id, _type, _name, _parent, _reg, _bit, _flags) \<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0[_id] =3D { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D _type, \<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D _name, \<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.gate =3D { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent =3D _parent, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.reg =3D _reg, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.bit =3D _bit, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D _flags, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +static const struct ast2700_clk_info ast2700_scu0_clk_info[] __initco=
nst =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_CLK(SCU0_CLKIN, &quot;soc0-clkin&quot;, SCU=
_CLK_25MHZ),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_CLK(SCU0_CLK_24M, &quot;soc0-clk24Mhz&quot;=
, SCU_CLK_24MHZ),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_CLK(SCU0_CLK_192M, &quot;soc0-clk192Mhz&quo=
t;, SCU_CLK_192MHZ),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_CLK(SCU0_CLK_U2PHY_CLK12M, &quot;u2phy_clk1=
2m&quot;,<br>
&gt; SCU_CLK_12MHZ),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PLL_CLK(SCU0_CLK_HPLL, CLK_HPLL, &quot;soc0-hpll&=
quot;, soc0_clkin,<br>
&gt; SCU0_HPLL_PARAM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PLL_CLK(SCU0_CLK_DPLL, CLK_PLL, &quot;soc0-dpll&q=
uot;, soc0_clkin,<br>
&gt; SCU0_DPLL_PARAM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PLL_CLK(SCU0_CLK_MPLL, CLK_PLL, &quot;soc0-mpll&q=
uot;, soc0_clkin,<br>
&gt; SCU0_MPLL_PARAM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PLL_CLK(SCU0_CLK_D0, DCLK_FIXED, &quot;d0clk&quot=
;, NULL,<br>
&gt; SCU0_D0CLK_PARAM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PLL_CLK(SCU0_CLK_D1, DCLK_FIXED, &quot;d1clk&quot=
;, NULL,<br>
&gt; SCU0_D1CLK_PARAM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PLL_CLK(SCU0_CLK_CRT0, DCLK_FIXED, &quot;crt0clk&=
quot;, NULL,<br>
&gt; SCU0_CRT0CLK_PARAM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PLL_CLK(SCU0_CLK_CRT1, DCLK_FIXED, &quot;crt1clk&=
quot;, NULL,<br>
&gt; SCU0_CRT1CLK_PARAM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PLL_CLK(SCU0_CLK_MPHY, CLK_MISC, &quot;mphyclk&qu=
ot;, mphysrc,<br>
&gt; SCU0_MPHYCLK_PARAM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PLL_CLK(SCU0_CLK_U2PHY_REFCLK, CLK_MISC, &quot;u2=
phy_refclk&quot;,<br>
&gt; u2phy_refclksrc, SCU0_CLK_SEL2),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_FACTOR_CLK(SCU0_CLK_HPLL_DIV2, &quot;soc0-h=
pll_div2&quot;, soc0_hpll, 1,<br>
&gt; 2),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_FACTOR_CLK(SCU0_CLK_HPLL_DIV4, &quot;soc0-h=
pll_div4&quot;, soc0_hpll, 1,<br>
&gt; 4),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_FACTOR_CLK(SCU0_CLK_MPLL_DIV2, &quot;soc0-m=
pll_div2&quot;, soc0_mpll,<br>
&gt; 1, 2),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_FACTOR_CLK(SCU0_CLK_MPLL_DIV4, &quot;soc0-m=
pll_div4&quot;, soc0_mpll,<br>
&gt; 1, 4),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_FACTOR_CLK(SCU0_CLK_MPLL_DIV8, &quot;soc0-m=
pll_div8&quot;, soc0_mpll,<br>
&gt; 1, 8),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_FACTOR_CLK(SCU0_CLK_AXI0, &quot;axi0clk&quo=
t;, pspclk, 1, 2),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_FACTOR_CLK(SCU0_CLK_AXI1, &quot;axi1clk&quo=
t;, soc0_mpll, 1, 4),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DIVIDER_CLK(SCU0_CLK_AHB, &quot;soc0-ahb&quot;, s=
oc0_ahbmux,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU0_HW=
STRAP1, 5, 2, ast2700_hclk_div_table),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DIVIDER_CLK(SCU0_CLK_EMMC, &quot;emmcclk&quot;, e=
mmcsrc_mux,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU0_CL=
K_SEL1, 12, 3, ast2700_clk_div_table2),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DIVIDER_CLK(SCU0_CLK_APB, &quot;soc0-apb&quot;, a=
xi0clk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU0_CL=
K_SEL1, 23, 3, ast2700_clk_div_table2),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DIVIDER_CLK(SCU0_CLK_UART4, &quot;uart4clk&quot;,=
 soc0_uartclk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU0_CL=
K_SEL2, 30, 1, ast2700_clk_uart_div_table),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DIVIDER_CLK(SCU0_CLK_HPLL_DIV_AHB, &quot;soc0-hpl=
l-ahb&quot;, soc0_hpll,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU0_HW=
STRAP1, 5, 2, ast2700_hclk_div_table),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DIVIDER_CLK(SCU0_CLK_MPLL_DIV_AHB, &quot;soc0-mpl=
l-ahb&quot;, soc0_mpll,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU0_HW=
STRAP1, 5, 2, ast2700_hclk_div_table),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU0_CLK_PSP, &quot;pspclk&quot;, psp_clk=
_sels,<br>
&gt; ARRAY_SIZE(psp_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU0_HWSTRAP1, 2, 3),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU0_CLK_AHBMUX, &quot;soc0-ahbmux&quot;,=
 hclk_clk_sels,<br>
&gt; ARRAY_SIZE(hclk_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU0_HWSTRAP1, 7, 1),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU0_CLK_EMMCMUX, &quot;emmcsrc-mux&quot;=
, emmc_clk_sels,<br>
&gt; ARRAY_SIZE(emmc_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU0_CLK_SEL1, 11, 1)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU0_CLK_MPHYSRC, &quot;mphysrc&quot;, mp=
hy_clk_sels,<br>
&gt; ARRAY_SIZE(mphy_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU0_CLK_SEL2, 18, 2)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU0_CLK_U2PHY_REFCLKSRC, &quot;u2phy_ref=
clksrc&quot;,<br>
&gt; mhpll_clk_sels,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARRAY_SIZE(mhpll_clk_=
sels), SCU0_CLK_SEL2, 23, 1),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU0_CLK_UART, &quot;soc0-uartclk&quot;, =
uart_clk_sels,<br>
&gt; ARRAY_SIZE(uart_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU0_CLK_SEL2, 14, 1)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_MCLK, CLK_GATE_ASPEED, &qu=
ot;mclk-gate&quot;,<br>
&gt; soc0_mpll,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 0, CL=
K_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_ECLK, CLK_GATE_ASPEED, &qu=
ot;eclk-gate&quot;, NULL,<br>
&gt; SCU0_CLK_STOP, 1, 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_2DCLK, CLK_GATE_ASPEED, &q=
uot;gclk-gate&quot;, NULL,<br>
&gt; SCU0_CLK_STOP, 2, 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_VCLK, CLK_GATE_ASPEED, &qu=
ot;vclk-gate&quot;, NULL,<br>
&gt; SCU0_CLK_STOP, 3, 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_BCLK, CLK_GATE_ASPEED, &qu=
ot;bclk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 4, CL=
K_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_VGA0CLK,=C2=A0 CLK_GATE_AS=
PEED,<br>
&gt; &quot;vga0clk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 5, CL=
K_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_REFCLK,=C2=A0 CLK_GATE_ASP=
EED,<br>
&gt; &quot;soc0-refclk-gate&quot;, soc0_clkin,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 6, CL=
K_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_PORTBUSB2CLK, CLK_GATE_ASP=
EED,<br>
&gt; &quot;portb-usb2clk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 7, 0)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_UHCICLK, CLK_GATE_ASPEED, =
&quot;uhciclk-gate&quot;,<br>
&gt; NULL, SCU0_CLK_STOP, 9, 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_VGA1CLK, CLK_GATE_ASPEED, =
&quot;vga1clk-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 10, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_DDRPHYCLK, CLK_GATE_ASPEED=
,<br>
&gt; &quot;ddrphy-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 11, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_E2M0CLK, CLK_GATE_ASPEED,<=
br>
&gt; &quot;e2m0clk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 12, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_HACCLK, CLK_GATE_ASPEED, &=
quot;hacclk-gate&quot;,<br>
&gt; NULL, SCU0_CLK_STOP, 13, 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_PORTAUSB2CLK, CLK_GATE_ASP=
EED,<br>
&gt; &quot;porta-usb2clk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 14, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_UART4CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;uart4clk-gate&quot;, uart4clk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 15, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_SLICLK, CLK_GATE_ASPEED, &=
quot;soc0-sliclk-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 16, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_DACCLK, CLK_GATE_ASPEED, &=
quot;dacclk-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 17, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_DP, CLK_GATE_ASPEED, &quot=
;dpclk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 18, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_E2M1CLK, CLK_GATE_ASPEED,<=
br>
&gt; &quot;e2m1clk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 19, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_CRT0CLK, CLK_GATE_ASPEED, =
&quot;crt0clk-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 20, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_CRT1CLK, CLK_GATE_ASPEED, =
&quot;crt1clk-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 21, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_ECDSACLK, CLK_GATE_ASPEED,=
 &quot;eccclk-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 23, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_RSACLK, CLK_GATE_ASPEED, &=
quot;rsaclk-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 24, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_RVAS0CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;rvas0clk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 25, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_UFSCLK, CLK_GATE_ASPEED, &=
quot;ufsclk-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 26, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_EMMCCLK, CLK_GATE_ASPEED,<=
br>
&gt; &quot;emmcclk-gate&quot;, emmcclk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 27, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU0_CLK_GATE_RVAS1CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;rvas1clk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU0_CLK_STOP, 28, 0=
),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct ast2700_clk_info ast2700_scu1_clk_info[] __initco=
nst =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_CLK(SCU1_CLKIN, &quot;soc1-clkin&quot;, SCU=
_CLK_25MHZ),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PLL_CLK(SCU1_CLK_HPLL, CLK_PLL, &quot;soc1-hpll&q=
uot;, soc1_clkin,<br>
&gt; SCU1_HPLL_PARAM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PLL_CLK(SCU1_CLK_APLL, CLK_PLL, &quot;soc1-apll&q=
uot;, soc1_clkin,<br>
&gt; SCU1_APLL_PARAM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PLL_CLK(SCU1_CLK_DPLL, CLK_PLL, &quot;soc1-dpll&q=
uot;, soc1_clkin,<br>
&gt; SCU1_DPLL_PARAM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PLL_CLK(SCU1_CLK_UARTX, CLK_UART_PLL, &quot;uartx=
clk&quot;, uxclk,<br>
&gt; SCU1_UXCLK_CTRL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PLL_CLK(SCU1_CLK_HUARTX, CLK_UART_PLL, &quot;huar=
txclk&quot;, huxclk,<br>
&gt; SCU1_HUXCLK_CTRL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_FACTOR_CLK(SCU1_CLK_APLL_DIV2, &quot;soc1-a=
pll_div2&quot;, soc1_apll, 1,<br>
&gt; 2),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_FACTOR_CLK(SCU1_CLK_APLL_DIV4, &quot;soc1-a=
pll_div4&quot;, soc1_apll, 1,<br>
&gt; 4),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_FACTOR_CLK(SCU1_CLK_UART13, &quot;uart13clk=
&quot;, huartxclk, 1, 1),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_FACTOR_CLK(SCU1_CLK_UART14, &quot;uart14clk=
&quot;, huartxclk, 1, 1),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0FIXED_FACTOR_CLK(SCU1_CLK_CAN, &quot;canclk&quot;=
, soc1_apll, 1, 10),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DIVIDER_CLK(SCU1_CLK_SDCLK, &quot;sdclk&quot;, sd=
clk_mux,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CL=
K_SEL1, 14, 3, ast2700_clk_div_table),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DIVIDER_CLK(SCU1_CLK_APB, &quot;soc1-apb&quot;, s=
oc1_hpll,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CL=
K_SEL1, 18, 3, ast2700_clk_div_table2),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DIVIDER_CLK(SCU1_CLK_RMII, &quot;rmii&quot;, soc1=
_hpll,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CL=
K_SEL1, 21, 3, ast2700_rmii_div_table),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DIVIDER_CLK(SCU1_CLK_RGMII, &quot;rgmii&quot;, so=
c1_hpll,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CL=
K_SEL1, 25, 3, ast2700_rgmii_div_table),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DIVIDER_CLK(SCU1_CLK_MACHCLK, &quot;machclk&quot;=
, soc1_hpll,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CL=
K_SEL1, 29, 3, ast2700_clk_div_table),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DIVIDER_CLK(SCU1_CLK_APLL_DIVN, &quot;soc1-apll_d=
ivn&quot;, soc1_apll,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CL=
K_SEL2, 8, 3, ast2700_clk_div_table),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DIVIDER_CLK(SCU1_CLK_AHB, &quot;soc1-ahb&quot;, s=
oc1_hpll,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CL=
K_SEL2, 20, 3, ast2700_clk_div_table),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DIVIDER_CLK(SCU1_CLK_I3C, &quot;soc1-i3c&quot;, s=
oc1_hpll,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CL=
K_SEL2, 23, 3, ast2700_clk_div_table),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_UART0, &quot;uart0clk&quot;, uar=
tx_clk_sels,<br>
&gt; ARRAY_SIZE(uartx_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL1, 0, 1),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_UART1, &quot;uart1clk&quot;, uar=
tx_clk_sels,<br>
&gt; ARRAY_SIZE(uartx_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL1, 1, 1),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_UART2, &quot;uart2clk&quot;, uar=
tx_clk_sels,<br>
&gt; ARRAY_SIZE(uartx_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL1, 2, 1),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_UART3, &quot;uart3clk&quot;, uar=
tx_clk_sels,<br>
&gt; ARRAY_SIZE(uartx_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL1, 3, 1),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_UART5, &quot;uart5clk&quot;, uar=
tx_clk_sels,<br>
&gt; ARRAY_SIZE(uartx_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL1, 5, 1),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_UART6, &quot;uart6clk&quot;, uar=
tx_clk_sels,<br>
&gt; ARRAY_SIZE(uartx_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL1, 6, 1),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_UART7, &quot;uart7clk&quot;, uar=
tx_clk_sels,<br>
&gt; ARRAY_SIZE(uartx_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL1, 7, 1),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_UART8, &quot;uart8clk&quot;, uar=
tx_clk_sels,<br>
&gt; ARRAY_SIZE(uartx_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL1, 8, 1),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_UART9, &quot;uart9clk&quot;, uar=
tx_clk_sels,<br>
&gt; ARRAY_SIZE(uartx_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL1, 9, 1),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_UART10, &quot;uart10clk&quot;, u=
artx_clk_sels,<br>
&gt; ARRAY_SIZE(uartx_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL1, 10, 1)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_UART11, &quot;uart11clk&quot;, u=
artx_clk_sels,<br>
&gt; ARRAY_SIZE(uartx_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL1, 11, 1)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_UART12, &quot;uart12clk&quot;, u=
artx_clk_sels,<br>
&gt; ARRAY_SIZE(uartx_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL1, 12, 1)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_SDMUX, &quot;sdclk-mux&quot;, sd=
io_clk_sels,<br>
&gt; ARRAY_SIZE(sdio_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL1, 13, 1)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_UXCLK, &quot;uxclk&quot;, ux_clk=
_sels,<br>
&gt; ARRAY_SIZE(ux_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL2, 0, 2),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0MUX_CLK(SCU1_CLK_HUXCLK, &quot;huxclk&quot;, ux_c=
lk_sels,<br>
&gt; ARRAY_SIZE(ux_clk_sels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_CLK_SEL2, 3, 2),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_MAC0RCLK, CLK_GATE, &quot;mac0r=
clk-gate&quot;, rmii,<br>
&gt; SCU1_MAC12_CLK_DLY, 29, 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_MAC1RCLK, CLK_GATE, &quot;mac1r=
clk-gate&quot;, rmii,<br>
&gt; SCU1_MAC12_CLK_DLY, 30, 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_LCLK0, CLK_GATE_ASPEED, &q=
uot;lclk0-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 0, CL=
K_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_LCLK1, CLK_GATE_ASPEED, &q=
uot;lclk1-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 1, CL=
K_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_ESPI0CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;espi0clk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 2, CL=
K_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_ESPI1CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;espi1clk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 3, CL=
K_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_SDCLK, CLK_GATE_ASPEED, &q=
uot;sdclk-gate&quot;,<br>
&gt; sdclk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 4, CL=
K_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_IPEREFCLK, CLK_GATE_ASPEED=
,<br>
&gt; &quot;soc1-iperefclk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 5, CL=
K_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_REFCLK, CLK_GATE_ASPEED,<b=
r>
&gt; &quot;soc1-refclk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 6, CL=
K_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_LPCHCLK, CLK_GATE_ASPEED, =
&quot;lpchclk-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 7, CL=
K_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_MAC0CLK, CLK_GATE_ASPEED,<=
br>
&gt; &quot;mac0clk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 8, 0)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_MAC1CLK, CLK_GATE_ASPEED,<=
br>
&gt; &quot;mac1clk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 9, 0)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_MAC2CLK, CLK_GATE_ASPEED,<=
br>
&gt; &quot;mac2clk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 10, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_UART0CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;uart0clk-gate&quot;, uart0clk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 11, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_UART1CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;uart1clk-gate&quot;, uart1clk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 12, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_UART2CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;uart2clk-gate&quot;, uart2clk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 13, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_UART3CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;uart3clk-gate&quot;, uart3clk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 14, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I2CCLK, CLK_GATE_ASPEED, &=
quot;i2cclk-gate&quot;,<br>
&gt; NULL, SCU1_CLK_STOP, 15, 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C0CLK, CLK_GATE_ASPEED, =
&quot;i3c0clk-gate&quot;,<br>
&gt; soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 16, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C1CLK, CLK_GATE_ASPEED, =
&quot;i3c1clk-gate&quot;,<br>
&gt; soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 17, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C2CLK, CLK_GATE_ASPEED, =
&quot;i3c2clk-gate&quot;,<br>
&gt; soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 18, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C3CLK, CLK_GATE_ASPEED, =
&quot;i3c3clk-gate&quot;,<br>
&gt; soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 19, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C4CLK, CLK_GATE_ASPEED, =
&quot;i3c4clk-gate&quot;,<br>
&gt; soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 20, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C5CLK, CLK_GATE_ASPEED, =
&quot;i3c5clk-gate&quot;,<br>
&gt; soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 21, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C6CLK, CLK_GATE_ASPEED, =
&quot;i3c6clk-gate&quot;,<br>
&gt; soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 22, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C7CLK, CLK_GATE_ASPEED, =
&quot;i3c7clk-gate&quot;,<br>
&gt; soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 23, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C8CLK, CLK_GATE_ASPEED, =
&quot;i3c8clk-gate&quot;,<br>
&gt; soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 24, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C9CLK, CLK_GATE_ASPEED, =
&quot;i3c9clk-gate&quot;,<br>
&gt; soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 25, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C10CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;i3c10clk-gate&quot;, soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 26, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C11CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;i3c11clk-gate&quot;, soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 27, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C12CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;i3c12clk-gate&quot;, soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 28, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C13CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;i3c13clk-gate&quot;, soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 29, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C14CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;i3c14clk-gate&quot;, soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 30, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_I3C15CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;i3c15clk-gate&quot;, soc1_i3c,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP, 31, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_UART5CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;uart5clk-gate&quot;, uart5clk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 0, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_UART6CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;uart6clk-gate&quot;, uart6clk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 1, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_UART7CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;uart7clk-gate&quot;, uart7clk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 2, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_UART8CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;uart8clk-gate&quot;, uart8clk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 3, C=
LK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_UART9CLK, CLK_GATE_ASPEED,=
<br>
&gt; &quot;uart9clk-gate&quot;, uart9clk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 4, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_UART10CLK, CLK_GATE_ASPEED=
,<br>
&gt; &quot;uart10clk-gate&quot;, uart10clk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 5, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_UART11CLK, CLK_GATE_ASPEED=
,<br>
&gt; &quot;uart11clk-gate&quot;, uart11clk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 6, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_UART12CLK, CLK_GATE_ASPEED=
,<br>
&gt; &quot;uart12clk-gate&quot;, uart12clk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 7, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_FSICLK, CLK_GATE_ASPEED, &=
quot;fsiclk-gate&quot;,<br>
&gt; NULL, SCU1_CLK_STOP2, 8, 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_LTPIPHYCLK, CLK_GATE_ASPEE=
D,<br>
&gt; &quot;ltpiphyclk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 9, 0=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_LTPICLK, CLK_GATE_ASPEED, =
&quot;ltpiclk-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 10, =
0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_VGALCLK, CLK_GATE_ASPEED, =
&quot;vgalclk-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 11, =
CLK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_UHCICLK, CLK_GATE_ASPEED,<=
br>
&gt; &quot;usbuartclk-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 12, =
0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_CANCLK, CLK_GATE_ASPEED, &=
quot;canclk-gate&quot;,<br>
&gt; canclk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 13, =
0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_PCICLK, CLK_GATE_ASPEED, &=
quot;pciclk-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 14, =
0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_SLICLK, CLK_GATE_ASPEED, &=
quot;soc1-sliclk-gate&quot;,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 15, =
CLK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_E2MCLK, CLK_GATE_ASPEED,<b=
r>
&gt; &quot;soc1-e2m-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 16, =
CLK_IS_CRITICAL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_PORTCUSB2CLK, CLK_GATE_ASP=
EED,<br>
&gt; &quot;portcusb2-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 17, =
0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_PORTDUSB2CLK, CLK_GATE_ASP=
EED,<br>
&gt; &quot;portdusb2-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 18, =
0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GATE_CLK(SCU1_CLK_GATE_LTPI1TXCLK, CLK_GATE_ASPEE=
D,<br>
&gt; &quot;ltp1tx-gate&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU1_CLK_STOP2, 19, =
0),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static struct clk_hw *ast2700_clk_hw_register_hpll(void __iomem *reg,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, const char *parent_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct ast2700_clk_ctrl *clk_ctrl) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int mult, div;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 val;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0val =3D readl(clk_ctrl-&gt;base + SCU0_HWSTRAP1);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if ((readl(clk_ctrl-&gt;base) &amp; REVISION_ID) =
&amp;&amp; (val &amp; BIT(3))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch ((val &amp; GE=
NMASK(4, 2)) &gt;&gt; 2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return devm_clk_hw_register_fixed_rate(clk_ctrl-&gt;dev, name,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 1800 =
* HZ_PER_MHZ);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 3:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return devm_clk_hw_register_fixed_rate(clk_ctrl-&gt;dev, name,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 1700 =
* HZ_PER_MHZ);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 6:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return devm_clk_hw_register_fixed_rate(clk_ctrl-&gt;dev, name,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 1200 =
* HZ_PER_MHZ);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 7:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return devm_clk_hw_register_fixed_rate(clk_ctrl-&gt;dev, name,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 800 *=
 HZ_PER_MHZ);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return ERR_PTR(-EINVAL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else if ((val &amp; GENMASK(3, 2)) !=3D 0) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch ((val &amp; GE=
NMASK(3, 2)) &gt;&gt; 2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return devm_clk_hw_register_fixed_rate(clk_ctrl-&gt;dev, name,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 1900 =
* HZ_PER_MHZ);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return devm_clk_hw_register_fixed_rate(clk_ctrl-&gt;dev, name,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 1800 =
* HZ_PER_MHZ);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 3:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return devm_clk_hw_register_fixed_rate(clk_ctrl-&gt;dev, name,<br>
&gt; NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 1700 =
* HZ_PER_MHZ);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return ERR_PTR(-EINVAL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D readl(reg);<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; BIT(24)=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* Pass through mode */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mult =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0div =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0u32 m =3D val &amp; 0x1fff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0u32 n =3D (val &gt;&gt; 13) &amp; 0x3f;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0u32 p =3D (val &gt;&gt; 19) &amp; 0xf;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mult =3D (m + 1) / (2 * (n + 1));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0div =3D (p + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return devm_clk_hw_register_fixed_factor(clk_ctrl=
-&gt;dev, name,<br>
&gt; +parent_name, 0, mult, div); }<br>
&gt; +<br>
&gt; +static struct clk_hw *ast2700_clk_hw_register_pll(int clk_idx, void _=
_iomem<br>
&gt; *reg,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0const char *name, const char *parent_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0struct ast2700_clk_ctrl *clk_ctrl) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int scu =3D clk_ctrl-&gt;clk_data-&gt;scu;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int mult, div;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 val =3D readl(reg);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (val &amp; BIT(24)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Pass through mode =
*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mult =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0div =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 m =3D val &amp; 0=
x1fff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 n =3D (val &gt;&g=
t; 13) &amp; 0x3f;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 p =3D (val &gt;&g=
t; 19) &amp; 0xf;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (scu) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mult =3D (m + 1) / (n + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0div =3D (p + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (clk_idx =3D=3D SCU0_CLK_MPLL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mult =3D m / (n + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0div =3D (p + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mult =3D (m + 1) / (2 * (n + 1));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0div =3D (p + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return devm_clk_hw_register_fixed_factor(clk_ctrl=
-&gt;dev, name,<br>
&gt; +parent_name, 0, mult, div); }<br>
&gt; +<br>
&gt; +static struct clk_hw *ast2700_clk_hw_register_dclk(void __iomem *reg,=
<br>
&gt; const char *name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct ast2700_clk_ctrl *clk_ctrl) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int mult, div, r, n;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 xdclk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 val;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0val =3D readl(clk_ctrl-&gt;base + 0x284);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (val &amp; BIT(29))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xdclk =3D 800 * HZ_PE=
R_MHZ;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xdclk =3D 1000 * HZ_P=
ER_MHZ;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0val =3D readl(reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0r =3D val &amp; GENMASK(15, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0n =3D (val &gt;&gt; 16) &amp; GENMASK(15, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mult =3D r;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0div =3D 2 * n;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return devm_clk_hw_register_fixed_rate(clk_ctrl-&=
gt;dev, name, NULL, 0,<br>
&gt; +(xdclk * mult) / div); }<br>
&gt; +<br>
&gt; +static struct clk_hw *ast2700_clk_hw_register_uartpll(void __iomem *r=
eg,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, const char<br>
&gt; *parent_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ast2700_clk_ctrl *clk_ctrl) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int mult, div;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 val =3D readl(reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 r =3D val &amp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 n =3D (val &gt;&gt; 8) &amp; 0x3ff;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mult =3D r;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0div =3D n * 2;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return devm_clk_hw_register_fixed_factor(clk_ctrl=
-&gt;dev, name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 parent_name, 0, mult, div);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct clk_hw *ast2700_clk_hw_register_misc(int clk_idx, void<=
br>
&gt; __iomem *reg,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, const char *parent_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct ast2700_clk_ctrl *clk_ctrl) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 div =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (clk_idx =3D=3D SCU0_CLK_MPHY) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0div =3D readl(reg) + =
1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else if (clk_idx =3D=3D SCU0_CLK_U2PHY_REFCLK) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (readl(clk_ctrl-&g=
t;base) &amp; REVISION_ID)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0div =3D (GET_USB_REFCLK_DIV(readl(reg)) + 1) &lt;&lt; 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0div =3D (GET_USB_REFCLK_DIV(readl(reg)) + 1) &lt;&lt; 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR(-EINVA=
L);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return devm_clk_hw_register_fixed_factor(clk_ctrl=
-&gt;dev, name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 parent_name, 0, 1, div);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int ast2700_clk_is_enabled(struct clk_hw *hw) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct clk_gate *gate =3D to_clk_gate(hw);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 clk =3D BIT(gate-&gt;bit_idx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 reg;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg =3D readl(gate-&gt;reg);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return !(reg &amp; clk);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int ast2700_clk_enable(struct clk_hw *hw) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct clk_gate *gate =3D to_clk_gate(hw);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 clk =3D BIT(gate-&gt;bit_idx);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (readl(gate-&gt;reg) &amp; clk)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(clk, gate-&gt;=
reg + 0x04);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ast2700_clk_disable(struct clk_hw *hw) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct clk_gate *gate =3D to_clk_gate(hw);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 clk =3D BIT(gate-&gt;bit_idx);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Clock is set to enable, so use write to set re=
gister */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(clk, gate-&gt;reg);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct clk_ops ast2700_clk_gate_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.enable =3D ast2700_clk_enable,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.disable =3D ast2700_clk_disable,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.is_enabled =3D ast2700_clk_is_enabled,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static struct clk_hw *ast2700_clk_hw_register_gate(struct device *dev=
, const<br>
&gt; char *name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const struct clk_parent_data *parent,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *reg, u8 clock_idx,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long clk_gate_flags, spinlock_t<br>
&gt; *lock) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct clk_gate *gate;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct clk_hw *hw;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct clk_init_data init;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret =3D -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!gate)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR(-ENOME=
M);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0<a href=3D"http://init.name" rel=3D"noreferrer" t=
arget=3D"_blank">init.name</a> =3D name;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0init.ops =3D &amp;ast2700_clk_gate_ops;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0init.flags =3D clk_gate_flags;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0init.parent_names =3D parent ? &amp;parent-&gt;na=
me : NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0init.num_parents =3D parent ? 1 : 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0gate-&gt;reg =3D reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0gate-&gt;bit_idx =3D clock_idx;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0gate-&gt;flags =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0gate-&gt;lock =3D lock;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0gate-&gt;hw.init =3D &amp;init;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0hw =3D &amp;gate-&gt;hw;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D clk_hw_register(dev, hw);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(gate);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hw =3D ERR_PTR(ret);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return hw;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ast2700_soc1_configure_i3c_clk(struct ast2700_clk_ctrl<br=
>
&gt; +*clk_ctrl) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (readl(clk_ctrl-&gt;base + SCU1_REVISION_ID) &=
amp; REVISION_ID)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* I3C 250MHz =3D HPL=
L/4 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel((readl(clk_ctr=
l-&gt;base + SCU1_CLK_SEL2) &amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0~SCU1_CLK_I3C_DIV_MASK) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FIELD_PREP(SCU1_CLK_I3C_DIV_MASK,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SCU1_=
CLK_I3C_DIV(4)),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 clk_ctrl-&gt;base + SCU1_CLK_SEL2); }<br>
&gt; +<br>
&gt; +static int ast2700_soc_clk_probe(struct platform_device *pdev) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct ast2700_clk_data *clk_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct clk_hw_onecell_data *clk_hw_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct ast2700_clk_ctrl *clk_ctrl;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct auxiliary_device *adev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *clk_base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct clk_hw **hws;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *reset_name;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_ctrl =3D devm_kzalloc(dev, sizeof(*clk_ctrl),=
 GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!clk_ctrl)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_ctrl-&gt;dev =3D dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_set_drvdata(&amp;pdev-&gt;dev, clk_ctrl);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spin_lock_init(&amp;clk_ctrl-&gt;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_base =3D devm_platform_ioremap_resource(pdev,=
 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(clk_base))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(clk_ba=
se);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_ctrl-&gt;base =3D clk_base;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_data =3D device_get_match_data(dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!clk_data)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_ctrl-&gt;clk_data =3D clk_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reset_name =3D devm_kasprintf(dev, GFP_KERNEL, &q=
uot;reset%d&quot;,<br>
&gt; +clk_data-&gt;scu);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_hw_data =3D devm_kzalloc(dev, struct_size(clk=
_hw_data, hws,<br>
&gt; clk_data-&gt;nr_clks),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!clk_hw_data)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_hw_data-&gt;num =3D clk_data-&gt;nr_clks;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0hws =3D clk_hw_data-&gt;hws;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (clk_data-&gt;scu)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ast2700_soc1_configur=
e_i3c_clk(clk_ctrl);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; clk_data-&gt;nr_clks; i++) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct ast2700_=
clk_info *clk =3D &amp;clk_data-&gt;clk_info[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *reg;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (clk-&gt;type =3D=
=3D CLK_FIXED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const struct ast2700_clk_fixed_rate_data *fixed_rate =3D<br>
&gt; +&amp;clk-&gt;data.rate;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0hws[i] =3D devm_clk_hw_register_fixed_rate(dev, clk-&gt;name,<br>
&gt; NULL, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f=
ixed_rate-&gt;fixed_rate);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (clk-&gt;ty=
pe =3D=3D CLK_FIXED_FACTOR) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const struct ast2700_clk_fixed_factor_data *factor =3D<br>
&gt; +&amp;clk-&gt;data.factor;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0hws[i] =3D devm_clk_hw_register_fixed_factor(dev, clk-&gt;name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 factor-&gt;parent-&gt;name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0, factor-&gt;mult, factor-&gt;div);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (clk-&gt;ty=
pe =3D=3D DCLK_FIXED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const struct ast2700_clk_pll_data *pll =3D &amp;clk-&gt;data.pll;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D clk_ctrl-&gt;base + pll-&gt;reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0hws[i] =3D ast2700_clk_hw_register_dclk(reg, clk-&gt;name,<br>
&gt; clk_ctrl);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (clk-&gt;ty=
pe =3D=3D CLK_HPLL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const struct ast2700_clk_pll_data *pll =3D &amp;clk-&gt;data.pll;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D clk_ctrl-&gt;base + pll-&gt;reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0hws[i] =3D ast2700_clk_hw_register_hpll(reg, clk-&gt;name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pll-&gt;p=
arent-&gt;name, clk_ctrl);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (clk-&gt;ty=
pe =3D=3D CLK_PLL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const struct ast2700_clk_pll_data *pll =3D &amp;clk-&gt;data.pll;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D clk_ctrl-&gt;base + pll-&gt;reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0hws[i] =3D ast2700_clk_hw_register_pll(i, reg, clk-&gt;name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pll-&gt;parent-=
&gt;name, clk_ctrl);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (clk-&gt;ty=
pe =3D=3D CLK_UART_PLL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const struct ast2700_clk_pll_data *pll =3D &amp;clk-&gt;data.pll;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D clk_ctrl-&gt;base + pll-&gt;reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0hws[i] =3D ast2700_clk_hw_register_uartpll(reg, clk-&gt;name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p=
ll-&gt;parent-&gt;name, clk_ctrl);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (clk-&gt;ty=
pe =3D=3D CLK_MUX) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const struct ast2700_clk_mux_data *mux =3D &amp;clk-&gt;data.mux;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D clk_ctrl-&gt;base + mux-&gt;reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0hws[i] =3D devm_clk_hw_register_mux_parent_data_table(dev,<br>
&gt; clk-&gt;name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mux-&gt;parents,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mux-&gt;num_parents, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg, mux-&gt;bit_shift,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mux-&gt;bit_width, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, &amp;clk_ctrl-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (clk-&gt;ty=
pe =3D=3D CLK_MISC) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const struct ast2700_clk_pll_data *misc =3D &amp;clk-&gt;data.pll;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D clk_ctrl-&gt;base + misc-&gt;reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0hws[i] =3D ast2700_clk_hw_register_misc(i, reg, clk-&gt;name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0misc-&gt;=
parent-&gt;name, clk_ctrl);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (clk-&gt;ty=
pe =3D=3D CLK_DIVIDER) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const struct ast2700_clk_div_data *div =3D &amp;clk-&gt;data.div;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D clk_ctrl-&gt;base + div-&gt;reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0hws[i] =3D devm_clk_hw_register_divider_table(dev, clk-&gt;name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0div-&gt;parent-&gt;name, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0reg, div-&gt;bit_shift,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0div-&gt;bit_width, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0div-&gt;div_table,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&amp;clk_ctrl-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (clk-&gt;ty=
pe =3D=3D CLK_GATE_ASPEED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const struct ast2700_clk_gate_data *gate =3D &amp;clk-&gt;data.gate;=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D clk_ctrl-&gt;base + gate-&gt;reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0hws[i] =3D ast2700_clk_hw_register_gate(dev, clk-&gt;name,<br>
&gt; gate-&gt;parent,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg, gate=
-&gt;bit, gate-&gt;flags,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;clk_=
ctrl-&gt;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const struct ast2700_clk_gate_data *gate =3D &amp;clk-&gt;data.gate;=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D clk_ctrl-&gt;base + gate-&gt;reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0hws[i] =3D devm_clk_hw_register_gate_parent_data(dev,<br>
&gt; clk-&gt;name, gate-&gt;parent,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0, reg, clk-&gt;clk_idx, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &amp;clk_ctrl-&gt;lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(hws[i]))<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return PTR_ERR(hws[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D devm_of_clk_add_hw_provider(dev, of_clk_h=
w_onecell_get,<br>
&gt; clk_hw_data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0adev =3D devm_auxiliary_device_create(dev, reset_=
name, (__force void<br>
&gt; *)clk_base);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!adev)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct ast2700_clk_data ast2700_clk0_data =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.scu =3D 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.nr_clks =3D ARRAY_SIZE(ast2700_scu0_clk_info),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0.clk_info =3D ast2700_scu0_clk_info,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct ast2700_clk_data ast2700_clk1_data =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.scu =3D 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.nr_clks =3D ARRAY_SIZE(ast2700_scu1_clk_info),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0.clk_info =3D ast2700_scu1_clk_info,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct of_device_id ast2700_scu_match[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;aspeed,ast2700-scu0&quot;=
, .data =3D &amp;ast2700_clk0_data },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;aspeed,ast2700-scu1&quot;=
, .data =3D &amp;ast2700_clk1_data },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ /* sentinel */ }<br>
&gt; +};<br>
&gt; +<br>
&gt; +MODULE_DEVICE_TABLE(of, ast2700_scu_match);<br>
&gt; +<br>
&gt; +static struct platform_driver ast2700_scu_driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.probe =3D ast2700_soc_clk_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;clk-a=
st2700&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_table =3D a=
st2700_scu_match,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int __init clk_ast2700_init(void) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return platform_driver_register(&amp;ast2700_scu_=
driver);<br>
&gt; +}<br>
&gt; +arch_initcall(clk_ast2700_init);<br>
&gt; --<br>
&gt; 2.34.1<br>
<br>
</blockquote></div>

--000000000000c23214063ba8b02c--

