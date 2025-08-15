Return-Path: <linux-aspeed+bounces-1970-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810C6CA0EE4
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Aug 2025 18:13:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3VbS0y6mz3cjH;
	Sat, 16 Aug 2025 04:13:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755281604;
	cv=none; b=WnDfpi9MMp4ubwxoKlcVWbT7ZOtoEd4kFEdlPoKfYQ7OuKRP6cI31s5ivyY7WtqOnfMPM8cPVJLrEns/SrqVKMtkuG+6ke4ZYvevpbcu6wVCMIuiueibA7sGR8rzHZXnlcWoRGGbQZNJWNTLpPBKmCpFh7JWDzJ+N/e3v5REkv7FwGOANycvXqxG1dYITeFjiZzTd4J94F29ajv0/N1tLiYCk0kGS3/AFJbeb9TAmQ4RJlrCYXcgNagEpiJ2WwmXkaUSF0Gioxj9E2DHsY5ZzCG/Z3z88olU6rtaAn5AikjvhchoYSaRMNkAhGVxKrRDR/3BtuNavJ97Y6GYXmoSig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755281604; c=relaxed/relaxed;
	bh=NaAAZBpMGB7NNLtOQW+QNZLjNhJZLoLyOf0dfTeVUlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Epmr8US1sl8mI2zBZ81xUa+gX0cs2NSXDvkYxxdheiUpxB0UiBCbKKybdgW7xjC20coDIN0IvMJa4QyFzDlMX9Jrp1hzOK284bFHuLJJWPotDMX/+FiIhc65XyT3ZefjHOfBVwIVD5kWsgJ4wH28fLTTj+zigW98vcER9ZdVLo/XGsgRQk5JcWk/lR3bXBFjn/4zmayEfY1U6G34EY5dMbYcp/UrLv3oE15l+oo7z785HD2rXJ6ov7/nltS4rRuIuT7A4rcvwsoVj1Rngqp12Ty+kt0wJLu+5QfIc1f5XbiRWKGAy0GrfuLdc3kUQfICcold0rlflC/bb/GV+KuiOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Tb6bmmhx; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Tb6bmmhx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3VbQ09mDz3cj9
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 04:13:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NaAAZBpMGB7NNLtOQW+QNZLjNhJZLoLyOf0dfTeVUlE=; b=Tb6bmmhxnYVqGw0yP/q44nYma2
	yPL4ILKbEY+6Ft21B0Rg6zzDDTZglBOta6eYBy5fyy7Q75j8J9GAGRWPV3cxpMJbzD32qjSC8QYh2
	8KL70QyrnMO8qUc6Lhu8tCYXJeP1lcdRi2B83nbFMTVeP9NZJ6VYwjHPX6GGO20mKFno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umyv8-004qgu-QW; Fri, 15 Aug 2025 20:12:54 +0200
Date: Fri, 15 Aug 2025 20:12:54 +0200
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
Subject: Re: [net-next v2 1/4] dt-bindings: net: ftgmac100: Restrict phy-mode
 and delay properties for AST2600
Message-ID: <08c46fbc-b65a-4eb4-9cfa-e555cab8398b@lunn.ch>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
 <20250813063301.338851-2-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20250813063301.338851-2-jacky_chou@aspeedtech.com>

> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-mac01
> +    then:
> +      properties:
> +        phy-mode:
> +          enum: [rgmii-id, rgmii-rxid]

Why not rgmii-txid? Also, why not rgmii?

On the MAC, tx/rx-internal-delay-ps is meant to be used to perform
small fine tuning. There is no reason why you cannot use this with a
PCB which implements a delay.

	Andrew

