Return-Path: <linux-aspeed+bounces-4073-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8027ECD4F49
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 16:28:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK3Bk0H7Rz2xrC;
	Tue, 19 May 2026 02:28:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779121693;
	cv=none; b=QXRXHDW0NTROQfLgYdakSFjoVnbrHIYrv42yAGafIlMV7GWGlZIefN/R0+YwFRmUwbP5+hX+NE8YxJA6Xpi2JfDuXb38mZQq9UfcRCq5X/XQLcYxA3rZ6dE8fERoxORoRvGIypxq6TrzPfFvZ+BtVJMtpuu6mqVNmg0+TSA6vnLKMIsTgBn/tdPAtIvXXig0NjjAaKTXn8alIHFYJOjOWcaM18tt97vQeWAnWkmlGdZN1nAF1KPr/FuI0ytxFXA0lYqkceE48Rhf07/chCoqg6Xh6LsW5LspbLOTvBA7pOI+zom31bGyGrBWIelukB1RAuPvPozuAB7UjSv0rE7naQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779121693; c=relaxed/relaxed;
	bh=3jGoaYLrIdfY8fxCt8RE2gFSjMDiP51+IVix3OYHhPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0qZdQCX5yIaO1OMV1o2hw9hZD83WMSTf3zklVw+UsArKc1H9TRh6cayatapIRW9QQAvYRo2PxOSBiUM3klZKVdELMO+6XdqbF5utQfJRRflF3iRmm9L+fM/rGxotIi1UplxZt+CD5V3FmtE/gn/yyTCIqDXjmYnsndQdCXJEI5IN7nqQEG+InUXOwnD6rKWXr70+PibsRqS0TBHZw5DHY734TcX1s5pJ0t+mLAxw+xkuSHTcIiu7p+c8bz6EgRzaRu28CzRHrHjF713ZODm4EtcUBLrzBI4RdsM4gW7FZA+XVsyCvuo8U7m9pEuC7BGVpbyY2d6EdyMokdsnWPg9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p7ExYI8T; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p7ExYI8T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK3Bj2xK2z2xpn
	for <linux-aspeed@lists.ozlabs.org>; Tue, 19 May 2026 02:28:13 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 800B54343D;
	Mon, 18 May 2026 16:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FF6C2BCB7;
	Mon, 18 May 2026 16:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121690;
	bh=3jGoaYLrIdfY8fxCt8RE2gFSjMDiP51+IVix3OYHhPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7ExYI8TItuqZz95XMRoZ60wsT3UBHH2czPLr5/hOQB77QY5jQITBge2xlNIE8AU5
	 Cd0yMJccZO37BZlp4CSoOlnL6pKqrLS9AB00DVqJEdwEElj1djSAdXCcCbPfLBYDIc
	 y0wr49RKJ5QoWDhKZCXz9PsOGJtOkdPnpO67XXfslPcJrojB6I2crWCJuJVyshJ5mp
	 /JAVg1+isUTuinLFcZ2Ttug/pj3bhbuIL2qERaPCyvdFsE7ur2Ak8laaFj31/A6+Dq
	 wBfAvnmllN92N02lhiySqatuyuNrOXtfqogL0yUJKMjI1Ji+FdUhSa7OSp76aK+0fQ
	 XOLggQ0TPB4OQ==
Date: Mon, 18 May 2026 17:28:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Neil Cheng <neilcheng0417@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: Add Meta Rainiera6 board
Message-ID: <20260518-contented-untimed-85b12903469f@spud>
References: <cover.1779088499.git.neilcheng0417@gmail.com>
 <4f7aee0a2dfc44770347ccc82e54820e7b35317c.1779088499.git.neilcheng0417@gmail.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D4Ni9Iy8zbLh/XVa"
Content-Disposition: inline
In-Reply-To: <4f7aee0a2dfc44770347ccc82e54820e7b35317c.1779088499.git.neilcheng0417@gmail.com>


--D4Ni9Iy8zbLh/XVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--D4Ni9Iy8zbLh/XVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCags+FQAKCRB4tDGHoIJi
0h/xAQD/GO09ESffxZeEWy0y0qDA2FYxyklacN0+YEI/W2UZ3wD9EAzOZtufjk4m
QRtp9ItGZJ9m+ezm/FyqrNQTH/CIlg4=
=dcZV
-----END PGP SIGNATURE-----

--D4Ni9Iy8zbLh/XVa--

