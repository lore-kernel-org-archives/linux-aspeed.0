Return-Path: <linux-aspeed+bounces-1766-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834D9C83F1A
	for <linux-aspeed@archiver.kernel.org>; Mon, 21 Jul 2025 05:55:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blqPW6Mjhz2xRw;
	Mon, 21 Jul 2025 15:55:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753077327;
	cv=none; b=Z0a+F0D0wQtk+tnV4I3NqW0WHdtioiqepDFZQjb7P/zpgk8FHfahI7xakpjV0Wk4PCqvibPue+pV4xp5wsG6jgPMQPh6rEsGql6YXhwe5McPNScWCXZF9Hc9lvthdR9+q+j0Gbzbhv7CwaK7uXo8xaJSMpTiVAGGdqvpd+XeNmCEDDxqEFdYKUN6GNSPaTG2xWK9flA2CHdtDIXi+nnDizbxoCOJHQlqrBLdJh7Rec8N6u5joLU5Ed+6srsEEBroMIb6xtvvUMsuzyA7HhOHlkCtDCo8wnqbnSvK9DNwOkEz+iBj+bhY3l6eDpD+YDl00WTw8HVCt6a0PdmaNvKtKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753077327; c=relaxed/relaxed;
	bh=pTbqmd/pDrisqN9r4zUGvC27ftvuz5/Vq0UCrl06Tzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGo71i+lc4FYnB2boWmifTPKXeSV5GJqs+JJIUCGkDHlBsqUkFwp5EAI4/5GWF7nLhR1uxMXTZjnQ1t7qiIE+Ert1ftUeuPytsMNVQF93oKh1VqlpFs6sTPfQNtp3v23r6HLSQl+NG8NGKOwqk4UA5pmXugXLAe9LNjWAZFXBSSiX9onEBR1rwYM6CNfdTfSvEMeYLPhPUjGvSPI0bd9bI4O7ijrR8z69tKpT0WYWDTUgUnMVqq8WUSc9XfTlWdO5v5bLYsHglRzmxT2MIpOoz3AfGnBDzM06NrR6P2tcMzyRPU7q9z9lXbgboV+1ANe3MsuL4mtEHXlFekCgs8FzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BlVLlQ1z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BlVLlQ1z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blqPV5Kljz2xCd
	for <linux-aspeed@lists.ozlabs.org>; Mon, 21 Jul 2025 15:55:25 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-7494999de5cso2597502b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 20 Jul 2025 22:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753077323; x=1753682123; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pTbqmd/pDrisqN9r4zUGvC27ftvuz5/Vq0UCrl06Tzw=;
        b=BlVLlQ1zqx7DXlKpJp63jMrV9aDtCki/k4z1Dyd1T/09vVXZ6XL2htl657+x4iVyIO
         gsVgnHGDSOzbk0CVia6N+LHR///c0qHkvd6GwYSfWNZGElF7UlRZdVv2lS0yHTAIQoOG
         GQ79SFO0lzMMeI62RQsdcv/7J+4a1opot37nxAXOWq/uivUfFUJ8WsHtCdRFO/nJQPSw
         A2Mn4tnmdfI1foSsVUf+dJh/nMHDoUp0+ESJ3waDZu5M+E53gjKevCBxU9D0SIe8MKTm
         z6Z2pYXr4Z3L66lEB3uYkbCOnC0GgBF8KwsL1mUmbbM2u+Wy0we5IItX8QYk8+9JBcQO
         H9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753077323; x=1753682123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTbqmd/pDrisqN9r4zUGvC27ftvuz5/Vq0UCrl06Tzw=;
        b=URdlnDr8nZKSLEywSJ7hA9QSplLHti+r5iKSGLWzFBKYrHBco4Mh1VGBhWWjmUkD45
         X5+/Ln3b6BusKML/GIjvWSMz4puBmcUoO2wNpTwbCG2jo41DVBX5ztjD2A2tfTCl/FnK
         MV6cB6FaJG3bMFjtrHBY8zRsJKCqhpLZ+UcgMJ9fnL37+DMsbkrpaxO7dKU2lTv0Kl0A
         AJDEMd+PNhkZfgFm4nqIUJs8LlaIeHIoxyXooXhY4YkWlXWu+ioCNMPq0f6GM7vn9Mfo
         t4IvdsBRrgesJTTJszsGA3LGuur4SRMGnbqHezubD7REl+OEmGb5vLbcIwFEQhXq/eQm
         XKBA==
X-Forwarded-Encrypted: i=1; AJvYcCVtf+C9g1HyZhSXLlxw0tyYu7o6XQpavReY3uuv0LrHfEzn6E/9TleKIwUbGfX4G1LXhsO/2OwFN5o3PkI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywr9qy2pYj/SxsBAmj+Jj8jDtxCMARQSTZRqI9VIJ9yVrbIQzUr
	cFWDRRujI/nlBT5sLXzhuVZqBMYlvFNHwFE2agvE/f/b5J8WtnuluT/n
X-Gm-Gg: ASbGncvqLgOTCyN8eCcSPHxwFtREv9EcI+W3DDFKjdPIf+2YAZoQ8rCGmB+3ObNenv2
	ocoIonRMZ1QZZ5YfK2tpzbOa6vKQnXhTJY0vjXYWs2/uggUtZs5+gKkON+2xitlEWJ34bNk2qML
	DU7Ul8enpYEt7lB3j5278LQdrtpqVzjPRcN2sEterMzUEiwnJzQhQWWTiIf+mTIeHEg69jxLJBF
	2uNEuXxXSYEzMBn/kEnV5KWpzfYSvH2TOkksu+p1JUL2nItPIeI1/ydARPvIXP5BlYlE6j/7W8K
	bBufSQ2R2e/dOePMx8dfRjArQnWHOQJc2CsohLESsIgyYXxm0O6qNskyiDt3w6g5MPRlj9n2fzV
	Tobx9nawUw5L/vaIfwFASufGYfME4tpR7IURIzgdSwUdJE64O45xreH6d2/jy7IFXbWkfqwpkAe
	4=
X-Google-Smtp-Source: AGHT+IFKnAKH9LL3fu6dCh2WrvJAAXiTbjHR2Kk8Tffqoygfy2DvBPBBXVdwIstByROSc1BOjkXlvQ==
X-Received: by 2002:a05:6a00:3c8e:b0:748:2e7b:3308 with SMTP id d2e1a72fcca58-756e8773a2amr27457074b3a.6.1753077323016;
        Sun, 20 Jul 2025 22:55:23 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89cfac8sm4939060b3a.35.2025.07.20.22.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 22:55:22 -0700 (PDT)
Date: Sun, 20 Jul 2025 22:55:19 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v2 5/9] ARM: dts: aspeed: wedge400: Extend data0
 partition to 64MB
Message-ID: <aH3WR4HL/nzXfDCU@localhost.localdomain>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
 <20250706042404.138128-6-rentao.bupt@gmail.com>
 <0b9b6c712bff18a25da218c507d18b9a8f18c7e8.camel@codeconstruct.com.au>
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
In-Reply-To: <0b9b6c712bff18a25da218c507d18b9a8f18c7e8.camel@codeconstruct.com.au>

Hi Andrew,

On Mon, Jul 21, 2025 at 10:42:03AM +0930, Andrew Jeffery wrote:
> On Sat, 2025-07-05 at 21:23 -0700, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Extend wedge400 BMC flash's data0 partition to 64MB for larger
> > persistent storage.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> > Changes in v2:
> >   - None (the patch is introduced in v2).
> > 
> >  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> > index 3e4d30f0884d..cf6c768cbad5 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> > @@ -92,7 +92,7 @@ tpm@0 {
> >   * Both firmware flashes are 128MB on Wedge400 BMC.
> >   */
> >  &fmc_flash0 {
> > -#include "facebook-bmc-flash-layout-128.dtsi"
> > +#include "facebook-bmc-flash-layout-128-data64.dtsi"
> 
> My preference here is that we maintain two separate DTS for Wedge400:
> 
> - aspeed-bmc-facebook-wedge400.dts
> - aspeed-bmc-facebook-wedge400-data64.dts
> 
> We do so such that we implement aspeed-bmc-facebook-wedge400.dts like:
> 
>    > cat aspeed-bmc-facebook-wedge400.dts
>    #include "aspeed-bmc-facebook-wedge400-data64.dts"
>    
>    &fmc_flash0 {
>    /delete-node/partitions;
>    #include "facebook-bmc-flash-layout-128.dtsi"
>    };
> 
> aspeed-bmc-facebook-wedge400-data64.dts includes facebook-bmc-flash-
> layout-128-data64.dtsi as usual.
> 
> From there we can consider aspeed-bmc-facebook-wedge400.dts to be
> deprecated and can remove it in a future release. At least with this
> arrangement any revert of the (future) patch removing aspeed-bmc-
> facebook-wedge400.dts has no other impact. Further, both layouts will
> be supported in at least one release, making it possible to update the
> kernel without requiring a simultaneous update to the flash layout.
> 
> Andrew

Thank you for the detailed explanation. Let me send out v3 after testing
the changes.


Cheers,

Tao

