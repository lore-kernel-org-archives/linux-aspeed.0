Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99CF606A31B
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Nov 2026 04:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ORjN6Qaq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLRRc3M6kz2xH7;
	Fri, 06 Nov 2026 15:44:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793940284;
	cv=none; b=KUytQPQU/41/kT/f9oEqYd+AszyMqjRpnI2o4z3oPlJ4Gl16bisiEsOZAZlLO2LFHlbZbIBY0uBnbNv++Hf0zwR6kxtTKlSDFZOB0bDhyInZ55abbGROEVBgPCcqrEy0fWV0zrbKjqZtaoXMUhOrXeu8IqqltJljAE0pKH5xlVBo6vL4I4n/XIbqfm13YdH9TkxbDw1mpdkaulP1nAXmQ+IuGG1cF+Zc0sKFRifubkr15+CwhxgrMDnfxUzT1Ruuez2dww4CA4nYoGO6Sj4a2up1Z0Q+fUnDcbwVvDPIwutY2MISQMjUkiLJF2035r5w1dh+UKGQ2cxyliRMTqBZ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793940284; c=relaxed/relaxed;
	bh=YFoZXU10IP230tleaiBGL1W+4BzMqJD5/OQifxbywPQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TY3nOBX0468aFIFp9aXo4rS77bGwqnNZCt2pZWZ6mZRBc8jxQOiNroKSDVS6cb8GicMp1mRHH8LqTyE0slFxxFAjncaC3/C2Ra9DWQjzON80fC79woYqR6MrA15ZGCGW7KV8pcO+ikfQfZwE5tcgY6zM07bY6eLY4nYoWCiu8nh4Q0LXp1FcurifdZ/nobnMk438GctTQr/5TrStTusN/KAzL7zquKP8/yKLVSDovWmRh+PvhND160UGnoPN7FvxHbhPQGpBlnU2NqroF6oC/N8OMuh338VELZwp3Ad8754LcR2kIhXRoRrdYz1n0wOkMNVrO/qSZN6De/t0X7nIuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ORjN6Qaq; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ORjN6Qaq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLRRc0KGLz2xDD
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 15:44:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793940283;
	bh=YFoZXU10IP230tleaiBGL1W+4BzMqJD5/OQifxbywPQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ORjN6QaqOIz1opYhhwsBq8ZHWvenOnD/h7Pyt2qqBWAk4IWMV1kigIYqGjllF3ZJY
	 G1bcFgU6+ExgM8Pwj1Qs1FiX2qRLh+YEIiJ1p2pnAJoR3MUfdMIFDl08Dd1/NHNq5g
	 zvjGn9sH5VVm0LfVu5qHdmvqabPC3o5zJ/aD0sLsXyf8edV/z7Gt/ypFr81dXdj4Bh
	 jYBmRyGU7qCJMUWzOCDYE535xqUGLUz2I2SyQSgpuxqeYmGN89bNT9JjF6viTDmJA2
	 GwhkpJwNaRYNsi8mRn2wTkutRaZV/NGLpjLVENy8qwiDZwBdgU1PSQ6iEE1qlkpapd
	 rmmmauy9Vda0Q==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AB8BB64952;
	Fri,  6 Nov 2026 12:44:42 +0800 (AWST)
Message-ID: <971b14eb2ea35ae89b5517438435460bdc8385a3.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 2/3] ARM: dts: aspeed: add Intel AVCRP BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Dawid Glazik <dawid.glazik@linux.intel.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	maciej.lawniczak@intel.com, Andrew Lunn <andrew@lunn.ch>
Date: Fri, 06 Nov 2026 15:14:42 +1030
In-Reply-To: <aa35e5bb8a3d49ea4d5bc245887aaf8ce0ce42b1.1792749922.git.dawid.glazik@linux.intel.com>
References: <cover.1792749922.git.dawid.glazik@linux.intel.com>
	 <aa35e5bb8a3d49ea4d5bc245887aaf8ce0ce42b1.1792749922.git.dawid.glazik@linux.intel.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-10-26 at 17:40 +0100, Dawid Glazik wrote:
> Add the initial AST2600 device tree for the Intel AVCRP BMC platform.

Can you please provide more information about the platform design and
its purpose?

>=20
> Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v4:
> =C2=A0 - Rebased onto aspeed/arm/dt of bmc/linux.git, no other changes
> v3:
> =C2=A0 - Sorted nodes alphabetically
> =C2=A0 - Sorted properties per dts-coding-style
> =C2=A0 - Removed lpc-snoop label
> =C2=A0 - Removed &i3c_global since it's enabled by default
> =C2=A0 - Removed GPIO line names for pins claimed by pinctrl
> =C2=A0 - Restored Reviewed-by from Andrew Lunn, dropped by mistake in v2
> v2:
> =C2=A0 - Reviewed-by: Andrew Lunn for nodes: &mdio1, &mac1
> =C2=A0 - Replace bootargs console=3DttyS4,115200n8 with stdout-path =3D &=
uart5
> =C2=A0 - Remove the unreferenced video_memory reserved-memory node
> ---
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../dts/aspeed/aspeed-bmc-intel-avcrp.dts=C2=A0=C2=A0=C2=A0=C2=A0 |=
 322 ++++++++++++++++++
> =C2=A02 files changed, 323 insertions(+)
> =C2=A0create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.=
dts
>=20
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed=
/Makefile
> index 6874b621deb4..1e4154f12228 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> =C2=A0	aspeed-bmc-ibm-rainier-4u.dtb \
> =C2=A0	aspeed-bmc-ibm-sbp1.dtb \
> =C2=A0	aspeed-bmc-ibm-system1.dtb \
> +	aspeed-bmc-intel-avcrp.dtb \
> =C2=A0	aspeed-bmc-intel-s2600wf.dtb \
> =C2=A0	aspeed-bmc-inspur-fp5280g2.dtb \
> =C2=A0	aspeed-bmc-inspur-nf5280m6.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts b/arch/a=
rm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
> new file mode 100644
> index 000000000000..010ace09d90f
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
> @@ -0,0 +1,322 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2026 Intel Corporation
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	compatible =3D "intel,avcrp-bmc", "aspeed,ast2600";
> +	model =3D "Intel AVCRP BMC";
> +
> +	aliases {
> +		serial4 =3D &uart5;
> +	};
> +
> +	chosen {
> +		bootargs =3D "earlycon";

Please remove bootargs here, earlycon is for debugging.

Andrew

