Return-Path: <linux-aspeed+bounces-81-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B00D33A29
	for <linux-aspeed@archiver.kernel.org>; Tue,  5 Nov 2024 18:53:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XjctC31Bhz2y8Z;
	Wed,  6 Nov 2024 05:53:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730832803;
	cv=none; b=RCwalb+Us02x3doRXiG6dDzpRjnjkfxvyCFF2AZsWHTFFASJNCjsnHW+aRqf+p+0/FShf7CDqriUUfg/YbxzJ0GA4M9kFDlWmOYdcjKRNcHG22Oa6HkznImfwy1Bpa63b9RHvjxRlQscj99sFqMKfMrUK7oE1N5S5Fcc+0gHqTzi4LfuPQ5TIfa52MQSkY11k1EmxOHo7HHlZ1NdoEI/oo4WrOPo8mZoJdCK567HPo+YVFSf0dxacpnI/zmiMXjewzsSY1Q2FpPkZrbLpR6cbHpA2xZojtdIwH3cMVKcuLZ836xn4wX1mRLTI8zO9ztaZAkv+U050hpzETcHuyawLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730832803; c=relaxed/relaxed;
	bh=ehmuV0mGF+56Q7DGeN7/B0OGtD8FDHl8tJhMc+L5J7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOvwEkuD0390A08FR4miBrXskMwnvpc0GuXjN+tecDTfcrx6hD/bIRd2C/1gIgFUHtNGEN2htfQMl652YTmSQ7UrnXREaLbQ/BFGlLfgYk6GEHGfiy3mN9MiyCY4bVFdcl5mAxJ0zG+U6kssVq8BPeaXE9e7v0Nu2vGB7SmMcxVDqT8nI+UhunVGoXIwhTq1J3xtEPwCwRs1L9/+FAEfNYn78zMaYHmO5xBHQgd+yXRzJBugv8wqNiZ9eWH8eJlan5MgUii6vEKrmt/PlBkVxgQtGDwgnZHjLuyfU16JVB9wBk/3fIwAOvgxgPzLr/EFLG1J974QFVh3zy6NA7psIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ci6r5DV2; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ci6r5DV2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xjct96zw5z2xH9
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Nov 2024 05:53:21 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3C0185C4D33;
	Tue,  5 Nov 2024 18:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4656C4CECF;
	Tue,  5 Nov 2024 18:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730832798;
	bh=ehmuV0mGF+56Q7DGeN7/B0OGtD8FDHl8tJhMc+L5J7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ci6r5DV2VqvCag1s6EuF1aRwGbPKGH/tDqYybfvWC09acB+ugQ+GjwdbjAN+mH/zy
	 9wUzO9DRDwMJO7FtUVQzTMYgujVqO3KDgHY6kXbZXUUv/ACutVQBpo4uUAU1A/dmrA
	 0KPfpjx8ruV3QgyNqLAhbXp661aM0b5hHIqO6Q2jXxAeyAXVw/K/s/nkR+0nALKWUP
	 k02jNQE3NdHiPOnuxzyXcaNHbBKmTI5cdXXbf4xnd5JEjzX8tA8vLQma1VRzkDEE3c
	 J1e2RY1kEInd06J27owPH5EGn3nsxBG2etos92r1tCCT23IH726/PaZyDU2W8/1lel
	 4nKNe9OV3BcCQ==
Date: Tue, 5 Nov 2024 18:53:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Naresh Solanki <naresh.solanki@9elements.com>, jdelvare@suse.com,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, krzk+dt@kernel.org, sylv@sylv.io,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	linux@roeck-us.net, Joel Stanley <joel@jms.id.au>,
	conor+dt@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Message-ID: <20241105-regroup-busily-adbb9b342abc@spud>
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
 <173072771091.3690717.11563964377469449295.robh@kernel.org>
 <20241104-saturate-device-d020a0d7321f@spud>
 <f468a5c0a0112cee35815fb6c7b7f9933934adc2.camel@codeconstruct.com.au>
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
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R4RpYoaHCnWgW7y6"
Content-Disposition: inline
In-Reply-To: <f468a5c0a0112cee35815fb6c7b7f9933934adc2.camel@codeconstruct.com.au>


--R4RpYoaHCnWgW7y6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 10:39:34AM +1030, Andrew Jeffery wrote:
> Hi Conor,
>=20
> On Mon, 2024-11-04 at 18:49 +0000, Conor Dooley wrote:
> > On Mon, Nov 04, 2024 at 08:39:21AM -0600, Rob Herring (Arm) wrote:
> > >=20
> > > On Mon, 04 Nov 2024 14:52:14 +0530, Naresh Solanki wrote:
> > > > Document the new compatibles used on IBM SBP1.
> > > >=20
> > > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > > Changes in V4:
> > > > - Retain Acked-by from v2.
> > > > - Fix alphabetic order
> > > > ---
> > > > =A0Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> > > > =A01 file changed, 1 insertion(+)
> > > >=20
> > >=20
> > >=20
> > > My bot found new DTB warnings on the .dts files added or changed in
> > > this
> > > series.
> > >=20
> > > Some warnings may be from an existing SoC .dtsi. Or perhaps the
> > > warnings
> > > are fixed by another series. Ultimately, it is up to the platform
> > > maintainer whether these warnings are acceptable or not. No need to
> > > reply
> > > unless the platform maintainer has comments.
> > >=20
> > > If you already ran DT checks and didn't see these error(s), then
> > > make sure dt-schema is up to date:
> > >=20
> > > =A0 pip3 install dtschema --upgrade
> > >=20
> > >=20
> > > New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-ibm-
> > > sbp1.dtb' for
> > > 20241104092220.2268805-1-naresh.solanki@9elements.com:
> >=20
> > Really? This many warnings on a v6?
> >=20
>=20
> I understand that it's surprising and disappointing, however these
> warnings are from the Aspeed DTSIs and not directly from the proposed
> DTS. Many are an artefact of history, and I'm (slowly) working to clean
> them up. Recently I haven't had any time to dedicate to that effort,
> and as I'm somewhat responsible for the state of things, I'm not
> prepared to block other people's patches and push my own
> responsibilities onto them.

Ah, you see that's where I would say "no new warnings" and get the
submitter to fix them ;) And were I the submitter, I'd want to resolve
the warnings rather than run into issues down the road when things get
"fixed"/documented. But I guess that's why I have the schmucks task of
reviewing bindings innit..

> I've been replying to those proposing new Aspeed-based devicetrees to
> separate the warnings they're introducing from the warnings that
> already exist, and requiring them to fix the issues they're responsible
> for. I hope that I'll have time to continue to improve the situation,
> as this is obviously a tedious task for me too.=20

Well, it is your platform and if you're confident that these nodes are
correct despite the warnings, who am I to stop you!

--R4RpYoaHCnWgW7y6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyppmQAKCRB4tDGHoIJi
0gl3AQDYMKKpv+VRW+O5chJQqZbIqtD3TSwbPLzL+iwv7LwutgD/SjKnZdTS+eIj
kcZPtile9/G6QpMnUwj4wo/u+c6FAwU=
=6O1S
-----END PGP SIGNATURE-----

--R4RpYoaHCnWgW7y6--

