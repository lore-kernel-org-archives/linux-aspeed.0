Return-Path: <linux-aspeed+bounces-5114-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787E8CA5FE0
	for <linux-aspeed@archiver.kernel.org>; Fri,  2 Oct 2026 17:24:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxFyL44TKz30Pp;
	Sat, 03 Oct 2026 03:24:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:41::e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790961866;
	cv=pass; b=h9Tpaet/j7c/MmuxeCzZdGer/g7AGIl/gEfbwy67uZIGtU9qzZbvfbKWakHh5jAMHsokQAb6TncG/A0VdfOXKHg/i7XI3Pl2Q+zgU9x4awnZx4nqn07qJM1VTmYnvndVZc/IYYODK5Y7pvKhMOSMrNOt0zMGdUfhe1My8bLSJLtcZVSqZC+MMDwr02CSl0xzstfYOPzpuwXh80uHXrjaqbzEVz17wAKFq3RwbOcAdKHAbF9Yb5DKUTLhngvYRFn7Q7YLU525kP9zx/CNOP5SG65mY0tRN3I2nHT9jZg/xWU67bomDAd0zctj4PCwMTFNVHuei7vORVwv9d3zv3mh2w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790961866; c=relaxed/relaxed;
	bh=2sO6vv8JagGZrzPp7+08QZgEZz0k6rjVa9SbgTWHXNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFCDChNKlTKJncEcLXnVrVEJqBX9VXSW1VBSnTKFOkukPALoy1aOyB8MsUWVCmUqlR+iWQVyIFzzekYV/1GvBePCoDBCqHHx4eKfR2UgzxIGNnCYSKR6CqD6OUowihCNSRQeWWiH7R+7qCAmzOu2n0thcNDHAlSvtWSB2VLPpzHi6B+FlS3OFnYC5sU35JjvFd3YFNc8pFo+A+LQJymJZAQLd/rR+MJt/FcFK+5+XX4ftBGizHaaLXoDu0iq1vlLyRIogXt5bY6WldMfKHFFyfzZsEdfQhisE02Y3aksged7M42i6ajsK7neLv99DLtjrdYxQhhywBSf6d1jZxCkJA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SadXKZrG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:41::e; helo=mail-yx2-x0e.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SadXKZrG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:41::e; helo=mail-yx2-x0e.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx2-x0e.google.com (mail-yx2-x0e.google.com [IPv6:2607:f8b0:4864:41::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxFyJ0wZJz2ynZ
	for <linux-aspeed@lists.ozlabs.org>; Sat, 03 Oct 2026 03:24:22 +1000 (AEST)
Received: by mail-yx2-x0e.google.com with SMTP id 00721157ae682-8a7411012b1so78376287b3.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Oct 2026 10:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790961859; cv=none;
        d=google.com; s=arc-20260327;
        b=Ilbww/qampJk9yGHWtFEbB0LwlO4wulfr5hw2zLB1jARBky6Uzkz6vQx1h/QlT81FK
         TSGzishR8OVsYtLagNhPysY8Wcpm4amzMiZah/AsJtY7ltFGU/9aCjDHrpc1o3MbI2hn
         kCCfml2IxuN/C7YTWMRiEzElPa0PiaupklgQmIklJjXZuxu472UQRUliyyZDSwfl1tck
         QTyfrnk9BXMsrC3g+t7CLl2omf+mOjE901sfcyK9dfZCD+krTa478RXsuCA3+CZftiyD
         IjARqMFIffEQMXPrvbTaniRpc2cljX8HyRFsXRzg/6xsOsbh18qQhryAPuRl19s+5g5J
         nvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2sO6vv8JagGZrzPp7+08QZgEZz0k6rjVa9SbgTWHXNM=;
        fh=Cz8TvaxUx+8xFamXOjK/34Jsi0mgeOBdk8n9ZJ2IivY=;
        b=TzjdBXxD1bKhWBT1jaUCvFdIHtxribYMrYzgxjRFt8duNfj06m/0ZGyNY4pEsqytUd
         dpGWy5Q0SGQBuuhcjmcQCObHbysm6PffmaQCPwmHtA4w98DVrAupUliwNbvAGr57YW/A
         A0QKfoIbTRHOwE6Lh7nx8s2mWepNrZ8JdC2K1x85MXx5LKCfEufYGGlBJs6CD6oZUd7M
         Tq5fC8QXUuP+9gzhmK+IYsoAihHeBxpz6CFW5xFBGEVHEDHnAXNW99QuGNRIMgwBICsf
         mpUsBoBk8CL2PTJ7QyjvZhspQlhzyg1PmwgPD56kQZ2ls6zrG5/GewI2JOP6MEYutYHV
         seNw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790961859; x=1791566659; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2sO6vv8JagGZrzPp7+08QZgEZz0k6rjVa9SbgTWHXNM=;
        b=SadXKZrG2gC0UhV7/FELhPvT/lRmhfAe5+Rd/3uNjDhflN+ylVRUbDtQhL4Evr0wnq
         QDHS6+CNxg52PSuHdxkwJIdaHnhQOEqPCw5ycphpcO22tOgXlDzkRVx7ku+IsU+C+7sh
         SraF6ijP4JZ+k+LhxphahUBVI4L+2NVBu6uzdDFriIIuw35GLRMl4j/FL+NbWjp//Qow
         lBmjb73EQg4v9I4/WQhfpdHzYXaszjfehRDzA79fVmK0vQnBeaXGXFDtHNqr1gOTBGiQ
         d4qQ3CU9CeJiDQTtWY/5lDJsVsVpWTF/7f42qkDP+xZx3i7aP1OnH6N+RL9OlnzwDWlJ
         CsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961859; x=1791566659;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2sO6vv8JagGZrzPp7+08QZgEZz0k6rjVa9SbgTWHXNM=;
        b=At17ZJQ1y2jm659f8wRQqWgka8pYbLY5dLM9ZIAgRX5N96rmSwmpOflM29rD808LJ/
         I9I21+9pIwoS6oIXMqR5x7hCFa6cAzPOQxmWN8G1Q4gk1hG8HizRTqaMPEMLuqdntCNW
         7cg2Yo5+EPVGuW/lLeMYTnM5lh6cdMaF5l6Dt0w56Zdd/KB2Hl/SDTUiOzWESQx3cPtx
         6b2+L+vr/MATNvGgqjj2A3UYb4d1G8yeez13jYHETPAyWOBB1tEY/1AK/0a7NnWgOq+M
         pNso3Qga6Q5sEmqhfMF/vHpxCC2yvcOPG0IOlztbBFKDf8FP4kzKIuDE5oS9X2nfi/xa
         KDpw==
X-Forwarded-Encrypted: i=1; AKwUvBz+KcmVHGXHGd8BS30ZvVSFynaqlLqm1GC+LTXuquKE8z0N3CoipZr45G8+xmzB2q5T9VQohQpLtmTy3jQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI5hrE9Zn2cdOxBnW3JO9DGwommgJ0guhi0CrWUtWOB2bY+7GPH
	O+zgvDEsLAVO1yoBK4RyfIUbzacKcDsZNGsLK9QBuJTMM8fw2F39dCbCZ5vkWHVdyCuDt/CUmII
	0wRsUTVW7uWwr7gMI2XFjhSovxScJzUk=
X-Gm-Gg: AYBFou0FbuQYKSSqUPeBT1dsWOXqBXDvmbfGtoDYZbTls7/19WtJ0shYjaNPbPFhMgs
	HOZ0WF1PXIuwgb2vxv0KlRrvwvKKCTb3eZQXEu9uwOg5MJxjCPbZ9ei1UREjedTKXTjBP1E1q5/
	PlkazboDFfFIpvYuwytDd9f6bA79Fs+JiqNVXpN93EXuZAYRnOE2vme8ukRyur/sK4ppp3Bc/v9
	tnrFLrzost746zDxNE2aHiK1aF5E6biprgD5/yktdGBYI2WCyLBJktd9+Q5277IpdrViqodIAjC
	3ZB9on42igQ3VXLwydHjE7GlWFuekFLzSSOCIgYXH9Mjg6bLXE9AIxllMQ==
X-Received: by 2002:a05:690c:348a:b0:873:5c6b:a303 with SMTP id
 00721157ae682-8ae3a00d216mr13030607b3.49.1790961858585; Fri, 02 Oct 2026
 10:24:18 -0700 (PDT)
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
References: <20261002131634.113680-1-prasanth.padarthi10@gmail.com> <9cfcd3e7-bbc3-47c6-ad43-72b595a90110@9elements.com>
In-Reply-To: <9cfcd3e7-bbc3-47c6-ad43-72b595a90110@9elements.com>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Fri, 2 Oct 2026 22:54:07 +0530
X-Gm-Features: AclHuK-uFTCee-FiQ9dFYhL8A6P_KDXcANz5wscwqCRZ4dKYIwzpVXTt-MGGazE
Message-ID: <CAMFFDGhvAcafnRJ3ovyvrWDBAoqp=6KZW09RqJcuBiRZ6gBG=g@mail.gmail.com>
Subject: Re: [RFC PATCH] soc: aspeed: Add B650D4U power passthrough support
To: Tan Siewert <tan.siewert@9elements.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, joel@jms.id.au, 
	ryan_chen@aspeedtech.com, Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: multipart/alternative; boundary="000000000000632891065cdecd8e"

--000000000000632891065cdecd8e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the clarification Tan.

For context, I sent this RFC to document the hardware-backed experiment and
request guidance on the correct kernel-facing implementation.

Using the current OpenBMC integration with the B650D4U hardware, the host
can be powered on through the standard D-Bus command, and the OpenBMC web
interface correctly reports the server power and host state. I validated
this
on the real board before sending the RFC.

The RFC was therefore intended to obtain feedback on whether this sequence
belongs in the kernel or should instead be expressed through the existing
GPIO and pinctrl configuration. I understand from your review that the
separate SCU passthrough driver is not appropriate, so I will investigate
the GPIO request and pinctrl configuration and withdraw this implementation=
.

On Fri, Oct 2, 2026 at 10:17=E2=80=AFPM Tan Siewert <tan.siewert@9elements.=
com>
wrote:

> On 10/2/26 3:16 PM, Prasanth Kumar Padarthi wrote:
> > Add the AST2600 SCU passthrough selector support used by the
> > ASRock Rack B650D4U host power-control circuit. This RFC includes
> > the driver, Devicetree binding, and board node to discuss the final
> > kernel-facing interface.
> >
> > Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
>
> This is definitely not the way how to solve this. I've already said on
> linux-aspeed as well as off-the-list, requesting the GPIO lines is
> enough and enabling GPIOP passthrough here does not make any sense, as
> it would be disabled by pinctrl anyways.
> There's a whole implementation in userspace to solve this issue (at
> least if you use OpenBMC). The issue you're facing here is, from my
> point of view, a configuration error, and you'll not solve it with a
> kernel driver that literally just enables GPIOP passthrough...
>
> So my answer to this patch is:
> NACKed-by: Tan Siewert <tan.siewert@9elements.com>
>
> > ---
> >   .../asrock,b650d4u-power-passthrough.yaml     |  23 ++++
> >   .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  |   5 +
> >   drivers/soc/aspeed/Kconfig                    |   9 ++
> >   drivers/soc/aspeed/Makefile                   |   1 +
> >   drivers/soc/aspeed/aspeed-b650d4u-power.c     | 110 +++++++++++++++++=
+
> >   5 files changed, 148 insertions(+)
> >   create mode 100644
> Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4u-power-passthr=
ough.yaml
> >   create mode 100644 drivers/soc/aspeed/aspeed-b650d4u-power.c
> >
> > diff --git
> a/Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4u-power-passt=
hrough.yaml
> b/Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4u-power-passt=
hrough.yaml
> > new file mode 100644
> > index 000000000000..e6451d17955c
> > --- /dev/null
> > +++
> b/Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4u-power-passt=
hrough.yaml
> > @@ -0,0 +1,23 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id:
> http://devicetree.org/schemas/soc/aspeed/asrock,b650d4u-power-passthrough=
.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASRock Rack B650D4U power passthrough
> > +
> > +maintainers:
> > +  - Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: asrock,b650d4u-power-passthrough
> > +
> > +  aspeed,scu:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +required:
> > +  - compatible
> > +  - aspeed,scu
> > +
> > +additionalProperties: false
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> > index a4e384588a54..86291c250562 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> > @@ -32,6 +32,11 @@ gfx_memory: framebuffer {
> >                       size =3D <0x01000000>;
> >               };
> >       };
> > +
> > +     host-power-passthrough {
> > +             compatible =3D "asrock,b650d4u-power-passthrough";
> > +             aspeed,scu =3D <&syscon>;
> > +     };
> >   };
> >
> >   &fmc {
> > diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> > index 11e4db998c06..1b0281e0bfb0 100644
> > --- a/drivers/soc/aspeed/Kconfig
> > +++ b/drivers/soc/aspeed/Kconfig
> > @@ -58,6 +58,15 @@ config ASPEED_SBC
> >         Say yes to provide information about the secure boot controller
> in
> >         debugfs.
> >
> > +config ASPEED_B650D4U_POWER
> > +     tristate "ASRock B650D4U host power passthrough"
> > +     select REGMAP
> > +     select MFD_SYSCON
> > +     default ARCH_ASPEED
> > +     help
> > +       Enable the AST2600 GPIO passthrough selector used by the
> > +       ASRock Rack B650D4U host power-control circuit. This selector
> routes the host power pulse through the board's passthrough logic during
> power sequencing.
> > +
> >   config ASPEED_XDMA
> >       tristate "ASPEED XDMA Engine Driver"
> >       select REGMAP
> > diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> > index 5f61bb4cc36c..3e9618d1eafc 100644
> > --- a/drivers/soc/aspeed/Makefile
> > +++ b/drivers/soc/aspeed/Makefile
> > @@ -5,4 +5,5 @@ obj-$(CONFIG_ASPEED_UART_ROUTING)     +=3D
> aspeed-uart-routing.o
> >   obj-$(CONFIG_ASPEED_P2A_CTRL)               +=3D aspeed-p2a-ctrl.o
> >   obj-$(CONFIG_ASPEED_SOCINFO)                +=3D aspeed-socinfo.o
> >   obj-$(CONFIG_ASPEED_SBC)            +=3D aspeed-sbc.o
> > +obj-$(CONFIG_ASPEED_B650D4U_POWER)   +=3D aspeed-b650d4u-power.o
> >   obj-$(CONFIG_ASPEED_XDMA)           +=3D aspeed-xdma.o
> > diff --git a/drivers/soc/aspeed/aspeed-b650d4u-power.c
> b/drivers/soc/aspeed/aspeed-b650d4u-power.c
> > new file mode 100644
> > index 000000000000..22a6925539dc
> > --- /dev/null
> > +++ b/drivers/soc/aspeed/aspeed-b650d4u-power.c
> > @@ -0,0 +1,110 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/device.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/mutex.h>
> > +#include <linux/kstrtox.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/bits.h>
> > +
> > +#define ASPEED_SCU_PROTECTION        0x000
> > +#define ASPEED_SCU_GPIO_PASSTHROUGH  0x4bc
> > +#define ASPEED_SCU_GPIO_ACTION       0x51c
> > +#define ASPEED_SCU_UNLOCK_KEY        0x1688a8a8
> > +#define ASPEED_B650D4U_POWER_MASK    GENMASK(27, 26)
> > +
> > +static struct regmap *b650d4u_scu;
> > +static DEFINE_MUTEX(b650d4u_lock);
> > +
> > +static int b650d4u_set_passthrough(bool enable)
> > +{
> > +     int ret;
> > +
> > +     mutex_lock(&b650d4u_lock);
> > +
> > +     ret =3D regmap_write(b650d4u_scu, ASPEED_SCU_PROTECTION,
> > +                        ASPEED_SCU_UNLOCK_KEY);
> > +     if (ret) {
> > +             pr_err("B650D4U: SCU unlock failed: %d\n", ret);
> > +             goto out;
> > +     }
> > +
> > +     ret =3D regmap_update_bits(b650d4u_scu,
> > +                              ASPEED_SCU_GPIO_PASSTHROUGH,
> > +                              ASPEED_B650D4U_POWER_MASK,
> > +                              enable ? ASPEED_B650D4U_POWER_MASK : 0);
> > +     if (ret) {
> > +             pr_err("B650D4U: passthrough update failed: %d\n", ret);
> > +             goto out;
> > +     }
> > +
> > +     if (!enable)
> > +             ret =3D regmap_write(b650d4u_scu,
> > +                                ASPEED_SCU_GPIO_ACTION, 0);
> > +
> > +out:
> > +     mutex_unlock(&b650d4u_lock);
> > +     return ret;
> > +}
> > +
> > +static ssize_t passthrough_store(struct device *dev,
> > +                              struct device_attribute *attr,
> > +                              const char *buf, size_t count)
> > +{
> > +     bool enable;
> > +     int ret;
> > +
> > +     ret =3D kstrtobool(buf, &enable);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D b650d4u_set_passthrough(enable);
> > +     return ret ? ret : count;
> > +}
> > +static DEVICE_ATTR_WO(passthrough);
> > +
> > +static int aspeed_b650d4u_power_probe(struct platform_device *pdev)
> > +{
> > +     int ret;
> > +
> > +     b650d4u_scu =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node=
,
> > +                                                   "aspeed,scu");
> > +     if (IS_ERR(b650d4u_scu))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(b650d4u_scu),
> > +                                  "failed to get AST2600 SCU regmap\n"=
);
> > +
> > +     ret =3D b650d4u_set_passthrough(true);
> > +     if (ret)
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "failed to enable power GPIO
> passthrough\n");
> > +
> > +     ret =3D device_create_file(&pdev->dev, &dev_attr_passthrough);
> > +     if (ret)
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "failed to create passthrough
> control\n");
> > +
> > +     dev_info(&pdev->dev, "enabled GPIO passthrough selector 1\n");
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id aspeed_b650d4u_power_of_match[] =3D {
> > +     { .compatible =3D "asrock,b650d4u-power-passthrough" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, aspeed_b650d4u_power_of_match);
> > +
> > +static struct platform_driver aspeed_b650d4u_power_driver =3D {
> > +     .probe =3D aspeed_b650d4u_power_probe,
> > +     .driver =3D {
> > +             .name =3D "aspeed-b650d4u-power",
> > +             .of_match_table =3D aspeed_b650d4u_power_of_match,
> > +     },
> > +};
> > +module_platform_driver(aspeed_b650d4u_power_driver);
> > +
> > +MODULE_DESCRIPTION("ASRock Rack B650D4U host power GPIO passthrough");
> > +MODULE_LICENSE("GPL");
>
>

--000000000000632891065cdecd8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the clarification Tan.<br><br>For context, I se=
nt this RFC to document the hardware-backed experiment and<br>request guida=
nce on the correct kernel-facing implementation.<br><br>Using the current O=
penBMC integration with the B650D4U hardware, the host<br>can be powered on=
 through the standard D-Bus command, and the OpenBMC web<br>interface corre=
ctly reports the server power and host state. I validated this<br>on the re=
al board before sending the RFC.<br><br>The RFC was therefore intended to o=
btain feedback on whether this sequence<br>belongs in the kernel or should =
instead be expressed through the existing<br>GPIO and pinctrl configuration=
. I understand from your review that the<br>separate SCU passthrough driver=
 is not appropriate, so I will investigate<br>the GPIO request and pinctrl =
configuration and withdraw this implementation.</div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri=
, Oct 2, 2026 at 10:17=E2=80=AFPM Tan Siewert &lt;<a href=3D"mailto:tan.sie=
wert@9elements.com">tan.siewert@9elements.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On 10/2/26 3:16 PM, Prasanth K=
umar Padarthi wrote:<br>
&gt; Add the AST2600 SCU passthrough selector support used by the<br>
&gt; ASRock Rack B650D4U host power-control circuit. This RFC includes<br>
&gt; the driver, Devicetree binding, and board node to discuss the final<br=
>
&gt; kernel-facing interface.<br>
&gt; <br>
&gt; Signed-off-by: Prasanth Kumar Padarthi &lt;<a href=3D"mailto:prasanth.=
padarthi10@gmail.com" target=3D"_blank">prasanth.padarthi10@gmail.com</a>&g=
t;<br>
<br>
This is definitely not the way how to solve this. I&#39;ve already said on =
<br>
linux-aspeed as well as off-the-list, requesting the GPIO lines is <br>
enough and enabling GPIOP passthrough here does not make any sense, as <br>
it would be disabled by pinctrl anyways.<br>
There&#39;s a whole implementation in userspace to solve this issue (at <br=
>
least if you use OpenBMC). The issue you&#39;re facing here is, from my <br=
>
point of view, a configuration error, and you&#39;ll not solve it with a <b=
r>
kernel driver that literally just enables GPIOP passthrough...<br>
<br>
So my answer to this patch is:<br>
NACKed-by: Tan Siewert &lt;<a href=3D"mailto:tan.siewert@9elements.com" tar=
get=3D"_blank">tan.siewert@9elements.com</a>&gt;<br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0.../asrock,b650d4u-power-passthrough.yaml=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 23 ++++<br>
&gt;=C2=A0 =C2=A0.../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts=C2=A0 |=C2=A0=
 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0drivers/soc/aspeed/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 ++<br>
&gt;=C2=A0 =C2=A0drivers/soc/aspeed/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0drivers/soc/aspeed/aspeed-b650d4u-power.c=C2=A0 =C2=A0 =C2=
=A0| 110 ++++++++++++++++++<br>
&gt;=C2=A0 =C2=A05 files changed, 148 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 Documentation/devicetree/bindings/soc/a=
speed/asrock,b650d4u-power-passthrough.yaml<br>
&gt;=C2=A0 =C2=A0create mode 100644 drivers/soc/aspeed/aspeed-b650d4u-power=
.c<br>
&gt; <br>
&gt; diff --git a/Documentation/devicetree/bindings/soc/aspeed/asrock,b650d=
4u-power-passthrough.yaml b/Documentation/devicetree/bindings/soc/aspeed/as=
rock,b650d4u-power-passthrough.yaml<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..e6451d17955c<br>
&gt; --- /dev/null<br>
&gt; +++ b/Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4u-powe=
r-passthrough.yaml<br>
&gt; @@ -0,0 +1,23 @@<br>
&gt; +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)<br>
&gt; +%YAML 1.2<br>
&gt; +---<br>
&gt; +$id: <a href=3D"http://devicetree.org/schemas/soc/aspeed/asrock,b650d=
4u-power-passthrough.yaml#" rel=3D"noreferrer" target=3D"_blank">http://dev=
icetree.org/schemas/soc/aspeed/asrock,b650d4u-power-passthrough.yaml#</a><b=
r>
&gt; +$schema: <a href=3D"http://devicetree.org/meta-schemas/core.yaml#" re=
l=3D"noreferrer" target=3D"_blank">http://devicetree.org/meta-schemas/core.=
yaml#</a><br>
&gt; +<br>
&gt; +title: ASRock Rack B650D4U power passthrough<br>
&gt; +<br>
&gt; +maintainers:<br>
&gt; +=C2=A0 - Prasanth Kumar Padarthi &lt;<a href=3D"mailto:prasanth.padar=
thi10@gmail.com" target=3D"_blank">prasanth.padarthi10@gmail.com</a>&gt;<br=
>
&gt; +<br>
&gt; +properties:<br>
&gt; +=C2=A0 compatible:<br>
&gt; +=C2=A0 =C2=A0 const: asrock,b650d4u-power-passthrough<br>
&gt; +<br>
&gt; +=C2=A0 aspeed,scu:<br>
&gt; +=C2=A0 =C2=A0 $ref: /schemas/types.yaml#/definitions/phandle<br>
&gt; +<br>
&gt; +required:<br>
&gt; +=C2=A0 - compatible<br>
&gt; +=C2=A0 - aspeed,scu<br>
&gt; +<br>
&gt; +additionalProperties: false<br>
&gt; diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts b/=
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts<br>
&gt; index a4e384588a54..86291c250562 100644<br>
&gt; --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts<br>
&gt; +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts<br>
&gt; @@ -32,6 +32,11 @@ gfx_memory: framebuffer {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0size =3D &lt;0x01000000&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0host-power-passthrough {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
asrock,b650d4u-power-passthrough&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed,scu =3D &lt;&a=
mp;syscon&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0&amp;fmc {<br>
&gt; diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig<b=
r>
&gt; index 11e4db998c06..1b0281e0bfb0 100644<br>
&gt; --- a/drivers/soc/aspeed/Kconfig<br>
&gt; +++ b/drivers/soc/aspeed/Kconfig<br>
&gt; @@ -58,6 +58,15 @@ config ASPEED_SBC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say yes to provide information about =
the secure boot controller in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debugfs.<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +config ASPEED_B650D4U_POWER<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tristate &quot;ASRock B650D4U host power passthro=
ugh&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0select REGMAP<br>
&gt; +=C2=A0 =C2=A0 =C2=A0select MFD_SYSCON<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default ARCH_ASPEED<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Enable the AST2600 GPIO passthrough select=
or used by the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ASRock Rack B650D4U host power-control cir=
cuit. This selector routes the host power pulse through the board&#39;s pas=
sthrough logic during power sequencing.<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0config ASPEED_XDMA<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;ASPEED XDMA Engine Driver&quo=
t;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select REGMAP<br>
&gt; diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile=
<br>
&gt; index 5f61bb4cc36c..3e9618d1eafc 100644<br>
&gt; --- a/drivers/soc/aspeed/Makefile<br>
&gt; +++ b/drivers/soc/aspeed/Makefile<br>
&gt; @@ -5,4 +5,5 @@ obj-$(CONFIG_ASPEED_UART_ROUTING)=C2=A0 =C2=A0 =C2=A0+=
=3D aspeed-uart-routing.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_ASPEED_P2A_CTRL)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D aspeed-p2a-ctrl.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_ASPEED_SOCINFO)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D aspeed-socinfo.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_ASPEED_SBC)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 +=3D aspeed-sbc.o<br>
&gt; +obj-$(CONFIG_ASPEED_B650D4U_POWER)=C2=A0 =C2=A0+=3D aspeed-b650d4u-po=
wer.o<br>
&gt;=C2=A0 =C2=A0obj-$(CONFIG_ASPEED_XDMA)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0+=3D aspeed-xdma.o<br>
&gt; diff --git a/drivers/soc/aspeed/aspeed-b650d4u-power.c b/drivers/soc/a=
speed/aspeed-b650d4u-power.c<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..22a6925539dc<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/soc/aspeed/aspeed-b650d4u-power.c<br>
&gt; @@ -0,0 +1,110 @@<br>
&gt; +// SPDX-License-Identifier: GPL-2.0-only<br>
&gt; +<br>
&gt; +#include &lt;linux/device.h&gt;<br>
&gt; +#include &lt;linux/init.h&gt;<br>
&gt; +#include &lt;linux/kernel.h&gt;<br>
&gt; +#include &lt;linux/mfd/syscon.h&gt;<br>
&gt; +#include &lt;linux/mutex.h&gt;<br>
&gt; +#include &lt;linux/kstrtox.h&gt;<br>
&gt; +#include &lt;linux/of.h&gt;<br>
&gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt; +#include &lt;linux/regmap.h&gt;<br>
&gt; +#include &lt;linux/bits.h&gt;<br>
&gt; +<br>
&gt; +#define ASPEED_SCU_PROTECTION=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000<br>
&gt; +#define ASPEED_SCU_GPIO_PASSTHROUGH=C2=A0 0x4bc<br>
&gt; +#define ASPEED_SCU_GPIO_ACTION=C2=A0 =C2=A0 =C2=A0 =C2=A00x51c<br>
&gt; +#define ASPEED_SCU_UNLOCK_KEY=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1688a8a8<b=
r>
&gt; +#define ASPEED_B650D4U_POWER_MASK=C2=A0 =C2=A0 GENMASK(27, 26)<br>
&gt; +<br>
&gt; +static struct regmap *b650d4u_scu;<br>
&gt; +static DEFINE_MUTEX(b650d4u_lock);<br>
&gt; +<br>
&gt; +static int b650d4u_set_passthrough(bool enable)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;b650d4u_lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D regmap_write(b650d4u_scu, ASPEED_SCU_PROT=
ECTION,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ASPEED_SCU_UNLOCK_KEY);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;B650D4U:=
 SCU unlock failed: %d\n&quot;, ret);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D regmap_update_bits(b650d4u_scu,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASPEED_SCU_GPIO_PASSTHROUGH,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASPEED_B650D4U_POWER_MASK,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable ? ASPEED_B650D4U_POWER_MASK : 0)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;B650D4U:=
 passthrough update failed: %d\n&quot;, ret);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!enable)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D regmap_write(=
b650d4u_scu,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASPEED_SCU_GPIO_ACTION, 0);<br>
&gt; +<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;b650d4u_lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t passthrough_store(struct device *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *attr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *buf, size_t count)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool enable;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D kstrtobool(buf, &amp;enable);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D b650d4u_set_passthrough(enable);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret ? ret : count;<br>
&gt; +}<br>
&gt; +static DEVICE_ATTR_WO(passthrough);<br>
&gt; +<br>
&gt; +static int aspeed_b650d4u_power_probe(struct platform_device *pdev)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0b650d4u_scu =3D syscon_regmap_lookup_by_phandle(p=
dev-&gt;dev.of_node,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;aspeed,scu&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(b650d4u_scu))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return dev_err_probe(=
&amp;pdev-&gt;dev, PTR_ERR(b650d4u_scu),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;failed to get AST26=
00 SCU regmap\n&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D b650d4u_set_passthrough(true);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return dev_err_probe(=
&amp;pdev-&gt;dev, ret,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;failed to enable po=
wer GPIO passthrough\n&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D device_create_file(&amp;pdev-&gt;dev, &am=
p;dev_attr_passthrough);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return dev_err_probe(=
&amp;pdev-&gt;dev, ret,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;failed to create pa=
ssthrough control\n&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_info(&amp;pdev-&gt;dev, &quot;enabled GPIO pa=
ssthrough selector 1\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct of_device_id aspeed_b650d4u_power_of_match[] =3D =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;asrock,b650d4u-power-pass=
through&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ }<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(of, aspeed_b650d4u_power_of_match);<br>
&gt; +<br>
&gt; +static struct platform_driver aspeed_b650d4u_power_driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.probe =3D aspeed_b650d4u_power_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;aspee=
d-b650d4u-power&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_table =3D a=
speed_b650d4u_power_of_match,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +};<br>
&gt; +module_platform_driver(aspeed_b650d4u_power_driver);<br>
&gt; +<br>
&gt; +MODULE_DESCRIPTION(&quot;ASRock Rack B650D4U host power GPIO passthro=
ugh&quot;);<br>
&gt; +MODULE_LICENSE(&quot;GPL&quot;);<br>
<br>
</blockquote></div>

--000000000000632891065cdecd8e--

