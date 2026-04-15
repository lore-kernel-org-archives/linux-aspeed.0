Return-Path: <linux-aspeed+bounces-3913-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0601DF433CC
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Apr 2026 23:59:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwymR1nQyz2yrT;
	Thu, 16 Apr 2026 09:59:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::32b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776247548;
	cv=pass; b=Fh12Q+aVM5GiVR1rUb8COkFKZXn5eiIAKEomf0bR/nsP6ZikOWnJqxMGKydCXowlHJ1mp4ZocgSZWK1BZB+ajlmonPGBND2XCVc6L0vI41Y7LItcLkffmC0aO1XcbBzefigNBPHphx7q3auwCCSFRlbLUamlMlFFix6Mm123+JU3ml0r31VYMFF4mp6h2/bJkVnxqh/EvsZwWT0Bkckvr+i/twwivwVKAXsRUrccdUdzySaH50xZVka80bpkggI7QRDIwFb7w8GegUcJcDwtB0H00M8WlvklQ7UHSJeRd2E0lhGtoPgjIBd+Yt+otgaAHFHmOYGIfi0Zl3f/0H/YRw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776247548; c=relaxed/relaxed;
	bh=duY+ZROtfr+N1IL089g5oclcqG4kl39QwJmUtTLl1Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyTec6uG144JY9/bKVvl7YnRaTZyyevPaYAmDyvenHGn/nnd70IZM9rjzmvRGUXqMj85BGi9Mz9JEpO1TtHbMHfN9qlAYEBpHHuhvCViTatKH6kvneQTcU+QE0y+U+jDgNQig+B9HDl9we3O6vnuh/b4c61WPps//ads71/9uYh7T4v5rXQKjPxqcNk1iQee9Yl7+VdwQk4nGyikBt0pxM5YQwne1smxjnvfleeh+4arvjl3lNnKfbH4UDybmBS9fWmDUiSDTPmPIYcliYhzu8GTBI0ky56si+Mkcz2bLtJ7iDLDUsj07cAsdCl/zEPibIUHL26GksRmU1uQ78yzVQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H7SVJvVP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H7SVJvVP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwcGg2syhz2yrM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Apr 2026 20:05:47 +1000 (AEST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-7dbccb6ae20so3462797a34.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Apr 2026 03:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776247544; cv=none;
        d=google.com; s=arc-20240605;
        b=OFLhdz42MCTX81hDxIOfAlgwDMO2XwnogcuEBg4QVw/8RxPFaQT7sMT/wxX9iu5bkI
         2dX8r3wsG7en/9KvF9a/uEPgs1lsnJD5fVCSKPsNy63M2wVjPhW+tlGVHW2AXJRM0oyh
         UyovAxvNySCvTBfftt5+jZV7iCN3RPdw4Z9VFEtTSbzqczt/J51QypDZCTuIgjr2TVvC
         MjXbyaMEMTxhXBTmWmKcV2Ar5kXBcORdo8+LzdxHBZjIE0C208Mdjiy7AIR8l27cE4Pi
         bTRjfMKTLrjJiczA0Ajg6j4zGdDhqciFceCqreOA2H7XUgYG75AhoZD15fNHoQEgYRUe
         aBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=duY+ZROtfr+N1IL089g5oclcqG4kl39QwJmUtTLl1Fg=;
        fh=WET706IDvkp780oRp4aKf6R6iFT1ziQ3RMSczQD9xcY=;
        b=MSgNhdR/zQfoUX66BB/8EQnjLSKh/oxEkRsrrnKLHHWKMjXxTptx6/SLBavUuY+I1S
         3fZDIm7qvypWu6K/l7hUsE0f0VbglvvtY2eBy6OBZbWJP9SrYF7gC/zvh6zSl2fC8pZF
         Rkgz5G8jVAfQS4Yuuzt5Jm2Io50rREBNH6881UWh6xFtDdx2y0/GexMc+c7s+UexB3Ij
         poVmHtdw31zlS74TxFViZgwEypn1F4pTUHqrK491kKk7PJppARSc5JvqZ9H0LZ/XGYs7
         E6hfLRwN1+2DSiiicpDzQsuOFyJ1G8T0kvz7+oqlKZ1f8kXXC4qWcpD9PZ6AJs2YfwZi
         UJTQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776247544; x=1776852344; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=duY+ZROtfr+N1IL089g5oclcqG4kl39QwJmUtTLl1Fg=;
        b=H7SVJvVPHJ3sqPt9o81tr8EJ8m37/GdvVqtK5Ev1QxcsIZqt3BrMnkmHD9R5r6eOWm
         bSwvAeU9Ti5NFRspt84lPQuCkAfjNVEFG7grZoYHqiIF41PoVEcGl7uuS/UU4SONW5YC
         NsdLwTIFcjUjNXw8HYWcMacsE1c+zGf+rKS7VLRpSehJVnPBYExkias0y04owIxgSogk
         WPZ7vwFN7kd36oR7dRFL4Gwox+jzaK5rNRTOKzv1oy7nLpzqnjCGVBP4/1+QuInEDjJD
         bqzFdE+lsRo3Tq3LP//WMZ85xziRvxpoLqHaNx4bM1QiUPbBRKVL1KCk49lOhwJwwfyG
         TtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776247544; x=1776852344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duY+ZROtfr+N1IL089g5oclcqG4kl39QwJmUtTLl1Fg=;
        b=jv7lgS+SSIsAXvGUr+MNipZXULKEOyKEe9Fb0vJw3EVmz21TAvPNFoTwTpJ8ShQuWn
         M0IM9JWAsJ4yl906TjZTJT9Hl3CxdroVmzbX1r7fLS9FdiLbBwS7S91HiEww76sDBcU9
         hNdTkkU6vhFgnkTcqDmm7GkdUB2jw1ETydKgYCzD3V1Bjs2YZuSQhFfWmVLmNOjreV5S
         ThSHDNTOnz8bldkmXd5bnUzfqVSlExrcEU0Qy97cMjlKs2mcJhOvUbuM0I/k5VDcbNKv
         C9HF6KABLOLU0CtFfm7YNCVTGzN/cJFN3pq+6QSefFloVkjwYLcGsrMhOVnB3ZDtPCOv
         21BA==
X-Forwarded-Encrypted: i=1; AFNElJ9IXLjDNxoJ7/EaEnRMxPoULJWxUBdelVstPpXaWzmNKiybzhRPrbGmwg4F7BplhTh3LVzctQzH8l6Vl84=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyPCu/Bd/B7K42Z6ux0/O5h3FkAGbyfJFvhfqTPYJXt0jVmh84g
	1FgQbkOZ/w0Ra0ROXqFXnhEW8ZLsfNsq81WXZI3eshT8sa2rBbNsg05/P5OOZw9sOnBDBQzo0Jl
	P4KZrgvlVGCLuzzqGi1X2aMlX7qYzUow=
X-Gm-Gg: AeBDietLDcPZQLxGn9qXNXzc4cw1P4XAwOXZaiGzFuswdoLLiVK62z/A0kCc9m1yDlC
	VytoKNK83nQqaCyhDnSPikva0qG+w8aikInfeSbkoRY7FtMRqJw4fXDlHiYIhWJKbskXW98WKy/
	fiVbEDsvEhIXARNEE6XbufUsaWQ+YzpSBUe1yrvhlWzWuUk9yOTsoPNrVuT/b+rPn8htqgE5frj
	bZYa2iXGCzPnfs2xQz09HhwofSJapVib9Qhb3iq82jbJnBx4Gr2LZQaR7TrpFrgiR2aGgzFrc3w
	4rFoLa4l
X-Received: by 2002:a05:6820:538a:b0:67f:ab29:e2d7 with SMTP id
 006d021491bc7-68be7ee673bmr7560700eaf.32.1776247544096; Wed, 15 Apr 2026
 03:05:44 -0700 (PDT)
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
References: <20260226055521.1655243-1-pkleequanta@gmail.com>
 <20260226055521.1655243-3-pkleequanta@gmail.com> <258747f4-9da5-44da-8eb9-24f8a8cbff3a@lunn.ch>
 <CAK8yEODCyYxkggU+7=xzWFcXP6RMTpNbHyYRHZhahX7=b6reqA@mail.gmail.com>
 <435616b8-8d4c-4814-8f21-d667755473f1@lunn.ch> <CAK8yEOAYC0iApNHBApt+xu1Fz=+N1wX0XrLGOPzmeRq=OjWnhg@mail.gmail.com>
 <e7a1588d-b4d4-4aa7-ba94-da3e2591d49c@lunn.ch>
In-Reply-To: <e7a1588d-b4d4-4aa7-ba94-da3e2591d49c@lunn.ch>
From: "P.K. Lee" <pkleequanta@gmail.com>
Date: Wed, 15 Apr 2026 18:05:32 +0800
X-Gm-Features: AQROBzCKi3mcri0LxIDQl6oKuIIwXm5p7sK3cRsVPkitktyR35BUd8JHeo19VuI
Message-ID: <CAK8yEOAOhY25R5qt82LUkGifg_9HLia24-E=WxoEwCdbft1eMg@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] arm: dts: aspeed: ventura: add Meta Ventura BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Jason-Hsu@quantatw.com, p.k.lee@quantatw.com
Content-Type: text/plain; charset="UTF-8"

> > > > > If there are no devices on the bus, why enable it?
> > > >
> > > > We intentionally enable it so user-space tools can access the switch
> > > > registers. I have added a comment in v13 to clarify this.
> > >
> > > Why would user space want to access the switch registers for an
> > > unmanaged switch? It sounds like you are using Marvells SDK in
> > > userspace to manage the switch, rather than using DSA.
> > >
> >
> > We do have a custom user-space daemon that configures the switch
> > registers for our specific use case. Should I remove the &mdio0 node
> > if it is only enabled and has no other configuration in the upstream
> > device tree?
>
> Please just be truthful that you have a user space driver, so need the
> bus enabled.
>
> I also guess you have some other kernel code that allows you to
> actually use the bus from user space? The typical ethernet IOCTL
> handler does not work for you, since you don't have an ethernet device
> using this bus. Such code is unlikely to be accepted into mainline. We
> don't like user space drivers when there is a perfectly good kernel
> driver for this switch.

Since the kernel driver for mv88e6xxx in kernel 6.6 used by this
project does not support LED control, and this feature is only
available starting from kernel 6.13, I had to initialize the LEDs of
the 88E6393X from user space.

In this case, should I remove the &mdio0 node?

P.K. Lee

