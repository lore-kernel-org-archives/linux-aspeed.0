Return-Path: <linux-aspeed+bounces-1937-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CBBC87FD3
	for <linux-aspeed@archiver.kernel.org>; Fri,  8 Aug 2025 14:48:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bz6Mz0bKzz2xQ1;
	Sat,  9 Aug 2025 00:48:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754664495;
	cv=none; b=gRPLSdTOGxXhtgB1aA/Y5SzD83+pRLX0ffixXCNqH7l1PZywdgI1Ar+Q8GPYKToRB8OX/3AAj038jTPHysH73EsJwN5S1rAb2K1UzCYU63ZNh3xO+MaBGCIFa3Mps3AFsW2W/buvOJWQjHlPPEdTahUwINnC7a8336vAZU0XL+NV1Cogd9GhmrOsSQIJvYNzHKPBw5bLAX8ezy4h9zx26zHlMXOGQSignpraWJPw1hdEMh4u5iNJErM/OByIaZ90KeQr6PDzwX43HpMAbXEoG7KkCUxfZf2KJiAUPMJqGosOgUQicPjbSiovxQ3qnLDO+pex6UL12mrV8GJZHbi0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754664495; c=relaxed/relaxed;
	bh=ewzjsdpoAykHhEBFgJ/UB1pQfM2cO3t1vQCCzVyKC6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XASPi6Q9o757L3JDpJovf/1y5P5e718c2FTGdIRNo0tCOBZyvTIIUI3aHG5jOAZBERMC1xVRMN4plzZ91Y5xYF6MwCbwMuGeZeT9uN0yJ9Bvado2guO1AVJ+omyy7VOHnAd4lF4Eb9REvQaolxf413/zfHEmpyMwdxnq87Df1ToGlr16jBWi0eKC6SjsE4mILr48qSfoDDtdEtR1oUQE5qu4BVgC1866GPzh6PbWe08Aj1SWT6w7QKYRsxB+MQgKmWDyGt+hxqhod3OmP5CeOpFWENQtIU1yLBq5eU8OjAZfZgvNGxrw8m1MEZfXvL+TT66XbpELTnLILEwBTiFXIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=minyard.net; dkim=pass (2048-bit key; unprotected) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=BgJHeEmp; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com; envelope-from=corey@minyard.net; receiver=lists.ozlabs.org) smtp.mailfrom=minyard.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=BgJHeEmp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=minyard.net (client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com; envelope-from=corey@minyard.net; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bz6Mx2wRcz2xK7
	for <linux-aspeed@lists.ozlabs.org>; Sat,  9 Aug 2025 00:48:12 +1000 (AEST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-61b50eddbc8so983837eaf.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 08 Aug 2025 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1754664489; x=1755269289; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewzjsdpoAykHhEBFgJ/UB1pQfM2cO3t1vQCCzVyKC6Q=;
        b=BgJHeEmp2cnj4ZJ+voWvUmeXbQFdYfyfr6bM5VvNWnD5mdGHlZNaJqsDuLEHpoMnmM
         WKh4ZVbpw3mYOCficD91kRea5TnMuxGD5/735QkxyldvFwamvfDt0TECmo32FdF7vBqC
         Vsbwxh6SEBSTITYNnt0RrpMIgxpauTu0Tnfa5rLZQ1wiMoLNo+dBgIWb0aOnVpnyfPCl
         x5UoU+W+GwlVdbC3Q0HWCeQVkyk1YHZpw+4QA4mme88Y+xr6LkMi3nUk34UosRlwflPm
         Yr36gKMqtVEcG2MZx0X5RCpGMzk9Vywfx3LSEhNfCBd5FA7JJl/xVlhml8G0tHlPQWIn
         G1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664489; x=1755269289;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewzjsdpoAykHhEBFgJ/UB1pQfM2cO3t1vQCCzVyKC6Q=;
        b=j4i+6FAXMCDzgO4W348Rd9ajofvrr60xS8JwexfZXm8PjQ9MSiIZ8xaMiZhu9l2/eI
         a6B0lh/G9ICMXHcmCZQI6j2LsQB0wZAng5g76GpaU8EUPRZcy6u02DQYcfiwRkEDD6qR
         ByejFWTHOdrtQ9f/OHUAajz78PTstf+xDBK4yG+wRzyS6y9gKcrisG6qGWvIfum4OXvo
         pIbYyTsRcSEVQ9Ff4do1ZwYA1ZSxTybSzfN++Ee36GxWtrv+bKm3mXSjZRf2MkjBJAbh
         yi37OrZwBKZopY5+Wf52iQapizwvpSETKHLgPHkEBh9LZZ+kEJSYwAslJD4MB1HozXc7
         dGjg==
X-Forwarded-Encrypted: i=1; AJvYcCW6uMLnBeqSA95b7fB6+yXCy33cJC7oC8J2RyQcoCVpzsAtE9K128HRbNxTsXP/Qo2PRGLK3PnAfU1b00E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxIsjJriEgxw9mQgHzAJwlQoRW2OoIYPOC5/byBW8Ij1QTqEQyW
	RAqY2eQLN7dgNzmpPgHGm5LWpllX4zyS3YrKRGkN1ohalVn3vRLWdobAFRa2fn6djiY=
X-Gm-Gg: ASbGncvHXWOTI6olw8uEjT4F19gPw5mWbYGhKZ7pxR/bypVsgp52CtXlV4tz7Y3CRdv
	h2FdbXu+MkOyJxFU4S/wfycoWfF2b5dU4vP3gLeu9KEcMybCPLl/208PYy02nww1SYrCeFvkwq/
	hfJWnl9ZQTdJjbWNuWkC7L7uut/OIngQ8DXJHUPQOVebr3lunwvW356+4Zk4KmKNCYuw+q6RYOL
	JNIGJhnVyX5nAi0rFBAB7CkmpEta44dO1zxOrZ25E/SDcMzrCOMaZJAmimj65+UoKxlTkEMYMmO
	sQ3QdTC3gqUGEI6pBCm52/6Nbw/+bMtcjDjG2bwK96ntb44rV17tsqB6pPglTrQG0hUJA6fGsjP
	S/R4akVhEFQROMrh+OWXJHjOjpfLbynTZt1Jc
X-Google-Smtp-Source: AGHT+IG4hCE+IdcT7gDI6Y/FY4GnDriutfuUfIR5SNfXBdFrj25/eWOpBz8eI1y/JTwOMLKAIgdhrw==
X-Received: by 2002:a05:6870:e311:b0:2ff:8ee5:d1f7 with SMTP id 586e51a60fabf-30c21080f92mr1906932fac.1.1754664489207;
        Fri, 08 Aug 2025 07:48:09 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:e698:accb:897b:ca29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30c3a9d052asm123722fac.14.2025.08.08.07.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:48:08 -0700 (PDT)
Date: Fri, 8 Aug 2025 09:48:03 -0500
From: Corey Minyard <corey@minyard.net>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ipmi: aspeed,ast2400-kcs-bmc: Add missing
 "clocks" property
Message-ID: <aJYOI8BzUSeMiuJm@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20250807132852.3291305-1-robh@kernel.org>
 <a14b98078554e27453fc1f96a667b299a15fd4c2.camel@codeconstruct.com.au>
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
In-Reply-To: <a14b98078554e27453fc1f96a667b299a15fd4c2.camel@codeconstruct.com.au>

On Fri, Aug 08, 2025 at 11:17:29AM +0930, Andrew Jeffery wrote:
> On Thu, 2025-08-07 at 08:28 -0500, Rob Herring (Arm) wrote:
> > The ASpeed kcs-bmc nodes have a "clocks" property which isn't
> > documented. It looks like all the LPC child devices have the same clock
> > source and some of the drivers manage their clock. Perhaps it is the
> > parent device that should have the clock, but it's too late for that.
> > 
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Thanks Rob.
> 
> Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Queued for 4.18, I'll add it to the next tree when 4.17-rc1 releases.

Thanks,

-corey

