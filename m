Return-Path: <linux-aspeed+bounces-3177-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CEEE6689E
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:54:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFWq4fjZz2yFY;
	Sat, 20 Dec 2025 17:54:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766133443;
	cv=none; b=dUrfla7OZpoIe3nf810dc5sy0dKrAR8rdoXXgHJHQ8u52+JwhBtmn/5BIBmD3tg+8u4AYHcWplWLLvDchV1vzGCVRD5fd6CuiezSQo8l0zDNbcjasc0slrOoX+eWagKjXOc1zZCoCm3htgOS5bg8gmt6xDoVXfZ+u7SMuw1/BhJjQOtoLUcd8q5ZkKu5EV/ipSxz0IL5+WNm/R+0IRVIl24jeTGA9OdCzTZOUOpoRhTaV+Sf/J7b04Q4FfCrVhByS6W8kMqgwhID3ZPZQ595W4FitoKiemswzYqUF2Ny97+Vizc0GqN5CwxdsimAP5NiOZTHdQfSIdNB9Q09bCD3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766133443; c=relaxed/relaxed;
	bh=ZQ15vqIj64VulmTvMX7gKagznPfyt4IeoJrE3JDAELA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUIRE5owaBj3/LDUvEpQU/VJFw36wRPZptSxXvd3aGAsLrCTwsn2rkHozFUPLxDJvarw1Xyraya3HfDlBunEMfkeihKuJHnfsIw70AOkEWRWjnxXXN+aU4ETkr5RY+fuEoYQzFnZ64BBNOfNK9Wk3VyfxEmkCvK4ryrKJn4hObt4XVENIJ0NVmuPlGrMWhZCwB2YTF4d2IlZJYvZfgGPR0cMkhjwkkR2EvzU1QhYBSN1+3Eyt+ThlZvo5e1bebG+OmgrACbOlHuQoH9ZbMtnull2vbrjUpkXT5bCbquGiNnsNIcVEvZVUYqba2hLbc0wDpxSWrsS3q1zv0Mt2WApng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fm2zm4Dv; dkim-atps=neutral; spf=pass (client-ip=209.85.214.182; helo=mail-pl1-f182.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fm2zm4Dv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.182; helo=mail-pl1-f182.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXgrf5Tghz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 19:37:21 +1100 (AEDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a1022dda33so13114945ad.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 00:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766133380; x=1766738180; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ15vqIj64VulmTvMX7gKagznPfyt4IeoJrE3JDAELA=;
        b=fm2zm4DvO2O63OFGJ4QlSWfrqAGU7nfLuWJZWorw4JSw+RshKXiOGYFDNyDogNfGVq
         GbaFl7imYdnosV2bB3c4KWGWn/NjuaZznQ28k0n63Fmlz72ikX6iIZatnGLTCl0Z8LUV
         whFXNKf4mlokOC90m2KvxD2LU40s/MxMmPyfTZ2CkDRivfBTXLr/fMCiY62o8CnXI3i3
         NuSylRYyCUuuUTTHfajg2xZPiaccZ+wZl880kr/E6uizzPwhkjGjgwRtvoMD0QQylb8C
         IV4AKZeOpyopdc8xuxkCO1rI46iA/WeidNCyCc05IC36LGvNRSqVwPYB6zeHH/hyVDar
         XE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766133380; x=1766738180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZQ15vqIj64VulmTvMX7gKagznPfyt4IeoJrE3JDAELA=;
        b=M2M7ouOk+dQrjtp9083fGfeVnWEAEkVOPa+gUNMA64J3biJOVsG30elGxh5jvROnXB
         BCLOwVHHtiPTT4qCOEtChAyQi5utEjoZ+7s7x4YAlZLZj0WbGdd1e38hNExpyGH9m6xO
         3YSZZ00+VpuzFotiEoS7Jz1IYTcG2RpKbd/Ua3Z4H1BPbWKpBkzXTJuGKnmf8FIYODpa
         Lu1rrcFxgxuQ1jFg2wiV9AKPmfB3zKxge3gKspwI1Uyqd9rhDogaONvmoRa6CWszfot2
         fAWx0s9mKtOW3Qupx4IN1J3HJaWq7Dnq+RCyXPXUKWiKBCy4pFz6VWpLm0OHmvFj18Zf
         Y4mA==
X-Forwarded-Encrypted: i=1; AJvYcCWkEoeefEjzfp3IFdZcBP9/0dU9KI5psIt01hqDfX4p+xwDI5Bsi7BIVEu1hanJyTTpIR/qZTpD7fhKhzU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxU5KFabaSj66XLZUo+qkdo+Hd9Gxq6gLwnmBRkcCr/8s1Fe5hI
	4ajql6mmM4hEJL9+hEkvOQoPy1mK4Arb+Yjwr92y+MNe/dxMHjIZgx4B6VD1CQ2Y2m1RKPPfSwo
	unaR1epUR7xESTQ9D+rd01EV65NJHIsM=
X-Gm-Gg: AY/fxX4D911X/TIIY5uRAoruFVU1Z+KPr5UjU6ayn4DAXAWhQKEuBl3LEz8/K1ibR0A
	6DcBsY1OZolhWwR6ONAgI7c/sJz8NmyTdRB1JMIvh4NLiXV6VfuQPvQR+niDKKJUNWyRnAHsLzK
	25auX/TLI+fMVsTi593FynGH6DE0ZdkQjWHvNIO8C1rl2b8V/g16wln0MEYLq8j6kKk3Tdxwu+N
	OkX18rvqmLqRbjzl+7UlOW4n9B/3bjdyKyqLKEkXKAVAuIfzEBieXWxZURkKtYLbbvMg2iM
X-Google-Smtp-Source: AGHT+IHoMetY0jMBrCjdGc88mFfxhQzBRDJteW86k7GC+pHgWJLGWEQWxMUQQCJ4cUxyjd7HhWR7FTDj+6JvEJptRWA=
X-Received: by 2002:a17:903:2a8b:b0:2a1:3cd8:d2dc with SMTP id
 d9443c01a7336-2a2f2b53f26mr20958725ad.57.1766133379728; Fri, 19 Dec 2025
 00:36:19 -0800 (PST)
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
 <20251118-yv5_revise_dts-v1-2-fcd6b44b4497@gmail.com> <ad11cd30eddc1b7c496cc92eef129eb5c0f2d604.camel@codeconstruct.com.au>
In-Reply-To: <ad11cd30eddc1b7c496cc92eef129eb5c0f2d604.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 19 Dec 2025 16:36:08 +0800
X-Gm-Features: AQt7F2r_PXl3skkkTv3B_wJpuSzrJrIzk8N8zRMoeuWF6kLBddZNyUa8Y0zFtL4
Message-ID: <CABh9gBeCU7Xr818AL2ud4SxFQ=D=4D9YwiDUu4HttWuOqO+7ag@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: aspeed: yosemite5: Update sensor configuration
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

Sure. I=E2=80=99ve added more detail in the v3 patch to clarify the hardwar=
e
revisions and the rationale behind this change.

Across Yosemite5 board variants, two different power monitor devices
(using different drivers) reuse the same I2C addresses 0x40 and 0x45
on bus 10. As the hardware evolved, newer board revisions replaced the
original devices with different ones at the same addresses.

Keeping these devices statically defined in the DTS can therefore
result in incorrect driver binding when running on newer hardware.
To avoid this, the 10-0040 and 10-0045 device nodes are removed from
the DTS, and the probe of the driver is instead handled in user space by
the OpenBMC Entity Manager based on the detected board configuration.

BR,
Kevin

On Mon, Nov 24, 2025 at 12:42=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Tue, 2025-11-18 at 18:53 +0800, Kevin Tung wrote:
> > Remove sensors 10-0040 and 10-0045 to align with the latest
> > hardware design changes.
>
> Can you please elaborate on this commit message? I'd like this
> description to be much more specific about revisions of the hardware
> design, and why you expect all instances of the previous design to
> suddenly stop existing.
>
> I can't imagine this is the only hardware change that occurred. What
> other changes are lurking?
>
> Andrew
>
> >
> > Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 14 ------=
--------
> >  1 file changed, 14 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts=
 b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > index 7991e9360847532cff9aad4ad4ed57d4c30668a0..45b8ac2e8c65a4f672e6457=
1631b7f6944f26213 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > @@ -674,20 +674,6 @@ gpio-expander@22 {
> >                       "PWRGD_P3V3_AUX","ALERT_TEMP";
> >       };
> >
> > -     power-sensor@40 {
> > -             compatible =3D "ti,ina233";
> > -             reg =3D <0x40>;
> > -             shunt-resistor =3D <2000>;
> > -             ti,maximum-expected-current-microamp =3D <32768000>;
> > -     };
> > -
> > -     power-sensor@45 {
> > -             compatible =3D "ti,ina233";
> > -             reg =3D <0x45>;
> > -             shunt-resistor =3D <2000>;
> > -             ti,maximum-expected-current-microamp =3D <32768000>;
> > -     };
> > -
> >       adc@48 {
> >               compatible =3D "ti,ads7830";
> >               reg =3D <0x48>;

