Return-Path: <linux-aspeed+bounces-4956-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DCAC61DD6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 03:23:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb4gD4LB8z2y2W;
	Thu, 03 Sep 2026 13:23:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1131" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788404900;
	cv=pass; b=SkGONylg8DrQn62x8IrK3ZiqnO3eCdPwZzCKdAKjVCtSGq2Mzh9KaTnITbq6Z7cFB8+1zBDs+UBD0FCPzDyETX7PpzkDri6u8pC7WX/B9ylDBF9xmdUeNivWJCTq/yBr7t1yeiM3o0HEK34FmMEHGNggLjzHUxaq5K5OqbxgPrJC+BhV4dQGtAPMXfMItZSYzUoIV6764ywxFllX4vOYyCzpBuPNKMyG3P7yWn+JRb7d2yh8Y544elra/k0fEMEhOT4r5riGEoY4i85rMCia4dj2fG4K9IJq7mgpibQiLDdHseWIFJhQQKR9IxKQSAyRC8HUsapc2+nay8PTTBulrA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788404900; c=relaxed/relaxed;
	bh=SnzwBfRZpBf2cJeykyMmu4E583GVHfgU8A+PMrUbmFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbuzW7rcATz+vRiJW0wuAGBLo+arijNFX/HboUtddGKpwG74q2Hp7GYp9VTqY5lXL60y/msDzBJ5cLXryP1NjWna8PDtYtsn8pUaXqb65tIU47+iS1yEn/+iwbMDR+r5SKTpi+5XlR5Q6fzkSf+A++NKvD3iqOAd2BZ1PG7USc0YkbSi6b1sGIdOKjM1v17DtcwSQpVxfk6GFfYkLyULBnzb/GyiZdVrcSXXtddUmV5QW4c2KOr6YSUnQR74+LWuyHm4rF28/21/llcVjweUWaI+Y1O6HlFgqjHtaLXz3Onbn31a2oMksaFC1EVw+znxhFrlnthHj0buLFF9WCOXSA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fqY5s8o3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fqY5s8o3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hb4Kt3Ybgz2y2M
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 13:08:17 +1000 (AEST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-8588583a7c3so23665527b3.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788404895; cv=none;
        d=google.com; s=arc-20260327;
        b=KXy7jtlwBmP2WDrqan8INX7hPheqYNIzuB/IUix9c1ZOYrWTRk4mCKi/YIrTFn2dU/
         RgF3TNXAnwOZUXYqqqGI+0+Bojc4pazCVmChSHCBtnduZeC1+RAjGnalDZTXSFX4gfRf
         v521VG/jI47kfFcaUN2LAUIhgY63hnHIc7nIoXckbW3wACBxcZVJRhE//ma0EHTmckHI
         wAM92tAwRlbgNsIqejyLvD7aIhE/Q71TGm+F++tBqs1hhJKAU2mLHqq/cQFxrwLA2+S4
         3USv2dDDXUps2df+fIpwcCcFFj4NODxP3aWjPcknk8ogbjz6HYMSPUzZFFAHFDuQN6Qy
         KJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SnzwBfRZpBf2cJeykyMmu4E583GVHfgU8A+PMrUbmFE=;
        fh=8PP+0VV4N5qJJ8Ms/QX2mtOI8xDlEolGsefo+vLvAIY=;
        b=sRdeWzYDGqVWJ4AsB3t9xs4zDjNvNagjmRJktakCgb89ICgLT0QvF5iFbyq6bJ+ekt
         fkv8nIXfVzNwAqsj+BMJExxIVZsvTkr06LPhMHJwdo47jHPUvCnpn58EUmrI2CQT1RUy
         lq/EMkvIFfVn+pUNrmn4fiEf6t1qZ3xgwj+Hr/OlXgnrHYfh/HZuKHZbABmJ3ibI8/q+
         ZS2EbzY1RiF2kBb/kw+8Df0qMECRQX1xfqWtn2JTJ9AuCq4K8eMabEgli68ti8l7s/qt
         R7fzatCWerV/fhFs7TVzp2U7rgYM7tHdVuhk1fiRf1lClbshSimNAluBR6ln6QW0yOVf
         2xHw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788404895; x=1789009695; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SnzwBfRZpBf2cJeykyMmu4E583GVHfgU8A+PMrUbmFE=;
        b=fqY5s8o3HJD5ycu0UFJx0awULRq0IQIClEaaQixNTfW2/rARC/vqKMv0zv2b7bqoDM
         EHTKgVLsUlrQScF2oIXKpFgM8VBiwrDzlpYhB5zGaei6sA4Tt+/2vlHk4X28407jjZbW
         2MSc4UKi3t0d4E3p5Xli3k7ljxDBy5mgZ/FVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788404895; x=1789009695;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SnzwBfRZpBf2cJeykyMmu4E583GVHfgU8A+PMrUbmFE=;
        b=Z1/LMl3fYB8L7Dd4REfFSEJ0A/Lvtty8qGjsDwr9GJxFFU3vQ8L/UPXb8e6vzLJNiL
         jPDjFUptkQFnskzQmyu9bRwuP6vQnl6DWruZyqjmZ2lU7PlISBtl1FtnJvWLrCrYNJzP
         BDsWMeOGgkK1tQNPKSDa03cjtZSdQ1uka/3WvYfYGaWyUUvPKUnahP2kJHfrmGyKnIko
         bkzWmxk+heoM84vV8lwdvuySyWGdghsi+4f63B3J+0W94ZMkx075qwwVH8Tjfyo5zsx0
         weOTQvNoh3b54GFp87sPSLjuquo0NajY7ArSfHCZ00xhmD10Eesl24pUYK2yeTmKw146
         Evog==
X-Forwarded-Encrypted: i=1; AKwUvBw3CRa5wdPDhAP20DCeeuIkoj8DwqD0nsl4VhO47BX+IInCGT0koaBjE/mrVcL2ItQNzniZnXjTDnUN+iQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lkqnQyEMlDsMMspF15qMyrKHpa4xCTJBMn3foph7+04kktWlni
	sRxsB1Aof1Liq+BNYnHfjnjYJyxseUiQwDCujGcQZGhlyNW3YtlIWIw1eepAMWyxlsog1nFZVoV
	oXjCJE81lhBWoFqkGJHV+wBgy8upsid5NGTbwB2df
X-Gm-Gg: AYBFou0XU7uog5lbUo4YfVo+X82jA4HkJEBz3/k4JyfAQbxAx83pTQIU2NKq8fZ2WM9
	h94iD4U3KleNYzdsjz+2a+nJvpPjGyI2PAIa6UcN9hO2Htp6mNv+4K405g+ySL0mRktO3/fCl+p
	JUccu2nA1/J1AnZXd+WzEkAF3TyIVgtPFP/hzrnIpWFqcW0vzMZg7rp/X+1vncbzbR9ED6dAox3
	+Qb0uDfEtabwQyhhPceNoBPMoa4fDDNGTm9azqU2yNwIeMhyKlFBhvr/Nq0w4IFNytuecKl+Fg6
	R61FYHf2SsO9jTd4cGjER1x8PaHaeFeDpC+QiJ4Q5Yobma7FlvPM2j0z/2hBIjdOtS4+1W/3W7c
	=
X-Received: by 2002:a05:690e:400f:b0:66d:113a:3928 with SMTP id
 956f58d0204a3-66f9bb6f3famr3574226d50.12.1788404894746; Wed, 02 Sep 2026
 20:08:14 -0700 (PDT)
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
References: <20260902200703.2016410-1-mukesh.ojha@oss.qualcomm.com> <20260902200703.2016410-6-mukesh.ojha@oss.qualcomm.com>
In-Reply-To: <20260902200703.2016410-6-mukesh.ojha@oss.qualcomm.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 3 Sep 2026 11:08:02 +0800
X-Gm-Features: AcwNN1Wn32BWTc7gvrI5NCynGubfvPlrWgUmvLkoMfGnpAB8yTnTJoIOOvbhgBM
Message-ID: <CAGXv+5E9zs7LsK=d08NB6QcuHkaPw4GcifuDuMDz0CVB6gB=8A@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] media: mediatek: vpu: Use devm_of_reserved_mem_device_init()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Daniel Scally <dan.scally@ideasonboard.com>, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Minghsiu Tsai <minghsiu.tsai@mediatek.com>, 
	Houlong Wei <houlong.wei@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
	Tiffany Lin <tiffany.lin@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Joseph Liu <kwliu@nuvoton.com>, 
	Marvin Lin <kflin@nuvoton.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Maxime Ripard <mripard@kernel.org>, Paul Kocialkowski <paulk@sys-base.io>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com, linux-staging@lists.linux.dev, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 4:08=E2=80=AFAM Mukesh Ojha <mukesh.ojha@oss.qualcom=
m.com> wrote:
>
> Use the devres-managed devm_of_reserved_mem_device_init() instead of
> the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
> pair, letting the device resource manager handle cleanup automatically.
>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/media/platform/mediatek/vpu/mtk_vpu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/mediatek/vpu/mtk_vpu.c b/drivers/medi=
a/platform/mediatek/vpu/mtk_vpu.c
> index 8d8319f0cd22..557bffb2c2f1 100644
> --- a/drivers/media/platform/mediatek/vpu/mtk_vpu.c
> +++ b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
> @@ -888,7 +888,7 @@ static int mtk_vpu_probe(struct platform_device *pdev=
)
>         dev_info(dev, "4GB mode %u\n", vpu->enable_4GB);
>
>         if (vpu->enable_4GB) {
> -               ret =3D of_reserved_mem_device_init(dev);
> +               ret =3D devm_of_reserved_mem_device_init(dev);

There are non-devm calls before this. Inserting a devm call in here
messes up the unwind order and leads to confusion. In other words
this is a bad idea.


OOTH, the remove function is missing a release call.

>                 if (ret)
>                         dev_info(dev, "init reserved memory failed\n");
>                         /* continue to use dynamic allocation if failed *=
/
> @@ -930,7 +930,6 @@ static int mtk_vpu_probe(struct platform_device *pdev=
)
>  free_d_mem:
>         vpu_free_ext_mem(vpu, D_FW);
>  remove_debugfs:
> -       of_reserved_mem_device_release(dev);
>  #ifdef CONFIG_DEBUG_FS
>         debugfs_remove(vpu_debugfs);
>  #endif
> --
> 2.55.0
>
>

