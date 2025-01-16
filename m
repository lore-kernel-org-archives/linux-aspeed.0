Return-Path: <linux-aspeed+bounces-497-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4597FC02180
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 10:38:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYfTt6Dwwz3cTp;
	Thu, 16 Jan 2025 21:38:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737023906;
	cv=none; b=O3POIBdhQC4zL6PgAgDuw17OQSnGRZM67qrS0mIp5+XNUHq2evqzen7fZDiG4uL4NHUrrnJWMDIbmsf53XcALfSUtpi1J0/1/OUwDz58SBkLda9hvRmPx+9nBAqYineaW8OlEW8rNv81zQs+KnxIxmYnGQnalT2eKFN9ccsICkH04PDoubg70DGjiynFkgKh9p1wiJDiZcpTDPyhezfVUqs+PHNyJG/XqiSU7Rmj8WpH4lRHRde4708KWc7q/ytp02QRZUy9LOGYvlvTyY0CSSFpJ1PLs5YbTIA46kc1xUHJZOj6CltzaS/A0crOyTlTVASh8JbyLbOsQ9kniP4GDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737023906; c=relaxed/relaxed;
	bh=hFH2QkUAPYArHwVFoe8AUQOmWzIhaJml0s+bthS7xaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpyKvv02uGsJsk+ZCeHmFrhxH6Ne4o89tlTee1mS+B7yzZx2tGvNvDbi1tUSA71QIfj52X7WtK9/am5th4E6t3LpmJETAuFNLjnafBw+DGRJqoMssXwmJLUv9REoqfsDe+5eK0DGmdcda7qvEzYirD77qJ9IvJpqfvtGpjASlMZxntLBm5fMMxj1GJ6/38Pamgz7lzTOW0GGed1eaF8I6JhQoO14Dtv6wq+YpnIhJNPbrKZsqoO9lgRPLYh/7I7JQux+zHov+a1TK8hXIyfCc8Y9zCIjQIVy0PohLsP76oUJNvzsZhEctdcTeq5j8poK5VZ4T9CIsCQmTKGt6nUPyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vCw1Hb3J; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vCw1Hb3J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYfTt1cPKz301n
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jan 2025 21:38:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D95AF5C5D20;
	Thu, 16 Jan 2025 10:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1225C4CED6;
	Thu, 16 Jan 2025 10:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737023903;
	bh=FxvjYb2DWjhqzHI2LNTmYl5TuYZ4ikMl0bpGCml6Q1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCw1Hb3JaeryBSelmXm/W7aZWkrxne1V6qJTMbT5wzUB0FLJb1HDVSxQs7L3Adk/J
	 h1jIgU3u8NtUtpMZzt59EKG6jWvD0UFM2aGmmMBywcxN0mvUC+SXnoaH6zwC9Y8ixV
	 0N4sgYOyBEb+mBtiV6qFripiT9i0WVcjWmKyFdexG6GtbzLRzdX7pr3N2gw3m2GYKm
	 KUjby//nop8j6RYVyZYzhQPJKQF5s/6tiY5a33mt3i5ohcQ1sJcIIXpLXXXJ7TjgDw
	 0tf+1KC5DkK6Yirs9t9kyDLWGwGJtBzwIga4CdNopnGWlom31Q/lmyG4CVS+r875GW
	 56144sKuxFylA==
Date: Thu, 16 Jan 2025 11:38:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: Rob Herring <robh@kernel.org>, minyard@acm.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, openipmi-developer@lists.sourceforge.net, 
	netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	devicetree@vger.kernel.org, eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing
Message-ID: <oezohwamtm47adreexlgan6t76cdhpjitog52yjek3bkr44yks@oojstup2uqkb>
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-4-ninad@linux.ibm.com>
 <mbtwdqpalfr2xkhnjc5c5jcjk4w5brrxmgfeydjj5j2jfze4mj@smyyogplpxss>
 <20250115142457.GA3859772-robh@kernel.org>
 <a164ab0e-1cdf-427e-bfb7-f5614be5b0fa@linux.ibm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a164ab0e-1cdf-427e-bfb7-f5614be5b0fa@linux.ibm.com>

On Wed, Jan 15, 2025 at 03:53:38PM -0600, Ninad Palsule wrote:
> > > > +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
> > > Choose one - suffix or prefix. More popular is suffix.
> > I was about to say that, but this matches what gpio-hog.yaml defines.
> > Why we did both, I don't remember. We could probably eliminate
> > 'hog-[0-9]+' as that doesn't appear to be used much.
> > 
> > Long term, I want to make all gpio controllers reference a gpio
> > controller schema and put the hog stuff there. Then we have the node
> > names defined in 1 place.
> 
> Which one of the following are you suggesting?
> 
> "^(.+-hog(-[0-9]+)?)$"

This. The second part of pattern.

I'll send a patch for dtschema to drop the prefix version.

Best regards,
Krzysztof


