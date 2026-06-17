Return-Path: <linux-aspeed+bounces-4269-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB60CD98E4
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Jun 2026 00:03:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gggt41NmLz2xLk;
	Thu, 18 Jun 2026 10:03:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::335" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781678441;
	cv=pass; b=QiYIR9XyVjSnIDvzq786Bqa4O5hfty+JYbFcoMXtG3+m0uUZ0IKSfTFt4UxejFs7h/uNBX6S9PyNbWz8eEw9GGMRJI+fEhiORHPalWtLgLBD3cC4nz+sCdr2hlqKcSbZlMlRSgZcdxY/Gn5aGaTQ0yy4YaVV1j5z3weSYzcX8zv1oblKyx2dKAHzpeLqLUEb3v6plxi3S0caMmQDRJeaU3D6v5wnqmyIekqgiCh9tQeAWBftysGD2mbMylFB8ybxNOcHrrW46E4ESaSq3MpEywK22dAKApLi1zZKTPboQKV46R7y4TAMtPkPJXhqzLMm5xlX9b8wh+qxulQLDOWvTA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781678441; c=relaxed/relaxed;
	bh=627DvcBL/GTdPlpYYcEZZXWw06fe0YXL5NBPNlxZyAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozRzUeRwV3/72DqpLh6nokJdkRfMU+jcWhB85UVAxkozOn2RxLXrLTztPZ7miLGFLeYkMBf2ud8kQYw1N/Z8KRWmbavJe7A4IigejjXPb9Dg7cSRbE2T6atv8K0B34hEhHIAosGxQanAbYj+P338R+Bm48ASQUPjyq2ciQPEn4r7OxtkgyCg4Jq9ogJhFwS8TGuIyXp2u70KR6uUw8RjY+PwTDYovmGBUbomUmZj6HDLvb8S4BG2+ki5Ueo5A9JHWDPeMhGQrvuz3Bnq3TQeiq0h+KTjIhFTJDiMKtxfQtZgXv2wXIkbj81QJ3cA0r5arBAavaiWLj6OaRPFQZPcQw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=OLrBEGk2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=OLrBEGk2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggDkv58hZz2xnK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Jun 2026 16:40:38 +1000 (AEST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so53951915e9.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 16 Jun 2026 23:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781678435; cv=none;
        d=google.com; s=arc-20240605;
        b=hO7zoulBkHSIwc3bSvfG/G3Pv7UV74aRqmFKln1sJ16JNxrEXztE3Bko0ymoFwtxcl
         GqmPmAhvxMFt/rzVpSj9RQtQK4tOUMobLudhacn0r00Q+EtkpTzPF0ue+C2rihsR3mfJ
         OBkUKdOWkn+FY6dTWb0qyZBzntJ0yJ9CsEDr5xeMALUtR73apUDhnAjYJIeYDuWVZ6gY
         OTMe+Qu+0k0ZsbOY+vrbc9D3GSWbVEC50LhiTfsM0ZLzfM82/5gTC5cqOKWdhL8d8X/j
         eEzQuP6hZln76X+SaZDcGT4J4G/Wo2QT0UtjyOWfyT3fdWUc51yZjw0ma2z2eOXmIAyX
         5Rdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=627DvcBL/GTdPlpYYcEZZXWw06fe0YXL5NBPNlxZyAg=;
        fh=7RZgFgPh5MZELEswUQnQG0dJIcSa1lL5bGpf9/dGOOE=;
        b=dDCdkesO/EFFrcBS6s350d2LsKLXcs9Jv04KdQRPp6O1CMGXdgcpHEUq8kTpXSrzGy
         Y3qqC1BB+K2WZQf7b4MoDcYY3rcrlTBDfBp8nB7Ccpwt01DE+a9PSNa4RMsrdil+AYMy
         TuwdTj4/2BSwyV08Fm/aoomCSwZfWiGcP5PP7Ph7N7cbadtZjxXxkjt0LmO5jXqIcdFY
         +IUrfD3roFFb261Epb+SuPvuQyf7suTmb4t3EY1cW0N35rnbz2YaeLV8Rg8sILedAjgq
         IiofRtRt4nZpLP/Sl81msWETm+AGoWShxJHGWLwgTxDO3DXfWxSVMOjF+wL6a0UvEf6g
         pePA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1781678435; x=1782283235; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=627DvcBL/GTdPlpYYcEZZXWw06fe0YXL5NBPNlxZyAg=;
        b=OLrBEGk2LYIkaZTjbQm2+70SmbwzIHs2ZMDffK8iWzTjvgnOODf9axQd72K2pChJ2o
         Ua4yOGEWCFkZSF/vW11NzwoCTBApVq+HwxrCUGpzdRtn7f14WQg3YdTAJMVSK73x6zts
         ecJqXA6Arm6N19thun8QoovO0yCVOXIcGpng3xTKQMCp+0zKpMEHb5CjZrJHwuUny+36
         +a/bJg51uyeriK/T8ONymx9xui0HzVM+mW76aCNBfMmvHHh3NxNVbpnFF/a+bQDXkUbp
         5yZkue/vtVUNtIlDeioLiT9+TZv1ttNzegNYCjSHA8Pwcj2NCzsyI+3Bv4RDKYfZ5MJL
         mrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781678435; x=1782283235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=627DvcBL/GTdPlpYYcEZZXWw06fe0YXL5NBPNlxZyAg=;
        b=qB2yPmMKqAN4TCVYyds5OS+UfGXpP2Euziw/8qZGcNuraHsnbXNpA+07g93GzUcQlF
         oTpa9eylVQFUO5oSDlIdtVdOFWVyjqEqJh4cPlDumDri8mnYfVt2TPYTVCefUz+nwUdd
         i5In5PBUYx5sX8oZ8rssodR55LAYxL/KXd19KJlG0wSjB0PSh7K+EzKi5sQ5G2v55/gI
         EtrrG6mizV72OwqBssHSeA36Kgt+gZxRYPVHnlwYv0/P/WxNr82FT17FjzxYYtOAVWFJ
         V7FGuXQRT2LMn9Iu0nbBYTgrEQwRxLiqJajtG+bevkjQCBMKJ7Uf0cGWWfAH9WvpsGGK
         Il7w==
X-Forwarded-Encrypted: i=1; AFNElJ/yMABC2BFxOTS04RIa+MCCQPh36l9JoabqKT6uJcvwfrel7cJ6Dgirf9qBeRHRmNjQaFboTeg+pgxWnY4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyTB6ZW1DxIFZoxd1sZ6qEqlS/UVaJdTyRBc+QjzMzyAtWV7jJK
	YFH4p9yVY14hXECbOd7qrLS1MkXnm1SerM+u4FejHTZyODaJaBu20+kJMqrV6oZNoPBx/sIOVN3
	MMnkF0Q+Q7JgVxXDv4wuhrcc3KwJ3fuugfeQJOu0/FQ==
X-Gm-Gg: Acq92OEdMiPH2pVVlM4dGhA3+D4QQLZXdKoaFTsPRMcKMAdpMlABOS/0fOar94wrgT5
	fGhyJ5twkpIsVIX5YGV1nx0R7G1k5fmB7oWwSlgnLw2eLiSVpNY6DwE32YYiw1Ku/s0pm9cyJU7
	clCA3gzx+yFhb8ML/pbC+OkAfWjzO5vm7iTR40qETEamBwAHSgs70xq9t2WtWNLV9ne0O03tcX4
	g9+4DAvoy8N3jbFuL7V05q1/vi9hdvvj33e7jL/JsDtIMmmn5QLzXh0IKf3I+vFksh3ors1SLO6
	HCkIPZu+TWQZJpKatIAyW3mK1NFtg5E1xrfga/tBuWLkR9Vu2fj/9YLw00X53fH1bgxu
X-Received: by 2002:a05:600c:4503:b0:490:cdb2:fb5e with SMTP id
 5b1f17b1804b1-4923412792amr26171515e9.22.1781678435211; Tue, 16 Jun 2026
 23:40:35 -0700 (PDT)
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
References: <cover.1780929570.git.gregoire.layet@9elements.com>
 <af322e76d34ad504e0bdec470293a017b489cfd7.1780929570.git.gregoire.layet@9elements.com>
 <4839c31f666b612799a795bb47c884901fd2a903.camel@codeconstruct.com.au>
 <CAFi2wKYzUDY5Gis9GaHdqeYdv-orHB+gWfLXkJBgbxfbnRgorA@mail.gmail.com>
 <CAFi2wKanAH+ekKz3eVtdiz=pjEvmKwSh1XhE-Xo7p=CCiSWpEw@mail.gmail.com> <e5822b82e99f8c2f81deecfeaea2192b223dfbec.camel@codeconstruct.com.au>
In-Reply-To: <e5822b82e99f8c2f81deecfeaea2192b223dfbec.camel@codeconstruct.com.au>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Wed, 17 Jun 2026 08:40:22 +0200
X-Gm-Features: AVVi8Ce_fPNb_-dl2aHTctX4f_poGDs7t08FlXnmiOLbRzVBfN5Op5CBNbdSeAw
Message-ID: <CAFi2wKYgxKpp0ezzryYhFPDeqAeHhUq9Lhm67pVpnXRg+c2Vhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: aspeed: add BMC-side PCIe BMC device driver
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: joel@jms.id.au, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
	yh_chung@aspeedtech.com, ninad@linux.ibm.com, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	anirudhsriniv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

> The concept sounds reasonable to me. There's probably some bikeshedding
> to do on the devicetree property though.

Yes, having looked at how it's done, I would say :
'aspeed,vuart-over-pci' and 'aspeed,kcs-over-pci' flags would be
better.

> Can you outline the duplication you're concerned about? I think it's a
> matter of resolving the SCU syscon to its regmap, then performing the
> necessary accesses?

Both drivers will need to set :
- Enable PCI BMC Device MMIO
- Enable PCI BMC Device IRQ
- Enable PCI BMC Device MSI rooting over PCI Device 1 (BAR1)
- Enable Host 2 BMC MSI interrupts
- PCI device class to 0xff000000 to be identified as a MFD device. The
reset default is 0x0C070100 which is an IPMI KCS device, but that
causes issues as it is detected by ipmi_si but can't be loaded because
of non default KCS address.

Sorry for my errors, there is not that much. But both drivers will do
almost the same initialisation. That was my code duplication concern.

> I think it's not as bad as you make it out to be. The SCU's regmap
> protects updates to individual registers under a lock, so concurrent
> modification isn't a concern. The hardware design choices make all of
> this slightly awkward for any related software design. As an
> alternative you could implement a mini subsystem that relevant drivers
> could call through to set the bits, but I currently think that's
> unnecessary work.

You are right it's not as bad as I thought.
For now, I will focus on the VUART until the solution has been
validated. Then I will easily do the same for the KCS over PCI.

So I'll do for the V3 of the BMC side driver:
- modify the device tree binding to have 'aspeed,ast2600-vuart' and
add the 'aspeed,vuart-over-pci' boolean flag, only for the ast2600.
- modify the '8250_aspeed_vuart' driver to add 'aspeed,ast2600-vuart' suppo=
rt.
- add vuart over pci enable and disable code to the '8250_aspeed_vuart' dri=
ver.

Regards,
Gr=C3=A9goire

