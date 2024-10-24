Return-Path: <linux-aspeed+bounces-20-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E6ED0BB4A
	for <linux-aspeed@archiver.kernel.org>; Thu, 24 Oct 2024 00:18:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XYmjG44hlz2ygy;
	Thu, 24 Oct 2024 11:18:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729729106;
	cv=none; b=Bno2Zrm9MlCZLeUJf2KeMxkpq1fn6mXoA2geDjFXrb7usJFuV4QTh7iWkX4pAkXlYVxuCAfQ76OajBakBUT0g6sZu19QrzczfNRmj06C7vgNOCgdII0ZFN8op2LkV/1f59va+Q1tb/sDLuz/VQFJCmsHyC1MJF/l3Yqkq4WtQPaNuMTNX+pEJ8k6hScuI6Tg6F7kgL7W3HOr/o23ONusLQVn5DkUTLsR6AdBjjjXwt12lO+ZihZqeSakLXKVPpkjJ7l3qYAfmBjwRtQ1yvpF8ASPvwPI5QT4m+HAjkBhQlEr3dQqcozjLkFhfwEtuDM1MO62+f6y9WoLHJikgS4fNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729729106; c=relaxed/relaxed;
	bh=WtnDx7HtpgMGToc67LvWVCZkY6l3tklYm20D0ZsZQYU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QVpIaXmEBcABEF3xXrCdTjmg9MPjK726JiZXyWfnM2NDuht+w4///NyNnKg4iAAHztwE9Yta+mItbJ1PjwjuE8AizwaQhXZzaCoXQe7KyfZ4+C1urQrvU+DzM0HYd9PrqIAAuW8i+r2yZhZCAghFWCSx6sa1uZeSrw9oNqrKLY8JKlkBESfoiRDGvn4WFi8oUdHTExg6ZwGXHfn0zBzgK6295Jthd7kCKMiqsPJuVaxlipD7YSVnQ3r3AtsRmZYnudZrjOGdCzfb3I872DghsMZTqgIm8QXfE3jCQ0G+a+YXsqsoK3q9RsjMERrBePYtA59oAtcHwFvD4Ci257HJSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=YDAmSUvB; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=YDAmSUvB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XYmjF2l1nz2yNs
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Oct 2024 11:18:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1729729104;
	bh=WtnDx7HtpgMGToc67LvWVCZkY6l3tklYm20D0ZsZQYU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YDAmSUvBbl4YtLfaeZNLAXebR7kAnuQTy9tN79E1k/JZOhQi6XQiS2LcvGdpxqdxc
	 qCjFi/DwBiL1/H8TCjOtcAPJLLeirRckkhJn6NL/g1sC2qxbYSv3Q5jmq+Iis+V8a2
	 Qcv7FYFwhXXiVJhX5dZq1Wk5I0mGUzRoRjsefxJHALCE2TJbpjHx7CPEblHa6Qzfxi
	 xgXWPT/hXrUKzIiBOSkosHGsLBX8O/kYmiWHokoIiH1zTPiPNC3lywBchKq0ihIQiS
	 IMJgA31Yv6T/oYVrMUYKWiQOo1CLfMxo1h50yEqyP2TIf0imLC1DiBJtdOvBUe6mIf
	 TNBOQ3pxVoYbQ==
Received: from [192.168.68.112] (ppp118-210-190-208.adl-adc-lon-bras34.tpg.internode.on.net [118.210.190.208])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 815BB6494E;
	Thu, 24 Oct 2024 08:18:23 +0800 (AWST)
Message-ID: <32cb6d9388fb136f7cd7ad1ab0d60d83ae387982.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/2] Add Meta(Facebook) Ventura BMC(AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?UTF-8?Q?=E5=BE=90=E5=82=91=E7=94=9F?= <jasonhell19@gmail.com>
Cc: yang.chen@quantatw.com, jerry.lin@quantatw.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, patrick@stwcx.xyz,
  devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 24 Oct 2024 10:48:22 +1030
In-Reply-To: <CAFGtgY3BJcpC=Q0cYZQa01D5BFAQTt6GEr=0_mrPGUntHYVioA@mail.gmail.com>
References: <20241022021230.2322132-1-jasonhell19@gmail.com>
	 <de478e5f56bb67a9babe59afa6ad53c8dd4542ee.camel@codeconstruct.com.au>
	 <CAFGtgY3BJcpC=Q0cYZQa01D5BFAQTt6GEr=0_mrPGUntHYVioA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 16:32 +0800, =E5=BE=90=E5=82=91=E7=94=9F wrote:
> Andrew Jeffery <andrew@codeconstruct.com.au> =E6=96=BC 2024=E5=B9=B410=E6=
=9C=8823=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:15=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >=20
> > On Tue, 2024-10-22 at 10:12 +0800, Jason-Hsu wrote:
> > > Add Linux device tree entry related to Meta(Facebook) Ventura specifi=
c
> > > devices connected to BMC(AST2600) SoC.
> > >=20
> > > Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>
> >=20
> > What commands are you running to generate and send your patch series?
> >=20
> > The patches must be threaded properly.
> >=20
> > `git send-email` or `b4` both do what is expected without any effort
> > required. Please consider using them, particularly b4, if you're not
> > already.
> >=20
> > Andrew
>=20
> We use `git format-patch` and `git send-email` command to generate and
> send patch series as below, could you help to check?  Thank you.
>=20
> git format-patch -2 --cover-letter
>=20
> git send-email --smtp-debug --to=3Drobh@kernel.org
> --to=3Dkrzk+dt@kernel.org --to=3Dconor+dt@kernel.org --to=3Djoel@jms.id.a=
u
> --to=3Dandrew@codeconstruct.com.au --to=3Dpatrick@stwcx.xyz
> --to=3Ddevicetree@vger.kernel.org
> --to=3Dlinux-arm-kernel@lists.infradead.org
> --to=3Dlinux-aspeed@lists.ozlabs.org --to=3Dlinux-kernel@vger.kernel.org
> --cc=3Dyang.chen@quantatw.com --cc=3Djerry.lin@quantatw.com *.patch
>=20

So from the details in the cover letter I'm guessing that you're using
Ubuntu 22.04 LTS (Jammy). At least, Jammy ships git-2.34.1, which is
what is mentioned in the cover letter.

The --thread option in the man-page for git-format-patch[1] says:

   The default is --no-thread, unless the format.thread configuration is
   set. If --thread is specified without a style, it defaults to the style
   specified by format.thread if any, or else shallow.
  =20
   Beware that the default for git send-email is to thread emails itself.
   If you want git format-patch to take care of threading, you will want
   to ensure that threading is disabled for git send-email.

[1]: https://manpages.ubuntu.com/manpages/jammy/en/man1/git-format-patch.1.=
html

The --thread option in the man-page for git-send-email[2] says:

   If disabled with "--no-thread", those headers will not be added (unless
   specified with --in-reply-to). Default is the value of the
   sendemail.thread configuration value; if that is unspecified, default
   to --thread.

[2]: https://manpages.ubuntu.com/manpages/jammy/en/man1/git-send-email.1.ht=
ml

Since you're not supplying any thread-related arguments in either case,
I wonder if you have thread values set in your git config. What's the
output of the following two commands for you?

   $ git config --show-scope --get format.thread
   $ git config --show-scope --get sendemail.thread

Regardless, you may want to try passing `--thread` in your `git send-
email` invocation.

Finally, please pass `-v $X` to `git format-patch` to version your
series (the value for X is how many times you've sent revisions of the
series). Currently I count 3 distinct attempts, so next time you send
out the patches you should pass `-v 4`. However, the b4 tool is helpful
here, as it largely automates the process for you.

Andrew

