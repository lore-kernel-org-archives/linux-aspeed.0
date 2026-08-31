Return-Path: <linux-aspeed+bounces-4888-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CF4C61DD3
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 00:04:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYmM06MDRz2yCv;
	Tue, 01 Sep 2026 10:04:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::630" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788180445;
	cv=pass; b=TmA88tVQja52GlqGqN1T053pCEMa97hbHvUFDhh9lOWXaWDeEGGX33nKHo+KfiK/SOB4HOd3VQZwoGQbhnpqs1byzJ7fApVzsvThG5VILiyzQP6Zvk35ZA4KbkUIxgaNke8UQ/LkMFQNLQIA7Ee0Uqkm60zmiuSakSjzW5yEhLZn72+yYW6ZYGEDKHaBPD2Xhvj2NJgU5rXEV6CuxA0fxwL4Gplf48kLYeSZjV4Ad4q1CJ5q3SDACisEjR3eBwAjwXswMse4q8WaCZ9BTAM8n3NHlpRAAmBy/3srVCNJ3oxDYityLbSR/YN1sbGX9dJK5XFmjmU7JQzhXQn6iu+TbA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788180445; c=relaxed/relaxed;
	bh=zLqTvy52sKSUUsDTZl72qNN+V6zjfC7RltS1uqqFZgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiUy2rlnmzqYdDj1ZzioMtQMOMlTtgPIdUlFgm3tryYkbiCUehyVKN20IB/cOhmxac1niM7hhuiqMnTQ+KYT8/KKQe3/5zhNjbR7BELXmbGVyGzJoXtRLd2NDlLH4IW/cvCgWEJ5/7ZG22gANIiFv/yfyp3w6I7Y48KqxBxllzJ5FN7qJNQsHrsZYcMqy3xBVJsaBC4JNoyNMYHSis54OOdHCjY0mGPlKKnCOwmqQ6/cDNjdWIsj58yqrsAxyN1BMYkI2dGrj6Go7TtIDJDhdOIZKIy71hw327Sj//AsJxoh0LoRc8SHD6jTXdZg8QwN8M0YibqU3WpC9VeD0CcNrQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nPKJi3qh; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nPKJi3qh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYTKS0qXYz2xLf
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 22:47:23 +1000 (AEST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-c207cb16cf5so557265666b.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 05:47:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788180435; cv=none;
        d=google.com; s=arc-20260327;
        b=ggCWmtxOpueF5kKOZdFwSrD4vD+VZGBXBL9nWJ+2nyuWjGxzLtyYsVK5Cq4ZYFtKYW
         liMUM+jiiYSdqoYt6eX9oKkEv1RSYwTZ9eXeqtFU9zPxZv58iBlni4tIbbcMExSDUjf6
         1A5/pJ4bZ+/AzQf3AtIFOtv4G/LocBfIJzYefz7m8KysRg0F8rEbv9e2m9ae7vABl+qK
         Kyv+jAzMZGTIIhh4E6J+KZTIqj7T0jKvQTTQtFEdi+fy27javcv2/1WrNJ44DlimD/wU
         uEJGxohbys4YjekoC4qF4+xB2mGa8JJbAZyFfY+rIVZlMN0fQnetXQhqUUbmxpJJ17HN
         5cgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zLqTvy52sKSUUsDTZl72qNN+V6zjfC7RltS1uqqFZgU=;
        fh=5GGxZ0gjcaRJHOK2EqLMR0tOUrMzWkfVwC5ZY3CkQrQ=;
        b=pvnPlHyOnhlxbbHr/mIvQI8PILDQjCxiY57/2JIE3UBZH054QrR3wjfePShuxv3ctT
         tXdJAEv+zwKSvjbLzQFLBHdK7AsCcklHV0VsSSD6ltoNy6/AM4pZCFusc55WbCobICB5
         azwsVhfiqJz+qqjB3kx/zIUq8AeY8hlAUU6XIecL/GzVDTd0b4ERjkg11dAgEn6lbV0g
         W26puTEJmk0oC8Vg5zhW944Hxf+IIAbvlhmGGAwDTPYIeKwwdNT+tyBaX7HN1z/04puN
         yu0P/Fo4tEKGch2+6bXBS+Ic//JilSyQ6x3HOMNVsZVINni07cBuJjox9cIIAtIc7Wpz
         zmXw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788180435; x=1788785235; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zLqTvy52sKSUUsDTZl72qNN+V6zjfC7RltS1uqqFZgU=;
        b=nPKJi3qhS6PR3Ebx/3NAOshJeeqMNU9g4OW8tOUq3EWc4aXvYDeW+/sX7ku9yVbagE
         vW21amY5FJ/7KiYLEkfu3gbTYoD3+QfHtSpLIEtDzuxd2u5qckjCqujAGL61uWJwYMgz
         LI12quIs/aQIafhj20Kq9mhInih4Tw7bJPcLPO/Vmt094KwW5yl2O5D/8cY+RGvesTHS
         yVC8ybrtOnDsgjRf++xahVM+J9XP53IfF/1/5AcIB1g0QbOMP6ZOW8QLf1MOsUWXdDc4
         8mM5CgLXy56H5uCARABSmmHq25/pHOF39vpqH/id/yNpUBERpcilyovvn/Rg2z+m9r6j
         JvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788180435; x=1788785235;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zLqTvy52sKSUUsDTZl72qNN+V6zjfC7RltS1uqqFZgU=;
        b=Xnsz2qvkDgjjo9rkKbepfiDT4T7aitUmTAUmznTk4geKiq4P33hgwoFbXGzFYVNctX
         w0ysJECGkTh/oQpljTGoyp+wCCdJ0kBypWXYu49ER9v9kxDAzYbk7+lfB/4WmyMHTUrt
         286pgHQhq0wkI7KOTcjQTAFFxAkmcp2YSBIStKVQgDrQ904IripaoLgYf+IBJP9KFb88
         zrljfkHr3wgFUzs5DanovhG4xU/abHlgo/jzji/PbmaaA3mmCiaYbxj6epKNGZQ3z//w
         iNiueCqTVydVx4JvzFCS7CYskCb3no2mBcqBuKnEN0IyKLvxd0GDgjxINAPzb+3QyEDW
         KbYA==
X-Forwarded-Encrypted: i=1; AHgh+RrvR61Lx8s/SblNSXafqHma2zdr6m4tFOlxzdUyqS4YW/TdskMhhmlwdnRF1nMEgHq03TpG9dY4F1SkBYw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l/lNxFl61I6Nyb1uY5b4Q7NmpynOMJDehyBT0P+lMi0kyxj57v
	YpFDIOjra7qKHv36NGLEmybzs8GPTCcGe6PBQWr+KAJWf/hxohh7BHA08FAji3J5hxhW3AqKTmy
	TW2iH4OoCGJJmaLqkAmsC1pCf9sRW1aQ=
X-Gm-Gg: AR+sD10P9neoavd+QOGHpJeSB23IXHtJj459Q3uMcmzXrXLJSjwtdljpDV9LYJXkkX0
	C3gTvRZfFTU+E3JazDTidpAiT0FvlQ7fOUbX2RPqDrs8FZA9js6aCRPgHR0OuTNF3glDtxitTce
	V0lEpASnqRxMI+QT6Fq9w7uM/6nH9J+DFJY+1swpFoue2w/5zO6BSfrFDsWIBWehW6AOc/Cqc2h
	X8N3o9oamwTsidHQPoK1iBMLeZ8HUWMQvvmfcX2qegpw9wPlByo8OY0dV03Xc0pbHpDSMt0tpBm
	LcQm04SevCwocuPDVXxMllYH/P7r1JjpObappK5nWcs2/A==
X-Received: by 2002:a17:906:6444:b0:c16:101d:7afa with SMTP id
 a640c23a62f3a-c25b3cde78emr15785266b.16.1788180435211; Mon, 31 Aug 2026
 05:47:15 -0700 (PDT)
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
 <20260830182036.284736-3-prasanth.padarthi10@gmail.com> <178817979463.20922.10263529532171804189.b4-review@b4>
In-Reply-To: <178817979463.20922.10263529532171804189.b4-review@b4>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Mon, 31 Aug 2026 18:17:02 +0530
X-Gm-Features: AcwNN1XIrIC7I6xOS5BaNQ3PLnAnWSJKPgHogQbkIGatLAVm1UY68sNUIGJAplc
Message-ID: <CAMFFDGi5eb_+ec5hGz6nE7OXpqYTMg7oZSPAzttXDPZJZw8v2Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
To: Tan Siewert <tan.siewert@9elements.com>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tan,

Thanks, this is very helpful, especially since you have tested the same boa=
rd.

I will rework the next revision to use the existing ASRock Rack DTS
patterns, including the I2C7 EEPROM/NVMEM MAC address handling and the
standard 64 MiB OpenBMC flash layout. I will also investigate the
GPIOs and video memory reservation you mentioned.

For MAC0, I will change the PHY mode to rgmii-id and remove the claim
that the board requires RX-only PHY delay. I will also investigate the
ASPEED SoC-specific MAC delay configuration and the difference between
upstream U-Boot and openbmc/u-boot before sending the next revision.

Thanks,
Prasanth

On Mon, Aug 31, 2026 at 6:07=E2=80=AFPM Tan Siewert <tan.siewert@9elements.=
com> wrote:
>
> Hi Prasanth,
>
> On 8/30/26 8:20 PM, Prasanth Kumar Padarthi wrote:
> > Add the device tree for the ASRock Rack B650D4U BMC, which is
> > based on the ASPEED AST2600 SoC.
> >
> > Describe the BMC memory, SPI NOR flash layout, UART console, and
> > MAC0 connected to an RTL8211F Ethernet PHY.
>
> Why no GPIOs? Why no I2C buses? You'd need at least i2c7 with an at24c128=
 to
> populate the MAC address on MAC0.
>
> >
> > The MAC0 RGMII RX delay configuration was validated on hardware.
> > The RTL8211F requires its internal RX delay for reliable operation,
> > while an additional TX delay is not required.
>
> No, it does not. The traces have the same length and don't require specia=
l
> delays. If you use u-boot/next, then it might be true because it still mi=
sses
> the correct SoC-specific delays. This is, however, fixed in openbmc/u-boo=
t.
>
> I know that this is not optimal. I'm already working on getting this fixe=
d in
> upstream U-Boot too.
>
> >
> > Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
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
> > index 000000000000..aa623f0ca36c
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> > @@ -0,0 +1,95 @@
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
>
> Where's the reservation for video?
>
> > +};
> > +
> > +&fmc {
> > +     status =3D "okay";
> > +
> > +     flash@0 {
> > +             compatible =3D "jedec,spi-nor";
> > +             reg =3D <0>;
>
> That's already defined in aspeed-g6.dtsi
>
> > +             label =3D "bmc";
> > +             m25p,fast-read;
> > +             spi-max-frequency =3D <50000000>;
> > +             spi-rx-bus-width =3D <4>;
> > +             status =3D "okay";
> > +
> > +             partitions {
> > +                     compatible =3D "fixed-partitions";
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +
> > +                     u-boot@0 {
> > +                             reg =3D <0x00000000 0x000e0000>;
> > +                             label =3D "u-boot";
> > +                             read-only;
> > +                     };
> > +
> > +                     u-boot-env@e0000 {
> > +                             reg =3D <0x000e0000 0x00020000>;
> > +                             label =3D "u-boot-env";
> > +                     };
> > +
> > +                     kernel@200000 {
> > +                             reg =3D <0x00200000 0x00800000>;
> > +                             label =3D "kernel";
> > +                     };
> > +
> > +                     rofs@a00000 {
> > +                             reg =3D <0x00a00000 0x02000000>;
> > +                             label =3D "rofs";
> > +                             read-only;
> > +                     };
> > +
> > +                     rwfs@2a00000 {
> > +                             reg =3D <0x02a00000 0x01600000>;
> > +                             label =3D "rwfs";
> > +                     };
>
> No. Include the partitions via `#include openbmc-flash-layout-64.dtsi`.
>
> > +             };
> > +     };
> > +};
> > +
> > +&mac0 {
> > +     status =3D "okay";
> > +
> > +     /*
> > +      * The RTL8211F provides the required RGMII RX delay. No addition=
al
> > +      * TX delay is required for this board.
> > +      */
>
> No? I do have this board myself with a custom BMC ROM and I can tell you =
that
> you don't have to set delays other than the described SoC-specific delays=
, but
> this is, as mentioned, already done in the BSP. (And no, I haven't upstre=
amed
> my DTS yet bc I haven't had the time to do it.)
>
> > +     phy-mode =3D "rgmii-rxid";
>
> `rgmii-id`
>
> > +     phy-handle =3D <&ethphy0>;
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_rgmii1_default>;
>
> No nvmem cell to set the MAC address? i2c7@57 offset 0x3f80? Please see t=
he
> other device-trees for ASRock Rack mainboards.
>
> For me, it is a:
>
> NACKed-by: Tan Siewert <tan.siewert@9elements.com>
>
> Tan
>
> --
> Tan Siewert <tan.siewert@9elements.com>

