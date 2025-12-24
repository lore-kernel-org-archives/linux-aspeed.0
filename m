Return-Path: <linux-aspeed+bounces-3215-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96F4E784BE
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:41:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dff8Q5MTCz2x9M;
	Mon, 29 Dec 2025 12:41:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766558516;
	cv=none; b=PxxNfxArPNLFPP6A6sW3IrbT0kKRqfujFSB1BB7/aPTAPRhSYUf01oIiiyvZZYU7IRJsWuuAFO8uaQDpzghjR6PYJapAhp2VrFoUTe9uWuy8PE3J6BCkpoDh10X1NGCw+v1rzgwltBkEoK2UZb8v02nmlNQH39LnIZUn8b+fTvOFQyWrW8iq32l1jfCrzGSJpIoZxxDKq9I3X0q+ymAlC+AgJTR1ABoMPy3iISH/WnXotAgcBLXrp2ed3DvFkdk+CguPQddnaZtVBiTB6OSKhUinRs3CbFGCSGFbFb9fTmdakG88gSzhXxSvaUGs7aLi5/fvUo4sPM+HVxcyYFB7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766558516; c=relaxed/relaxed;
	bh=QhWuML+xfN/FbEBKC+hfJSr+oGnXRh1tbjNh8rpQndc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqOrHz5qHQITJtmOOoIaVUuf/KH7fSAGbrFX4RybL1Dyt59EKUruU6kLyYHDMhXSabQW9E9CIjB1a7HNZbbI78i+BvLDaZPyVSythh9DrwdWezlkOCdyZaRQcmNnSM7ed4VJUzpJsVdYvUt9jFN/kNYBRP1exFEj7/rP4YXona1xieU/pgFUCL+Yik1dHDWP6kY6vv34vCAst3ubk+tDbH0a0CKOUc5rlltvqqzLPzqP0z6+gkJm8slilx+6zn/VKkBUXz5chEG0mWhVNJ1IB9fFFGzlQ3RvqiHUbrpTmWEmTAT0Sg78ZJPtZXiBmxByH3ZMd11qVVCaNORP6hWp9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DTPiXhcq; dkim-atps=neutral; spf=pass (client-ip=209.85.221.179; helo=mail-vk1-f179.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DTPiXhcq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.179; helo=mail-vk1-f179.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbj366cpFz2xnl
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 17:41:53 +1100 (AEDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-55b265f5122so1341610e0c.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Dec 2025 22:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766558451; x=1767163251; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhWuML+xfN/FbEBKC+hfJSr+oGnXRh1tbjNh8rpQndc=;
        b=DTPiXhcq4VMs+SN9AbX7OVHDusvZCT5guMsx1+WoCauPP60Dav5IbslgOSsYUAVH6t
         +KfrxsFt2f0SQJml5Gaz3nH6LPg+rfwh38IuSdF8PqFAdH6lPvE/rBFoLXZT94qTulIE
         vU/+I+bk/hOqWtfxdU+vZwehpM5repbp9WWLPJUHm2GOu9VdUXfEH8Fbt3BLnUlEQQyA
         j0giQmAAsBLeLtl5uqbfbbdQYFRF8pqJ1JstUac+q+vxjHvvwFj32TAdcP5I2o7tdzQ0
         rqQ8sOl89CdwNdom2hCvhmBDT9VG4FABrCz87GWH1AQbJhwFXaOPjUpZswyLff5+FFMK
         nbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766558451; x=1767163251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QhWuML+xfN/FbEBKC+hfJSr+oGnXRh1tbjNh8rpQndc=;
        b=e9TC7G25l/iRQnQ378EOxbhKs3/ks5ZvUUsjRrEpc+ezg8SW/ccqjTa+WozPCauBcF
         WhyGE4ZjRjVq4iKFPczZE0mDLqnZCf5l25otoNR5gPIitECTowrgolQcRKv9L2m3Fg+/
         f5Ox8zl1Z9db0M/83U0ynXn4FuznON2cK06UfZ751FABXwTh+0HBWPTvt4C45nvErqfS
         fOwKMr60vbU/LvO+1cX2w5at3L4wG5Ak9jATdUKrtRsUWGoXvpUs1+OaYTTSJWibJIwl
         5z4WIoyRGCatz1YcRpCSTNHbsKB0ftnZpsf6q3jREJSgaLZaIkHOvrhxw1T64psZR5UD
         AjAg==
X-Forwarded-Encrypted: i=1; AJvYcCUtMRlyybayleSzi5XbKicIAtFMni2RI953k0SkuU1ZB84UqJFaD59mT9jK1LUiwfTSZGNNzCVd+P8uYy8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxsJpY/UN0BtqiU32q0D0PsKBfqqVbxQWgKlCx61TuONLQVz9gQ
	J+nXkzwmP51WxeDVRcgILPic6IHje0N8E1QMI37qe++ms7gTU9oQxncmiDgDhdH1RmzaWRwr9Bb
	aNEbpIbsN1Xw4F0MVAuTJ+lQCUsJvg+0=
X-Gm-Gg: AY/fxX5NbZ84Rbt5uZzx6K7eH2imlesJZGUzNg5meCVxEjwq10VfOfdeIdGZ/pZbQU/
	QQYC9qyqy3SoZ+1v3YXS+qr3j040/uaO2C4PYGf4xu5GRZ9dFJ2UL3ft44L4jDIOpdZybZ/MgGT
	uMdyeexNbXKn10z10FQ1TsdzAbgithN5VbKpdlhjazgDHDUeLESoWnv5u2znBT1RXgKn2SkV7LH
	5DkKiUoqpbO9+2E2nTefXdaeFIr2qLMymOdg3h1M/MDYiSZgVin3VAnmAdwO+jBrVvreRf4
X-Google-Smtp-Source: AGHT+IGqNey6TG8yqdYhTpzWZIqLA35E9fAegGhLCjqG575xM7vw/bkoGiuMiUd1DxNeOqzRaI7119YN5vercXgA8zY=
X-Received: by 2002:a05:6122:240c:b0:55b:9c1c:acd4 with SMTP id
 71dfb90a1353d-5615be9091emr4344447e0c.15.1766558450878; Tue, 23 Dec 2025
 22:40:50 -0800 (PST)
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
References: <20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com>
 <20251222-ventura2_initial_dts-v1-2-1f06166c78a3@gmail.com>
 <c069b452-df22-4afa-bf6a-c48949f40ebc@lunn.ch> <CAF7HswN_jEXOU_9K4LpLnbhvd+RD0qqELAHxMBbp=hGtMjS4kQ@mail.gmail.com>
 <35f3eba9-5ec4-4cba-8a64-fb521dc65b79@lunn.ch> <CAF7HswN0hhJQ-gmE59cKTuPyzrs1A3rM8Xw+Z8i3_AsHRiNcug@mail.gmail.com>
 <1e21f828-1b06-492d-bfcd-ab5721621e8a@lunn.ch>
In-Reply-To: <1e21f828-1b06-492d-bfcd-ab5721621e8a@lunn.ch>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 24 Dec 2025 14:40:39 +0800
X-Gm-Features: AQt7F2pZDHak7nDZcL8jCA1XWJnW12d9SgVdpUOLF37-2YvXQexfXsCcudZZ8p8
Message-ID: <CAF7HswP7Oejs42K=jG8bkNiBoDhXR2LbeHoppk0nnNon6_afwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 6:35=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > What make/model of switch is it? Is it unmanaged, or does it use SPI
> > > or I2C for management?
>
> > The switch is connected via RMII to the MAC and is managed over MDIO.
>
> O.K. What make/model?
>
The device is a Marvell 88E6393X switch. In our design, the BMC connects
to the device via RMII with fixed link parameters to retrieve ethernet.
> > On our board, MDIO is not wired directly to the processor; instead, we
> > use a USB-to-MPSSE bridge (FT2232) to toggle the MDIO signals for
> > switch management.
>
> I have to push back on you using a closed source user space driver,
> given that i help maintain the Ethernet switch drivers...
>
> I know there have been attempts to get GPIO support added for FT2232,
> but i don't think any got as far as mainline. That is probably the
> only part you are missing. You can describe USB devices in DT. So you
> should be able to describe such a GPIO controller. You can then
> instantiate an virtual,mdio-gpio driver to give you an MDIO bus. And
> then add nodes for the switch using DSA.
>
Apologies for the confusion in my previous reply.
The BMC connects to the peer via an RMII fixed-link.
The link parameters are fixed at design time and there is no runtime
MDIO-managed PHY or switch control from the BMC.
>      Andrew

