Return-Path: <linux-aspeed+bounces-3283-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D46D25030
	for <linux-aspeed@archiver.kernel.org>; Mon, 12 Jan 2026 01:47:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqFd90v9hz2yqT;
	Mon, 12 Jan 2026 12:47:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768182477;
	cv=none; b=REuhbywxb3pJl+jAI5HQGZSeA6W/egBXp78IjB8/fks7WiTwT093dbnlRFrMwppynciBvR0BJhz4vGOR+RUXCimyHiEFzcyoeS3XXGB0DMdkCviZU6k/FkmXgRt15hUByMpehu63PV+tU0KMzl/68TdPIqIiLE++UXerdrMbN14ZBijhPwSa+BFLxokFTgtVDqQHxzaLvlL2+hIZL4qfz9tRQqNld/ZUO3t1/zrpOniTnW3qoz/vuIM6jeIxZcX29MEmxgYhSwSoJlygTH0vuDik0kyfuk8u9fj6OznyfJo52I7254OaNm/bvKEwMv7uoH8eLuCU/wjjcrsLdSFQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768182477; c=relaxed/relaxed;
	bh=V9knavuyCT6oMajtPRYkTyO37PoH9hWBI4tf+SPVJ9A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UusGTz2a0NcLAydglTwU0ePLgcYFrIiugw3LGiwPxUKB3ZwcZDoi1u65aPwBIPzmI4XKdaJFv/Hu7WMuSGET8d7Lo7jLCCI8m/GjnUoYiuNBekzPiMzJ+T5RiYMB3xUlD0wnf7phhlwkIWa5DSVhywvTaJU7W8H80e3DcX97I1/HC2ocbC88BIb3xY6rmXokhYgZUtJ/MK9gcKBMXe1qDjNNaImaGVzUceV46NQNdycB0FsZW/YGK48b6N+4If2kqif6WUzVPetoIkiVLRnjQoZz2FOaGB9b4gLcLSbNvFNhN/3dgtzxep/3DWKw3Pbeii4VVcADxp9rjiqLtGAxxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=go3Z1fPX; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=go3Z1fPX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqFd83ctlz2ypw
	for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 12:47:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1768182475;
	bh=V9knavuyCT6oMajtPRYkTyO37PoH9hWBI4tf+SPVJ9A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=go3Z1fPXa5bUPR03yLVrGGZm9mRU49Jry1I2HmDOI4bZadYTX+Vqrzd7+2DiuDGPp
	 DzjCEOakYzF+015VYQK2VNaLP3fEjnwSxO5fvAM0OQVsJjpusVi0yHFsIUI5Zrb1YP
	 yADtbm2VuJxZoiLQALWuXzDbCRN20LQBoE2RNg2zEo+LQnmeqFCbs1gl4eDXADnwDS
	 LgQTRsxG70Y2jn1hHRjP/Ew3IPdhEG0uhCM4cluMYd/3Hyq2Lk0Ac/21AhtYlRIc9A
	 Oqnw9ssHTfW2FPT6cC/yRmJG7GZG2fQGfJUsBXY+oa19+8dbKeV0MmqlkO3OuntbHi
	 hSb0BY1xxkMkg==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7D84F648B5;
	Mon, 12 Jan 2026 09:47:55 +0800 (AWST)
Message-ID: <3db927cd7ece9b0672b9e62eab64b951594470dd.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add Asus IPMI card
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Anirudh Srinivasan <anirudhsriniv@gmail.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Jan 2026 12:17:55 +1030
In-Reply-To: <20260111201040.162880-3-anirudhsriniv@gmail.com>
References: <20260111201040.162880-1-anirudhsriniv@gmail.com>
	 <20260111201040.162880-3-anirudhsriniv@gmail.com>
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

Hi Anirudh,

On Sun, 2026-01-11 at 14:10 -0600, Anirudh Srinivasan wrote:
> Add device tree for Asus IPMI card, an AST2600 BMC PCIe card
>=20
> Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../dts/aspeed/aspeed-bmc-asus-ipmi-card.dts=C2=A0 | 136 ++++++++++=
++++++++
> =C2=A02 files changed, 137 insertions(+)
> =C2=A0create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-ipmi-ca=
rd.dts
>=20
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed=
/Makefile
> index 9adf9278dc94..ff40d9ab88b7 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> =C2=A0	aspeed-bmc-asrock-spc621d8hm3.dtb \
> =C2=A0	aspeed-bmc-asrock-x570d4u.dtb \
> =C2=A0	aspeed-bmc-asus-x4tf.dtb \
> +	aspeed-bmc-asus-ipmi-card.dtb \
> =C2=A0	aspeed-bmc-bytedance-g220a.dtb \
> =C2=A0	aspeed-bmc-delta-ahe50dc.dtb \
> =C2=A0	aspeed-bmc-facebook-bletchley.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-ipmi-card.dts b/arc=
h/arm/boot/dts/aspeed/aspeed-bmc-asus-ipmi-card.dts
> new file mode 100644
> index 000000000000..fea94360245c
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-ipmi-card.dts
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2025 Anirudh Srinivasan
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include "aspeed-g6-pinctrl.dtsi"
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model =3D "ASUS IPMI Card BMC";

I'd drop the "BMC" from the model description as well (wrt the
discussion on patch 1/2).

> +	compatible =3D "asus,ipmi-card-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial4 =3D &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial4:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x80000000 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		video_engine_memory: video {
> +			size =3D <0x04000000>;
> +			alignment =3D <0x01000000>;
> +			compatible =3D "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		led-fault {
> +			gpios =3D <&gpio1 ASPEED_GPIO(C, 5) GPIO_ACTIVE_HIGH>;
> +			panic-indicator;
> +			default-state =3D "off";
> +		};
> +
> +		led-heartbeat {
> +			gpios =3D <&gpio0 ASPEED_GPIO(A, 7) GPIO_ACTIVE_LOW>;
> +			linux,default-trigger =3D "timer";
> +		};
> +
> +	};
> +};
> +
> +&mdio2 {
> +	status =3D "okay";
> +
> +	ethphy2: ethernet-phy@0 {
> +		compatible =3D "ethernet-phy-ieee802.3-c22";
> +		reg =3D <0>;
> +	};
> +};
> +
> +&mac2 {

This looks good in general.

For the purpose of review I've started requesting that phandle
references be ordered alphabetically, because it's tedious to confirm
they're ordered by unit address, and it's nice to have consistency
across the files. Can you please fix that along with Andrew Lunn's
concern about the phy-mode?

Andrew

