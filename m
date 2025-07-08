Return-Path: <linux-aspeed+bounces-1662-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73A0C71130
	for <linux-aspeed@archiver.kernel.org>; Tue,  8 Jul 2025 02:07:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbkyb4nDqz3064;
	Tue,  8 Jul 2025 12:07:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751940455;
	cv=none; b=N+aUM0oksyGFS0PjTqG9dIMpy2JfhCi5GTxSRvr/PcqLD8Hi1xKcIUAYTUIain8Er1Iq9SpKcYulyBRdknCpoE1MkLSSiK3xpPnwpQuu8xqMtjtkucxGq/QHHBTRyEPZwSawmB6t3PdHtXepOSn/017SKbWrfpsz+uBMplVOHpIEgP/rxM23VrcStIvQ2N2NfMyX5DxX9UzAa2fCWn/mQe8bf70MxEjx7sB/40FocY0zcICM4k95Z7innh0c5nAPcdKmh7WI54ci4CKE75X9lBm40UbCYbVhO5cRmHFQZYrT0iZeqTiwIoLzdFRoE2m5nzJwkaSAgCUSIXiXJtRBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751940455; c=relaxed/relaxed;
	bh=kN2rGg2gNBfzoLzarmFrc1jj2Kw72Baij/wc1vu6ems=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aKOBBgR3N0/6KpU3jwOpq7UQJK3CBpFKleufSEzXbX5HHPo41fMc6fi1JnFXRBjoBo1tv05vYsHyeBxYgwCv0iQfFv2ydbduO8mXZLrF/5+FoquY3/z5t7iMbcpYkwt72JhNdSOxFX0HGK5wM/QYosytqq7f+yr6i13jJ+w9nbOIwjrraKRSYhw8rkgZAhRzLDRCZYhzI90XknE5l408lDH96nzVGOOEmbfTPDj7hAW3uwqPk0azLU2iCFQVX3X/P0X22k5OQq6EwN+YKCesI6C6Eo1jEpFjwfPcFAPNEZPKQuarnGlbVK7fwG25eQ58SChbOKBB9vbAWMFA1OWN9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ha7WJgDe; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ha7WJgDe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbkyb1rrxz2yFP
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Jul 2025 12:07:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751940454;
	bh=kN2rGg2gNBfzoLzarmFrc1jj2Kw72Baij/wc1vu6ems=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ha7WJgDe74gsOm+qeUSIHRg1ZoYq42zJfJfEFAdPLWCIehOh1LgUHY3Lu7ki+g3VL
	 ooAPifuT5592xzW4KaZw5xgMa4XxL+qNaTjlis5u+x1SQvCv4DDgpqdWMbB8KtLLGK
	 jnio7lHVl0gMqGHN9PhT+nK3TN9DTvVaTuzhQLh/TZCHrD66aSYjhqQ0vG5fLY0Q8E
	 YvldycIztxQPZQU5Ai8h/1FqPz4xXhaL8KMHFLLk7NMQdUPh82hUvV1Ggv3/9CauXB
	 05e+Rd10x9SxSsqfmnvkBTmJ111HvMq9x3VTctmTsiKdLUqq6+fjTFHyVQMqwl79va
	 luKLA74fgVsnQ==
Received: from [192.168.68.112] (unknown [180.150.112.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 148376ADE6;
	Tue,  8 Jul 2025 10:07:34 +0800 (AWST)
Message-ID: <24c957d3e63bf6dcd58b0807df79350d4b111926.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 10/10] soc: aspeed: lpc-snoop: Lift channel config to
 const structs
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, Henry
 Martin <bsdhenrymartin@gmail.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>,  Andrew Geissler <geissonator@yahoo.com>,
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Tue, 08 Jul 2025 11:37:33 +0930
In-Reply-To: <20250704182348.53808e0f@endymion>
References: 
	<20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
	 <20250616-aspeed-lpc-snoop-fixes-v2-10-3cdd59c934d3@codeconstruct.com.au>
	 <20250704182348.53808e0f@endymion>
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

On Fri, 2025-07-04 at 18:23 +0200, Jean Delvare wrote:
>=20
> > @@ -189,28 +215,27 @@ static int aspeed_lpc_snoop_config_irq(struct asp=
eed_lpc_snoop *lpc_snoop,
> > =C2=A0}
> > =C2=A0
> > =C2=A0__attribute__((nonnull))
> > -static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum aspeed_lpc_snoo=
p_index index, u16 lpc_port)
> > +static int aspeed_lpc_enable_snoop(struct device *dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct aspeed_=
lpc_snoop *lpc_snoop,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct aspeed_=
lpc_snoop_channel *channel,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct a=
speed_lpc_snoop_channel_cfg *cfg,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 lpc_port)
> > =C2=A0{
>=20
> I'm confused by this new calling convention. With lpc_snoop and index,
> you could already retrieve the aspeed_lpc_snoop_channel struct and the
> aspeed_lpc_snoop_channel_cfg struct. I can't see the benefit of the
> change.=C2=A0
>=20

My motivation for this choice was to isolate the association between
indexes into the arrays to the call-site of aspeed_lpc_enable_snoop(),
rather than have that information spread through the implementation.

I considered the approaches you outline next before posting v2, so
while they have their merits as well, I'm going to chalk this one up to
personal preference on my part.

> It even forces you to add an index field to struct
> aspeed_lpc_snoop_channel_cfg, which would otherwise not be needed.
>=20
> If you prefer to pass cfg instead of index as a parameter, that does
> not imply passing channel too. You can get the index from the cfg (if
> you decide to keep it in that struct), and then the channel from index.
>=20
> Or you could even pass only the channel (to be consistent with
> aspeed_lpc_disable_snoop), if you set channel->cfg before calling this
> function. Again this implies keeping index in struct
> aspeed_lpc_snoop_channel_cfg.

*snip*

>=20
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Enable LPC snoop channel =
at requested port */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_update_bits(lpc_snoop=
->regmap, HICR5, hicr5_en, hicr5_en);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_update_bits(lpc_snoop=
->regmap, SNPWADR, snpwadr_mask,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 lpc_port << snpwadr_shift);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_set_bits(lpc_snoop->r=
egmap, HICR5, cfg->hicr5_en);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_update_bits(lpc_snoop=
->regmap, SNPWADR, cfg->snpwadr_mask,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0lpc_port << cfg->snpwadr_shift);
>=20
> It is a good practice to align the second line on the opening
> parenthesis of the first line (as was done originally).

Thanks, I've fixed this up.

*snip*

> > =C2=A0
> > =C2=A0static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
> > @@ -339,6 +326,8 @@ static int aspeed_lpc_snoop_probe(struct platform_d=
evice *pdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return rc;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0static_assert(ARRAY_SIZE(cha=
nnel_cfgs) =3D=3D ARRAY_SIZE(lpc_snoop->chan),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0"Broken implementation assumption regarding cfg count"=
);
>=20
> Both also need to be equal to ASPEED_LPC_SNOOP_INDEX_MAX + 1, right?
> Otherwise the loop below would break. But it turns out that both arrays
> are now declared that way, so it just has to be true. This makes me
> believe that this static assert is no longer needed.

My intent was to convey that we require the arrays to be the same
length, as opposed to being declared such that they happen to have the
same length. It's a property of the design rather than the
implementation. All static_assert()s should be obviously true; IMO
their purpose is to communicate requirements and constrain change.

With the view to getting these patches applied I intend to keep it.

Thanks,

Andrew

