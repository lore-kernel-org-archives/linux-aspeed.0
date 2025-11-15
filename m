Return-Path: <linux-aspeed+bounces-2916-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62534CEBF86
	for <linux-aspeed@archiver.kernel.org>; Sat, 15 Nov 2025 21:46:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d86zJ3p6nz2xqg;
	Sun, 16 Nov 2025 08:46:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763243212;
	cv=none; b=FTkrTv1iGq1oqo02pNV7TtUlmF0ERWyu4YCTxM+8ULtVy1KtIE7+WBCcYMkvnSO4O1ECL7EymG7UrinLN9RAf7SsOpHKZnWz3Yl3d214S72KT8h06KGsj8CIu09CMRDrY4uZD2Ft8PizGf8AF6wofafFKHW6NKP10Za/NjJ4q0pJBLza1AIhGs1WvxRpC4fOPJAxtQ99Bupnkmbdlg6L4N65Mv54rlWrJQQseHRIOtqPmkj185X8KMBkJK142xCz+PtBF70X7hlUVnTCfJt5H69wjwb8gUjGPcMk4c1D4FHI9kpELDkN4gyh6TTJXLJPWZp/wGKoDge37Vvb8MKWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763243212; c=relaxed/relaxed;
	bh=/whuAK3kZgLzmadCmNYa4Vh8RN8Z7SP1J4SvcMcHv2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekdx5aIPTwQPE5UBTPSp1MfjEoIiWboHF01s/OEJSvEvf3wCFsTSdYGF+pjcdNyI8/VvflA2jXIosID5RXgpvKQCEDW5ID6uGtnBWitoEa5cBzzgc5YpwU9QblgeKaNCoiXZEt7cMgKmrHP2ms2tZhDr58VodbtGC8IzZodPjq7vLupcz8fZtnnnIoMKBSLNEJ9dLozPcIP9/khq14BztbzHYdF9cWvwMbqbKy+UQudvOVpBIzQVpXxzU9LnNFvMugiMfkZeqIj3CubfJOJgBxIXUkif+70Xz3V4tnrZriKiF3Rk0EoQV1xcauMlN5vVBsJDIMRLWFL4QTr0GqnuPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=BqUkofmW; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=BqUkofmW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d86zG1FRGz2xqf
	for <linux-aspeed@lists.ozlabs.org>; Sun, 16 Nov 2025 08:46:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/whuAK3kZgLzmadCmNYa4Vh8RN8Z7SP1J4SvcMcHv2Q=; b=BqUkofmWLA/5XsBL3zG6W2CG9A
	2w8hAJDCdvu170jvmqVCh3C7wzLAfwYwGsO7TlSjv4QZyuFKHdKFjBZt+zm705bTebsUzav8cupwK
	AUWns5itZzZxccGXPwG6PL43hFGPs/s9dw/D5mG+LY37jHakJ8jsJNv+muqE7HUbJMJw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKO60-00E7C7-S7; Sat, 15 Nov 2025 22:46:12 +0100
Date: Sat, 15 Nov 2025 22:46:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <041e23a2-67e6-4ebb-aee5-14400491f99c@lunn.ch>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
 <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
 <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>

> Based on the above information, I have attempted to outline my understanding.
> 1. 'rgmii' + MAC delay:
> Add warming, keep MAC delay and pass "rgmii-id" to PHY driver.

Think about that. What delays do you get as a result?

> 2. 'rgmii-id' + MAC delay:
> disable MAC delay and pass "rgmii-id" to PHY driver
> 
> 3. 'rgmii-id' + no MAC delay:
> Keep disabling MAC delay and pass "rgmii-id" to PHY driver
> 
> 4. 'rgmii-txid' or 'rgmii-rxid':
> Keep original setting

> I have some idea to discuss with you.
> 1. On 'rgmii', I want to add warming and directly disable MAC delay and pass 'rgmii-id' 
> to PHY driver.

Yep.

> 
> 2. On 'rgmii-id', ignore if enabling MAC delay, all disable MAC delay and pass ' rgmii-id'
> to PHY driver.
> 
> 3. On 'rgmii-txid' or 'rgmii-rxid', keep the above item 4.
> 
> Actually, it's difficult for the driver to determine whether the MAC delay is enabled or not.
> Our design doesn't use a single bit to indicate the delay state. Instead, the delay setting is 
> derived from the user's configured delay value.

But you can turn it back to ps. I would say, if it is > 1000, the
intention is it provides the 2ns delay. If it is < 1000 it is just a
minor tuning value because of bad board design.

Do you have experience from the field, what do real boards use? Are
they all inserting the same 2ns? Or is each customer tuning their
bootloader to configure the hardware differently per board design?

You might even need a more complex solution. If the bootloader is
adding a delay between say 200ps and 1600ps, it suggests a poorly
designed board, and the PHY adding 2ns is not going to work. There is
a need for rx-internal-delay-ps or tx-internal-delay-ps in DT. You can
give a warning, and indicate what values are needed, but leave the
hardware alone. If the bootloader is setting the delay > 1600, passing
_RGMII_ID to the PHY, and disabling MAC delays is likely to work, so
you just need to warn about phy-mode being wrong. If the bootloader is
inserting < 200ps, and phy-mode is rgmii-id, that is just fine
tuning. Maybe suggest rx-internal-delay-ps or tx-internal-delay-ps be
added in DT, but leave it alone.

Whatever you do, you need a lot of comments in the code and the commit
message to help developers understand why they are seeing warnings and
what they need to do.

	Andrew

