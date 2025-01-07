Return-Path: <linux-aspeed+bounces-338-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC62E77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 16:24:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSGbl2qwhz3bWP;
	Wed,  8 Jan 2025 03:24:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736267091;
	cv=none; b=m446rc/9pgmC7ciccqVIOX8M5DaAKExEC82AI97BXDncCPPPZb5aJ8iTsPAmdIXFGV3oW1u0TwFTZ57kkJR9NpBul+6iN7b/E+GAJfIn4IgacM6cbZ87YiTwpDvZbiy2FxNx9t9i6O9PqUy9RV4n07+R9VPE0XhWc6mAssI5F4aOQltcvf01bb4lP5ZaTz0Vh2Jw8K+q8PWaefdcdOBClDolh79itkm9mguJEVDuJySMy7dR5nkeWFoG8jGssWuBM6pZBusgykkT+SezY3hxxhI35JMoLxUW+7Zv9ioTuryeaXf4O8ph3LPXQ539PDM9Nxxn2P1l1p2WEgsMlYsvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736267091; c=relaxed/relaxed;
	bh=3+/XHKlm0uDWaGNf90vFoVIJ7tDwFWEFaxqH+12MDaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kD0PdNHlyzyrf1KcRkE9G+Aex946unVS5WvYKG2MG3zk6F+2Ec7HO/SJWmTl4cG92aUiNvnq05/cT8DR4X0jyignAk+TsUU3lWFn2cixC8UMOtS0lzv4Dj2Sj9BJNOLhcJP699Oqj8hZ1U4FYd43L2R+MDwjLDuFgwKdLOsnhmZYcv/hfqYqtjRBM2/VVwLBsxr0CaVeOr5DAgZ0uiMyJYQvaA2FycUb+k3ODYG4POxZguwD/+goXcOaB4mbuKIxP0tvrE59w1b8zYmiFmAKNSiqFeKUJBMrUc+o4DZgXz4T9KrFI/xeYlUFrtvHxzxR7pPCjmzKPkK/M/K0DOCFuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz; dkim=pass (2048-bit key; unprotected) header.d=stwcx.xyz header.i=@stwcx.xyz header.a=rsa-sha256 header.s=fm1 header.b=M9ouyZU7; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ITI393vw; dkim-atps=neutral; spf=pass (client-ip=103.168.172.155; helo=fhigh-a4-smtp.messagingengine.com; envelope-from=patrick@stwcx.xyz; receiver=lists.ozlabs.org) smtp.mailfrom=stwcx.xyz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=stwcx.xyz header.i=@stwcx.xyz header.a=rsa-sha256 header.s=fm1 header.b=M9ouyZU7;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ITI393vw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=stwcx.xyz (client-ip=103.168.172.155; helo=fhigh-a4-smtp.messagingengine.com; envelope-from=patrick@stwcx.xyz; receiver=lists.ozlabs.org)
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSGbc1SLhz3bWH
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 03:24:43 +1100 (AEDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E0C281140096;
	Tue,  7 Jan 2025 11:24:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 07 Jan 2025 11:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736267079; x=1736353479; bh=3+/XHKlm0u
	DWaGNf90vFoVIJ7tDwFWEFaxqH+12MDaI=; b=M9ouyZU7OxAYdpAtYZDUCD9BPU
	fkATgBp7F+ak/a/vC19pFscf/A5FKmkZ7yLvTb2NKz1FSetCPAlW4D6yV+BHNmCU
	F9/2bag+l7hUS8tOFZYv9Lzzsv2xVXugyM8eXTD7SOuz4VEaIuwYJst4hwtsYx+J
	2EBBbNNq70LhQ+JZO22HZ/5SKEND/jLcmnzuimerYe056sp0XxrJf6g5wa94pko3
	8UB0vsRSiCEQXgKSJxJs9ZNg3DW8SzWIJmzl8OP0QkntMj6msX+9m/ordQV58OTZ
	KBLje+4tYforzbtYVBhep32iTcuQsN3NUMYNIhyBZOfffXyS6r1/jKmvlnNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736267079; x=1736353479; bh=3+/XHKlm0uDWaGNf90vFoVIJ7tDwFWEFaxq
	H+12MDaI=; b=ITI393vwW+TCUpi3M/bOvD56LCvDfpnRjuKb//ChvuTYV0WGLOB
	5YuO8E/UPW0NTF7NEAkcTP2jj5LlzU8lMBYahuwSrd7j9DdOS05lUuIniegWsyUv
	vaJwf4RS51bJ02sFBb70r84CcLX4UqQ2Hp2rD2G6HYwuCb81yPiAjBNYHAC0Voyz
	CpJ+J7kC+5UK8syPswP1YaDqpojfeHIKz0UAVfvaSMWbKqW49mgMDzVKZb5OALLO
	zocXCBRwCycIoIFL2WVBoCoNu0kj9CPPqmAV+wIQSMtG9IldrEbnzU5dYVSY+ncX
	cIWdiqnp6dJxcgSKk6atDcD3GzF8a3oIkVw==
X-ME-Sender: <xms:RlV9Z9SJYKjh6p5FdooEkexQpJ-UaY4KCxTinCCXQcS0t-nV8qTTCg>
    <xme:RlV9Z2xDVZwHUVbqCk76FvffJqFE-HWzYIC0oxQC_45ZjHkfsNeZzX4k_P188AVEe
    0A_h8lhleyE8dhVJt4>
X-ME-Received: <xmr:RlV9Zy0V0fHkJpDBnfWkESqpVkabgs_U2RgLySVB0mUdXff5bAC0uBQaIg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmsh
    cuoehprghtrhhitghksehsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpefgkefg
    vdevgeeukedvgeegtddvjeevgedtffdvfeeiudfhteelvdfgvdduudffjeenucffohhmrg
    hinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihiidpnhgspghrtghpth
    htohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnughrvgifsegtohgu
    vggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtthhopeguvghvihgtvghtrhgvvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhk
    vghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlih
    hnuhigqdgrshhpvggvugeslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghu
X-ME-Proxy: <xmx:RlV9Z1Dea5_OSCTwNOJegcT-Z_vLR8l8RdK9CPdJhoLJqBCVyjSFAg>
    <xmx:RlV9Z2hMrViWT7lcy3j733YtpkOOuTnZDkjM7oLF626LnPPngbvUIA>
    <xmx:RlV9Z5qUNZX4Dq7JQiY3ALEDtQuw5mB06Ccqs-LHH_sWmVf0PXMzBQ>
    <xmx:RlV9Zxgz6Kc0utIRFErPCP6RuC_bEZlTNh1mDGyh8FgSllnibUs1vQ>
    <xmx:R1V9ZxMzdSuo3mUY3FpoR03yjUr-RLfJGpb8vl1jiFv9-b-_QoNWwA-I>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 11:24:38 -0500 (EST)
Date: Tue, 7 Jan 2025 11:24:37 -0500
From: Patrick Williams <patrick@stwcx.xyz>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] ARM: dts: aspeed: yosemite4: adjust secondary flash name
Message-ID: <Z31VRZg2LTd36S4n@heinlein>
References: <20241218212458.3050775-1-patrick@stwcx.xyz>
 <e3279e0c41259f165a0cde0195b196f416ac566a.camel@codeconstruct.com.au>
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
	protocol="application/pgp-signature"; boundary="PAVj/NgUE1LkrRTU"
Content-Disposition: inline
In-Reply-To: <e3279e0c41259f165a0cde0195b196f416ac566a.camel@codeconstruct.com.au>


--PAVj/NgUE1LkrRTU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2025 at 03:44:04PM +1030, Andrew Jeffery wrote:
>=20
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0status =3D "okay";
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0m25p,fast-read;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0label =3D "bmc2";
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0label =3D "alt-bmc";
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spi-rx-bus-width =3D <4=
>;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spi-max-frequency =3D <=
50000000>;
> > =A0=A0=A0=A0=A0=A0=A0=A0};
>=20
> I'm hitting conflicts (?) when I apply this on top of[1]. Do you mind
> rebasing it?
>=20
> [1]: https://github.com/amboar/linux/tree/for/bmc/aspeed/dt

Sure.  It looks like someone elsewhere changed the spi-rx-bus-width
which is causing the conflict.  I'll resent a rebase.

I'd like this backported to the openbmc tree also.  Not sure which
version is best for that tree right now.

--=20
Patrick Williams

--PAVj/NgUE1LkrRTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmd9VUQACgkQqwNHzC0A
wRnm6Q/9HIRQVMEheGRvQkFPPiZna4IbkT/Z2CMi7dI/wcwY2Pq3IMVZEBpuUGha
XE1lgC0wJUgeNRMZtR/FlrTOz5PMMhPyfZ6HuqmnZtxp9Gn6ABnIJA8VeTIVx1Px
immzzeMOgIFBX5Fa882qv3Dt/gdES6OK0Atz/iNTml/wBpXgEkfJRglGfzoKvZQU
L4RSg/97uRmMFjfuwExu9uqRcx6Dm9KRaCyLxnPphyeMYJh3ZDMD8O6FzEuq7IWA
20x0LwtNkLcRXeFCh35qtUpHeXUsAKrieTqCv4B2MvLH3ULHUoOYQEiyjsNl4/nV
rip++J+YuLli3l4ASsO3Q7nO5LDN8aFZWcN75KGhfADizDLx/mABSvVIgi4TVKC4
oaMiGylQJPtNeylH0Q1M3c7Bxiu6ZkzQrZwxyo9vhrxpSLYdXWLj3lLAlxkr1kJE
JJelTjLSaq6hrYElLRS52h1/uGa/PlRIil2LJ+y8kHRaAkD4XAj2+tyhNiFUaOww
A7XQCQhzkbxpdt3Sx9BkK1O9jUo+B9xQNxU4jVutVK89gz9o3vFgCRG7D+LTxxZP
6+2oNprwRqivfZxpO4fX1CtlXc1oP2AZax0kvwyX9mHlWiIpKQz+fzfoQRz8Nx6W
ZVbOW7hAH2n18B0fmCyuqcuMGAk/bDiSJAWcPON42gfXteuRHHc=
=KDov
-----END PGP SIGNATURE-----

--PAVj/NgUE1LkrRTU--

