Return-Path: <linux-aspeed+bounces-5017-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A58C982C1
	for <linux-aspeed@archiver.kernel.org>; Thu, 17 Sep 2026 01:46:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hldrj5dM6z2yYd;
	Thu, 17 Sep 2026 11:46:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:41::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789609573;
	cv=pass; b=gcxRVeE9qKo4HuN91IkLiPko3mVQd3lkcl7uySQkAo5o4ceBIBL84xDViopc6Ejd5CEGPqVmIrUW3Hn81vOmpNYAUeU0IjcLw0TCQfNhcVhg2pCKpWLTfLZVWCqk1GxJfw7mbByJywBipBizQoBmXVGNIwyIHd8KXHQpTJoghmRMEhWavLqTAMLHhsgCwVGJowPwu0ekVKA6df9aaf4cr6Meh7uLk+p7Y5y4fH22zNC0tmIZ36A2F+x9T3pi2ohj4ax9L85l54h6M7Jwh3dcVEM1sgkEoxkJpbrPjajCY9+eDghWNKxhQAnnx1/mexs2YCwTeoMO+TBbfnl59h/fPA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789609573; c=relaxed/relaxed;
	bh=+/oI6OE+gqvIMbXOYDHCCFZTXA+5DVoFDE03BakR8Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwtsNykx2tn9kGoWJOs+6WzXLRVvetvRjCEU8JnID23+v2Qum7JT2b072/fkbsSXjPgB/65SCLZ3BTiELUxq++7eRHGq2SICURYF2Cpnzk4ppb/EgQuvrPs2Hi0DLmVqJWp0a5K0tbNgbU6Bx84/jY/lgJErOV1peuQxsC3eJjnu6wgcgoJsVjfAa7BUVLsmWNj/b1Fy4ih8YM9lhL8b3cA5Kw6MRLdvBQWI6Jk8T9+Jp/rpYhM0ngw+FQuk0xE1cqcU8hOe9KpEbc8K3rzmyQAKgmpjIvfpQ5tz40oqZkjGsOCGRcrfTjj0rNb10VMFb+c1tvulyLWGZGrJgZhYeg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YdCGtKNK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YdCGtKNK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com [IPv6:2607:f8b0:4864:41::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hldrg6VdKz2y2Q
	for <linux-aspeed@lists.ozlabs.org>; Thu, 17 Sep 2026 11:46:10 +1000 (AEST)
Received: by mail-yx2-x10.google.com with SMTP id 956f58d0204a3-66f943b286fso251340d50.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 18:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789609567; cv=none;
        d=google.com; s=arc-20260327;
        b=sjePZNOsS8puxJfjDticNomIjRgtIoYv0ne7KDIj9xF8ICkoYGX0Fw7VUfSHWHIYDc
         Wi/GOTtWPnvlNpz+oy/HIjXc4FA5adc3MSGg6lVPrtOmF2wPoAQwDLY9njVM4Ln3xTFx
         R4EIgL+cHSxWpa0NbCXbZ9RTLIWDc/pFYGPbFKz0eF8SpGcoJJlF2E8ghcYo+/qZqnbl
         fWvGiv7Hv/I98MpV6YHeAoWYp2JJsURw/v+Sng91KiHnih7ZbZKzWWLIK3xKgXRWadI0
         D5CYMfvfnevEtSbXhS0yQiiAjJ4+IR3L6lMasCQIWq3iIPD5XAXLPNERENkvOX0wf73T
         tKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+/oI6OE+gqvIMbXOYDHCCFZTXA+5DVoFDE03BakR8Jk=;
        fh=yXbY4/FOktCIbQiODc6fX6Dp0ItL/waflOFMOtlO53k=;
        b=m4h7eDCMokdG9Uq7zE+t/4R+eNZ2LYzz3OahiCF1U4wNDTUB/0ws+hi/MlAawhmNm8
         Y6SGfEG34OfsHvoTeAIgrW0J/h4NbNKZUtBcd8oLLYQl96xjNOJ+KNn8o3tzSJ3dWRKI
         DAORL0y0dfwQwg35DlXYFNZ2tCz+FsZ7DSX8/pO8yZ6iX4YXaAf1wYHNtNj/UyCAaLIE
         xVRGbC+YuvhSI8QDns8NZzNfj1lBBru/lH0Lb8UHUmlVR+thYy6JuebaxtNNRzIieslZ
         bfUvfBOeZjKH5KUmvhsxlbPQeDerMqo6TKTdx199g/sEvxDbddosqpssAIsss8misP3m
         J+nA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789609567; x=1790214367; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+/oI6OE+gqvIMbXOYDHCCFZTXA+5DVoFDE03BakR8Jk=;
        b=YdCGtKNKNYhb72hAEZdCAZDA0r5vjmFi3oWEqG3EjjopDD/YqjoVGhOJvUfYu7tb3o
         lNwlgoF97jjrm3DBjqROQSanpHw3SmsrGHrhbszPdBzwU6WINht/KQ7Z9tFRUtFRZGky
         oIeCb3POMpwHRqrMaIoJYAFPOfyGngs1WCuePJ8qm1c81yrwCeGc0F6P4we3x0Mp6D2Q
         tVWGnXxY235UqXgs7+A0rz0wJuEMRUN3mA8Tm5+qg3deMz+blIM83hDUIVKd4Yt15+HZ
         ZUMULtTFpo2u4KzpYwHrDfcckHuCXZVUY0WYal+1Fewzew4xf/9fkKJgfsz1y7TOJPht
         5vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789609567; x=1790214367;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/oI6OE+gqvIMbXOYDHCCFZTXA+5DVoFDE03BakR8Jk=;
        b=Ve0C+991NO0ztCyGIK1kv4DbHuIBn5GltLv8P28/qlPxa/Akld2EK1JNogTzSZidE8
         zlGjdgilMDhH2MJuL+7b6MNfIH9vVJSj3+sJyZBhH5Hok7qPwj9xW0oJsp0sBRI91ASP
         FGo9hh6WIGQ6XgzcIELXiLn2XJDa/K/FsVfFTlRnYMUGuSUjGnQ9Zk8EAX6eMxYDp/9c
         9k4a01syqJM7ov0ftogZ306tn+a6C9RTKnU3nJRZptwrW6idJO62PvhmoQyg45NFesNk
         u3bOJtJsrMyWLxazZJaB2vvDlvmOr67e1hYbSGzo/QBSYc9oWAkUr31jA/Ik3l/UVdhm
         l3VA==
X-Forwarded-Encrypted: i=1; AKwUvBwyqADiz7Ma/C77kjJ5Au2w2Ewpyf5paLH3AsnZVhwSqAQnmILuhTyEGW/Y2Rw1XKqoVEYM1ghtAbpsdp4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ljfsOaFIB02eZ8SckQfDA6S5C92uiaEedVh7BoMdLSVZWWg/Bp
	JXo1udy5/kgerYbs01Rde1fXP33chqFRz0otOzSvddkx1BsxNiGnlK19Hx85YJ4qABJqpk3NN5r
	uOZQWj0obMQ/1ADtMB9C2RZx7NBuaAAU=
X-Gm-Gg: AYBFou30Za+rQYwccLp97D7EBzRFDGf08S6L/EcltlKPKQN84nFJVheRHR3fIPmioF5
	5Rzl18UNkO6ShCpVCYDFVTPqbhDcg6KYOuvjqPNJlZtDGvc/2+eIc9IKQwIphPe+AZfjeiIxw0s
	MSmqu2kmcVFmB7eZdjeUhB9quefu0ytTTxGCdEZM8N70908LZSMcwAmigL7Ve6bviqsHwDb9gUp
	kELuwgVPfhpStlXM9usoSLkZmuQzSf5psfSy4Kf0rTHqoUPCm9Mc5R3C70APRLOyx3Hdq3bmaef
	KoZyoUe1VT9J72p+hXRGSeWJ5qxCiVHjcSBPef93N+u7WIsTIDbttz5s+Ukm5sW6qXEL5ckCK/d
	LgqS5BjYtCQTl+w==
X-Received: by 2002:a05:690e:1448:b0:671:3b67:8a7a with SMTP id
 956f58d0204a3-6716f1503b4mr822727d50.42.1789609567316; Wed, 16 Sep 2026
 18:46:07 -0700 (PDT)
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
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
 <20260915013110.4780-1-prasanth.padarthi10@gmail.com> <20260915013110.4780-3-prasanth.padarthi10@gmail.com>
 <178954999459.14468.3220034594197550391.b4-review@b4>
In-Reply-To: <178954999459.14468.3220034594197550391.b4-review@b4>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Thu, 17 Sep 2026 07:15:56 +0530
X-Gm-Features: AcwNN1UdrXBNsGeffpdFdIkqCffMMWj64Hnt-znjfLcodjJc9sYsCQEWLc2Z4pg
Message-ID: <CAMFFDGircqrsDSOCPo+nzcpXoNi2Yu93BBQ+dkXw5rC4dWRjtQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
To: Tan Siewert <tan.siewert@9elements.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tan,

Thanks for pointing this out. I had identified P3 from runtime GPIO
observations while exercising host power control, but after checking
the AST2600 pinctrl definitions I see that P0-P5 provide the
THRUIN/THRUOUT functions, so that observation alone was not sufficient
to establish the board-level signal mapping. I'll update this in the
next revision based on your schematic information.

Thanks,
Prasanth

On Wed, Sep 16, 2026 at 2:43=E2=80=AFPM Tan Siewert <tan.siewert@9elements.=
com> wrote:
>
> > Add the device tree for the ASRock Rack B650D4U BMC, which is
> > based on the ASPEED AST2600 SoC.
> >
> > Describe the BMC memory, SPI NOR flash layout, UART console,
> > GPIO line names, video framebuffer memory, I2C EEPROM, and MAC0
> > connected to an RTL8211F Ethernet PHY.
> >
> > Use the EEPROM on I2C7 as the NVMEM provider for the MAC0 address.
> >
> > Configure MAC0 to use the RTL8211F in RGMII-ID mode.
> >
> > Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
>
> dt-check-style --mode strict reports issues:
>
>     arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:8: [property-o=
rder] property 'compatible' out of canonical order (should sort before 'mod=
el')
>     arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:26: [property-=
order] property 'ranges' out of canonical order (should sort before '#size-=
cells')
>     arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:30: [property-=
order] property 'alignment' out of canonical order (should sort before 'siz=
e')
>     arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:31: [property-=
order] property 'compatible' out of canonical order (should sort before 'al=
ignment')
>     arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:39: [property-=
order] property 'memory-region' out of canonical order (should sort before =
'status')
>     arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:70: [property-=
order] property 'spi-max-frequency' out of canonical order (should sort bef=
ore 'm25p,fast-read')
>     arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:72: [required-=
blank-lines] "status" must be preceded by a blank line
>     arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:80: [property-=
order] property 'phy-mode' out of canonical order (should sort before 'stat=
us')
>     arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:81: [property-=
order] property 'phy-handle' out of canonical order (should sort before 'ph=
y-mode')
>     arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:83: [property-=
order] property 'pinctrl-0' out of canonical order (should sort before 'pin=
ctrl-names')
>     arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:85: [property-=
order] property 'nvmem-cells' out of canonical order (should sort before 'p=
inctrl-0')
>
> >
> > diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspe=
ed/Makefile
> > index 6b68671f9379..b109491d5c8f 100644
> > --- a/arch/arm/boot/dts/aspeed/Makefile
> > +++ b/arch/arm/boot/dts/aspeed/Makefile
> > @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> >       aspeed-bmc-ampere-mtmitchell.dtb \
> >       aspeed-bmc-arm-stardragon4800-rep2.dtb \
> >       aspeed-bmc-asrock-altrad8.dtb \
> > +     aspeed-bmc-asrock-b650d4u.dtb \
> >       aspeed-bmc-asrock-e3c246d4i.dtb \
> >       aspeed-bmc-asrock-e3c256d4i.dtb \
> >       aspeed-bmc-asrock-paul-ipmi-card.dtb \
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> > new file mode 100644
> > index 000000000000..6585bda56a4c
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> > @@ -0,0 +1,120 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/dts-v1/;
> > +
> > +#include "aspeed-g6.dtsi"
> > +
> > +/ {
> > +     model =3D "ASRock Rack B650D4U BMC";
> > +     compatible =3D "asrock,b650d4u-bmc", "aspeed,ast2600";
> > +
> > +     aliases {
> > +             serial0 =3D &uart5;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +     };
> > +
> > +     memory@80000000 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x80000000 0x20000000>;
> > +     };
> > +
> > +     reserved-memory {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <1>;
> > +             ranges;
> > +
> > +             gfx_memory: framebuffer {
> > +                     size =3D <0x01000000>;
> > +                     alignment =3D <0x01000000>;
> > +                     compatible =3D "shared-dma-pool";
> > +                     reusable;
> > +             };
> > +     };
> > +};
> > +
> > +&gfx {
> > +     status =3D "okay";
> > +     memory-region =3D <&gfx_memory>;
> > +};
> > +
> > +&gpio0 {
> > +     gpio-line-names =3D
> > +             /* A0-A7 */     "","","","","","","","",
> > +             /* B0-B7 */     "","","","","","","","",
> > +             /* C0-C7 */     "","","","","","","","",
> > +             /* D0-D7 */     "","","","","","","","",
> > +             /* E0-E7 */     "","","","","","","","",
> > +             /* F0-F7 */     "","","","","","button-reset-n","","",
>
> How did you confirm this? According to the schematic it should be P0 (P0-=
P5
> have GPIO passthrough functionality).
>
> > +             /* G0-G7 */     "","","","","","","","",
> > +             /* H0-H7 */     "","","","","","","","",
> > +             /* I0-I7 */     "","","","","","","","",
> > +             /* J0-J7 */     "","","","","","","","",
> > +             /* K0-K7 */     "","","","","","","","",
> > +             /* L0-L7 */     "","","","","","","","",
> > +             /* M0-M7 */     "","","","","","","","",
> > +             /* N0-N7 */     "","","","","","","","",
> > +             /* O0-O7 */     "","","","","","","","",
> > +             /* P0-P3 */     "","","","control-power-n";
>
> Personally, I'm not a fan when `gpio-line-names` doesn't match with the a=
mount
> of defined `ngpios`, but that doesn't mean it's wrong. Maybe Andrew Jeffr=
ey has
> a different opinion on that.
>
> > +};
> > +
> > +&fmc {
> > +     status =3D "okay";
> > +
> > +     flash@0 {
> > +             compatible =3D "jedec,spi-nor";
> > +             reg =3D <0>;
> > +             label =3D "bmc";
> > +             m25p,fast-read;
> > +             spi-max-frequency =3D <50000000>;
> > +             spi-rx-bus-width =3D <4>;
> > +             status =3D "okay";
> > +
> > +#include "openbmc-flash-layout-64.dtsi"
> > +     };
> > +};
> > +
> > +&mac0 {
> > +     status =3D "okay";
> > +     phy-mode =3D "rgmii-id";
> > +     phy-handle =3D <&ethphy0>;
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_rgmii1_default>;
> > +
> > +     nvmem-cells =3D <&eth0_macaddress>;
> > +     nvmem-cell-names =3D "mac-address";
> > +};
> > +
> > +&mdio0 {
> > +     status =3D "okay";
> > +
> > +     ethphy0: ethernet-phy@0 {
> > +             compatible =3D "ethernet-phy-ieee802.3-c22";
> > +             reg =3D <0>;
> > +     };
> > +};
> > +
> > +&uart5 {
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c7 {
>
> Please sort your nodes, as per the device-tree style guideline [0].
>
> [0] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
>
> Tan
>
> --
> Tan Siewert <tan.siewert@9elements.com>

