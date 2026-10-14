Return-Path: <linux-aspeed+bounces-5201-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A6CC6B2D
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 04:33:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5X802jbRz3bwd;
	Fri, 16 Oct 2026 15:31:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b132" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791972895;
	cv=pass; b=mrEzJBYN5N1ojgiGgVjFe/m6j81oSFxAVo1386TdwEKEFXjVyeGAeRKPjxyHFOMGMryDv0Ht9kHHZ6KeQ3QChSkZviO6ydcl6OSxxfsWwjKSrefoVG5fYuRXrDNa593ml5bOGRceOIL21T4yWi5PIxAHPeNPxNSP36mr4CdEDP5TrPjXqTaQJF3DDXBh4H8JTo9LPjZHkCdzyRRILfXzGFftDogsxvzoc9lLIiM/+qvpRA7ksTTLcSprsmAwVNpfsIu86oRNFuqY11rD1nOlgD5dILuq9AJZc1SzEX9MDfZv4zPLEte9AtOf0Xqz2SMv3+Nnis+q6rfiayEtSWPEeA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791972895; c=relaxed/relaxed;
	bh=Edwfse8WHzu9gP6zUwwr3O8TIa4a9hek/bDZw8bIzFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evVSBxoRoYQGRaKn77lggMy15p7VqpGAGZGcVgE/sWwXyqYB2Ax6Ttu/0Da0eHx2mn3yhsosxOnApO+ydJyLdXqKqHhjkAi8l7AsZyKV6ixwErxO0t+07brLPjEt+IqyWaK42/hAITiHcYaBEvvzS8UOBJchdhfkwvH4WwQrGrpYDV3WMMzZvoOAeDysMGyZ4uBVEqCmjiKlioC5R+4aqMxZr8E6hOYjcKWFxVnPAKKdgscPrPjtNeeOYrmVMA1cm+8AZeEGxcr60cS1E0nYbpi2GGQoRwaoyaO6+qu1jUp+sTCpn3WiOZGAkxXPDwPJWcdjcncNumo7/xEfJcwxpw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BjCFZdUV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BjCFZdUV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com [IPv6:2607:f8b0:4864:20::b132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4Rs95fYyz2yDm
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 21:14:51 +1100 (AEDT)
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-6768403e9bbso3346982d50.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 03:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791972888; cv=none;
        d=google.com; s=arc-20260327;
        b=sja4EYjSIaQvFKdfONDwoWtOUSsgzNDHMxcGIaVRqblXb3xX5YXHO0vk0kGIZvTRUn
         wKFUnqFL9KBO5BoCpku4MndMQcbl2dKJAKHC9oyDbSm9YbugUq760iPFilEA4OlbR0rl
         Ovav1rgft/mC+F38+DUGfkCPUpcWodmBWgAUZMarIKbAu9X4svlqIzwmQkpAXkIPP+pR
         DRR1s0ZM/PV11rKbufNBgAM8AWO/m3GGlrOOrDTBbboZn6n1Jr1vG2m7tyDMl95x2pA7
         LY2YkOSw9791yPtKyabfyWKzs/Jul7ZrbMOGpDsx9TDpA+up3rcqdx4s2s/Q4QCKf5c+
         FQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Edwfse8WHzu9gP6zUwwr3O8TIa4a9hek/bDZw8bIzFg=;
        fh=8b7v4Wq40bxR1kaX7VMvrIbo6OhuvuOzHD6lNx08yeA=;
        b=OQyd87Q1YieyEM7u7FgHWVN2V9cyyvAwEC1etwWb21/GKOOdx9jq06LUINfMct0q30
         GXKV/GGiUBUWd0ZJVj7n48+Pb9WMHdd32OyJji00yQEvrRxMhQud+fiS6S/INckdBib3
         WE0sgcpNX1WY/6YHF6ui76FCXLsYngBd6B5G405cWJyedeEFlSF/MIgB3EdWn5pD4qtg
         uXQTCYQqBcbVMouZng/2BpxQHV+JYLPl+2eAD23M7KfPpUg90Qi5eqJk+6IzU0X3URQM
         OOnkcZLMrn4lyQ7Spa/lmnqn7qKveJ1esiy5n7AZXEGcRO1wG0CiqUYGj7tKovYp9ep+
         YWdg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791972888; x=1792577688; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Edwfse8WHzu9gP6zUwwr3O8TIa4a9hek/bDZw8bIzFg=;
        b=BjCFZdUVRYiJwFLFauxGUzXmRdlnO9x7pZYTBfUv53yR78jHgibtwaSlfvMVxrEHWT
         yxWkQFHusR3bDX6JokN0En8MV/BOFDZZR/s61e5AIxU8OhvGPSYPdH9fH7pw1pjpjkNS
         hIpptVK42sS7eMIjWxt/O4TjxdZbk4uiyQkZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791972888; x=1792577688;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Edwfse8WHzu9gP6zUwwr3O8TIa4a9hek/bDZw8bIzFg=;
        b=XcyjDc59tx3dCi6MPimDMp94CRN6NBPt4JhHRqiT84jV63Jwc7PfXAeyY+vpSW/fov
         xngUEXF0OPX1/nlUKkr7nhFiCytMkihJJuEwd/9DjEJkMR6zqZy8UTp5gf1DrKjck3hM
         5HbgsOtE2/bAb5Alg0PEe6Xa1iiu+hCYL71LPY0fR30bmt9adbdiD2IOu8eakDytv4Bb
         FVqLpzlZUkL+6OYv1JjgMkqnslQBY6c4rQu2Q+LSUkYck5mMcDSXoOKqWfQzv3jcQjHC
         H4U/qTCeZ3xGcHi5dSwfmyl+yu7URdQ1H8hbGxrLM8euR7WY8b1JN/QyrmrPAmhseqar
         ievg==
X-Forwarded-Encrypted: i=1; AKwUvBxn1EZUAIwQSLT1popYOv8/NeTVxpz+u5LhFRXcR3fOkmJGQ8j3KPgPAF6Z02syx1iPO8PJn8OA+SFBLw4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKjlIb3rSp4CEQPlRivxj1E86u/xU8+SPY7qa7XmRzVUIQ2k9A8
	hI4x4FsmHThDwVj1BWZW41dVGFfuqXZKdvh8jG0Go9S7zLFwuP+qNgUEicxrvaX8CRwzGLyP52a
	4Ek2T3yVTfnNEZKvjVolO6+eHuMwrPurceDiFDyrn
X-Gm-Gg: AYBFou3YJCOblqHR+ckQw7qnaSLu3G173GEiEmnCiXwJ9nlLegCNtBLFOJgfibkDnw4
	A2IrBC2K3nHCSdQ2fvYzjyIIvMVtoZe8Aax6cgl2k/n5qrlnb4WMHvArIzBX9tGvyTw4LhAvAPL
	Jmy389B9XNqge1Mu20tm6/Qhb0TIYnDgifzZQv99nl/GVyxH71xznf8yW2VuPri/4Ktn1WHMEm8
	z8cBpHEdE9huFbhAffrme47BmGAn/WZk4Nw+X2nqd/gJhX59f64HadhkyzgG5pwj+Dsy3IvmCbp
	C9QWyzxhdQZo7rX3XtW0fJAesEI7MtCvWj2JmFBYXTTwanPkgBM/aEiK
X-Received: by 2002:a05:690e:1206:b0:677:ac49:ebc4 with SMTP id
 956f58d0204a3-67936a424f4mr7759702d50.67.1791972888459; Wed, 14 Oct 2026
 03:14:48 -0700 (PDT)
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
 <7020a7a6-332e-4fd0-a659-d82eb768614c@linaro.org> <CAGXv+5G1kgyumbj7wGf6rPFbg3spSO0zYmEkn-hZT4qUdJbytA@mail.gmail.com>
 <03375a31-0ac6-47a4-b0dc-6327080e1622@linaro.org>
In-Reply-To: <03375a31-0ac6-47a4-b0dc-6327080e1622@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 14 Oct 2026 19:14:37 +0900
X-Gm-Features: AclHuK8K2ha0wfmSqlf_vB5Bnq5oR8A0v5D4YSyisrVXA9HcSK0AnBminp1imug
Message-ID: <CAGXv+5H+ZZXnZKB4EzXP0O9f4YGHBHsz3YCRyRJgX9V6RW1eug@mail.gmail.com>
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

On Wed, Oct 14, 2026 at 6:44=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 10/14/26 11:29, Chen-Yu Tsai wrote:
> > On Wed, Oct 14, 2026 at 5:28=E2=80=AFPM Neil Armstrong
> > <neil.armstrong@linaro.org> wrote:
> >>
> >> On 10/14/26 10:20, Chen-Yu Tsai wrote:
> >>> The DWC3 controller can operate in host mode. It does so with a XHCI
> >>> compliant host controller. The XHCI has two downstream ports, one for
> >>> HS and one for SS. USB downstream ports start from 1, not 0.
> >>
> >> Is there something in index 0 we will need to define at some point ?
> >
> > On the host side, no. Downstream ports start at 1.
> >
> > On the device mode side, I believe the numbers are completely made up.
> >
> >> Using 0 as base for numbering in DT isn't incompatible with the USB
> >> spec using base 1 for numbering,
> >
> > But you end up with diverging numbering schemes, and it diverges
> > from other USB controllers, particularly XHCI, which DWC3 embeds.
> >
> > And it also differs from the numbering currently used for directly
> > connected onboard devices (like hubs), which use or expect the USB
> > numbering scheme.
> >
> > Sure we can make DWC3 "special", drop inclusion of usb-hcd.yaml,
> > and duplicate the section for onboard devices. On Linux, we can
> > add some more code to xhci_find_raw_port_number() to make an
> > exception for DWC3 controllers.
> >
> > Also, usb_of_get_connect_type() is already broken for DWC3 based
> > controllers that only describe the HS connection but not the SS
> > connection. usb_of_get_connect_type() currently doesn't call
> > usb_hcd_find_raw_port_number() so both HS and SS get mapped to port 1,
> > which wouldn't be in the DT since HS is currently port@0. But even if
> > it did, SS would get mapped to port 2 anyway.
> >
> >
> > IMHO having consistent numbering across controller types would be
> > better. This avoids making the USB core and hub code deal with more
> > exceptions, and also easier to understand and write device trees.
>
> I was in the impression the port number not necessarily reflects
> an actual physical numbering, and can be a logical number we would
> then map in the kernel.
>
> I don't see any issue here having base 0 for the bindings and then
> converting it to base 1 for the XHCI port numbering.
>
> Each controller (Host, Device, OTG) will have it's own numbering anyway,
> so using the XHCI numbering only sounds a bad idea TBH.

OK. So we keep the port numbering, which is different from the embedded
device numbering, even for the same dual role controller? See below.

I hope you see why I think it is confusing.

> >
> >>> Reconcile the downstream port numbering with the common USB host
> >>> binding, renumbering the downstream port numbers from 0 and 1 to
> >>> 1 and 2.
> >>>
> >>> This is non-backwards compatible, however it won't break current
> >>> major implementations:
> >>>
> >>> - dwc3 "gadget mode" in Linux kernel only requires a connection to be
> >>>     present; it doesn't matter which port it is
> >>>     - dwc3 "host mode" OF graph connections aren't supported yet [1]
> >>> - FreeBSD doesn't use the OF graph for anything
> >>> - U-boot doesn't use the OF graph for USB
> >>> - OpenBSD doesn't support dwc3, only the XHCI in dwc3, and doesn't us=
e
> >>>     the OF graph for USB
> >>> - coreboot doesn't use the OF graph for anything
> >>> - Zephyr doesn't support dwc3
> >>> - TF-A doesn't use the OF graph for anything
> >>> - EDK2 doesn't support dwc3 and doesn't support OF graph
> >>> - OP-TEE doesn't support dwc3 and doesn't support OF graph
> >>>
> >>> [1] WIP to tie OF graph port node to USB port device
> >>>
> >>> Fixes: a33113f73693 ("dt-bindings: usb: snps,dwc3: document HS & SS O=
F graph ports")
> >>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >>> ---
> >>> It is unclear to me whether the HS/SS numbering is fixed for all dwc3
> >>> variants. I checked Allwinner H616 and Rockchip RK3588 and they both
> >>> have HS as port 1 and SS as port 2.
> >>>
> >>> This also doesn't cover a potential "multi-port" DWC3 implementation,
> >>> which Qualcomm seems to have.
> >>
> >> It breaks the current Qualcomm numbering on numerous boards.
> >
> > Yes. It breaks _everyone_ using the current numbering in the sense that
> > they are no longer valid, but should not affect actual usage.
>
> Older DT are supposed to be working on new kernels, you will break ABI
> and will break usage if the port numbering is enforced to enabled embedde=
d
> hubs for example.

On that front, embedded hubs already require you to use the USB numbering.

If you write

    dwc3 {
        hub@0 {
            compatible =3D "usb0123,abcd";
            reg =3D "0";
        };
    };

It won't match anything. The current USB HCD binding doesn't prevent you
from using port 0, but the kernel won't tie the USB device to it, even
if it is a single port USB controller. As I mentioned, USB downstream
ports start at 1, even for root hubs that only have 1 downstream port.

The kernel also doesn't check if the compatible property is correct, but
that is a separate issue. Maybe it should though, so people can see that
their DT is incorrect, like if they swapped HS and SS ports for a USB 3.x
hub.


ChenYu


> Neil
>
> >
> > This comment refers to "multiport" controllers from Qualcomm [1], which
> > would have ports beyond 1 and 2.
> >
> > [1] https://lore.kernel.org/all/20240420044901.884098-8-quic_kriskura@q=
uicinc.com/
> >
> >
> >>> ---
> >>>    Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml | 4 ++=
--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3-common.y=
aml b/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
> >>> index 6c0b8b653824..4b6304bd2ec1 100644
> >>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
> >>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
> >>> @@ -410,11 +410,11 @@ properties:
> >>>          property is used.
> >>>
> >>>        properties:
> >>> -      port@0:
> >>> +      port@1:
> >>>            $ref: /schemas/graph.yaml#/properties/port
> >>>            description: High Speed (HS) data bus.
> >>>
> >>> -      port@1:
> >>> +      port@2:
> >>>            $ref: /schemas/graph.yaml#/properties/port
> >>>            description: Super Speed (SS) data bus.
> >>>
> >>
>

