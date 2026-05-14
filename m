Return-Path: <linux-aspeed+bounces-4029-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB19CCD4F39
	for <linux-aspeed@archiver.kernel.org>; Thu, 14 May 2026 18:20:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGdsY0j4Wz2xtC;
	Fri, 15 May 2026 04:20:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778782801;
	cv=none; b=Db8DeVWvAjOLzuEnCzxdxKD+fBLFiU2/pxOoGuARRwBJ+k77XlLZvHEZz9oyaYzQ1dRvR3PiphXRFsT0enh5WXIAV+NvHzEAS3mQtzYWRa73T6PKW8merrAxsH8hq+mW77ginLHQ9/jo7nRegQ0uOkICDUfVFvfPN/FbdIj8NA1SIDNjF/LyvMZxpgTH78Hrl+pYsd8VZ9I9aWryo5OaSXWKJA+eJRyUjjXm1GFUPbUW6YY2Ah1PcFxfDaNtTXYlKgrI7YiwdA/POyN6luitPFOod8P4BP9jTBhtaGIXLdXfuK+KEWvC9bs0Q/OlqiabB0G2mmJkiQI2pPJZswYe7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778782801; c=relaxed/relaxed;
	bh=gTjiv2/TKYKg8TdJlS1e8VNcO9aFXlqH7uu9TXo9p7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bct1e2hT+EpXdyKL4lbUQOJ8MsjkV1d5jqqSIcepn0lZJ8jv1uqktXAU+1/iC4i/3vkHWSAaOGzGIfh8llcm/zCbqqSZcup97EBAbzJlhCspRLIrF/chCl+T21/vNXN7/rWVg+YhODVpynd6v6pBpqM7kxmvk1ajku2H1hk/UG/yGyvueqvrCt10FXFhswzXor9ZjJy2o2yHYAvZfS3L/D5INlLNa5b+fKdhvCrfb4hVj7Ld2ftskM7Qp7uZfqaZoWrBYOobim/XBZTGtg6Stj7Lg5nTticrLbWVjNsOlXCdjc0VQNV5Bb2rISuU84OzzjmIAwI2GyfGTY/NaWKhTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rRXrZDVx; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rRXrZDVx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGdsW5PYlz2xlV
	for <linux-aspeed@lists.ozlabs.org>; Fri, 15 May 2026 04:19:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EADD360008;
	Thu, 14 May 2026 18:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4CEC2BCB3;
	Thu, 14 May 2026 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778782796;
	bh=gTjiv2/TKYKg8TdJlS1e8VNcO9aFXlqH7uu9TXo9p7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rRXrZDVx7GTdXCnIwrHfDFQA0dGr35iuWoB4FubCL5S0/SggcV3ELk6ElUR9Bc7Xr
	 E9RlVLcF+sOuexxBssBK4IQcHoUpAXH5ZdNXZg+V9yPdRT16uPEin1MmUBzJj3EbjR
	 qS6dD++lzzSbVFhEkG2nioBmBS4WC8mOW2j2irA9Cp2m6ry5OkGgcDBhH23JU9LgEa
	 4V1C+ZqUZfxF858MrOZpCDuP3S9Iw2VisXNJ630nq+OV5288iS5K1bAnX+5W/HBxGy
	 dG8OXo8duFyfWRP/DzZKY6LHGoqUnv3oIL1MIYg5fTwJSAXRTbYYHfZxXwQytYuwHd
	 ZvsKB7cT12m4g==
Date: Thu, 14 May 2026 19:19:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
Message-ID: <20260514-spiffy-freezable-e8c6d9042d57@spud>
References: <20260514031622.1416922-1-prasanth.padarthi10@gmail.com>
 <20260514031622.1416922-2-prasanth.padarthi10@gmail.com>
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
	protocol="application/pgp-signature"; boundary="URRyEgb7TO15cZW/"
Content-Disposition: inline
In-Reply-To: <20260514031622.1416922-2-prasanth.padarthi10@gmail.com>


--URRyEgb7TO15cZW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--URRyEgb7TO15cZW/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagYSSAAKCRB4tDGHoIJi
0pscAQCKHketvGg954MMHYLTbNRveDFA9z87ehYbOYNaP/sQhAEAwtGdaTIOTrWP
3HYqEymg57NUGfTRu+sS10wbhb6qYAE=
=8NEg
-----END PGP SIGNATURE-----

--URRyEgb7TO15cZW/--

