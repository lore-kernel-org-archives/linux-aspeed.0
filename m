Return-Path: <linux-aspeed+bounces-4314-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3598AC43458
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Jun 2026 15:26:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpqrX3HnKz2ySS;
	Tue, 30 Jun 2026 01:26:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782746812;
	cv=none; b=ZyjFecbx+647LsjzaqBSgDjE3a90bE8dYLpaAtrhzK2B8ZmNZaidV7jAB+GaT57FI49tzDcW1qiJWMrrgAyzJkLwpeonYxCGth76OJojvuNZakrpVDMtR0N85FSR4aBn7x/FtaXocXcIHlNoUWTWX3FGnyRqEPej6IyK+LGEQi3KUPUsGVIgyf61nv5A6Z/ynxqXcpc7dop1NNaKxxH9uNWobbPwoGJYRJDIV+KePDRZ+SQIzCKFJTB1BGxpzU2lKzhQIdZu23gzlZN7XUiwuaKd/cszuu8+vuyEPK+eHdsQOogjkD7fz7a0GqpDOIATtRtWh+smm9caJEWsTQmejA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782746812; c=relaxed/relaxed;
	bh=1DD1v7WAUfTa8LEsmdnXmo8TZcmGZDr0zVXhLE2Z5xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6oNC0agr1B7Dfpqv8M0YKKYc9zfQt9QHCCurVMju3BZ9CK10hc3UKTP9YpHvELKi0v4HZ7NQGX2jtXWIn3DwfD0iPhMkWW2WnkjT60lcwlvxmkD9PRKafhqFYGXpkUfT8J9X+AO0maohipLOmWkYI0+BpTg6T3u9nduVgAknWD2Byb5gH7lPIMT8SYfb0tyHsumOkc+7XqCoX3okJAOTqsstbrRaRcQfm/EZ+UoaVs1FlVJPfeLtFxWogg+3lkw9VMjiVxz93coKAP5UpzCf9VpZjigcKwcCfwogoLNo1vyGzYaZ4qqSaUUrTDsARjiAHO1B5DGEUu1KJvhNuUVcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIQ37Fhi; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIQ37Fhi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpqrW03Bsz2yFc
	for <linux-aspeed@lists.ozlabs.org>; Tue, 30 Jun 2026 01:26:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 46698600AB;
	Mon, 29 Jun 2026 15:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF75A1F000E9;
	Mon, 29 Jun 2026 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782746808;
	bh=1DD1v7WAUfTa8LEsmdnXmo8TZcmGZDr0zVXhLE2Z5xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kIQ37Fhi2asFeMqWXXsLFHsaVl4ib20zlyAFLNPHlXv0muZuUzgETqBfuj/Xy0YSa
	 WJJts9i1xfRTBqy+zfHF5JnBJTN/zs0dNJNhfZhaGXZ8Z19wG+JNMOIwlQY1iqmiff
	 PIziNckrvryuyZfyUnkqvaVrPWY2MHnD/UBExEufw9TxRtRGGQbL03J5eqvKCl69E3
	 pDJ3L5POMusd4aiY7cHf4gavA7VhI/eO9NRlRTEBLytFyr1ZY95b2cvcTvDYFIdKTd
	 hDbN0ncM+iPhk21ehxXhUZxcdXehe4d2QrzD7j+JKWClC5ai3hdfGDw94kMdZ2sphP
	 o+cmD1krgsh/A==
Date: Mon, 29 Jun 2026 16:26:43 +0100
From: Conor Dooley <conor@kernel.org>
To: yc_hsieh@aspeedtech.com
Cc: Corey Minyard <corey@minyard.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 3/4] dt-bindings: ipmi: Add optional LPC properties to
 ASPEED BT devices
Message-ID: <20260629-bogus-vocation-db32e55a595f@spud>
References: <20260629-aspeed-bt-bmc-multichannel-v1-0-fc23ee337f7a@aspeedtech.com>
 <20260629-aspeed-bt-bmc-multichannel-v1-3-fc23ee337f7a@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="JftmSqqify0j7mOM"
Content-Disposition: inline
In-Reply-To: <20260629-aspeed-bt-bmc-multichannel-v1-3-fc23ee337f7a@aspeedtech.com>

--JftmSqqify0j7mOM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 02:49:00PM +0800, Yu-Che Hsieh via B4 Relay wrote:
> From: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
>=20
> Allocating IO and IRQ resources to LPC devices is in-theory an operation
>=20
> for the host, however ASPEED systems describe these resources through
>=20
> BMC-internal configuration, as already supported by the ASPEED KCS BMC
>=20
> binding.
>=20
> Add aspeed,lpc-io-reg and aspeed,lpc-interrupts to the ASPEED BT BMC
>=20
> binding so firmware can describe the host LPC IO address and SerIRQ
>=20
> configuration using the same properties as KCS devices.
>=20
> Signed-off-by: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
> ---
>  .../bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml       | 21 +++++++++++++++=
++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bm=
c.yaml b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml
> index c4f7cdbbe16b..1803c6bbae93 100644
> --- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml
> +++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml
> @@ -25,6 +25,24 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  aspeed,lpc-io-reg:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 1
> +    description: |
> +      The host CPU LPC IO address for the BT device.
> +
> +  aspeed,lpc-interrupts:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2
> +    maxItems: 2
> +    description: |
> +      A 2-cell property expressing the LPC SerIRQ number and the interru=
pt
> +      level/sense encoding (specified in the standard fashion).
> +
> +      Note that the generated interrupt is issued from the BMC to the ho=
st, and
> +      thus the target interrupt controller is not captured by the BMC's
> +      devicetree.

Why can these two properties not just be an additional reg and
interrupts entry?


Cheers,
Conor.

> +
>  required:
>    - compatible
>    - reg
> @@ -35,10 +53,13 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/clock/aspeed-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> =20
>      bt@1e789140 {
>          compatible =3D "aspeed,ast2400-ibt-bmc";
>          reg =3D <0x1e789140 0x18>;
>          interrupts =3D <8>;
>          clocks =3D <&syscon ASPEED_CLK_GATE_LCLK>;
> +        aspeed,lpc-io-reg =3D <0xe4>;
> +        aspeed,lpc-interrupts =3D <10 IRQ_TYPE_LEVEL_LOW>;
>      };
>=20
> --=20
> 2.34.1
>=20
>=20

--JftmSqqify0j7mOM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakKOswAKCRB4tDGHoIJi
0psAAP9G4epdhbKfSpCHpiVzmew6DQEbokTKpL+98RgnG2LBKQD/U3BgoLrNNiQx
n3K2bKbjCnRtMLKQG2R8sbPvLE9VbwM=
=ygXE
-----END PGP SIGNATURE-----

--JftmSqqify0j7mOM--

