Return-Path: <linux-aspeed+bounces-54-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52893D6B6DA
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Oct 2024 21:01:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xf0195djyz2xLR;
	Thu, 31 Oct 2024 08:01:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730322109;
	cv=none; b=o0V1175f70DQqJJaGi1cYSEdbViiJd1m4K5Lqe2rUE+cQ02hBgJGmOiwQLxxQwz0RQwAEaz4XXMMtsA+FcTmKfNnkGSvAkESbxWBoVU4dh6LpaRt9few4U9qdMUMKFuSY4Wv3b9nLYkKty3EWUeKlaT0X4DQiVw9683Okec0y5jZk9LQgJ4TC9IsOKMj8QG5t/m4KKs7OtfpRE5CLSkvnFm8LJcSJhSx5UegBTe1VMq/fe1Vq+V1PLMlGnImVFgIPlGKtiKVww+VNgeYJtwyftYXkIy/0gzOKFqtEhcfzIkwqsn7jve6MFNuUt/yvJd74w3MfsmxL3rR6USu4gGPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730322109; c=relaxed/relaxed;
	bh=QlbjBrjfJwipy4+mF4SLnBTaKSlHUDRYJgaW5NZk1uI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=PLVrdvxaOkWdQ8oUM8fXtPfFWmp46JCUAAZs9n+skfbM1ZE/ekYHUHckunWvMDMVVowr7LBzBoaeVQwDOVYygp1ACpSXxgj+iZHJmarDPb0VmTbOqjz9EjQ0zZTGVp/ekKSAx8bY4h4vbosKmUZ7KyCqJkoDFtB0g77TXudm8rFrUnu/mSZ06qoFKex9ilX2YAbwgP+TDgSb2dm46sTy6QvOZAT/W/J6yfrG/vgSfL8ALQ+JfVXDF+wbuSdvu0T+nHdSP7pBnWJwqbXEOASSe+qovXoPyqA5xmPxO/H+GDMGJaSfWdb8bFw+91c0vZRf1xHxT3zl9kaXQMyC63z89A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jrGyCHB7; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jrGyCHB7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xf018541lz2xHb
	for <linux-aspeed@lists.ozlabs.org>; Thu, 31 Oct 2024 08:01:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3348E5C0448;
	Wed, 30 Oct 2024 21:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B366DC4CECE;
	Wed, 30 Oct 2024 21:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730322105;
	bh=q9zfrzpM+zkrWbsk3mIy6Dlm8RGXhbxqDPFE7XZ8n78=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=jrGyCHB7TgVH5IndJa3ZOHCdGwnL4syFWjo9S0GvMcLmyr/E5C4aQcXF0aH/Rcsfv
	 1Sr/70b9X13bkuZmrAoeLrH/yViX2FAmPJczfg3G+4woXZICTuK5/ikhW+zxgOFG1S
	 tbR0RoIq/Lys/g9eAMHohWWjDfA87RwJhLC6UqhYgV3KClnTMmFgICMwK3FTNDXGFe
	 CpYgekpvzxsozyPhZievHPtImFZAjQTFULuOJFotV+TBx54UgDosnKVHwNqGQY74rx
	 Euqr3C98Br/4jYl8sPof+B48qn6k1MJBPLry9Ryb9Ho6soYEz2WT9CYQjJtbC1r43E
	 F3deGEtlFu5Zw==
Message-ID: <287924eed186e3b6b52cd13bcf939ab6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241028053018.2579200-4-ryan_chen@aspeedtech.com>
References: <20241028053018.2579200-1-ryan_chen@aspeedtech.com> <20241028053018.2579200-4-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v7 3/3] clk: aspeed: add AST2700 clock driver.
From: Stephen Boyd <sboyd@kernel.org>
To: andrew@codeconstruct.com.au, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org, joel@jms.id.au, krzk+dt@kernel.org, lee@kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de, robh@kernel.org, ryan_chen@aspeedtech.com
Date: Wed, 30 Oct 2024 14:01:43 -0700
User-Agent: alot/0.10

Quoting Ryan Chen (2024-10-27 22:30:18)
> diff --git a/drivers/clk/clk-ast2700.c b/drivers/clk/clk-ast2700.c
> new file mode 100644
> index 000000000000..db9ee5031b7c
> --- /dev/null
> +++ b/drivers/clk/clk-ast2700.c
> @@ -0,0 +1,1513 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 ASPEED Technology Inc.
> + * Author: Ryan Chen <ryan_chen@aspeedtech.com>
> + */
> +
> +#include <linux/auxiliary_bus.h>

Is this include used?

> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>

Is this include used?

> +#include <linux/of_device.h>

Probably should be mod_devicetable.h here

> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/units.h>
> +
> +#include <dt-bindings/clock/aspeed,ast2700-scu.h>
> +#include <soc/aspeed/reset-aspeed.h>

This include can go before dt-bindings.

> +
> +#define SCU_CLK_12MHZ (12 * HZ_PER_MHZ)
> +#define SCU_CLK_24MHZ (24 * HZ_PER_MHZ)
> +#define SCU_CLK_25MHZ (25 * HZ_PER_MHZ)
> +#define SCU_CLK_192MHZ (192 * HZ_PER_MHZ)
> +
> +/* SOC0 */
> +#define SCU0_HWSTRAP1 0x010
> +#define SCU0_CLK_STOP 0x240
> +#define SCU0_CLK_SEL1 0x280
> +#define SCU0_CLK_SEL2 0x284
> +#define GET_USB_REFCLK_DIV(x) ((GENMASK(23, 20) & (x)) >> 20)
> +#define UART_DIV13_EN BIT(30)
> +#define SCU0_HPLL_PARAM 0x300
> +#define SCU0_DPLL_PARAM 0x308
> +#define SCU0_MPLL_PARAM 0x310
> +#define SCU0_D0CLK_PARAM 0x320
> +#define SCU0_D1CLK_PARAM 0x330
> +#define SCU0_CRT0CLK_PARAM 0x340
> +#define SCU0_CRT1CLK_PARAM 0x350
> +#define SCU0_MPHYCLK_PARAM 0x360

It would be easier to read if these things were tabbed out a little.

#define SCU0_MPHYCLK_PARAM			0x360

> +
> +/* SOC1 */
> +#define SCU1_REVISION_ID 0x0
> +#define REVISION_ID GENMASK(23, 16)
> +#define SCU1_CLK_STOP 0x240
> +#define SCU1_CLK_STOP2 0x260
> +#define SCU1_CLK_SEL1 0x280
> +#define SCU1_CLK_SEL2 0x284
> +#define UXCLK_MASK GENMASK(1, 0)
> +#define HUXCLK_MASK GENMASK(4, 3)
> +#define SCU1_HPLL_PARAM 0x300
> +#define SCU1_APLL_PARAM 0x310
> +#define SCU1_DPLL_PARAM 0x320
> +#define SCU1_UXCLK_CTRL 0x330
> +#define SCU1_HUXCLK_CTRL 0x334
> +#define SCU1_MAC12_CLK_DLY 0x390
> +#define SCU1_MAC12_CLK_DLY_100M 0x394
> +#define SCU1_MAC12_CLK_DLY_10M 0x398
> +
> +enum {
> +       CLK_MUX,
> +       CLK_PLL,
> +       CLK_GATE,
> +       CLK_MISC,
> +       CLK_FIXED,
> +       CLK_DIVIDER,
> +       CLK_UART_PLL,
> +       CLK_DIV_TABLE,
> +       CLK_FIXED_FACTOR,
> +       CLK_GATE_ASPEED,
> +};
> +
> +struct ast2700_clk_info {
> +       const char *name;
> +       const char * const *parent_names;

Please don't use strings for parent names.

> +       const struct clk_div_table *div_table;
> +       unsigned long fixed_rate;
> +       unsigned int mult;
> +       unsigned int div;
> +       u32 reg;
> +       u32 flags;
> +       u32 type;
> +       u8 clk_idx;
> +       u8 bit_shift;
> +       u8 bit_width;
> +       u8 num_parents;
> +};
> +
[...]
> +
> +static const struct clk_div_table ast2700_clk_div_table2[] =3D {
> +       { 0x0, 2 },
> +       { 0x1, 4 },
> +       { 0x2, 6 },
> +       { 0x3, 8 },
> +       { 0x4, 10 },
> +       { 0x5, 12 },
> +       { 0x6, 14 },
> +       { 0x7, 16 },

Isn't this the default divider setting for struct clk_divider?

> +       { 0 }
> +};
> +
> +static const struct clk_div_table ast2700_clk_uart_div_table[] =3D {
> +       { 0x0, 1 },
> +       { 0x1, 13 },
> +       { 0 }
[...]
> +               .bit_shift =3D 23,
> +               .bit_width =3D 3,
> +               .div_table =3D ast2700_clk_div_table2,
> +       },
> +       [SCU0_CLK_GATE_MCLK] =3D {
> +               .type =3D CLK_GATE_ASPEED,
> +               .name =3D "mclk-gate",
> +               .parent_names =3D (const char *[]){ "soc0-mpll", },
> +               .reg =3D SCU0_CLK_STOP,
> +               .clk_idx =3D 0,
> +               .flags =3D CLK_IS_CRITICAL,
> +       },
> +       [SCU0_CLK_GATE_ECLK] =3D {
> +               .type =3D CLK_GATE_ASPEED,
> +               .name =3D "eclk-gate",
> +               .parent_names =3D (const char *[]){  },
> +               .reg =3D SCU0_CLK_STOP,
> +               .clk_idx =3D 1,
> +       },
> +       [SCU0_CLK_GATE_2DCLK] =3D {
> +               .type =3D CLK_GATE_ASPEED,
> +               .name =3D "gclk-gate",
> +               .parent_names =3D (const char *[]){  },

This has no parent? Why is parent_names set to an empty array?

> +               .reg =3D SCU0_CLK_STOP,
> +               .clk_idx =3D 2,
> +       },
> +       [SCU0_CLK_GATE_VCLK] =3D {
[...]
> +
> +static struct clk_hw *ast2700_clk_hw_register_pll(int clk_idx, void __io=
mem *reg,
> +                                                 const struct ast2700_cl=
k_info *clk,
> +                                                 struct ast2700_clk_ctrl=
 *clk_ctrl)
> +{
> +       int scu =3D clk_ctrl->clk_data->scu;
> +       unsigned int mult, div;
> +       u32 val;
> +
> +       if (!scu && clk_idx =3D=3D SCU0_CLK_HPLL) {
> +               val =3D readl(clk_ctrl->base + SCU0_HWSTRAP1);
> +               if ((val & GENMASK(3, 2)) !=3D 0) {
> +                       switch ((val & GENMASK(3, 2)) >> 2) {
> +                       case 1:
> +                               return devm_clk_hw_register_fixed_rate(cl=
k_ctrl->dev, "soc0-hpll",
> +                                                                      NU=
LL, 0, 1900000000);
> +                       case 2:
> +                               return devm_clk_hw_register_fixed_rate(cl=
k_ctrl->dev, "soc0-hpll",
> +                                                                      NU=
LL, 0, 1800000000);
> +                       case 3:
> +                               return devm_clk_hw_register_fixed_rate(cl=
k_ctrl->dev, "soc0-hpll",
> +                                                                      NU=
LL, 0, 1700000000);
> +                       default:
> +                               return ERR_PTR(-EINVAL);
> +                       }
> +               }

What if it is 0? Were we supposed to return an error? Why isn't HPLL a
different type of PLL so that this function can be broken up into two
PLL registration functions?

> +       }
> +
> +       val =3D readl(reg);
> +
> +       if (val & BIT(24)) {
> +               /* Pass through mode */
> +               mult =3D 1;
> +               div =3D 1;
> +       } else {
> +               u32 m =3D val & 0x1fff;
> +               u32 n =3D (val >> 13) & 0x3f;
> +               u32 p =3D (val >> 19) & 0xf;
> +
> +               if (scu) {
> +                       mult =3D (m + 1) / (n + 1);
> +                       div =3D (p + 1);
> +               } else {
> +                       if (clk_idx =3D=3D SCU0_CLK_MPLL) {
> +                               mult =3D m / (n + 1);
> +                               div =3D (p + 1);
> +                       } else {
> +                               mult =3D (m + 1) / (2 * (n + 1));
> +                               div =3D (p + 1);
> +                       }
> +               }
> +       }
> +
> +       return devm_clk_hw_register_fixed_factor(clk_ctrl->dev, clk->name,
> +                                                clk->parent_names[0], 0,=
 mult, div);
> +}
> +
[...]
> +
> +static int ast2700_soc_clk_probe(struct platform_device *pdev)
> +{
> +       struct ast2700_clk_data *clk_data;
> +       struct ast2700_clk_ctrl *clk_ctrl;
> +       struct clk_hw_onecell_data *clk_hw_data;
> +       struct device *dev =3D &pdev->dev;
> +       void __iomem *clk_base;
> +       struct clk_hw **hws;
> +       char *reset_name;
> +       int ret;
> +       int i;
> +
> +       clk_ctrl =3D devm_kzalloc(dev, sizeof(*clk_ctrl), GFP_KERNEL);
> +       if (!clk_ctrl)
> +               return -ENOMEM;
> +       clk_ctrl->dev =3D dev;
> +       dev_set_drvdata(&pdev->dev, clk_ctrl);
> +
> +       spin_lock_init(&clk_ctrl->lock);
> +
> +       clk_base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(clk_base))
> +               return PTR_ERR(clk_base);
> +
> +       clk_ctrl->base =3D clk_base;
> +
> +       clk_data =3D (struct ast2700_clk_data *)of_device_get_match_data(=
dev);

Just
	clk_data =3D device_get_match_data(dev);

> +       if (!clk_data)
> +               return devm_of_platform_populate(dev);

What is being populated? Isn't there always clk_data?

> +
> +       clk_ctrl->clk_data =3D clk_data;
> +       reset_name =3D devm_kasprintf(dev, GFP_KERNEL, "reset%d", clk_dat=
a->scu);
> +
> +       clk_hw_data =3D devm_kzalloc(dev, struct_size(clk_hw_data, hws, c=
lk_data->nr_clks),
> +                                  GFP_KERNEL);
> +       if (!clk_hw_data)
> +               return -ENOMEM;
> +
> +       clk_hw_data->num =3D clk_data->nr_clks;
> +       hws =3D clk_hw_data->hws;
> +
> +       for (i =3D 0; i < clk_data->nr_clks; i++) {
> +               const struct ast2700_clk_info *clk =3D &clk_data->clk_inf=
o[i];
> +               void __iomem *reg =3D clk_ctrl->base + clk->reg;
> +
> +               if (clk->type =3D=3D CLK_FIXED) {
> +                       hws[i] =3D devm_clk_hw_register_fixed_rate(dev, c=
lk->name, NULL,
> +                                                                clk->fla=
gs, clk->fixed_rate);
> +               } else if (clk->type =3D=3D CLK_FIXED_FACTOR) {
> +                       hws[i] =3D devm_clk_hw_register_fixed_factor(dev,=
 clk->name,
> +                                                                  clk->p=
arent_names[0], clk->flags,
> +                                                                  clk->m=
ult, clk->div);
> +               } else if (clk->type =3D=3D CLK_PLL) {
> +                       hws[i] =3D ast2700_clk_hw_register_pll(i, reg, cl=
k, clk_ctrl);
> +               } else if (clk->type =3D=3D CLK_UART_PLL) {
> +                       hws[i] =3D ast2700_clk_hw_register_uartpll(i, reg=
, clk, clk_ctrl);
> +               } else if (clk->type =3D=3D CLK_MUX) {
> +                       hws[i] =3D devm_clk_hw_register_mux(dev, clk->nam=
e, clk->parent_names,

Please don't use strings for parent_names. Use clk_hw pointers or DT
indices.

> +                                                         clk->num_parent=
s, clk->flags, reg,
> +                                                         clk->bit_shift,=
 clk->bit_width,
> +                                                         0, &clk_ctrl->l=
ock);
> +               } else if (clk->type =3D=3D CLK_MISC) {
> +                       hws[i] =3D ast2700_clk_hw_register_misc(i, reg, c=
lk, clk_ctrl);
> +               } else if (clk->type =3D=3D CLK_DIVIDER) {
> +                       hws[i] =3D devm_clk_hw_register_divider(dev, clk-=
>name, clk->parent_names[0],
> +                                                             clk->flags,=
 reg, clk->bit_shift,
> +                                                             clk->bit_wi=
dth, 0,
> +                                                             &clk_ctrl->=
lock);
> +               } else if (clk->type =3D=3D CLK_DIV_TABLE) {
> +                       hws[i] =3D clk_hw_register_divider_table(dev, clk=
->name, clk->parent_names[0],
> +                                                              clk->flags=
, reg, clk->bit_shift,
> +                                                              clk->bit_w=
idth, 0,
> +                                                              clk->div_t=
able, &clk_ctrl->lock);
> +               } else if (clk->type =3D=3D CLK_GATE_ASPEED) {
> +                       hws[i] =3D ast2700_clk_hw_register_gate(dev, clk-=
>name, clk->parent_names[0],
> +                                                             clk->flags,=
 reg, clk->clk_idx,
> +                                                             clk->flags,=
 &clk_ctrl->lock);
> +               } else {
> +                       hws[i] =3D clk_hw_register_gate(dev, clk->name, c=
lk->parent_names[0],
> +                                                     clk->flags, reg, cl=
k->clk_idx, clk->flags,
> +                                                     &clk_ctrl->lock);
> +               }
> +
> +               if (IS_ERR(hws[i]))
> +                       return PTR_ERR(hws[i]);
> +       }
> +
> +       ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, c=
lk_hw_data);
> +       if (ret)
> +               return ret;
> +
> +       return aspeed_reset_controller_register(dev, clk_base, reset_name=
);
> +}
> +
> +static const struct ast2700_clk_data ast2700_clk0_data =3D {
> +       .scu =3D 0,
> +       .nr_clks =3D ARRAY_SIZE(ast2700_scu0_clk_info),
> +       .clk_info =3D ast2700_scu0_clk_info,
> +};
> +
> +static const struct ast2700_clk_data ast2700_clk1_data =3D {
> +       .scu =3D 1,
> +       .nr_clks =3D ARRAY_SIZE(ast2700_scu1_clk_info),
> +       .clk_info =3D ast2700_scu1_clk_info,
> +};
> +
> +static const struct of_device_id ast2700_scu_match[] =3D {
> +       { .compatible =3D "aspeed,ast2700-scu0", .data =3D &ast2700_clk0_=
data },
> +       { .compatible =3D "aspeed,ast2700-scu1", .data =3D &ast2700_clk1_=
data },
> +       { /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, ast2700_scu_match);
> +
> +static struct platform_driver ast2700_scu_driver =3D {
> +       .driver =3D {
> +               .name =3D "clk-ast2700",
> +               .of_match_table =3D ast2700_scu_match,
> +       },
> +};
> +
> +builtin_platform_driver_probe(ast2700_scu_driver, ast2700_soc_clk_probe);

Use module_platform_driver_probe() and make the config tristate. I don't
see what's preventing this from being a module.

