Return-Path: <linux-aspeed+bounces-2230-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEBBCAC59A
	for <linux-aspeed@archiver.kernel.org>; Mon, 15 Sep 2025 12:32:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cQPYx0KDVz3dS6;
	Mon, 15 Sep 2025 22:32:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757939556;
	cv=none; b=YoApJylODjoCfE+TEJeAQD05LwNCm2OgKBRndpG95AnB6R3s8Ebw4cYs3I6y7bJ7xyIGhYwUm1t3tCSDECjgraaIEY+H7xSQxXsAzMUPQ7q7uKonvsPSftFq/fEDOm7HRqTbaYM9WuwOmN39MpoBaNEbBb7fMkEDKj5geE4fiANuJjz5L3CTK3CdORj0vcz/L8YiNpoEc1TknxkP8XE/j8hbXYqG6VtMcRa8R+78Qp93UKWbZ33SICg8INxbwLJ5EV3ZuIhfipkZBovp4IquNMXCd1xUI+wr1luVxlUxHjwNAj/c5pWv4SPj1oMWTVcjviwl4p3gvRtOjsNaXLJKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757939556; c=relaxed/relaxed;
	bh=L+qwPhZJSfWWFHa/0JQ9FLyPYdavHmaBAX9ONZmEHB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kywrInoXag0Cb6L1A2ygaCXsgD2aeU1BpwZZ4Qrb5J3HgJPnXQk2RMXKwd2HIhwIk8lZP2gyKD26ax6QwMyx4QQCaKqjpiq05Gtjc7uUGASigV6x1SsXBfJj17VFHEsobSYfUzK1tz1R+xhMDno0EC5+y4OEMV3gSAsQ45jOyj6obBrlPWvCAieRTDy3JnVG2M5NzjozGOGf3TDI5nIGFHOZ17USnYNANMzL6w79hiKWgc0+CaxodfcQprVJxITEQu84RfWe3n6WNJytGp/0MhZu2B4yV/sfS6dVyg9hM8vFOsmGwM0NGLhM6wCaegcOD8E+2Z9ms0bMduUeTtt5SA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=BA16kbce; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=BA16kbce;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cQPYt40vYz3dM1;
	Mon, 15 Sep 2025 22:32:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L+qwPhZJSfWWFHa/0JQ9FLyPYdavHmaBAX9ONZmEHB4=; b=BA16kbceQ0CW2l1BGcmB7I60Ya
	QnN81//wbpw8quKuMH6/dnUkOgJEKiQRUZqo2vg5uMwODqj2BFBbDfb6tacvlyba3eyRndm4qgcmz
	m3umrb5pHfC90FqVjq/If662ZML4vhaE6WCfO5tab3MsZReSECjUY8H6hDgUxpR7uSZk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uy8NQ-008RD7-1w; Mon, 15 Sep 2025 14:32:12 +0200
Date: Mon, 15 Sep 2025 14:32:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Donald Shannon <donalds@nvidia.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, etanous@nvidia.com
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: Add NVIDIA VR144NVL board
Message-ID: <6b50e9fb-ce59-406b-bab6-6cfa4eb44e3e@lunn.ch>
References: <20250822203818.4062595-1-donalds@nvidia.com>
 <20250822203818.4062595-3-donalds@nvidia.com>
 <f9cd6015c47d390eef9c689d2cb4fcd301c4d123.camel@codeconstruct.com.au>
 <fcd64668-4232-4d7b-98ec-5326d40d19d7@nvidia.com>
 <f0b75151-d355-4d03-a356-dfbfb7a9e803@nvidia.com>
 <ae46aa8e57d01208deb56a8fd01f26a9a0bf359b.camel@codeconstruct.com.au>
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
In-Reply-To: <ae46aa8e57d01208deb56a8fd01f26a9a0bf359b.camel@codeconstruct.com.au>

> > 
> > Our board phy implements tx and rx delay, so -id would be the appropriate one to use if we
> > decide to use it.

I'm curious. How do you achieve this? Have you hacked the bootloader?

> Right, so long as there's no delay configured for the MAC in the SCU
> (see SCU340-35C) and networking functions for your board then I think
> it's fine to keep the node and specify `phy-mode = "rgmii-id";`.

Yes, this is how it is supposed to work. But please add a comment to
the commit message about how this actually works, e.g. if you have a
hacked bootloader, please make that clear, in case somebody wants to
run the mainline version on this hardware.

	Andrew

