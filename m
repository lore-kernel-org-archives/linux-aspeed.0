Return-Path: <linux-aspeed+bounces-183-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC86E77173
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Dec 2024 22:15:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y4lvc1zZ4z2y71;
	Sat,  7 Dec 2024 09:15:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733523356;
	cv=none; b=cQyXSZAfobH5BCDaV/x4FtYp9WF63JdaYSVnyu9bkba8R/QCQWyi3qoaJjhy9PBChISPkGrCbnWjWhtfmZG3vp0nYmHqr0GAIjOr2g77Jg1R5zCkTXO8tZnHY2BspTt2CqWofSJmwCCkA3j2GIdg0iSQ6RHMibqePgSs3f4P7SHYJBluK5sUb0co69cvmjvCGJUDVZjsKF3cpDXd6YVwhKlVoeGS6wzfw7KfD0gPA+FygpsfwdasZmRu5pI5l7SFidl6uL9wuEU7dz4EdGx/JmvnArBFT1PfuBkds8Z2tuW9dRtRCqtt0CQfuLPJ+FGSfZcCY94LpY530yAx/kLGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733523356; c=relaxed/relaxed;
	bh=GevLmvfwiXsrwkExVMB51n5zrgaKIKEjgRHeUZKe3dA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=F5VLU8r9M3/Hw4OUOXNzsm7WLw48CTwkTNhNqpjuJ7bdqlZ6kVimJf+gPYjtZV8GpIukm2+GPHUcsaG3xGHitOjRHDdvlyeeZFisHs9FGAAZ28U0IozASuMkcEmVnXHKBESw7kKG00pARMEuPzf7Wx9C9M7SBJuFW5jMjuCGQFJ2Uiuaq9vHDkcUpVTVFkPI/TGxftiVKM30WXiDYqnqfMB91XHDdt/R789MojJI83I0OrgtHQMljMGN0+6cAG7ALMG5lHzbAy4CIwV2apX0exUdcGvNdcrjT9UBzP91f17eTgYFI+CnfmwXz2njUeQBoIV37sGqmWYjmRaF5eA8cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GvqzUsXZ; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GvqzUsXZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y4lvb23Mvz2xvF
	for <linux-aspeed@lists.ozlabs.org>; Sat,  7 Dec 2024 09:15:55 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A2024A44550;
	Fri,  6 Dec 2024 22:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0D1C4CED1;
	Fri,  6 Dec 2024 22:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733523349;
	bh=5hI/uypdQ/H8IoEyLiu4ZQJXiF2mNJEIaK8PWV6n+Us=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=GvqzUsXZoGMcNUjVnwdwKwQVvHQX3ZGAVH/1iCL4fI1Att4BK5LiOOpASFiQUA4p1
	 p+bONBwTrRgrlGDAOYAOmowbokEdDtazIvMBcOKBtsi+W3G4dr57OH3vGpUSlNJO1I
	 uwcQ8VtvlQlhR/ktqYNx97hG/IBDHkThDgtQLffUYtHfZKgXIx6VZusZdp0kGT8iiG
	 S1+5EoLHmj9ZIwfRmstGG2N7U7HRbQepRqApC7i0+qlyvQu8UGY1jlZMFXG7AZwQ10
	 A8QMNELaAHuyoclDsPYHiFEw+CZlXv6FmrCw4R77ukLGfhUhEC9TI3FL5d42aDMEx4
	 cm16AMPPg28sg==
Message-ID: <c898338622625cbfc825e8d4cc5f0fff.sboyd@kernel.org>
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
In-Reply-To: <OS8PR06MB75418449B451224C5AB46FBFF2302@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20241028053018.2579200-1-ryan_chen@aspeedtech.com> <20241028053018.2579200-4-ryan_chen@aspeedtech.com> <287924eed186e3b6b52cd13bcf939ab6.sboyd@kernel.org> <SI6PR06MB7535F5D22E3FCCF5C610B307F2552@SI6PR06MB7535.apcprd06.prod.outlook.com> <a68516df98c8b8fb80f094e6e55fcb8d.sboyd@kernel.org> <OS8PR06MB75419637D55A022300E00850F2352@OS8PR06MB7541.apcprd06.prod.outlook.com> <9ccfb478d9a122db6c634e9559e211ff.sboyd@kernel.org> <OS8PR06MB75418449B451224C5AB46FBFF2302@OS8PR06MB7541.apcprd06.prod.outlook.com>
Subject: RE: [PATCH v7 3/3] clk: aspeed: add AST2700 clock driver.
From: Stephen Boyd <sboyd@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>, andrew@codeconstruct.com.au, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org, joel@jms.id.au, krzk+dt@kernel.org, lee@kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de, robh@kernel.org
Date: Fri, 06 Dec 2024 14:15:47 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Ryan Chen (2024-12-04 16:48:42)
> > > struct ast2700_clk_info {
> > >         const char *name;
> > >         u8 clk_idx;
> > >         u32 reg;
> > >         u32 type;
> > >         union {
> > >                 struct ast2700_clk_fixed_factor_data factor;
> > >                 struct ast2700_clk_fixed_rate_data rate;
> > >                 struct ast2700_clk_gate_data gate;
> > >                 struct ast2700_clk_div_data div;
> > >                 struct ast2700_clk_pll_data pll;
> > >                 struct ast2700_clk_mux_data mux;
> > >         } data;
> > > };
> > >
> > > struct ast2700_clk_div_data {
> > >         const struct clk_div_table *div_table;
> > >         const struct clk_parent_data *parent;
> > >         u8 bit_shift;
> > >         u8 bit_width;
> > >         u32 reg;
> > > };
> > >
> > > static const struct ast2700_clk_info ast2700_scu0_clk_info[]
> > > __initconst =3D { ...........................
> > >         DIVIDER_CLK(SCU0_CLK_AHB, "soc0-ahb", soc0_ahbmux,
> >=20
> > Can you also show what soc0_ahbmux is?
> It will be following.=20
>=20
> static const struct clk_parent_data soc0_ahbmux[] =3D {
>         { .fw_name =3D "soc0-ahbmux", .name =3D "soc0-ahbmux" },
> };

Instead of that, please use only the index.

 static const struct clk_parent_data soc0_ahbmux[] =3D {
         { .index =3D <number from DT binding> },
 };

