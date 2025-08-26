Return-Path: <linux-aspeed+bounces-2051-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD98C8303F
	for <linux-aspeed@archiver.kernel.org>; Tue, 26 Aug 2025 03:18:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9tCk1pRFz3d4F;
	Tue, 26 Aug 2025 13:18:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756178306;
	cv=none; b=C6FCfJnW8X8kcfNtcHTP+VsEvnD18k/KeMAHMYWaQ0DJ73vR6Qr/CQUZhgd9OVuAgpsrVOgXQs3e0nfLT2Z5Uq0BiX5DKb9lTDi6BCGf5QTcHk4fdBRGyM87iguJoCS3ZelmTWNtlcWXVgEubNsDbUMsO6fC3P1HrFu5MCp1YdPaMAYluEwur0GLjjv7iVK7DB6nGqYRX+6Ps2Y5uHcKZZ2YwS1dBTWNlHQmSChGRdZl2lvdxDG8Yj8rp0OKgGSHxmB2drBvHSHmVMxInbHMiGTsloNpiWljLSEKyeAfLzn1nLhWGdHftr6IGjmkS6bllxPYGUDzrYIhM1yF7WYetA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756178306; c=relaxed/relaxed;
	bh=Fs6pzcFRfuk1HEj3n7YIn4AqvWgvz9+8/2xjZTxmZoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUv2Sr+Yg8I8P3jHrEcaM5+Yx9BsFiMtw4MirJHwTnhIJ7kKGEiVorbKZZBti1nDZxcn3NhZ10q0F3WKm39N6Tb2sqN5Y9EW442eE8SVnRHsJw4d9evwXWb01EK5nzq4pWXNAS2sqKIBOQ4y9144Ov2suW8/rrswKagmYDuBWbkJZ6GNAswlT6f+Pp/OJ0Hicm2KXHRVI8XMrG77lQUrum3hdQH2jJnLwJzj70UIpIBAh1oaEerkGrCkqM6if5pmExABzmo+fC1a32sNvkY2Zia4ATucqBNbcK/5tVo+Nd7ROCUMkyT8rlE2s9mH8Fr/DPW4thgqSol7NdEhoMU8fQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WEgzZL61; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WEgzZL61;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9tCh2PQSz3d44
	for <linux-aspeed@lists.ozlabs.org>; Tue, 26 Aug 2025 13:18:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Fs6pzcFRfuk1HEj3n7YIn4AqvWgvz9+8/2xjZTxmZoY=; b=WEgzZL61kJnw32A5oSkohRl/ER
	OgcFmeG2v/j2w/acUPDqQIctI4nkAWMcJoaGoJTN+DRFJNCd1VLKq9Ks/CLfkD4PsZUuYsGQPNNfJ
	W1JLMEPpQ1EkC2fJRJnXSKTOjdJEA7RBEVkpZ4fhsGFbBUTgWUlYnExfEz/fOtY6EbjY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqkC1-0061wJ-02; Tue, 26 Aug 2025 05:17:53 +0200
Date: Tue, 26 Aug 2025 05:17:52 +0200
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
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: [net-next v2 0/4] Add AST2600 RGMII delay into ftgmac100
Message-ID: <0c3ab6ae-a013-4d22-a05d-2760c8bca7ff@lunn.ch>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
 <a9ef3c51-fe35-4949-a041-81af59314522@lunn.ch>
 <SEYPR06MB513431EE31303E834E05704B9D33A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3966765c-876e-4433-9c82-8d89c6910490@lunn.ch>
 <SEYPR06MB51342BAA627D12DA4DC32D6E9D39A@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB51342BAA627D12DA4DC32D6E9D39A@SEYPR06MB5134.apcprd06.prod.outlook.com>

> I would like to discuss with you how we fix the RGMII of AST2600 in this thread.
> And thank you for your patience in reviewing our code.
> 
> Currently, the RGMII delay in AST2600 is configured in U-boot stage, not in Linux.
> The ftgmac driver will not use the phy-mode to configure the RGMII delay on MAC side.
> 
> I list the parts that I think need to be modified.
> 1. Change the phy-mode to "rgmii-id" in aspeed-ast2600-evb.dts.
> 2. Add the tx/rx-internal-delay-ps in dts.
> 3. Add RGMII delay configuration in ftgmac driver. If the tx/rx-internal-delay-ps has not existed,
>   according to the phy-mode to configure default value.
> 
> These are the fix items I can think of.
> Could you point out what I miss or a clear direction to correct the RGMII mode on AST2600?

We have to be careful with the assumption u-boot is configuring
delays. I've seen DT blobs which use 'rgmii-id', which suggests
something is disabling the MAC delays, maybe because they are using a
different version of u-boot, or barebox etc.

You should be able to read what the MAC is doing with delays. You can
compare this with what the phy-mode is.

* If the MAC is adding delays, and the phy-mode is rgmii-id, disable
  the MAC delays, pass rgmii-id to the PHY.

* If the MAC is adding delays, and the phy-mode is rgmii, issue a
  warning the DT blob is out of date, disable the MAC delays, and pass
  rgmii-id to the PHY.

* If the MAC is not adding delays, and the phy-mode is rgmii-id, pass
  rmgii-id to the PHY.

* If the MAC is not adding delays, and the phy-mode is rgmii, that
  suggests the PCB has extra long clock lines, and the board is using
  a U-boot which has been modified to not enable MAC delays. Pass
  rgmii to the PHY.

I would also suggest you review all DT blobs in mainline and see if
any are using rgmii-rxid or rgmii-txid. If not, i would go with KISS
and return -EINVAL for these, with a comment. Support for these can be
added when somebody actually needs them.

Most boards today will be the second bullet point. With time, they can
transition to the first. New boards should hopefully be directly the
first bullet point.

Backwards compatibility is however an issue. Anybody with a new DT
blob won't have working Ethernet with an old kernel if they are using
the first bullet point. So we should not edit every DT blob in
mainline and change rgmii to rgmii-id. We want to leave it to the
board owner to decide it is time to make the warning go away.

tx/rx-internal-delay-ps are optional. I would not add them yet,
because it makes the logic more complex. As far as i understand, no
board has required them so far, so there does not appear to be a need
for them.

You need good commit messages with these changes. Make it clear there
could be backwards compatibility issues, but that is the cost of
fixing up a broken implementation.

	Andrew

