Return-Path: <linux-aspeed+bounces-430-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD30E77188
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 17:53:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV8Qh34bDz3cdh;
	Sat, 11 Jan 2025 04:53:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736531612;
	cv=none; b=W0Jkj5rJ2+D1n2Mi4IZA4hERTWqjHQXHhHs7+zQ8CQv0pOXzPMsMGR1iyj6H8x1Nb2Iht99NnOi8e8Xap1jTTTVZN4ZQST/4L518W/Vmm8X18OS8ycVZQjX7IJlsZUUu5VsgfWgmrbommtlsc78CXp2/BTrKRQWw222BRKUrlPRtatIjtzUtrPucr2YyBcNUhvsd1KJqycfOXX3MJz8LnQYf32kxMg1adZ+Qjrpa252q/CRFH1dLrZGezrrtlnwwm+zOs3/YBk5jTm//Yo1pshvTocgQEuiLC5MTmfe6Tp3u+DeBzJu61L2oJvGUolrNKdJJUjkkLdQByBnaRytDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736531612; c=relaxed/relaxed;
	bh=6JOagae3dW1lR5FIp/nsWts7K+C85jj/Xatk2ej+x4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT0kHmoCUUPqIERiXBKJZG5HWED80xzAKTKdOgSMV2utruflhVfbZCZ9qV4RY8gsVJvHwO4ivcGxhM+TE64YuEk7+b4Vzn9PiUtdegI0BOYArosKmVsbl7jWvcZ4mO3+cqPEE9z/PvBizdbexY7+Jjfhrr+GsAbvK50A/DA6Ks2Xvij5bPG3DDEjHDgxbvrJVbvIm0PriFg9w9xdcXIiN1PCG55W3A6odm0y6cfNjg3XCJGvRBSqN0bmZY1cptRQkMZqRfIF/dzLPUTTAfhSZHb3BDkL7LZN/KMKOlR6LU2BLYyJgK8SHmOV09fWfsDt2/DF7cZhX1XABzMeuoIG/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=minyard.net; dkim=pass (2048-bit key; unprotected) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=setkdvWI; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com; envelope-from=corey@minyard.net; receiver=lists.ozlabs.org) smtp.mailfrom=minyard.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=setkdvWI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=minyard.net (client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com; envelope-from=corey@minyard.net; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV8Qf0mTCz3ccL
	for <linux-aspeed@lists.ozlabs.org>; Sat, 11 Jan 2025 04:53:29 +1100 (AEDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5f2e2608681so1071252eaf.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jan 2025 09:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1736531605; x=1737136405; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JOagae3dW1lR5FIp/nsWts7K+C85jj/Xatk2ej+x4U=;
        b=setkdvWI6Hzbxcqiio5XnREjtCrioS7QgOFbJRT6XQ3CzhzA1I9ljhnkVMlj8o/b+/
         LDB1XQO5CMwpVFF3P5Ck1NyZbNflSr4YihJ+gQE9WvDBCrid2ajpA5lcfdjqeUTnXOKE
         fjLxDwRUx5t7cZ2uuh4jB8JH32OQpb58TCTjW8MzQzS3q5fb8BEVm4A4JoU1HZb/wFrW
         ujEvEC2nKLxHoV6kJEBDn37lzMWniyayp1L/xt/C+i3qvZdlz421b72r/GKnOzxp+8sx
         1qJgtOoFrC+ocJvglmY/LuK8eAsL+Z/3i0pOcFUFwcRs4OAjHq7tWSIqqE18FLok/UMC
         30dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736531605; x=1737136405;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JOagae3dW1lR5FIp/nsWts7K+C85jj/Xatk2ej+x4U=;
        b=OwJRvPz2fjB+aetj8DDk8xgMOeaRmiK9jWKl66Kp1nD0c2ycgFbopkhLXb6s+CUAYM
         UCr9Nd5YUQzFrXIvXu1N8XFj+OkB6FbtTjrbdqjgAm7n4hbOTRpKWgBVPuBkZE93Y4yl
         NLzoLH6of9GfBJtj3C8CAlY90+KwYyLk3vNVa1mMwJYIY/CPwBNJdc5Z3dTEsFSRgMaQ
         Q1NTBdjjgSV0uJgIXMfDQMWa1rLJZttfzU0pKO+/BlfjcSI3VBUOonPqCFLbFaPdEhKF
         wdTHg8f2N7e1mr8VZkQQP+MHs3NSB160lEqWKJIpfOb1a0yZKVsHQtZfcmKGqh5RuicF
         g7/A==
X-Forwarded-Encrypted: i=1; AJvYcCXuo1ZidV8ftAFBLi6u5vJR71CG1tfvJHPXuv1+M3l80JP898/vVFdAr9+V+9VGvzSn1Ng9vhpyNPuEQzA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzUH8pTUUE3qoN23SP596oHs5V+XVxYirf2dOEeP/J59xL1Wqij
	u6f5lZ7OpfxGEcuQNlUOoqfXNspa7gCiGr5UyCHj+khm3ik53k1O0/ZS/CBvK+U=
X-Gm-Gg: ASbGncvcTUjiXunsXvshHrmPLD/rVKE3uP3qDlasYZeH1RXOuI9RkskAjto1fTTsA/4
	trFq40oMUl4mhQaydqGsEZ62xx2Es8+c4VB03IQYb7mzQgvXpqXYy/FsaZqnODzQ/8bCOZBwW0F
	xJjL6t95Eb84bRskGqT4zVEtJUj/tFM/XcpnLCGA/+QjD1c4RdyEy4zc9ZBtQ94tnhFNLhffUrv
	8/4aS1leyhWSOWhqWoJo+n/xJM1+VWrubIGITJUu4aPGbMbZGFmaoBDQ1YG
X-Google-Smtp-Source: AGHT+IGB0PKOvj7h3ojvbM7pAuyzSK65qG5xXrDh822hP3luACM/ibUleffXIwmcp6JhMd8+ciJOnw==
X-Received: by 2002:a05:6870:a691:b0:29d:c999:b90c with SMTP id 586e51a60fabf-2aa065118c4mr2126228fac.1.1736531604651;
        Fri, 10 Jan 2025 09:53:24 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:1850:cb65:a40d:8a99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ad804af3b6sm1080167fac.4.2025.01.10.09.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 09:53:24 -0800 (PST)
Date: Fri, 10 Jan 2025 11:53:18 -0600
From: Corey Minyard <corey@minyard.net>
To: Rob Herring <robh@kernel.org>
Cc: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ratbert@faraday-tech.com,
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] bindings: ipmi: Add binding for IPMB device intf
Message-ID: <Z4Fejhd_qPfuVLiw@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <20250108163640.1374680-3-ninad@linux.ibm.com>
 <20250110160713.GA2952341-robh@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110160713.GA2952341-robh@kernel.org>

On Fri, Jan 10, 2025 at 10:07:13AM -0600, Rob Herring wrote:
> On Wed, Jan 08, 2025 at 10:36:30AM -0600, Ninad Palsule wrote:
> > Add device tree binding document for the IPMB device interface.
> > This device is already in use in both driver and .dts files.
> > 
> > Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> > ---
> >  .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> > new file mode 100644
> > index 000000000000..a8f46f1b883e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/ipmi/ipmb-dev.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: IPMB Device
> > +
> > +description: IPMB Device interface to receive request and send response

First, thank you, this does need to be documented.

> 
> IPMB is not defined anywhere.

Indeed.  At least reference the spec, but better do that and provide a
basic description.

> 
> Which side of the interface does this apply to? How do I know if I have 
> an ipmb-dev?
> 
> This document needs to stand on its own. Bindings exist in a standalone 
> tree without kernel drivers or docs.

At least to someone who knows what IPMB is, it's pretty clear that you
are saying "The i2c device this node is in is on an IPMB bus." However,
to someone who is not, this is all a foreign language.  This definitely
needs better documentation.

Why do you have a "reg" property?  I don't see it referenced in the
driver.  I assume that's the I2C address, but that's going to be the
same as what's in the containing I2C node.  I don't think it's
necessary.

-corey

> 
> > +
> > +maintainers:
> > +  - Ninad Palsule <ninad@linux.ibm.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ipmb-dev
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  i2c-protocol:
> > +    description:
> > +      Use I2C block transfer instead of SMBUS block transfer.
> > +    type: boolean
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ipmb-dev@10 {
> > +            compatible = "ipmb-dev";
> > +            reg = <0x10>;
> > +            i2c-protocol;
> > +        };
> > +    };
> > -- 
> > 2.43.0
> > 

