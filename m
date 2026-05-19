Return-Path: <linux-aspeed+bounces-4093-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA06CD4F57
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 May 2026 11:04:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKWy812yrz2xwH;
	Tue, 19 May 2026 21:04:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779188640;
	cv=none; b=PJyFq0/kT8bkvaVjTG0htQtNUoqNPQEYZlLP0+2/LUyBB6ULKhrXicp21DfjWnrPRoaggBOL16k743vKgfos3opyupMF3eRkXsO3sl9gOYFetPx7AW9mUcWLUZW7VlMS21i4Q5E1MjXU0iRXMwQ1bZe4nb3MVvnem+bqPu+yN9fVn5+WohARoyquNd50UkDqvZLWrXjoGZBWmhMjnQQsDRVBD9FH6JEwaT0Ro0b6vNMhBBiQMfRX7SI9AreZtI5g1jpVW7+OeZ3rlazFX/wNwSdJKROjx357Ar+bgs/AlfgP+6nOOPXTvBO2jROjKAx3xLzQoVPNI7K6g4pG2rI0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779188640; c=relaxed/relaxed;
	bh=i7+TPDNRmMBKzPA7G+4/OR67XS1KLFV6sMuUCk4N2H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JojpopHRijphXtdZBEzWCNPyhlkAp1u7xrkjTlyyd4VkLIdy7KNvkBSsE3etcyknC5JWhAVKgVPVdku8fA/4A0+vqIFU5SmHcXB3eyDIvXPsDEYCMiBJYalaTpoJcNS48kni3+K0VKT59dbY2veDFKkDNZKtlwU4+bzPGPyPIZfH3ay3Z23wARa7GR+DMR3c09n3M05AMdMYGea0bHOuq926UIUKU6rLGmUjruabAV+NxPPdhDFdShPBszdsozerkhxnyzET/jGllWOE3617xJLTKOuZzTCEZhw8ZJpWIB+sqk06tIhBq3zamOIOxSt42eSfMIY8tm/3S9vz1iuDSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uAWomEkv; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uAWomEkv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKWy722jlz2xqv;
	Tue, 19 May 2026 21:03:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D421F4087F;
	Tue, 19 May 2026 11:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC2FC2BCB3;
	Tue, 19 May 2026 11:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779188636;
	bh=V7IBH97Z2/GKxpxpkUNDatXbplsDGhepTwPW4cq1SlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uAWomEkvJnuu2fb+G1+FjOqSf/R4BcWsFt8i+vOAas+teqBq761ZuGVjPSpHhdnvw
	 ocDjxTi/rw0M2qWFYwXQ64sGjBb91U5eDPFtOvh813nl8XGE5EA42c0s2nvGdkmi7u
	 8gobw8oAu9SP39OvpwkfwPW0aVnMO/ODGc9275d0LK0esFDf4+fChboD6Zwem9+3id
	 aR171PWtqm5Hu56m9MWZWJKptcYE/xwoKm0ZWY3kQsKySLd5jDj6bWD9HwmYTYxtQh
	 0kCXY33r5AnfJDrmtZgD/UTbgfBGmmeJg+GrXFK2xyefvfy5UC2fIroOmqSK9PpoEM
	 wzU1Cwzplec3Q==
Date: Tue, 19 May 2026 12:03:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: clg@kaod.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: aspeed: Replace VLA parameter with flat pointer in
 calibration helper
Message-ID: <659a6593-0223-4a26-830b-1390326b84e5@sirena.org.uk>
References: <20260518095708.2502537-1-chin-ting_kuo@aspeedtech.com>
 <20260518095708.2502537-3-chin-ting_kuo@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="Ym/3v19Weq8ydfWw"
Content-Disposition: inline
In-Reply-To: <20260518095708.2502537-3-chin-ting_kuo@aspeedtech.com>
X-Cookie: Huh?


--Ym/3v19Weq8ydfWw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2026 at 05:57:08PM +0800, Chin-Ting Kuo wrote:

> -			while (k < cols && buf[i][k])
> +			while (k < cols && buf[i * cols + k])

This really needs () to make it clear what's going on; the precedence is
well defined but not everyone is going to know that off the top of their
head.

--Ym/3v19Weq8ydfWw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoMQ5YACgkQJNaLcl1U
h9B3pAf/am7wOig3BHiAuTlInU7joZdU36Y27z2iCl3tYJ1+lR0IKbwk13HQ65ha
oelRLYtS0WA/lKoyVTCWx2iGhjhxYTdgiQ1Wpta7YDltIy9DHQLpCZjruh7+kS/G
wqj1XvTObSW5coagxf/u3QfSt6IB2m+X5FlNHTaiG16RFXewUBQH7OtS7+ZHArJ0
lf2EakmCFwG+5NYEzYNe70qY8je0okRhaf1vzeHLbER9t7tpKF4EqJWqysgzoLxb
g+re13ZwT/O+tETcGPFo/P68eMXxqIOq5xvJca98XV4s0Fz22aIHitK8dl+HkPRh
aSZ+o1havyWnTEllOggQHwYQsf+ssQ==
=wLZU
-----END PGP SIGNATURE-----

--Ym/3v19Weq8ydfWw--

