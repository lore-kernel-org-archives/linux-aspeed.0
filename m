Return-Path: <linux-aspeed+bounces-1241-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F33DC54F30
	for <linux-aspeed@archiver.kernel.org>; Tue, 27 May 2025 14:13:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6F3W2ff5z2xPL;
	Wed, 28 May 2025 00:13:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748355207;
	cv=none; b=BTcMmh0VfBsm7Zg9zccYcJqwIySHfs6PfRJ4TajAzp+CYnHqtgxC5O9ZPpg6H1DmsULB4uynuVWcvTDgAzzAujobuGoc5omweP7mdz6bV0BxCgat+wdHDETKYQx/tnv+j9JhaxpQfyBvlz6VdkpzNYICNUmqZKWAQhn3K9biWSEbEvZlbQfyh+7ob60crvapyzM6RnoOHyr6DwU5Zj0L2xOVOex3a/vYuBmRt5z1HoqzMCF1mXsbAt1C4Gh9HVNmoxFwqNNUZBfqD1Q0zXRWkxD1H4m52Or5XBoQYJ3zvL3XdwhucuAO7EqYtVIcjeDshXV9VLWM2+MyeFy3ZOn9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748355207; c=relaxed/relaxed;
	bh=I3K86fNEmzLGXmR+LN27EJiuIkSaPt0ARV8IrPHQSGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt9XuXn70g2iKSYEA3L/x0kKWmnCeqzNuWWLtJem/pnX3CTVNK9VMEz7Z6DQEyQjqVY5ddOzUXr1FOL86QBN8SYdoUs9IwV1k+VYP6+4XRYVohg3oU/WFBd48w28ajIlaOXcfQVFV+mgAd7KNUvZ6Abm3FxdHnOxcmhaEB2QDegpXxu90P4Wu3t6inGarxjtedTIbQ4nI/SKE1XWgl8QS0UtbFUHGipHv8bACywCo61k4+tRYL2+P8EXvsKy/JGB069QsGgssYDjTYf0/y5fMZNVS3PO2k/mtxJ2opaS7L1Zwz6an5Nrhu1vewHZhdEIpEEQZrCFRopwMGmc219YgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Dkn/sBqo; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Dkn/sBqo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6F3V0zT3z2xKh
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 00:13:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E7894A49FF4;
	Tue, 27 May 2025 14:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4886C4CEED;
	Tue, 27 May 2025 14:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748355202;
	bh=s1/Fl3iRmGCQlCudqjCG+PZ70PcwovATM6h2BAyhIz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dkn/sBqocoIftLHlFTZ2LSlb4tK30ZM9SKUm8A/A+h5H7XH2GqTiTqzc/tYvAejl0
	 LwGIrtc//qPJNWvU51AoNto0CnTUxzaHfxd6wY7i/6WskrxAZv9vI5rXySLi47l9ha
	 FTFaDaYQgxEexSY6vd5F1CAiXEuTXtpbisYVWW2EU9ddhinJhoOJCrXYqKL1PS/ETU
	 FdErHUk5oVgvfzMcfbxPOIV0UKzqiEQJk+Of/8t05Fb8LoS5gWg6m9uGNfT6bhnL0I
	 oFYM+7YuUq8g7x7Kbsqc8D0O2fy5PiLCrmYrhVNKMZV/daF9cXkTOZFMpu9/icjRNv
	 UG4yWwL98RTMA==
Date: Tue, 27 May 2025 15:13:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [net 1/4] dt-bindings: net: ftgmac100: Add resets property
Message-ID: <20250527-sandy-uninvited-084d071c4418@spud>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
 <20250520092848.531070-2-jacky_chou@aspeedtech.com>
 <20250520-creature-strenuous-e8b1f36ab82d@spud>
 <SEYPR06MB51346A27CD1C50C2922FE30C9D64A@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oF1MzhfhQDns9knz"
Content-Disposition: inline
In-Reply-To: <SEYPR06MB51346A27CD1C50C2922FE30C9D64A@SEYPR06MB5134.apcprd06.prod.outlook.com>


--oF1MzhfhQDns9knz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 02:20:48AM +0000, Jacky Chou wrote:
> Hi Conor Dooley,
>=20
> Thank you for your reply
>=20
> > > +  resets:
> > > +    maxItems: 1
> > > +    description:
> > > +      Optional reset control for the MAC controller (e.g. Aspeed
> > > + SoCs)
> >=20
> > If only aspeed socs support this, then please restrict to just your pro=
ducts.
> >=20
>=20
> The reset function is optional in driver.
> If there is reset function in the other SoC, it can also uses the reset p=
roperty in their SoC.

"if", sure. But you don't know about any other SoCs, so please restrict
it to the systems that you do know have a reset.

--oF1MzhfhQDns9knz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDXIfAAKCRB4tDGHoIJi
0gH9AQCRLkHk3neNHshJkYAPhnXtXcmS1T4OLHZhP/AyJZlligEAroQq3M9Xp8gF
CRE717jgbijLXCXCNR11jW1nOPCN7g4=
=2CfM
-----END PGP SIGNATURE-----

--oF1MzhfhQDns9knz--

