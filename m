Return-Path: <linux-aspeed+bounces-2393-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BB0CCA471
	for <linux-aspeed@archiver.kernel.org>; Fri,  3 Oct 2025 20:49:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cdgkW6stgz3d9W;
	Sat,  4 Oct 2025 06:49:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759524547;
	cv=none; b=FduaS2CalejBSg/Q++X23oOq8ZrvfKbk9M54SxP1/PJ3Nb1zxl9A3vr4zSA5wt9NRq8+5z5ph9MmaGqN4u6CzcS5ie14sQp2c4ypXTY3x7ilMMcC2b0brmqeY8JKEUHRndljVCrNU440bckQ0+d4rfMI7j32Hmivz0fmFnHGDLaHtHwsn+420Xcw+2YbTVS0Y2DSEf6Kz7CRt5KtlaKCN8e6A8dNYUz2HQCVPIvS9a06yAHqrAqBFCS03VhcXumNOEObR4eQf7dNxTGjgov39MUzTY2VrBFsVTPZ6hgOkx3FWBa6aPt3Yla41zI6WdmKu4aazUWipSqXt2v6f/e7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759524547; c=relaxed/relaxed;
	bh=TQMn0xYZu/W44ie7RbT5/KZKevQi8dTv/4ecWALqC3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIShz+RBJy32u+0IHeI9lte514gbwZjGKdAnCbHpQZVy5xLkDPA13m6alPoKHiYKSIfIlLjj69JSSTxbmrnzcIr4rmxBmnzYI3vFy8NfFz+IkTnMISVuHWTiy0CHnmj5zkK4uTixkMP8ZviYB1s4fYpoNX/QxOVYgy9x6ykg/nASMcIzBFtdRzGPCS3Tap5/6Rq+kyG0NbD0ZaKEyXx/iRwtuYxwMW6jLSW6yZv9CrShsx2PIYVW1GrOX3yGhXpzhFa2kHzTz0QLTEF03Z4PM0jhoxA/zBLpc2uet7cwywZLW0l5+awAo9Ckz5Tv9DuRvoHRcLlLWBiQHt5WIDopfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aAaiiEFQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aAaiiEFQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cdgkW2cbqz3d8S
	for <linux-aspeed@lists.ozlabs.org>; Sat,  4 Oct 2025 06:49:07 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 19F9B61E01;
	Fri,  3 Oct 2025 20:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6CEC4CEF5;
	Fri,  3 Oct 2025 20:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759524544;
	bh=HQTN2i+oT4JFL9hKIQWaUwNNbKsxDcq6rJFXHwtEikg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAaiiEFQHTfaCaOlYOkAF/OukCRWCchT3W9jx+D2mhrmILAFZaAcwRxrdNVXkRKj2
	 02qQ68YfCssAjZzlcxQHMGs0ihIJh7PwxYi5KZ1PId5HPNXwer3tBLvizJz8/sy0ad
	 3hEiWr2yv9L5aLWBfT/KNpTsPO91gcTjcqmGiNwHWW3b33XCWsm7y2Mvhw5Jljt6jN
	 wUrNkGUCfctJPguOmbZHWsEy9siTTuhk8oDCJK6Am1lYKfsiQkf+o6FNaVc09/SNA8
	 r8khxcmnPRXK74I44TylP+W4XepoACJ2hATZC4rp62J1VcFSKW8xdvCRPLHzDbrrk/
	 1gH0u83Ddh70A==
Date: Fri, 3 Oct 2025 21:49:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: aspeed: Add VIDEO reset
 definition
Message-ID: <20251003-paralyze-herald-f9ef464d43e2@spud>
References: <20251003015845.2715538-1-jammy_huang@aspeedtech.com>
 <20251003015845.2715538-2-jammy_huang@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="0l94K67tftqusJJV"
Content-Disposition: inline
In-Reply-To: <20251003015845.2715538-2-jammy_huang@aspeedtech.com>


--0l94K67tftqusJJV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 09:58:44AM +0800, Jammy Huang wrote:
> ASPEED clock controller provides a couple of resets. Add the define of
> video to allow referring to it.
>=20
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  v2 changes:
>   - Update index of ASPEED_RESET_VIDEO

Ah, so here is the next version. I don't see how this can be correct if
21 was correct before. Was 21 wrong?
> ---
>  include/dt-bindings/clock/aspeed-clock.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindin=
gs/clock/aspeed-clock.h
> index 06d568382c77..671e5a476eae 100644
> --- a/include/dt-bindings/clock/aspeed-clock.h
> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -53,5 +53,6 @@
>  #define ASPEED_RESET_AHB		8
>  #define ASPEED_RESET_CRT1		9
>  #define ASPEED_RESET_HACE		10
> +#define ASPEED_RESET_VIDEO		11
> =20
>  #endif
> --=20
> 2.25.1
>=20

--0l94K67tftqusJJV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOA2uwAKCRB4tDGHoIJi
0kHxAP9tfxXaNJcuCWViceFs1gRlxpPvViWfAlgUUO4nMPglFQD/Y2wX2hhSzCcW
lX1Osw6hWMgsEj7CQ1ilQ4aTXa/d5QU=
=B5UU
-----END PGP SIGNATURE-----

--0l94K67tftqusJJV--

