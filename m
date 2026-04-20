Return-Path: <linux-aspeed+bounces-3934-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F1BF588E5
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Apr 2026 15:36:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzqNC45fbz2ypw;
	Tue, 21 Apr 2026 01:36:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776699403;
	cv=none; b=FA0FD8bK3SoNbbW7pnw9gscyOADX12KKojGVzVCkNet1S8lNlvmubKIO5QDdbnSx36J6QQ07pPbyoIiM+kBtYnt/5HMJSVWD5V8XKrE2gOMnHaDoh2BUeNcz9GrL5aDc1eVvRHyLNFjaiTDgXFQmnaNIDSqCwqFyC4yvevD3Z2WoqCQkDW0DSvx1XM9oMeGVWNA7VGCX8+6U3mjIMlu7LlhOHyTRsE2aF+2u7+fEY1zn5Fr8s9YHIgoVmcBiIxHfb/K4i/9nr46dIjzznGodUxJ1ZaO9/nRsInoP2v228kO/7KIVBXOp3UwFehL+C+F0ydMRDo3E1taltouSRSMhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776699403; c=relaxed/relaxed;
	bh=RXTlata/cDCaSGkwzCEWmovi5WJsV4Y9htt8/UPRgxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGH8/qZq1gZ1XaKt9UyxyLPQUEQEbf29dzFg7noRUtYyVO6lpV4b18fEQUpeRM31QAtbUHD4kLnpembBKrcx6/tmpRMyvh0Z4RpVDu6rWhwI+JLggknkQE7g7l20InVc8+8W99JKmKgxCeUGlwcjjT3iGGT8QpPxuNt+Tj8JlZSzFvwsCdNmi/SS/8e5My6yjjEQMHVLlS/aPfM5ZqPvsm1Ho4YD+lR/Q0657No8k7vMyS7qY94yJS13vSN8/xvyK8GXKOe645gsWVTxmRkOtEXLf1IDoqpFPav2T+eqZ7s4XJK1S6nOZN1TvmH9fVW5reBXMZi0GjB7ZCKy3M8vbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aRrAXzKA; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aRrAXzKA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzqNB4bB8z2xll
	for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Apr 2026 01:36:42 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C6CD760018;
	Mon, 20 Apr 2026 15:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C507C19425;
	Mon, 20 Apr 2026 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776699399;
	bh=AzFmS5Tnu8sMhg8eDHy3LPsdHF0AOqqG0otqcA9EY1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRrAXzKAS0bBFun9CQKrTyofiR5UlWY17F+ckg075QcTe2r9+vjrfK++RzMggttkV
	 q1NTwF7XAvZjmFfZLPpUmtgMYHiDG2drOziCXgfLcWd0Y6nEvjujmTwVZmr5hMl1wU
	 CpaQ6uFIbL/EpyQ6i/wUmfEaRC4/BNEMMkieXlqICQmUyLAF5aakdEG77cGbUkLmqz
	 xjBh+OUX0oJ5Fa5DT38dIq0PLIc5seAMFXqe/ETiWMO5q9VvdUgynajX2MEWNsqgBM
	 AuMqXg2f+PdpqyrfovuxaJ/zCNSe3WpEcIJstH9jBILV0URQE+p5fot3kNejTRHC7U
	 FmdZfQNqOrUaQ==
Date: Mon, 20 Apr 2026 16:36:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Colin Huang <u8813345@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	colin.huang2@amd.com
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: aspeed: add Anacapa EVT1 EVT2
 board
Message-ID: <20260420-garnet-goal-4a284a8818fc@spud>
References: <20260409-anacapa-devlop-phase-devicetree-v2-0-68f328671653@gmail.com>
 <20260409-anacapa-devlop-phase-devicetree-v2-1-68f328671653@gmail.com>
 <20260409-foster-stability-f77b38c6f7a0@spud>
 <CAPBH0A_K39218+=QHJuEY+SbFk-nCnM=Z8RQMdHBK7SkCj2QtQ@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="rT7U0ER3rzaPGzgy"
Content-Disposition: inline
In-Reply-To: <CAPBH0A_K39218+=QHJuEY+SbFk-nCnM=Z8RQMdHBK7SkCj2QtQ@mail.gmail.com>


--rT7U0ER3rzaPGzgy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 01:41:30PM +0800, Colin Huang wrote:
> Conor Dooley <conor@kernel.org> =E6=96=BC 2026=E5=B9=B44=E6=9C=889=E6=97=
=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:36=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Thu, Apr 09, 2026 at 07:40:26PM +0800, Colin Huang wrote:
> > > Document Anacapa BMC EVT1 and EVT2 compatibles.
> > >
> > > Signed-off-by: Colin Huang <u8813345@gmail.com>
> >
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > pw-bot: not-applicable
>=20
> Hi
>   Could anyone let me know, what is my next step which I need to do?
>   I can't find the changed in for-next branch of
> https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git .
>   Thanks.

You wait for the merge window to end and the maintainer to apply your
patches.

--rT7U0ER3rzaPGzgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeZIAgAKCRB4tDGHoIJi
0gyRAPih4zXoYopFmAszf/ozsfmpEp1cZspkWl07OnahV3yqAQCD9Sal/PjSSKtW
PGb84+0XAkYu+zzoDJlWPigE0ykYBw==
=g4DA
-----END PGP SIGNATURE-----

--rT7U0ER3rzaPGzgy--

