Return-Path: <linux-aspeed+bounces-2126-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657CBCA1007
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 06:52:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGtZX6TkPz2xnw;
	Wed,  3 Sep 2025 16:52:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756882324;
	cv=none; b=W1WvEgIj6sby3zKRizpQhU2YglhUt53wN9efUaWoZJe7De2lmTwSSJDNu5PdlIESY80fvjDFXQpNCGkI7IAvHs75YHM+/f/KPG6HHeVBYqiqkuVcGbxUDz/3RcorsVWQW7Z5yKgNt/IhemWivskTMKIa5APJs5wdaFRhh922xsv2emuJJNyyPOqSE3achRSFwJMdz3t9oIUQY6e2pnHos2KqPrbEPBIKVlh/cUelU1eHpEQfe3efHz5qtLQ3UHysngtF7PFYosDG8AAr4mzilO/+LY8NwUMNaVcyyN6CyXiXXycATS7Gt3ODyrQ4yk6rNnDtvgKdE7Vi0nlk7B6USg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756882324; c=relaxed/relaxed;
	bh=iX6E278sLnenR0ElEl7fBs88lDGzWQdjTL8gZ1XkMuQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bpsYeQSQsUStzk0xO/3OO/zDlBYijmNfGMj8fJY9YFuQGn6MGS9BFizPaaUHllfnFNhj39PKLirSDobIW2L/P5ozpbD0b7PUVS56MxgWcUeEat9Z2O7FyzZ1kX37vxe+h9OE4eMsdD23ox17R9h4SF9OydQSu9YmVBMlOMXCExIKr3TaJQwPMXptP+mZ13lYBsAHBjuu3uD2SooeO7TCXb9UuvC5O7zeRtFh/m2MweFOU8s1U4siiOeYGo4G70jrHxHdIas6i7aIeytTn3ZhO3AcwXj4gNr/WZXiJn3C7kMFVhauJnu+36cW7Le13PauKlkc0QHxO06tnQKBEL2pFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=dAHoAAqa; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=dAHoAAqa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGtZW5cjRz2xQ4
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 16:52:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756882321;
	bh=iX6E278sLnenR0ElEl7fBs88lDGzWQdjTL8gZ1XkMuQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dAHoAAqaJCfLWv6t/f4kUcLxb4ed9cEPu8uYgdRqon2TC5yW7HPgF4I3f+d7kIIrd
	 HD/2tREDqXOl3kP5qf9DzVqylPq6JZd8JvlxLr0WbyxJeZCppIGrM90WtcWTMeAqgx
	 vdCR4coU5Dc5OaC8G9KUMIiDtGywshOBQEYWeze1jz1dFVQXTTrWSNPTiH/RpWCMrR
	 Z0A1pPWpYjmf9L4oZ8Rs2hkjuAoVDX2z+3zo5ZBGwRgBY0DHoH7trP/vMCaiemfnaB
	 1rxVGui1XlMhDkeNIs7crK3W9K/s9WmwzW9cikY6D6y7GVWwLcqNszRtEwLV71GiPa
	 RzbNftqiDUHWQ==
Received: from [IPv6:2405:6e00:242a:e4ac:24d9:ee83:45da:199b] (unknown [120.20.133.19])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6799D6445D;
	Wed,  3 Sep 2025 14:51:58 +0800 (AWST)
Message-ID: <360776d4dd765dc2c98f0c1b718fe63d4a8a70d4.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: Fix/add I2C device vendor prefixes
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Date: Wed, 03 Sep 2025 16:21:56 +0930
In-Reply-To: <307fa87eb552ac4a1f6dd6139450786195e3892a.camel@codeconstruct.com.au>
References: <20250815230841.3487764-1-robh@kernel.org>
	 <307fa87eb552ac4a1f6dd6139450786195e3892a.camel@codeconstruct.com.au>
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

On Wed, 2025-09-03 at 15:01 +0930, Andrew Jeffery wrote:
> Hi Rob,
>=20
> On Fri, 2025-08-15 at 18:08 -0500, Rob Herring (Arm) wrote:
> > The ASpeed DTS files have various I2C devices with missing or incorrect
> > vendor prefixes in their compatible strings. This hasn't really mattere=
d
> > and doesn't impact ABI compatibility as I2C devices get matched with th=
eir
> > vendor prefix stripped.
> >=20
> > With this, the "maxim,max31790" nodes now validate and have some
> > warnings. Remove the spurious "#address-cells" and "#size-cells"
> > properties to fix the warnings.
> >=20
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > =C2=A0.../aspeed-bmc-arm-stardragon4800-rep2.dts=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
> > =C2=A0.../dts/aspeed/aspeed-bmc-facebook-harma.dts=C2=A0 |=C2=A0 8 ++--=
---
> > =C2=A0.../aspeed/aspeed-bmc-facebook-minerva.dts=C2=A0=C2=A0=C2=A0 | 24=
 +++++--------------
> > =C2=A0.../aspeed/aspeed-bmc-facebook-tiogapass.dts=C2=A0 |=C2=A0 2 +-
> > =C2=A0.../dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts |=C2=A0 2 +-
> > =C2=A0.../dts/aspeed/aspeed-bmc-opp-palmetto.dts=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
> > =C2=A0.../boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts |=C2=A0 4 ++--
> > =C2=A07 files changed, 14 insertions(+), 30 deletions(-)
> >=20
>=20
> I see you've applied this to your tree. Sorry for being slow on the up-
> take, I've been focusing on other things recently. Happy to take it
> though, if you're happy to drop it?

Actually, do you mind dropping it from your tree? It conflicts with
Krzysztof's patch that I'd already applied:

https://lore.kernel.org/all/20250819131743.86905-2-krzysztof.kozlowski@lina=
ro.org/

I've applied your patch here with a note in the trailer:

https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git/commit/?h=3Da=
speed/dt&id=3D61a913644a8c5b6c8bd9da09f78f88e50edfaeb

Andrew


