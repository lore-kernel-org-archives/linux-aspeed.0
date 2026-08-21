Return-Path: <linux-aspeed+bounces-4765-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D559C5DF8E
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 06:28:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hR9P717B1z2xnW;
	Fri, 21 Aug 2026 16:28:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::135" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787293723;
	cv=pass; b=MWHLqL/jXRCngzQF51FTYiPKu4W/+dcSO5wVnZkRSrb0ojbm/jTUbwlZIbsULV7dGyFRPVy+AYBj8q3OZNijMJbj0fqdSGNJq4SCuxZhi8qIHHRL6HPzJJoFDgIqmCKmeUeg7+rw4nNiN3zYiglxirzZpwzW/3qjMtcSNm9lWUHMozzTvcbFRvCrPtkhnlrXWSYNA0nHAc+8JFuQk9L5aSDwkGA4PXfk8xTwIpOefIXwybE0iJSERwKQmNIW6fiM8eIa/P5x5H3SQjQVwg+XF0TrWI8+N/5FpbimBbSa5hVu+nz9n2TF33BykWxufyUtXcFcMbtEteEvZiY+dsCmIg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787293723; c=relaxed/relaxed;
	bh=+B9pQd9t0eZEYhD64ciNA4BU0alMXlOocEuezOHCIMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ajuaank6GKxnHTM02gfG4oMgVLj1ZFWkEGA2ecFE9kmZOaEGaQy+esA0rTsjLSQ4gpzWRInMSx4+jyKttB6zF+xolXlhEXV5LT8zJNaOrJsc/HPCd0V5ZpH7chTyuCaxetgR3Nog+TDoaDzJ6I4aHCv9agKvbH0VAjMfhmcmyazFS5UbZz9HQJJSB6y+gbBwG4UNj2PiFj5Ws/AqmN6OGQUMd3AgSZx0ZfiWHBZ2YTCtE7YXQ3LQAIZWBoE6Lc4zzW0m6OQJqPogk+NltBmY3yW5QrHi8crqn2v1pmAicCLoX7t7o3IAmoaCMnfm/snlO+sn6CeJ0SolhpxXLDpjOA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fQF7Z62j; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fQF7Z62j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hR9P60Z9kz2xWt
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Aug 2026 16:28:41 +1000 (AEST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5aec6360133so519312e87.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Aug 2026 23:28:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787293718; cv=none;
        d=google.com; s=arc-20260327;
        b=HU3Y+irQF3Jh+cPvq+ZA7FqFtEnxMTX0BP/EVlWw06vBTATHKdxDJ/Egs8sAdqMawB
         qoN7rDAbHU0u/oBdA2Blgs+NUwscC5j09pcNQtJJg0wCvIBtEO+TMlOqeTIBvn7o+I2G
         is0eqZet+KP6ki51+91uGlUIcxrQs05grtHoEttZCIpzIjLcftLgR+QgA3hAx/HxuBPF
         IVc1yQtRLh7P7jeHu7wcKZUJJD0GesZuyww2RDlYCNiyC23UoxscO7UYmvXquuYKZNHk
         WBT5IoS3gASN2cunuhcqDA/d3YGsrsDAwJ0jybCzGnSPoN5TMp4v5RPVB/IKtvNY9rse
         Z3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+B9pQd9t0eZEYhD64ciNA4BU0alMXlOocEuezOHCIMY=;
        fh=JdP2A+vxmslacAxFv5hIfiNN348WnOThyni6UuMyFls=;
        b=NOsaRwRjw191zkLDRnL5l3KMH8WtbH9b7QAJjEV2LEOmYJzXUZjimaOxyxN9TO6res
         2mMKP2nYk85wLpWTeQLXqrCq+gbSkAQUu9IDrB/oqYFNtMwvrUYLvWd5tR+8Gg4tmbtV
         +pL2fHXoTA5g2NyTN2sLQCZiyGx6lQPaid8F8tziZUpN773D+bAlV+vdepBpYtrN9ZAs
         MqPxGLMCqKFIHfFNQxktKDdjVkALDdYQpgXnHZq+aoWryk7ILRV0JZV9KhtlF9EvN3pn
         /DgHGYjEsFM9rcFLqnOabZYVnPq4PmAclFe6C5hO7V8YnsY9fUqhKjRXqMOH6Q3ux1rx
         h+7g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787293718; x=1787898518; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+B9pQd9t0eZEYhD64ciNA4BU0alMXlOocEuezOHCIMY=;
        b=fQF7Z62jsqronfTpqXDUa5Qc8ekzEfEnqnop0x9lW5GFp5VLhR86rswL64hbtDFvwj
         TeaqGKE7UBvDzMJaHHGfRP1aIPpUsNRydKf9kcaL2N2ZR8HwbmMrtmZSliHQSHRnJofc
         ceMhNrGM1meEEqgZSe37eLTx0WTC5Jz/Y9x8oAyy9b/2Nhrub4vye3FBVlo2pTbmGU9O
         5s+2Qq60k95GnK7KQCMuBBdbFXP8XvHLTIB91drBCQ6RwcODeHi0+qxYEc5HzGgM1/+w
         Qe8kzvBHjKH5M9MUE+1ub9eSuSszrRRr3XjiVPlaOYC6Txp5rHKgsz4/1gF9B/fc0Ymv
         uhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787293718; x=1787898518;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+B9pQd9t0eZEYhD64ciNA4BU0alMXlOocEuezOHCIMY=;
        b=qQl0ND1tXnihlK7rmVv0PlkSwmbxzfG5QWn6qckEiOh61mjpjG0s+qkx+bdz0mZ8I7
         egmBbNMFXjpqx2elm7bPfy9K9nxdukoJTaI4Bbt066U3IASu1V4Cgt4qDw+OlAGdIwBf
         R5fl1OFLXJzLACzaMAwDttEQN+pINyTakcXTJJG5WO7qN9sNnI+nX/QazQxeLIChXdEY
         evOlJecqLjvlRPopdERUf9Si5IIXzbJkIuHn12M9p89IzRM97XPqO/Ocl2oh9nUZGdiy
         6xXsVEG227qw6OQ/CsdyStynp6SSKDoVQNZAiwk6ViRxtVpCAI28uJ0lmTLyqeV2YyDa
         Rfzg==
X-Forwarded-Encrypted: i=1; AHgh+RpmsBAxj5no0nT0g1d6NZqCQiWCiGAktVYlFfkIrT3hRz+JtAPcQWE/EyqjlWilafOx5wO3QN/Guvp+qO0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kdLwEAndGRob84NkQ/NoytMzRtiNwCTvJUDpIrravYXGQ0dNKG
	toDG6MxZ2WwBG6GdH410Y3rX4twaK+C09lpPrOW4IKcNK+D2e59s9fL3hLHF1iivNZ+YS2esC2u
	OP7sIIMHqREIGntEfBqswG8RLWeFt7nY=
X-Gm-Gg: AR+sD12kisLWMaO6P2svB4q5UKSxFb6LqTTwLqoujAlas7SlQBYSDfJKra1Jnu8Z4do
	03SLHZbQPswLlx2pZ/GgcVGKgYROgl86UY5RkpQzGnFanY06p++r2c7eORxoXw8l6L+T7AUvlrX
	9OI5OW5d96wLWBBdIIyJIX3g4DlyocRc6j+C4rqu1k4VC7+5Oje+4mGCZTzckP3tZTbnr+X3KW+
	ha3IZuWiudK+TewLvCUDga12X+6//74KrjoZUsbEwKS1CEnE6g16I4JL+CopBtKmvnxYsiscojK
	9MWGCcomFFCY3Nvuxo8rCtb3Th55A0tCih8bwDJBlI2dcA==
X-Received: by 2002:a05:6512:3da0:b0:5ae:bcc4:c071 with SMTP id
 2adb3069b0e04-5b484090f50mr1322562e87.0.1787293717922; Thu, 20 Aug 2026
 23:28:37 -0700 (PDT)
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
References: <20260727-ventura2_initial_dts-v9-0-504c0ec68039@gmail.com>
 <20260727-ventura2_initial_dts-v9-2-504c0ec68039@gmail.com> <178724902712.20555.7009712214570349708.b4-review@b4>
In-Reply-To: <178724902712.20555.7009712214570349708.b4-review@b4>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Fri, 21 Aug 2026 14:31:41 +0800
X-Gm-Features: AcwNN1VHyDF2m_8gVrWdQPyCUbVvLps1cRKmYDiyS5eZ7IMCo5hpISGq-5CfFl0
Message-ID: <CAF7HswN1ZzwjfXjG2hV5tEkVZkZYp0CiVNSo_9A4m3tsqQp_Bg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
To: Tan Siewert <tan.siewert@9elements.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tan,

Thanks for the review.

On Fri, Aug 21, 2026 at 2:04=E2=80=AFAM Tan Siewert <tan.siewert@9elements.=
com> wrote:
>
> Hi Kyle,
>
> > Ventura2 is a Rack Management Controller. It is a modular
> > device designed to manage liquid cooling systems and monitor hardware
> > states within an IT rack. The system uses an AST2600 BMC for management=
.
> >
> > RMCv2 serves several critical roles:
> > - Detects liquid leakage at both tray and rack levels.
> > - Communicates with and controls liquid cooling equipment.
> > - Manages leakage events and executes system recovery protocols.
> >
> > Key hardware features include:
> > - An extensive I2C and IO expander topology to support comprehensive
> >   sensor monitoring and backward compatibility with legacy trays.
> > - MCTP over I2C support for asynchronous device communications.
> > - A dual-flash design for BMC firmware redundancy.
> >
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
>
> *snip*
>
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts =
b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> > new file mode 100644
> > index 000000000000..f1273ca31bf8
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> > @@ -0,0 +1,3005 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2023 Facebook Inc.
> > +/dts-v1/;
> > +
> > +#include "aspeed-g6.dtsi"
> > +#include <dt-bindings/i2c/i2c.h>
> > +#include <dt-bindings/gpio/aspeed-gpio.h>
> > +
> > +/ {
> > +     compatible =3D "facebook,ventura2-rmc", "aspeed,ast2600";
> > +     model =3D "Facebook Ventura2 RMC";
> > +
> > +     aliases {
> > +             /*
> > +             * Pre-allocate I2C bus aliases for userspace predictabili=
ty.
> > +             * Several I2C channels are intentionally left empty in th=
is
> > +             * DTS as they are strictly reserved for future hardware
> > +             * feature expansions and add-on boards that will interfac=
e
> > +             * with these busses.
> > +             */
> > +             /*
> > +             * i2c switch 0-0077, pca9548, 8 child channels assigned
> > +             * with bus number 16-23.
> > +             */
>
> This alignment is one of the things that seem to be a false-positive for
> dt-check-style in strict mode (value-whitespace). See [0] where Krzysztof=
 said
> that it may report false-positives, and "Review and investigate warnings =
from
> 'strict' mode, but do not fix them automatically without thinking".
>
> @Krzysztof wdyt about this one?

You're right, and this is a regression I introduced in v9. In v8 these comm=
ent
blocks used the standard kernel style. While running dt-check-style, I appl=
ied
the strict-mode output too mechanically and dropped the space before '*' in=
 all
38 comment blocks in the file. I will restore to the standard style in v10.

>
> > +             i2c16 =3D &i2c0mux0ch0;
> > +             i2c17 =3D &i2c0mux0ch1;
> > +             i2c18 =3D &i2c0mux0ch2;
> > +             i2c19 =3D &i2c0mux0ch3;
> > +             i2c20 =3D &i2c0mux0ch4;
> > +             i2c21 =3D &i2c0mux0ch5;
> > +             i2c22 =3D &i2c0mux0ch6;
> > +             i2c23 =3D &i2c0mux0ch7;
>
> *snip*
>
> > +     spi {
> > +             compatible =3D "spi-gpio";
> > +             #address-cells =3D <1>;
> > +             cs-gpios =3D <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
> > +             miso-gpios =3D <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH=
>;
> > +             mosi-gpios =3D <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH=
>;
> > +             num-chipselects =3D <1>;
> > +             sck-gpios =3D <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>=
;
> > +             #size-cells =3D <0>;
>
> Shouldn't #address-cells and #size-cells be ordered together? If reported=
 by
> dt-check-style as issue, then it might be a false-positive.

I will put the two properties back together in v10. Like the comment
alignment above, I'll list this as a strict-mode warning I'm not acting on.

>
> > +
> > +             tpm@0 {
> > +                     compatible =3D "infineon,slb9670", "tcg,tpm_tis-s=
pi";
> > +                     reg =3D <0>;
> > +                     spi-max-frequency =3D <33000000>;
> > +             };
> > +     };
> > +};
> > +
> > +&adc0 {
> > +     pinctrl-0 =3D
> > +             <&pinctrl_adc0_default &pinctrl_adc1_default
> > +             &pinctrl_adc2_default &pinctrl_adc3_default
> > +             &pinctrl_adc4_default &pinctrl_adc5_default
> > +             &pinctrl_adc6_default &pinctrl_adc7_default>;
> > +     pinctrl-names =3D "default";
> > +     vref-supply =3D <&p1v8_bmc_aux>;
> > +
> > +     status =3D "okay";
> > +};
> > +
> > +&adc1 {
> > +     pinctrl-0 =3D <&pinctrl_adc8_default &pinctrl_adc10_default>;
> > +     pinctrl-names =3D "default";
> > +     vref-supply =3D <&p2v5_bmc_aux>;
> > +
> > +     status =3D "okay";
> > +};
> > +
> > +&ehci0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&ehci1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&fmc {
> > +     status =3D "okay";
> > +
> > +     flash@0 {
> > +             label =3D "bmc";
> > +             spi-max-frequency =3D <50000000>;
> > +             m25p,fast-read;
> > +
> > +             status =3D "okay";
> > +             #include "openbmc-flash-layout-128.dtsi"
> > +     };
> > +
> > +     flash@1 {
> > +             label =3D "alt-bmc";
> > +             spi-max-frequency =3D <50000000>;
> > +             m25p,fast-read;
> > +
> > +             status =3D "okay";
>
> Missing '#include "openbmc-flash-layout-128-alt.dtsi"'?

I will add it in v10.

>
> > +     };
> > +};
>
> *snip*
>
> > +&mac2 {
> > +     phy-mode =3D "rmii";
> > +     pinctrl-0 =3D <&pinctrl_rmii3_default>;
> > +     pinctrl-names =3D "default";
> > +
> > +     status =3D "okay";
> > +
> > +     /*
> > +     * The Marvell 88E6393X is initialized at boot via EEPROM
> > +     * configuration and hardware straps.
> > +     * The BMC connects via an RMII fixed-link; link parameters are fi=
xed
> > +     * by board design.
> > +     */
>
> This kind of writing gives me the suspicion that it was written with assi=
stance
> by an LLM, but I might be wrong.
>
> Either way, if you have used AI assistance for your series (or only for t=
his
> patch), even if you have only used it for the commit message, then you mu=
st
> declare it via the "Assisted-by" trailer [1][2].

You're right; I used an AI assistant to write this comment. I'll add the
Assisted-by trailer in v10.

>
> > +     fixed-link {
> > +             full-duplex;
> > +             speed =3D <100>;
> > +     };
> > +};
> > +
> > +&mac3 {
> > +     pinctrl-0 =3D <&pinctrl_rmii4_default>;
> > +     pinctrl-names =3D "default";
> > +     use-ncsi;
> > +
> > +     status =3D "okay";
> > +};
> > +
> > +&peci0 {
> > +     status =3D "okay";
> > +};
>
> You mentioned that this is a rack management controller. Does it really r=
equire
> PECI?

It does. Ventura2 can be populated with a COM Express module, and &peci0,
&kcs3 and &lpc_ctrl describe that path, so I'd like to keep them. I will ad=
d
a comment in v10 explaining this, so it's clear from the DTS itself.

For the record, the v5 changelog claimed &peci0 had been removed. That was
incorrect; the node was never actually dropped. Apologies for the confusion
that may have caused when reading through the series.
>
> > +
> > +&sgpiom0 {
> > +     bus-frequency =3D <100000>;
> > +     gpio-line-names =3D
> > +     /*"input pin","output pin"*/
> > +     /*A0 - A7*/
> > +             "power-chassis-good","FM_PLD_HEARTBEAT_LVC3_R",
> > +             "host0-ready","R_BMC_PTH_RST_BTN_L",
> > +             "CONTROL_VT2_SUPPLY1_CLOSE","FM_MDIO_SW_SEL_PLD",
> > +             "CONTROL_VT2_SUPPLY2_CLOSE","FM_88E6393X_BIN_UPDATE_EN_N"=
,
> > +             "CONTROL_VT2_SUPPLY3_CLOSE","Sequence_TransFR_Alert",
>
> Why's "Sequence_TransFR_Alert" written in camelcase?

An oversight; it should be consistent with the surrounding names. I
will renamed to
"SEQUENCE_TRANSFR_ALERT" in v10.

Thanks again for the thorough review.

Kyle Hsieh

