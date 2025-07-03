Return-Path: <linux-aspeed+bounces-1624-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3DBC83F03
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Jul 2025 22:15:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYB161f6hz2xJ1;
	Fri,  4 Jul 2025 08:15:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751580954;
	cv=none; b=eMkqeSWsukGEyFpRTpmqE4sc4PJzDHomBD+iNrG55BPzzJSa/pWpjb72oypBQOapN1TYDYqzhjj/0n549GFnzISUWnazNwGzxHLq1TV6gCtWL2y8o+GEuc8QWgEQXyknDyyFeIWy1kkTyyfkDOuwPVTYmOliJCZsqBFnRb4dbx3toh9+CU868maAzeDed96XGL78jGsPOKHDDQwIm62tzHLyaUjcBs7BBMAD8k1cEQs923E78J3BaCuTlL3J0QChO2Y8ZKhUPmaGqPJKf+YWVeBagJnW5wegyQPbw4Tm2MHzOUqbVPvt5K8t9KsKWug8kWJDAMhkAK64Ox3cbt5b4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751580954; c=relaxed/relaxed;
	bh=LdVEyliI7CI2o2rNcOBW/maFK6t06bm6iyL8o0UQrKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oelCVx+j/BgAuRQ1tZ6Nb+KZeCufG6OfO5nkDgb/IcX3lPwHapJyZnogQitdS5y/uc9aam5DiWS3M2qSve28wf2gUO6oDnvoDOLgd4s+vgBAD74mw1sUtSGg9vJgXn9yzNTeg+wrDKbJlypj6IFa0Udo8JalN3e0tEgtPb4SKAkgjs/FaqPrvSs3I/gM64zQhMjLT96whUQvcS5ij5i1hDGhKA5PiamO06dYXCHY7OiKqPGLvLn3jIadFmwYwf2Y5m3+D0ZL6ikX1ioDHHueKBh5EfnpTCAHUTNfgbi4KMxOvCn3jU/jCLOtFEzsb8BLJHYsVpZqVPUeUW+KB+V3GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JDe/iKIt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JDe/iKIt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYB140X2qz2xCd
	for <linux-aspeed@lists.ozlabs.org>; Fri,  4 Jul 2025 08:15:50 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-749068b9b63so320292b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Jul 2025 15:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751580948; x=1752185748; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LdVEyliI7CI2o2rNcOBW/maFK6t06bm6iyL8o0UQrKM=;
        b=JDe/iKItt3hZTCE/mL7/ZfsvjIVTPakO4un36WCrsW1m7g0oNAxjDVqRRAToLhJsA3
         AUtV1UrhHPrbN5FGa0i03sqPoWS4N6i/X6YYihLR2Aqey28sxCrcf8+yGZ/Bpry/dLV8
         QV0QBqHnIrLHI4TlPLXVQq2VCoaruQ0GjOSTe98POaguUoejzwtrRXThiQvK9+9N7OjF
         sIyNpS8D0cxHyNNoAdfMqlhW4YlBhZMY3Pe8s62M0TXrL7lVVafhgTcaooSNgPl0sSiM
         kSfR+GiV6fN3LWW8jZPLPbLMhDv0fjM2N6WYy3klvNMw2UeN/J6M5Cs3tq/iSQrUZ8ub
         KmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751580948; x=1752185748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdVEyliI7CI2o2rNcOBW/maFK6t06bm6iyL8o0UQrKM=;
        b=IgnYwb+iEbRrV7hz7QYIF96E0/0voRLJeDBVKLCa4iKQbaAkcIamuYee820H3sOCPy
         pfpYRhRKd+nbRqhwSZ/yzWeEqp3Q0H5oUb+ockfxr82DmZSutiU3bAfSy0TmwbPi2YKN
         tNjFKlREAPtuO3HweZQjuhVcTVzakDdkIhW+egTpgfFaqWeHg4f/r2pv8CSmDJbtCM1B
         uPDXqItipDAKbmSowofUiCc/hhbxr5egJIjcfnz+/YW3FUGgY536hU+J7xgA/rdC9WfE
         rQ9sl0oIq4ixn5kI9ZyzvE1PsFZKEOFuZB1yK1L6sapWdH5rYXUQjPt91x4Fs7ZhWH5k
         evsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyfdlTUzGjNnWL7nUS2YU6B0XXU63muY9+4swk2orxAhusi+h11G7/syVCxi0KHFystcn4wIWjYEEX6u8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx2agRCc/rlA0PXHJK4qHK62oKxppbVU39z8y5pmSA55WU6s+21
	Vtjo6mu/ZxMK7NrDWpC6f6XAs/LodX2FHXUBo62BMhTKUjM7+1pD2ITg
X-Gm-Gg: ASbGnctWMCV9d9pXFWZ8kD5D8FGpshauiv1E/SYDI/Gl0cr8d8wn5TTijeKairYdp3L
	8f32i9oqETc1/zoybFl4bnemu19kxClvOBIQjrJ33RXG0YhMEssRCqHe7m7H+ZDmX7GwgwFqi+h
	g44KMs02b324DlaHku4nkO3vtnEGHrnraYpFF7SKb216XvB8fAFEA4xLPfYXRkxaTv/VCdLvJv6
	a0ml0ihtjznXROF0zAGC78JEoAX8KM3zfWwdgjpha2FgrSik1x1yNGOFEfD5pfAnBvMEZC4lYIO
	U5KD5nFdxNhMFiB/P8HnNndssppa5/7vkHqPFB91HSx/Y4JIOL1T8b7jEjt5MquGPc+z4JqB7mL
	M1khvA0v0fD4xvlnKtM7OxNr+Ts6sON57fyM9pmT4SJYxOAXVRQ==
X-Google-Smtp-Source: AGHT+IGUk7PwRYq/uESipZTr5l7TnZjN4IATKVV7k9iHCae7JNaUFn05U63lEW19hVmJQS8UvmDn3w==
X-Received: by 2002:a05:6a20:72a3:b0:220:33ae:dabb with SMTP id adf61e73a8af0-225c0de25fdmr530119637.29.1751580948326;
        Thu, 03 Jul 2025 15:15:48 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce429b34dsm423082b3a.120.2025.07.03.15.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 15:15:47 -0700 (PDT)
Date: Thu, 3 Jul 2025 15:15:44 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH 5/5] ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
Message-ID: <aGcBEHMEyQJuzmjj@localhost.localdomain>
References: <20250702050421.13729-1-rentao.bupt@gmail.com>
 <20250702050421.13729-6-rentao.bupt@gmail.com>
 <a6f6966b-50ee-4b4f-9422-96c6ac9391a2@lunn.ch>
 <aGW8Nm8ZWMwRYVOo@localhost.localdomain>
 <220ac6c2-8373-4742-86fa-f322d6ada624@lunn.ch>
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
In-Reply-To: <220ac6c2-8373-4742-86fa-f322d6ada624@lunn.ch>

On Thu, Jul 03, 2025 at 09:58:48AM +0200, Andrew Lunn wrote:
> > > How do RGMII delays work? Connections to switches have to be handled
> > > different to PHYs, to avoid double delays. But is there extra long
> > > clock lines? Or are you expecting the switch to add the delays?
> > > 
> > >       Andrew
> > 
> > Hi Andrew,
> > 
> > The delays are introduced in BMC MAC by setting SCU control registers in
> > u-boot. The delays on the switch side are disabled.
> 
> Sorry, but not acceptable. This is something i've been NACKing Aspeed
> DT patches for. You need the MAC driver to interpret the phy-mode and
> program the SCU control register as needed.
> 
> Since you have the MAC introducing the delays, you want phy-mode
> 'rgmii-id'.
> 
> If you want to submit some DT now, drop the ethernet node. This is
> what others have been doing while waiting for Aspeed to fix their MAC
> driver. Having said that, i've not seen any progress from Aspeed, so
> it either needs their customers to apply more pressure, or somebody in
> the community to just fix it and submit patches.
> 
>     Andrew

Hi Andrew,

Got it, and thanks for sharing the context.

I will reach out to ASPEED offline to see if they are actively working
on the MAC fix, or if I have enough knowledge to work out the patch.


Thanks,

Tao

