Return-Path: <linux-aspeed+bounces-4107-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741BCCD4F3C
	for <linux-aspeed@archiver.kernel.org>; Wed, 20 May 2026 10:10:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL6kK15wMz2xrC;
	Wed, 20 May 2026 20:10:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779271849;
	cv=none; b=l8tj3sTd1Z8pVqcjTnfnBiuuwIa3FPno9cDUYo74Dbw4fwxOjtLhi62aMpguQiWwuChfKgU0Kg81wa5gJm/WlKxOqqOPqrJsO0w/9pl61pBeNFGxFqhNVABuf6VVaibKM/QK+jTtYMq8BuQyMuNaT5GS1+MH5kvqq1ZDD3nz7z+YzV2/x1wqVmkMv14mUc3wJ2reo80BJMJeSuUdtE/tdn9vH0+vC09Vi5fxKQdDqxLWRQLyFdkmO8tTp3IZKrTIZJSn+p14hytWtPUjEsEz4Oo85a/Mg/O6jX+gk9aWmMp74eCYKe7ygYpwe+uvcabDf7+abPuq9ZTs6THaEhk9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779271849; c=relaxed/relaxed;
	bh=8/Nk4vPQPh0CW8IIxSh5GD9J7BcZmYtjb7vHxo1Fj6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWBvdtxkR+SZM0mHEtz6HS0Y5E4p1MqDPjjnWNYJqhK+CUw7frPhcIsvDJodNjA6PpmLW0fXfZhwmG3wAG/JDZpSjHBFPbkOHFGJqJAM6xPqCXBCEdVO3YRogiqR1KkvSTy9tOEw+Fe4RWp20nDwIcovtt5aOoypkpZrdo8OiGcQCjuG39dIk7dvMEUKLp8qAkE885n9EGA/ZUpA7w/KxKQNRUlo8Nf7Eltugrt/qNyTlH9kgARUTSpfPNIFQ89795eQ96cGYNWNA0qfugytJYz1yyTZaaMLaocGk70ZN1AselZ0FbDELi+Xu85p86FbM9frd2PMxx2abxLwjdqa6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqzyR9ia; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqzyR9ia;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL6kJ2YzBz2xfB;
	Wed, 20 May 2026 20:10:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 758504346E;
	Wed, 20 May 2026 10:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BAF1F000E9;
	Wed, 20 May 2026 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779271846;
	bh=8/Nk4vPQPh0CW8IIxSh5GD9J7BcZmYtjb7vHxo1Fj6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kqzyR9iarPoVRPZapZy1o91ByBc5CmJZZ1xpTdT2vRSRwBSf0TtB18tSB+Uh8mKRM
	 /mVD4QHz6XlazB8ms3CjXQ8yxVtPzWCFwWYKDxag41kPFbhMAU8kiBSuPK7h8x7lA7
	 fTW3cWzof75A2x4RXGR79xVMK5FI6CoejoTSEfj/Mc3Plp0PWM7amSzapYHEmgS0Qg
	 pAotSBhZ4lT4RQPE4oc//Rhb4qOg8YWjjY7oRmDlq3kQ5z5nh/fS2UDyCi3jPncf5K
	 BJ44bQaRUg3as4vSafa8HLa3Wqed5w7ptmPTeTirZFz2b/WpLc2kVGMk+sbhLwizUK
	 ANXHF1UvN+a0w==
Date: Wed, 20 May 2026 11:10:41 +0100
From: Mark Brown <broonie@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, clg@kaod.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: aspeed: Replace VLA parameter with flat pointer in
 calibration helper
Message-ID: <b629d6bb-fb17-4c17-9a79-d96d39ed0d0b@sirena.org.uk>
References: <20260518095708.2502537-1-chin-ting_kuo@aspeedtech.com>
 <20260518095708.2502537-3-chin-ting_kuo@aspeedtech.com>
 <659a6593-0223-4a26-830b-1390326b84e5@sirena.org.uk>
 <20260519181348.777f7dc5@pumpkin>
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
	protocol="application/pgp-signature"; boundary="KmowL/JuPoFq42Ku"
Content-Disposition: inline
In-Reply-To: <20260519181348.777f7dc5@pumpkin>
X-Cookie: Natural laws have no pity.


--KmowL/JuPoFq42Ku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 06:13:48PM +0100, David Laight wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Mon, May 18, 2026 at 05:57:08PM +0800, Chin-Ting Kuo wrote:

> > > -			while (k < cols && buf[i][k])
> > > +			while (k < cols && buf[i * cols + k]) =20

> > This really needs () to make it clear what's going on; the precedence is
> > well defined but not everyone is going to know that off the top of their
> > head.

> Come on, it's multiply and add - everyone is going to get that right.

No, I have to stop and think.  It's not just "what is the rule" it's
also "is that the same rule whoever wrote the code thought there was" -
implicit precedence is the sort of thing that flags up as an alarm bell
when scanning through code.

--KmowL/JuPoFq42Ku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoNiKAACgkQJNaLcl1U
h9BIxQf9HkMWU0/J36NRwMFjRutEI7x1P5sg8Sloy12eLKK6LBY1hzsPKyZ4ZaIw
vVtbThixSNpcSL6oBndIVKdvWoWyYT/o3x2bfTnzKHbdKT5Ok9heXD6aSc/f1ck4
k0Xp0kN9MptpXrEEVBr15nBjhkUOOyFVnlsFotYE9TBzhGWBWxJrQrK1w+eBYu6r
MEd0mR0/FfuUwFm27aMR6Ur33GRUPs/pVN5/2ndfNGwtIXrjKICYIQ5/lJyONp+5
nCIorPasL6Yywp5B6+p492omJxkuUpkq3EhWhwowOwTD/zlpnglzkNyVuIp3E3Wf
jyCptDj/7h3ujYiwLZ80EgTAcxFF4A==
=pk4f
-----END PGP SIGNATURE-----

--KmowL/JuPoFq42Ku--

