Return-Path: <linux-aspeed+bounces-4239-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C3FCD98CF
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Jun 2026 15:58:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbnNx4PNJz2xfB;
	Fri, 12 Jun 2026 01:58:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781193489;
	cv=none; b=QH9C5+1BcILlQcVLRYrXK5jejgUx3xTQhrKRBWI4uqBcc0mHPujesE5ZgGL1DtvoLbX/QBYaIcMqby+BjXbjQwuxpqF6EV58keJvuGgGNhecILwbYKvnSKCYWdQQLzNwaPgSnCRTDip+mtXRRY2h8hF6TPAGHc3fGs0E1aqVz/uw17qpr9m3ZVQk7j0zF8aEFAJAZD8RierUPPZKs9+NVD/pQ1qpUn2tXcYOC/5AUWUyTslkK1bluxXrkQWyN6+m6XN7zpu8Tl26W0wXJ+aoOejV+IGqZL/VcrTqXrZmepyoGW86oYqC98QmbzQg/+xE6JbyOmQMW0amxOgdXJ23iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781193489; c=relaxed/relaxed;
	bh=Ay/pqQVPXIWWJwlc0dUtX0HqvnadfJAa4MdZo4NoSxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlgHh2+4YkSIOYJV8CYbues2RUXXl42apuaZg5pTLPm7iyaQf/pnbf7JyYbWwoWPj2poGWXCqTYeAdzt601yu85k89smWh0bKhdiGFGvR+vRW7n5NxZbLrZB/jWgniIQ4mwtzIsgANdE9Kwq0TD0i86VdI7Vm/o/760wQMzkF8R+SLHil4p3ILdCcyd2x4E5jjBHJ5G7pRIEcN2nyVhLYBkBdgihDqE3pY1w4B4X0jLloV3t4B8e7q6gcLRqVx5HUXBtNlbBXnBMoQlBZ27yCBbc/XaqpeaDHEFluHTaSJgUhqRlYYN/W5xkXYlJTMsrVv0Ab9sEgUSbgOEw+BrhpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=JRkhRdRd; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=JRkhRdRd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbnNt710Yz2xJT
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Jun 2026 01:58:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ay/pqQVPXIWWJwlc0dUtX0HqvnadfJAa4MdZo4NoSxQ=; b=JRkhRdRdI0wAxV9i/GI3MUsimw
	F3Cg3voANNES7YJ1k6gON4AJlMtNR4Ds8s0nIiMWucrk1D7jy8YmKMLCgbboRMhr2NcIsxDQZCBz5
	oTSqbzoUYWapEF0r+AozWSd7i5OLQKpQ6ICokxgULZ8LCwi/5eadBTiBVYxg6vuY5GaQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXhmv-007BRy-7p; Thu, 11 Jun 2026 17:57:49 +0200
Date: Thu, 11 Jun 2026 17:57:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
Message-ID: <843dc0ff-a504-4237-b0f4-d92be07e2465@lunn.ch>
References: <20260611-ventura2_initial_dts-v7-0-a61d8902bc5f@gmail.com>
 <20260611-ventura2_initial_dts-v7-2-a61d8902bc5f@gmail.com>
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
In-Reply-To: <20260611-ventura2_initial_dts-v7-2-a61d8902bc5f@gmail.com>

> +	/* Marvell 88E6393X EEPROM */
> +	eeprom@50 {
> +		compatible = "atmel,24c64";
> +		reg = <0x50>;
> +	};

How is this on both a host I2C bus, and the switches I2C bus? Are you
using multi-master? Is there a GPIO to hold the switch in reset while
the host access the EEPROM?

      Andrew

