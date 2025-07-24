Return-Path: <linux-aspeed+bounces-1826-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D57C83F26
	for <linux-aspeed@archiver.kernel.org>; Thu, 24 Jul 2025 12:53:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnrY23Vfwz30T8;
	Thu, 24 Jul 2025 22:53:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753361638;
	cv=none; b=BoKAPdS+ENyq3M0jAyOIGRnby0aJpzseDRYsVx0/lc9/CZ/Vt2xleMF1gl2fz0/OLyl0uW8kHj7j3vp5AEKPSAROii7LDSdY9eENMDn5EJSXnIFbuzqBiPfQwCSg7MsHQKgkdedS+91RA9+GhV9AfFLakENBs6koanjeJdAXV2tOjRKv0E5aenhkAjV9vCJRJn53GitAW/PqUhtLTrDxTYEnVeRjCDW0U1mY03CwZlKredUTUGqlYgWmjmglVENOBvGkQ9d/nb6YwmFT/4vz3OhPmzFsRHbY3I5SyrGSTZpKv7Ca0ZxpWyYt16bgb48P5Uv5gi+SVnYIGih0OXtEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753361638; c=relaxed/relaxed;
	bh=n3/g4/jBSS+544GxD3Uqs3+ihWOI9sn+j4nRaeUAg7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIhs+k5Xp0t8CKAWGQZ8Lz3VPMkQi5rF4X73dqmxVEnR4/w0pNLcsw5xlLVm8Hk9XsTbwRCVnu5u7DWy25Wsa+PJ7Pcx8g+9CrvXJf79iWui+I9JpQeVew4Rz5oElEgeRaIQxPP7I7QijzE6dzop9ttzKmPhjJvoH9S2PH8VjuJzgpLk05//0NbjTSIjgjkeuPtZOeTLldGDEs4qJ2mFPsGiofBGdk/FtoHk5913oTKP9Ab0azhg2WiRa7m1zoKBBkZL/qdAjWp3dQTkVl5f0RxN4pHFZyE0wWrYbWTrUm/yyr4o76WpBg3RErp5fwbZOfW72uL+Hwn5KkhoIlB+MQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ZBpdSnxs; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ZBpdSnxs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnrY13dgvz2xS9
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 22:53:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n3/g4/jBSS+544GxD3Uqs3+ihWOI9sn+j4nRaeUAg7Y=; b=ZBpdSnxsorutDmupx/4WVEj1SW
	1bm4a1Sl3LhmC7jKATKv6Bj5YVbhDxxMPBxAXZG6W+WhjzDrpfbfTQgHmOFy8klPSGkde/Myqk3Pb
	SHKyusWfHkjVxeysakRsTlCMlY406YskhV+RB00hIFeaHeEgYDfq9m/MRcdqhX6PzFYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uevS7-002lEV-5u; Thu, 24 Jul 2025 14:53:39 +0200
Date: Thu, 24 Jul 2025 14:53:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tao Ren <rentao.bupt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 10/13] ARM: dts: aspeed: Add Facebook Fuji-data64
 (AST2600) Board
Message-ID: <769d6817-ee97-4a23-b013-29bc875a00cb@lunn.ch>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-11-rentao.bupt@gmail.com>
 <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>
 <aIGGdbIX9HaV4dB/@localhost.localdomain>
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
In-Reply-To: <aIGGdbIX9HaV4dB/@localhost.localdomain>

On Wed, Jul 23, 2025 at 06:03:49PM -0700, Tao Ren wrote:
> On Thu, Jul 24, 2025 at 02:03:20AM +0200, Andrew Lunn wrote:
> > > +&mac3 {
> > > +	status = "okay";
> > > +	phy-mode = "rgmii";
> > 
> > Does the PCB have extra long clock lines to implement the 2ns delay?
> > 
> > 	Andrew
> 
> Hi Andrew,
> 
> Thank you for catching it. I didn't notice the settings because the file
> is copied from the exiting fuji.dts with minor changes.
> 
> The delay is currently introduced on MAC side (by manually setting SCU
> registers), but I guess I can update phy-mode to "rgmii-id" so the delay
> can be handled by the PHY?

That would be good, if it works. The problem with the current code is
that those SCU registers are not set as part of the MAC driver, so it
is hard to know what value they have.

	Andrew

