Return-Path: <linux-aspeed+bounces-2392-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E7CCAC5B0
	for <linux-aspeed@archiver.kernel.org>; Fri,  3 Oct 2025 20:47:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cdghz5hqNz3d9W;
	Sat,  4 Oct 2025 06:47:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759524467;
	cv=none; b=JhrLlglG4lmTpBHBbzQH5JOW4wqic3iRid8PqKCGR1QIEjifxjO8d8mC597xLl9vDSN1IgR54zPpCocZsurRclmO3pX6iC5dLMUqeYoOoxihjxbXIA+9q58Wp4r2szirrIaPwR2fI+wHRBOc+2yWwzh6Gok4pSdRFVri3J+Bxwn8rF3m+t8q4krYFZGuHbkIZJHs2eFDzfzZB/h6qILMIfceE0iPhNvEM7yQLUN+NzjeAIYsLWZ2Mmr/i0H8eicmdENInqiqyhlmH0EjxwgA9K8IG7nGtlRQwbk8X1COb1cpnyGcQ69eGQlP59+JfIqoiitj07VCstoxKM6KDDxN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759524467; c=relaxed/relaxed;
	bh=r/Ug7VqD/kAYHAJQDi9yvKwq4BwPGbWmkyV5KEW5Z6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdPIZ2YDkFt073S+AMauB5su9TwNiwXHN2Zje0tx1/d7kIxyR2e7HG5pzle6g8RA6NHc2LhlLOPohGWla1n2DgTshcLCnSrrtAqixf/DhENWMTEdzxB2lx9Rdp1UYhNVKbGKuOuXjlzUssP+Sey2mdF4kQcQdjBTGz3fpwEtOuTqbHxJr8YU8G+qqpY7pfudF+Sj5H/kAo7KmLoDyeGvQE0hI5agC+U7qOCDZF92mY06bxCshe3pEIYiwpGmPTFOLQekEiBP/0Dv9gtlh33GlYgNfp4kFLHZnVLQnXS9ljIF7bjViCWoGLUvDAm9iZ19mmNETxjXHphJHc2maQdrvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=d6y11QK1; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=d6y11QK1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cdghy6plyz3d8S
	for <linux-aspeed@lists.ozlabs.org>; Sat,  4 Oct 2025 06:47:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8D1CC40522;
	Fri,  3 Oct 2025 20:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7302C4CEF5;
	Fri,  3 Oct 2025 20:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759524464;
	bh=s9KdYwHxtmjq+rq4sojwwWTmmqYjg09bj3FGC5XSE/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6y11QK15ZptdWlP41qvreKP+B3iFmWUFkf3nCrbM4xwYUYyG9tVcIfnLscTKs9PW
	 RwKJdiQ+tHjDH6b4QYRIPTDqNM1yRC1FmVnI7xpckDbCDby6fRJDNSGLwyLmrCsMuJ
	 +EnsN/amGGUjz9mlYR90GLkIe8Xf6BfRBM29dgfEz7TqOURUVnmmusBn7haFd57Ot2
	 pRVOlOH8XaUsiBM7yX3x0MEUQ2jBX1e1ybH0Ls+ivJbWVIQPu2cA3CTiSCe+rGIG1t
	 6J2cK6X8+UjoK3QC7jNlBcjsU77FGfp8OKFRtwyDzKZpBWDFcBKhusG2TosjL+rhPj
	 A7mRq8QKyoYMw==
Date: Fri, 3 Oct 2025 21:47:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: clock: Add AST2500/AST2600 VIDEO reset
 definition
Message-ID: <20251003-gestate-roast-37ef1b1c2e07@spud>
References: <20251002095651.2211900-1-jammy_huang@aspeedtech.com>
 <20251002-accuracy-gloomily-a3e46d5a3f02@spud>
 <TYZPR06MB65687E6795F9C899B3F067CEF1E4A@TYZPR06MB6568.apcprd06.prod.outlook.com>
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
	protocol="application/pgp-signature"; boundary="1VWs/xU7QyzcZvNl"
Content-Disposition: inline
In-Reply-To: <TYZPR06MB65687E6795F9C899B3F067CEF1E4A@TYZPR06MB6568.apcprd06.prod.outlook.com>


--1VWs/xU7QyzcZvNl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 01:50:46AM +0000, Jammy Huang wrote:
>=20
> > On Thu, Oct 02, 2025 at 05:56:51PM +0800, Jammy Huang wrote:
> > > Add VIDEO reset bit definition for AST2500/AST2600.
> > >
> > > Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> > > ---
> > >  include/dt-bindings/clock/aspeed-clock.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/include/dt-bindings/clock/aspeed-clock.h
> > b/include/dt-bindings/clock/aspeed-clock.h
> > > index 06d568382c77..421ca577c1b2 100644
> > > --- a/include/dt-bindings/clock/aspeed-clock.h
> > > +++ b/include/dt-bindings/clock/aspeed-clock.h
> > > @@ -53,5 +53,6 @@
> > >  #define ASPEED_RESET_AHB		8
> > >  #define ASPEED_RESET_CRT1		9
> > >  #define ASPEED_RESET_HACE		10
> > > +#define ASPEED_RESET_VIDEO		21
> >=20
> > What's up with the gap here? Are there another 10 resets missing?
> Thanks for your review. I find this is just an index of reset map. I will=
 update
> new patch later.

I don't know what this has to do with the question I asked. What's going
to be in the update?


Cheers,
Conor.

--1VWs/xU7QyzcZvNl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOA2awAKCRB4tDGHoIJi
0jDmAQC9H6FC4Z5rZxCYUvmj2W55k+/oKnx/O91NA9fjEXpn4wEA1EUm7O+71S3h
KO0JSohz5byNmEAy5MoQILoMqD6k2Aw=
=MtpR
-----END PGP SIGNATURE-----

--1VWs/xU7QyzcZvNl--

