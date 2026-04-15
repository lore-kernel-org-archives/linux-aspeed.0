Return-Path: <linux-aspeed+bounces-3906-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05738F43833
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Apr 2026 15:16:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwl983KcMz2yvr;
	Thu, 16 Apr 2026 01:16:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776266188;
	cv=none; b=hA3ChI2Wwk4/zNy+/KPGzzqwXL7lJ5ZZ+HGXzXPvOV4D37R+/QRgHiTpT+GroFpf01F6wUM+UCb1YH1Uy5SRKNd8zy5C0s0IZhTrD1KL3pQgZNvXokpqD7qVQQZMA8RS3Po0KY2pAZwLSaU7YHKGx1XPKRJdMgUzGcCnZZT5F2AgWRoAtUPTByWq0MwK853GE40btE3xYGXmH9GG/1OKjT+GaXsU5a8r0zUoflojnkLEEGm7ZnQbusjzw9r+XChjjkxaZk/dzyWAfNmsRlgGrQ56sIRz9JId0m6M1dAdPGG2wk7A2Gf2b6SQbSIAgX2Rbnifdrfzm2+E4ggnko5cgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776266188; c=relaxed/relaxed;
	bh=ms3qftcx9l8CcCu7n9bXhHjFHP3lu9ydftyONXWJth0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mC63htHh9rziDkkFg87OCupAfluD7c7lIzKhy9wu63azAk7DWgmMfw3R+U701mOoW/jKaMzwbqRS+rrZZSqlrK9kXJ/XRVnDGITNvlNiMQY+fhrSBH6hoe5O8olCIpTy6F8cCF2XHCJqFbXFeJko+c5Et6rqUKEcg0p7m+kC9WUEzGRtKq//FugvsSIV7383r26Z1otj+63k9dLkyPPL6NCdcIkdIUVu3Ih/Nl/onS6yQVrfbV0yEA2yvHC2j1fKZ92TE+5EItp7RuirRbLwJpPJeC3aosDshffPQ20lOLrO1UN4UQYcLts27SgSAbBtd1vOk8sf2lMeKKbESuo+fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BxasmsFP; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BxasmsFP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwl972FzXz2yvG;
	Thu, 16 Apr 2026 01:16:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 75A0B600AD;
	Wed, 15 Apr 2026 15:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78ABC19424;
	Wed, 15 Apr 2026 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776266179;
	bh=ms3qftcx9l8CcCu7n9bXhHjFHP3lu9ydftyONXWJth0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxasmsFPvYIRmUnYJKcAbphex+Wq5Pjp52xM7nx1/wr37rxyxDr6pxdPjg3OiMYrL
	 0GF2RZDY1Ji7/wVnMccZXCIFYwRXt5iNiz+sEVa/2lEqeOhVGfjuooYwXpxNWzSmn1
	 PXyCT6nUNFAqZxd+j6voIb9pqaX+V8e1NG2H82EsQQAPCNgyjRy1Yhnx4BfkUKUlJi
	 3QSRKmvtxpQxwGle0iY7cvCGZAoL+vknOQ6lMbjJUB+4GCxrLlYESj21plkLMj1FJn
	 MaA+7rtESxCqHReFhUjrsfwSSdi3dWopxsBejjve1jZ32Qg3ma4Zkrq9bE1nUo11V3
	 r+tpxn8tkVrMA==
Date: Wed, 15 Apr 2026 16:16:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: jk@codeconstruct.com.au, andriy.shevchenko@linux.intel.com,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rayn Chen <rayn_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH v29 1/4] dt-bindings: i2c: Split AST2600 binding into a
 new YAML
Message-ID: <20260415-quartered-value-c97d22249d2e@spud>
References: <20260415-upstream_i2c-v29-0-317c1a905ae1@aspeedtech.com>
 <20260415-upstream_i2c-v29-1-317c1a905ae1@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="T+1xF5cKS74kAZx6"
Content-Disposition: inline
In-Reply-To: <20260415-upstream_i2c-v29-1-317c1a905ae1@aspeedtech.com>


--T+1xF5cKS74kAZx6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 01:14:02PM +0800, Ryan Chen wrote:
> The AST2600 I2C controller introduces a completely new register layout
> with separate controller and target register blocks, unlike the mixed
> register layout used by AST2400/AST2500.
>=20
> Move AST2600 I2C binding from aspeed,i2c.yaml to a dedicated
> aspeed,ast2600-i2c.yaml schema.
>=20
> Besides the split, this also adjusts for AST2600-specific requirements.
> - require two reg regions (controller register block + buffer block)
> - use clock-frequency for bus speed description
> - interrupts are required on AST2600
> - use correct DTS coding style in example
>=20
> No compatible strings are changed.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--T+1xF5cKS74kAZx6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCad+rvQAKCRB4tDGHoIJi
0i4+AP42ReMqv194rOhH36frqjgErlXbSrRKDSEC57660lJwPwEA6By5dTTLyEEk
89m6goS9CjKTurkjleB8q03uegrHXws=
=AghQ
-----END PGP SIGNATURE-----

--T+1xF5cKS74kAZx6--

