Return-Path: <linux-aspeed+bounces-2289-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A805CAC592
	for <linux-aspeed@archiver.kernel.org>; Fri, 19 Sep 2025 17:20:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSzmB1HXcz3cfQ;
	Sat, 20 Sep 2025 03:20:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758302426;
	cv=none; b=ocnT3qSkfuGhECzAdE3wGrhiNH/QhCvgPxnVGD56OgtvIfPTmoymym4GHO1ldmnxQuLkKOwuaNdYKKj64Cb+CPM3crIpB9iy1rF8083N1OOmaMczBW5GK3OuFWR6ptuuRxnKUswZlaD72JB3JTKfV50BDrVZg79JYS2WqFJWgHI23LfMtblCGMRfqcG4Ve42Srrd1YJF4ObJbiK9E6ElqW4qruS9am9WJMADFPkMyS+EfIG31F9CLunLjJR3d/c7wqXf4pGFLHXtGa/b+mGu8hQF7Rot1vbZHZY/+oi6f0RRMfvQ57utL5Z42urm/MfTk3lfPl30FcTACpFEWA1stQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758302426; c=relaxed/relaxed;
	bh=piPFu+cMpmpbBtwW/KgBv/3Pl9j2EwCCE9vhSTtvT+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQUguV+lA9TH6MwB3mpmiBl0mbqghVpNQEhoCPldaHUEMwZ8Y6dSLSFp1XJZF71R1m1FIFalyBWw3cEj4RvDlFnz+Wif50CmIn/pZIJ3xQuj1sjm9q8P9FcdqFk/bACqrRSP0B6njStQFGsgJmzT+6esBKJ9bEol3TxdWjJ5Zl5aW7oR06mAZqFV2r3roUrPSgTjwJARMo8iIt2pfoxDtajgpykV5fq4KoiUOGt9nDyZ+P8JWtyuBhOc8dIM+49+6LsL+8DWvdq66/AIl3rBrqhKc1iYrNBBtmnFdSkwrbT1NFUwUhpQ5xNPzEkdkCSqxa5yA6Ye4lor+d01wkvktg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AlnVEepW; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AlnVEepW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSzm93drgz3cf8
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Sep 2025 03:20:25 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D043543A63;
	Fri, 19 Sep 2025 17:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B395DC4CEF0;
	Fri, 19 Sep 2025 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758302423;
	bh=piPFu+cMpmpbBtwW/KgBv/3Pl9j2EwCCE9vhSTtvT+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AlnVEepWxHalo5mDInuATYumccjTzTky/qELxnGG3oDJtRmuG0tAZx6+2TY5uaTeR
	 0arw3OcYJX3p7w6obN0kQfqfGEf+L/PGII+JBvFvcgltm37vVFg2nDK/7B1oow+CZx
	 BwWveWIHGZ0fOoBIdhrYr8m1zC6u24Ry5M4GmEUmgQgJzuoeFkxUiML05VCgwYsKQH
	 LaAw2AeKQ/TnJRqX76G7GDJXPEESetpw2DnaeC+wQZILuQ2EseTfTbSOnkOkNAq4Cx
	 a+P1FJk5dMaNN72lKt+yC10+A8N+s3BwCCg3MBBKKgRJzTR36DF/QmKbMbZ3UPxHgF
	 1dUwO+TNAOKng==
Date: Fri, 19 Sep 2025 18:20:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Marc Olberding <molberding@nvidia.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: Add Nvidia msx4 board
Message-ID: <20250919-retrace-lego-31dde220b234@spud>
References: <20250918-msx1_devicetree-v1-0-18dc07e02118@nvidia.com>
 <20250918-msx1_devicetree-v1-1-18dc07e02118@nvidia.com>
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
	protocol="application/pgp-signature"; boundary="R02dLCybvaecFiaK"
Content-Disposition: inline
In-Reply-To: <20250918-msx1_devicetree-v1-1-18dc07e02118@nvidia.com>


--R02dLCybvaecFiaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--R02dLCybvaecFiaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaM2Q0wAKCRB4tDGHoIJi
0tVwAQCtT8kAmJaiRiYCHAZ9+okhbpCV4iRU7npKt8xpiaaAGgD9FrWGFrB4qeYy
Lww4rVJvvHOciqSTshRRzKcBT66riwM=
=CCD4
-----END PGP SIGNATURE-----

--R02dLCybvaecFiaK--

