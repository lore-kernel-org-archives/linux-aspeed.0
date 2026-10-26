Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE8606A325
	for <linux-aspeed@archiver.kernel.org>; Mon, 26 Oct 2026 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xr4e1Wm+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCkBZ3bp5z2yGT;
	Mon, 26 Oct 2026 17:25:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::530" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792989266;
	cv=pass; b=B8y0HD/4zHhOYksgXMZ8xDZW7k0Eo5POF3a8YH5HragyepMlScHQ/IYzoPGvZO3p76K/5ATWDwp187qIfZse8cf4U3f02OgGTxmvbAYSQo0AAK6uVd0evvTbqMzd0QrCZ5+ZNz91xwbleCPzfFCRJKLttMfedHIVuKSE6biJPp9Fm4bRh43R/p08JhSVJVIXZbeMns4kunwDrX2dQGTsWE/m1xbkt6QgrMNxL00hRE/9TnaAJRRmNxdAr3Yl154KpT1Oniuk6icMdmkcadXJs6kMRZHn7mjQYTWIJ0HQnjvIaRiqHeCgRymm1yij8rdPGzObaU5Ch+f1dpe2eH/3eQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792989266; c=relaxed/relaxed;
	bh=JknfVeyropx1Yfkv746qbFuy3ZewLN9dKu8PP8jMuQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzalmKOlFFbo3FFwkJ+1d4gqa/uW9ICaM3JghN5tUQySeZPZ6WEkV89mI4d6zbDnz3DdS9JqPyXcwZQGaEot5GrXT4taapABRcnnKDfjblleO3A1h4us/j9jm3hb+L2+Dq80y8BNcVmTBrpvykAp9Mp/KWTHX7Cxb0Rmej7B/e+yX+0b//jyjZhEZ/+pnL8ZUcfPC5AT3K5rUClNfV/bIHmGdOVgst79x/1JDBS+DjBox4bDH5o20OLoA6sIhWblUjSxcocQRTyOOtTRqevuW0eop02PogszsvjVSzZjxroCv0e/dYFcCn6vyKpEAcjw6QAeVGs82hdrqnaL/8f/OA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xr4e1Wm+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=kavyamadarsh@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xr4e1Wm+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=kavyamadarsh@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCgkl5wKlz2xcB
	for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Oct 2026 15:34:22 +1100 (AEDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so4495223a12.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 25 Oct 2026 21:34:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792989257; cv=none;
        d=google.com; s=arc-20260327;
        b=KnPwxvMIwv/ZW3VyYuQEl5ztSriz/t/tnP7gsAMosAGHJsYbvmjAutViWcra5EItNA
         VhellpI9/R2QYWvlCoNI6azuAIGetEyQcnA+z/QvnOrHPoODpeAiZxV1Nmvb/tngxf64
         e1BwYHT+o78cOrLpZE4gn4Nt3w64bJwQfglB2ljh6ItWba8N1R+RgmrgV1h2QlXHqRXP
         hM0U47w+q51HGLYLjB14kCYZeO66iPOPSWcXLAH5HmOzBQUHAkRWpXJa7hTLIl8LXihi
         MupgbAZztUCtf/FIAaqDCAw4CRXBYkY/pdNvkD4FEVGop9EQnaUt/VdJN91kGh3mEwEx
         +lfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JknfVeyropx1Yfkv746qbFuy3ZewLN9dKu8PP8jMuQY=;
        fh=o8gM4DlxPOdl5OURfVvTraJth6/HNCOdmAxoP9erMCY=;
        b=L1+O9QKnI17ZdBbUjUDYV0F9ONtbKZ0gVz3wNFjS9iHb4e0nQe2Bv3Z69z/6Ych4WO
         P7dxGolUHIMfoAziIVPd86cSJf8ek0gX0t9WXnotpyMoq4t7BeTpeu9VsfiPkyhN4WZv
         tvXIR+hEdHPX1+cniA6D4o3CZqyGuQ7FRG5rPXPPdwyszzitE3a/vEl/u0DYJ+a0+5BZ
         8yVmRM8Zqh158oqS+cLFbRdkLdSCSIwAfr6NoSlw3+I2dUl5kHcvgy5wSZTGMxV8TjYm
         YYX/WJywXDMGeaKYRwFHGrnaDaKn6pultL0iE5jAoxUfoQLl8q6V3iiMDr0L0c22ekjE
         mX/A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792989257; x=1793594057; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JknfVeyropx1Yfkv746qbFuy3ZewLN9dKu8PP8jMuQY=;
        b=Xr4e1Wm+qhoDun12DgFTQuRK5nbNXgfPDmtPrA0mMPaJ4/JoZ3oMR+Se5qpazyEuNg
         kfMtWpDsX+nGuCo5v0Ruyu4Havw1flkaddGs85AaWaGPqzwPKIDlYqyZT3mKvBM9uECj
         w6/hwEvLb9huGFeVdEqYzT6EhF7f59mxr88Lw4OvQHtaYJiYpIls9nEip1vua9ZpaP2Q
         EQ+vtzYTWosWAJT1hCZUtifW92kTlVbj6SF6sASkQ51rNrAR2HEBsi1nxQor/Ikk4V1m
         pMaCFWx+C97NZPbnW8Ds65IfBV38tXcNG082l8Xj4uQUBehAHtDHsRSp7B5khTAvuV3J
         tKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792989257; x=1793594057;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JknfVeyropx1Yfkv746qbFuy3ZewLN9dKu8PP8jMuQY=;
        b=VwgmLeLGOAYl7QcfqSOggYSu3ARnCgH9PU0Z4QsJVyrlkP9d2YavmyRLf6Jd8xSJuz
         NUhafHQ8dcNmuZatCcc+3PxEihN8dHer9SbaCs8nh2pfTXEBrlhc6WUlouwZYBfLh9gb
         yPJ0ZDOx7ycy9mZQG9+hzpo4fHJWtt+JOMYOVAq2oPTWwDPEzX0VTwN/t+ktH82DA27H
         /NTTu7p3OStiyByMbRtFuT7rr9SbpC9XKoIuv4mi7rBsqoBX0mjV546Ju85i8GvqW5rE
         8Zl5+68T0iGmVaBoMLYN8nZZfxSb5Cnfuap0K/+Z/pJ/GvM3M7WgKSBnSeMjsXaB6rcY
         F5lA==
X-Forwarded-Encrypted: i=1; AKwUvBzMzJbYQg+0492Flc5hAX5v8q2twrMWfUG/zxSbNTgExJhS4ECKVnyTK+rMz4XxvN5el0uUOxUjBR2ZWUQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJMWBa2tKX8RkWJH0HMdp05swVVZkk+wTVyskUq64sJc8mO/QMX
	7RIUT+jYQGI170ED+YQh1Z/UjGeQ0gYaFHV/u1SrvurxfQl+lSvj3oPm0KqUMcyg2uFEWR8Jh3a
	cq0KpftQ2OpOZsYHJTsrd5ne8Dlu+Mog=
X-Gm-Gg: AYBFou1s9Q2V/tG3SJIPsX/NUx0Lz0uaX+KLCaLdS2mu4THMJ1a8hOGKUTdGUaVht5P
	TLYau3650uujzFrcHGv3po0vKb9xSS9hhsuBiHAb+tRpRDu+RTyfsvz/MPg+DLMGfAy8RuhVzQt
	1NSqXbuuXn9qZ0KKa8REPqn7uReeIaNjnRq09CjU0EjlT8F0x5+BS/tvn4osapwcDRnYdxouruw
	KyGwOlGh1Ag5/DSNPuvL6meFyZZe/Elxsny7xuwHbWg/bdqhPVHU6tvyQi5L25IrL8U/UeVcH9X
	TOrwX2CTGYZtSIqB2fJn+wfKZJw9QPLYj6/hDR3uUVX0Cj+bdzMrhfk1/16N8MM+HsF716QRwlC
	pJcgQsiYbM0Kkl8YM1gSxtp7PTOlY9TyP26gS
X-Received: by 2002:a17:906:f58c:b0:c2e:3b23:1468 with SMTP id
 a640c23a62f3a-c46bdfe801emr708215866b.48.1792989257222; Sun, 25 Oct 2026
 21:34:17 -0700 (PDT)
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
References: <20261002062933.26497-1-prasanth.padarthi10@gmail.com>
 <20261002062933.26497-3-prasanth.padarthi10@gmail.com> <CAMFFDGjmJTRR8GOX=S+kKnMA-bG+gbZP0sS8dG_d+taDPPRDZQ@mail.gmail.com>
In-Reply-To: <CAMFFDGjmJTRR8GOX=S+kKnMA-bG+gbZP0sS8dG_d+taDPPRDZQ@mail.gmail.com>
From: KAVYA M M <kavyamadarsh@gmail.com>
Date: Mon, 26 Oct 2026 10:04:05 +0530
X-Gm-Features: AclHuK99f_qXUYjg8MyEOV0P5O4UaXNX-iYuiNNSBbvkSpdmMfb2FxquJTDgB8Y
Message-ID: <CAD_a9mYKSYyP2TqeyjbQWYHdZgF3ggdrU6oTK6VWs2C2GSYMjQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
To: Prasanth <prasanth.padarthi10@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Andrew Lunn <andrew@lunn.ch>
Content-Type: multipart/alternative; boundary="000000000000c34f0c065eb6d71d"
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,WEIRD_QUOTING
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c34f0c065eb6d71d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello team,
I am new to OpenBMC. I want to development image for the machine using the
OpenBMC/Yocto build system, available firmware information, and readings
from the existing BMC.

Since the original BMC firmware has limited access and the motherboard
schematic is not available to me, I would appreciate your guidance on the
recommended approach for developing and validating a reliable OpenBMC image
for this board.

I have the following questions:

1. Hardware documentation required
=E2=80=A2 What documents are normally required before starting an OpenBMC p=
ort for
a new motherboard?
=E2=80=A2 Is the motherboard user manual sufficient, or do we also need the
motherboard schematic, BMC datasheet, hardware design guide, component
datasheets, and board-specific signal mappings?
=E2=80=A2 for example the CPU schematic and AST(BmC) reference schematic ar=
e
available but the motherboard schematic is missing, how much of the
required hardware configuration can be established from them?
=E2=80=A2 Since my target board uses the ASTs BmC, which specific datasheet=
s or
hardware design documents should I obtain?

2. Extracting information from existing BMC firmware
=E2=80=A2 If the original BMC firmware is available only as a binary and it=
s Linux
shell or source code is restricted, what information can reliably be
extracted from the image?
=E2=80=A2 Can we identify the flash layout, device tree, GPIO configuration=
, I=C2=B2C
devices, sensor definitions, fan configuration, Ethernet settings, and
board identity?
=E2=80=A2 Which details can be confirmed from firmware, and which require t=
he
motherboard schematic or physical measurements?

3. GPIO and hardware configuration
=E2=80=A2 How can we verify GPIO connections, signal polarity, direction, t=
iming,
and safe initial states without the motherboard schematic?
=E2=80=A2 How can we identify the actual I=C2=B2C bus routing, multiplexers=
, device
addresses, and peripheral protocols?
=E2=80=A2 What is the recommended method for verifying voltage-divider valu=
es, ADC
scaling, and temperature sensor configuration?
=E2=80=A2 How should fan PWM/tachometer mappings, fan zones, minimum safe s=
peeds,
and failsafe behavior be established?
=E2=80=A2 How can the LED wiring, Ethernet PHY address/reset configuration,=
 and
NCSI connections be verified?

4. OpenBMC image development
=E2=80=A2 What is the recommended workflow for creating a new OpenBMC machi=
ne
configuration, device tree, Yocto layer, sensor configuration, and required
services?
=E2=80=A2 Are there existing OpenBMC reference boards or porting guides tha=
t would
be useful for this type of project?
=E2=80=A2 Can we proceed with firmware analysis and QEMU testing while some
hardware details remain unknown?
=E2=80=A2 Which functions can be validated in QEMU, and which must be teste=
d on the
physical motherboard?

5. Flashing and recovery
=E2=80=A2 If the original BMC firmware source code is unavailable, can a cu=
stom
OpenBMC image still be developed and flashed safely?
=E2=80=A2 How should the original SPI flash be backed up, the flash layout =
and
image size verified, and a recovery procedure prepared?
=E2=80=A2 What checks should be completed before writing the image to the p=
hysical
BMC?
=E2=80=A2 If the image boots but networking, fan control, sensors, or other
hardware functions do not work correctly, what is the recommended debugging
and recovery process?

6. Validation and safety

=E2=80=A2 What validation checklist should be completed before enabling hos=
t power
control or testing other GPIO outputs?
=E2=80=A2 How should fan control and cooling failsafe behavior be validated=
 before
using the image on a live server?
=E2=80=A2 What are the minimum hardware details that must be verified befor=
e
proceeding with physical-board testing?

My current goal is to continue testing the image in QEMU, document the
confirmed and unverified hardware mappings, and determine the correct
procedure before flashing the physical board.

I would be grateful for any recommended documentation, reference
schematics, OpenBMC porting guides, practical experience, or advice from
engineers who have worked on similar BMC porting projects .

Thank you for your time and guidance.  please response or guide anyone to
take my step forward towards learning.

Best regards,
Kavya M M

On Mon, 26 Oct, 2026, 9:05=E2=80=AFam Prasanth, <prasanth.padarthi10@gmail.=
com>
wrote:

> Hi,
>
> A gentle follow-up on the B650D4U BMC device-tree series posted on Octobe=
r
> 2.
>
> Could you please let me know whether any further changes or validation
> are needed before this series can be picked up?
>
> Thanks,
> Prasanth
>
> On Fri, Oct 2, 2026 at 11:59=E2=80=AFAM Prasanth Kumar Padarthi
> <prasanth.padarthi10@gmail.com> wrote:
> >
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
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch> # MAC0 and MDIO nodes only
> > Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed/Makefile             |   1 +
> >  .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 135 ++++++++++++++++++
> >  2 files changed, 136 insertions(+)
> >  create mode 100644
> arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> >
> > diff --git a/arch/arm/boot/dts/aspeed/Makefile
> b/arch/arm/boot/dts/aspeed/Makefile
> > index 6b68671f9379..b109491d5c8f 100644
> > --- a/arch/arm/boot/dts/aspeed/Makefile
> > +++ b/arch/arm/boot/dts/aspeed/Makefile
> > @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> >         aspeed-bmc-ampere-mtmitchell.dtb \
> >         aspeed-bmc-arm-stardragon4800-rep2.dtb \
> >         aspeed-bmc-asrock-altrad8.dtb \
> > +       aspeed-bmc-asrock-b650d4u.dtb \
> >         aspeed-bmc-asrock-e3c246d4i.dtb \
> >         aspeed-bmc-asrock-e3c256d4i.dtb \
> >         aspeed-bmc-asrock-paul-ipmi-card.dtb \
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> > new file mode 100644
> > index 000000000000..a4e384588a54
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> > @@ -0,0 +1,135 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/dts-v1/;
> > +
> > +#include "aspeed-g6.dtsi"
> > +
> > +/ {
> > +       compatible =3D "asrock,b650d4u-bmc", "aspeed,ast2600";
> > +       model =3D "ASRock Rack B650D4U BMC";
> > +
> > +       aliases {
> > +               serial0 =3D &uart5;
> > +       };
> > +
> > +       chosen {
> > +               stdout-path =3D "serial0:115200n8";
> > +       };
> > +
> > +       memory@80000000 {
> > +               device_type =3D "memory";
> > +               reg =3D <0x80000000 0x20000000>;
> > +       };
> > +
> > +       reserved-memory {
> > +               ranges;
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <1>;
> > +
> > +               gfx_memory: framebuffer {
> > +                       compatible =3D "shared-dma-pool";
> > +                       alignment =3D <0x01000000>;
> > +                       reusable;
> > +                       size =3D <0x01000000>;
> > +               };
> > +       };
> > +};
> > +
> > +&fmc {
> > +       status =3D "okay";
> > +
> > +       flash@0 {
> > +               compatible =3D "jedec,spi-nor";
> > +               reg =3D <0>;
> > +               label =3D "bmc";
> > +               spi-max-frequency =3D <50000000>;
> > +               spi-rx-bus-width =3D <4>;
> > +               m25p,fast-read;
> > +
> > +               status =3D "okay";
> > +
> > +#include "openbmc-flash-layout-64.dtsi"
> > +       };
> > +};
> > +
> > +&gfx {
> > +       memory-region =3D <&gfx_memory>;
> > +
> > +       status =3D "okay";
> > +};
> > +
> > +&gpio0 {
> > +       gpio-line-names =3D
> > +               /* A0-A7 */     "","","","","","","","",
> > +               /* B0-B7 */     "","","","","","","","",
> > +               /* C0-C7 */     "","","","","","","","",
> > +               /* D0-D7 */     "","","","","","","","",
> > +               /* E0-E7 */     "","","","","","","","",
> > +               /* F0-F7 */     "","","","","","","","",
> > +               /* G0-G7 */     "","","","","","","","",
> > +               /* H0-H7 */     "","","","","","","","",
> > +               /* I0-I7 */     "","","","","","","","",
> > +               /* J0-J7 */     "","","","","","","","",
> > +               /* K0-K7 */     "","","","","","","","",
> > +               /* L0-L7 */     "","","","","","","","",
> > +               /* M0-M7 */     "","","","","","","","",
> > +               /* N0-N7 */     "","","","","","","","",
> > +               /* O0-O7 */     "","","","","","","","",
> > +               /* P0-P7 */     "button-reset-n","control-reset-n",
> > +               "button-power-n","control-power-n",
> > +               "button-nmi-n","control-nmi-n",
> > +               "","",
> > +               /* Q0-Q7 */     "","","","","","","","",
> > +               /* R0-R7 */     "","","","","","","","",
> > +               /* S0-S7 */     "","","","","","","","",
> > +               /* T0-T7 */     "","","","","","","","",
> > +               /* U0-U7 */     "","","","","","","","",
> > +               /* V0-V7 */     "","","","","","","","",
> > +               /* W0-W7 */     "","","","","","","","",
> > +               /* X0-X7 */     "","","","","","","","",
> > +               /* Y0-Y7 */     "","","","","","","","",
> > +               /* Z0-Z7 */     "","","","","","","","";
> > +};
> > +
> > +&i2c7 {
> > +       status =3D "okay";
> > +
> > +       eeprom@57 {
> > +               compatible =3D "atmel,24c128";
> > +               reg =3D <0x57>;
> > +               pagesize =3D <16>;
> > +
> > +               nvmem-layout {
> > +                       compatible =3D "fixed-layout";
> > +                       #address-cells =3D <1>;
> > +                       #size-cells =3D <1>;
> > +
> > +                       eth0_macaddress: macaddress@3f80 {
> > +                               reg =3D <0x3f80 6>;
> > +                       };
> > +               };
> > +       };
> > +};
> > +
> > +&mac0 {
> > +       nvmem-cells =3D <&eth0_macaddress>;
> > +       nvmem-cell-names =3D "mac-address";
> > +       phy-handle =3D <&ethphy0>;
> > +       phy-mode =3D "rgmii-id";
> > +       pinctrl-0 =3D <&pinctrl_rgmii1_default>;
> > +       pinctrl-names =3D "default";
> > +
> > +       status =3D "okay";
> > +};
> > +
> > +&mdio0 {
> > +       status =3D "okay";
> > +
> > +       ethphy0: ethernet-phy@0 {
> > +               compatible =3D "ethernet-phy-ieee802.3-c22";
> > +               reg =3D <0>;
> > +       };
> > +};
> > +
> > +&uart5 {
> > +       status =3D "okay";
> > +};
> > --
> > 2.47.3
> >
>
>

--000000000000c34f0c065eb6d71d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello team,<div dir=3D"auto">I am new to  OpenBMC. I want=
 to  development image  for the machine using the OpenBMC/Yocto build syste=
m, available firmware information, and readings from the existing BMC.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Since the original BMC firmw=
are has limited access and the motherboard schematic is not available to me=
, I would appreciate your guidance on the recommended approach for developi=
ng and validating a reliable OpenBMC image for this board.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">I have the following questions:</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">1. Hardware documentation requir=
ed</div><div dir=3D"auto">=E2=80=A2 What documents are normally required be=
fore starting an OpenBMC port for a new motherboard?</div><div dir=3D"auto"=
>=E2=80=A2 Is the motherboard user manual sufficient, or do we also need th=
e motherboard schematic, BMC datasheet, hardware design guide, component da=
tasheets, and board-specific signal mappings?</div><div dir=3D"auto">=E2=80=
=A2  for example the CPU schematic and AST(BmC) reference schematic are ava=
ilable but the motherboard schematic is missing, how much of the required h=
ardware configuration can be established from them?</div><div dir=3D"auto">=
=E2=80=A2 Since my target board uses the ASTs BmC, which specific datasheet=
s or hardware design documents should I obtain?</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">2. Extracting information from existing BMC firmwar=
e</div><div dir=3D"auto">=E2=80=A2 If the original BMC firmware is availabl=
e only as a binary and its Linux shell or source code is restricted, what i=
nformation can reliably be extracted from the image?</div><div dir=3D"auto"=
>=E2=80=A2 Can we identify the flash layout, device tree, GPIO configuratio=
n, I=C2=B2C devices, sensor definitions, fan configuration, Ethernet settin=
gs, and board identity?</div><div dir=3D"auto">=E2=80=A2 Which details can =
be confirmed from firmware, and which require the motherboard schematic or =
physical measurements?</div><div dir=3D"auto"><br></div><div dir=3D"auto">3=
. GPIO and hardware configuration</div><div dir=3D"auto">=E2=80=A2 How can =
we verify GPIO connections, signal polarity, direction, timing, and safe in=
itial states without the motherboard schematic?</div><div dir=3D"auto">=E2=
=80=A2 How can we identify the actual I=C2=B2C bus routing, multiplexers, d=
evice addresses, and peripheral protocols?</div><div dir=3D"auto">=E2=80=A2=
 What is the recommended method for verifying voltage-divider values, ADC s=
caling, and temperature sensor configuration?</div><div dir=3D"auto">=E2=80=
=A2 How should fan PWM/tachometer mappings, fan zones, minimum safe speeds,=
 and failsafe behavior be established?</div><div dir=3D"auto">=E2=80=A2 How=
 can the LED wiring, Ethernet PHY address/reset configuration, and NCSI con=
nections be verified?</div><div dir=3D"auto"><br></div><div dir=3D"auto">4.=
 OpenBMC image development</div><div dir=3D"auto">=E2=80=A2 What is the rec=
ommended workflow for creating a new OpenBMC machine configuration, device =
tree, Yocto layer, sensor configuration, and required services?</div><div d=
ir=3D"auto">=E2=80=A2 Are there existing OpenBMC reference boards or portin=
g guides that would be useful for this type of project?</div><div dir=3D"au=
to">=E2=80=A2 Can we proceed with firmware analysis and QEMU testing while =
some hardware details remain unknown?</div><div dir=3D"auto">=E2=80=A2 Whic=
h functions can be validated in QEMU, and which must be tested on the physi=
cal motherboard?</div><div dir=3D"auto"><br></div><div dir=3D"auto">5. Flas=
hing and recovery</div><div dir=3D"auto">=E2=80=A2 If the original BMC firm=
ware source code is unavailable, can a custom OpenBMC image still be develo=
ped and flashed safely?</div><div dir=3D"auto">=E2=80=A2 How should the ori=
ginal SPI flash be backed up, the flash layout and image size verified, and=
 a recovery procedure prepared?</div><div dir=3D"auto">=E2=80=A2 What check=
s should be completed before writing the image to the physical BMC?</div><d=
iv dir=3D"auto">=E2=80=A2 If the image boots but networking, fan control, s=
ensors, or other hardware functions do not work correctly, what is the reco=
mmended debugging and recovery process?</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">6. Validation and safety</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">=E2=80=A2 What validation checklist should be completed be=
fore enabling host power control or testing other GPIO outputs?</div><div d=
ir=3D"auto">=E2=80=A2 How should fan control and cooling failsafe behavior =
be validated before using the image on a live server?</div><div dir=3D"auto=
">=E2=80=A2 What are the minimum hardware details that must be verified bef=
ore proceeding with physical-board testing?</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">My current goal is to continue testing the image in QEM=
U, document the confirmed and unverified hardware mappings, and determine t=
he correct procedure before flashing the physical board.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">I would be grateful for any recommended do=
cumentation, reference schematics, OpenBMC porting guides, practical experi=
ence, or advice from engineers who have worked on similar BMC porting proje=
cts .</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thank you for your=
 time and guidance.=C2=A0 please response or guide anyone to take my step f=
orward towards learning.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Best regards,</div><div dir=3D"auto">Kavya M M</div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Mon, 26 Oct, 2026, 9:05=E2=80=AFam Prasanth, &lt;<a href=3D"mailto:pra=
santh.padarthi10@gmail.com">prasanth.padarthi10@gmail.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
A gentle follow-up on the B650D4U BMC device-tree series posted on October =
2.<br>
<br>
Could you please let me know whether any further changes or validation<br>
are needed before this series can be picked up?<br>
<br>
Thanks,<br>
Prasanth<br>
<br>
On Fri, Oct 2, 2026 at 11:59=E2=80=AFAM Prasanth Kumar Padarthi<br>
&lt;<a href=3D"mailto:prasanth.padarthi10@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">prasanth.padarthi10@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Add the device tree for the ASRock Rack B650D4U BMC, which is<br>
&gt; based on the ASPEED AST2600 SoC.<br>
&gt;<br>
&gt; Describe the BMC memory, SPI NOR flash layout, UART console,<br>
&gt; GPIO line names, video framebuffer memory, I2C EEPROM, and MAC0<br>
&gt; connected to an RTL8211F Ethernet PHY.<br>
&gt;<br>
&gt; Use the EEPROM on I2C7 as the NVMEM provider for the MAC0 address.<br>
&gt;<br>
&gt; Configure MAC0 to use the RTL8211F in RGMII-ID mode.<br>
&gt;<br>
&gt; Reviewed-by: Andrew Lunn &lt;<a href=3D"mailto:andrew@lunn.ch" target=
=3D"_blank" rel=3D"noreferrer">andrew@lunn.ch</a>&gt; # MAC0 and MDIO nodes=
 only<br>
&gt; Signed-off-by: Prasanth Kumar Padarthi &lt;<a href=3D"mailto:prasanth.=
padarthi10@gmail.com" target=3D"_blank" rel=3D"noreferrer">prasanth.padarth=
i10@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 arch/arm/boot/dts/aspeed/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts=C2=A0 | 135 +++++++=
+++++++++++<br>
&gt;=C2=A0 2 files changed, 136 insertions(+)<br>
&gt;=C2=A0 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b6=
50d4u.dts<br>
&gt;<br>
&gt; diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/asp=
eed/Makefile<br>
&gt; index 6b68671f9379..b109491d5c8f 100644<br>
&gt; --- a/arch/arm/boot/dts/aspeed/Makefile<br>
&gt; +++ b/arch/arm/boot/dts/aspeed/Makefile<br>
&gt; @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed-bmc-ampere-mtmitchell.dtb \<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed-bmc-arm-stardragon4800-rep2.dt=
b \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed-bmc-asrock-altrad8.dtb \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed-bmc-asrock-b650d4u.dtb \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed-bmc-asrock-e3c246d4i.dtb \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed-bmc-asrock-e3c256d4i.dtb \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed-bmc-asrock-paul-ipmi-card.dtb =
\<br>
&gt; diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts b/=
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..a4e384588a54<br>
&gt; --- /dev/null<br>
&gt; +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts<br>
&gt; @@ -0,0 +1,135 @@<br>
&gt; +// SPDX-License-Identifier: GPL-2.0<br>
&gt; +/dts-v1/;<br>
&gt; +<br>
&gt; +#include &quot;aspeed-g6.dtsi&quot;<br>
&gt; +<br>
&gt; +/ {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;asrock,b650d4u-bmc&qu=
ot;, &quot;aspeed,ast2600&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0model =3D &quot;ASRock Rack B650D4U BMC&qu=
ot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0aliases {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial0 =3D &a=
mp;uart5;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0chosen {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout-path =
=3D &quot;serial0:115200n8&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0memory@80000000 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_type =
=3D &quot;memory&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x=
80000000 0x20000000&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0reserved-memory {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ranges;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#address-cells=
 =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#size-cells =
=3D &lt;1&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_memory: fr=
amebuffer {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0compatible =3D &quot;shared-dma-pool&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0alignment =3D &lt;0x01000000&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0reusable;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0size =3D &lt;0x01000000&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;fmc {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0flash@0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D=
 &quot;jedec,spi-nor&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0&=
gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0label =3D &quo=
t;bmc&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spi-max-freque=
ncy =3D &lt;50000000&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spi-rx-bus-wid=
th =3D &lt;4&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0m25p,fast-read=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D &qu=
ot;okay&quot;;<br>
&gt; +<br>
&gt; +#include &quot;openbmc-flash-layout-64.dtsi&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;gfx {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0memory-region =3D &lt;&amp;gfx_memory&gt;;=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;gpio0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0gpio-line-names =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* A0-A7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* B0-B7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* C0-C7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* D0-D7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* E0-E7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* F0-F7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* G0-G7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* H0-H7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* I0-I7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* J0-J7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* K0-K7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* L0-L7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* M0-M7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* N0-N7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* O0-O7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* P0-P7 */=C2=
=A0 =C2=A0 =C2=A0&quot;button-reset-n&quot;,&quot;control-reset-n&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;button-p=
ower-n&quot;,&quot;control-power-n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;button-n=
mi-n&quot;,&quot;control-nmi-n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;,&=
quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Q0-Q7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* R0-R7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* S0-S7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* T0-T7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* U0-U7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* V0-V7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* W0-W7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* X0-X7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Y0-Y7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Z0-Z7 */=C2=
=A0 =C2=A0 =C2=A0&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;=
&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;i2c7 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0eeprom@57 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D=
 &quot;atmel,24c128&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x=
57&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pagesize =3D &=
lt;16&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvmem-layout {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0compatible =3D &quot;fixed-layout&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0#size-cells =3D &lt;1&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0eth0_macaddress: macaddress@3f80 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x3f80 6&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;mac0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0nvmem-cells =3D &lt;&amp;eth0_macaddress&g=
t;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0nvmem-cell-names =3D &quot;mac-address&quo=
t;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0phy-handle =3D &lt;&amp;ethphy0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0phy-mode =3D &quot;rgmii-id&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pinctrl-0 =3D &lt;&amp;pinctrl_rgmii1_defa=
ult&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pinctrl-names =3D &quot;default&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;mdio0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ethphy0: ethernet-phy@0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D=
 &quot;ethernet-phy-ieee802.3-c22&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0&=
gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;uart5 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; --<br>
&gt; 2.47.3<br>
&gt;<br>
<br>
</blockquote></div>

--000000000000c34f0c065eb6d71d--

