Return-Path: <linux-aspeed+bounces-181-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD285E7716D
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Dec 2024 23:24:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y3YWy4Hxkz30DL;
	Thu,  5 Dec 2024 10:24:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733354686;
	cv=none; b=UQon1JaY4bTbAGIzsf4LeryyJ9/TPFu8XmFULeiLvUL9nscuzb9RQaOf1YALtAZ8pMkaAq9VAt2Ij6efuKZ1qmDYBliOgzD79jDgl3rVPeuYssgNmjom8tImw0Xi1CbikVypAJLEcisYmPlU3JlRdATYM9j50DIcfPAvO86oq7xXuTFHEPYA8d6WSyjaavGweQMZurzOr6j9a4OQ478kL/MT8Avxbu8mTda8It1RwM6MV3fFSIzZ69VzdjY2RQANFySBKv5LbClE/3h2xvK87z6qaM4pAV6eaLTeXk/Zg8/IWWna6OXkf5hoyYaFe4gzhLz+adMC7KQ2afc8miiIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733354686; c=relaxed/relaxed;
	bh=U95w3ZhQysRNriViK2YjwAoYndR153TS1yK6EG2Jj7A=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=lEAuberWCCZlrL54qjGPBk5ozrgcyPoUniZxGNzTakWWe23tWI5byhFLLaBXwn363rwqRLK6Lh5dshyui7kH1f8mnot+hLszas7h+nj/NsRSJTFRlimEGpXxHNi2HB8MCebL0YEQZ8ecGtElHhkk1dG0HzYFNZZkGTin+PjN9JmncdPqOUSApXOo0gdVaS98LbZI8ubXKg/v2su0Z4l7sZiAENH4w/EoVwKjo/b5qxW17AnaolWVHKS6pCA3hRB77xxOu+nzLHEDK6g949WdJc/uMcS+2E8DOoz0Hwz1OYLA/3yO/FjddIY7QRXSIVBf/yLQceN5I162nmqne3jChA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GiOWzsli; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GiOWzsli;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y3YWx2rM5z309W
	for <linux-aspeed@lists.ozlabs.org>; Thu,  5 Dec 2024 10:24:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B61725C70EA;
	Wed,  4 Dec 2024 23:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D87C4CECD;
	Wed,  4 Dec 2024 23:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354682;
	bh=n6tt8G5iTvpqN8Ai25XZii/0NhY4FJ0gg4/pPLwKCLU=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=GiOWzsliDjYjlm7BEB7r0ofwLpgEMaFF1CGsnuzGfzn3rh9A2v2GqkccSbrv1sJiB
	 nyNb6EBSmgIV/FNj23TTr9go6o8Y2kTC/gUtGyOX55nD8WrRXMiINDLLtIz1vJCjY4
	 d6iBZmpUJB5yp2lADEAQO1ulCBnKanstPMRIATkRj0xBuSiodEyezHFGjBjztzfPYk
	 6/AB26dA+ZB0Pml+u0UUDE/kS747yKT0oGfF53KrQ7o1hQLesFLCVxrCnYaTbGSyud
	 NKxTGfE5Iz2YYqKLPlRSbG7CA+RK4C1SVmWivF3EZ+lr4wU+fIYubbzTqyl/AGgQt9
	 N3iRPScMm7DFw==
Message-ID: <9ccfb478d9a122db6c634e9559e211ff.sboyd@kernel.org>
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
In-Reply-To: <OS8PR06MB75419637D55A022300E00850F2352@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20241028053018.2579200-1-ryan_chen@aspeedtech.com> <20241028053018.2579200-4-ryan_chen@aspeedtech.com> <287924eed186e3b6b52cd13bcf939ab6.sboyd@kernel.org> <SI6PR06MB7535F5D22E3FCCF5C610B307F2552@SI6PR06MB7535.apcprd06.prod.outlook.com> <a68516df98c8b8fb80f094e6e55fcb8d.sboyd@kernel.org> <OS8PR06MB75419637D55A022300E00850F2352@OS8PR06MB7541.apcprd06.prod.outlook.com>
Subject: RE: [PATCH v7 3/3] clk: aspeed: add AST2700 clock driver.
From: Stephen Boyd <sboyd@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>, andrew@codeconstruct.com.au, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org, joel@jms.id.au, krzk+dt@kernel.org, lee@kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de, robh@kernel.org
Date: Wed, 04 Dec 2024 15:24:40 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Ryan Chen (2024-12-01 19:12:01)
> > > > Subject: Re: [PATCH v7 3/3] clk: aspeed: add AST2700 clock driver.
> > > >
> > > > Quoting Ryan Chen (2024-10-27 22:30:18)
> > > > > diff --git a/drivers/clk/clk-ast2700.c b/drivers/clk/clk-ast2700.c
> > > > > new file mode 100644 index 000000000000..db9ee5031b7c
> > > > > --- /dev/null
> > > > > +++ b/drivers/clk/clk-ast2700.c
> > > > > @@ -0,0 +1,1513 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > [...]
> > > > > +struct ast2700_clk_info {
> > > > > +       const char *name;
> > > > > +       const char * const *parent_names;
> > > >
> > > > Please don't use strings for parent names.
> > > Sorry, do you mean use clk_parent_data struct for parent?
> > >         +const struct clk_parent_data   parent;         /* For gate */
> > >         +const struct clk_parent_data   *parents;               /*
> > For mux */
> >=20
> > Yes.
> And I find a better way for parent_data. The following is my modification=
.=20
> And parent_data will be union data structure. Like following.
> Is this good direction?=20

Looks OK.

>=20
> #define DIVIDER_CLK(_id, _name, _parent, _reg, _shift, _width, _div_table=
) \
>         [_id] =3D { \
>                 .type =3D CLK_DIVIDER, \
>                 .name =3D _name, \
>                 .data =3D { \
>                         .div =3D { \
>                                 .parent =3D _parent, \
>                                 .reg =3D _reg, \
>                                 .bit_shift =3D _shift, \
>                                 .bit_width =3D _width, \
>                                 .div_table =3D _div_table, \
>                         }, \
>                 }, \
>         }
> struct ast2700_clk_info {
>         const char *name;
>         u8 clk_idx;
>         u32 reg;
>         u32 type;
>         union {
>                 struct ast2700_clk_fixed_factor_data factor;
>                 struct ast2700_clk_fixed_rate_data rate;
>                 struct ast2700_clk_gate_data gate;
>                 struct ast2700_clk_div_data div;
>                 struct ast2700_clk_pll_data pll;
>                 struct ast2700_clk_mux_data mux;
>         } data;
> };
>=20
> struct ast2700_clk_div_data {
>         const struct clk_div_table *div_table;
>         const struct clk_parent_data *parent;
>         u8 bit_shift;
>         u8 bit_width;
>         u32 reg;
> };
>=20
> static const struct ast2700_clk_info ast2700_scu0_clk_info[] __initconst =
=3D {
> ...........................
>         DIVIDER_CLK(SCU0_CLK_AHB, "soc0-ahb", soc0_ahbmux,

Can you also show what soc0_ahbmux is?

>                     SCU0_HWSTRAP1, 5, 2, ast2700_hclk_div_table),
> ......................
> >=20
> > >
> > > >
> > > > > +       const struct clk_div_table *div_table;
> > > > > +       unsigned long fixed_rate;
> > > > > +       unsigned int mult;
> > > > > +       unsigned int div;
> > > > > +       u32 reg;
> > > > > +       u32 flags;
> > > > > +       u32 type;
> > > > > +       u8 clk_idx;
> > > > > +       u8 bit_shift;
> > > > > +       u8 bit_width;
> > > > > +       u8 num_parents;
> > > > > +};
> > > > > +
> > > > [...]
> > > > > +
> > > > > +static const struct clk_div_table ast2700_clk_div_table2[] =3D {
> > > > > +       { 0x0, 2 },
> > > > > +       { 0x1, 4 },
> > > > > +       { 0x2, 6 },
> > > > > +       { 0x3, 8 },
> > > > > +       { 0x4, 10 },
> > > > > +       { 0x5, 12 },
> > > > > +       { 0x6, 14 },
> > > > > +       { 0x7, 16 },
> > > >
> > > > Isn't this the default divider setting for struct clk_divider?
> > > Sorry, I don't catch your point.
> > > the SoC do have default divider setting. But it can be modified.
> > > And also have different divider table setting.
> >=20
> > I mean that this is the way that struct clk_divider works already. So y=
ou don't
> > need to make the clk_div_table array for what is supported in code.
>=20
> Sorry, I understand your point. But I trace the code didn't get any clue.=
 "clk_divider work already".
> finally function call will be __clk_hw_register_divider
> https://github.com/torvalds/linux/blob/master/drivers/clk/clk-divider.c#L=
589
> It still need table point need to address. Can you give me more direction=
 or example?
>=20

The 'table' member is optional. When the table is NULL, we treat each
number that fits into the divider field width as a divider. It may be
CLK_DIVIDER_EVEN_INTEGERS that you have here though.

