Return-Path: <linux-aspeed+bounces-603-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BE8C0218A
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Feb 2025 03:40:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YmXLt6z7yz2ywC;
	Mon,  3 Feb 2025 14:40:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738554006;
	cv=none; b=Pyo3VJ3HI0+FRaHECFbKnzMfslkNC8WoXc2ZkpAx4Aq0OQdDtObR5T0L01RfSqMPcCK6fpSBh70jPbIVW+3iWvshDykRObLVRazTuKU0up3NchX0Ei6dd03pV1VBRlefA5kz/LpP73+kegDF5KPb65t0UaddXsixFM9pQIB6oyrFZyGJIuTBCuXEGiuoC8PKPA2+CLqYdXZH2ODbYQZryrkk2B3nmmcAC29YJxuuiv+AYQIvXU0ItS7GlDMv4P7llsD7V0MWI652JFc7Sn7VLpcFsMtnzTNhWPBAu5330BHz41QHDWH8znPWR7BiksIEjrrT4Phsarw1P4f6Qm7naA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738554006; c=relaxed/relaxed;
	bh=zfsuTILH/eWQPUyqwomkj6abdgucor8q4nBTCb+4ETc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lgZLWF9BcZhmVZ/jMPD99kA+gvR943cUtOjeF9UEDvMhEjA7+5OXE1VIiYonr+FXgSorjno5mAF4rLkFQrjaeTNHJSwckgipJGJwYo6P6k9FINLg4N1rCBG5KImJ0yMNj/W02H4YfJSU0EuPWXgLK9TcyxMYajqT2pMu9Kw3HT7+kGqRCg1xhqJodH1/4HlEH6tDzHI3OsaDm+xqxlhDhvyh8SyhBGfuoxiwvz+xPM38g/HWM7IKNrxoBT4VMwGVvFI9x8p0afvYgcjj6mpW5/h2W4wXJkFJnUpWx6KOfjz9Q4AAkz0oGvpizRiE1ft/eegHLpEMyqh03/9tHtCq9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=HOwZ4qqw; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=HOwZ4qqw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YmXLt1tmpz2yvv
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Feb 2025 14:40:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738554005;
	bh=zfsuTILH/eWQPUyqwomkj6abdgucor8q4nBTCb+4ETc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HOwZ4qqwuL2nhQDO404IUhiOe6WgQ0UWJ16RPrNcLSbwR/Hrc19MOhREnPeveUeGI
	 MvCdTW9QM1Fqe4+XlwgL2Vj9T/YcmUDxJvWG/kFYvUeDJJhQl9IkZH6fvs8eNONBtY
	 yqbMbwjarHMi1+fi4zfrW9wOjpfFei24503rqo7prYGErIRl2SvKFnB/oPqb/vwhsJ
	 ciG4Pp5T1+yB8JCOym/n2V+PNOJv1EbvmwlW+wGm371p6nObXvu2ryu37FjTD2lPPr
	 /BTJW5+Fe38J4r9Nam2iUNio8CAdQvyvkiz9Kh4hehIqknWlQW2dgy5IWGf4SpWGfw
	 og3yw2L4w86hA==
Received: from [192.168.68.112] (58-7-156-140.dyn.iinet.net.au [58.7.156.140])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 64E8A73C54;
	Mon,  3 Feb 2025 11:40:01 +0800 (AWST)
Message-ID: <df21af9083a189bf9d2598ee4658f9e45fcdde5f.camel@codeconstruct.com.au>
Subject: Re: (subset) [PATCH v6 1/3] dt-bindings: mfd: aspeed: support for
 AST2700
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Lee Jones <lee@kernel.org>, 
	"robh@kernel.org"
	 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org"
	 <conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>, 
	"mturquette@baylibre.com"
	 <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"p.zabel@pengutronix.de"
	 <p.zabel@pengutronix.de>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	 <linux-clk@vger.kernel.org>, "dmitry.baryshkov@linaro.org"
	 <dmitry.baryshkov@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 03 Feb 2025 14:10:00 +1030
In-Reply-To: <OS8PR06MB75417CF1E84556D1492EADF4F2E82@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20241023090153.1395220-1-ryan_chen@aspeedtech.com>
	 <20241023090153.1395220-2-ryan_chen@aspeedtech.com>
	 <173047754439.1930424.6922132618537420144.b4-ty@kernel.org>
	 <OS8PR06MB75417CF1E84556D1492EADF4F2E82@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

Hi Ryan,

On Fri, 2025-01-31 at 03:51 +0000, Ryan Chen wrote:
> > -----Original Message-----
> > From: Lee Jones <lee@kernel.org>
> > Sent: Saturday, November 2, 2024 12:12 AM
> > To: lee@kernel.org; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; joel@jms.id.au; andrew@codeconstruct.com.au;
> > mturquette@baylibre.com; sboyd@kernel.org; p.zabel@pengutronix.de;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org;
> > linux-clk@vger.kernel.org; dmitry.baryshkov@linaro.org; Ryan Chen
> > <ryan_chen@aspeedtech.com>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Subject: Re: (subset) [PATCH v6 1/3] dt-bindings: mfd: aspeed:
> > support for
> > AST2700
> >=20
> > On Wed, 23 Oct 2024 17:01:51 +0800, Ryan Chen wrote:
> > > Add reset, clk dt bindings headers, and update compatible support
> > > for
> > > AST2700 clk, silicon-id in yaml.
> > >=20
> > >=20
> >=20
> > Applied, thanks!
> >=20
> > [1/3] dt-bindings: mfd: aspeed: support for AST2700
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 76c6217c31266e800b67a476bba59dfe=
b9858a90
> >=20
> > --
> > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>=20
> Hello,
> Since this patch have been applied, if I still want modify I will do
> the rebase and still patch base on this.
> Am I right?
>=20
> For example I want to modify include/dt-
> bindings/clock/aspeed,ast2700-scu.h
> I send the patchv8 [1/3] patch for aspeed,ast2700-scu.h
> Others [2/3], [3/3] still progress, am I right?

I'd rebase the series on top of v6.14-rc1 and continue incrementing the
series version. You've replied to v6 here, but I see v7 at [1], so I
guess v8 as you suggest?

[1]: https://lore.kernel.org/all/20241028053018.2579200-1-ryan_chen@aspeedt=
ech.com/

Andrew

