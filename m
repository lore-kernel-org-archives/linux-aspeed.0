Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849D606A329
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Nov 2026 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=VdVV4V5Y
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLRZZ5QCDz2xH7;
	Fri, 06 Nov 2026 15:50:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793940646;
	cv=none; b=nY3Ox2W3OJN8MLDYr/yxde4CVcfD8kao6RtrcfZ/s5g194K3JOOuOKfhgdIBHdqoRAmbZvGqS1pMIcWac9+wXtah7n6auGEXy/sNQe5oKg7JVFRmxhgj5yVMdv+mcHeqWSIEimEotoMtpVCIZuALT3Z5MA8e+w5vNVADRB4LjvLZ93BkylZoud4Oj+MGE5Wj+SxWvbH3Iv8Sq7Wg7QjqqB38lei5tiX3qrn7GSbEksKEScJhaEBzh4eu02ruE2YmU2crP5nDv60MNHAvYK9uKmDtmW4fpwhQ+s2oSgIYONT2bhVkskmGkh+Ovy6kmligapI+lhf6PLZkdwnb3WCJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793940646; c=relaxed/relaxed;
	bh=kxFpMtQbzKIRxEyj/jc+g0b9VDx9hp1+9az4E+nbn3U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c5aw8yYQd9xTA84Dg0EvWtT4Mi6eBAiGeJ0smmBessMRjyBHHM0qwQAd7VOB61keP49b9SmjDM9biCU2iwctorRj+pJ+PxvtNRwBmljbRFkXWYpVRhcBHICG68TWI6QP1OqtYLXq287QuxTjc4R9baeAfEWq1Q2P3bhZAUdL/mGFQEk+di9y5SKXPxOJbZvHEMij3MmbMxk7NyUC5gEo4uU7KAzwBiWAGdPerLA8eLLqqpaYndOwyWmne62JAUPnxfMh33JCBi6ZKdE4o5dapnXv4P5PyqCo7F6LF7qIf7gSF6Go9YYGCKMZ5PQYD3Sa3EHjsXLkH0pYqsnMmo1U4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=VdVV4V5Y; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=VdVV4V5Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLRZZ1pCMz2xDD
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 15:50:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793940645;
	bh=kxFpMtQbzKIRxEyj/jc+g0b9VDx9hp1+9az4E+nbn3U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VdVV4V5YyBeklNYMLlTDcpWHCtmgoy7lcLNQr36qF84kCLsoNnb/nc/Hd9v1lTf/W
	 o7qbp9x44oun7kbQvUe1AOhr/28CoD/9ZLPqBuhRng+BHIx/JHeb6ciGFQoJxTeeJ5
	 6uIXhQua2Lqsdmq12APk08T5vkuCOZib9/0JV6nZ0DSnQMto9gc1Wu0T8aXW2IVjyD
	 4vXyYoPEoBWLrCr9l6ecnygTl2IFeqaZfamMw5da2cGnJiDGnq7Jc5yqLvuq7W4oRs
	 RsM0t4sks6ZqXJ8i6dPi0oTJP+hNR7qCT98HzKgUy21OVHfLmENgNSWZsQUDj3efHO
	 AmDX4/IYAwGBw==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1C32964952;
	Fri,  6 Nov 2026 12:50:45 +0800 (AWST)
Message-ID: <7eda59ffde46142602c6d8e425fd4097872ee8c4.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 3/3] ARM: dts: aspeed: add Intel JNCRP BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Dawid Glazik <dawid.glazik@linux.intel.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	maciej.lawniczak@intel.com, Andrew Lunn <andrew@lunn.ch>
Date: Fri, 06 Nov 2026 15:20:44 +1030
In-Reply-To: <ffb7b028f317a3a2cd1a98b8f454b46a706cee42.1792749922.git.dawid.glazik@linux.intel.com>
References: <cover.1792749922.git.dawid.glazik@linux.intel.com>
	 <ffb7b028f317a3a2cd1a98b8f454b46a706cee42.1792749922.git.dawid.glazik@linux.intel.com>
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
> Add the initial AST2600 device tree for the Intel JNCRP BMC platform.

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
> =C2=A0 - Added &kcs3 and replaced flash layout with 128MB one
> =C2=A0 - Restored Reviewed-by from Andrew Lunn, dropped by mistake in v2
> v2:
> =C2=A0 - Reviewed-by: Andrew Lunn for nodes: &mdio1, &mac1
> =C2=A0 - Replace bootargs console=3DttyS4,115200n8 with stdout-path =3D &=
uart5
> ---
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../dts/aspeed/aspeed-bmc-intel-jncrp.dts=C2=A0=C2=A0=C2=A0=C2=A0 |=
 276 ++++++++++++++++++
> =C2=A02 files changed, 277 insertions(+)
> =C2=A0create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.=
dts
>=20
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed=
/Makefile
> index 1e4154f12228..5e685a625883 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -58,6 +58,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> =C2=A0	aspeed-bmc-ibm-sbp1.dtb \
> =C2=A0	aspeed-bmc-ibm-system1.dtb \
> =C2=A0	aspeed-bmc-intel-avcrp.dtb \
> +	aspeed-bmc-intel-jncrp.dtb \
> =C2=A0	aspeed-bmc-intel-s2600wf.dtb \
> =C2=A0	aspeed-bmc-inspur-fp5280g2.dtb \
> =C2=A0	aspeed-bmc-inspur-nf5280m6.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts b/arch/a=
rm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts
> new file mode 100644
> index 000000000000..e66ea7f00fed
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts
> @@ -0,0 +1,276 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2025 Intel Corporation
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	compatible =3D "intel,jncrp-bmc", "aspeed,ast2600";
> +	model =3D "Intel JNCRP BMC";
> +
> +	aliases {
> +		serial4 =3D &uart5;
> +	};
> +
> +	chosen {
> +		bootargs =3D "earlycon";

Please remove bootargs here, earlycon is for debugging.

Andrew

