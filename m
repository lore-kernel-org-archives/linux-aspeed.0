Return-Path: <linux-aspeed+bounces-773-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1FCC021AA
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Feb 2025 01:25:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YyJc317hrz2yFQ;
	Wed, 19 Feb 2025 12:25:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739928323;
	cv=none; b=cD7iv+e6/ReJ+LprCDgCqKDWIsb8HIyP/brgE3ex+fvq+CvZd01akmD+ysOw6CCjUWvI3uoQrYoV0AwunWdg4D4WIGse9gx8be+NbkI7p9Dxu2bF692Zc0TRLffO6lqCzaL21/d3IxAonfNeqcaj8/cuo5lLJw42r8Agbp+8IMFuK4hy5htwI5g34IIKPmWo9MhlyMwFZGhS4PuzgzN9n4hTf3/JqhWT+UCa/4VTVpPi+adXj2GRg4N2uIk9H+Kp3O84a8A0Nquixx/7PYpg77PBvQ56pn0qbwBuFkpH1oN7F9I2gZohZ0bPNLsVL/JuoXhRtlk80GUs2JNWk9L/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739928323; c=relaxed/relaxed;
	bh=dkFhdB0sw0/QyG+CwpMOC58rxh7WXIHCwBFRv+IGTiY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wpe5jkQLjP2klHfbN2QQ6fOTPuljxqoKUrWuMXqcEAL90Z00KtSt1fOsvVMZgM2ilUou3dPLggOVQL7CUEtamkHJDi2z1jDNSDHbTs9D9r5xo2ukiyoFyo84KuDjVMy8Daolz4gWAkRHfcaNWTQjqo859wmdXyduAeVIeQtI8dsZ4/vMShjygKnVHcup1rtmvo4pEzDHaaiJRxeaUa3D4f9yf7CHlHSBQFdjY0ymQqmjC4iT/79eYXw6BNBjcjA9yZJaq1JOj2pLtqxi+lbS3Jx44tf9kz/TrxBTmVEiIXlF7uJlcASw+E/insESzIOdipSt/mnx2en5mizm6zsNhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=avb2FyYT; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=avb2FyYT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YyJc21KsPz2y8V
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 12:25:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739928321;
	bh=dkFhdB0sw0/QyG+CwpMOC58rxh7WXIHCwBFRv+IGTiY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=avb2FyYTTBY0LlkaOkCWpVHdubriDy15YcVmzOXNlQiNvvVH4Edal4xm7c3TFeLde
	 caVsMWd0Y6xZbmPtPyQAIMN6ycCu92Xcth4M+4NFXk+EsV9VN7YJVYQkUqQkgmQhRU
	 Y0vm11gVt7B7X5KmbiK3eTG3nOGez8xNILAhcwg6LdXRToDky4FlSSQUbU43PPpRV/
	 r4cn6rq8yEU/tQoV1drbOEanUU0THtZFkx/WHZVt8C7ky5Ezx3LKZ6QFXm5lw3zPXu
	 rsC9l5oM5TKZMmRfK5nWOi1FzlwDH19cuBy955S20HlvKh9uAgIoPNCabIJZvGL1uE
	 r+E+cydkmu7KA==
Received: from [192.168.68.112] (203-173-1-6.dyn.iinet.net.au [203.173.1.6])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 41B3476191;
	Wed, 19 Feb 2025 09:25:19 +0800 (AWST)
Message-ID: <201b57c00043e2c3590c77a4d1aba413aa576b01.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] driver/aspeed-wdt: fix pretimeout for counting down
 logic
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Guenter Roeck <linux@roeck-us.net>, Heyi Guo
 <guoheyi@linux.alibaba.com>,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,  linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley
 <joel@jms.id.au>,  Eddie James <eajames@linux.ibm.com>
Date: Wed, 19 Feb 2025 11:55:19 +1030
In-Reply-To: <50ab5a0a-b807-4bd7-bda8-7c6f4bfc76fc@roeck-us.net>
References: <20250218031709.103823-1-guoheyi@linux.alibaba.com>
	 <50ab5a0a-b807-4bd7-bda8-7c6f4bfc76fc@roeck-us.net>
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

On Mon, 2025-02-17 at 21:33 -0800, Guenter Roeck wrote:
> On 2/17/25 19:16, Heyi Guo wrote:
> > Aspeed watchdog uses counting down logic, so the value set to register
> > should be the value of subtracting pretimeout from total timeout.
> >=20
> > Fixes: 9ec0b7e06835 ("watchdog: aspeed: Enable pre-timeout interrupt")
> >=20
> > Signed-off-by: Heyi Guo <guoheyi@linux.alibaba.com>
> >=20
> > Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> > Cc: Eddie James <eajames@linux.ibm.com>
> > ---
> > =C2=A0 drivers/watchdog/aspeed_wdt.c | 7 +++++++
> > =C2=A0 1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wd=
t.c
> > index b4773a6aaf8c..520d8aba12a5 100644
> > --- a/drivers/watchdog/aspeed_wdt.c
> > +++ b/drivers/watchdog/aspeed_wdt.c
> > @@ -187,6 +187,13 @@ static int aspeed_wdt_set_pretimeout(struct watchd=
og_device *wdd,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 actual =3D pretimeo=
ut * WDT_RATE_1MHZ;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 s =3D wdt->cfg->irq=
_shift;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 m =3D wdt->cfg->irq=
_mask;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 reload =3D readl(wdt->ba=
se + WDT_RELOAD_VALUE);
> > +
>=20
> It is unusual to use a register value here and not the configured timeout
> value. I would have assumed that pretimeout is compared against wdt->timo=
ut,
> not against the register value, and that the multiplication with WDT_RATE=
_1MHZ
> is done after validation. This needs an explanation.

+1

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (actual >=3D reload)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > +
>=20
> On top of that, you'll also need to explain why watchdog_pretimeout_inval=
id()
> and with it the validation in watchdog_set_pretimeout() does not work for=
 this
> watchdog and why this extra validation is necessary.

+1 as well.

Further, the logic looks broken regardless for the AST2400 where
there's no pretimeout support. aspeed_wdt_set_pretimeout() should error
out if wdt->cfg->irq_mask is 0.

Andrew


