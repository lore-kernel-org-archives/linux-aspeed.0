Return-Path: <linux-aspeed+bounces-2259-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965B6CAC598
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 19:17:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRpS36CRCz2ytV;
	Thu, 18 Sep 2025 05:17:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758136643;
	cv=none; b=Cq2G9xpE378jot/dE1tTCJc0eg0WGoaKUGDT1jtvGcFDWoMvGuecYbp7CjpxXK7PusreMx11lHgY7Eb7B05zbie7/Jfhvob638k5HXurptPSCusz/9v35Pfq7BSDMAiISvvwhDJnWooGbIyg4bfKb40usgcnyykF+vGabn4Rn2M4iBtKOTlJ0VwqV/bMynHVaP7f/1IVX7CaxhZhn735AVMknMJGnnnDnjIMPVM38Lj3unVLMimdCIT13HlgStKE309gphYK+Ucmzysi10WR0DLuyDOD9GbcG4uiWCUTS3GB7lufsmahbffOSRZJTSUrcBRNvQ/7eKlv4cC3XjOPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758136643; c=relaxed/relaxed;
	bh=u3Am9CZijzheAJRrJMo40O044w6jv7P7hbe11u4WcaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+NbEhN47h1wRt33w/B43DqH5P5sz9k2b+ndUUwmMqQbxceLF6qULS0B7s/RQ0kaUjBL3oN/uOZDA3TUDay+mjE9ul2pcdkK3zFL9WqYXQAF9acs84Mmm0FT4UmJaDgFwQP1VHCwbm71PtHjXJhPUPD7Y3M8lLSyUJJHQgx0iuBDw+kQpybfztLZ5SF2NcmyAq58Bh0qSfug06r7KI3C2U0GACy108lWh4bNM0ryRQEfUaLieJk1Ryg/Q8XNGCryBWafDSo0VhBsvAHFG5fmWD1ya/3jJX+qrlnGQ6rxlkHchZzBcb6qvEi17R227g9dTT+oFevCRnuuTnGRoLrBzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MW1GcNNW; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MW1GcNNW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRpS26CLCz2yhD
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 05:17:22 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C04F3601E9;
	Wed, 17 Sep 2025 19:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74744C4CEE7;
	Wed, 17 Sep 2025 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758136640;
	bh=u3Am9CZijzheAJRrJMo40O044w6jv7P7hbe11u4WcaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MW1GcNNWlRPw0CLjtk7TbSRXrcmpzpiwCmx2qHA9ImM0Yt1nmMDeQ+uY8a5n25+RT
	 dRiEHOMjWeAJ1iY9m4uwgVdDzvpTANohnpo5ryFeX5LIdyT0Wh1H9KTLg6bURSNMH5
	 jz+XKpHrYLgwOX5G9Y4IjJJ5z9JWMdRWivyI/Cy4EYoec3+v9SiU8aK8u9a/3HB4uQ
	 fTFRSIaDvd/2T0z42yUwVHI10Gjm5q3hpKo0p1Dg/ngnGEtlJ4XFIuhwurrtKJsfi6
	 HG05sHoBZIs1Ghf4UIZSzyG/J7q1sHvRIsNXmLCki/8+sxc4jhAZ5jTVhzxmGrVuJK
	 OG0DdLL84hRqg==
Date: Wed, 17 Sep 2025 20:17:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Rebecca Cran <rebecca@bsdio.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8
 board
Message-ID: <20250917-upswing-paprika-515d88bdc6c9@spud>
References: <20250917180428.810751-1-rebecca@bsdio.com>
 <20250917180428.810751-2-rebecca@bsdio.com>
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
	protocol="application/pgp-signature"; boundary="evQnuMst3vf9IghK"
Content-Disposition: inline
In-Reply-To: <20250917180428.810751-2-rebecca@bsdio.com>


--evQnuMst3vf9IghK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--evQnuMst3vf9IghK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMsJPAAKCRB4tDGHoIJi
0oRPAP9UJ57vJwVYjF7FY8AiEeYNHjjJsfTgCjQb95se9aB1LgEAnwvvzR9O6Qev
0yJLKjluBiyy80DVqbCAxm8AgQTA9Q4=
=U7SI
-----END PGP SIGNATURE-----

--evQnuMst3vf9IghK--

