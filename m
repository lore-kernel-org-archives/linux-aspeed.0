Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA015606A31E
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Nov 2026 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wax+6Vc9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY1174HBCz2y7p;
	Mon, 23 Nov 2026 20:31:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b133" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795426315;
	cv=pass; b=omWTxBW+2XdLNYU18rKYwWJQEt4YaofMZRlyctAx5frj6GXkRal8kFmynSdMO+Ps6gmIuxEIKtcEQibDblPxG+n6oosXzb3QAcnEH4W2A3dbC72YrTD7EITncS2rEAgH9ZtAId3Fgy1lPdjb3qSq493s7ZDTKZU3gzcZKzLMxeLBHMff/t8rq1EamJs9+pjvXLScmIl75WzRMBNIXwLF9tUrcDJpoSit+dpL+ovc3ocvyu75WkafAcBzdTA5Q2+iUY8GL4QwJq7EOP4fHtp0zZA4TqVgkP8JcEwuUjbVc99Zy1DrUNFfyC+MKlAHZE6XF/EXCg4RThcOyJNIQ6gxOA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795426315; c=relaxed/relaxed;
	bh=sA6A+HVLCaq1WHRrrdPMSMYH1omsgOJBkasA2HvpXv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JI+sCFQ4JZdH8P35U+LLo4hTq8z4Dspu5BwanOT90TnOtJnD3NMHD7Hg7uGgFuTCTy2P6r6F+pObS6f8JtdpbuhfU3iibFRcWaxeXsgS+SeYdlOE4esQZogHqe1afzH3AG515QoUcKPDi6LMNneeHd2Z+CDYbCQj6v3UJKsGWROpwLQyT67i1vJVMPHyqG8lvGz6IWxjLiKPVOOHor9Pi3ZRJ0w6XwCviZZdZ/2gRMN+WvuDRaZLKZ4ljOaf8MiaQhkHyONxSeILm7vz7AoMXxZN1obu4jpawlLCtVjmR79wrFQd93W70cXH5ZlGNYI80pr6/06SyuV17BAbhM+55g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wax+6Vc9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wax+6Vc9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com [IPv6:2607:f8b0:4864:20::b133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY1166Sjsz2xyj
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Nov 2026 20:31:54 +1100 (AEDT)
Received: by mail-yx1-xb133.google.com with SMTP id 956f58d0204a3-67da62357acso3886038d50.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Nov 2026 01:31:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795426312; cv=none;
        d=google.com; s=arc-20260327;
        b=MVgfGOiVJysub7QIqyYoQ7EI/TGTxSBwS+XDSaXtR+HcmhVxlSKtavMcqviOzCwkI6
         jtfRnIao8vGhQ/3IsfT5mhTO/NYGVInPHg71vhl7thXYyZbb7fMbidofiEhlTbaY3fMC
         tQapXL6wtI3wHA/nrTmbMAUfsvYqvHzyPKoXHLJ3nNksfqlAdMdQnT2IFG7qXp9U8+eF
         o6gwexsMYduQi1TIdyJ01l1qIUrds/SRF2sGno6gnbPkIbG0ovHFmLNuR3tlK8+OHtiZ
         zrFXGLf/Z2VD0cztMbm46sdTyet3pUBsTfg8dT0lz5K2A82xwrF81zr10Z68E1Wf3NyI
         UWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sA6A+HVLCaq1WHRrrdPMSMYH1omsgOJBkasA2HvpXv0=;
        fh=EefYiSVC1q6sv6TZwKqo7exVvAi0DN2G1PmH9HtcX1s=;
        b=p7sZspiXkWqfoHQhBtqU1mVI6IHR3J/ZAT4J8xtE8WkWeOl0ZdSuGD82GCi1zTcvDT
         UUNG9na2YaguTFmDnFz6BwJ+bnsNLoRgsI+/eKyVUZ1bkZF/gn0+ZaJGZN7+YMI8GCG+
         R0mX2dTdBOel9oVoxbVLqTK0WBJzIFDw1r53LLyvv9/Ak2uX3a10Rwi7MpnWhDmptDu0
         inXUExJhF35GrDifq+6qePx5K6esXZDjlmoEhQtFF6KaGJvybp1oFvnvtIgP6CedKqsl
         W6gESysgbctOQx++EIUABkFcpyF4/EK4LdCv0oGkHHvSpzfIMyuQ88Fbp8SOOkol0Ddl
         UqlA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795426312; x=1796031112; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sA6A+HVLCaq1WHRrrdPMSMYH1omsgOJBkasA2HvpXv0=;
        b=wax+6Vc93HqHpyIPEmZEzKuTF93S7SQJTdRKMBM7dTb6K3C/Lklg7LnZA+SpAU6oHM
         vdAVUaiwOecg+jU3VRScQ9KiEnLgTbAeRUklbWZ04JY1ihROcnZ/6QCvgXAhv5TI6kof
         they/6FHMwkhLfPvjnfoTltNxwMQxfrstfWRhXNx/o00wUcAJzotJmJC+DdwQ21sm/fl
         r2gZUJHQdnBpZU1o4byEaD1h2twuThrBvR0Zy9Kl7LgUfcuDJsp1qHjMwmEXgGASwlo1
         TpUev40Pdaqu5dRyMgVKNPjAf+0qUtjS0cwXrPRr5JultufeZaIrY6A8Oq2mauuWcUIs
         ynVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426312; x=1796031112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sA6A+HVLCaq1WHRrrdPMSMYH1omsgOJBkasA2HvpXv0=;
        b=VpC1UNqdz6DkcSpT2TZl/lY+yb6zxO9tuhdG4Givbz9lM8ekOlZAhjjumo5OJoDtXO
         pMsX0yrQIY8at7iNcgyjMcT7Y24CsdEJqpfWxp2YcFjahzDM7ACEzkaHgqgNXrPgiaSO
         XYdV4R66BPlzOdKxUU9O6ncwXsUwPGynahdvVmGmMabaI0ihyrY3rbbuw7M9v3KSoHu5
         +X3LKTDS9LR0RFmx5noGuMoNGs0j92aKQRAoAo4u5qB85wGTcd6vLXFJbqtx/AyTIyZ+
         h2qnho6jqKjx5KQ5UO51LPQGwi6xS9xQppo4WT8g8pPpi2gZZqApTjWBSNQCKFtxfOIb
         2dbQ==
X-Forwarded-Encrypted: i=1; AL+hErG0ODjX+fQGxSW/Mh16jAJhjEyihJsXIe05bAms6pksiEojH+UoIgdQWwQYETRALmumtkTlRliTclsJ5JI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z91Y1xF7j9ZWGOIYW6qdMbKm+DaoSn3hTtVXBfOKaUldDfaesVk
	xTqLcH1X4LvZdV7XdRxz4U5gQQo4xIPOxaWXVa6q8CHlbjd9G7di9Mk/tBaxsjeOjRtZzASXRbC
	bvYEmZYdHKF9ANUMpyHG4JqrqMz2Y/mU=
X-Gm-Gg: AZFdTZfL6+zSZVGOViOtfQGEXxMK9ylU053a0USNQQpdMYPEIZktt3jwBbKeYYYhHen
	NhVzv7UncFlGzYIUCUePT8KuxZKiPuKQg+BXyIluvyTglsNPJVTXQ/Q8JK/ZpyK02vgvOxS4e+W
	keBxE3WdxyzUEYV7mgGISws+SWTawsAt0KWMisArZzS/5PaU62y07wY9YHDe8G5GIW2a1EqRw6Z
	glyRCsBHo0d8HmCWbQtEvlapZWKtcZg5wPjLEWuEAkZeLT7Qp2h/eKcWYzhyBw4GjcpOC35a1yu
	Fp2jBijANhjFgQI6sx2d50f1twanO2fn9QSTc3CslR+06ZB2BsdQR7FHE8BySxaCbxC7VkEardP
	UNJtm4tOQBecj+2cbOreYjki98+cXwV3ELZj4rg==
X-Received: by 2002:a05:690e:438c:b0:67d:a6fc:6ba9 with SMTP id
 956f58d0204a3-67df4508943mr2085122d50.106.1795426312499; Mon, 23 Nov 2026
 01:31:52 -0800 (PST)
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
References: <20261121034053.39878-1-prasanth.padarthi10@gmail.com>
 <20261121034053.39878-3-prasanth.padarthi10@gmail.com> <awQDxB-09pHSgfJ_@monoceros>
In-Reply-To: <awQDxB-09pHSgfJ_@monoceros>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Mon, 23 Nov 2026 15:01:41 +0530
X-Gm-Features: Aa3M54on3hjaWixdom-MZvFvoY_Ect6i0Ad8JpXIU33APeKTiBCUcj1JKRPJeMs
Message-ID: <CAMFFDGh=7CtLR5bOyzP0SuSXVaXY=5H2UajaFx6pcescqfYjYQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] nvmem: aspeed: Add read-only AST2600 OTP support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, ryan_chen@aspeedtech.com, 
	billy_tsai@aspeedtech.com, neal_liu@aspeedtech.com, tan.siewert@9elements.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks, Uwe. I=E2=80=99ll drop the linux/mod_devicetable.h include in the n=
ext revision.

On Mon, Nov 23, 2026 at 2:45=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Sat, Nov 21, 2026 at 09:10:53AM +0530, Prasanth Kumar Padarthi wrote:
> > +#include <linux/bitfield.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/unaligned.h>
>
> <linux/platform_device.h> already provides of_device_id without all the
> dependencies that are implied by using <linux/mod_devicetable.h>. So
> please drop the latter.
>
> Best regards
> Uwe

