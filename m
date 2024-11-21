Return-Path: <linux-aspeed+bounces-161-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7B8D75BB2
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Nov 2024 04:29:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xv4xf0nN4z2yjb;
	Thu, 21 Nov 2024 15:29:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732163350;
	cv=none; b=Gshw1WsQtVI1k6n7/1mPl7OlNod92zGFkXBgeXM8yEZCCJG8jVJiZIloSxVLMDbBReLDGlZI0EBr3bLN6SmXOPFNdaFmIp0QcVXX+JM+pTyTpFNvoaDgB9LC8Uw4d2lmsQjAmnIQk0gz5+M1OfpqAAqqJV7PjeB5yqRzskQ0Nv3JsiQJz8PubW3OySqzCMqbJQK2+Rk9rlp6+KHHxznLRzVvtX/Cd+VnZqfA7SvenVFyS063MCNnSHEIDka8UGsGsZHUpLozPbz431rJDKiSqoMLJSlnAc9lyNFUWm5EJ27eM8oeQNdDC4v65cm2X5QseDEaHdajVym4LL63483brw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732163350; c=relaxed/relaxed;
	bh=mrLmzUmm6ToQPoBGZOkQVodGHG3cbLJ24xAFO3b7XsQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VAeCijhWnt0uqSFkf27LRZHP2ZaYgU/8PlEQFV3Gt3MlmlMlxO3DzniLJTHeX3eQCrDk6a93/qrol3o4z9ByyWheDuj2LJ1ECnTFXM7wplsjucmq6roq8nCpzmAyo4kYH+NT4WSQ05bALcdNxFpf8t054/YJU4n9ioXoTbN4iX2pTz6nNrTAFXQVM1DCRxRX844QHyfnCeoLee9GRa7u4iuelr11bOyplzfU5uE88qqvKOr/heDOmdrQvGyVYuZWsvFNiT34Q3pNpjMw+NRV9aHpDBy3eSzquzEVirpWVX/yzkXL0HpUl/PNYXZceDCKJqxIsHe6Mfu5xHXEmqx4vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=MEg8R2aI; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=MEg8R2aI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xv4xc0XZhz2yjR
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Nov 2024 15:29:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1732163346;
	bh=mrLmzUmm6ToQPoBGZOkQVodGHG3cbLJ24xAFO3b7XsQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MEg8R2aItOCsozsPbMgwasrISoK1DySd0kmnMLuGcFIDVypoEzI9axv9SrQU8Bacl
	 w5oxEl18qmEgYoTTTbw0vFb5jkm7oQ/LfWr+PC8qj8RtpDCAzyeDNZVc4YlYRbcSBz
	 IbuOFKez76r76Sq2AIgWeWv4vpqwM3SatVCW5KMDcJQFP2ycHZEZJyNd8nWmOeVzcb
	 qWBenb9nhm9Z1W8cUi9gCX87Iib9fYctRMXeZeP7XBHkzM3c0bvGeGkDoewEwDLkqm
	 5E02JqnKZVzyZfiV2ihQ5/1ZkJd6FiuVuwpXInGUUYMZG5kbE1mXmFQSt0Ej/89sTT
	 tQhcWYvrwZzIQ==
Received: from [192.168.68.112] (ppp118-210-181-13.adl-adc-lon-bras34.tpg.internode.on.net [118.210.181.13])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9CEB16C2B6;
	Thu, 21 Nov 2024 12:29:01 +0800 (AWST)
Message-ID: <944951bb04506e6b131293d634ab7be7417d8827.camel@codeconstruct.com.au>
Subject: Re: [PATCH net v2] net: mdio: aspeed: Add dummy read for fire
 control
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>, hkallweit1@gmail.com, 
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  pabeni@redhat.com, joel@jms.id.au, f.fainelli@gmail.com,
 netdev@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Thu, 21 Nov 2024 14:59:01 +1030
In-Reply-To: <b6155c5f-3012-42d1-90dc-8ef39d1eef2d@lunn.ch>
References: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
	 <d28177c9152408d77840992f2b76efe3cb675b7a.camel@codeconstruct.com.au>
	 <b6155c5f-3012-42d1-90dc-8ef39d1eef2d@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Wed, 2024-11-20 at 14:44 +0100, Andrew Lunn wrote:
> On Wed, Nov 20, 2024 at 03:13:11PM +1030, Andrew Jeffery wrote:
> > On Tue, 2024-11-19 at 17:51 +0800, Jacky Chou wrote:
> > > When the command bus is sometimes busy, it may cause the command
> > > is
> > > not
> > > arrived to MDIO controller immediately. On software, the driver
> > > issues a
> > > write command to the command bus does not wait for command
> > > complete
> > > and
> > > it returned back to code immediately. But a read command will
> > > wait
> > > for
> > > the data back, once a read command was back indicates the
> > > previous
> > > write
> > > command had arrived to controller.
> > > Add a dummy read to ensure triggering mdio controller before
> > > starting
> > > polling the status of mdio controller to avoid polling unexpected
> > > timeout.
> >=20
> > Why use the explicit dummy read rather than adjust the poll
> > interval or
> > duration? I still don't think that's been adequately explained
> > given
> > the hardware-clear of the fire bit on completion, which is what
> > we're
> > polling for.
>=20
> I'm guessing here, but if the hardware has not received the write,
> the
> read could return an indication that the hardware is idle, and so the
> poll exits immediately. The returned value of the first read need to
> be ignored. It is simpler and more reliable to do that with an
> explicit read, rather than try to play with the poll timing.
>=20
> AS i said, a guess. We need a good commit message explaining the
> reality of what is happening here.

I agree, the commit message needs to be more precise about the
interactions and effects.

Andrew

