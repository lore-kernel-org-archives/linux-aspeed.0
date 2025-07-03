Return-Path: <linux-aspeed+bounces-1621-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300E9C77B7C
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Jul 2025 07:59:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bXq0d6BvBz2yhb;
	Thu,  3 Jul 2025 17:59:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751529553;
	cv=none; b=OfIRdQKOAhZGaeIzIyQPwBC2eFSjD/6RyWjtVfbQ/Jpv3MsYzNyXjydportmrXLJlmpcvj0P70PlLSjiyGpubflE3xdHyth7Br6C1qywdYjHjsK2YiA+k0eR/b/s8Jb/XrMRNfqYRztuNn6IF9f+Dl/c/CF6O94+lShd6MFJZnTLLCYjWxeGRceWWVMHeAPM2EhIjydDcq1oMi7dGI2AFMJIzxbxnXkZXWcGuDH9uHh0clTm5n94qiUmJdd+QfruIO5nAyDNfC3eZsv5eta+2u9tzNnKDHRrk68Q4oyrG6ohLkKUOk9O9AHc2qHZlQGYo26cxOEj+QzG6HRYZF+oLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751529553; c=relaxed/relaxed;
	bh=tGLHPn31SBnvlRKtDGgofPJ9xwIi/cPbYqUokOekMHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgDevtRlNoW+oNaTrmEoB0BTO2FJLjA9FdIzCuYbgsOaiHDNT1KP/yB6Alyr+5VhwfJ6ObtgbsEQh7vOMNDVKSLJT7bAshEvVDadVJ9bBhHZgxRidj3Rtsb6iSUPYA2gRQWv7h4kCtRTTazg7D+UU0aGROK2Q/tZdBVJAmWCdsR2rQ4uOAj5YeBLKwYbgVHB7yQD7y+3PrBGEWyHGexhxc10nUS90/Qac/GCR6k+J6tiQj8K9ZbXPJbj3aiSShn0W3N3o1NzhKSqAIAUjzNz5vqOhETIXJpVOndIGRWYdXVcAxaVF2Z/lY8huX7f5hq/zRydiMaRHNYhb+x6LaYTzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=0vNq3pOW; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=0vNq3pOW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bXq0b4qSqz2yf3
	for <linux-aspeed@lists.ozlabs.org>; Thu,  3 Jul 2025 17:59:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tGLHPn31SBnvlRKtDGgofPJ9xwIi/cPbYqUokOekMHk=; b=0vNq3pOW8vaihoEQMlxVNi/Qem
	4KzOjTIY110+8Y30tKn/LO2jaEPbeM7CI0jQ1pfrU2QzaNaWOExTp+OfyYJvMBHoeDNHcH9qwRzyS
	qfx2xx2Qx/XBg4vC7sKrMjQyRpSHQexJ+E+zwNtpaATvXsCSsr8sz+Umhp88dbEGKQDE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXEqG-0004W2-E6; Thu, 03 Jul 2025 09:58:48 +0200
Date: Thu, 3 Jul 2025 09:58:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tao Ren <rentao.bupt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH 5/5] ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
Message-ID: <220ac6c2-8373-4742-86fa-f322d6ada624@lunn.ch>
References: <20250702050421.13729-1-rentao.bupt@gmail.com>
 <20250702050421.13729-6-rentao.bupt@gmail.com>
 <a6f6966b-50ee-4b4f-9422-96c6ac9391a2@lunn.ch>
 <aGW8Nm8ZWMwRYVOo@localhost.localdomain>
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
In-Reply-To: <aGW8Nm8ZWMwRYVOo@localhost.localdomain>

> > How do RGMII delays work? Connections to switches have to be handled
> > different to PHYs, to avoid double delays. But is there extra long
> > clock lines? Or are you expecting the switch to add the delays?
> > 
> >       Andrew
> 
> Hi Andrew,
> 
> The delays are introduced in BMC MAC by setting SCU control registers in
> u-boot. The delays on the switch side are disabled.

Sorry, but not acceptable. This is something i've been NACKing Aspeed
DT patches for. You need the MAC driver to interpret the phy-mode and
program the SCU control register as needed.

Since you have the MAC introducing the delays, you want phy-mode
'rgmii-id'.

If you want to submit some DT now, drop the ethernet node. This is
what others have been doing while waiting for Aspeed to fix their MAC
driver. Having said that, i've not seen any progress from Aspeed, so
it either needs their customers to apply more pressure, or somebody in
the community to just fix it and submit patches.

    Andrew

---
pw-bot: cr

