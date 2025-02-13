Return-Path: <linux-aspeed+bounces-705-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D382C02198
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Feb 2025 01:39:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtdCP112rz301B;
	Thu, 13 Feb 2025 12:39:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739410785;
	cv=none; b=n5XRNGfkVz6jyKbK7n8KjqshtPXJ46wBvwAwxQ3kGeA6JFGDoKIldjQ6TO7/OXqOBxwAsrorRRptxOy6bMQPHCPKuiyqXS1lfk+EyKMQdg2z8OBfyJ76WyfFdEnqbQPpZzTvQhb4mF8ZOLJnFlYaQIC8JSBZFyIkIw/XWrdVtT0K1CKy3qIULw8p+qV5XO3HlCWwsQwmy/cE7WmUtIsglB6A6sZO9KsYb2jBEBx0d3g5XmX4bCBNJN4z5prFguHtLgDNpS7aI6aIbGusKcwRCgaVrRxcMZPy7P/CS9kZxtyiV7l9WPjWL/Sr70DkWLnHHOF5RkSkJ3jYBhNX40qJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739410785; c=relaxed/relaxed;
	bh=7ynEPinVYg58vFFqJ9Y3/dS+93WPxCWeOZ+W7+imhK8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FaMY8EhBXYg+JJCjWxXjuzkpl7rtlBo0sOuiigukJYShXsX3tuycWYIEJG0djJrbLKCPrgJZKTPvHJf+P9PGMvZIPHOrmCNIWukwWVWfv/PEPH+/7G55EC/8jecAsTeUItB21BuMyZXlITW6OrWStlSZIOFb5JQYy3iOwsUfYsZ2JHAuBa9SCPixA7A4Y9SSz1wbUdlOYq8II8xjBgjLiAg/mqNugNczBXda6NT2XXA09ISJvAIezhWb5R18f9lPFbeUeVz1J+/fKp7vN8o8TPACaM6vaC0CQgqWYK5vopBaWNCgOWfIvgUmjaIJYPOzriVtnYN1PV8j/wBcQuMGWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Fx7eib3X; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Fx7eib3X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtdCN4pk9z2yK7
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Feb 2025 12:39:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739410784;
	bh=7ynEPinVYg58vFFqJ9Y3/dS+93WPxCWeOZ+W7+imhK8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Fx7eib3XacDk4lxD4dnjY4m+ta1n7/2Jkt7TtBw5BZw5rUPmpssTEoG+roFoYDPvg
	 YGNwK+sEiNMwEAYVitnFnOjB9YGrbTA+FjTqjwgvZQHBDYWSIlOMnXzcERdzCJqPrm
	 U6H/QITP/jNkLuUV2C+PvrByCdd3hn86fqitcVUfr5K7FWaFe1GYp9YALBK9YStdux
	 iawfA8zq0tMjdDnjZBXoRyE0Ok0eacV8W+C7gLl4A6Bl6Mmsu8gARPYK61XeUBp+0H
	 3x0KZydeJ1OZQKFjDlLj6HWrKuRiAgp25OHG19g1vaHpGRY8a+7QQ82Lw5SDTWHRuU
	 QH0Cu94VW1lYg==
Received: from [192.168.68.112] (203-173-7-184.dyn.iinet.net.au [203.173.7.184])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 662197576E;
	Thu, 13 Feb 2025 09:39:43 +0800 (AWST)
Message-ID: <8e6c7913fda39baa50309886f9f945864301660f.camel@codeconstruct.com.au>
Subject: Re: [PATCH] soc: aspeed: Add NULL pointer check in
 aspeed_lpc_enable_snoop()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: joel@jms.id.au, richardcochran@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 13 Feb 2025 12:09:42 +1030
In-Reply-To: <CALGdzuoeYesmdRBG_QPW_rkFcX7v=0hsDr0iX3u5extEL5qYag@mail.gmail.com>
References: <20250212212556.2667-1-chenyuan0y@gmail.com>
	 <f649fc0f8491ab666b3c10f74e3dc18da6c20f0a.camel@codeconstruct.com.au>
	 <CALGdzuoeYesmdRBG_QPW_rkFcX7v=0hsDr0iX3u5extEL5qYag@mail.gmail.com>
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

On Wed, 2025-02-12 at 19:37 -0600, Chenyuan Yang wrote:
> Hi Andrew,
>=20
> Thanks for your prompt reply!
>=20
> On Wed, Feb 12, 2025 at 6:21=E2=80=AFPM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > Hi Chenyuan,
> >=20
> > On Wed, 2025-02-12 at 15:25 -0600, Chenyuan Yang wrote:
> > > lpc_snoop->chan[channel].miscdev.name could be NULL, thus,
> > > a pointer check is added to prevent potential NULL pointer
> > > dereference.
> > > This is similar to the fix in commit 3027e7b15b02
> > > ("ice: FiI am cx some null pointer dereference issues in ice_ptp.c").
> > >=20
> > > This issue is found by our static analysis tool.
> > >=20
> > > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > > ---
> > > =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 ++
> > > =C2=A01 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > index 9ab5ba9cf1d6..376b3a910797 100644
> > > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > @@ -200,6 +200,8 @@ static int aspeed_lpc_enable_snoop(struct
> > > aspeed_lpc_snoop *lpc_snoop,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpc_snoop->chan[channel].m=
iscdev.minor =3D MISC_DYNAMIC_MINOR;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpc_snoop->chan[channel].m=
iscdev.name =3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME,
> > > channel);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!lpc_snoop->chan[channel].m=
iscdev.name)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> >=20
> > This introduces yet another place where the driver leaks resources in
> > an error path (in this case, the channel kfifo). The misc device also
> > gets leaked later on. It would be nice to address those first so that
> > handling this error can take the appropriate cleanup path.
> >=20
> > Andrew
>=20
> It seems that the `aspeed_lpc_enable_snoop()` function originally does
> not have a cleanup path. For example, if `misc_register` fails, the
> function directly returns rc without performing any cleanup.
> Similarly, when the `channel` has its default value, the function
> simply returns -EINVAL.
>=20
> Given this, I am wondering whether it would be a good idea to
> introduce a cleanup path. If so, should we ensure cleanup for all
> possible exit points?

Yes please!

Thanks,

Andrew


