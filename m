Return-Path: <linux-aspeed+bounces-3644-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07196FD0650
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Mar 2026 08:05:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW3GP2Nnlz3cyZ;
	Wed, 11 Mar 2026 19:05:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f2b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773216349;
	cv=pass; b=lWPq550412NPtTNmm6aA9lqtn2BsFBm+marQsk5RhU0MNrLVhDB5LdHN2WimbEkyU0wewEWvZLSpSn+Tq8lu+XawnoEc/hPNC0qPx/Y094EStsaFiIEQ0du8NIlIrMiFimdSPwhgUMMbn9dO8dI7uVrOE+nBUso1AAMCM/sYT2ZPt3fogx/9n39vzj9uwYZ/honJHjmZN8o3APDpyTZVra+cCAlz35R8w8zqqyCztRssZuPsZWiFfnsKN5vLvFLkNqrP5U0edx48UeqULQtJkD13c8y0yNZMEr7R417eX4bEBlzjss630nnVk/jYBWiYpBRdWxiLMBbALdspwNhJnA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773216349; c=relaxed/relaxed;
	bh=AYKrCeV+MhTQzAkldGnfBMc/qasi6YGvmmlBuzZRAqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpmveCBH/k85knhxxIrH5L6wiWo8PYaXvtLI1NbNz2lt0oXwcQeRmyCjVhpp8k+6i+Sv88AbjOMl9Q1ky4X7vyYZUlm2BEXERulQjitXgvtGpK7VnzUMbG0cLrTN5sAPMDcYiha2HgaQ6dXyjETDeJcSdzt4V42Ve/w7ftBAq67AAuA5Q6FCksFA4iKxNB3l3SgbAHXqHvubV94ugCLO98p2EwUclRVjdzqYuFEO58R3QN10xBAhDrrOTFhC5AnV/LkyByM2vjKTclC3xKF3Qn7n3iDaCQGz3AA81wYgKI4HyyqAADBFzfZzOlNSBasltGuKB/96LOfkiBcLSbmwbA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nUs0EW9y; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nUs0EW9y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW3GM4DC6z3cfv
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Mar 2026 19:05:47 +1100 (AEDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-899a5db525cso129349876d6.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Mar 2026 01:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773216345; cv=none;
        d=google.com; s=arc-20240605;
        b=PbS91j0ndFBNxBAjkP0/aUfj/gixH5Lej5PyVheAII+l5KKiApO4YIIo2TlDPy/7zU
         eE4jKvkid2lGepjAiVSV/74aLPTawg2YqhZnWbxQW1qft+PGE0ZxXDZReV419r643ApT
         n0Mi/OSkYLIgY+AJoS3olwcCHAz/vGB7bVU+G4zxboRAXgKTVhHTJNo/Y5QJChjKYXsw
         5iZec7bZ/6tWeWC9ti4DgTVgBOQkQDfE4ab97FbIOTX1mqvS2zjz7SgWIIMgtutyFS1V
         eJFdUsMULTnFaekxWxACddiqECbMF5M2VXQooly7nc8WIXAh3+Kr+Q0tiLaJa+ArNXJA
         8CpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AYKrCeV+MhTQzAkldGnfBMc/qasi6YGvmmlBuzZRAqM=;
        fh=VzEbUJjw5AQ9E9HamX0FcGo0J8L/3MO45aSbHFiaaFw=;
        b=gO6ggEOeYtcUFyY0hVcUkY9h1XjEow7vZjk6fwFghC49II6S6Nd7/iSIeG6mayvEKy
         /eYZ1lyM5weaswx9zPZsVTivR3N/+M7bUdkPUPQbcBFUacAE775vVCv3XFYmUMZBOJUo
         rCwpC4Pf0TuqOkH6EHbrDk/86U25LL7ovFGr+p+Qvg+A8gL0T8T3bJx3HBF5ieCX87o3
         9vZlzPJf0aEBc7A8aDPTMAKcHq4JDqaWE4tguvqpQtRa1NJwhD0ovPsSARc2SjzkXw/s
         WtI/QEruuUsDajEjAb0Jo1SL24P0gcWHiBOgnSck3j/YzZKVa+Unpe9hWnqT2Nlwz8W3
         ZkZw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773216345; x=1773821145; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYKrCeV+MhTQzAkldGnfBMc/qasi6YGvmmlBuzZRAqM=;
        b=nUs0EW9y1pqI9Wz5d+t1rmvHs88vFV+fmf85ZzmtXOryMCJ1UPIep5aZojwdxFCHyA
         w6FZqV+wB4jmB+KxyvcIi6O6KfDXKi9vaENg9YqJ/OwK7839MgCrLzzeuTmiktrS8vl2
         ASb+utSh+JTjJJD0fwMZkF/SrZ+6/K3x/QSyxHhouHl9Vx7jCGC6OoXviT9Tqh6m0raS
         FttB2oCy7b/0cDNXU8Dksd0h5+W6Jui0tdd/lhRMhzXXMouemriBSl9PY72/sv9wZvZU
         hAIxqlgTU/dEfEgwTs/Z4dSO2BzJruah1FMDbCpFsPaGeharZjXQthMiGKxYapZkL8tt
         J/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773216345; x=1773821145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYKrCeV+MhTQzAkldGnfBMc/qasi6YGvmmlBuzZRAqM=;
        b=DQcRY5RG5EFHgnSfze9TVkao+U0U3COecG4E18ljCdFm/syqW1J/1rFe9tQeGMS9hA
         HCritWqlE5zNPJMSeY3ihXzV/61BCVlXU7YPa7c6NXKe60Zp/eq+BGkvu/WLSJwW6aUY
         umoElvwnzyY90VwaZu4zfGhT9jyIo3Op358vCQoUyytIO71HHpsudJiKNrUTuhfRbJV5
         mXpx+cmFmbktQF6qBmJiyZ6SB70FUK8qqhpcvWWB1qVJvvTeM1SqL3cnAFvfPmrKvkFQ
         QzoN+D9xnwIljeGB5gV8l3WXL9/zADPMwe6JveyhiuRUs4h88DVCjblRVU7C+DpoGFUL
         +yhw==
X-Forwarded-Encrypted: i=1; AJvYcCVhwxbMo1LxJHHrOFkFwO4VCL4pYV8EhXGdvZuIjFMWfz/A7dofbRevt9lcdJKSLtuTArU49BYiur6x0gU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwpkDfN6U3/Ry17fjPvBtrOutJ98upAlk6PSo9LfFQHm6ATwLyA
	a9Ux5U1f0Tq3q7jrSrbJUN1H7wV6KMxO4vYFON2SM0LmFC0vx9kliQIE98kWwy4cG4QCeC2WKbi
	EKDy+xl+9SM+HWg5ahrJoDw13F65+mso=
X-Gm-Gg: ATEYQzzWyjgeMvEYYDJBlI4S4Z7K1QhompQD1XgMOTIVHbRA5jtBTY6hThhE2czx/Tr
	uGrBjV7W9sNyX3kDWrktsgpj7Ju4c9YsxuxeF290eOp2KZufHkZlm6agW+jD1hmcuZBtGE3d+IT
	quNFeTccY8W1hSkKhEcgM3GGWWQb1WFUWmy+KODPyjj4vDbCZHWZhi4aOuTFJT8Rw7+wqJxG93L
	Bz7sZJEfJePu8XN68aPnV8QsAAOgP8kvWl3zn/+TVyF4FdVRgxL9jlUiZah3/qEvJ1Ibhn9ekhO
	AUqa8n6O
X-Received: by 2002:a05:6214:c44:b0:899:f5a4:8110 with SMTP id
 6a1803df08f44-89a66ad1f80mr18466396d6.56.1773216344645; Wed, 11 Mar 2026
 01:05:44 -0700 (PDT)
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
References: <20260202-sanmiguel_init_dts-v1-0-c0023ae41899@gmail.com>
 <20260202-sanmiguel_init_dts-v1-2-c0023ae41899@gmail.com> <d7c03808b09b4cb3994a9de2eff156ec589ab581.camel@codeconstruct.com.au>
In-Reply-To: <d7c03808b09b4cb3994a9de2eff156ec589ab581.camel@codeconstruct.com.au>
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 11 Mar 2026 16:05:33 +0800
X-Gm-Features: AaiRm52tmf-PMV2NqwBvW-Vb0NrLbQv85M7D1YR9rJ6D6ErXgN13_VbO5sEQOD0
Message-ID: <CAGfYmwVdUJLUhjgyPUcOw2eTRxndba4Czb7rdw10cABBN2GRuQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add Meta SanMiguel BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>, 
	Mike Hsieh <Mike_Hsieh@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
	Roger Kan <Roger.Kan@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 2:40=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Potin,
>
> Regarding the patch subject, can you please capitalise the start of the
> description after '... aspeed:'?
>
>    ARM: dts: aspeed: Add Meta SanMiguel BMC
>
Hi Andrew,

Thank you for reminding.
Updated in v3.

> On Mon, 2026-02-02 at 14:03 +0800, Potin Lai wrote:
> > Add linux device tree entry for Meta (Facebook) SanMiguel compute-tray
> > BMC using AT2620 SoC.
> >
> > Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed/Makefile                  |    1 +
> >  .../dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts   | 1163 ++++++++++++=
++++++++
> >  2 files changed, 1164 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspe=
ed/Makefile
> > index 9adf9278dc94..ab2effc29f6f 100644
> > --- a/arch/arm/boot/dts/aspeed/Makefile
> > +++ b/arch/arm/boot/dts/aspeed/Makefile
> > @@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> >       aspeed-bmc-facebook-harma.dtb \
> >       aspeed-bmc-facebook-minerva.dtb \
> >       aspeed-bmc-facebook-minipack.dtb \
> > +     aspeed-bmc-facebook-sanmiguel.dtb \
> >       aspeed-bmc-facebook-santabarbara.dtb \
> >       aspeed-bmc-facebook-tiogapass.dtb \
> >       aspeed-bmc-facebook-wedge40.dtb \
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts=
 b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
> > new file mode 100644
> > index 000000000000..bcf857835b23
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
> > @@ -0,0 +1,1163 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +// Copyright (c) 2025 Facebook Inc.
> > +
> > +/dts-v1/;
> > +#include "aspeed-g6.dtsi"
> > +#include <dt-bindings/gpio/aspeed-gpio.h>
> > +#include <dt-bindings/usb/pd.h>
> > +#include <dt-bindings/leds/leds-pca955x.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/i2c/i2c.h>
> > +#include <dt-bindings/leds/common.h>
> > +
> > +/ {
> > +     model =3D "AST2600 VR NVL144 BMC";
> > +     compatible =3D "aspeed,ast2600";
>
> This is missing the platform compatible string defined in the previous
> patch.
>
Updated in v3.

> > +
> > +     aliases {
> > +             serial0 =3D &uart1;
> > +             serial1 =3D &uart2;
> > +             serial2 =3D &uart3;
> > +             serial3 =3D &uart4;
> > +             serial4 =3D &uart5;
> > +             i2c16   =3D &imux16;
> > +             i2c17   =3D &imux17;
> > +             i2c18   =3D &imux18;
> > +             i2c19   =3D &imux19;
> > +             i2c20   =3D &i2c20;
> > +             i2c21   =3D &i2c21;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial4:57600n8";
> > +     };
> > +
> > +     memory@80000000 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x80000000 0x80000000>;
> > +     };
> > +
> > +     iio-hwmon {
> > +             compatible =3D "iio-hwmon";
> > +             io-channels =3D <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3=
>,
> > +                           <&adc0 4>, <&adc0 5>, <&adc0 6>;
> > +     };
> > +
> > +     spi2_gpio: spi {
> > +             compatible =3D "spi-gpio";
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             sck-gpios =3D <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>=
;
> > +             mosi-gpios =3D <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH=
>;
> > +             miso-gpios =3D <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH=
>;
> > +             cs-gpios =3D <&gpio0 ASPEED_GPIO(X, 2) GPIO_ACTIVE_LOW>;
> > +             num-chipselects =3D <1>;
> > +
> > +             tpm@0 {
> > +                     compatible =3D "infineon,slb9670", "tcg,tpm_tis-s=
pi";
> > +                     spi-max-frequency =3D <33000000>;
> > +                     reg =3D <0>;
> > +             };
> > +     };
> > +
> > +     standby_power_regulator: standby-power-regulator {
> > +             status =3D "okay";
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "standby_power";
> > +             gpio =3D <&gpio0 ASPEED_GPIO(M, 3) GPIO_ACTIVE_HIGH>;
> > +             regulator-min-microvolt =3D <1800000>;
> > +             regulator-max-microvolt =3D <1800000>;
> > +             enable-active-high;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +     };
> > +
> > +     scm-leds {
> > +             compatible =3D "gpio-leds";
> > +             led-0 {
> > +                     label =3D "bmc_heartbeat_amber";
> > +                     gpios =3D <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_L=
OW>;
> > +                     linux,default-trigger =3D "heartbeat";
> > +             };
> > +     };
> > +
> > +     fio-leds {
> > +             compatible =3D "gpio-leds";
> > +             led-0 {
> > +                     label =3D "power_blue";
> > +                     gpios =3D <&fio_ioexp 4 GPIO_ACTIVE_HIGH>;
> > +             };
> > +             led-1 {
> > +                     label =3D "power_amber";
> > +                     gpios =3D <&fio_ioexp 5 GPIO_ACTIVE_LOW>;
> > +             };
> > +             led-2 {
> > +                     label =3D "id_blue";
> > +                     gpios =3D <&fio_ioexp 6 GPIO_ACTIVE_HIGH>;
> > +             };
> > +             led-3 {
> > +                     label =3D "id_amber";
> > +                     gpios =3D <&fio_ioexp 7 GPIO_ACTIVE_LOW>;
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
> > +#include "openbmc-flash-layout-128.dtsi"
> > +     };
> > +     flash@1 {
> > +             status =3D "okay";
> > +             m25p,fast-read;
> > +             label =3D "alt-bmc";
>
> Perhaps include the alt layout for 128M as well (which I recently
> applied).
>
This will be added in the next submission (v4).

> > +             spi-max-frequency =3D <50000000>;
> > +     };
> > +};
> > +
> > +&uart1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&uart3 {
> > +     status =3D "okay";
> > +};
> > +
> > +&uart5 {
> > +     status =3D "okay";
> > +};
> > +
> > +&uart_routing {
> > +     status =3D "okay";
> > +};
> > +
> > +&mdio0 {
>
> The DTS coding style allows label references to be ordered
> alphabetically, which is my preference. Can you please fix this
> throughout?
>
Sorry, v3 has not applied with the DTS coding style.
I will update it in the next submission (v4).

> > +     status =3D "okay";
> > +     ethphy0: ethernet-phy@0 {
> > +             compatible =3D "ethernet-phy-ieee802.3-c22";
> > +             reg =3D <0>;
> > +     };
> > +};
> > +
> > +&mac0 {
> > +     status =3D "okay";
> > +     pinctrl-names =3D "default";
> > +     phy-mode =3D "rgmii-rxid";
> > +     max-speed =3D <1000>;
> > +     phy-handle =3D <&ethphy0>;
> > +     pinctrl-0 =3D <&pinctrl_rgmii1_default>;
> > +};
> > +
> > +&ehci1 {
> > +     status =3D "okay";
> > +     hub@1 {
> > +             reg =3D <1>;
> > +             hub@2 {
> > +                     reg =3D <2>;
> > +                     hub@1 {
> > +                             reg =3D <1>;
> > +                             device@1 {
> > +                                     reg =3D <1>;
> > +                                     cp2112a: interface@1 {
> > +                                             reg =3D <1 1>;
> > +
> > +                                             gpio-controller;
> > +                                             interrupt-controller;
> > +                                             #gpio-cells =3D <2>;
> > +                                             #interrupt-cells =3D <2>;
> > +
> > +                                             i2c20: i2c {
> > +                                                     #address-cells =
=3D <1>;
> > +                                                     #size-cells =3D <=
0>;
> > +                                             };
> > +                                     };
> > +                             };
> > +                             hub@3 {
> > +                                     reg =3D <3>;
> > +                                     cp2112c: device@2 {
> > +                                             reg =3D <2>;
> > +                                             gpio-controller;
> > +                                             #gpio-cells =3D <2>;
> > +                                             interrupt-controller;
> > +                                             #interrupt-cells =3D <2>;
> > +
> > +                                             gpio-line-names =3D
> > +                                                     "IOB0_MCP_P0_2-B"=
,
> > +                                                     "IOB0_MCU_RST_L-O=
",
> > +                                                     "IOB0_MCU_RECOVER=
Y_L-O",
> > +                                                     "IOB0_GLOBAL_WP-O=
",
> > +                                                     "IOB0_GLOBAL_ADDR=
_L_R-O",
> > +                                                     "IOB0_GLOBAL_ADDR=
_U_D-O",
> > +                                                     "IOB0_PWR_EN-O",
> > +                                                     "IOB0_MCU_READY_S=
TATUS-I";
> > +                                     };
> > +                             };
> > +                             hub@4 {
> > +                                     reg =3D <4>;
> > +                                     cp2112d: device@2 {
> > +                                             reg =3D <2>;
> > +                                             gpio-controller;
> > +                                             #gpio-cells =3D <2>;
> > +                                             interrupt-controller;
> > +                                             #interrupt-cells =3D <2>;
> > +
> > +                                             gpio-line-names =3D
> > +                                                     "IOB1_MCP_P0_2-B"=
,
> > +                                                     "IOB1_MCU_RST_L-O=
",
> > +                                                     "IOB1_MCU_RECOVER=
Y_L-O",
> > +                                                     "IOB1_GLOBAL_WP-O=
",
> > +                                                     "IOB1_GLOBAL_ADDR=
_L_R-O",
> > +                                                     "IOB1_GLOBAL_ADDR=
_U_D-O",
> > +                                                     "IOB1_PWR_EN-O",
> > +                                                     "IOB1_MCU_READY_S=
TATUS-I";
> > +                                     };
> > +                             };
> > +                     };
> > +                     hub@2 {
> > +                             reg =3D <2>;
> > +                             device@1 {
> > +                                     reg =3D <1>;
> > +                                     cp2112b: interface@1 {
> > +                                             reg =3D <1 1>;
> > +
> > +                                             gpio-controller;
> > +                                             interrupt-controller;
> > +                                             #gpio-cells =3D <2>;
> > +                                             #interrupt-cells =3D <2>;
> > +
> > +                                             i2c21: i2c {
> > +                                                     #address-cells =
=3D <1>;
> > +                                                     #size-cells =3D <=
0>;
> > +                                             };
> > +                                     };
> > +                             };
> > +                             hub@3 {
> > +                                     reg =3D <3>;
> > +                                     cp2112e: device@2 {
> > +                                             reg =3D <2>;
> > +                                             gpio-controller;
> > +                                             #gpio-cells =3D <2>;
> > +                                             interrupt-controller;
> > +                                             #interrupt-cells =3D <2>;
> > +
> > +                                             gpio-line-names =3D
> > +                                                     "IOB2_MCP_P0_2-B"=
,
> > +                                                     "IOB2_MCU_RST_L-O=
",
> > +                                                     "IOB2_MCU_RECOVER=
Y_L-O",
> > +                                                     "IOB2_GLOBAL_WP-O=
",
> > +                                                     "IOB2_GLOBAL_ADDR=
_L_R-O",
> > +                                                     "IOB2_GLOBAL_ADDR=
_U_D-O",
> > +                                                     "IOB2_PWR_EN-O",
> > +                                                     "IOB2_MCU_READY_S=
TATUS-I";
> > +                                     };
> > +                             };
> > +                             hub@4 {
> > +                                     reg =3D <4>;
> > +                                     cp2112f: device@2 {
> > +                                             reg =3D <2>;
> > +                                             gpio-controller;
> > +                                             #gpio-cells =3D <2>;
> > +                                             interrupt-controller;
> > +                                             #interrupt-cells =3D <2>;
> > +
> > +                                             gpio-line-names =3D
> > +                                                     "IOB3_MCP_P0_2-B"=
,
> > +                                                     "IOB3_MCU_RST_L-O=
",
> > +                                                     "IOB3_MCU_RECOVER=
Y_L-O",
> > +                                                     "IOB3_GLOBAL_WP-O=
",
> > +                                                     "IOB3_GLOBAL_ADDR=
_L_R-O",
> > +                                                     "IOB3_GLOBAL_ADDR=
_U_D-O",
> > +                                                     "IOB3_PWR_EN-O",
> > +                                                     "IOB3_MCU_READY_S=
TATUS-I";
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&adc0 {
> > +     aspeed,int-vref-microvolt =3D <2500000>;
> > +     status =3D "okay";
> > +
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_adc0_default &pinctrl_adc1_default
> > +             &pinctrl_adc2_default &pinctrl_adc3_default
> > +             &pinctrl_adc4_default &pinctrl_adc5_default
> > +             &pinctrl_adc6_default>;
> > +};
> > +
> > +&wdt1 {
> > +     status =3D "okay";
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_wdtrst1_default>;
> > +     aspeed,reset-type =3D "soc";
> > +     aspeed,external-signal;
> > +     aspeed,ext-push-pull;
> > +     aspeed,ext-active-high;
> > +     aspeed,ext-pulse-duration =3D <256>;
> > +};
> > +
> > +&i2c0 {
> > +     status =3D "okay";
> > +     aspeed,enable-byte;
> >
>
> ... Have you run `make dtbs_check`? A quick grep suggests this isn't a
> valid property.
>
I think v3 has fixed most of the failures in this DTS file.
The remaining failures originate from other included DTSI files.

> > +
> > +     ssif-bmc@10 {
> > +             compatible =3D "ssif-bmc";
> > +             reg =3D <0x10>;
> > +             alert-gpios =3D <&gpio1 ASPEED_GPIO(D, 7) GPIO_ACTIVE_LOW=
>;
> > +             timeout-ms =3D <5000>;
> > +     };
> > +};
> > +
> > +&i2c1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c2 {
> > +     status =3D "okay";
> > +
> > +     hpm0_ioexp_20: gpio@20 {
> > +             compatible =3D "nxp,pca9555";
>
> Is this a true nxp,pca9555, or a CPLD-based reimplementation? Same
> query for other instances...
>
There are physical IO expander chips on the module, not CPLD-based.

> Andrew

Potin

