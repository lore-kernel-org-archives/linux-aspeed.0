Return-Path: <linux-aspeed+bounces-3247-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B02FC6166
	for <linux-aspeed@archiver.kernel.org>; Sat,  3 Jan 2026 01:36:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4djjnm4Hlnz2yFj;
	Sat, 03 Jan 2026 12:36:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767056598;
	cv=none; b=dZt9ju+R5MyXARHLWYtwe7WC8s+DydkRfiFTjOt5/F20Wi98YlUXKXDENGaUKT4kCkwxDitBNgucnglMA6SjIsvHmfZJiKxesDOwHUTYBu7tnr0tDAFp7BqzaDVXgXgbgE0YEGjG31irHUNrPqqcNmK7zXY4iRXWvufSzuBn0tcQnPK1ctjw8qSFXx8jQMHTIx59iZQA+W9jnuHW9hd8abrg065QgPX5DoNOjq3W/FpOgT+4K3d4Nmn2KDA3dz+8ILqwpeB3Ps7oE6NQfZwkuuf8cbcRDJnCYuR5cGPIc6SX+xewebBYEi2KEm2f3K8W0q+CveNF7hmSbzMuDMxs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767056598; c=relaxed/relaxed;
	bh=K3uupG6wwKA+D3WjE6NNFWCJoJkQpCysPioJbVD9zeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXUgUQ3mfAqCNO/5AYDJc2afv2N1AEGXaBoC6x5noRXFGkUs+w1Kx6ieq5byEBsqlv1o6fKkEdY6KEBD7wTCtG0MYzB1f0FAPlH3wQL1LSKgWb3iUG6M7TDJTpvutdjZ5seDFP2Jz7Ow4pm1FdMzF0UKtAQerKsI9uMEj+17A2OjujiYqAfsJwzVgYHcfv0mndMkx2Ov0rywHMjlHQNjeo6ZecJo5917A3ClebfMNAWeuY6i7giWlK0x46DuHmU2cJRFUZ8Zx7TaKXNSWfKHEA88PUm8nop/DqOihGX54Y4SkBe2MbbgQKgHlkX9JiLgkzFv3KdfEAjYAsdeHoPQYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MfSClJ3a; dkim-atps=neutral; spf=pass (client-ip=209.85.221.173; helo=mail-vk1-f173.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MfSClJ3a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.173; helo=mail-vk1-f173.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dgFFc326Gz2yD4
	for <linux-aspeed@lists.ozlabs.org>; Tue, 30 Dec 2025 12:03:15 +1100 (AEDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-55b2a09ff61so1951191e0c.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 29 Dec 2025 17:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767056533; x=1767661333; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3uupG6wwKA+D3WjE6NNFWCJoJkQpCysPioJbVD9zeI=;
        b=MfSClJ3aYa2wck5KjyVhTm5B4o+bGLOsifuPvtO33YQ7v1NeexjMlx9rgsjnvSP1Fw
         lH5Wo9XsKW7wBM2Aj6k3DNmRSJ7/Nsj48M7qXvulw0XmwANHRNk9ZjouBm305HQHU8xx
         i0Bprb/VJ8+WmNbfWsX3zioABetGVwg/n8Xj9fayZJwwdzMaKQG2G61FMy9rWlVEhO1l
         cjwtOap6MsWUHYE6OsnGfkJGkoEq44G0yPGjTHzTtGG6gy+gPk0B1q5s+78mPNjWro0J
         3oITYerhTHLw0eVzw/btxVqnjmRnGRUrskRjq7DxO3HW1VuXyfq3Tw6FuvRv85LOqLHS
         qKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767056533; x=1767661333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K3uupG6wwKA+D3WjE6NNFWCJoJkQpCysPioJbVD9zeI=;
        b=hXOK1SvUBA9LupM3vI1ogx16EED+sb6LXrwMzj96u0zbu5rwJ9HR8E/uoNx5jEWia/
         7n5nhZQjav/ZRi6aKDy2qRifoyKpnFE74utl2JlMhKAl7rGtVlsblI1ogEXnU74BBVET
         jcfQWfbvIvnWl4Xc9a90j+qq/OmEBIlmd5hq2cgNGb94C1ttmq3TH6lOdXNv5PrKU5+y
         9MreKGca17ul9LHdoneI6a6eHWbuT8NJQmQ3cWQQzV2adCH9P3yEboIfCvhGpEAcy3zn
         +q7QoYqUsIttPNECmBynAli36caveoP0bh9dkQk2KoDpPg7dGBnJYc0jfY0/dgCWgFCl
         8N/g==
X-Forwarded-Encrypted: i=1; AJvYcCWaXieoHCpTb26QAKRx0tt7gUZ1GXQGB3KjqWXdR2kbydhx3B8DPJWWUUQL+oYAaK9umnhQv4y15zEejz4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQI5K52HmOoAU9ZqqqQqcyWZ9lAVCd3dHZVZBU0tI1aw/Q/T5W
	HYU7cFfzFOtC7jhYjUTkWML8RrrIp4QA5E/hTVynNncEANrqpnEwtZxDXNos/JO4LtOsVgiRcej
	HhHrorzdUt716tIIbLGRx8MEtfgWEV0E=
X-Gm-Gg: AY/fxX69HC2kvw5o5s6CmPvy6s/jg6QYHYljAyzOP1ic9XzafM3WjSf9W1GLOIrpoXw
	wlHY8oe5Ko7CY0m5rcZzt6NIGyhTITL8lSbUy/A7dD6Flo9CUoU5cjiwA+RuYMevIyPOZDGYwvK
	JK91fJooRMNwwsMDwhfmofZ6445czBIcU8r6qfMWBehwnmTBYlpL9AVm9jXjvZA3dTJy2SWIPNs
	QfwGYLnd7o8fY6/yPujhbT4bJJlgLIb8r5fwxw3Dk2NUbRMb9B3Xs3b8aPclER06wjdtcl4
X-Google-Smtp-Source: AGHT+IHWHcxnnE6ua2lnO59+DWRC+LlEqTyrTydKj3DfcxQoiFj1yeTa9TC+D4wZtLiBbwSaYWQkTAPRRUX0Kb/EYlU=
X-Received: by 2002:a05:6122:a1a:b0:559:65d6:1674 with SMTP id
 71dfb90a1353d-5615becae79mr7910503e0c.14.1767056532775; Mon, 29 Dec 2025
 17:02:12 -0800 (PST)
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
 <1e21f828-1b06-492d-bfcd-ab5721621e8a@lunn.ch> <CAF7HswP7Oejs42K=jG8bkNiBoDhXR2LbeHoppk0nnNon6_afwA@mail.gmail.com>
 <32ff7ca8-9cb0-4889-adb0-a6dae735630b@lunn.ch>
In-Reply-To: <32ff7ca8-9cb0-4889-adb0-a6dae735630b@lunn.ch>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 30 Dec 2025 09:02:02 +0800
X-Gm-Features: AQt7F2pPUn1JLWmR3VqaFLx0jmfpldK-iH0ck9hcP5otIfqONHlFX9khVNFmN88
Message-ID: <CAF7HswMRrs9hwKo_uHCLMtx7+h46-DPEJRcEqu0-zEG4CVvvjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 5:20=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Dec 24, 2025 at 02:40:39PM +0800, Kyle Hsieh wrote:
> > On Tue, Dec 23, 2025 at 6:35=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > > What make/model of switch is it? Is it unmanaged, or does it use =
SPI
> > > > > or I2C for management?
> > >
> > > > The switch is connected via RMII to the MAC and is managed over MDI=
O.
> > >
> > > O.K. What make/model?
> > >
> > The device is a Marvell 88E6393X switch. In our design, the BMC connect=
s
>
> Which Linux does have a driver for.
>
> > to the device via RMII with fixed link parameters to retrieve ethernet.
> > > > On our board, MDIO is not wired directly to the processor; instead,=
 we
> > > > use a USB-to-MPSSE bridge (FT2232) to toggle the MDIO signals for
> > > > switch management.
> > >
> > > I have to push back on you using a closed source user space driver,
> > > given that i help maintain the Ethernet switch drivers...
> > >
> > > I know there have been attempts to get GPIO support added for FT2232,
> > > but i don't think any got as far as mainline. That is probably the
> > > only part you are missing. You can describe USB devices in DT. So you
> > > should be able to describe such a GPIO controller. You can then
> > > instantiate an virtual,mdio-gpio driver to give you an MDIO bus. And
> > > then add nodes for the switch using DSA.
>
> > Apologies for the confusion in my previous reply.
> > The BMC connects to the peer via an RMII fixed-link.
> > The link parameters are fixed at design time and there is no runtime
> > MDIO-managed PHY or switch control from the BMC.
>
> So you use the USB-MDIO to program the EEPROM? The switch boots using
> the settings in the EEPROM? It is then an unmanaged hub? You are not
> using UMSD in userspace? That code looks terrible.
>
> So if you connect multiple of these unmanaged hubs together in a loop,
> your network disappears in a broadcast storm? Yes, you can use these
> switches in a dumb mode, but it has consequences. If you let Linux
> manage it, you gain a lot of functionality, such as STP, to break
> loops.
>
> But you seem to be opposed to this. At least add in a comment
> explaining the purpose of the fixed link. DT describes hardware, so
> there is no harm in describing the hardware, even if it is a comment
> and not real properties.
Thanks for the comments.
I understand the concern about the DTS. I will add a clear comment in the
device tree explaining why a fixed-link is used and that the switch is
initialized via hardware straps and EEPROM, with no runtime management
from Linux.
>
>         Andrew

