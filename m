Return-Path: <linux-aspeed+bounces-341-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68B4E77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 17:57:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSJfM1ZyZz300V;
	Wed,  8 Jan 2025 04:57:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736272635;
	cv=none; b=mDn1VTIv/xDM/qJv6kc2fZB4J5ntLiUZQ+64nr0y7HPS8fUA/C50m42ORsFELB2ejO38H6pR68Cn1jDhkL1hLDgoUflFpmVXdFUX1mdMaW/Vns5K3Ldu9aIs4Ld5ljSmr81QSxZAG8KkwOajXkPD+wbGTMMPiwIHr0bCS3By3dwzt3SpN2AMmATtug3wonxxpFhPcQgMVH+S3F0qJCii7zYCXtyaNFZ2oq9xhyxCOXg5+QHD1vDSzTjOVuNCgIJX9QN6PjsCwE4hJFkoIIZJsDd6IKrpeI69oZB0Mg66hporcCA2JF8T3WMsmXgkLUqswsa6XI6U0f6ul/kFzxmURA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736272635; c=relaxed/relaxed;
	bh=Oo0AFK2EzQ2OwrwFCMPNzHx8Ha8dYNYdRLxBsPZu2ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlRdGLY1UjZCLXZzvtv7Ijm1+Q9GQka+FUncaDJ2rQlKJWP/UtbmqlNOPCH5/sABpyX2n9kW8n9R2Nbxlpk/ucsHbXkedG8ohkq91vJHlDXnKObyLC2ji8QHHYwvJkKlaqAEJxpDqlB14yk1xWNGagy6FarSC5Djo8fgKe4w62MB4REPGM8lr7jty3aSmXQU+ZAqvD941BMqwbgTZHqsYESrxoM8bYdX8/2FutQgB+Zf0lC0ZOxPOhV7h03peLPLzXgP1aGOCgkmIp8OHcbwEKPP04CA+8G9qsQ/PMaVYVtmNFHgNsjVmuDzjYr2xWU9TgmWzUNucmcX1bXD+QLgmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=lDjijOYi; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=lDjijOYi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSJfF6gvjz2yFB
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 04:57:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Oo0AFK2EzQ2OwrwFCMPNzHx8Ha8dYNYdRLxBsPZu2ig=; b=lDjijOYiFo0Tz9rfv4QLoNScC0
	/JkEh2Mo1bfS+s9xB2kXiZjOCVfOmsb0kb/MldD/OOId8ryI3y3i5k3KSO/Ezz37/brQyD/+xfcS+
	dFHdn8AE+fz+mSohPFa0UZauCEaSUv+VEDUHILm4oD5Db38RdWxuP3sipBHCokrY7Bo4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVDoW-002JeJ-Oh; Tue, 07 Jan 2025 18:56:24 +0100
Date: Tue, 7 Jan 2025 18:56:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ratbert@faraday-tech.com, openipmi-developer@lists.sourceforge.net,
	netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <6d9ea6f5-4ff5-40ed-b470-e40c1f6a5982@lunn.ch>
References: <20250107162350.1281165-1-ninad@linux.ibm.com>
 <20250107162350.1281165-6-ninad@linux.ibm.com>
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
In-Reply-To: <20250107162350.1281165-6-ninad@linux.ibm.com>

On Tue, Jan 07, 2025 at 10:23:42AM -0600, Ninad Palsule wrote:
> system1 has 2 transceiver connected through the RGMII interfaces. Added
> device tree entry to enable RGMII support.
> 
> ASPEED AST2600 documentation recommends using 'rgmii-rxid' as a
> 'phy-mode' for mac0 and mac1 to enable the RX interface delay from the
> PHY chip.

Why?

Does the mac0 TX clock have an extra long clock line on the PCB?

Does the mac1 TX and RX clocks have extra long clock lines on the PCB?

Anything but rgmii-id is in most cases wrong, so you need a really
good explanation why you need to use something else. Something that
shows you understand what is going on, and why what you have is
correct.

     Andrew

