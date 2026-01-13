Return-Path: <linux-aspeed+bounces-3301-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68F4CF45D4
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 Jan 2026 01:15:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqrsQ3RMqz2xqj;
	Tue, 13 Jan 2026 12:15:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768266713;
	cv=none; b=RL8nl40tYzKVMwq2sAgFOGaXjwrBbgnstJumlRKl8QZLdp9k/Fw81EmOVjPCT0RdWacc7/bHyY2hteJ6R4Dj0srpVWxpb8P1+Ol2PlXqrrcvpzWPwA9x+qLhan4x88CafTRmJqutqvlw/p+TGohyuh6VagoTnxBJliMCjiMGniR6/9TuIk5mE1/kQWUrZAQAQ/Hmf+uXf5YyeOivCdVUjHMBvtPnVeAoWRlvTJTN/udlTvpuNNrC5w20XIZp1s0cdAhpCsGzPfx4LBlS4XCVI38Qb9a3RDEYUF2MIKxiqWRxAIlWG/NklYAVxpo6T8nzVrRcZIFA/6si6yCE7N3FKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768266713; c=relaxed/relaxed;
	bh=SkjvMLrJnigKmMdCcK2k3H/cAhm9En6UKwdXIu8qM+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXYOU6knOsmbNvpQJNT+FwyroQmg6dR9uMB3QskqRRHHeBl4hm+8iuPIp5KIyCrI5CDduT/fX3MqYLN/365afibnI2l5vdtjnELpspRCgLQ5Bpf2Kd5MfgpUkxCpmdUhxBf3JhXsl2F9dV+vbU84zmCwfpQDfT8GeZwCDlrOJUzwyqgYMu/IMUDHUTfzZz0GIwYIgP2MoUeQP1d8Xz82TDavbesZhLiDNp9AeddGTqLbNkN2wn9XWbqCA44wlGrou9ArriOB3ljIUOwRkNPP9iArr1MPwgK9AhW36G+HN7c4f0uI1EWGH3igyQu2kr+c64vJ6JkyPW/neVoHe1+CIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CvwNUZoV; dkim-atps=neutral; spf=pass (client-ip=209.85.221.170; helo=mail-vk1-f170.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CvwNUZoV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.170; helo=mail-vk1-f170.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqrn41lGBz2xKx
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Jan 2026 12:11:51 +1100 (AEDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5636274b338so2951703e0c.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 17:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768266648; x=1768871448; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkjvMLrJnigKmMdCcK2k3H/cAhm9En6UKwdXIu8qM+Q=;
        b=CvwNUZoVueWIWl/IVDz+V+r0G7f3nb4wQD5fk4U0OCr07Mf0zaBWATdV8/O6mK3Y06
         bix8zpC2OPdA+vvjm9f6JehZ/LkaG0dJ5HsWe8zn/N6TeK0+r2HjTBoOg3fZhzOwSJsv
         9tF2TEUaw5LfM6swYKGz4G0djF79L2Cmt0kkvpF5G17rOB5k3RiPPFf5weudn5x2MctK
         Eq2JbBj9ay1xhIppmutovZukZBNy/4OY/cB/pmHYazChAkpwtAUHSqT4cEtZhPwOy9KC
         cBb0T4GI+iVLpObcuOFOBSg8FAi+LfoodofgQdOFCYFjr8+KOfs9M5dkXC4z6VrcCMPn
         npig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768266648; x=1768871448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SkjvMLrJnigKmMdCcK2k3H/cAhm9En6UKwdXIu8qM+Q=;
        b=Muu50C7QoUzE6udIhK5QeQD2I/ZMf31zVqlMN9dLeq0v6cXLbwDRTdI5boUM6h235Y
         Op+Ux0HSqww9Jq8Qay5qiWnvyGtfnye1Mg1ZsVwGG0lBOyVi3v5u2ah9AMJhAjftuBpN
         wQ42izFA7qZ6DGEm7CW9wHGRPcnjv+x1s6NVyizuRCl0AOOgvGNXgy6TvKgMzT/88Wxb
         lSv9SSCIMLbmr4Qq/Mysg59nnAGPHj4Hz5SL0MnNQ2yriBKuX+nOnuynOOj/62GVzhRI
         VL2g3XAQeCHxuXAiJL5qTwF8d0vzQBLa3UtV2apnPAc1bV9MPp4Pz6KzrvtdvFNz6+VO
         zWsg==
X-Forwarded-Encrypted: i=1; AJvYcCVGfNTKKjtxwa2FiV8915dhWnFiWTnuuQmI0fXPT4ZABPRN6xql4rEaFMsb1RBTaymUjd66NrKLw4TUr5g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyIVKCyCeFB0Th7aUaR4hHzz4z3JBIgqI6oBfQktfmRR17uJ9Wc
	guOH1+lmUDfjpUTBU7XcciiShMkRq3Lw78h1mxXMSE3nDflgZkEljDGxqkbRZPkdodk1AYJS9wg
	3LeGjRip4HB6VCv4B7/TVVm1LmJMyOf0=
X-Gm-Gg: AY/fxX5WIUQBXwolz9A2QSoumb88zhFW4n3HJVXuzuqgUTQcg14ApdJBIPE4Yj/ew48
	7w8bnNdbqFGn7ZC+ESxioqEGhUSy76euu0M44byQKmBob7iU5hCBWEYPD0ZAApeukwi20ayzXo1
	laOIY7ws0BAxsfqwNdz5K1nUVseXnbjR81sHpoGFzu9LGxJok8JuK0aH3yHuClK7hYK0hg/yahc
	RkbqxOv7du9nvs8i4crxeoVZaQM8UxpdkWbgUB68zZS6+OHyzJfiBxC5r8bAN7scMVSpwiu
X-Received: by 2002:a05:6122:4896:b0:563:466c:2 with SMTP id
 71dfb90a1353d-56395c42437mr568534e0c.5.1768266648408; Mon, 12 Jan 2026
 17:10:48 -0800 (PST)
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
References: <20251224-ventura2_initial_dts-v2-0-f193ba5d4073@gmail.com>
 <20251224-ventura2_initial_dts-v2-2-f193ba5d4073@gmail.com> <baa2e4e86b0b6851a56ef97501f6cad67d7970e6.camel@codeconstruct.com.au>
In-Reply-To: <baa2e4e86b0b6851a56ef97501f6cad67d7970e6.camel@codeconstruct.com.au>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 13 Jan 2026 09:10:37 +0800
X-Gm-Features: AZwV_QgqSsvNI6cCP4eKfzDR4jBHaqaLbqGDWOCo3Ee8aobMZGS6aolRUOmEwl4
Message-ID: <CAF7HswM1nch2Z1JCQiCowWK7UwrV4zvg_uVJUM6bfnFEWVx9Gw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 12:38=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Wed, 2025-12-24 at 14:44 +0800, Kyle Hsieh wrote:
> > Add linux device tree entry related to the Meta(Facebook) rmc-node.
> > The system use an AT2600 BMC.
> > This node is named "ventura2".
> >
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed/Makefile                  |    1 +
> >  .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 2945 ++++++++++++=
++++++++
> >  2 files changed, 2946 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspe=
ed/Makefile
> > index 9adf9278dc94..6b96997629d4 100644
> > --- a/arch/arm/boot/dts/aspeed/Makefile
> > +++ b/arch/arm/boot/dts/aspeed/Makefile
> > @@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> >       aspeed-bmc-facebook-minipack.dtb \
> >       aspeed-bmc-facebook-santabarbara.dtb \
> >       aspeed-bmc-facebook-tiogapass.dtb \
> > +     aspeed-bmc-facebook-ventura2.dtb \
> >       aspeed-bmc-facebook-wedge40.dtb \
> >       aspeed-bmc-facebook-wedge100.dtb \
> >       aspeed-bmc-facebook-wedge400-data64.dtb \
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts =
b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> > new file mode 100644
> > index 000000000000..e22bbaf519ea
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> > @@ -0,0 +1,2945 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2023 Facebook Inc.
> > +/dts-v1/;
> > +
> > +#include "aspeed-g6.dtsi"
> > +#include <dt-bindings/i2c/i2c.h>
> > +#include <dt-bindings/gpio/aspeed-gpio.h>
> > +
> > +/ {
> > +     model =3D "Facebook ventura2 RMC";
> > +     compatible =3D "facebook,ventura2-rmc", "aspeed,ast2600";
> > +     aliases {
> > +             serial4 =3D &uart5;
> > +
> > +
>
> *snip*
>
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial4:57600n8";
> > +     };
> > +
> > +     iio-hwmon {
> > +             compatible =3D "iio-hwmon";
> > +             io-channels =3D <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3=
>,
> > +             <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> > +             <&adc1 2>;
> > +     };
> > +
> > +     leds {
> > +             compatible =3D "gpio-leds";
> > +
> > +             led-0 {
> > +                     label =3D "bmc_heartbeat_amber";
> > +                     gpios =3D <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_L=
OW>;
> > +                     linux,default-trigger =3D "heartbeat";
> > +             };
> > +
> > +             led-1 {
> > +                     label =3D "fp_id_amber";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_H=
IGH>;
> > +             };
> > +
> > +             led-2 {
> > +                     label =3D "bmc_ready_noled";
> > +                     default-state =3D "on";
> > +                     gpios =3D <&gpio0 ASPEED_GPIO(B, 3) (GPIO_ACTIVE_=
HIGH|GPIO_TRANSITORY)>;
> > +             };
> > +
> > +             led-3 {
> > +                     label =3D "power_blue";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_H=
IGH>;
> > +             };
> > +     };
> > +
> > +     fan_leds {
>
> Can you please order these unit-address-less nodes (iio-hwmon, leds,
> fan_leds, etc) alphabetically?
Yes, I will modify in the v3 patch.
>
> > +             compatible =3D "gpio-leds";
> > +
> > +             led-0 {
> > +                     label =3D "fcb0fan0_ledd1_blue";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander0 0 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-1 {
> > +                     label =3D "fcb0fan1_ledd2_blue";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander0 1 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-2 {
> > +                     label =3D "fcb0fan2_ledd3_blue";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander1 0 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-3 {
> > +                     label =3D "fcb0fan3_ledd4_blue";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander1 1 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-4 {
> > +                     label =3D "fcb0fan0_ledd1_amber";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander0 4 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-5 {
> > +                     label =3D "fcb0fan1_ledd2_amber";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander0 5 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-6 {
> > +                     label =3D "fcb0fan2_ledd3_amber";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander1 4 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             led-7 {
> > +                     label =3D "fcb0fan3_ledd4_amber";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&fan_io_expander1 5 GPIO_ACTIVE_LOW>;
> > +             };
> > +     };
> > +
> > +     memory@80000000 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x80000000 0x80000000>;
> > +     };
> > +
> > +     p1v8_bmc_aux: regulator-p1v8-bmc-aux {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "p1v8_bmc_aux";
> > +             regulator-min-microvolt =3D <1800000>;
> > +             regulator-max-microvolt =3D <1800000>;
> > +             regulator-always-on;
> > +     };
> > +
> > +     p2v5_bmc_aux: regulator-p2v5-bmc-aux {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "p2v5_bmc_aux";
> > +             regulator-min-microvolt =3D <2500000>;
> > +             regulator-max-microvolt =3D <2500000>;
> > +             regulator-always-on;
> > +     };
> > +
> > +     p5v_dac_aux: regulator-p5v-bmc-aux {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "p5v_dac_aux";
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> > +             regulator-always-on;
> > +     };
> > +
> > +     spi1_gpio: spi {
> > +             compatible =3D "spi-gpio";
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             sck-gpios =3D <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>=
;
> > +             mosi-gpios =3D <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH=
>;
> > +             miso-gpios =3D <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH=
>;
> > +             cs-gpios =3D <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
> > +             num-chipselects =3D <1>;
> > +
> > +             tpm@0 {
> > +                     compatible =3D "infineon,slb9670", "tcg,tpm_tis-s=
pi";
> > +                     spi-max-frequency =3D <33000000>;
> > +                     reg =3D <0>;
> > +             };
> > +     };
> > +};
> > +
> > +&fmc {
> > +     status =3D "okay";
> > +     flash@0 {
> > +             status =3D "okay";
> > +             m25p,fast-read;
> > +             label =3D "bmc";
> > +             spi-max-frequency =3D <50000000>;
> > +             #include "openbmc-flash-layout-128.dtsi"
> > +     };
> > +     flash@1 {
> > +             status =3D "okay";
> > +             m25p,fast-read;
> > +             label =3D "alt-bmc";
> > +             spi-max-frequency =3D <50000000>;
> > +     };
> > +};
> > +
> > +&peci0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&mac2 {
>
> Same for all the phandle-referenced nodes throughout: please order them
> alphabetically. Another possible ordering is in unit address order, but
> I prefer alphabetical in the dts because there's no unit address in
> sight (it's in the corresponding dtsi).
I will modify in v3 patch.
>
> > +     status =3D "okay";
> > +     phy-mode =3D "rmii";
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_rmii3_default>;
> > +     fixed-link {
> > +             speed =3D <100>;
> > +             full-duplex;
> > +     };
>
> Andrew Lunn asked for a comment justifying the fixed-link node in [1]
> and you said you'd add it in [2], but there's no comment? Can you
> please add it?
Last time, I pushed the v2 patch too early, so I have not yet added
the annotation.
I will add the annotation next version
>
> [1]: https://lore.kernel.org/all/32ff7ca8-9cb0-4889-adb0-a6dae735630b@lun=
n.ch/
> [2]: https://lore.kernel.org/all/CAF7HswMRrs9hwKo_uHCLMtx7+h46-DPEJRcEqu0=
-zEG4CVvvjg@mail.gmail.com/
>
> > +};
> > +
> > +&mac3 {
> > +     status =3D "okay";
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_rmii4_default>;
> > +     use-ncsi;
> > +};
> >
>
> *snip*
>
> > +
> > +&sgpiom0 {
> > +     status =3D "okay";
> > +     ngpios =3D <128>;
> > +     bus-frequency =3D <2000000>;
> > +     gpio-line-names =3D
> > +     /*"input pin","output pin"*/
> > +     /*A0 - A7*/
> > +     "power-chassis-good","FM_PLD_HEARTBEAT_LVC3_R",
> > +     "host0-ready","",
> > +     "CONTROL_VT2_SUPPLY1_CLOSE","FM_MDIO_SW_SEL_PLD",
> > +     "CONTROL_VT2_SUPPLY2_CLOSE","FM_88E6393X_BIN_UPDATE_EN_N",
> > +     "CONTROL_VT2_SUPPLY3_CLOSE","Sequence_TransFR_Alert",
> > +     "RETURN_CNTL1_FB","WATER_VALVE1_OPEN",
> > +     "RETURN_CNTL2_FB","WATER_VALVE2_OPEN",
> > +     "RETURN_CNTL3_FB","WATER_VALVE3_OPEN",
> > +     /*B0 - B7*/
> > +     "IT_STOP_PUMP_R_CPLD","WATER_VALVE1_CLOSE",
> > +     "IT_STOP_PUMP_SPARE_R_CPLD","WATER_VALVE2_CLOSE",
> > +     "IT_STOP_PUMP_2_R_CPLD","WATER_VALVE3_CLOSE",
> > +     "IT_STOP_PUMP_SPARE_2_R_CPLD","REPORT_VT2_SUPPLY1_CLOSE",
> > +     "RPU_2_READY_SPARE_PLD_R","REPORT_VT2_SUPPLY2_CLOSE",
> > +     "RPU_2_READY_PLD_R","REPORT_VT2_SUPPLY3_CLOSE",
> > +     "RPU_READY_SPARE_PLD_R","PCIE_SSD1_PRSNT_N",
> > +     "RPU_READY_PLD_R","",
> > +     /*C0 - C7*/
> > +     "IOEXP8_INT_N","",
> > +     "SUPPLY_CNTL1_FB","",
> > +     "SUPPLY_CNTL2_FB","",
> > +     "SUPPLY_CNTL3_FB","",
> > +     "PRSNT_TRAY1_TO_40_R_BUF_N","",
> > +     "PWRGD_TRAY1_TO_40_R_BUF","",
> > +     "SMALL_LEAK_TRAY1_TO_40_R_BUF_N","",
> > +     "LEAK_DETECT_TRAY1_TO_40_R_BUF_N","",
> > +     /*D0 - D7*/
> > +     "PRSNT_CANBUSP1_TRAY1_TO_32_N","",
> > +     "PWRGD_CANBUSP1_TRAY1_TO_32_PWROK","",
> > +     "SMALL_LEAK_CANBUSP1_TRAY1_TO_32_N","",
> > +     "LEAK_DETECT_CANBUSP1_TRAY1_TO_32_N","",
> > +     "PRSNT_CANBUSP2_TRAY1_TO_32_N","",
> > +     "PWRGD_CANBUSP2_TRAY1_TO_32_PWROK","",
> > +     "SMALL_LEAK_CANBUSP2_TRAY1_TO_32_N","",
> > +     "LEAK_DETECT_CANBUSP2_TRAY1_TO_32_N","",
> > +     /*E0 - E7*/
> > +     "PRSNT_CANBUSP3_TRAY1_TO_32_N","",
> > +     "PWRGD_CANBUSP3_TRAY1_TO_32_PWROK","",
> > +     "SMALL_LEAK_CANBUSP3_TRAY1_TO_32_N","",
> > +     "LEAK_DETECT_CANBUSP3_TRAY1_TO_32_N","",
> > +     "PRSNT_CANBUSP4_TRAY1_TO_32_N","",
> > +     "PWRGD_CANBUSP4_TRAY1_TO_32_PWROK","",
> > +     "SMALL_LEAK_CANBUSP4_TRAY1_TO_32_N","",
> > +     "LEAK_DETECT_CANBUSP4_TRAY1_TO_32_N","",
> > +     /*F0 - F7*/
> > +     "PRSNT_CANBUSP5_TRAY1_TO_32_N","",
> > +     "PWRGD_CANBUSP5_TRAY1_TO_32_PWROK","",
> > +     "SMALL_LEAK_CANBUSP5_TRAY1_TO_32_N","",
> > +     "LEAK_DETECT_CANBUSP5_TRAY1_TO_32_N","",
> > +     "PRSNT_CANBUSP6_TRAY1_TO_32_N","",
> > +     "PWRGD_CANBUSP6_TRAY1_TO_32_PWROK","",
> > +     "SMALL_LEAK_CANBUSP6_TRAY1_TO_32_N","",
> > +     "LEAK_DETECT_CANBUSP6_TRAY1_TO_32_N","",
> > +     /*G0 - G7*/
> > +     "PRSNT_CANBUSP7_TRAY1_TO_32_N","",
> > +     "PWRGD_CANBUSP7_TRAY1_TO_32_PWROK","",
> > +     "SMALL_LEAK_CANBUSP7_TRAY1_TO_32_N","",
> > +     "LEAK_DETECT_CANBUSP7_TRAY1_TO_32_N","",
> > +     "PRSNT_CANBUSP8_TRAY1_TO_32_N","",
> > +     "PWRGD_CANBUSP8_TRAY1_TO_32_PWROK","",
> > +     "SMALL_LEAK_CANBUSP8_TRAY1_TO_32_N","",
> > +     "LEAK_DETECT_CANBUSP8_TRAY1_TO_32_N","",
> > +     /*H0 - H7*/
> > +     "wCHASSIS0_LEAK_Q_N_R","",
> > +     "wCHASSIS1_LEAK_Q_N_R","",
> > +     "wCHASSIS2_LEAK_Q_N_R","",
> > +     "wCHASSIS3_LEAK_Q_N_R","",
> > +     "wCHASSIS4_LEAK_Q_N_R","",
> > +     "wCHASSIS5_LEAK_Q_N_R","",
> > +     "wCHASSIS6_LEAK_Q_N_R","",
> > +     "wCHASSIS7_LEAK_Q_N_R","",
> > +     /*I0 - I7*/
> > +     "wCHASSIS8_LEAK_Q_N_R","",
> > +     "wCHASSIS9_LEAK_Q_N_R","",
> > +     "wCHASSIS10_LEAK_Q_N_R","",
> > +     "wCHASSIS11_LEAK_Q_N_R","",
> > +     "wAALC_RPU_READY","",
>
> Out of curiosity, what's going on with the lower-case 'w' prefix here
> (and again below)?
The prefix 'w' is the sgpio name, after confirming it can remove this prefi=
x.
I will remove it in the next version.
>
> > +     "","",
> > +     "","",
> > +     "","",
> > +     /*J0 - J7*/
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     /*K0 - K7*/
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     /*L0 - L7*/
> > +     "wIT_GEAR_RPU_2_LINK_PRSNT_SPARE_N_R","",
> > +     "wIT_GEAR_RPU_2_LINK_PRSNT_N_R","",
> > +     "wIT_GEAR_RPU_LINK_PRSNT_SPARE_N_R","",
> > +     "wIT_GEAR_RPU_LINK_PRSNT_N_R","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     /*M0 - M7*/
> > +     "","",
> > +     "","",
> > +     "wPRSNT_SENSOR_N","",
> > +     "wPRSNT3_VT2_PLD_N","",
> > +     "wPRSNT2_VT2_PLD_N","",
> > +     "wPRSNT1_VT2_PLD_N","",
> > +     "wPRSNT3_RETURN_PLD_N","",
> > +     "wPRSNT2_RETURN_PLD_N","",
> > +     /*N0 - N7*/
> > +     "wPRSNT1_RETURN_PLD_N","",
> > +     "wPRSNT3_SUPPLY_PLD_N","",
> > +     "wPRSNT2_SUPPLY_PLD_N","",
> > +     "wPRSNT1_SUPPLY_PLD_N","",
> > +     "wPRSNT_LEAK11_SENSOR_R_PLD_N","",
> > +     "wPRSNT_LEAK10_SENSOR_R_PLD_N","",
> > +     "wPRSNT_LEAK9_SENSOR_R_PLD_N","",
> > +     "wPRSNT_LEAK8_SENSOR_R_PLD_N","",
> > +     /*O0 - O7*/
> > +     "wPRSNT_LEAK7_SENSOR_R_PLD_N","",
> > +     "wPRSNT_LEAK6_SENSOR_R_PLD_N","",
> > +     "wPRSNT_LEAK5_SENSOR_R_PLD_N","",
> > +     "wPRSNT_LEAK4_SENSOR_R_PLD_N","",
> > +     "wPRSNT_LEAK3_SENSOR_R_PLD_N","",
> > +     "wPRSNT_LEAK2_SENSOR_R_PLD_N","",
> > +     "wPRSNT_LEAK1_SENSOR_R_PLD_N","",
> > +     "wPRSNT_LEAK0_SENSOR_R_PLD_N","",
> > +     /*P0 - P7*/
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","",
> > +     "","";
> > +};
> >
> >
>
> *snip*
>
> > +
> > +&i2c6 {
> > +     status =3D "okay";
> > +
> > +     eeprom@50 {
> > +             compatible =3D "atmel,24c64";
> > +             reg =3D <0x50>;
> > +     };
> > +
> > +     io_expander0: gpio@20 {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x20>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +     };
> > +
> > +     io_expander1: gpio@21 {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x21>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +     };
> > +
> > +     io_expander2: gpio@22 {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x22>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +     };
> > +
> > +     io_expander7: gpio@23 {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x23>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +     };
> > +
> > +     rtc@51 {
> > +             compatible =3D "nxp,pcf8563";
> > +             reg =3D <0x51>;
> > +     };
> > +};
> > +
>
> *snip*
>
> > +
> > +&io_expander0 {
>
> io_expander0 is a label you've defined in this same dts, just above.
> Please just include the properties in the original node directly, don't
> separate them like this.
>
> Same applies to all other cases of the same pattern.
Thanks for review, I will put the properties to the same node.
>
> Andrew
>
> > +     gpio-line-names =3D
> > +     "RST_POE_BMC_N", "POE_DISABLE_BMC_N_R",
> > +     "RST_FT4232_1_BMC_N_R", "RST_FT4232_2_BMC_N_R",
> > +     "RST_FT4232_3_BMC_N_R", "PRSNT_FANBP_0_PWR_N",
> > +     "PRSNT_FANBP_0_SIG_N", "PRSNT_POE_PWR_N",
> > +     "PRSNT_POE_SIG_N", "IRQ_POE_BMC_N_R",
> > +     "PWRGD_P3V3_ISO_POE_BMC_R", "88E6393X_INT_N_R",
> > +     "P48V_HSC_ALERT_N", "SMB_TMC75_TEMP_ALERT_N_R",
> > +     "DEV_DIS_N", "PCI_DIS_N";
> > +};
> > +

