Return-Path: <linux-aspeed+bounces-2260-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F31CAC598
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 19:27:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRph23yBRz2ytV;
	Thu, 18 Sep 2025 05:27:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758137266;
	cv=none; b=BydyP/S4oMDExQNvkZ30ugPLWBRApZMvvwM0SEOyXVHduQib422m2qeAtHcLS+km0r7Q8IreKsGiLy78fouoWyH7F6cgaPfq3YJWRd0wBmJPynEJLqlH+0BqcBhdNvjtM/0g/jL86nICTsXSbU28CQw6JKkx5lcTsH3rV3us+NR4dcrJS2BTppL37AU4lGEz1/KQCYAEDjKesFGgBbO44ZQqFjdobbtnqKpLGkas6ss0PpEzHKmpCk5bQrK2prwrSXWfMYAviDolBVhjSoOhGNTyWCh1d2fGvdcEiHzlBvfCCKcyBkshqS0QqWY9gt2tmjx6wEUUtxJdVwiMmP5Yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758137266; c=relaxed/relaxed;
	bh=gr3F9g/r13IbodjkbswahgoO+gHnOjod7V4voFnQTMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1ruqav3HZpS/biDosqlRc9xWIEBWiciY8AVbnwoOObV1UlYMjlAaY63tyGyWLE3SH6U3sY4CoHnrR3sInuxh+bCHRFhyfF64Fx7+r3CruezUu5CedRxXsoZzUfKEk0gwbKT/NME8ns3V2rii3RGDGlCLRcu9stsFvWNBvN+YKmQD3SO8dv5iedffq7cMWL5W79F2JtAVzawj5GYEvOUkhTebdeE9xK1uwQ5cc1ZLQsMXOeM2bk0iJQvHAwEeg9ZyayiVN5+iND/CuOyo40+oE34NyAjxwbgb/k8ndmm5i2IaZWUrQonZdXtxW/3Xc/klNJ2l+ZYkMmAm+AL+2J7NQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o593B8bh; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o593B8bh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRph163Nkz2yhD
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 05:27:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9DEB26023C;
	Wed, 17 Sep 2025 19:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F9AC4CEE7;
	Wed, 17 Sep 2025 19:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758137263;
	bh=gr3F9g/r13IbodjkbswahgoO+gHnOjod7V4voFnQTMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o593B8bhRSTEOjlj+wGHK1uCJ5fOkOv1NZ0b3Zc4xrlHoPteX4c8FuwXmyea3lKi0
	 xx4Dwqgc/qz0is2U2wsj6K2uyW0IfkZdxrOz1a+m3QlON7xkwZTo5XPQWL23hcA/pX
	 C8CO1Gc0z6eMH9Wr5wbL/RSqwzPcaEPsaiGkoZsuPPBvU3vDH6WzchAFrLtJi1h9ew
	 QhcszbpSHUUbMdf5boE60/ZJavCDUmmkYCf0xQn9KvjNe33vGFVpsZq5pLHup4hdSJ
	 OjR60akzeJssaNRF3Cu3RiOAIMUkrAwSaH7QGqdXTRO0bpfkazW16cOZUvDZ9Xo1W0
	 FWav0Up9PrmDg==
Date: Wed, 17 Sep 2025 20:27:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: aspeed: add Meta Yosemite5 board
Message-ID: <20250917-removed-grader-328f0a71bb73@spud>
References: <20250917075156.4043936-1-kevin.tung.openbmc@gmail.com>
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
	protocol="application/pgp-signature"; boundary="iJ0kmrmEVtt0EMQV"
Content-Disposition: inline
In-Reply-To: <20250917075156.4043936-1-kevin.tung.openbmc@gmail.com>


--iJ0kmrmEVtt0EMQV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--iJ0kmrmEVtt0EMQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMsLqwAKCRB4tDGHoIJi
0h+kAP47tu4UOEsK0a/6ISyjquXeGZE2vnuhAzzB52b1McFerwD8CfdmMddHrJuW
QtdHkVqKuD2OiurAWDrWSuXMWIdiEQ0=
=4008
-----END PGP SIGNATURE-----

--iJ0kmrmEVtt0EMQV--

