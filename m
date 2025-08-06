Return-Path: <linux-aspeed+bounces-1924-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A44BC87FCB
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 22:59:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4by5N625Q3z2xlL;
	Thu,  7 Aug 2025 08:59:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754521190;
	cv=none; b=JghRKpa68sNxHVaJvebvi1ys/s9ZssKqZHl+Vewrr03n1y355iBnY48AN2X5RHjNWDv+ysjY395Xek3iVnYZP33pVBot+m0BgkXnUIyxWVMoDJBzb/+7O6/GiEBbQdo4t5nn1Vumhvm8F/ltbFSLTzj+Cahu5pRE2a34+y2M+FZtu2qT9iGMhUUhsRdEfxShClMFDLVuJvQrbIcXYTX3orx3bpqx4F8t55VIjaD/+BYHMvzTjObwjuBM2vVLkYOPxmx5x9d3Y8qF0X1GUNdp6/tkEUxomo9wDo7x2+E+n+qSiyW0DODiubPmd7tP1T0Vnuv2IGb7n3rcZGw7AN45fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754521190; c=relaxed/relaxed;
	bh=KcfvvkG75j2d+wQhqvhp/jfvQ6i81cVYK2IzDjw/IvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYW4V+TSpTgkZzaGjzlhWAt4YnJ0sm7ALOEAqw3rOavlf1f/H14/ND4xLJeoth150YZaKdkiHd6k/M6q/NE+ih5o11Sl6WNp6ZrX/NN9An1AOE98qNrRtAgJAzU+uAT7PSQZVofOqU97l09kb8cKHXJaeR+xvoV/3rio/7+CGLowBkdB2AZrsmE9OUu+uVrYRnyMC7DCLnfrfyR96aXE30Eccboj/7UZ6CEGUNxsVwuZiMaZAcjmb2pONSMIjBEyGh81JbK3irJMqfDdkugX5TDO/2kaa8ASJDLNobvffSCZDNhvXEtWhWNhhVVWM0457I5CUPfd6hnxSC4c9bGjtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OgglgPiz; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OgglgPiz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4by5N53lnHz2xS9
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Aug 2025 08:59:49 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D8F1B44E14
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Aug 2025 22:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8073C4AF09
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Aug 2025 22:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754521187;
	bh=dDM7iYy/AIyraTR1O/TqJPxcWhBNEAq3Tvg3vZpZnGU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OgglgPizuO6/3WaBbwiRRUJBy0VGQxZw0/pWpmTdTwVS0a67YXDlooZTxgD7bTxSe
	 +etPPVvI1Dn3N7oPtSsUuqOWHL0Xic86727Bnd3NefzUGC0nn2y0itOCmgjYmsvGwP
	 kK2FNOLbfou4xIzjY9pGGwlA/4RC/OXz/lcr++glR2XNNC+Bk2kib3AI1rtX4eWpzu
	 WSW0BtCYNDwA8AB0opTVEZSgEl4B8lN7FlG4jbIlEZ3+CKxJij4efJe5zTBDAfKazV
	 /L1lNFRWeJmwrrzPjuoLLAaQYzJelcVwiLjKvxZvxm3BvwwEqkqxm0k0vN7f/9VwyJ
	 /Ivd83Vz4CfOA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af967835d0aso57757266b.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 06 Aug 2025 15:59:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzx0DW1tAqXzeWAxiu/uIk3goI9w6O7HljKxZB31TAR3vkglPXb
	BhnwPFwPZ2tWxyhRJf/DplP0TFj9Y1dZqiQS7hhsukU26b8bZLE/1SluFR9fOsFRmmyfiXGn2F7
	W96K1/JwG6BIAzDqhw6iIsMAQhKq6Dg==
X-Google-Smtp-Source: AGHT+IFJm49FQ3qDs9QJ4zSUztXvxUUkXzeHHTnblRFgK77C0PGfkTOh6h/psk/FFnm7rWpnCJR4cDmmHjfc2gQuIl4=
X-Received: by 2002:a17:906:6a0e:b0:ae3:caba:2c07 with SMTP id
 a640c23a62f3a-af9a60bd3d8mr66628566b.18.1754521186262; Wed, 06 Aug 2025
 15:59:46 -0700 (PDT)
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
References: <20250806184711.1882725-1-eajames@linux.ibm.com>
 <20250806184711.1882725-4-eajames@linux.ibm.com> <CAL_Jsq+JBhak=YS33tG=KFtbb+Ckz69s5Chz6daEUY0O95QOSQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+JBhak=YS33tG=KFtbb+Ckz69s5Chz6daEUY0O95QOSQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 6 Aug 2025 17:59:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKa6R2WQQsaJ-Rm8NwVAt7gk2yRSyjnZ44yYn1un2C12Q@mail.gmail.com>
X-Gm-Features: Ac12FXwBLC02AdrQvR4Z1RK5nwIRSy2xeBZ701G7FQt_sUSyqWFUOdOSyfJmI2U
Message-ID: <CAL_JsqKa6R2WQQsaJ-Rm8NwVAt7gk2yRSyjnZ44yYn1un2C12Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: trivial-devices: Document max31785 sensors
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, 
	andrew@codeconstruct.com.au, conor+dt@kernel.org, krzk+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 5:04=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Aug 6, 2025 at 1:47=E2=80=AFPM Eddie James <eajames@linux.ibm.com=
> wrote:
> >
> > Remove the old .txt max31785 documentation and add the compatibles
> > to trivial-devices.yaml.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > ---
> >  .../devicetree/bindings/hwmon/max31785.txt    | 22 -------------------
> >  .../devicetree/bindings/trivial-devices.yaml  |  4 ++++
> >  2 files changed, 4 insertions(+), 22 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.tx=
t
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/max31785.txt b/Doc=
umentation/devicetree/bindings/hwmon/max31785.txt
> > deleted file mode 100644
> > index 106e08c56aaa..000000000000
> > --- a/Documentation/devicetree/bindings/hwmon/max31785.txt
> > +++ /dev/null
> > @@ -1,22 +0,0 @@
> > -Bindings for the Maxim MAX31785 Intelligent Fan Controller
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -Reference:
> > -
> > -https://datasheets.maximintegrated.com/en/ds/MAX31785.pdf
> > -
> > -The Maxim MAX31785 is a PMBus device providing closed-loop, multi-chan=
nel fan
> > -management with temperature and remote voltage sensing. Various fan co=
ntrol
> > -features are provided, including PWM frequency control, temperature hy=
steresis,
> > -dual tachometer measurements, and fan health monitoring.
>
> While technically the binding is trivial, I don't think this device
> really is. It has got 6 PWMs and 6 tach inputs, a reset line, 2
> interrupts (alert and fault?), and an I2C master. Not really trivial.
>
> However, better to have this documented as a schema than not, so I'll app=
ly it.

I take that back. You already have 'fan' child nodes, so this isn't a
trivial device/binding.

Rob

