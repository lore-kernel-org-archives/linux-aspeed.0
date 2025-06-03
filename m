Return-Path: <linux-aspeed+bounces-1298-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6BAC5AD49
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Jun 2025 21:45:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBkm62Rccz2ySg;
	Wed,  4 Jun 2025 07:45:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748987142;
	cv=none; b=Nm0rqEAg+uCDUnXuD1X0+riOLm19gBdLg9zhiPnmk5/R/sci0VQDz6i3lQrUwyhmW+ehCCOi4EaJftfz5OE4FqvGAIuxarGf2mi/X/WECiBt15Nz9bl59TSQq2xsSci2DLZlfjI102FQDTa12mJIIT9p335+o14Y+cNV/5BERjhg4/fQgYBhNioDV9mnzGnebcKGJxsRxejBXvQIbf/smBB7Asl5vWqDbXgQSwo+S5Z06rrNJMgpxY33rQYy6/m6QFvA5n38NADodJqvXv+BC+K6NwG4Qll51D118LLOeUPO9OL81AbXl9wmJfM9wQQ76yxe6CWd/8WAc+UzCFZfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748987142; c=relaxed/relaxed;
	bh=MTrgU+1AMH8ppDvhBBziD30T8+V1scNAGU4VvZ9oUo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkQK1bhNvKePISdHtgLUFmUH0SGCJpQM3YGxwVo4Ulk/twGW5+sewIFfn3QZXBxQui7AU1JumB/qG8m1I57niZo2gTFMP6VHacCewDTNmJqcQXELQlsqRYeWJ/e0pGB+8AA65VHGWkpCX1vxU8UnK4slhSQBTIkbN21zVn/oqiMm/4/U77hjIIH35FQdUqqOoVsl2F63PfE8GtQ9+m6wwT2mNziA45D8VgRsbeqY/D6GsmmPJYSQFqIV9j0kcdBNtriFLf8kLOgeByyN97dLXbvN5n3+1WWjl+I6qA3It5pr8rnlMaEWlLMH7EwKaYaCP5J63+oSlN96CiE1E9SHVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=nliAvRAX; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=nliAvRAX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBkm33rqsz2xXP
	for <linux-aspeed@lists.ozlabs.org>; Wed,  4 Jun 2025 07:45:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MTrgU+1AMH8ppDvhBBziD30T8+V1scNAGU4VvZ9oUo8=; b=nliAvRAXIFg3vXZcbWDKYDOZTF
	+ICpkfgM1AmA6ULQ0px1RarDvIXCHCZufR/PninsH6nwPz5vU2DDUIePV1+eu7HwHNkBjCERsx+Qo
	IXYc9PQlnqs6r8z9zNuvd+4GY2M99Abc5cYz0r4Cvhuta7uNmrBHGY9xvF91daqBy6j8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uMZRf-00Ec3N-Ta; Tue, 03 Jun 2025 23:45:19 +0200
Date: Tue, 3 Jun 2025 23:45:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Donald Shannon <donalds@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: aspeed: Add device tree for Nvidia's GB200
 UT3.0b platform BMC
Message-ID: <dbcdeb49-7118-4517-b965-af580164722b@lunn.ch>
References: <20250603203241.727401-1-donalds@nvidia.com>
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
In-Reply-To: <20250603203241.727401-1-donalds@nvidia.com>

> +&mac0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	phy-mode = "rgmii-rxid";

Does the PCB have an extra long transmit clock line?

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

You probably want 'rgmii-id' here.

> +	max-speed = <1000>;

RGMII has a maximum speed of 1G, so this is pointless.

	Andrew

