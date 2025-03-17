Return-Path: <linux-aspeed+bounces-1009-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F3FC282EC
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 12:45:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGZST4rjJz2ypV;
	Mon, 17 Mar 2025 23:45:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742215513;
	cv=none; b=GdlnjLqFaaCWDB/W+zdNOmsijwg+qgYzhd7Nlhjg7e/rzldF3JAp3rWPlIbzHrJpbcFTZNBODVx8uoyON4PmWBzud4zBIdkR1YcwDDvxS/mWxziNPrhcm0YuthJ7+nnE/aJuBevQ5SpOgdRjyFgqqQF0g0SgneWCiJqZMm8/sXh+/5vSLx/K6Q+m7gBowmuRilq+io6lOIgt68OrwjOlSe0oLooRtNHhMq2/XXid/u/J0NuMqgx4mO1Ix9LWqmhSlGSWzueljWNGvZJ6yE8GiGjEEzgVuXKb1Zgg2ZcrlD2djUJA3aQbw66ZwaDXq7m3AVTuRZagRSGWSLdQHmpLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742215513; c=relaxed/relaxed;
	bh=zjV/I2fEfxjcoP8gAnydAdTVwP1+scv9m0uCGjJEH5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi1pDmd/N4yN6JNMhF4R+qq1rktfeiNamRACE92MrEwFMTJGkhjmOppTwPXMntE1yqsq0OFp7PvFD4AMwy1asieefde6p8oa60JxSymzU9ya4zFGFLVpn4CXfWXZjjyQo4LPdUENaI1hH3Q6j+/N0H2BgW/dhe3pZIqu7SqqvVBWWjPLlWBb2xYM1MalN82yzJVj1ks1bMLAQdwvLhvUUeGE7nP1s9qVBugthdwVaVUPvfge3kKVIRZGz4Jio6XGfK2BggB1sZziNg88RhE0mq3ua4bXaTUv5uTkTT/cLCa2hqk6jsQDDMD8UN/+ZHAarRKbpceM/qb19sg27ZGfxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=uwTmUe6w; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=uwTmUe6w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGZSR4F4nz2yhW
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Mar 2025 23:45:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zjV/I2fEfxjcoP8gAnydAdTVwP1+scv9m0uCGjJEH5Y=; b=uwTmUe6wsrJ41nfKAKTp0Yu0hf
	CfH6FmTXxj4xWQt3NWyGIJxsrJHrc6CvrNQngk8V2Tu7/bmgNxWES97qeznElbW5UQ3RepjVLvL9x
	rN8PEO2jFnMmc8/43/rpWwfg0j7BNOoZQgNYIqGM7OHdQBOgbtgly58cwIThnaMwI318=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tu9pd-00680C-0H; Mon, 17 Mar 2025 13:44:37 +0100
Date: Mon, 17 Mar 2025 13:44:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, ratbert@faraday-tech.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, BMC-SW@aspeedtech.com
Subject: Re: [net-next 3/4] dt-bindings: net: ftgmac100: add rgmii delay
 properties
Message-ID: <27927166-d73b-4837-90a9-ed15661b0a6e@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-4-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20250317025922.1526937-4-jacky_chou@aspeedtech.com>

> In Aspeed desgin, the RGMII delay is a number of ps as unit to
> set delay, do not use one ps as unit. The values are different
> from each MAC. So, here describes the property values
> as index to configure corresponding scu register.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml          | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index 55d6a8379025..c5904aa84e05 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -66,6 +66,20 @@ properties:
>      type: boolean
>      deprecated: true
>  
> +  rx-internal-delay-ps:
> +    description:
> +       Setting this property to a non-zero number sets the RX internal delay
> +       for the MAC. Use this property value as a index not a ps unit to
> +       configure the corresponding delay register field. And the index range is
> +       0 to 63.

You have to use picoseconds here. As with all DT binding, you use SI
units, and the driver then converts them to whatever value you need to
poke into the register.
	
    Andrew

---
pw-bot: cr

