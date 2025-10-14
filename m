Return-Path: <linux-aspeed+bounces-2452-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482F9CCD18E
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 22:39:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmTg15hN6z2yGM;
	Wed, 15 Oct 2025 09:39:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760481581;
	cv=none; b=hVuCKawJIiQAkVQJcAfz6/406V9jFpw6aIxbzgrtycQG3C1sxIwH58qJoj1qEsmwC2Wv21UcoeB3BUWAy50JlKuWjdkScbIFo+R5YNKQl7x94k+MshKfdGWnVrijsn1J8bAC0jf0jRaB47mEbHFv7Bvoj8uq8QdPxgDdHduuCAVc74GLdir0ugLxkCvL6PlWOnpl768ntpYIyFyzcJTLU6SOGMnnwP3UY45rFOJm49T14qsYn+jBmYNkw4tDjVXwDriTtI5MlohUo77i7+ZLfmOB8jKI16LZSGvcl+M2qcUQM9gi7Xm5n0HD9ZxYC6Tc77dfXHPR4hIoE0vDvgvCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760481581; c=relaxed/relaxed;
	bh=3ZtqCDOZscLqB8RaEJpnchm/C2TI80sLGGpkj07xncY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3ytTBIIUUFdzPqw1lkDgfclqxdOEU9KxkHv+/lP3Gpyz8+n7A4dJkaGYgDTZWC7qv0UgG1/Fuok6qtaocZ4NZ7r5tC27ADtwMQfh/wKeBy+ZjMV3STrStOGoxZyY+jJtj2qgmFKuv/32khBqwizUuf8TLHdQlcxeG25bEedXWtemiDYfDIoenjCVz661hwQaGA+Matd8NnvGHbF8oqg2qaRBxqE2yP7pWFep/dZc8TXW3vTOZw/81961lvoMHPE6JUG4bs1rH+B+Vdwhw7fAztItegOFPAGbivs5w9sRGWJVTyAa20IAV0MwLCX9z1Zc8ua8+e5oz4O4V4icH7eyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V/GLHC+I; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V/GLHC+I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmTg03rB6z2xdg
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 09:39:39 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso5674138b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760481578; x=1761086378; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZtqCDOZscLqB8RaEJpnchm/C2TI80sLGGpkj07xncY=;
        b=V/GLHC+IiQiELZlC7tPUFg7ET6A9YN3jWRW7y1TmVtx7hlKsPoYN7mp/sOR6kOvQ9K
         pmMQxR+2fgtSzw5vaALFZUE8JcZHJ4nMc/7uqkjTyQ9cGzwZVuaFWQGxtO8mzlOFGi0C
         Qp0Cuaspyd2qfDvCC2fnSYgLWgRsoKemRZdGjyyGAhlLun77FQTu9b6+EYn8KAb7OEO/
         ukslSDQ0BczdSIBPZR3TSSL/1RVdQeTVwIPKwNR1XeMqdBXBaXKvVBO+yB+WfM5R9puS
         mhvZ8Po2+zEI+oC+ZvsaUKlhLOffZ6CJgWJfKUDa9j02Pmwol3j5UKvUmfba2gNsWYSL
         KNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760481578; x=1761086378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZtqCDOZscLqB8RaEJpnchm/C2TI80sLGGpkj07xncY=;
        b=pd7zNZ8dqF+pwHmn440fA48kOo/Co6dlXXF9FOJ3NoqeQUoyJJNES48nf/JpVwz+Bi
         7JMVRgM5r/6aUbDBO2PLUytOsvbOkkHF9/A3H1RDcZLsTcfNGEKBGCoIugv1BsnGT9QP
         6EaJwTwB2S+GpLhvBEjVYBn58kk2gEopTpIOPjXopfoeE5na18vhsDptDKCBFNu/wo0O
         Dah8Q5Slf0DngG870QXVSdGJIw6X6LC/HDn7Oxyg8wxBy2IGr5TZvtarWJrsTB1Nc0+7
         SRFFSTjYW15ye/a1TkTEn1jZL0rdKPff2JHSK3TDO+twXhIilQtZ/AVdMyZMhQJMgW5u
         /Cxw==
X-Forwarded-Encrypted: i=1; AJvYcCWjRYqBJ62Xl3jmRddrrEc/yX/QU63s9YBeUuDwDHU4sy2avTT18cgPNS2Br0mHqEg/tGvPxZ5MvFwh9eA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwbdZDMlYa5Y19gaYm+GkNO9F+ks++QarezMQ6hKX0P3cKqpCv/
	veE946L2caWSu8UD8ZR7k0umDgr/TJGDALp+0w4y4RZKJ8VcvO2zfGJi
X-Gm-Gg: ASbGnctOVhhHely5WCyGXya3o4UVO6k4RiQgwiSxcrVHsi55ZfKSkitROKaKUl0YmN2
	AlJOGexUA2OobNZtmK7cVRMzCNoo1ih+AbE9hWMiOSDtHL1nB2fW2a4tbhMivGc3FmUKirhRs+6
	pyuoMMXzqkEhFudiK+nqJ5MXFBxl2IPk6EnrOWFAqlA8IpWJJYPXCbukB4hSooIu49Q9I2fIisv
	IHFMrRApm9C74ZO6MZwT1iiezzYavPKwGjJ7G8AACyk/QOf0JBOfg7PSLuh7/U8D2nSc0y8GnoH
	mSy3oRJSUae9pDTJfIPumFJfUXzzZmNqpiHAI+SeZ1nYE/TONzVqzSY91OqJNLeV4lvEYvemGEE
	D3wIuDM/FUuvORJ4EJP6ejd/JKFtZlfasFfOb+Kb50w==
X-Google-Smtp-Source: AGHT+IEi+B24saT9H9rxfelGvAFHN/l9cEixm6BxrzttyGvKpYxkywr6o9MKjbLEkqIAa3+5HpvU8A==
X-Received: by 2002:a05:6a20:3955:b0:2bb:b5b0:b3a with SMTP id adf61e73a8af0-32da7e7bd47mr32647446637.0.1760481577555;
        Tue, 14 Oct 2025 15:39:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:600::1:891f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060b59sm16672205b3a.2.2025.10.14.15.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:39:36 -0700 (PDT)
Date: Tue, 14 Oct 2025 15:39:34 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
Message-ID: <aO7RJs8ceO3mwjn4@localhost.localdomain>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
 <aO2kLyxGlGt12sKD@fedora>
 <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
 <4e099ead-e6df-4489-a775-1730bc852dcf@roeck-us.net>
 <f801a4cb-3d27-439c-82f2-d5ee5aa0d810@lunn.ch>
 <7197bfc7-fef6-40b2-b3f3-182e9428dc12@roeck-us.net>
 <33b9d6d4-bb2f-47e6-8d3d-94a2ca2b8474@lunn.ch>
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
In-Reply-To: <33b9d6d4-bb2f-47e6-8d3d-94a2ca2b8474@lunn.ch>

Hi Andrew,

On Tue, Oct 14, 2025 at 09:14:21PM +0200, Andrew Lunn wrote:
> On Tue, Oct 14, 2025 at 09:39:02AM -0700, Guenter Roeck wrote:
> > On 10/14/25 08:11, Andrew Lunn wrote:
> > > > > If it is already in mainline, i don't care too much if it is wrong. We
> > > > > don't want to cause regressions.
> > > > > 
> > > > > I only object when adding new nodes which are wrong. If we keep adding
> > > > > broken nodes, there is no incentive to fix the broken driver to do the
> > > > 
> > > > This wasn't adding an allegedly (sorry, it worked for me) broken node,
> > > > it was removing one that worked for me all along. Obviously I do not know
> > > > if it worked (or if it is even used) on real hardware, but it worked for
> > > > the fuji-bmc qemu emulation.
> > > 
> > > It probably does work on real hardware, because it is one of those
> > > "two wrongs makes a right" cases. So i see this as a regression. The
> > > node should not be removed. It should hopefully get corrected sometime
> > > in the future when somebody actually fixes the aspeed driver, and
> > > fixes both wrongs.
> > 
> > So you are trying to force the issue by disabling the Ethernet interface
> > on fuji-bmc until the problem in the driver (whatever it is) has been fixed ?
> > That just seems odd.
> 
> No, i see this as a regression, it probably used to work, so it should
> still work.
> 
> I'm just pushing back on adding new nodes which are broken. If it is a
> new node, it should not cause a regression.
> 
> 	Andrew

The fuji-data64.dts was copied from fuji.dts mainly for larger
persistent data partition (64MB), and the latest fuji.dts includes
fuji-data64.dts (instead of vice versa) because we wish to deprecate
fuji.dts in the long term.

So it is a regression for fuji, but fuji-data64.dts is a new node..

My original plan is to add mac3 back to fuji-data64.dts (which will fix
fuji.dts) when the rgmii fix is ready in aspeed mac driver, but I can
add it back now if we need to fix the fuji regression asap. Please
suggest.

BTW, the current mac3 settings work in real fuji hardware because rgmii
delay is configured in u-boot.


Thanks,

Tao

