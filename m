Return-Path: <linux-aspeed+bounces-1921-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668F3C87FD3
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 22:05:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4by48t49vGz2xCW;
	Thu,  7 Aug 2025 08:05:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754517902;
	cv=none; b=n9Hd5QZdG1OKzvKTqUwLuLTzxcR/J3cDwRAlMyVfJt32bZYqwOXBWccfBJU5/VWdQxTFf/h7V4OAA/GIltY/pGdBqzlFUa8IHDI1lJHaw3IW9nCsIxqIs4PgsYd/5oR41tBAR3iNUcSUe4WlSl1bIE2d8bYfVF5UTfGqJ8JltwfmiviBWxyJ+IEVmySyIAveLRV/HDhlZMDUNczd19MIeqMeQ0CcRlKkEk7w8jnafbJU2ap+Wq+eNShsrVfKuttL7sn3Szusj5U4QlnfB2UfRaYR7HPivxY3N2gjkgepot3eWxz4c/MdR+92e3cUfj8Jz55N4TPl1pthfQJS0S5wWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754517902; c=relaxed/relaxed;
	bh=lvtIJaY89Ns07FCpsPzKh0Y5jZAzWg6lfn9zlH+YnIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mF8EGSci1Q21uJW5YfD5mU4CkHaA1eqcFHwFA760pT2lIrLhYT2jIQX/G5yFlnK+TlbL9Sf7c8/xLzBMZeTWM+TDfBLtb5ZJqSXtVliKy3p7XybYJJexclLgU3nJzNaXlhbyaMgo+HZln8qgDuhWoH/aiFwvoN4R8Y73z4A5NFDSIsvJa5YExLejZ3nxJ+78dQlzcKEmY7qzj6tKmDkgvoWFq1R6QN7giTCD5HBpKGZywRCIavUYKiIlh178r2wfLD6mRuWGX9WuQlFYQwtGT5jbb7I5Ctwg65JLfSqXJ4z6ywEyvThGz2YQqL1ollfdHPLw0g4DHfvDiuYogGU0pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UPEDfOxb; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UPEDfOxb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4by48s3QqNz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Aug 2025 08:05:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1306744A9D
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Aug 2025 22:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92F3C4CEF7
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Aug 2025 22:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754517898;
	bh=XBXy9h0RXe8emjEbqbC6m8TfTRYUSfPZsoPdx3xkiIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UPEDfOxbDfeUUGaANWZp4RrBpoLlmR70DmHfjW4W7E+V5RrJVDg4wtRaeqmPToQOm
	 H7de07who/73Opu2Yg6MM4t4sYd/gDs+yymWRO63HI+z2Z9BnbJd9G3gU3O9/IzPdC
	 o85rgOVHiIaRev/s5Y6EmEo7KoeUiiXvnZOKu027CkODAwMUeMnNivfuULYM9iWywC
	 VfouMUFHhoFgs01vg8BWZoDvIVv97241JTuJlYHGfYDyPBMzLieP/bW9XHtuMnrZvM
	 hhOuObChjEfEYjIGv+RD3umvSRl6kNCprOaPZweEk+wRaP4Ug+rbBtJ1hFETgcFupC
	 ES8Bj3v3jcVyQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so545070a12.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 06 Aug 2025 15:04:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YyggGXRrMa2+0Y0mb5gaLHEVASKp5xUjpp7zZkrYbmX99xePBqz
	846YI/Sq6uRpM+ucSdGAKvSvajWZ39MBaUDsFs+lj/uZfBLfjd3IGv2VXi6yIrUB+6AN8ELWSrv
	QLSnzY70PQCr+KHyMEgXY55BCkaKG7A==
X-Google-Smtp-Source: AGHT+IGFO0C2oNNbI+/5/qV/5y6ZPflABnvWU9g3w+x8P6ViZNqC5D1y568b/N9TTteKYidrHHo2/ik5ZL5D6prIWTs=
X-Received: by 2002:a17:907:7207:b0:af9:8064:21df with SMTP id
 a640c23a62f3a-af992c2dd55mr371863366b.53.1754517897517; Wed, 06 Aug 2025
 15:04:57 -0700 (PDT)
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
References: <20250806184711.1882725-1-eajames@linux.ibm.com> <20250806184711.1882725-4-eajames@linux.ibm.com>
In-Reply-To: <20250806184711.1882725-4-eajames@linux.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 6 Aug 2025 17:04:45 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+JBhak=YS33tG=KFtbb+Ckz69s5Chz6daEUY0O95QOSQ@mail.gmail.com>
X-Gm-Features: Ac12FXyfR0wieXyxBEYZwoqcWgBwyaJLFglgRDqYs5T6n-aS5DrGLQU4aITSK5A
Message-ID: <CAL_Jsq+JBhak=YS33tG=KFtbb+Ckz69s5Chz6daEUY0O95QOSQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: trivial-devices: Document max31785 sensors
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, 
	andrew@codeconstruct.com.au, conor+dt@kernel.org, krzk+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 1:47=E2=80=AFPM Eddie James <eajames@linux.ibm.com> =
wrote:
>
> Remove the old .txt max31785 documentation and add the compatibles
> to trivial-devices.yaml.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../devicetree/bindings/hwmon/max31785.txt    | 22 -------------------
>  .../devicetree/bindings/trivial-devices.yaml  |  4 ++++
>  2 files changed, 4 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt
>
> diff --git a/Documentation/devicetree/bindings/hwmon/max31785.txt b/Docum=
entation/devicetree/bindings/hwmon/max31785.txt
> deleted file mode 100644
> index 106e08c56aaa..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/max31785.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -Bindings for the Maxim MAX31785 Intelligent Fan Controller
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Reference:
> -
> -https://datasheets.maximintegrated.com/en/ds/MAX31785.pdf
> -
> -The Maxim MAX31785 is a PMBus device providing closed-loop, multi-channe=
l fan
> -management with temperature and remote voltage sensing. Various fan cont=
rol
> -features are provided, including PWM frequency control, temperature hyst=
eresis,
> -dual tachometer measurements, and fan health monitoring.

While technically the binding is trivial, I don't think this device
really is. It has got 6 PWMs and 6 tach inputs, a reset line, 2
interrupts (alert and fault?), and an I2C master. Not really trivial.

However, better to have this documented as a schema than not, so I'll apply=
 it.

Rob

