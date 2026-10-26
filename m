Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6BB606A31A
	for <linux-aspeed@archiver.kernel.org>; Mon, 26 Oct 2026 03:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V3i80cH7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCfQF7198z2yK7;
	Mon, 26 Oct 2026 14:35:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::112e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792985701;
	cv=pass; b=Jxgog/zMEq08hNdbeB9D6YSHdqUckkPmK63EzV3VWzJ9tY2wz+2sBu95QLQhzBU0uToFt8STvJDiDJqIIxZm5NDRCl3zk39o/O6AYTZG5hRymTOVZuNo0WQzD3Sjy9UTssPhXkHtyxzD5sGZIfba0bbMZR0CJFjEFOTcG5/RXmUkl7N98xDPUmcG5BLLKnehx82eWp7vV3awXGtAZmO44+uFNEyBdsxF0evP9XUN7LZGU2YSA2DLUcCvgKlhG4CCok/hxRPQicZ/cBtHeFXeFY/HGIIkaYYI0/uJk8IX6m3Z6W3pmYtogHV+v01HmFymw2Cu5Kf4K9UGUprG38gfVg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792985701; c=relaxed/relaxed;
	bh=qvFzouQF9MYPvoxr1/BdmBibADJU3LaIGGor9Gt6xfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEvCdoA4EgJ0XKLVP4tokGJMX0G4//pliC8trBbxuPqy1xowDwHpixufVuZwr/bpNIudjrHFRgddzEWavd8Rp/O34Gn+DQcU/0XNV71QFZ6jZK4tTDJmPTDUIVSSo4xNiAhXbbg8PcbvuxP0GrXUlNIBNeBCJwDoK2BAKLE8VWH9sjbPYhVlQzu7myhgKVeQcjx10LnJEl1i+QeSTL0GAUrW2dsg9NoSZNRWQZM92lV4TnVkv2AKH3hDwFUF2mD5QnRT359zifNGd+JV+y+8iiif0bWHHSaAvzQmZXAt3UHPPsNbz8WB/1k0IOWnHwcobIyqw9nBnW22TGSwCA0giw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V3i80cH7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V3i80cH7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCfQC2kcSz2xsW
	for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Oct 2026 14:34:58 +1100 (AEDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-8b125371596so25124307b3.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 25 Oct 2026 20:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792985695; cv=none;
        d=google.com; s=arc-20260327;
        b=TWLgOMOMfayRz4QUxtXjO7vpfGNB8hog5FuPPFi305Im3HnEjXZf0Anx+4fpw2uCGM
         AWe1sy53LV1ViWV428ONdCILb6LE3EvtWInMhEWsPuV02IAl3/3jZqOIKIB1TeRz1YsP
         00zps6TLLmi0G2TJSGlJ3wAFT3KnInUjOJQxzHX1B+iRNxAX4UQ9HVgXej2uKx6CebFD
         ISyDBTzE/ChwbNgrf/et8KJYCJgIepX8eiMsTush9Ko5qbrmjQa29dCvRW4FacqVoOGD
         8ue2I8ouf6CrYgIiunnYa15a3nc2aadJFF2uyTiJDOp6M0zejA356jd2lNtrmCd6w1oT
         AnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qvFzouQF9MYPvoxr1/BdmBibADJU3LaIGGor9Gt6xfo=;
        fh=DUgbEvoD/8Mo0CsNrSWjNEN5aSFFMsFBgSH1pHwajYs=;
        b=FLYHo109LBFB6/qDs2lASVpaTmNP4//oNHNTW6afi39Ne21bi7RFVCGVzzgikCzxeS
         jK678QW7mEqcS/vWv6/smLXsL743gCtDFQSBouR9+wfZmiQcemb9oeqKssn81Cvd8EX4
         i8fEiOq76xLX40woketsXONvtCpvqNCaWOg+Av1mAP+RBFa+IWpCIgHdLCsCD8DNxSOs
         Ui2NZHC7moz/Nn0PpKUsurew2l1u6XbRmGJsJ8/5ecKi3BkNvPYSYWf69DLoqfPbSCYs
         9v8YrN1wBJM7eTIcJnAG4tKgKTKMnHra3mAe3k0KBCV1HoX/JB/ye3QO3eTOiWobsTAq
         naOQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792985695; x=1793590495; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qvFzouQF9MYPvoxr1/BdmBibADJU3LaIGGor9Gt6xfo=;
        b=V3i80cH7SwY9QbHTjE3z494z8zCHp4vwx1od/WVXziGHbYiUMCOpHWmmJx6g1Ex7M4
         xdO3eom3dO5cprGXxQvh+blRZctufPWsZ7UTX89MO5qZk4PuwmvVAbjtJLqfUShPEVe9
         7znBygVB9b1CJ62b/F49gH2RmsjOuhpInCNcf7Y9Z0mK0LnlZBZF08I7uckzcBKMzn/C
         AYZvwbRkmBFLV4n0qXixqPP/GC8GFl0nberKrrFWJ4pkbcKur4XV4oAEHFc01M+SOXV3
         rn7De6dikKdE7c7fMT+alPTwf4hA49Ibbth9z2csAgm/t30A6R7tSfZ5YVe2L9UauwmU
         F7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792985695; x=1793590495;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qvFzouQF9MYPvoxr1/BdmBibADJU3LaIGGor9Gt6xfo=;
        b=hSkXqu0UJCvXkGFazZapeLKRJAg4CT2wMjKOQg1TKLv/X2mCBNvTevrzEMqOEId29P
         pNYnbbgLXIkIQl66NRx6ja2kiJO0vc1sZmO0JDbRf8x9wTVSPOmaFf2vcXobzPmLtSKG
         nIHmmYDAnL/p5PIS3CYDO5AcYG57xKPoyDhdil5eOXNwN1IgLuTDFRrC9/BKa0M/CaFC
         WeQHOZq6ERjApvD2mBSVfJs79mvm+vpkU+zJLlEv9ZSpDRXWuWAT7P4WBuVjokeavbLm
         3NBV3OpTd5d8s1SR0CChfC9L5JVKDBkmzKAT8KBW4Ox2+RKjbKvLUR7xKmd7tULZRv2+
         D7gw==
X-Forwarded-Encrypted: i=1; AKwUvBxO7YLpN1azNdjnQxPu2OgGaeg17ccJrW3oUJXTTo76LSKppN/G3M+jofDRZdRIZ8BrtFapfUVA6yKXTT0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIX9+nKNmFs6JBC0H9IB0QNFCbxegxUX4egkl1xhryFHGEbSfB2
	SKRFs0sU+k5xL7CY+BM8KgsgVsGbzE/8SVgI0Nkc/we0ePX76FMFpLBgZJMxue0IUl5szPp72k5
	YvwJXG2sTjkOcfIeeWPwEvXlUq1aZXn0=
X-Gm-Gg: AYBFou1yRVESyXd86L+BCTAskaXz+UgUrLh6/G/q+HTKq+Zgf5edHQEEOlxUtxXFC1a
	QyY5Gl9nj0Lk1IuVsidLiKefMJw0f7Nuae+G8fpKE6qjK7uQMMSa/nls0QWSYXvLfPUOctujFq4
	IzZcs24fpYOhv0hQl/Z2VNhsjkmHvrLucMru9AmnIoe0ijEODU3gJHvtD7eKM+yIkjXtgkmc0sr
	FJREFG/100Nw25uI6p+ZBerlcoLIUOU+xK6rYHw+jLUR6mpn90HLl5zRMjap/JyLpPUqHySvnaz
	DWZtS9jHgFipEi0NEJUE/W2huUqSk+kV0+lUp94/qOtwV8qEUQ/OMx37JUABBujzpID1g2CXqYp
	bXFFxa4MWcBsTzQgsuztlql2XuWdz4Jy0fb7D
X-Received: by 2002:a05:690c:e3cc:b0:8b0:56e6:54ff with SMTP id
 00721157ae682-8b1671e0cb1mr39578197b3.6.1792985695228; Sun, 25 Oct 2026
 20:34:55 -0700 (PDT)
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
References: <20261002062933.26497-1-prasanth.padarthi10@gmail.com> <20261002062933.26497-3-prasanth.padarthi10@gmail.com>
In-Reply-To: <20261002062933.26497-3-prasanth.padarthi10@gmail.com>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Mon, 26 Oct 2026 09:04:44 +0530
X-Gm-Features: AclHuK9g2QPyjNGvOYOKw3ICZuN5ZkwaHqbNNAHIXI0yRtldeEML3mZWQVHrKk0
Message-ID: <CAMFFDGjmJTRR8GOX=S+kKnMA-bG+gbZP0sS8dG_d+taDPPRDZQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au, 
	andrew@codeconstruct.com.au, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,WEIRD_QUOTING autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

A gentle follow-up on the B650D4U BMC device-tree series posted on October =
2.

Could you please let me know whether any further changes or validation
are needed before this series can be picked up?

Thanks,
Prasanth

On Fri, Oct 2, 2026 at 11:59=E2=80=AFAM Prasanth Kumar Padarthi
<prasanth.padarthi10@gmail.com> wrote:
>
> Add the device tree for the ASRock Rack B650D4U BMC, which is
> based on the ASPEED AST2600 SoC.
>
> Describe the BMC memory, SPI NOR flash layout, UART console,
> GPIO line names, video framebuffer memory, I2C EEPROM, and MAC0
> connected to an RTL8211F Ethernet PHY.
>
> Use the EEPROM on I2C7 as the NVMEM provider for the MAC0 address.
>
> Configure MAC0 to use the RTL8211F in RGMII-ID mode.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch> # MAC0 and MDIO nodes only
> Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 135 ++++++++++++++++++
>  2 files changed, 136 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dt=
s
>
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed=
/Makefile
> index 6b68671f9379..b109491d5c8f 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
>         aspeed-bmc-ampere-mtmitchell.dtb \
>         aspeed-bmc-arm-stardragon4800-rep2.dtb \
>         aspeed-bmc-asrock-altrad8.dtb \
> +       aspeed-bmc-asrock-b650d4u.dtb \
>         aspeed-bmc-asrock-e3c246d4i.dtb \
>         aspeed-bmc-asrock-e3c256d4i.dtb \
>         aspeed-bmc-asrock-paul-ipmi-card.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts b/arc=
h/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> new file mode 100644
> index 000000000000..a4e384588a54
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +
> +/ {
> +       compatible =3D "asrock,b650d4u-bmc", "aspeed,ast2600";
> +       model =3D "ASRock Rack B650D4U BMC";
> +
> +       aliases {
> +               serial0 =3D &uart5;
> +       };
> +
> +       chosen {
> +               stdout-path =3D "serial0:115200n8";
> +       };
> +
> +       memory@80000000 {
> +               device_type =3D "memory";
> +               reg =3D <0x80000000 0x20000000>;
> +       };
> +
> +       reserved-memory {
> +               ranges;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +
> +               gfx_memory: framebuffer {
> +                       compatible =3D "shared-dma-pool";
> +                       alignment =3D <0x01000000>;
> +                       reusable;
> +                       size =3D <0x01000000>;
> +               };
> +       };
> +};
> +
> +&fmc {
> +       status =3D "okay";
> +
> +       flash@0 {
> +               compatible =3D "jedec,spi-nor";
> +               reg =3D <0>;
> +               label =3D "bmc";
> +               spi-max-frequency =3D <50000000>;
> +               spi-rx-bus-width =3D <4>;
> +               m25p,fast-read;
> +
> +               status =3D "okay";
> +
> +#include "openbmc-flash-layout-64.dtsi"
> +       };
> +};
> +
> +&gfx {
> +       memory-region =3D <&gfx_memory>;
> +
> +       status =3D "okay";
> +};
> +
> +&gpio0 {
> +       gpio-line-names =3D
> +               /* A0-A7 */     "","","","","","","","",
> +               /* B0-B7 */     "","","","","","","","",
> +               /* C0-C7 */     "","","","","","","","",
> +               /* D0-D7 */     "","","","","","","","",
> +               /* E0-E7 */     "","","","","","","","",
> +               /* F0-F7 */     "","","","","","","","",
> +               /* G0-G7 */     "","","","","","","","",
> +               /* H0-H7 */     "","","","","","","","",
> +               /* I0-I7 */     "","","","","","","","",
> +               /* J0-J7 */     "","","","","","","","",
> +               /* K0-K7 */     "","","","","","","","",
> +               /* L0-L7 */     "","","","","","","","",
> +               /* M0-M7 */     "","","","","","","","",
> +               /* N0-N7 */     "","","","","","","","",
> +               /* O0-O7 */     "","","","","","","","",
> +               /* P0-P7 */     "button-reset-n","control-reset-n",
> +               "button-power-n","control-power-n",
> +               "button-nmi-n","control-nmi-n",
> +               "","",
> +               /* Q0-Q7 */     "","","","","","","","",
> +               /* R0-R7 */     "","","","","","","","",
> +               /* S0-S7 */     "","","","","","","","",
> +               /* T0-T7 */     "","","","","","","","",
> +               /* U0-U7 */     "","","","","","","","",
> +               /* V0-V7 */     "","","","","","","","",
> +               /* W0-W7 */     "","","","","","","","",
> +               /* X0-X7 */     "","","","","","","","",
> +               /* Y0-Y7 */     "","","","","","","","",
> +               /* Z0-Z7 */     "","","","","","","","";
> +};
> +
> +&i2c7 {
> +       status =3D "okay";
> +
> +       eeprom@57 {
> +               compatible =3D "atmel,24c128";
> +               reg =3D <0x57>;
> +               pagesize =3D <16>;
> +
> +               nvmem-layout {
> +                       compatible =3D "fixed-layout";
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +
> +                       eth0_macaddress: macaddress@3f80 {
> +                               reg =3D <0x3f80 6>;
> +                       };
> +               };
> +       };
> +};
> +
> +&mac0 {
> +       nvmem-cells =3D <&eth0_macaddress>;
> +       nvmem-cell-names =3D "mac-address";
> +       phy-handle =3D <&ethphy0>;
> +       phy-mode =3D "rgmii-id";
> +       pinctrl-0 =3D <&pinctrl_rgmii1_default>;
> +       pinctrl-names =3D "default";
> +
> +       status =3D "okay";
> +};
> +
> +&mdio0 {
> +       status =3D "okay";
> +
> +       ethphy0: ethernet-phy@0 {
> +               compatible =3D "ethernet-phy-ieee802.3-c22";
> +               reg =3D <0>;
> +       };
> +};
> +
> +&uart5 {
> +       status =3D "okay";
> +};
> --
> 2.47.3
>

