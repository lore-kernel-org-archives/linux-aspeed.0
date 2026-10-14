Return-Path: <linux-aspeed+bounces-5202-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CBACC6B38
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 04:33:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5X844d7sz3bwk;
	Fri, 16 Oct 2026 15:31:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b136" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791970204;
	cv=pass; b=ev7v0+UDR9l6O90bqAxYQzcJi8UcroVLZfNu5mmGDiibsxRq961+6qgv1wTi0o/JG15EZLuNMZ+UzYhTjzHQOhRFctQzLhjYTDVPxoqmi4qaL1aUb9UofE2nxO2znlL/78xRoZmbmgQp+XLbCKW0I23L4+lY8ZZtksCMcc2hUQ93TfizhvCD4tnQr3wxCvKv1XwIaRAGnCrg5lUgUt/JhBmtmxTvWTBx6W07X6RxMVQf8p2uoaKIc7aIpwZGBF1Acj4omAawjtE7e2+Di4qqSuE1F8uEmG/ltn9mf+qgLeT7MdDZ30m7OVNpghY5AyCk/KfrGmi7IxJaN4YuOJdLHw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791970204; c=relaxed/relaxed;
	bh=pMwu/+dLKz/hELXQ8G9suR4fEQW92masMZdt6u+igOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHF/4GDY8bfoRWmGxQM9CCDSVnmEJGJj4n8Q5enokPhsfVkG4AWq1nCiSGWmLBIwKe/Cn5joOd2xjYGsOi9ZWBSBpX5NaOqfZnKYoMD6fSLB1aacxDDyPgccz3WZ6k4zb3/6pj6ueMLDz9iI1eGPX0oh4EOmkKlZrPOL1EPulFI5LtP+jMe+8/Z+sfID/sZZsuZJRVFJbzwD9CLQi6Z348p/URYJWCDRksv7CrU8GAY3E6RCWIEGZThg3+gm9AAdXUpbyGttULh4F5BOf7wsjPSMxEfgEjtlKlYhhaLzdqEZhJUiJblvtgwELu1xcpeTvx2uygsPJL+KQcfuLrNeVw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HvUKUgHp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HvUKUgHp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com [IPv6:2607:f8b0:4864:20::b136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4QsP2t7Hz2xwM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 20:29:59 +1100 (AEDT)
Received: by mail-yx1-xb136.google.com with SMTP id 956f58d0204a3-677bc4704cbso3533699d50.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 02:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791970197; cv=none;
        d=google.com; s=arc-20260327;
        b=DlMFqNd1kPE4WD9zelx6omm3gMvmgG22H9bkIVyv5boWqG/727eNttIDYGFsSDr/gT
         84wPLTTMeRP2IHkTwRRz2WcFL69pBElvyuyLTw2PrGJx/dmBWBozp3nqyBGkrHOSPaGI
         s/irLF7xr17bjUOr+usfjD5eoFjXhgmfzEqgDBRwJbbbMGv93rgjlMD17YS0KOm4qzcf
         IkEJnKtTGR48meSBquG+xv9ocLDP0HYKy5soelgL7MAb8MTcsiiFCu+nTrJemqTbwSdJ
         48P6TCdCK+v6dmzzJPiXEzMVuL06SPa37uhxAXRTs7jrz+7jdX3Ej5pYORwhtLtnhYPH
         76bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pMwu/+dLKz/hELXQ8G9suR4fEQW92masMZdt6u+igOk=;
        fh=SgtSRNpHh8ZiTsdbGXRjxMfWCI6c02hdGtpahYfN3e0=;
        b=I9Yyu4yZlS0VAxazgq3p2PTjLtCo1WSsUraC4vaA7b/EDy+5svQexRY0l3ndY2LhTW
         aTZwipFX4wDldLE9nS3Gm87DUh+zou52R/ITQ5w2Sx2YwatvG/dGUpwypYdVPasEBW8N
         KScVQWQo0YYPAZ4h2qiBJsFh+8PkHMJmZqYWWMYeIq2LDfEjjUQNEDFKw2Dg12You74c
         R0svngvsX9QRCJpi1c75mY1s9B/9Lu6sakx0N8vh83Mmw1ajzRrdl7l5AKGcY+G5OmaD
         MO91/Sv25A5PubdAtfjZjvd9nsO2BNvCFv7oXb3YOSA2ffWQvxqZ63ka+UZu7h/B939D
         7sAg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791970197; x=1792574997; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pMwu/+dLKz/hELXQ8G9suR4fEQW92masMZdt6u+igOk=;
        b=HvUKUgHptA1CIckQ6AKRzlPzSuF7+mi5NNz4qYSp5bICYYKyPgxcRUX+rtEeiDdyWG
         Ju/EJT30S4FYbgxGPeepTb5Diyu907925pmcL1u/O1FP41Yqnoa7BEriElUBfV/riUKE
         dUJo2T/8xzirMn9SCMY0xF+jbfPmXCJYudEEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970197; x=1792574997;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pMwu/+dLKz/hELXQ8G9suR4fEQW92masMZdt6u+igOk=;
        b=PENgAQzktKaZfkyA/IaiRC0xVOqCmekiKuZ2VJz1CJTIZ/1mTtHpIpvO5jo+W075WI
         sh/kUvkgE4nGYYoLu6Kfkh6gt64hTS30a15eI0sdQ1MWwyfN+SyK3XWmEzHiZm+V4Rsf
         tDwj0Zd10L6uptV5IpkaxnTsxAGgI5MlXELKpmwdTzzBoZQjcn4Hz+5skxWH+OCXHIzn
         AtkwElG5+H0Ufhpgzz7wy5gSKR1vEawdwu+T4TENoVpZCqzvK4U63mZ9T3OfWFv9dtyL
         gNZmoMmJPzZ1YQsT868wF2mGWmU2HUFKIGhWIDAUDEygbpfR8UWJBo6AUCnP4GkT5Au6
         GloQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPwCkwGhtqixBG+vB9ov/zvKfv5zmkNx+0SKNvDwFJ0YudWG74ZEYsyoSc/l1uG7HSvcL7C74OdrHA2Wk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIHfI/7J7TZr84z9BmOGPY6n9exg9e+gXOtrN+63HARf8H+6r0q
	tCy98UvR0ww9pRLQECrDbcrTIdp6D7ghgDU6lsskf2dp2WzumRyUTVjAR5RmRs0UE1g6Yvdm7G8
	gIvEk1ZePimxn7nT9HdqIjQsplRnqnaPEZXe48W0P
X-Gm-Gg: AYBFou0U4+VFAlEjLhPfv9uhJJB3DgjvvMJIrRZf2KeZcK8JQbSwrEdWhND7y7BI6EE
	TZy9hr9zlNvvJ9oblM+JeohYxlGnfc3Zb1KYxBilcwxkgNym3W6Ot6SM4lt/pB0xrPBeIlTP8hD
	6LaF82xB109xrVXQhiOO791WaNJMSv6E81t4ocmIEVOfutYvjQdvH4Kq6BE5g4n5fxwLBQSHGXx
	m6dfoT6Q+dqqvGncOZ7i5mOk6Q5o58ENQXO8cpQ/GMQS3HXzN+O+FBtwXj0DOk07TaFk5OPlqpv
	VMq2al613ggBELLwPCf5+RE3aWdf4sbNQV/8vVbwvqlnrm57lNIAKPwTyzzjOhyoD74=
X-Received: by 2002:a05:690e:1094:10b0:677:d106:6f97 with SMTP id
 956f58d0204a3-679363475c0mr3180487d50.152.1791970197053; Wed, 14 Oct 2026
 02:29:57 -0700 (PDT)
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
References: <20261014082037.1774672-1-wenst@chromium.org> <20261014082037.1774672-3-wenst@chromium.org>
 <7020a7a6-332e-4fd0-a659-d82eb768614c@linaro.org>
In-Reply-To: <7020a7a6-332e-4fd0-a659-d82eb768614c@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 14 Oct 2026 18:29:46 +0900
X-Gm-Features: AclHuK9N2qPZVqRIKj3AC2e-RNgLBJ_oiV-FNmg6s8RgvBJGg_msVeXPasEPdno
Message-ID: <CAGXv+5G1kgyumbj7wGf6rPFbg3spSO0zYmEkn-hZT4qUdJbytA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: usb: snps,dwc3: Fix downstream port numbering
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Sven Peter <sven@kernel.org>, 
	Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Michal Simek <michal.simek@amd.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Troy Mitchell <troy.mitchell@linux.spacemit.com>, Minda Chen <minda.chen@starfivetech.com>, 
	Shyam Pandey <radhey.shyam.pandey@amd.com>, Wei Yang <yangwei1@eswincomputing.com>, 
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>, Hang Cao <caohang@eswincomputing.com>, 
	Li Jun <jun.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, Roy Luo <royluo@google.com>, 
	Yang Xiwen <forbidden405@foxmail.com>, 
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, 
	Robert Marko <robert.marko@sartura.hr>, Xu Yang <xu.yang_2@nxp.com>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Stanley Chang <stanley_chang@realtek.com>, 
	Ze Huang <huang.ze@linux.dev>, Aswath Govindraju <a-govindraju@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-aspeed@lists.ozlabs.org, imx@lists.linux.dev, 
	linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 5:28=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 10/14/26 10:20, Chen-Yu Tsai wrote:
> > The DWC3 controller can operate in host mode. It does so with a XHCI
> > compliant host controller. The XHCI has two downstream ports, one for
> > HS and one for SS. USB downstream ports start from 1, not 0.
>
> Is there something in index 0 we will need to define at some point ?

On the host side, no. Downstream ports start at 1.

On the device mode side, I believe the numbers are completely made up.

> Using 0 as base for numbering in DT isn't incompatible with the USB
> spec using base 1 for numbering,

But you end up with diverging numbering schemes, and it diverges
from other USB controllers, particularly XHCI, which DWC3 embeds.

And it also differs from the numbering currently used for directly
connected onboard devices (like hubs), which use or expect the USB
numbering scheme.

Sure we can make DWC3 "special", drop inclusion of usb-hcd.yaml,
and duplicate the section for onboard devices. On Linux, we can
add some more code to xhci_find_raw_port_number() to make an
exception for DWC3 controllers.

Also, usb_of_get_connect_type() is already broken for DWC3 based
controllers that only describe the HS connection but not the SS
connection. usb_of_get_connect_type() currently doesn't call
usb_hcd_find_raw_port_number() so both HS and SS get mapped to port 1,
which wouldn't be in the DT since HS is currently port@0. But even if
it did, SS would get mapped to port 2 anyway.


IMHO having consistent numbering across controller types would be
better. This avoids making the USB core and hub code deal with more
exceptions, and also easier to understand and write device trees.

> > Reconcile the downstream port numbering with the common USB host
> > binding, renumbering the downstream port numbers from 0 and 1 to
> > 1 and 2.
> >
> > This is non-backwards compatible, however it won't break current
> > major implementations:
> >
> > - dwc3 "gadget mode" in Linux kernel only requires a connection to be
> >    present; it doesn't matter which port it is
> >    - dwc3 "host mode" OF graph connections aren't supported yet [1]
> > - FreeBSD doesn't use the OF graph for anything
> > - U-boot doesn't use the OF graph for USB
> > - OpenBSD doesn't support dwc3, only the XHCI in dwc3, and doesn't use
> >    the OF graph for USB
> > - coreboot doesn't use the OF graph for anything
> > - Zephyr doesn't support dwc3
> > - TF-A doesn't use the OF graph for anything
> > - EDK2 doesn't support dwc3 and doesn't support OF graph
> > - OP-TEE doesn't support dwc3 and doesn't support OF graph
> >
> > [1] WIP to tie OF graph port node to USB port device
> >
> > Fixes: a33113f73693 ("dt-bindings: usb: snps,dwc3: document HS & SS OF =
graph ports")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > It is unclear to me whether the HS/SS numbering is fixed for all dwc3
> > variants. I checked Allwinner H616 and Rockchip RK3588 and they both
> > have HS as port 1 and SS as port 2.
> >
> > This also doesn't cover a potential "multi-port" DWC3 implementation,
> > which Qualcomm seems to have.
>
> It breaks the current Qualcomm numbering on numerous boards.

Yes. It breaks _everyone_ using the current numbering in the sense that
they are no longer valid, but should not affect actual usage.

This comment refers to "multiport" controllers from Qualcomm [1], which
would have ports beyond 1 and 2.

[1] https://lore.kernel.org/all/20240420044901.884098-8-quic_kriskura@quici=
nc.com/


> > ---
> >   Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3-common.yam=
l b/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
> > index 6c0b8b653824..4b6304bd2ec1 100644
> > --- a/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
> > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
> > @@ -410,11 +410,11 @@ properties:
> >         property is used.
> >
> >       properties:
> > -      port@0:
> > +      port@1:
> >           $ref: /schemas/graph.yaml#/properties/port
> >           description: High Speed (HS) data bus.
> >
> > -      port@1:
> > +      port@2:
> >           $ref: /schemas/graph.yaml#/properties/port
> >           description: Super Speed (SS) data bus.
> >
>

