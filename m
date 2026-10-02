Return-Path: <linux-aspeed+bounces-5115-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066E8CA5FDD
	for <linux-aspeed@archiver.kernel.org>; Fri,  2 Oct 2026 17:28:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxG340sKnz30Pp;
	Sat, 03 Oct 2026 03:28:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:41::2b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790962112;
	cv=pass; b=LKJzyBiH2wqLrH7hm9+jOSJacYfEkGB0H1a0gas3X/arJs/4V+lvrfnBiY3cZbK97gzoGniTBGioTzJFDrb7WwJBwS3jMTyPrnEP2LX/qCpT5GFM3K8juOYolSznIaptaZkHYHD0mMxW46S8hM3EN1qW0ynR9n+ofy8gUewQp8MTq8y9sS9l+Phtw06MdAw/lO4Lf0s1iReBwpTxI+WeBoothDAHEnSwc2TLlkU5We/24YgU51fNGvyiBWZBSxQMcWnHItQncXigQvSeIZSf7TV6ckc1H4HPTTwL6zD2RvKIk3kvNHcKElGY+YuHnNeJnDezxqso0PTeKaKbcPQldQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790962112; c=relaxed/relaxed;
	bh=AYkEOeExnXVYl7DVk7pNZ0jHVMuLD/iLqTtJDBZJL1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHp+vIUj424AyWsUrmI9SGKEPDEhydhX/dNQ57Ui+AeatX3807ctUvVjL7jQgTAYGSoUmDxQU7kgZHau8J6q7DJQy8G9YBXWL9eI+nKlybDthsPFCfE+WgDTnjDX84mhPRG8o6QUwtJC5edULnibmEQyrzE+Zufg8zZv56L1PP0eYEA0pwFtRe1Ap5QQ8Ui5ksK+7jv9eEXVtik6zw/Nc0y+Cy0/7ZqfbyrrXCVW7cUXUwrMcblGj53hq9yJJq9RuEuYqLbrPbiISea2iYvIubTLoxa52Xyyw0sG8XoNqAhnsoyuij2pTLShlwxrWJ9err/CCdd1fYZchAD/kfLIlw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dm3RY99u; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:41::2b; helo=mail-yx2-x2b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dm3RY99u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:41::2b; helo=mail-yx2-x2b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx2-x2b.google.com (mail-yx2-x2b.google.com [IPv6:2607:f8b0:4864:41::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxG332lYcz2ynZ
	for <linux-aspeed@lists.ozlabs.org>; Sat, 03 Oct 2026 03:28:31 +1000 (AEST)
Received: by mail-yx2-x2b.google.com with SMTP id 00721157ae682-8aca30a369cso31964097b3.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Oct 2026 10:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790962109; cv=none;
        d=google.com; s=arc-20260327;
        b=SruSaR/AXKGUsyU/xVAMr49m87Zb441McmF4kZkd2iXRxvvWc8UGBu/FDkERn+m0JJ
         MCr/ZPdSW8d+h/ze08i0h74DVgCGtn9IpnCrYiGJCtP27tN6o6PqDNNZ1a75+r5Mi/+L
         VgA4ceJqOxvrnYby8fcbzWEyqybQVcsr9yhhOwSfaZLccmqLE/2xTTbC4NtScEA//mg1
         BXJjp4pChobBy9RdAzbfdWeRFquLK/Kdj8yE39Mzt5t1qVGMeSPw/miiYA4FO2EHfEoP
         GxcS0iAVstzS97qcqAIDjTcUkp+kQP0GsPyCJk/4jkGC/JHMaRotu+1OXzp4TdjBwlWj
         KznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AYkEOeExnXVYl7DVk7pNZ0jHVMuLD/iLqTtJDBZJL1U=;
        fh=uPHa2fxqstANPhwwyOcoHRp3xMelNgJb1brErDcjGY4=;
        b=SPCae8rI6gTjn9uxMxWjdLpwFmBBbs5SHc+io4FlJ2KTP4CfLrEBVK1NMAZuCfhiBx
         Nb49Y0PXqZbHffjRNf+3Vi0G5e8H3quOM/FMHwBJcNNiFyny/wqJbnIIP35nly9hN+1M
         9VeZjp5hfA/kGpbo7W08uE7Tg9FJ+Lqv3liiRhNkWNR71F8gyitNDgPI+kRJ6+64LqAo
         h8vbUc/t3XU/mmLUAk/Y37LFlrLcIiy+A7x88WZp+NGfzEnyDuIpAByynpG3AgowDQev
         nW7anvT1UFx6fEShuArSp09sf75n2uc2AoudPcCs5ayxfNhMFgnnGySZkFEw0cGJ/x1+
         pqPQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790962109; x=1791566909; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AYkEOeExnXVYl7DVk7pNZ0jHVMuLD/iLqTtJDBZJL1U=;
        b=dm3RY99uIpdL5NzRAlr6csesGXbLgi5VYXKnVczjDeoxGLWFLxk46dLKaS1CtQK2Bt
         3C0memqBlriCvWn5KzqxYZhOSF/U3DsiOsdEmSexJPgBgm6qTQ++2qNdbbFm+y8S58Zw
         fTxzk3NOn9WH0zR8hHVBtANAwKv/rqTpt16u79ZD6mIjTlBYuz25qHFau4YQdZkBjUM8
         t6rAHpEZSkhcH5bZiUkENBtpUgCf0m1R2d4vN1yqIxEQb7b6mDL18IXuvwoDz2lLMCuU
         zxJYao4Q5IGdrLhLgyisgqssi/HBsaYLZZ+SDtM4xfREVjow29EdHIbu+zZp3KiuYt9e
         SMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790962109; x=1791566909;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYkEOeExnXVYl7DVk7pNZ0jHVMuLD/iLqTtJDBZJL1U=;
        b=P8LXPr0+qmXujLRuYMgfrEjBYiUHWucO/o3tgr01lpo1u6R6uUNOXtDNnHr1NiXwbg
         ZUUdrE5cMZajbBDxN1iAcRzHOMpbmYDCGHI9bjTv4ltOB/cIW2eql7Aa4+iRvAeB3CiU
         91gosb50U2Zf7j8jZ6OZxvubpWieoXNS485V2r1qbEWJF2CKXrEa/AqbGgkWm5Z6MazS
         cIIwaAuLRI7Xl6KwtR0Finkx39WVVE/KZ++QI/AKIaBi2CRSRE34yNzByPyRTPXiV3b3
         9wOF/ecLg/Ste+OBZc+iNHCnF3kxDTQRfcI+EiM/0EMjn/K1d0pjtJ6AJ1arTGhh6pUK
         pKcg==
X-Forwarded-Encrypted: i=1; AKwUvBzECOtXRmUek1mzp5yaMplS/uo0JXc1bfnh+W7vhKJ2pzmOvnPFgPRiFht4FWLXcbBHy8AosmrHGu8+fTU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLDD9i1jTkUId3+OoBv2t1oxIEOOpK25UDZAW7/c3ND1NPgwcRT
	prhgHjDXJfFg2IAzT/GpGvOcfuyp8NdNKXi/7GjannOBZha/kx+j/olf3/zawgyeru+AZkyXUe3
	cWcgOpqFju5BF/RvwYw4bfH4K/JbD3PU=
X-Gm-Gg: AYBFou3V3jNntsBkKjbacwXnSyw1OofPQPL8IRCM571n/W1K1CU6H7FjLnPmREJQMsM
	7RjWrrZgAYcYpnZ0dWZZ8SlLtXKdvM06NMb4+k6GiN8xAT4vC2JbFS3+ks6ozLwAcUt87Fx/iLw
	NGYuwkJzGfFBswwFUWTi2fnGryCxnsjvyd6aN/r1Y/Pb0Np2zWSvk5R3Gq/X3HBmunJj77elAga
	k4LGRG9Fb0TJuOYkdAxuuDPLgD/TVPUj0SyvzC3n4IQ5ikD4e15RBL68DD+MrRrtEfrFRAF0UCS
	BSZve3cxLV+pEAGKxcGYxtSspLnEBlLe6+cnJYjuD2BGlGzX3sOiqi9u+Q==
X-Received: by 2002:a05:690c:4191:b0:89a:63da:cbde with SMTP id
 00721157ae682-8ae39c24e90mr13846367b3.36.1790962108737; Fri, 02 Oct 2026
 10:28:28 -0700 (PDT)
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
Date: Fri, 2 Oct 2026 22:58:16 +0530
X-Gm-Features: AclHuK_-cjgeNcqjWWE-fRWp3-4f5pXhe0bXkxn9mUfCwvl8hZuFbXmIKRHKAIY
Message-ID: <CAMFFDGhCMr+9OV4ceo+SG=xrsoASB2AiFSUZwMJpyQou+eR-fg@mail.gmail.com>
Subject: Re: [RFC PATCH] soc: aspeed: Add B650D4U power passthrough support
To: Tan Siewert <tan.siewert@9elements.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, joel@jms.id.au, 
	ryan_chen@aspeedtech.com, Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the clarification Tan.

For context, I sent this RFC to document the hardware-backed experiment and
request guidance on the correct kernel-facing implementation.

Using the current OpenBMC integration with the B650D4U hardware, the host
can be powered on through the standard D-Bus command, and the OpenBMC web
interface correctly reports the server power and host state. I validated th=
is
on the real board before sending the RFC.

The RFC was therefore intended to obtain feedback on whether this sequence
belongs in the kernel or should instead be expressed through the existing
GPIO and pinctrl configuration. I understand from your review that the
separate SCU passthrough driver is not appropriate, so I will investigate
the GPIO request and pinctrl configuration and withdraw this implementation=
.


On Fri, Oct 2, 2026 at 10:17=E2=80=AFPM Tan Siewert <tan.siewert@9elements.=
com> wrote:
>
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
> >   create mode 100644 Documentation/devicetree/bindings/soc/aspeed/asroc=
k,b650d4u-power-passthrough.yaml
> >   create mode 100644 drivers/soc/aspeed/aspeed-b650d4u-power.c
> >
> > diff --git a/Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4=
u-power-passthrough.yaml b/Documentation/devicetree/bindings/soc/aspeed/asr=
ock,b650d4u-power-passthrough.yaml
> > new file mode 100644
> > index 000000000000..e6451d17955c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4u-power=
-passthrough.yaml
> > @@ -0,0 +1,23 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/aspeed/asrock,b650d4u-power-pas=
sthrough.yaml#
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
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
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
> >         Say yes to provide information about the secure boot controller=
 in
> >         debugfs.
> >
> > +config ASPEED_B650D4U_POWER
> > +     tristate "ASRock B650D4U host power passthrough"
> > +     select REGMAP
> > +     select MFD_SYSCON
> > +     default ARCH_ASPEED
> > +     help
> > +       Enable the AST2600 GPIO passthrough selector used by the
> > +       ASRock Rack B650D4U host power-control circuit. This selector r=
outes the host power pulse through the board's passthrough logic during pow=
er sequencing.
> > +
> >   config ASPEED_XDMA
> >       tristate "ASPEED XDMA Engine Driver"
> >       select REGMAP
> > diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> > index 5f61bb4cc36c..3e9618d1eafc 100644
> > --- a/drivers/soc/aspeed/Makefile
> > +++ b/drivers/soc/aspeed/Makefile
> > @@ -5,4 +5,5 @@ obj-$(CONFIG_ASPEED_UART_ROUTING)     +=3D aspeed-uart-=
routing.o
> >   obj-$(CONFIG_ASPEED_P2A_CTRL)               +=3D aspeed-p2a-ctrl.o
> >   obj-$(CONFIG_ASPEED_SOCINFO)                +=3D aspeed-socinfo.o
> >   obj-$(CONFIG_ASPEED_SBC)            +=3D aspeed-sbc.o
> > +obj-$(CONFIG_ASPEED_B650D4U_POWER)   +=3D aspeed-b650d4u-power.o
> >   obj-$(CONFIG_ASPEED_XDMA)           +=3D aspeed-xdma.o
> > diff --git a/drivers/soc/aspeed/aspeed-b650d4u-power.c b/drivers/soc/as=
peed/aspeed-b650d4u-power.c
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
> > +                                  "failed to enable power GPIO passthr=
ough\n");
> > +
> > +     ret =3D device_create_file(&pdev->dev, &dev_attr_passthrough);
> > +     if (ret)
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "failed to create passthrough contro=
l\n");
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

