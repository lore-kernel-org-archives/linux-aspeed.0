Return-Path: <linux-aspeed+bounces-3230-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5687AE9271B
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:51:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dffMv6nGrz2yFw;
	Mon, 29 Dec 2025 12:51:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766482040;
	cv=none; b=F0Ck4AVpUuAwC3N7eeD9OTFqUTtyXMVm5cSK1EiJ1iLhqmKFYKrATfKj5hSDR2i+rFM9bRzL4Acwj+CIIEm6f5spA5UZOpE2KhluDBrBtgkqr7/8H9d+rGRI+Jkm+E7VSOPgx2XsxwpvNAlZqJjOdnQyXTbWa6sfhiIg09NcJ6FvPHAywInUnvWJay+GArlCXwTmljgRqEpyot67f4L0BGYkUN5VIbsND0wWH+OcE85W0bGYET2UbU6YJ8d91l+Ly8twFEhiBS0+L4ou9jvtfKc+BZOwQ4XMGaOK5i3nF9s8iNNgXAOj8XjvRkq3pKH1reoqNOWReNNEhYU4uKbSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766482040; c=relaxed/relaxed;
	bh=GTGEyTW46XThYDSb3nGfOTcnTXkOQCNX3Dl5sNqjw6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTa+/Q7ECtdC814DyaaGIdPLNBWQNFSzGuLrhH1/T9RpDqmH+ZVU40zdDt6rwehfvewLt0DDjvCElhw3BuTFN1dQUNIp9n5y9KESLoSllX+fu52erM7P+DDzPSrntk+PU07OR4axWkicW6k+cls176D0qVFIrPczqFsFIY6zVogITxfGNMHgBDEK0Xf77duzfTAjfWphi2BRXX+RqB66MFTtn43wf1XmB04hlU6kRgyB0dnqoTjGOcDDSpFPXJDIe2RsXUf0tM/4oyNzRYEuOsIUILKyfmuG6WB7X9mdDFb4Rdop+IAcBA2XIVBYlAkV24aajFsyNBDoOJTJXi3L+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VlD4OgiF; dkim-atps=neutral; spf=pass (client-ip=209.85.221.172; helo=mail-vk1-f172.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VlD4OgiF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.172; helo=mail-vk1-f172.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db8mQ35tSz2x99
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Dec 2025 20:27:17 +1100 (AEDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-55982d04792so3798449e0c.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Dec 2025 01:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766481973; x=1767086773; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTGEyTW46XThYDSb3nGfOTcnTXkOQCNX3Dl5sNqjw6Y=;
        b=VlD4OgiFNFyCkFx8ADgHE1bbeTZ/HcxPGYGOKpUe680KwMeNoWcfAdukF8qXV4rSPA
         jebPQG03WcmL35j2Mgtnu/dTZ5nvc4W36/YpIAyzLxsUX4DOu0LkCX+QxRUXIssqs0+e
         vnsgmnYFH+flZGhcwZ7pCBCpyDzvemP2B72DxSv5pqvXZNVGpbLmG5+4MshJYGHQb1yA
         dQ3dml4A5RvRYHQ5unyWPWxPROROFQZAh0yV7zn277zIYwqf400yXwkOxpwPo15l8D0e
         /lxDV3eSg/ur83PRCf7LGDWhwSNSE49BWzTPpu+NAg8MphMWt7yvBsQC9frRp47xJkzs
         qtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766481973; x=1767086773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GTGEyTW46XThYDSb3nGfOTcnTXkOQCNX3Dl5sNqjw6Y=;
        b=Rv5Dqg1pc0BL5A8kttUerjkfasqoZKdStOisVlnRy3WG4c7ACjsfav2lsjCx5FCTQM
         Y91m4KBtJyM/vdWkT4+APm8xHQbv6n4mUTJpjUaRrkTJQexcaK1KFX+vOfLkLIBTeH+r
         Doz5cXpdIq04eKWrIuX+xPV1b3FM7YMreV2kUjoBo0ZKW2AmZmkre4ep2oCrWoqqiFuv
         s0mMahgaitu4xQ3AAH7SisPbqQkjz0QMYjUppAb9ufGxlCXOUklk+BV8SGxISqNuTRL6
         mIzLlvTiQPknkWwX71R48jv0gWWlFmnFT08otfYM5xeXhOM1hbGV0LMuI3vtbsTnr9Yp
         EQSw==
X-Forwarded-Encrypted: i=1; AJvYcCVQSby/bUPGjKyru0FSMSSWVSxMylN0dgS1sZpOgLPgIt2pGBfpI2UkPgb6z2cASOjp/zVEEt4axcSKECQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzEeMq3GDPrZgjcZwaTJx04YYTPwvqgy+8Dt+C3d2nnHyLd+LfY
	Pt4T1PaWQWHmTCMAh6ER8Gjao0+qjVq6lslw4EuedrtugdapEBGJFNjCr7Y4N3HCUVLJrEMYXHE
	SpN4cZJPokxJOUNVKjSrKPJI3HI+yuKg=
X-Gm-Gg: AY/fxX5b3aki8Ln5u3/W4qC8+4HDkiqNqjZvDFwy8a6tmodxmY+Ad6dBDKrcfpvzrLt
	ayth4sItxDsJxz8QNVMy+CPiMJelGvgB4MXBQhOVHJ5eKWu1n6ZzC29N+4AgLSqt6dLY8qIUP4V
	O41304Qrs5YSUqOEynmZLbUIdTgzL9hfQrzp6Z7ZJ+NvgzxKw3k83IMD9NjVe5pSYwvySRhVk/x
	JRSLviDez48zpfQflnbbfmOflqR44bNLNSzzEDfMC7UDa5/P0IIggCGaVFcpT7146fqlZSMgnO6
	iciOX0Q=
X-Google-Smtp-Source: AGHT+IGNdoIAhQtLGCBr8mC/SwI6VG9mNcrxVeUK7FLVxcyVEZlSIvEaWHvs6v2NaAD9i9XNu9ROrW3FCi+AlPV3bc8=
X-Received: by 2002:a05:6122:8c26:b0:559:ebd7:56e4 with SMTP id
 71dfb90a1353d-5615bceb93amr4461609e0c.5.1766481973546; Tue, 23 Dec 2025
 01:26:13 -0800 (PST)
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
 <35f3eba9-5ec4-4cba-8a64-fb521dc65b79@lunn.ch>
In-Reply-To: <35f3eba9-5ec4-4cba-8a64-fb521dc65b79@lunn.ch>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 23 Dec 2025 17:26:02 +0800
X-Gm-Features: AQt7F2rfLXR1N_dAP9Rb-QfqDYef379P6Ra9zBB7wrWIZBUMZ5TM9ysNyWSrhdo
Message-ID: <CAF7HswN0hhJQ-gmE59cKTuPyzrs1A3rM8Xw+Z8i3_AsHRiNcug@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 5:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Dec 23, 2025 at 09:49:02AM +0800, =E8=AC=9D=E6=94=BF=E5=90=89 wro=
te:
> > On Mon, Dec 22, 2025 at 5:30=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > +&mdio0 {
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +&mac2 {
> > > > +     status =3D "okay";
> > > > +     phy-mode =3D "rmii";
> > > > +     pinctrl-names =3D "default";
> > > > +     pinctrl-0 =3D <&pinctrl_rmii3_default>;
> > > > +     fixed-link {
> > > > +             speed =3D <100>;
> > > > +             full-duplex;
> > > > +     };
> > > > +};
> > >
> > > That is an odd combination. You enable the MDIO bus, but don't have
> > > any PHYs on it, no phandles pointing to it. And you have this
> > > fixed-link. It makes me think you have an Ethernet switch on the bus,
> > > and this connects to it?
> > Thanks for the clarification.
> > Yes, there is an Ethernet switch in the design.
> > The MAC is connected to the switch via RMII using a fixed-link
> > configuration.
>
> What make/model of switch is it? Is it unmanaged, or does it use SPI
> or I2C for management?
The switch is connected via RMII to the MAC and is managed over MDIO.
On our board, MDIO is not wired directly to the processor; instead, we
use a USB-to-MPSSE bridge (FT2232) to toggle the MDIO signals for
switch management.
So the MDIO bus in the DTS is not used, and enabling it there was a mistake=
.
>
>         Andrew
Best Regard,
Kyle Hsieh

