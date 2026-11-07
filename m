Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC568606A837
	for <linux-aspeed@archiver.kernel.org>; Sat,  7 Nov 2026 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=euIfCb9T
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLyBk5RMvz2xyj;
	Sat, 07 Nov 2026 11:50:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1134" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794012622;
	cv=pass; b=eWUfwvFYjE4xuH0+F8aVsD5c0A6F5bA0io90L0DRVfpxLynIOrmE5th2DYGBIFdG7+jwKzLTKgDcCXwitKMmMH4tnvj84mKEIZjPQ4ZmqPk8a3jjqW72scMixYAbA/w5UBfsy8ljET3MEeqVv1R4RFo/wg0NquZlorifILd9wl3WKfw8J2FdGjNG2xAQyYQhzMKH5qBtgjL1RwTn8zwNSPChe+BT3u59OWJ22oR1UVTZpwTsdhX2cIQTCilihxf0WqKSDzbWWvf7cp04GGgUho8ud6mYFObhU4enQCfrF0E+3c4HvUECm3bR//ECMIi+hJakhwj8IYxGSiR5YGwdYg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794012622; c=relaxed/relaxed;
	bh=UDIdAIMbLFTYVUq+kbKb1q8+a8DtU0N+YUkvYxJXF6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtsbEz/in/bvWS3eYGKQV4VrIxskiY00brya8vPHf7M3fZIlwkl59FGeRjhexBzqfvaDBlpzlLmP9KetX/FdpLt3Q+TsCClUMD5cDfeBouiaWEVp9ejTk0+gHey8PTAT/rbv6xNPFFx32wsTWAXHGE5UNoifca9F+8/OUsPHqBrjRydGzP7awiDETF5sJ9wRL2ED5dPm53+eusBrSbM480IzU5OoB1kqK+9HflK54Wop/WMXoYKELN26kC1tq+MZkPVXD6n0//wtEKkSB6Ma8ceeNUJiWi8CFk7dznSTZ0sF7L5q+e3TZYEuRWvpqsL6KfeO7B35B0crJvaeXXf7Og==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=euIfCb9T; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=euIfCb9T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLyBh1DV8z2xGr
	for <linux-aspeed@lists.ozlabs.org>; Sat, 07 Nov 2026 11:50:19 +1100 (AEDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-8b312be5de8so11999847b3.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 16:50:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794012616; cv=none;
        d=google.com; s=arc-20260327;
        b=lgHKDd+B7Z9gqdg7owv6t+Wqdj1WH3Ued18WOUiGGaMXymw2wUxurxFOo6jfUFasgV
         uLi//CQOZ26Y3/WwuH5hvH+QHzCqXOUWN3S55n/gF2YSu9y5Fqwo5NSh86FzPtxgX/3i
         wTnDMt9/9zw28/rf0S6tmmsxQbmZ20vA/510dM+mZgGt8YFQftcqJX8npUkN4uv9+J5h
         ZmI4fHaVlu/hUvu4UwUC9VJOJV87sO/iiP0iCQ6mqtYLoRD6xo4D5BNx4LWsEHZCnqI9
         6Nz9JH7BmgHUBZYtpof2UQFwUskPiPu5zzOQp20kuIfbOlSdTBrKxYQLi1aZOnhknZWo
         DVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UDIdAIMbLFTYVUq+kbKb1q8+a8DtU0N+YUkvYxJXF6k=;
        fh=6FMNr+zIXrTwSvI1lMYgMOvgfkVuzsBdxbzIr65mgf8=;
        b=G4ZdR+gpYhhOAm1DocNWUvxyLk02hfF4BrX7WlGDfmJppJHcnxDw5NTwL4OsyoDv4t
         dCDdBLAmXENUVyHNU/ftb44rYsjjSe4aIaUg26KxZDvrNMj0eNfdfJdWQGEf80ATuyhl
         6pjAXGLYzi6UQDAx9Qnpl15YdcTztR+qqwBQaaTstSO8Ajk4hV4pUlAKi2YrxShTWgbV
         4iAD4aV1D3WieXvnbQ8/XNazObSYGdWc2oHNCIFt9xXfb4dk1ltVcvFSFaAjvk2r9sOG
         y3+FDFV3MtLH/woweIcQtXUNDio03AdP7yx4GvEGy03bX3Q7PjavSPLcatfCS8Z673T7
         ommg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794012616; x=1794617416; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UDIdAIMbLFTYVUq+kbKb1q8+a8DtU0N+YUkvYxJXF6k=;
        b=euIfCb9T1/EgL/S+vJUz41APOZ5nVihMqpHMBGyqMk1bdFRtLN6xF4r6tgQCklybPc
         /1hhp34FDOMMLBQCpf61NiyM5EvYj+ACiuANuuT6ZZltSj08ZmpVt63f+EsJ7sW1/Xb5
         LmVn2xe4N8YfaYQUr3agoCeXhNDKu0PwlLUpQDbnFGlwhv5mywQZxKnj4ZeJc8dS+pib
         LWMfQ0+b97qJomUyJJHEPJq0Z2IMh5mEs4Y3NuK9uLfHO7CJoKiMs+MexwwBy1YrWZ8z
         SEQcPEhbOlq2FSujMyXUTVKUEhYy4SRQZUWLywB+p5ZND26qFBeOzxMxkXaOkPkwizHq
         Eahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794012616; x=1794617416;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UDIdAIMbLFTYVUq+kbKb1q8+a8DtU0N+YUkvYxJXF6k=;
        b=wdMvgJ8xrSf4Ra2BRcNyhv2wKtY05uHD8jh8v7YV4vedH2rCUSOkrL18VYhsvAHkL1
         gbXLgfk0WT52IS5bMvqa7j5KzkRRM+4aI1HojZSmdVSvIiftA6jzV2NsHbMv1qoVHMsR
         gpDYYgfG/mcnColcSHC8In0s34UrReh8tjZpADyne4dO53bnMoA+ddpiYQU7LnreOP85
         9/qY4Tqj9+doaOMK4M487ME8WYxCD0+gPTnsGr5UkKJvcRQ6jyLh6v/vCGPpYA93o1DV
         0Nyw7mf9xCRCxKltOdi4Wzqx9TKWnFPZwtFYleD2tPYLTGw+Y6idXccF7SWNkzIHiDjh
         5E9g==
X-Forwarded-Encrypted: i=1; AL+hErHc9L3ejh4MFW4fV/Qvn8P9x5OtMm+gBI9IhaOGEvpAbewOCdSOZ9qeSHXOeeTReUxXM01xA7bf23KZxO8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8X/R58cwD68fBsBCKW0r9iODancWp4FZxPzW1/vbBAav0BH5nZ
	97CfO4I0rfe89CUybsw1E/Weji/CTtD4tDecmUzA3UixUdaW+9AAaS5II6od1rZxLxOB1R5GTUr
	L3Bx8esAm9KwOosi09z5uqW6ppaPFCKc=
X-Gm-Gg: AYBFou2r2pSdwFN2Rban7r1Xpk88uggVeGPBqqmwdBSQr8ToA0LTUC8Gmd/j0XTpQui
	oLv21y1C32760A4kuGby4pOBTYIqYXhAaGrdD6dXjFqTt+qY1AJhbKnJTdge3uu1eleyPsM4clH
	uw4+oF/0SbaGKV9uoI3vZoPav0avIKgBkZXj3eFADfc7HU6rHY0qRnESbBdWl6Qjt+863CZt4EQ
	mESd+yKkIJ/QUiriUtTVIuFfxzuO7sXYdm5GfEPzKw3WyHl7cd5k0jzU7AKQsGM47IdKkJ9qKO6
	YxrEDYgnAp7ipmUJAHxXrK5DRAGjMWHdFR0FwrbYTNPlcsaW4UNIWKbyAgynapFRYJFkB8N9fgS
	XP/ff/P9/Fs89gj1TN6v56WybJwslzM1Lz4GX3C9n3+Bn0Uf6jCj4PFIB408=
X-Received: by 2002:a05:690c:d8c:b0:8b3:f05:dd6d with SMTP id
 00721157ae682-8b34192ea67mr20495907b3.45.1794012615901; Fri, 06 Nov 2026
 16:50:15 -0800 (PST)
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
References: <20261105152348.8567-1-prasanth.padarthi10@gmail.com>
 <20261106022907.10735-1-prasanth.padarthi10@gmail.com> <20261106022907.10735-3-prasanth.padarthi10@gmail.com>
 <71eb94df4d373d0f3afbe2a8ff880869f96e054b.camel@codeconstruct.com.au>
In-Reply-To: <71eb94df4d373d0f3afbe2a8ff880869f96e054b.camel@codeconstruct.com.au>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Sat, 7 Nov 2026 06:20:02 +0530
X-Gm-Features: AclHuK_zfgDPcux-rGy0j0Dx_Q046t2jqfjZUDa9PKNbMEPl2IK8UVzJpqMRhCY
Message-ID: <CAMFFDGgebSfVGfogTG--kpOnGNP5UxWVUGW2g_Sej_18FybNVQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] pinctrl: aspeed: Hand over global GPIOP
 passthrough to local mux controls
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linusw@kernel.org, Tan Siewert <tan.siewert@9elements.com>, joel@jms.id.au, 
	ryan_chen@aspeedtech.com, billy_tsai@aspeedtech.com, brgl@kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

Thanks for the detailed review.

I'll address the naming, error handling, and implementation concerns
you've raised.

Regarding the necessity of the patch, on B650D4U, GPIO-only power
control failed with SCU51C[9] set. In my hardware testing, clearing
that bit allowed remote and physical-button power control to work.

However, I haven't yet established whether this requires a pinctrl
driver change or can be handled through existing initialization.

I'll investigate the existing pinctrl path further before sending
another revision.

Thanks,
Prasanth

On Fri, Nov 6, 2026 at 4:24=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Prasanth,
>
> On Fri, 2026-11-06 at 07:59 +0530, Prasanth Kumar Padarthi wrote:
> > On B650D4U, GPIO-only host power control fails when SCU51C[9]
> > enables GPIOP passthrough, even after the normal GPIO request path
> > clears the individual SCU4BC selections.
> >
> > Transfer globally selected GPIOP0-P5 THRU roles to SCU4BC[29:24]
> > before registering the controller, then clear the active shared
> > sources. Leave PWM selection and the strap-source selector unchanged.
> > Clear SCU510[28] through SCU514 and verify the shared enables cleared.
> >
> > If handover fails, retain an instance-local error and reject affected
> > GPIO and mux requests before changing their mux state. Check every
> > pin in a mux group before calling the shared helper. Retain prepared
> > local selections after partial failure rather than blindly restoring
> > a shared enable.
> >
> > Probe-time normalization policy, concurrent SCU writers and
> > post-handover registration failure remain open design questions.
> > Electrical continuity, mixed-pair forwarding, protected-write paths,
> > PWM coexistence and SCU510[28] hardware handling remain unvalidated.
> >
> > The implementation passed remote power-on, remote graceful power-off
> > and physical-button power-on tests on B650D4U with an OpenBMC Linux
> > 6.18.24-based kernel. The rebased version was ARM compile-tested on
> > v7.4-rc1 using aspeed_g5_defconfig with AST2600 pinctrl enabled.
> > With the managed-registration prerequisite, the v7.4-rc1 version
> > also completed one unbind/rebind cycle under generic KASAN on
> > B650D4U hardware and in AST2600 QEMU. Host power operations have
> > not been retested with the v7.4-rc1 kernel.
> >
> > Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> > ---
> >  drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 145 ++++++++++++++++++++-
> >  1 file changed, 141 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinct=
rl/aspeed/pinctrl-aspeed-g6.c
> > index 85d6640ff..be22a9184 100644
> > --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> > +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> > @@ -4,7 +4,10 @@
> >  #include <linux/init.h>
> >  #include <linux/io.h>
> >  #include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> >  #include <linux/pinctrl/pinctrl.h>
> >  #include <linux/pinctrl/pinmux.h>
> >  #include <linux/types.h>
> > @@ -36,6 +39,8 @@
> >  #define SCU4D8               0x4D8 /* Multi-function Pin Control #23 *=
/
> >  #define SCU500               0x500 /* Hardware Strap 1 */
> >  #define SCU510               0x510 /* Hardware Strap 2 */
> > +#define SCU514               0x514 /* Hardware Strap 2 Clear */
> > +#define SCU51C               0x51c /* Hardware Strap 3 */
> >  #define SCU610               0x610 /* Disable GPIO Internal Pull-Down =
#0 */
> >  #define SCU614               0x614 /* Disable GPIO Internal Pull-Down =
#1 */
> >  #define SCU618               0x618 /* Disable GPIO Internal Pull-Down =
#2 */
> > @@ -2743,12 +2748,56 @@ static struct aspeed_pinctrl_data aspeed_g6_pin=
ctrl_data =3D {
> >       .nconfmaps =3D ARRAY_SIZE(aspeed_g6_pin_config_map),
> >  };
> >
> > +struct aspeed_g6_probe_data {
> > +     struct aspeed_pinctrl_data pdata;
> > +     int thru_error;
> > +};
> > +
> > +static bool aspeed_g6_is_thru_pin(unsigned int pin)
> > +{
> > +     return pin >=3D AB22 && pin <=3D AB23;
> > +}
> > +
> > +static int aspeed_g6_gpio_request_enable(struct pinctrl_dev *pctldev,
> > +                                      struct pinctrl_gpio_range *range=
,
> > +                                      unsigned int offset)
> > +{
> > +     struct aspeed_pinctrl_data *pdata =3D pinctrl_dev_get_drvdata(pct=
ldev);
> > +     struct aspeed_g6_probe_data *g6 =3D
> > +             container_of(pdata, struct aspeed_g6_probe_data, pdata);
> > +
> > +     if (g6->thru_error && aspeed_g6_is_thru_pin(offset))
> > +             return g6->thru_error;
> > +
> > +     return aspeed_gpio_request_enable(pctldev, range, offset);
> > +}
> > +
> > +static int aspeed_g6_set_mux(struct pinctrl_dev *pctldev,
> > +                          unsigned int function, unsigned int group)
> > +{
> > +     struct aspeed_pinctrl_data *pdata =3D pinctrl_dev_get_drvdata(pct=
ldev);
> > +     struct aspeed_g6_probe_data *g6 =3D
> > +             container_of(pdata, struct aspeed_g6_probe_data, pdata);
> > +     const struct aspeed_pin_group *pgroup =3D &pdata->pinmux.groups[g=
roup];
> > +     unsigned int i;
> > +
> > +     /* Check the entire group before the shared helper changes any pi=
n. */
> > +     if (g6->thru_error) {
> > +             for (i =3D 0; i < pgroup->npins; i++) {
> > +                     if (aspeed_g6_is_thru_pin(pgroup->pins[i]))
> > +                             return g6->thru_error;
> > +             }
> > +     }
> > +
> > +     return aspeed_pinmux_set_mux(pctldev, function, group);
> > +}
> > +
> >  static const struct pinmux_ops aspeed_g6_pinmux_ops =3D {
> >       .get_functions_count =3D aspeed_pinmux_get_fn_count,
> >       .get_function_name =3D aspeed_pinmux_get_fn_name,
> >       .get_function_groups =3D aspeed_pinmux_get_fn_groups,
> > -     .set_mux =3D aspeed_pinmux_set_mux,
> > -     .gpio_request_enable =3D aspeed_gpio_request_enable,
> > +     .set_mux =3D aspeed_g6_set_mux,
> > +     .gpio_request_enable =3D aspeed_g6_gpio_request_enable,
> >       .strict =3D true,
> >  };
> >
> > @@ -2778,15 +2827,103 @@ static const struct pinctrl_desc aspeed_g6_pin=
ctrl_desc =3D {
> >       .confops =3D &aspeed_g6_conf_ops,
> >  };
> >
> > +/*
> > + * Experimental: transfer the global GPIOP0-P5 THRU selection to the
> > + * individual mux controls before registering any pinctrl consumers.
> > + * PWM selection is higher priority and is deliberately left unchanged=
.
> > + *
> > + * Do not undo the local selections on error: a shared enable may alre=
ady
> > + * have cleared. Keeping the equivalent local selections preserves rou=
ting
> > + * while rejecting affected requests, rather than granting an unsafe G=
PIO.
> > + * Signal continuity during this transfer still needs hardware validat=
ion.
> > + */
> > +static int aspeed_g6_thru_handover(struct regmap *scu)
> > +{
> > +     const u32 local_mask =3D GENMASK(29, 24);
>
> Defining a variable with the value (even though that variable is
> qualified const) means it's not an integer constant expression, which
> may impede some optimisations.
>
> Further, local_mask is not a descriptive name for what's occurring
> here. Please name the mask in terms of its behaviour. Perhaps:
>
> #define GPIOP_UNGROUPED_PASSTHROUGH_MASK GENMASK(29, 24)
>
> > +     unsigned int strap2, strap3, local;
>
> Please lets improve on the name 'local'. Perhaps: ungrouped_passthrough
>
> > +     int ret;
> > +
> > +     ret =3D regmap_read(scu, SCU510, &strap2);
> > +     if (ret)
> > +             return ret;
>
> Consider this error-handling strategy:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/pinctrl/pinctrl-gemini.c?h=3Dv7.4-rc1#n2556
>
> If the first read doesn't work, then we can't expect any of the further
> accesses by the core aspeed pinctrl implementation to work either, so
> we can just bail out entirely in the caller.
>
> > +     ret =3D regmap_read(scu, SCU51C, &strap3);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (!(strap2 & BIT(28)) &&
> > +         ((strap2 & BIT(30)) || !(strap3 & BIT(9))))
>
> Please give these bits named macros. This is not easy to comprehend as
> it is.
>
> Also, consider FIELD_GET() from include/linux/bitfield.h. Something
> like:
>
>    if (!FIELD_GET(OTPSTRAP_ENABLE_GPIO_PASSTHROUGH, strap2) &&
>        (FIELD_GET(OTPSTRAP_ENABLE_DEDICATED_STRAP_PINS, strap2) ||
>            !(FIELD_GET(STRAP_ENABLE_GPIO_PASSTHROUGH, strap3)))
>
>
> > +             return 0;
> > +
> > +     /* Preserve every globally selected role, including under PWM. */
>
> This comment feels like a classic LLM statement that somehow manages to
> be simultaneously both too abstract and too detailed, while also devoid
> of context, all in 8 words.
>
> Can we rather say that the PWM functions on these pins are higher
> priority in the mux than the pass-through GPIO function, so if PWM is
> already selected, then the following write does not affect the PWM
> configuration?
>
> > +     ret =3D regmap_update_bits(scu, SCU4BC, local_mask, local_mask);
> > +     if (ret)
> > +             return ret;
> > +     ret =3D regmap_read(scu, SCU4BC, &local);
> > +     if (ret)
> > +             return ret;
> > +     if ((local & local_mask) !=3D local_mask)
> > +             return -EPERM;
>
> Please add a comment here about the write-protection in SCUF30.
>
> > +
> > +     /* Leave the inactive GPIOZ6 source alone in dedicated-strap mode=
. */
>
> 'dedicated strap mode' is a confusing statement because ASPEED's
> documentation is confusing. I think we can drop this comment with
> regard to making other improvements.
>
> > +     if (!(strap2 & BIT(30)) && (strap3 & BIT(9))) {
>
> We've already inspected these bit values previously. Please consider
> extracting them to bool variables for re-use and to improve everyone's
> ability to comprehend the expression.
>
> > +             ret =3D regmap_update_bits(scu, SCU51C, BIT(9), 0);
>
> Essentially, having configured the ungrouped passthrough functions
> above, we can now de-configure the grouped passthrough function in
> strap3 (SCU51C).
>
> It's probably worth noting in a comment that SCU51C cannot be write-
> protected.
>
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     if (strap2 & BIT(28)) {
> > +             /* SCU510 is write-one-set; do not use an ordinary RW cle=
ar. */
> > +             ret =3D regmap_write(scu, SCU514, BIT(28));
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     ret =3D regmap_read(scu, SCU510, &strap2);
> > +     if (ret)
> > +             return ret;
> > +     ret =3D regmap_read(scu, SCU51C, &strap3);
> > +     if (ret)
> > +             return ret;
> > +     if ((strap2 & BIT(28)) ||
> > +         (!(strap2 & BIT(30)) && (strap3 & BIT(9))))
> > +             return -EPERM;
>
> This appears to be the negated expression of the earlier one, and given
> we're only returning a fixed value in either case, you could rather use
> the same expression again. Given it's repeated, you could extract it to
> a macro or static inline function.
>
> > +
> > +     return 0;
> > +}
> > +
> >  static int aspeed_g6_pinctrl_probe(struct platform_device *pdev)
> >  {
> > -     int i;
> > +     struct aspeed_g6_probe_data *g6;
> > +     struct regmap *scu;
> > +     int i, ret;
> > +
> > +     if (!pdev->dev.parent)
> > +             return -ENODEV;
> > +     scu =3D syscon_node_to_regmap(pdev->dev.parent->of_node);
> > +     if (IS_ERR(scu))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(scu),
> > +                                  "No SCU regmap for THRU handover\n")=
;
> > +
> > +     g6 =3D devm_kzalloc(&pdev->dev, sizeof(*g6), GFP_KERNEL);
> > +     if (!g6)
> > +             return -ENOMEM;
> > +     memcpy(&g6->pdata, &aspeed_g6_pinctrl_data, sizeof(g6->pdata));
>
> This seems unfortunate.
>
> Have you considered other approaches?
>
> > +
> > +     ret =3D aspeed_g6_thru_handover(scu);
>
> Must this logic be separate to the usual set_mux path? If not, I expect
> we don't need to retain thru_error.
>
> > +     if (ret =3D=3D -EPROBE_DEFER)
>
> Do you have an example of how ret could be -EPROBE_DEFER?
>
> > +             return ret;
> > +     if (ret) {
>
> If this handover logic is to be integrated here, can you please test
> for specific return values to separate the regmap access failure from
> the write-protection failure?
>
> Related, I've heard opinions from Tan that this patch is not necessary
> to get the platform booting. Given the current complexity, I'm
> interested to hear whether you can do without it.
>
> Andrew

