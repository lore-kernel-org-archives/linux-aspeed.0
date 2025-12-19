Return-Path: <linux-aspeed+bounces-3178-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332D0E668AF
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:54:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFWv6cSpz2yFb;
	Sat, 20 Dec 2025 17:54:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766132838;
	cv=none; b=do5K0OIF7JhmoffaLfJDtuYjWQ+r7cdvJ9gIJCyMn4k+1wJlVtQFAvC3ysbL8Voav8ibKpwoP3c+KYLkReSqSECAUmjaFZNo9TfJO/qTa4x5Ig9ry3FLeD7tkSdzpqam2FI0kW4grPDZBrvYTiuu0O9r1pAr2KEpXNyJqkiuueofssE7uYVjAc3xFxnX7o+Fd02Hrb9yS6zy3dxLzSbWm/sglNhOuNsD5a9jJRcvn9UgGF/cJSbWAWek0V/2yORFYC0uUSmZOedtfS8SOzraDm+uIuqThyXL0nQkQA/7EgWKGk3DQ9pLgDO32pRxzMBfL7HQ33Kq+CBlQbn4N36XYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766132838; c=relaxed/relaxed;
	bh=m5VbsO8NOFBu8cM3PiLkWiMooEcKpbjdJrZHI4GhWGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QC+biMO4JXC6Ekv5sXBxxqIDbKPMgSv7kBHkgSuWjSa+f9On0PXs3XU8+qFDNJL9YcPM9sTw9sp2a/Xt6DWYBNIk4ANN1F9Ug+Yr/wLABvXPfkXbCzOUtDyyXryn5sU2FBuErdVp8i4eBRthZg7DnV9bRu2pJg+J4M7TMb3wzPIUEBU2gZYgY41WtRwZKGdRQ5cRM1Rxx8Ju4NAewKDzM3h9rw+Go5syenkZWkbZGDbU9qq/nWMxwBq8HdDJqrXZg3fliD+m8UfXAfeyXWFIgP1eNU6Qa4XWnjBKfsR1X4e83s6HAX434rYjdp/0NbXdRTadHYyoLuhSPI9+k3UwTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QS63tFgS; dkim-atps=neutral; spf=pass (client-ip=209.85.216.45; helo=mail-pj1-f45.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QS63tFgS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.216.45; helo=mail-pj1-f45.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXgd14jX2z2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 19:27:17 +1100 (AEDT)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c565c3673so1221370a91.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 00:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766132774; x=1766737574; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5VbsO8NOFBu8cM3PiLkWiMooEcKpbjdJrZHI4GhWGY=;
        b=QS63tFgSPfjVCy/kj+kRIFqsPZB6Z5WOM7gOB6Dv60Q+fEoIr3ncVsh42LKxZ/tZm+
         7RDWrZNDt1BfMh3hHNRftHaWzaXKHIRxu94ePG2IvDYLah3aRrnx7nwU4gs6KxoNnOqE
         EptTNqcGfV8IGhyE6nabmFjD5dgScaHjO57AxlyGlWqnPlAvW6YmHolOKRQvDeRIsHBQ
         g5fc+oOJzya+xOD9lq/1SdWEU8bpJtdz8BWvfS7Dftspr2woDRBxC99lUdfcE5CazH+7
         sot0zyoEsizwop63M/r0DX1ZiCCTqsdo7VwqExK7/pvIJjsM25k+qPCViLvXmutaQKA/
         TUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766132774; x=1766737574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m5VbsO8NOFBu8cM3PiLkWiMooEcKpbjdJrZHI4GhWGY=;
        b=PszXUu3J1c/+9RLwcCxmnTX+wbQrWArWuatW2fCo6Vb/5ORhrIeh2vfH5XUmCl6th8
         1vNiT3RAmbXRKxU7Vvz8XjwwBoGGP0QHY0jkBZz20LLNwvwplQGBvJlLkb6vMPde4gQS
         6kbgR2gkgxDAEMIAWvNQIxJ3wFMd2vwsYLkQls0EjQ46xLpjTNaqs9BmG8f7T/A1CgcB
         d+n+qPtf93t4/Kk9SFknlLsklVY7QT3+YA5kusvHGYJOjfvVG22uExRm4BnvTB1Q0+zR
         dmkYgQnQRSd7zKf+lz8781pkqFEtTsxxox8S+OOvSpMkMu7TTaul+e/+/QoP8ExvdgAK
         uybQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKor7fR39bw3adgZwIbc1PrKwSmnJDUzvxQrsWd7EO1bWFMBrCNEgJplWF8DxK1mw9S4oKXgtXtorxxcM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwsNm589mkAKge63QwwQqNrWKvdqGpDTcBZbdgYxe8cS+A0uVrT
	pG7erqZJMztek1C+oRS/lV+SpqK/EI9C8S0JcBCeLUQ+2yTTZN34rtMMaz3fnjUFmw0N5vHKAD7
	kGulzHA+CjqRTI57FmDAuSZ7Qf0v8QXo=
X-Gm-Gg: AY/fxX6eArI1uu10S8fqgDcn+MrXW6ZZBIPnCfiRpidMcZAzKTcxP5FaNFCLEvJbVgb
	wa1S+ojEL+PsZ0jEFauSo2zqq1B9i2gBPhCeH2fR+0j6TZROD8Xs+JpClUMNAGDRUUCZoJ1AajX
	sXXoL7YJaNf1fePJ5RUpWRhYka5L2cpX5JoKIOo5nonOBJyZYSt8p3OEutdBfo6IwS9fGlnvEdh
	5wVvDPwBQkx6G2PXOzdRm0BKYTKYkvpl/D7c9arLZXkLIXVNdZHzODiBGlbHy2UOhyWRKQ4
X-Google-Smtp-Source: AGHT+IGPmADYM3+zkhv22FUUPyuAnnylSRC8nYRgd73Eur0wmU9zUYCJLT1U5U5sFLrEIkHvrknhCBn+vQ2wRGMXl9c=
X-Received: by 2002:a17:90b:1348:b0:34c:ab9b:837c with SMTP id
 98e67ed59e1d1-34e7151d99bmr5127645a91.0.1766132774402; Fri, 19 Dec 2025
 00:26:14 -0800 (PST)
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
References: <20251118-yv5_revise_dts-v1-0-fcd6b44b4497@gmail.com>
 <20251118-yv5_revise_dts-v1-3-fcd6b44b4497@gmail.com> <74b9c09cebac1de0e6e2e712a1374ab5294f61d8.camel@codeconstruct.com.au>
In-Reply-To: <74b9c09cebac1de0e6e2e712a1374ab5294f61d8.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 19 Dec 2025 16:26:02 +0800
X-Gm-Features: AQt7F2rMlRqPGBwtEiOBW-nH3v4LXxnrzuVjolj7vO7f61ahRRx-VbiavMDcxf8
Message-ID: <CABh9gBd8Mvpyv5WmFMQ7T4uDirxjprKpnq90+if11UOKZ4CN_Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: yosemite5: Rename sgpio P0_I3C_APML_ALERT_L
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
	Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

I=E2=80=99ve sent v3 of this series to address these concerns.
The signal rename has been reverted to avoid breaking any existing
user space dependencies. In addition, a new patch has been added to
introduce additional SGPIO line names and a more detailed
discussion in the commit message.

BR,
Kevin

On Mon, Nov 24, 2025 at 12:44=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Tue, 2025-11-18 at 18:53 +0800, Kevin Tung wrote:
> > Rename P0_I3C_APML_ALERT_L to FM_APML_CPU_ALERT_N for clarity.
>
> Are user space components looking for these names? Will updating the
> devicetree break older applications? I'd like to see more discussion of
> these problems in the commit message.
>
> Cheers,
>
> Andrew
>
> >
> > Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts=
 b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > index 45b8ac2e8c65a4f672e64571631b7f6944f26213..060757b7211a6da777c51d9=
f0c886796cf2450a4 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > @@ -964,7 +964,7 @@ &sgpiom0 {
> >       "FAULT_P3V3_NIC_N","",
> >       "FAULT_P12V_NIC_N","",
> >       "FAULT_P12V_SCM_N","",
> > -     "P0_I3C_APML_ALERT_L","",
> > +     "FM_APML_CPU_ALERT_N","",
> >       "ALERT_INLET_TEMP_N","",
> >       "FM_CPU_PROCHOT_R_N","",
> >       "FM_CPU_THERMTRIP_N","",

