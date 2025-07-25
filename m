Return-Path: <linux-aspeed+bounces-1830-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD14DC83F26
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Jul 2025 05:19:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bpGPf3k6Sz30RJ;
	Fri, 25 Jul 2025 15:19:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753420742;
	cv=none; b=ke4pacy4/j0rLGXVhm64UzbEBMkfoGwtMLlWwgpGl48uOFcRH2X4uzEwlvsyivUVMKVe8vrFcZ65Lp2ngni32/g+TWn9IoCq6Hj9mmZNrN3B4ifKOGfm6vk2LzGUrBHg+ViNvpzUpiA6SB24eRdnRVof1mK7PYskt2GErvTRQYROVs3LqWngQ+4zoEpw110isjAinO64lUiPb33HY1SnhqvZ6bJ9bx9a1tsLDLy9n6aMk/tu8hBBXC1rHnH9lHXlus14VrUldxbYxChowQQV1YBQaUt9Mgvv5/fQOMSIgkieFIG+0AE7a4tBnxsgGI7PpQjXV7vXZAGKCUN8poj4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753420742; c=relaxed/relaxed;
	bh=hwlCoX9n3S+W1I2p1kc9IDkLp+xJ/GgTuu9b7/n8qiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVkcfBe8e6++nmrCq9T3L60MAy6wM/JPHUQbfnRvz4dvutPvvEieqKLq9V+e+1Twi3T1ydb9xP/QuCwoESJxdGnGsThFFRHKlYPv04aCS/Odb/Znd1tXrzu5xWYQJ0pkm2r8WcoCGolL1ySct7eDG9ca9o9q7Yw2cEAPlLZo+8qT1cpQsdP/JhC7eD45tdLKLwsZMBhVIR6a3xU+NIiWzqoPmRJ9OwAEt2GI4bUf4ot0PETyjb0T1jg37peyd1DZi9AS3IPtI8y2rvW1MOt1aeRb7/c4X0EliGqBr4IpqNTNZzSd5KtDd9y3HFw37eOGMdQiWBACkDhs7BYPHtA0BA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OjdJRICv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OjdJRICv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bpGPc72c8z2xC3
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Jul 2025 15:18:59 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-747c2cc3419so1418796b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 22:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753420737; x=1754025537; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwlCoX9n3S+W1I2p1kc9IDkLp+xJ/GgTuu9b7/n8qiY=;
        b=OjdJRICvw2tjo4SX++Nkib4evt7tdFnh/e8jOsrogNa0kAiUOPkrNRYDS9TAH38amC
         0kmwSUqokOut+DMUeEqPEwREWjODaQd14gbA3sTWZ1YxBYzJYt5imJ26dZuHi+vv2fo0
         8YNrHK9IJtgZHsy80Vo1ZxpsWidk8kQZ+mFvSn5tEHAL6B6gkP3794Ee6UN4tc4r8Ib+
         YuDta/xHzMLRBmIaVuVOsPWRU6isEH2AwN/9BdlBFe49ZFPD4Clv5qsnrX0eGvSeGu59
         0ssdYwhefnQ10OMvgbCX9yMNHiDUytE6l7OAWvZz4WvFIeZkgY+qYoBshLU6Tf8NUxf7
         Os4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753420737; x=1754025537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwlCoX9n3S+W1I2p1kc9IDkLp+xJ/GgTuu9b7/n8qiY=;
        b=nJoiKFoS+8TdS/0iA0i5EHilKhnTDCSHo2P3J/UdqwDCNWRVWOoj6TRomUrmi2SK4g
         zu/jVJSfxiRtPkw8CDX7jMZknnQyZcoq9SfXwjHpgWEimhcwzuyvZnkyEQQZ7RwtUYVI
         R/4+2w3jiEC2pKjiUty3scVwpkzjG7/HxxcjyyYs5ele15UskGI5YnZJcKz3qdbJjoYQ
         FTrxp4/ti7dfqd0F3zJSRaz+sbH4PmGGqIvUaDA6prv6QFqktaLtUQ48XaXRoMm4dQB8
         fXvWxkSTejE+BgII+1w7+5KioDQD4IRZAMcAHooyzToqaQvf+/mVd669WHuLNqLPulqG
         Z+ng==
X-Forwarded-Encrypted: i=1; AJvYcCWp41TYfttko47NW6jVeGFWueliChLzWQ3Z/DS8GpwvcpuoRyEYl2i+hJ1buFC+XA7PC5/Z/+xbdp1JxZk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyicfDUUHhGHGlVjTOFYj+QABtBJmvrCSAc69h4yqDgovj20BPA
	G6582CEg0Xmu5Czbn8XWqDc7BWs/MvUyhSRmMkAaCXisox3mSrJ2lpmq
X-Gm-Gg: ASbGncuEuFvqhjGCDlf8GulXIEchW7nr/xfXRb0am3oJxoB4KmlbLIXRd4tdgJdHjdE
	DLOVzMiK6KJfWubdZmpmOgLYjHQoYya070Afatn9GggXpJBOBIDXmIGd/eWjSFPyL8U/j+RskAs
	eeVJidVaCGzaUidzDdxb257v5rCNZpphIHPKcmUNiY+2umo4wKcSy0yxF0z/N1RbNguv2ABO91K
	PS3U2rBXl4aY2kIA6kGTMS/57rYCKHCkp0SkyejwwllcIrIctUM0UcLbT9rdEyQum/rn5+jwGOr
	JKjMmeNFr7Wvn0rdIBgRfbEPCsvVlmnvQJEZPjj1IF3BD3iO5EuwPFW15QaGN3ZL/xNFS0i8hhD
	6DpIPRWeBMJH30+BhhCOeFc0Qqxot3xstKeD/YsVvYlUjX5BZw82+tz+Jm61ZZz59X1d1ky9eYK
	0=
X-Google-Smtp-Source: AGHT+IFPixTsfdXK9p29I79UGfIgXeOO9MD+/pKk+rfiR7TaXdWeo4fQpMcFgUkv1hBHXBF3FZnWGw==
X-Received: by 2002:aa7:88c6:0:b0:748:f80c:b398 with SMTP id d2e1a72fcca58-763382d8395mr881883b3a.15.1753420737003;
        Thu, 24 Jul 2025 22:18:57 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761ae15838csm2966301b3a.43.2025.07.24.22.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 22:18:56 -0700 (PDT)
Date: Thu, 24 Jul 2025 22:18:53 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 10/13] ARM: dts: aspeed: Add Facebook Fuji-data64
 (AST2600) Board
Message-ID: <aIMTvUyHGd/ikKY9@localhost.localdomain>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-11-rentao.bupt@gmail.com>
 <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>
 <aIGGdbIX9HaV4dB/@localhost.localdomain>
 <769d6817-ee97-4a23-b013-29bc875a00cb@lunn.ch>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <769d6817-ee97-4a23-b013-29bc875a00cb@lunn.ch>

On Thu, Jul 24, 2025 at 02:53:39PM +0200, Andrew Lunn wrote:
> On Wed, Jul 23, 2025 at 06:03:49PM -0700, Tao Ren wrote:
> > On Thu, Jul 24, 2025 at 02:03:20AM +0200, Andrew Lunn wrote:
> > > > +&mac3 {
> > > > +	status = "okay";
> > > > +	phy-mode = "rgmii";
> > > 
> > > Does the PCB have extra long clock lines to implement the 2ns delay?
> > > 
> > > 	Andrew
> > 
> > Hi Andrew,
> > 
> > Thank you for catching it. I didn't notice the settings because the file
> > is copied from the exiting fuji.dts with minor changes.
> > 
> > The delay is currently introduced on MAC side (by manually setting SCU
> > registers), but I guess I can update phy-mode to "rgmii-id" so the delay
> > can be handled by the PHY?
> 
> That would be good, if it works. The problem with the current code is
> that those SCU registers are not set as part of the MAC driver, so it
> is hard to know what value they have.
> 
> 	Andrew

Hi Andrew,

I set phy-mode to rgmii-id (letting BCM54616S handle RX/TX delay) and
cleared SCU350 (MAC3/4 RGMII delay) register, but somehow BMC is not
reachable over ethernet.

Let me see if I missed other settings. I will drop the mac entry from v4
if I cannot make it work by next Monday.

Thanks,

Tao

