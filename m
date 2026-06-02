Return-Path: <linux-aspeed+bounces-4156-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47397CD6E64
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Jun 2026 16:20:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVGJp6Zjzz2yFK;
	Wed, 03 Jun 2026 02:20:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780417226;
	cv=none; b=nHJQpO26V4cTg8lJazxYgbC4ZxupkqU11XiAuFpDoPP8K/bPt4VXCI/YGAg+mH14piiTRD8RM4nHUPmXJngAp+DljikOYLmzhPmOe2aTM43XHP2qq7vJquCZdrwIYj1U4WlbrvPCWKTvbRhe+ciCeXpRGvyTykJQ/T1fwVTRZzaziupAve3CpWY1Solrc/JBxz0Usx1V/QOegeYfF6rL5aXRxHsmCMrKHkQGIeIN1ZcBNDZUm/xorpRlL5GkhimRzSBqynMyTifgzss9+jsScEHtWOgRTPp48D/LsNZcNzO3d3TDLDB/jRVIHp5C5fnRIu6ikc8FRFmVA4YnqenGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780417226; c=relaxed/relaxed;
	bh=0k5yjZl4vRmofziFWi9oG66Z9lvqiWvEA4ZQGqJDIvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeYe4kRfaL/b2loWnXd7ttJIBysVVy/Qe2lbk31arHF2TZCO/AfV4Wd+rxIrhXKJLrBUNNgFrLUXNB/URO6+OJq0GicFlTtyIJwuuj5MltNByZwDyV6tyThZw8eWf0a5xya8S2qocxMdJcRD5iEDyrkiCWANW5NJFqOaNGtVWb7qLG4yfk4sM00miMtxdyMZ0CZxoy6pcri3ehVY3XkLNbpR0ZihYdvVXlkrkiGVY7jJRkpzQIw/DOFaMCyYyfM1YiwcIATeUQ+Kk4A1CCu+3bIQ8NYOuge6q1TemRx2uQr4SBV7IgbAcnHNto9sxqauWm0PMhKz30PQb8g7Hur03w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJIT0ssx; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJIT0ssx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVGJn6XtLz2xy3
	for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Jun 2026 02:20:25 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D54A402CF;
	Tue,  2 Jun 2026 16:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661911F00893;
	Tue,  2 Jun 2026 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417223;
	bh=0k5yjZl4vRmofziFWi9oG66Z9lvqiWvEA4ZQGqJDIvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hJIT0ssx97ERW0yGHGdcAT7Onyw2jRu3dp6/o7krwbw88WSv6suDGkCjttC1oDfsY
	 aSQigl1oNaNO2XtrFypJjWpzeyx9yWJbPf4I0urwcRMwUlMHmB1furYutcp9B9RRtN
	 g1OVtUn2jaT7a2LH8r2jVudjwwGLbPKZuPN32RgADkEl418D6BpCv0CD3cuFvSjUY1
	 UN9cmu2E5srnx/Twd7c1B2ZWVHke/iyUkf5XxXYOO26yFtXI4spd8q+ROi4Iz7rz/x
	 3XCAbB12R3EfmL/z9wfv9YNlNyt5uYoSNMUajVXFpP6GoUfY5AaAAs28YkFXBRgpr8
	 RjWX5shckYo+Q==
Date: Tue, 2 Jun 2026 17:20:19 +0100
From: Conor Dooley <conor@kernel.org>
To: u8813345@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	colin.huang2@amd.com
Subject: Re: [PATCH v3 1/9] dt-bindings: arm: aspeed: add Anacapa EVT1 EVT2
 DVT board
Message-ID: <20260602-cupping-cahoots-40da41ef0f67@spud>
References: <20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com>
 <20260602-anacapa-devlop-phase-devicetree-v3-1-7c93c5df8d9b@gmail.com>
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
	protocol="application/pgp-signature"; boundary="PLx3EfovJTpILGs4"
Content-Disposition: inline
In-Reply-To: <20260602-anacapa-devlop-phase-devicetree-v3-1-7c93c5df8d9b@gmail.com>


--PLx3EfovJTpILGs4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--PLx3EfovJTpILGs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCah8CwwAKCRB4tDGHoIJi
0s1kAP0VxPsI2ai9KcE8KjyAxQu6KSL/RYgc7cxhHgVC0P+rzQD2POXKO6YSEjEE
5WfTAe4ILcmjizB2Ac+SEFo7f85KAg==
=cSj8
-----END PGP SIGNATURE-----

--PLx3EfovJTpILGs4--

