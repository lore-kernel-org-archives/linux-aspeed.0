Return-Path: <linux-aspeed+bounces-1631-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCBEC83030
	for <linux-aspeed@archiver.kernel.org>; Fri,  4 Jul 2025 04:45:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYLg52pC9z2xS2;
	Fri,  4 Jul 2025 14:45:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751604353;
	cv=none; b=N/Y8uXLK51gRkw5SVYXru9lX//+NHf4Big6vrK3y6QmX+RSwKUOoO6ZPF4vMCCya00BqT4I1GHBcT6X+FjtRy8G9FY5b13L0rtF2pePGNUD7ury75ocO/wEQWsZXSJiWC7Q5fLo+hCJZt4eDeo+BVwo87bY1rvvahKYBvfIaiLQtHyjuvW3MffHECO895YmyVA7ZiIfUSYJcwzcLtRSqyTY+9EzR6jqLuT/yGorpQ4oqu6AWiQtt8hagb1xf4ksnG3eteEX2zaOz+qM2oSRwHZvOBnW69z9shXgV9ulysJ6PjuUTwEDorN7p+lpjPovPoABNj+gkvUrnVU2AmW95+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751604353; c=relaxed/relaxed;
	bh=cG3nGFKHy1r5C+lPIaBzR6QdGIwuCZhkFG9bY42b6Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1rLpcFK4gXiYGuiw0PDWN9PxFB4F2RvTrCsundXuTkqH072dYf85CpCh7vMol+HyD3JcJuk8Hwwz2jrWOXpbbywgZQLfpTypWEfTVrZNsZy1fhCP/tOevZFs+3Vr3Zpxffck0eb6EmwxDRGHDzGROVrYdUA5B87nf6tAJhyBhaxNR1AJJdLzpAKoGetCe1SwdVJ8+43b1QjLNgr32qjDV2GAS8kuqu039GOCxeA+BET9S+7RyOE6du5Q3MFDeCIh0+HcQpC7R4B3YoLSdxanzdiuet0BAC0sGcGRqp74DLfgz24NC/HdwWePlTY1ZQiYDDk2VhaGQq5R83FZwRNXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XIBWfXyo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XIBWfXyo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYLg374M7z2xJ1
	for <linux-aspeed@lists.ozlabs.org>; Fri,  4 Jul 2025 14:45:50 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-234c5b57557so6157895ad.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Jul 2025 21:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751604348; x=1752209148; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cG3nGFKHy1r5C+lPIaBzR6QdGIwuCZhkFG9bY42b6Jw=;
        b=XIBWfXyoGoM0dx0HYHtWxMnSbpIt7fdCHMGLKvgHNvoXzfCZ/mIDhJHXbBuAkmfExV
         u4i4KPGKci+PFS+Ruc5/hFaWLDADOhlx40OEGbrMwKTJP0Q+wQ96N5IkNKxlv65+8iHd
         Zo8lJj2/VE/g03Yp5zFiyQ9b2H98qHiT6cT2IRHdRoMuUoE1z9sijAvw86B8q5INhNpp
         k6iuo9f+rZWO9mwhCqrEvAaCGya1ZXcS88nZ4VE8wSXDMRpbz00oaFN0PBZeDxDjHEgS
         Of6U8BKNu00dDNbZ0/Ui3OYk69GOOV3U9WdSuyMb80T8GEPCpzuSzdKxx882Fbzf5qbQ
         Y5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751604348; x=1752209148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cG3nGFKHy1r5C+lPIaBzR6QdGIwuCZhkFG9bY42b6Jw=;
        b=LjIDXrs2lWjIvtTMcFNp1PnhPHTigS4voK2mFMG8Q/7QrVpuJUlOmqXvcAvF/vVTTD
         kZYfgt/qHFbOKBrRuUn10XQdcqtBwB0xwlZixU0aRQa4ZCJtjj8tzgnkOMNg89oCQWaN
         kQD+80J55EO4JR0vBegO+RP/+INc7Lxt+utqwonmRNCRkwy68uKoiW7fuCsZjNN9dCe+
         VD4srn+KaIvQ9aXPkl2fmrfVwyegA/n3lyRfnwiD99YVVulG1kLvAA2SQheiPCNFjy4s
         vscFOWp3+U9zbWCyIoABY6DKVIqZKmXepC8yM65751uPGRORZeDXzuXDR0yktzwEla9S
         adLg==
X-Forwarded-Encrypted: i=1; AJvYcCWVsT4djpav2ehTROpRnFr/GQius5sXdsIwJ1wSYZ/9eq3D+SF5VmhdTpirXMK2aFj7HPTf6mzoym2Z8GQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxTLbBgBz6jJtul9g7UwIWdVQLO8f+pt3+WfOl0XsHcd5Ixr52M
	v9lyeuvIKBxd86NjIjD1FPr/V2A26NHU3YAcIjmmRPBj374i22Nge08W
X-Gm-Gg: ASbGncsuMV9f1q8KN250afC5fAjQxR9OEgqS/GYtMN7e4F2Nz0K8Btc/ldsP/sdDQVe
	HsN6bbhJdgR49yPIRCpxo+Ba+Yzrj3LoSR4uYPyVg44I5QR+XHDbtVf/LjCnoKrFw4iXu6Q3Jkb
	XBRCCqazBqp4CfM0NxnK4yHXw5Mww0EJZ5mndt19TT2u8u+98eoYHePFUavg3wp/ml91D7L3L9k
	JvDu+d2J0elT8YZLIbd5tvf+BozqG90Jrhsqiy0wn6dfeZIwGe38QPxPYNUuvMkeYA6vPqs1Mb6
	94R8BPvrxBWrN75BTcjERKf7w06Cj+0EiH9WAp2/EW8qqF27J31MrorBmUGaspBzMR2Y3KKi1by
	GMNN5nR1zmZHz2+7id5Pxdd8S4hf/Sz2i8hAh4I8=
X-Google-Smtp-Source: AGHT+IF0o3ITf8BCpP5P9I2hnMwefUgNCwsqn4QO6uhOxBG7wPoKctcKA38mvJ7HISgAzRZvMAgLmA==
X-Received: by 2002:a17:902:c404:b0:234:a139:1203 with SMTP id d9443c01a7336-23c85e7459amr19740725ad.32.1751604347591;
        Thu, 03 Jul 2025 21:45:47 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455ba98sm9751345ad.135.2025.07.03.21.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:45:47 -0700 (PDT)
Date: Thu, 3 Jul 2025 21:45:44 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH 1/5] ARM: dts: aspeed: Expand data0 partition in
 facebook-bmc-flash-layout-128.dtsi
Message-ID: <aGdceHVCEaWxo5QG@localhost.localdomain>
References: <20250702050421.13729-1-rentao.bupt@gmail.com>
 <20250702050421.13729-2-rentao.bupt@gmail.com>
 <78f9fcbc58261064f248e95eb7740549e338bc78.camel@codeconstruct.com.au>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78f9fcbc58261064f248e95eb7740549e338bc78.camel@codeconstruct.com.au>

On Fri, Jul 04, 2025 at 09:36:29AM +0930, Andrew Jeffery wrote:
> On Tue, 2025-07-01 at 22:04 -0700, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Expand data0 partition to 64MB in facebook-bmc-flash-layout-128.dtsi for
> > larger persistent storage.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  .../boot/dts/aspeed/facebook-bmc-flash-layout-128.dtsi | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128.dtsi b/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128.dtsi
> > index 7f3652dea550..efd92232cda2 100644
> > --- a/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128.dtsi
> > +++ b/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128.dtsi
> > @@ -32,19 +32,19 @@ image-meta@f0000 {
> >         };
> >  
> >         /*
> > -        * FIT image: 119 MB.
> > +        * FIT image: 63 MB.
> >          */
> >         fit@100000 {
> > -               reg = <0x100000 0x7700000>;
> > +               reg = <0x100000 0x3f00000>;
> >                 label = "fit";
> >         };
> >  
> >         /*
> > -        * "data0" partition (8MB) is used by Facebook BMC platforms as
> > +        * "data0" partition (64MB) is used by Facebook BMC platforms as
> >          * persistent data store.
> >          */
> > -       data0@7800000 {
> > -               reg = <0x7800000 0x800000>;
> > +       data0@4000000 {
> > +               reg = <0x4000000 0x4000000>;
> >                 label = "data0";
> >         };
> >  
> 
> Two existing systems use this dtsi:
> 
>    > git grep facebook-bmc-flash-layout-128.dtsi
>    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts:#include "facebook-bmc-flash-layout-128.dtsi"
>    arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi:#include "facebook-bmc-flash-layout-128.dtsi"
> 
> This change requires a full reflash of those devices, which is pretty
> disruptive.
> 
> It seems more appropriate to me to create a separate dtsi for the new
> flash layout to use in new systems.
> 
> Andrew

Hi Andrew,

I agree it's better to create a new layout, and I will take care of it
in v2. The migration is already done for all the network BMC platforms
except elbert/darwin, and having separate layouts will make my life
easier :)

Any suggestions about the file name of the new layout?


Thanks,

Tao

