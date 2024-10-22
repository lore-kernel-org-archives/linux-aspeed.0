Return-Path: <linux-aspeed+bounces-11-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEBCD2CDFF
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Oct 2024 16:52:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XXysf06dJz2yVb;
	Wed, 23 Oct 2024 03:52:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729615973;
	cv=none; b=eW7gRlyT5gMhuIqZTsYiRH3oXzM9Ku0WwCx4jf5pybZNSga76uBTcNYz0HkYSg5H8VOGxOwONAel17mHGrkhI5DVqzwVpUvdnKgeX8MtdtlEuYErSeIg+l/IoAjcvDtg+jU1MqxdmxRNvxZ9kRS2qGprGrhRyIRpcVH6y6dEUfPcWVva/RG/A4K/VnbUoLlioKh0mHU9E16eS0yV3f9Bt2ZjH2j6uzJDLLPNDMv+7LUjMAUGoWD94aDhtBUat74kteyuZI4OXai48saRpE0qfNbHpLELa28QMOETIo4P2KUMvu738lCzxkwlm/66cf/IiNibgvXUuoO1lH67V2wACg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729615973; c=relaxed/relaxed;
	bh=ln4RaaN3hlStJiTXS0w9jYwOdR139lH8BqX/igzVO24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bh3UbS6EtmQyo9MJi3KEWbjk9AK+2GK6vOOdTN+t6KWAPbv6uuNsusVxBJLhmG8fJNzvQxhH9Yrsc5hSJ7HCe2y5rbzhNjelOTXq8V0I0Mg2aSoTFsQJOFWw65wkx4W3tEANA8lP3TaKz1BxsPgSJRkY8yS0rBUasZqoUq+2zHqbJjotlwpSpa/JOVKp9uPnof2suFPHSikBRLzaQbDRcD2DUJrTxskV7GKcvzRKwRwDJB/KN+NrPxzGe2srrW9ZlgmIjkVqHTEkwr+zaBorVD2z2Y0ksBW4LCCAB4ZPkZQvoY/r04y+Wh7FH8Sxo6soqN/uUbi39i4YgLr89iAoBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WWiS06E8; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WWiS06E8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XXysd1LQcz2yV6
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Oct 2024 03:52:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C5FCD5C4C8E;
	Tue, 22 Oct 2024 16:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7616CC4CEC3;
	Tue, 22 Oct 2024 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729615971;
	bh=ln4RaaN3hlStJiTXS0w9jYwOdR139lH8BqX/igzVO24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWiS06E8fIgaC4r7wPMNYXeRYiTBAmYLGVQUKjMNITcw08Fw6uwutF5fWI550+rth
	 T/p5M4HbpBxbsnfyqFmGNulDYnq34JR7ZsOeVwLKO8KnEsmLU0CQORaqKD14/ghtaT
	 FThIm0Wh8W13pUVQnfeKMEthtbk/cNfcsJHSIFppbr3GFOePWwciY4+UdxHHI4z75n
	 sCL8CpvOxdQsOVQf3TW59ZhS6DszXZnH3BWFpfszSa0fZ1qXaQ5xqmyEVs3Y25lE/t
	 4nPXgpbIp9gA/fopANf3AUs20HcnXBiLtuFIRbco1U6CbJKvAAgSLDtJDe704kEP2K
	 mUZJMkYGswZFg==
Date: Tue, 22 Oct 2024 17:52:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Jason-Hsu <jasonhell19@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, patrick@stwcx.xyz,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	yang.chen@quantatw.com, jerry.lin@quantatw.com
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Message-ID: <20241022-purgatory-modify-fdcc5f1cff23@spud>
References: <20241022021511.2322303-1-jasonhell19@gmail.com>
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
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yLTSOIWSP2DWBufY"
Content-Disposition: inline
In-Reply-To: <20241022021511.2322303-1-jasonhell19@gmail.com>


--yLTSOIWSP2DWBufY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:15:11AM +0800, Jason-Hsu wrote:
> Document the new compatibles used on Meta Ventura.
> Add subject prefix for the patch.
>=20
> Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>

This patchset should be threaded. With taht,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--yLTSOIWSP2DWBufY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxfYXgAKCRB4tDGHoIJi
0jmrAP0atEdkBB4ulX4MyZxjcMS8Bvmm6/bB2RqP6JF7ZeGqxQD/fD2F3B7QKFDh
ACUq1/f1Z9ZRHQIm/8YMh9sujE+HnQo=
=Wg7A
-----END PGP SIGNATURE-----

--yLTSOIWSP2DWBufY--

