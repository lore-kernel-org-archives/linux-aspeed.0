Return-Path: <linux-aspeed+bounces-1973-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B64CA0EE4
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Aug 2025 18:42:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3WFV1TjCz3cjS;
	Sat, 16 Aug 2025 04:42:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755283374;
	cv=none; b=elQe7+0vrTIjXL1uYuNSktEFATT+6GWzfWAsF+yYT0IRE/fGsWulNRTIgi8GuaRa2sjVUH3cVbvr492gXk7f4txF8wbJUN13Z1jRhAWQ4G4fq0xk2OJQUmRduAkwpLp8BvHA85eiJR919NrOwzRqOQtfU3oGh3TU1VXC95UuGaBLHPSVrSqBWz9i0N8zGdtv+7MaJYYvaAPReaqTqjKpq0YHcpbJPZAHkTjTE1TxVVJ3VfHS23qol1Ge++/FHGaTPeRYFsJk24qRXHt9wD2cQwD4slQdFYHgMvYmTe8XxkQ4uZIwTh+HNauXg2aBDjTvNg6ngPJbVxumQfFQayfLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755283374; c=relaxed/relaxed;
	bh=NFEat3zirg8C2/2oLxu6X/ZdyOC05vJhFKTQnZhl0cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkeaTR2EePkOXP23cMjRrn9XSGBYlILm3Y7JhdvuGJmYWbt0ESUyri4la1Wl8LD2pWQNW3tGV5tGZnMRGTLqAVgZZitekkJ7qcYYfvTPik+WpaD4YI/9P/PSh9Plv96A7oN9FOChof2nrXBC90mdLbEc5sIbpRkhV2TtaDG60j7vq28/avjJN8fsAX1UJgRQ24ZyhN58wChnldTdTLgarU8VVpn3VktyXr/jVyv7uZECouYJYCGo4MqRem323447RViHv7oF5CLN2SOexcFM1+J2yP6B9hy8PK0QTvYW9eZJx8djbv49SzI0Xg33TiT91+ZjKz16ZFemKj9nkNkqvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=GTeAPr8g; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=GTeAPr8g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3WFT1bY4z3cjQ
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 04:42:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NFEat3zirg8C2/2oLxu6X/ZdyOC05vJhFKTQnZhl0cg=; b=GTeAPr8gn7YNZKVQbSxG+bF1QA
	CtBH83Hd9XObTUvCNk45wDj5dQNcibQ7ra2s4ipaVsEQqMj7iguXuby5CTgruIH7T60llxk4xKsQ5
	+Nh+55C3QG53q0Kaj2eiMYJmqtcEyE5S+tvSg6m7oWR4pTBfDE7tNVHxQKRDffL+EBxI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umzNj-004qvW-Bo; Fri, 15 Aug 2025 20:42:27 +0200
Date: Fri, 15 Aug 2025 20:42:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Po-Yu Chuang <ratbert@faraday-tech.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	taoren@meta.com, bmc-sw2@aspeedtech.com
Subject: Re: [net-next v2 0/4] Add AST2600 RGMII delay into ftgmac100
Message-ID: <a9ef3c51-fe35-4949-a041-81af59314522@lunn.ch>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20250813063301.338851-1-jacky_chou@aspeedtech.com>

On Wed, Aug 13, 2025 at 02:32:57PM +0800, Jacky Chou wrote:
> This patch series adds support for configuring RGMII internal delays for the 
> Aspeed AST2600 FTGMAC100 Ethernet MACs.

So i think you are doing things in the wrong order. You first need to
sort out the mess of most, if not all, AST2600 have the wrong
phy-mode, because the RGMII delay configuration is hidden, and set
wrongly.

Please fix that first.

Then consider how you can add fine tuning of the delays. Maybe that
needs to wait for AST2700.

	Andrew

