Return-Path: <linux-aspeed+bounces-153-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085C9D63939
	for <linux-aspeed@archiver.kernel.org>; Wed, 20 Nov 2024 13:44:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XtjJy2PnCz2yPS;
	Thu, 21 Nov 2024 00:44:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732110274;
	cv=none; b=XoeweMHNdGaHc8esGE8Z1L/3sEe8zVfN85IfqZI84znHaE5GRMNWaUWSWZxtjAsf71UuiHQ1pUEdl5A7koumv/Hdw+SEi/lWLt2CbzEUyk0DQ9VLzlkQfWOrihfAXnp9WUDua7u2eRwmlyHZaciYhE/nBwmqeJVnTv3ifrIA0kdegMHVSNbdRdoHiFasxiMxRh2IJsV1EWswzXVkaFXTdPGX+wKNMZjlSDR/fsho3mSFXf7DLChhwxe/XbHIv3c57QbuyCXJ5pfZcKO+FEGKjTbhlq+qBtB+l5/lZr8XllmVlzEARM9TYeg0j8CW+3ownzK83qP/rQJGPed1OE4nRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732110274; c=relaxed/relaxed;
	bh=vwDPiYIBxwEmAaxai1DgMFwF8LB6iOUHjsbt/QR1yko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpSdnkUnLrDi5TFAaB+oJ0tQyKcnvSEsBFVldDJQR9kIwis5ZcnoaHNFVaOyqQ2B4DrH3yR/czfndUecXQ6GvKlPYCuGQWzYoIRuPVQKjIaiMpQ0vM1H8WB+AQPY0YGT2mjD71tGWpL7rx3BU2XnXc9rRBOFiVOSqJe1IJMExyoccn6ptAALWV/MPkO1m63WhSfVpYu1hiIH1Es5gIq9xkrjCxmlWoY9BeQ7+4ZnoWJL3vAfhyrD4HGaPHPnMCwDn3v5CYJiXye6Xt3Yhz9+KIrJmJGEuI0swDC7m7xN3tPDtLjtCHPoH1j54/2nPTgGr76pEGR/ieJnkRO8Bgjolw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=dwQ/7DzW; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=dwQ/7DzW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XtjJv73Jbz2xfR
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Nov 2024 00:44:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vwDPiYIBxwEmAaxai1DgMFwF8LB6iOUHjsbt/QR1yko=; b=dwQ/7DzWt63C6SmfRoK5OrKV1l
	jRvx7JKVfjETzd8RbU+63a98l6A5iM/YrQfGnE+V3inVGUYSkESBNpTPj2Ig8sYuN1yDBXsL9ck6L
	8ILcrrEBhA5M3tzqu6J9pbDVSrda9UiViBg6CDjvGe5SID+sFJDX2PtAzet4YPzlLJNw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDkzw-00DxOS-NA; Wed, 20 Nov 2024 14:44:00 +0100
Date: Wed, 20 Nov 2024 14:44:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, joel@jms.id.au,
	f.fainelli@gmail.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: mdio: aspeed: Add dummy read for fire control
Message-ID: <b6155c5f-3012-42d1-90dc-8ef39d1eef2d@lunn.ch>
References: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
 <d28177c9152408d77840992f2b76efe3cb675b7a.camel@codeconstruct.com.au>
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
In-Reply-To: <d28177c9152408d77840992f2b76efe3cb675b7a.camel@codeconstruct.com.au>

On Wed, Nov 20, 2024 at 03:13:11PM +1030, Andrew Jeffery wrote:
> On Tue, 2024-11-19 at 17:51 +0800, Jacky Chou wrote:
> > When the command bus is sometimes busy, it may cause the command is
> > not
> > arrived to MDIO controller immediately. On software, the driver
> > issues a
> > write command to the command bus does not wait for command complete
> > and
> > it returned back to code immediately. But a read command will wait
> > for
> > the data back, once a read command was back indicates the previous
> > write
> > command had arrived to controller.
> > Add a dummy read to ensure triggering mdio controller before starting
> > polling the status of mdio controller to avoid polling unexpected
> > timeout.
> 
> Why use the explicit dummy read rather than adjust the poll interval or
> duration? I still don't think that's been adequately explained given
> the hardware-clear of the fire bit on completion, which is what we're
> polling for.

I'm guessing here, but if the hardware has not received the write, the
read could return an indication that the hardware is idle, and so the
poll exits immediately. The returned value of the first read need to
be ignored. It is simpler and more reliable to do that with an
explicit read, rather than try to play with the poll timing.

AS i said, a guess. We need a good commit message explaining the
reality of what is happening here.

	Andrew

