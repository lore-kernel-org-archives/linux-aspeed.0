Return-Path: <linux-aspeed+bounces-2437-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995FCCCD184
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 12:08:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmCg45Htjz3c2k;
	Tue, 14 Oct 2025 23:08:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760443728;
	cv=none; b=gmbSZRUBQwDvf+gchF1v9lWr9XRqDjhRBhubMhwk5yWZwe3Vcr4T3dEqYkh+EqG1GmFBQYGlccCwgWap9C21qGHiy8UB/rb1nK6DVWmXEUOz/Gd5p993Rw9dlmn3X/OZe+8Ey9+tBG6PjLuyndqvIw0DHcBQKXlLW2YQg5arsJHgFMBWHgCkjqUAbrHZBR9/WT8h/40bRp/ziedeDqqifoAyOM/g1scoQ96Sji/sZ7tJl7oBqLqDJeR1sV3zypcdl+B7YV+Zn6hxCnSs5vpRyI3Uy9wScoaOpXsQ2qRzmcoV6QU43yEk9s76zZQ7NSwhOhXYbvWLdScoX0IG5pqeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760443728; c=relaxed/relaxed;
	bh=mW5/QLinbAfVE5ha1MwCMCncckpC/haHYS4j6AucDUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lcw88eoLB5ZuUuRDSPyWjSjr29FBep0EhoFa4po8JWSzEIDbnwLmqalS2y9wlZUyHC3JBdIErra96XyyAlmeE8XiYwF67lEf7JnrsFTAKtmKuuH880sdoOjSr79+Xy0XtLk973fCKMIZkO+GDy0kCLYZ+Ld8sEkwVcHMuyQ0bD4yLYrvemoOdwIbP57OqXqtIOvAyx25CHkifSDPxMXj10rjmq9Igfn3g8LUbhvkGhtrNxmX+ZoIfWAd3Rn6wMDxxBxR8+SknhTimENKX+vF/GgD94UNardIAgiL/0+qf58usZvGL2Oy+4fYaietvu39xUwb+9sBTqNEbWxvWHrnYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=CaQ79jPN; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=CaQ79jPN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmCg22k1xz3bW7
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 23:08:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mW5/QLinbAfVE5ha1MwCMCncckpC/haHYS4j6AucDUM=; b=CaQ79jPNVv0wPdoAWonJgGYDDJ
	gN1JXn/Rp/A1HbhvqmmaPtJDfQsExftP0rQlILsYHlyIGaFfzwj5gZmNvoZ3u+6PA6ZcL8uQm1z1U
	PFBjUFwUsrZYhAfYS3amge6/P9iVXqJ1LHl8qp+glaxGfsSXFr4Dnx0cueO2rGMbB0ZY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8dpC-00AuCb-Ud; Tue, 14 Oct 2025 14:08:18 +0200
Date: Tue, 14 Oct 2025 14:08:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tao Ren <rentao.bupt@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
Message-ID: <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
 <aO2kLyxGlGt12sKD@fedora>
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
In-Reply-To: <aO2kLyxGlGt12sKD@fedora>

On Mon, Oct 13, 2025 at 06:15:27PM -0700, Tao Ren wrote:
> Hi Guenter,
> 
> On Mon, Oct 13, 2025 at 05:20:57PM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > On Sun, Jul 27, 2025 at 10:56:13PM -0700, rentao.bupt@gmail.com wrote:
> > > From: Tao Ren <rentao.bupt@gmail.com>
> > > 
> > > Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
> > > duplicated code.
> > > 
> > > Fuji-data64 and Fuji are identical except the BMC flash layout.
> > > 
> > > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > 
> > With this patch in the mainline kernel, the Ethernet interface I use for
> > testing does not come online when loading fuji-bmc in qemu.
> > 
> > Reverting this patch fixes the problem.
> > 
> > Looking into this patch,
> > 
> > > -
> > > -#include <dt-bindings/leds/common.h>
> > > -#include "ast2600-facebook-netbmc-common.dtsi"
> > > +#include "aspeed-bmc-facebook-fuji-data64.dts"
> > >  
> > ...
> > > -&mac3 {
> > > -	status = "okay";
> > > -	phy-mode = "rgmii";
> > > -	phy-handle = <&ethphy3>;
> > > -	pinctrl-names = "default";
> > > -	pinctrl-0 = <&pinctrl_rgmii4_default>;
> > > -};
> > 
> > I don't see this in aspeed-bmc-facebook-fuji-data64.dts, meaning that
> > interface is now disabled. Adding it back in fixes the problem.
> > Also, MAC3 is explicitly enabled for fuji-bmc in qemu.
> > 
> > Was the interface disabled on purpose ?
> > 
> > Thanks,
> > Guenter
> 
> The mac3 interface was removed in the latest patch (v4) per Andrew Lunn's
> feedback, because the rgmii setting is incorrect.
> 
> I was planning to add mac3 back as soon as rgmii support is properly
> handled in aspeed mac driver, but kindly let me know if you have other
> suggestions.

If it is already in mainline, i don't care too much if it is wrong. We
don't want to cause regressions.

I only object when adding new nodes which are wrong. If we keep adding
broken nodes, there is no incentive to fix the broken driver to do the
correct thing. Not that me NACKing nodes for the last year or more has
actually made anybody care enough to fix the issue. It seems like
developers are happy to have BMCs without Ethernet in mainline, which
i find odd. There does appear to be sufficient information out there
that anybody could fix this, not just aspeed.

	Andrew

