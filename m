Return-Path: <linux-aspeed+bounces-4465-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3C5C43458
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jul 2026 06:34:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzqK13LFJz2xqn;
	Tue, 14 Jul 2026 16:34:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::432" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784010853;
	cv=pass; b=KHW6TwD3+zHANPdKpYxf/M2yDxD3X6D7sqYy5QrlpryDzTJWd/S6UQbDEXKXVG8Mwo71J3fVmQbAmmGB9dOk4vXa7m/0n+RWH8ulR4L/IA6HkhzGyeGmRBiejjyQjzSDaXXNTqmBts2TN7fJZ3PpcdNsJKnatCIW4coWRhV7+sWNVKVaoE1IWiIoAOKRqdbfqILSOYvCRovQ1Bu4GYC9VQVMwM6DQWDaurweN5H9b9880ER3edvoyrlZbRzqtv0/ypPMD/tJ3/hizuQ+I2H9Rn63wSpoQqD7xDwQhw+TN85luYLWs+Xt6npwHrxxo1jA23r5j1TW98MuV2lqaGQZtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784010853; c=relaxed/relaxed;
	bh=W9FrfG9Gw4/z5mtWnR84x/YK0xjKM0uXdEh4ByObXig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMlIOctoCHjiD7bf9jhTHn2M9yj4y+eiJjn9QuuRl2GNbBKkCv9F+1x/3Ijlrrqn1LN57AjQeYPljQaMzrP3jJhhFJrDx3W78dRi7EeJorazdmMzpKT/bDK4zF108BD3kHIqUBemTlrEhnuUuP9vSlAX7sDoYGAa1xmDFLj5ZUn5vGDAou9f5k6g+Tv4k/gUN5IG/iXLc1WK5VmgKkbRCaD0Kg1YxUZRJOMMAQsYG3pUMN6szGyng1N1hdpZTgacmPJP87Rh7sdwJgbHmNWnuoHnpYrsEc+6a+qWBy39ttBMcBhZ5bVEs0r7Um/aqVm0Wk5sXu8PLYHT23/oNPd+ZA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=gax/DXq+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=gax/DXq+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzqJy6kfwz2xPb
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jul 2026 16:34:09 +1000 (AEST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-47dec32798aso3972412f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Jul 2026 23:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784010844; cv=none;
        d=google.com; s=arc-20260327;
        b=ecqIUOs73AewBb+k8eKQUVoYgAwf8leGs9KFBNYs/0e6BYf0iwIcXWJiK+nA6cwvLC
         rhdttp69JsOh0UuYAoM3SFawDi+/tG/v5OmnORKAgTB3T+WOxzwaLBFheOOBkAq6L/HH
         2LpIz0rfTNgQPxtD/y8GuZPqaC/6QY8cE6Q5Fyow71iRM/jCW2yileUIkXfLV8Jk5zZR
         mxCQhUQgrPELVu0zu59mcOed1VdRUqAx/eDKMI6vVW2M4UyFNox1UkBkjfXN8TO+UnqE
         2DvAEB3lI+pt7yObS0hurwmg/Caw6tR4Mbay03Pm9jxdMqjg0NLzFJVBipFatT1Pwq4T
         dkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W9FrfG9Gw4/z5mtWnR84x/YK0xjKM0uXdEh4ByObXig=;
        fh=CBCmI8S5uXBo4EZLr1Nfhl8+HRj8qAomPEN9komU+yQ=;
        b=rGZLRE/RiQ9DU7mJZqJ/n1f3g/nboZQV17LiKzW9TD7WfwT0R/3Dhli1SD3ZSinETy
         GZYjCzefNtJfX0PgYMjWgD24NhmPjUAd/qLuWJvtuFDhbEvr+gkxkhTUwyxZD1SZ6Abh
         1rmu4y3Au45kfydN+LE0Kq8JgUi+7SzmnsDWLV5XmDfgghMR36w9lzqNA9nfNkXIbnTQ
         jKAYnm+W0cOHhpCML/bibBO+uV3hsMovTLFz1kA9MUkpRFRPoTBglROAl9IvEPTXehMJ
         irU1HZlJEGTowjqmSxsr8scVIIR86cfLrypwQ5PdRuq+lDyqpgO6acNSPwMJHn4XpvyP
         KmcA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784010844; x=1784615644; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W9FrfG9Gw4/z5mtWnR84x/YK0xjKM0uXdEh4ByObXig=;
        b=gax/DXq+y9XkhKom/Yrvw3ipxjXdEJdq6S9moWpz05xaLV6RqAa0V1TevdPa+hn0Rz
         L426nn5jVhMI9NZADYT7JfPzpSzXQTQD+wPgdOPYMRl3LChEpvac4sFC1BpI18QweBof
         HQP5ZyNOvMqVFs/5MezYzFW2qUUrcjnZ8nedmErAmszH5si8RZlC0l8N0qg4xd/zeDwL
         uSwx99Tt4jjmQkr9DN8feEw2KN+zlAQw+HzLB5/L+OdHRb4b2u0/s78CBoRU51T5Uerx
         lcbgv/LnXhOVB+g33fRUgTOqMhGGNInGCIszDUkQzgGDxVqmYeVDoqID4DpEL6qFDfAa
         cP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784010844; x=1784615644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W9FrfG9Gw4/z5mtWnR84x/YK0xjKM0uXdEh4ByObXig=;
        b=jBkx+63l1BmbvDISnwqUB64Pi2yxqVgQz9VEhOugNL+jMVMKl5matmYKcDzG9I8tZy
         jOdDFjXHzM+tCZlgY7x4J8/V3jQ8WR6Dr9Cbbt2UWrd8fp4Oeo2AQ15rBULjPpyY5JKX
         aFZKdklLIcxQTW7cbKZxIRLiFK6bRMQvNfWSML5q4wyn0aePVb8k7a6UJpDPxP7Dy8/S
         pqgGl/+M3HJJ8WMOWVIq+bNhs5NnXR669cEhWisp5uv2ZJJ4wltcGluau68oUxj8TN6A
         Px/E8Tc64gKAPjtXlxn87uGNmZnkFxxon77qiw7iv1wCIHNg/Ox0/Lp2sHvF5bCO8sua
         BMNg==
X-Forwarded-Encrypted: i=1; AHgh+RqNq8hFshX7VIGNeReybn/AjGWB9Za7cgpsv5xDdmhz7myoTPl/7mIuXwzN5/kjPQZSTh5+i9gK7b9+lOc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYh7gW3adov0mZrxs6XJ5QW90kIZK3FhxGA337SmQKDXobES5c
	vYafFlpeq0QmCDLXBXzO23i4issG/y3XO4Pal5idE3HfGtDdiJWnBVJvf7BrvUfrLX6k8lEQMwt
	iTeb3lJkEuY2vckQDxkxdp3zYfNcF6WNPgyaRDCPgMA==
X-Gm-Gg: AfdE7cn3WOCRSYHlp49zxf6xcK07iieKbrO315tEqQBZtWDrp0CqrpOQ5nq2bXNE4ur
	E5Za5z4cqs2oLrw/x0axYUtQHQ2TDSu1hxFUFIyynKVOM8qHzdrfr4oe9zbto6GqZZny3p+knlg
	bY86mhH783uUUzLs/O8irMWXYcQ8iAcFsVB2gWeET5dS9HAjgVChRSuHIbOflnfN2kUf9zvLTrS
	xcM0sNyBgC5Ffk17GLOL0L4WieOLBs9LOQXrYsh+7igcCiGGty1SKafIODQy2sVqK1hx/kfgO5l
	MrJTCf6aSNBwZesFCjH9DSEkttaiyKJzTU5hahq/6iINWYGqkIvajNOO/A==
X-Received: by 2002:a05:6000:40ca:b0:43b:498f:dceb with SMTP id
 ffacd0b85a97d-47f488488a5mr1165528f8f.9.1784010844468; Mon, 13 Jul 2026
 23:34:04 -0700 (PDT)
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
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <28c6e7c493559feffc7e6231b0a2f0b73b7fda41.1783524645.git.gregoire.layet@9elements.com>
 <1af9eb75-fcab-4541-8ba7-ec620546f031@kernel.org>
In-Reply-To: <1af9eb75-fcab-4541-8ba7-ec620546f031@kernel.org>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 14 Jul 2026 08:33:53 +0200
X-Gm-Features: AUfX_mwqF2s0XWJlIYVM5Zbx0O-qqVqJE0SWnGYK8fsSsk4VE3pkV1cTIOFg11A
Message-ID: <CAFi2wKZRVbmCwprkxGZoxib8BrFd9kDS3H2cDmykEorB5S7Xrw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] serial: 8250_aspeed_vuart: add VUART over PCI
To: Jiri Slaby <jirislaby@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Thu, 9 Jul 2026 at 07:17, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 08. 07. 26, 17:35, Gr=C3=A9goire Layet wrote:
> ...
> > --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > @@ -32,6 +32,26 @@
> >   #define ASPEED_VUART_DEFAULT_SIRQ   4
> >   #define ASPEED_VUART_DEFAULT_SIRQ_POLARITY  IRQ_TYPE_LEVEL_LOW
> >
> > +#define ASPEED_SCU_SILICON_REVISION_ID                       0x04
> > +#define AST2600A3_REVISION_ID                                0x0503030=
3
> > +
> > +#define ASPEED_SCUC24                        0xC24
> > +#define  ASPEED_SCUC24_MSI_ROUTING_MASK                      GENMASK(1=
1, 10)
> > +#define  ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1          (0x2 << 1=
0)
>
> So is this
> FIELD_PREP(ASPEED_SCUC24_MSI_ROUTING_MASK, 2)
> ?

Yes, replaced

>
> > +#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN          BIT(18)
> > +#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN                    B=
IT(17)
>
> Perhaps switch the two (to be in asc order)? And define 14 as _RESERVED
> as well?

Acknowledged. I have also removed the comment afterwards.

> > +#define ASPEED_SCU_PCIE_CONF_CTRL    0xC20
>
> Hmm, should these go before 0xC24?

Yes

Thanks for the feedback, I have made the changes for the next revision.

Regards,
Gr=C3=A9goire

