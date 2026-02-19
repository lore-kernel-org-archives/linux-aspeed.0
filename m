Return-Path: <linux-aspeed+bounces-3524-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F49E9A03B
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Feb 2026 04:21:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGgDD09VWz2xlj;
	Thu, 19 Feb 2026 15:21:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771474859;
	cv=none; b=N8E6sG+eSxSAnYrNUUJJijqwzimzSgaPVqFyyt/tS+Up/NF+G5X0qW5kRS+j1iqdLUOI+EHzcCHo+5iTSRRk0z0ANOL3V3PamCyBkpYJsLuXv9Wk8gc8oh2wau4/tDUwofu9ZeSzmVhfgnn4LPvQaemI7ODYBrOzny9t/RK8ljN3KmdI5rYlsLRls0H/v/6qO5p6quvtGkTObsQXAINtXtUrwWHGLDpoaWLKzdsGhmKJCqnb/9YZZarkc0TXwE1V9TFtsVtHgwxHqxACUYYxYlGugApMIXKXGZ6IFGUBCTQ51v0Xi0V/Fwrg8GSdSfaZVnYZpPF/MoL/PChYVE4zVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771474859; c=relaxed/relaxed;
	bh=hXrvUZQrcqQlGaHQ11Cid7iVmcJJZTJxmPs9kL1e/rs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UNbUJjQjkIcd45hQtSbsFGqe18nUVBZg82jOy8rLJSOkfkmtMFNDJSw12D2riyjM7Ds3DOc+JHGY0N2RIhb0XiO5vGMfgiGCnlvc94lhCj9JC8j54bL9axB0RXLLqavN9IS/p/b4JiQnbS9PW6m1JwNQUdzUZdmkR5h/3ryr4LKN+BDpvImO9KN9AiDT7g2qy4xu3uMkDmvWD6SSUi8L/7Q2/z/S1kkBw3USFoUoQKmHrLoQ4vME3foQnS7gTNRoGhgqsiW818DHGFiJvpj7DlFuVhWlGNfZoy4qY2Os0QLEJbzsDUsiIXblYntmjzuDrTIfpBGCDXPOkCuqA2diYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Bwojwkgh; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Bwojwkgh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGgDC1q2Jz2xN8
	for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Feb 2026 15:20:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1771474857;
	bh=hXrvUZQrcqQlGaHQ11Cid7iVmcJJZTJxmPs9kL1e/rs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Bwojwkghc4xDICaeOQpHCSeB8PghyUnrrJCRmCC47tvOKYdQauZ9ySpiEMgRFHQje
	 W7XQ9bOGmCwzJzAxSgb2kQWMHDnx/ck8uhmj78B3mgYQd5yosqtJWjc/aDRaobYMyG
	 1ievMsTD9NDe9y/4hZJpDuMYcEeSZ3CCfADJ8yASmQo+o5gwgvR8A12pyU8vI6HtjI
	 0IkXNFnda2+4MMi1XQliOtPXfvhNz1fd72yaFBtJxUdN58Lcmj0y9qqNtfYGLK2fin
	 ml2MnBIN3YNT9i2P2sMskWwrRTHdNUV04FscunCJESHRjbT4iScD7f1Zj110Q19EG7
	 2ajMkwQcxDSQw==
Received: from [192.168.68.114] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1839760033;
	Thu, 19 Feb 2026 12:20:55 +0800 (AWST)
Message-ID: <6192440acc150d216de5e074299e579e891fc845.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] ARM: dts: aspeed: anacapa: Add retimer EEPROMs
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: dirkchen@amd.com, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Feb 2026 14:50:54 +1030
In-Reply-To: <20260209-b4-anacapa-dts-fix-v2-1-fe446a7038bf@amd.com>
References: <20260209-b4-anacapa-dts-fix-v2-1-fe446a7038bf@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hi Dirk,

On Mon, 2026-02-09 at 15:58 +0800, Dirk Chen via B4 Relay wrote:
> From: Dirk Chen <dirkchen@amd.com>
>=20
> The Anacapa board features Atmel 24C2048 EEPROMs on i2c0 and i2c1, which
> are used to store retimer configurations. Add the corresponding device
> tree nodes to support these components.
>=20
> Signed-off-by: Dirk Chen <dirkchen@amd.com>
> ---
> Changes in v2:
> - Improved commit description to clarify that the change reflects
> =C2=A0 actual hardware as requested by the reviewer.
> - Removed mentions of other platforms to avoid confusion.
> - Link to v1: https://lore.kernel.org/r/20260202-b4-anacapa-dts-fix-v1-1-=
20d4b0114854@amd.com
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 12 +++++=
+++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> index 221af858cb6b..b8d248d99d7c 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> @@ -328,6 +328,12 @@ i2c0mux0ch3: i2c@3 {
> =C2=A0			#size-cells =3D <0>;
> =C2=A0		};
> =C2=A0	};
> +
> +	eeprom@50 {

Please order these nodes by ascending address. The node currently above
this one is i2c-mux@70 - eeprom@50 should go before it.

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-=
nodes

> +		compatible =3D "atmel,24c2048";
> +		reg =3D <0x50>;
> +		pagesize =3D <128>;
> +	};
> =C2=A0};
> =C2=A0
> =C2=A0// R Bridge Board
> @@ -362,6 +368,12 @@ i2c1mux0ch3: i2c@3 {
> =C2=A0			#size-cells =3D <0>;
> =C2=A0		};
> =C2=A0	};
> +
> +	eeprom@50 {

Same for this one.

> +		compatible =3D "atmel,24c2048";
> +		reg =3D <0x50>;
> +		pagesize =3D <128>;
> +	};
> =C2=A0};
> =C2=A0
> =C2=A0// MB - E1.S
>=20
> ---
> base-commit: 4c87cdd0328495759f6e9f9f4e1e53ef8032a76f
> change-id: 20260202-b4-anacapa-dts-fix-207ffe9a3b0c
>=20
> Best regards,

