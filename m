Return-Path: <linux-aspeed+bounces-5051-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FC1C9830D
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Sep 2026 05:45:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrfnb16fTz2y8d;
	Fri, 25 Sep 2026 15:45:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790315155;
	cv=none; b=huZHs7sYoMLPoPNKSge4+Gb+N5BmAYewtOXisOjp5R3rTepy+jzJp9jsNA4FalVU/4mIwTiF+p6dn5+uxm/N3lW8WAKXOjjR5iChCTqpaFeUZtqNrqDWRJ5Z9ldXkd6vpDvUaD6eURZAGVFnggKwnpvVJTy+Cvv2Ma7L93iuq/bz5+mcOFBeBmQnXW10RQxlz+7BK8oMPPPdfRwuPYDnTmeGAtG6KFW3iQyj2AqJeNOVQOBVXXCwydNcR1CyDSxCGVIf4h9UKqGNwRDMpnoCwBe/JmvnYgCd1P+LDiKZbrd3UqvXdTb/ZOAAV/YxvF5VVbHHHRBld3sjDM7f280ohw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790315155; c=relaxed/relaxed;
	bh=vgch/mbwhJBjvGWR38g64Y3Z0HQP0UunvP8KfpIpt18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdCbB3RFcBcNaLFVqShAW5mHcTyd2ICDty6K2dxMDwmXtEyD336qbb4gg28OTlgZNtCcqsM3ARGY1tbhfs0ulLQzgv1BvyXgsIuZfhKa2bLY4xdsbfXtkFgIZK5D/heJzbrQwHN0RABb8CogSkJMjX1iyyBqCU5r47QKrrfa/v+zNCMZJI90qk5V8wo1tYsqk2VRe1Su79gkZSj+EmCcl8ij/eUqXrlIrpbwLDdb+1MhYMexbicOI2J/DGyIqhIEyviDP2Mx4E23QV7ctlkn2mKvqG+iVnKTOKvTcy+i93j1TVesFIEJKhfNWJb0522rK6TevmJ3kUqu0dQl2XNptw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=RL1H7N+Z; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=RL1H7N+Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrfnZ11Jsz2y2J
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Sep 2026 15:45:54 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 00B1140E02C3;
	Fri, 25 Sep 2026 05:45:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MtBkMgRwCoAC; Fri, 25 Sep 2026 05:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790315140; bh=vgch/mbwhJBjvGWR38g64Y3Z0HQP0UunvP8KfpIpt18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RL1H7N+Zj4lP4SDfpoB6NBKQF88iSUUp4ryL0gqAMzBzp0p/rDknZdNrGYUxlCcVT
	 f2vpq+6jLfZPxxTIV8bJ2KKEc9avRGnKYZOVu+YhTdwgC7qMDH+t6zvCxITZT5/pZd
	 PVCnpupA62ge9yrkmv2QRfU8K75Uqh+eV7ZsfAjoGbDhGJ5bLkPHYfRfyk2oMT9f1j
	 e94M2OVZjPsMu4YsY9nsXWkp9RzgpkQy9ryMWZD3WWNGb6rdfWQRr8lpnWYlMhIMlh
	 9M9kaNW5G69YDDk5Zs60B8aFCfpJtoWinCzUMnMW1FHefgBcE+cgIhz6RtNcEUWcLj
	 9Za1VN8qmmrsVucvQo6IxGp0Q5vsKAxZQu76WOcTUbuN7huIk1QX+h9AIfIG9StdDE
	 9LqNqGW7HzxEbdpuybNAFS6eUn9f9JsecKba0DUMO4qMpECW/9DuqmMEDWY1LbHBzZ
	 IuituXGP2ffb0gqu4D39QlIBdjwzcvHG7aazB3CwHQYDvMW/NUhiZZ7zQbHdxfbPx3
	 Q87p9kFU7XcYDjP5wabNolDeS83Ajl7oZzZRs5T60ThXKYofp37XQaQ5QXmwtA5Mun
	 iKbgIZ40nEEgHEOiCz8am0dCSnOxkF0sxM0x8K5hSYdPqSXOl1fpoAyAXjGi1hw8Wr
	 YVEB+3HOkAZBoLxkmOQR+BjU=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E254F40E015D;
	Fri, 25 Sep 2026 05:45:24 +0000 (UTC)
Date: Thu, 24 Sep 2026 22:45:22 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/9] EDAC/aspeed: Set the DIMM grain
Message-ID: <20260925054522.GDarYKcvFR4mLdAhSe@fat_crate.local>
References: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
 <20260916-edac-v3-2-23e9ed2fbdf9@aspeedtech.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916-edac-v3-2-23e9ed2fbdf9@aspeedtech.com>

On Wed, Sep 16, 2026 at 01:30:39PM +0800, Ryan Chen wrote:
> The driver never sets dimm->grain, leaving it zero. Since commit
> 3724ace582d9 ("EDAC/mc: Fix grain_bits calculation")
> edac_raw_mc_handle_error() runs WARN_ON_ONCE(!e->grain) and forces the
> grain to 1, so the first ECC error reported on any Aspeed BMC SoC emits a
> warning splat, e.g. on the AST2600:
> 
>   WARNING: CPU: 0 PID: 0 at drivers/edac/edac_mc.c:924 edac_raw_mc_handle_error+0x4b4/0x604
>   ...
>   edac_raw_mc_handle_error from edac_mc_handle_error+0x364/0x4a8
>   edac_mc_handle_error from count_rec+0xdc/0x124
>   count_rec from mcr_isr+0x110/0x1e8

All of that is fine and dandy but you should talk about why the grain is
chosen to be 16 here. The warning is just to make you choose a proper grain
for your hw and doesn't need that much 'splainin'.

> Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: stable@vger.kernel.org

Is this really stable material and if so, why?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

