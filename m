Return-Path: <linux-aspeed+bounces-1925-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EF1C87FD3
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 23:52:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4by6YG2R65z3bcj;
	Thu,  7 Aug 2025 09:52:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::12a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754445653;
	cv=none; b=IxwEvn5bjs89qyyYWyULeoNp0rnex1jvAqJUgy2ep5ULJ6AJyT1nktvUR3FgO6y2h7fKi1t8tNk6qkifXPAu1qbB7GzQRdk8GnbSACddMRb1bivvfy7DuKCgUXCYHSllhsbmHubDxTyXppk6g8Q/s1tJbB41+p9/2ozmyWJkvyHy7TUfWnG5lRLIHBrJAA9L4l7205j/wXqzuEQvJDt9W8FrDkGr+GfnLdOyRL5A+1w2FYbLhLOh2wks5fvaSfhTwtoJT1DM6QbY4u0d6ZnmB2BBVoBM6ycCniJqWQ6I/P18gCd1/FtSujko0HZr83uiCq3xUZs8tO/XBeYzg9jgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754445653; c=relaxed/relaxed;
	bh=DO8e5tESSKyN/CBl3RR3wWGDxP2dJBX+o7ZhFfAGhBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxos5O/PWAyB2neoEPT05TwcC/bNXlzA7DYDR6kBFl2cSV1aOF7Dg7VR2Cn+bUx5wvy2AiGCP1yp2z2RdDu0G9DbinOLUoIJ+30HCNvPdXk/Q9/8cp1UzFOoG1FaXuyLjNbPoIio1tymzs8P+CL+kY90y5SHDrtXN/Ig4erHdgjtzc6clJ85qEk7w6sQyM2X/lzwdwc9QypfGDeUW6xMPv9kWyfSxqZ6+kFmuMV7T3ecQNk7vmn/zkGWMOa1BYfM8hzxx7d+UFZrbrevgdLxSh1cQypBMJeah561kT28B65O7y6Dsz8zNsK2uxvS2az0I5KSNTGDsL2CfnLUEIVzGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=RIJ+C0nB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::12a; helo=mail-il1-x12a.google.com; envelope-from=elbadrym@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=RIJ+C0nB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::12a; helo=mail-il1-x12a.google.com; envelope-from=elbadrym@google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxYRR4Rlkz3bkb
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Aug 2025 12:00:50 +1000 (AEST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3e41754d4a5so51205ab.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 05 Aug 2025 19:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754445649; x=1755050449; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DO8e5tESSKyN/CBl3RR3wWGDxP2dJBX+o7ZhFfAGhBg=;
        b=RIJ+C0nBtaPvbIeQ7FMHWhhUd9ZFx6eZhPZuaclwWGSSQFuXOLyOBk8tSmFQ/dkxL0
         y3OTnwqdcSNF/DclxincCVL29CdTjhWny5394vlO3CprmwV9R/BxBx9VAbbyAn4VHb7O
         TXYqfhWouSwEcyhU7Odk3+SUybnwNkTedOIaIkILc49qkCEMPhFu3miHP64C9BcEHUVV
         adlfRQd/n49OyLzJznBUYQhZjswikR3h5CSbEED0u8082ijl+3u0QOE+0ozJ9VphZbBh
         /8FFqIj653hQ8CRGpDr8Z4OoAPniH0emKzJDYbH2VnDlDN5fCUCyz9tlg3+K+Axa6bOP
         WmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754445649; x=1755050449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DO8e5tESSKyN/CBl3RR3wWGDxP2dJBX+o7ZhFfAGhBg=;
        b=v1ox46/C54Y9XmaIFK7WejIU0q8oSDJjgPCEH1azZK5bp0WqTR9oxtomxsmwEP51hw
         42L+oeutmP9waIQAfwSwBSLBC4Nh+nKsfl2J+Mdyi7u+jFTwzbW0l2CIdB9o/MxinyyG
         Wdmkze+XBcpOW9AYxoEvYCsFpXaMDPSL3wT+ke4dQlq15uC7NEFUJu3GAFwWW2sqhuJl
         dcIUuc/G85ixALYzxKR739tSkVzML1c1THQQSNX4Hdd5khgY+i8ac3gFdiy+lI05hU0Z
         VXHl3gBlwFi6yTyABcm1ZDJds90w8IS9T1paq8NgzoPZ3NAaqvJVaqsrzXK199Kh023N
         8ipA==
X-Forwarded-Encrypted: i=1; AJvYcCXkoGH2Io01imyAcL5Kw8MIP4e6VfmRYgIfsjWWoJVvPwLeAa6RX2VQoX8pl3sSaihXZx9MXwbXx7GIY6Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwHP5iqQc8cwoMnazsXk49sRVmF1bMJzn7CdRIXDfD0hxBL7TH2
	ZDxeR+LPt8jWVvR6bUXS9FRWAn6JYI5mRucQH1tkc7vPn6JuPt3274wJdptHb6yxt8Peak3pLih
	p69JrCZBJJpxGQzVCscBg5WxMff3OwduuWygvrca/
X-Gm-Gg: ASbGnctQyGNEwqrFAcAi/7Svh24BLcqosaWApCmxNY4dCAsvdR25ct/DbBGl3SqPfZ7
	1lpOTDpa+Gs+Fht83FhqP/z8yxMVqSbEGLxqx9VRKJlce2ybSx2mQcibF5IuceHM+etkr5JZJ6G
	It5nCPV8Hr0/nfaw7CgBjCSk9Y7YDmPXMbl0vkxVAE85j3lcozzSu/3mPAdLttHitA49EOimTNg
	pTrnA==
X-Google-Smtp-Source: AGHT+IHnFWLwa8TNBzKFoQJ/S1TS8QFCY4hDk/LcaPh9SXnPLWpmmHBuYYDkjoMbdkOa8HxVInH+dYY6qajB4Fmki6k=
X-Received: by 2002:a05:6e02:1feb:b0:3e2:c639:8279 with SMTP id
 e9e14a558f8ab-3e51a6d4a49mr2468505ab.20.1754445648210; Tue, 05 Aug 2025
 19:00:48 -0700 (PDT)
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
Date: Tue, 5 Aug 2025 19:00:37 -0700
X-Gm-Features: Ac12FXxVEwLtC34GmYJe1rYKdV0nAgAPlHOZuQmYGJ_mMe1ZE27r7BlNAO_syVI
Message-ID: <CAOO6b=tEigCRXZ47BMgsTvxiZdO0P32+jFhQ313O044VALgaWA@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Kernel Maintainers,
I hope this email finds you well.

If I may ask, what do we need to do to move this patch forward?

Thank you for your help,
Mo


On Tue, Jul 8, 2025 at 11:41=E2=80=AFPM Ryan Chen <ryan_chen@aspeedtech.com=
> wrote:
>
> Hello Stephen,
>         sorry to bother you, do you have time to review this patch?
> Ryan
>
> > -----Original Message-----
> > From: Ryan Chen <ryan_chen@aspeedtech.com>
> > Sent: Tuesday, July 8, 2025 1:29 PM
> > To: Ryan Chen <ryan_chen@aspeedtech.com>; Michael Turquette
> > <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Philipp Zab=
el
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
> > Add AST2700 clock controller driver and also use axiliary device framew=
ork
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
> > +       The driver is responsible for managing the various clocks requi=
red
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
> > diff --git a/drivers/clk/clk-ast2700.c b/drivers/clk/clk-ast2700.c new =
file mode
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
> > +#define MUX_CLK(_id, _name, _parents, _num_parents, _reg, _shift, _wid=
th)
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
> > +#define DIVIDER_CLK(_id, _name, _parent, _reg, _shift, _width, _div_ta=
ble) \
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
_mult, .div =3D _div, } }, \
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
> > +static const struct ast2700_clk_info ast2700_scu0_clk_info[] __initcon=
st =3D {
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
> > +     FIXED_FACTOR_CLK(SCU0_CLK_HPLL_DIV2, "soc0-hpll_div2", soc0_hpll,=
 1,
> > 2),
> > +     FIXED_FACTOR_CLK(SCU0_CLK_HPLL_DIV4, "soc0-hpll_div4", soc0_hpll,=
 1,
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
> > +static const struct ast2700_clk_info ast2700_scu1_clk_info[] __initcon=
st =3D {
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
> > +     FIXED_FACTOR_CLK(SCU1_CLK_APLL_DIV2, "soc1-apll_div2", soc1_apll,=
 1,
> > 2),
> > +     FIXED_FACTOR_CLK(SCU1_CLK_APLL_DIV4, "soc1-apll_div4", soc1_apll,=
 1,
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
t char *parent_name,
> > +                                                struct ast2700_clk_ctr=
l *clk_ctrl) {
> > +     unsigned int mult, div;
> > +     u32 val;
> > +
> > +     val =3D readl(clk_ctrl->base + SCU0_HWSTRAP1);
> > +     if ((readl(clk_ctrl->base) & REVISION_ID) && (val & BIT(3))) {
> > +             switch ((val & GENMASK(4, 2)) >> 2) {
> > +             case 2:
> > +                     return devm_clk_hw_register_fixed_rate(clk_ctrl->=
dev, name,
> > NULL,
> > +                                                            0, 1800 * =
HZ_PER_MHZ);
> > +             case 3:
> > +                     return devm_clk_hw_register_fixed_rate(clk_ctrl->=
dev, name,
> > NULL,
> > +                                                            0, 1700 * =
HZ_PER_MHZ);
> > +             case 6:
> > +                     return devm_clk_hw_register_fixed_rate(clk_ctrl->=
dev, name,
> > NULL,
> > +                                                            0, 1200 * =
HZ_PER_MHZ);
> > +             case 7:
> > +                     return devm_clk_hw_register_fixed_rate(clk_ctrl->=
dev, name,
> > NULL,
> > +                                                            0, 800 * H=
Z_PER_MHZ);
> > +             default:
> > +                     return ERR_PTR(-EINVAL);
> > +             }
> > +     } else if ((val & GENMASK(3, 2)) !=3D 0) {
> > +             switch ((val & GENMASK(3, 2)) >> 2) {
> > +             case 1:
> > +                     return devm_clk_hw_register_fixed_rate(clk_ctrl->=
dev, name,
> > NULL,
> > +                                                            0, 1900 * =
HZ_PER_MHZ);
> > +             case 2:
> > +                     return devm_clk_hw_register_fixed_rate(clk_ctrl->=
dev, name,
> > NULL,
> > +                                                            0, 1800 * =
HZ_PER_MHZ);
> > +             case 3:
> > +                     return devm_clk_hw_register_fixed_rate(clk_ctrl->=
dev, name,
> > NULL,
> > +                                                            0, 1700 * =
HZ_PER_MHZ);
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
> > +static struct clk_hw *ast2700_clk_hw_register_pll(int clk_idx, void __=
iomem
> > *reg,
> > +                                               const char *name, const=
 char *parent_name,
> > +                                               struct ast2700_clk_ctrl=
 *clk_ctrl) {
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
l *clk_ctrl) {
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
> > +     return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name, NULL,=
 0,
> > +(xdclk * mult) / div); }
> > +
> > +static struct clk_hw *ast2700_clk_hw_register_uartpll(void __iomem *re=
g,
> > +                                                   const char *name, c=
onst char
> > *parent_name,
> > +                                                   struct ast2700_clk_=
ctrl *clk_ctrl) {
> > +     unsigned int mult, div;
> > +     u32 val =3D readl(reg);
> > +     u32 r =3D val & 0xff;
> > +     u32 n =3D (val >> 8) & 0x3ff;
> > +
> > +     mult =3D r;
> > +     div =3D n * 2;
> > +
> > +     return devm_clk_hw_register_fixed_factor(clk_ctrl->dev, name,
> > +                                              parent_name, 0, mult, di=
v);
> > +}
> > +
> > +static struct clk_hw *ast2700_clk_hw_register_misc(int clk_idx, void
> > __iomem *reg,
> > +                                                const char *name, cons=
t char *parent_name,
> > +                                                struct ast2700_clk_ctr=
l *clk_ctrl) {
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
> > +static struct clk_hw *ast2700_clk_hw_register_gate(struct device *dev,=
 const
> > char *name,
> > +                                                const struct clk_paren=
t_data *parent,
> > +                                                void __iomem *reg, u8 =
clock_idx,
> > +                                                unsigned long clk_gate=
_flags, spinlock_t
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
> > +             const struct ast2700_clk_info *clk =3D &clk_data->clk_inf=
o[i];
> > +             void __iomem *reg;
> > +
> > +             if (clk->type =3D=3D CLK_FIXED) {
> > +                     const struct ast2700_clk_fixed_rate_data *fixed_r=
ate =3D
> > +&clk->data.rate;
> > +
> > +                     hws[i] =3D devm_clk_hw_register_fixed_rate(dev, c=
lk->name,
> > NULL, 0,
> > +                                                              fixed_ra=
te->fixed_rate);
> > +             } else if (clk->type =3D=3D CLK_FIXED_FACTOR) {
> > +                     const struct ast2700_clk_fixed_factor_data *facto=
r =3D
> > +&clk->data.factor;
> > +
> > +                     hws[i] =3D devm_clk_hw_register_fixed_factor(dev,=
 clk->name,
> > +                                                                factor=
->parent->name,
> > +                                                                0, fac=
tor->mult, factor->div);
> > +             } else if (clk->type =3D=3D DCLK_FIXED) {
> > +                     const struct ast2700_clk_pll_data *pll =3D &clk->=
data.pll;
> > +
> > +                     reg =3D clk_ctrl->base + pll->reg;
> > +                     hws[i] =3D ast2700_clk_hw_register_dclk(reg, clk-=
>name,
> > clk_ctrl);
> > +             } else if (clk->type =3D=3D CLK_HPLL) {
> > +                     const struct ast2700_clk_pll_data *pll =3D &clk->=
data.pll;
> > +
> > +                     reg =3D clk_ctrl->base + pll->reg;
> > +                     hws[i] =3D ast2700_clk_hw_register_hpll(reg, clk-=
>name,
> > +                                                           pll->parent=
->name, clk_ctrl);
> > +             } else if (clk->type =3D=3D CLK_PLL) {
> > +                     const struct ast2700_clk_pll_data *pll =3D &clk->=
data.pll;
> > +
> > +                     reg =3D clk_ctrl->base + pll->reg;
> > +                     hws[i] =3D ast2700_clk_hw_register_pll(i, reg, cl=
k->name,
> > +                                                          pll->parent-=
>name, clk_ctrl);
> > +             } else if (clk->type =3D=3D CLK_UART_PLL) {
> > +                     const struct ast2700_clk_pll_data *pll =3D &clk->=
data.pll;
> > +
> > +                     reg =3D clk_ctrl->base + pll->reg;
> > +                     hws[i] =3D ast2700_clk_hw_register_uartpll(reg, c=
lk->name,
> > +                                                              pll->par=
ent->name, clk_ctrl);
> > +             } else if (clk->type =3D=3D CLK_MUX) {
> > +                     const struct ast2700_clk_mux_data *mux =3D &clk->=
data.mux;
> > +
> > +                     reg =3D clk_ctrl->base + mux->reg;
> > +                     hws[i] =3D devm_clk_hw_register_mux_parent_data_t=
able(dev,
> > clk->name,
> > +                                                                      =
   mux->parents,
> > +                                                                      =
   mux->num_parents, 0,
> > +                                                                      =
   reg, mux->bit_shift,
> > +                                                                      =
   mux->bit_width, 0,
> > +                                                                      =
   NULL, &clk_ctrl->lock);
> > +             } else if (clk->type =3D=3D CLK_MISC) {
> > +                     const struct ast2700_clk_pll_data *misc =3D &clk-=
>data.pll;
> > +
> > +                     reg =3D clk_ctrl->base + misc->reg;
> > +                     hws[i] =3D ast2700_clk_hw_register_misc(i, reg, c=
lk->name,
> > +                                                           misc->paren=
t->name, clk_ctrl);
> > +             } else if (clk->type =3D=3D CLK_DIVIDER) {
> > +                     const struct ast2700_clk_div_data *div =3D &clk->=
data.div;
> > +
> > +                     reg =3D clk_ctrl->base + div->reg;
> > +                     hws[i] =3D devm_clk_hw_register_divider_table(dev=
, clk->name,
> > +                                                                 div->=
parent->name, 0,
> > +                                                                 reg, =
div->bit_shift,
> > +                                                                 div->=
bit_width, 0,
> > +                                                                 div->=
div_table,
> > +                                                                 &clk_=
ctrl->lock);
> > +             } else if (clk->type =3D=3D CLK_GATE_ASPEED) {
> > +                     const struct ast2700_clk_gate_data *gate =3D &clk=
->data.gate;
> > +
> > +                     reg =3D clk_ctrl->base + gate->reg;
> > +                     hws[i] =3D ast2700_clk_hw_register_gate(dev, clk-=
>name,
> > gate->parent,
> > +                                                           reg, gate->=
bit, gate->flags,
> > +                                                           &clk_ctrl->=
lock);
> > +
> > +             } else {
> > +                     const struct ast2700_clk_gate_data *gate =3D &clk=
->data.gate;
> > +
> > +                     reg =3D clk_ctrl->base + gate->reg;
> > +                     hws[i] =3D devm_clk_hw_register_gate_parent_data(=
dev,
> > clk->name, gate->parent,
> > +                                                                    0,=
 reg, clk->clk_idx, 0,
> > +                                                                    &c=
lk_ctrl->lock);
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
data },
> > +     { .compatible =3D "aspeed,ast2700-scu1", .data =3D &ast2700_clk1_=
data },
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

