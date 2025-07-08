Return-Path: <linux-aspeed+bounces-1661-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2682FC83030
	for <linux-aspeed@archiver.kernel.org>; Tue,  8 Jul 2025 02:07:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbkxx4Rdfz30WQ;
	Tue,  8 Jul 2025 12:07:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751940421;
	cv=none; b=LfskO38xfRkG3vh/wnn3SLtTyO5/7/ukMF0hxg/AkvQswvU4u7pEVPO2Fw8XDnq+96HgFtVGh8OI8J5/mK44dd+5U/3t4Wt14UPo+qKd7dgleEHD/AgcmUYRD8kToTrz3795sKCdRHcpczF3r2L2S3yO3jUFY52sQTN58C7QrrS0fnkcZ3rgDeQ4OYmgGILI44c+GVPF48Ndp3tcu3PHlzIBxG/r93VUl8JbCXMiCjBKCdU+FIR4awFvk/MfgEDFrnC2j9tWpRUPvNJ5QEUX4Bo94aDo6ap056N8SE9dtZsl2pwiPXzQm+XHLd1lSfcvABGo/ePb1ywVW/7iSQJ7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751940421; c=relaxed/relaxed;
	bh=22aHBNm2PspGv0EtsJjFnQgJ+VWdLmQz4v9JsyG/8T0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0y9auiKstpYmBNtOqbV1GMmoywpLqbEqjTBxqmHT/TISM5ahf2kIGpGxQmcOM1GsOfzT9+BYeIYHhlAtxujWwB68v+WAulcvw0e9Gz95my1nhQnud7GIBoOAwA0qWp0rj6MgDX9HQoeJcTQN5UUUrVS2NaYh79EtpDRwwSJqBo9uaajnl7cJ07fSGkv/JmKvG9axbHuCjadpl37rGOgMm9q8p4e22AdPW/40vOGx9LsduPmC5syb6BJw6jOIZuKo0RPx0mcLxLVx7dvn6DkzO99f05/Ydax3u4udW/Wtsf9dmZHEaK+FaJ69KZmx0NxKSIbX3lJqphz8dSJPralGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=HrxfvQZM; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=HrxfvQZM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbkxx1Tc4z2yFP
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Jul 2025 12:07:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751940420;
	bh=22aHBNm2PspGv0EtsJjFnQgJ+VWdLmQz4v9JsyG/8T0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HrxfvQZMQqxlV3pXxRhc8vFKhJqUddUqywz7ltue+x0o9avwg4/C/7Tyu2+x8F4+Y
	 uLSwX3Soo59Ol+gx+Sl2/YWPD0VqA1iXFh89OzNL3I1wZd2G6Iyza4EkoQDnZNhw71
	 CPF4OhNGGJJno0BrvTmasL+ExIxwNKGS1rNFAV459k2bOlMBvkBQZbUEV/Em19/nnr
	 2IBpFcdfreG7UHRahfoXaFWMAYJ8NcTW97QpghRjVsMZuaC3X54FL6q70XNGsMZJuc
	 ksk8J/tDPelZVLBHwgMdHzanvSFHN7eikJMJP5P3DqigxlvntjJbs0Q3YgJGoCDOuL
	 RGiqDY0xEqS3A==
Received: from [192.168.68.112] (unknown [180.150.112.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 08D9A6ADE6;
	Tue,  8 Jul 2025 10:06:59 +0800 (AWST)
Message-ID: <6ae95d064de0c1b6333c234e461eae3e8da80168.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 09/10] soc: aspeed: lpc-snoop: Consolidate channel
 initialisation
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, Henry
 Martin <bsdhenrymartin@gmail.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>,  Andrew Geissler <geissonator@yahoo.com>,
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Tue, 08 Jul 2025 11:36:59 +0930
In-Reply-To: <20250704171315.30300f59@endymion>
References: 
	<20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
	 <20250616-aspeed-lpc-snoop-fixes-v2-9-3cdd59c934d3@codeconstruct.com.au>
	 <20250704171315.30300f59@endymion>
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
Precedence: list
MIME-Version: 1.0

Hi Jean,

On Fri, 2025-07-04 at 17:13 +0200, Jean Delvare wrote:

>=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> > =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 51 +++++++++++++++++-----=
-------------
> > =C2=A01 file changed, 24 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed=
/aspeed-lpc-snoop.c
> > index 8dbc9d4158b89f23bda340f060d205a29bbb43c3..9f88c5471b1b6d85f6d9e19=
70240f3d1904d166c 100644
> > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > @@ -294,12 +294,21 @@ static void aspeed_lpc_disable_snoop(struct aspee=
d_lpc_snoop *lpc_snoop,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfifo_free(&channel->fi=
fo);
> > =C2=A0}
> > =C2=A0
> > +static void aspeed_lpc_snoop_remove(struct platform_device *pdev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct aspeed_lpc_snoop *lpc=
_snoop =3D dev_get_drvdata(&pdev->dev);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Disable both snoop channe=
ls */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aspeed_lpc_disable_snoop(lpc=
_snoop, ASPEED_LPC_SNOOP_INDEX_0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aspeed_lpc_disable_snoop(lpc=
_snoop, ASPEED_LPC_SNOOP_INDEX_1);
>=20
> For consistency with the probe function, I think it would make sense to
> use a for loop here as well, instead of hard-coding the channel number
> to 2. That way, no change will be needed if a future device supports
> more than 2 channels.

You're right, but for now I'm not bothered by it. I'm going to leave it
as is, as the motivation for the loop in the probe() path was to
consolidate the logic required for both channels. This one is an easy
thing to fix down the track.

>=20
> None if this is blocking though, so:
>=20
> Acked-by: Jean Delvare <jdelvare@suse.de>
>=20

Thanks.

Andrew

