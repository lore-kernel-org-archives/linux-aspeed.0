Return-Path: <linux-aspeed+bounces-1008-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074AEC282EC
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 11:16:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGXTl4g0xz2yhD;
	Mon, 17 Mar 2025 22:16:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4d48:ad52:32c8:5054:ff:fe00:142"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742210169;
	cv=none; b=c5i9asaoJnmlZTzIhdWqp/hje5UraLd74aZTT8179T+2GQ/GX9NtgYylTGGVywcnzqCvmsjzEx6pmfaEx4AK2Gxbosbp2BV1+lTfeedeUhjZsWkMuFVwn79v8vY3devRHwPOWMFCMPymQm8eFeeetENxkRFYIYBaaUzM5YrBWMiOVAmXlNSLHWuaPoDt3R91mHp3bhmBHlRhp+2BtiGefJRDUKDOQCAQfADAaaaEX53ZQi9aO44rzdCHaAASVtn9yg8C3CTz7jBfhEsKVo/5livpR8r9AQ8LPzyZ8ABCQwl9yuE4YyB0ex1IlsuieZTBr8v5hKFQQIynzD3TrZ4xCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742210169; c=relaxed/relaxed;
	bh=CucQxAMz4q00rKoqMFkXW/rTlFZs/81VWM2dWuS9iPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO6uy8jXSf7YrNIiCJ4jSIZyFiv1zGa5a5XO83jGY3RDKSZ58a+QyzWQ+pho/5157CY6/IlJuc1DG7k77s5/6aLauxDgIuYcKFgiv8YzvzlgV/b17MPQWwmFTmUYoI+SN1760bFP15JIp47wsOE37DERbO8VX5Bw4fYjMvaEimGJS4RSXz1nLf8UY4MVhb4kCVjS3b7QmYQLwBfDGCmZgVleOdR4agDAxDjNUpXYH2QMuqI/HIAAM4+aAhCtn0xDbfdwXbqj/HHprFibwRRBoA89YVe4qhtRNGQir8xz9YOMtcfMm80cxT9CWazSu4Cv0bo7cv7nbKw3aFrtoikKQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; dkim=pass (2048-bit key; secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=L3ANOjmC; dkim-atps=neutral; spf=none (client-ip=2001:4d48:ad52:32c8:5054:ff:fe00:142; helo=pandora.armlinux.org.uk; envelope-from=linux+linux-aspeed=lists.ozlabs.org@armlinux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=armlinux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=L3ANOjmC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=armlinux.org.uk (client-ip=2001:4d48:ad52:32c8:5054:ff:fe00:142; helo=pandora.armlinux.org.uk; envelope-from=linux+linux-aspeed=lists.ozlabs.org@armlinux.org.uk; receiver=lists.ozlabs.org)
X-Greylist: delayed 364 seconds by postgrey-1.37 at boromir; Mon, 17 Mar 2025 22:16:04 AEDT
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGXTc6bC3z2yfG
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Mar 2025 22:16:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CucQxAMz4q00rKoqMFkXW/rTlFZs/81VWM2dWuS9iPE=; b=L3ANOjmC4JYjNEDTGSFlYSj+EY
	lDMUKIAPuul1T4GUZ6puKUkV8BzHq5WJJG6+uQGshRelm43SbzWOXlnmp3+t9vl5U/CCIqrkoFocf
	0CLTtY4lXl6Aov3FiPFUso512czcMF1HO/Kfq/XAlzRMnW/HXJL2jAIjFrAL1OAvRukC77bqdyIAv
	vnzXTJERSI/rnvJZYtJBQUhNFNs9z9CSA7BH9VOZ2jnPlNjMcvT0nKfMAOf3fOK49uAvKalEejjFu
	SziT/8P/6JFZWVLYKFbO8dKi4HTjASat0y9ujjRXOzcAOdpA22UH87wRqpGq1Z7yFEyP30SG71LHf
	YJq6KtAQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59148)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tu8LT-0003PO-0x;
	Mon, 17 Mar 2025 11:09:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tu8LL-0003W9-0k;
	Mon, 17 Mar 2025 11:09:15 +0000
Date: Mon, 17 Mar 2025 11:09:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	ratbert@faraday-tech.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	BMC-SW@aspeedtech.com
Subject: Re: [net-next 4/4] net: ftgmac100: add RGMII delay for AST2600
Message-ID: <Z9gC2vz2w5dfZsum@shell.armlinux.org.uk>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
 <20250317095229.6f8754dd@fedora.home>
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
In-Reply-To: <20250317095229.6f8754dd@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 17, 2025 at 09:53:33AM +0100, Maxime Chevallier wrote:
> So this goes completely against the naming of the property. It has the
> -ps suffix, so you would expect to have picoseconds values passed, and
> not an arbiraty index.
> 
> Take a look at other drivers, you should accept picseconds values from
> these properties, then compute the relevant index in the driver. That
> index should be something internal to your driver.
> 
> An example here :
> 
> https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c#L51

Another example would be drivers/net/phy/adin.c::adin_get_reg_value()
and associated functions - these lookup a DT property and then look
that up in a table to convert it to a register value.

I suspect that's something which could become generic, as I suspect
most hardware isn't going to accept a picosecond value, but be a
choice of N different options.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

