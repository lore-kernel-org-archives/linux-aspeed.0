Return-Path: <linux-aspeed+bounces-4882-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2E9C61DE2
	for <linux-aspeed@archiver.kernel.org>; Mon, 31 Aug 2026 12:13:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYSZ44NhRz2y2f;
	Mon, 31 Aug 2026 22:13:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788178396;
	cv=none; b=OrcblvS7qkTs/2RG6W+jhEiQ2GSCeYdXiwZenk3MUj8mFGkFCud+Lw+/oERBKTjEy8uEhv+BINsr7CJ6PFU3DZaZc0YZJPtARvMp0Ao3uoTN8CisJ7y9ShqLpZVYsO5KIOivJUxdL5FiwepwHOxXlQWrUu4jHC2Tf9eRrZ2dF+jTiH4HYouBAXy1XQA0j5GF4ax6fa6vORphCqFCE4dz9C3+t6oJBLZI0WWcy6iNPK2sJofDD+e7wOb8bTG7/pD0wZphC1FClCL5qPua4GPsEtNLoQjqEXDtMirg/OiTOcHBueaoPcdW0RFJ+aBNyXdXDaehFv/Qk3hfmrhJpmUQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788178396; c=relaxed/relaxed;
	bh=F5FZuqvEUAT2/PGcwzm4Qov9gm3yBMDweP9yb9iR+HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb81DXI992PsaojJViO37RKFxO97IF0nWNiDaDeCB385iR0vAuhVU3pCKjRxxcwBAA5J3q6nKPpmLrqlBIlh4YQorDJ/q9km6yAp1t6HFKf9XDk57E5EbD5VwlCS+gQ8zpYC4hGdXSOAQqDy0pSt+1zx+Zf1xV0NtnI8wlhPOjtc056oBZN2NbYI1Hmy1NoOk5a+9lsf8Pm7vBsSAzr0HkW3+xS6FAXmAUB3E6HVRm+1SCpkQav40YGwskCqSF5WH7cfC1xjmFzg2S4a4JoYaR+pEOkpz45dgSqZ911OZ4czwz5rttYGWRDBfSq2q7xYQqGYi5576mIhvdMkaZMtOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ZRFide8o; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ZRFide8o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYSZ20S5Fz2xLf
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 22:13:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F5FZuqvEUAT2/PGcwzm4Qov9gm3yBMDweP9yb9iR+HU=; b=ZRFide8oJiPpu9hZmbIkYaN0+4
	4XtdFgm/EkgzNhTbt5eEEiWaD3+OifNF8lBC/8J/GpnGa+xucYWpnCdPUjyXBZdq4NwjIqUWIeNH5
	GW6b4s7GJcXVohYd4clgmE47LMQPpdA70XUiyjLed1CKfrRDOU5HcaAQHutx8i5wxhng=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x10se-002Acg-Kj; Mon, 31 Aug 2026 14:12:52 +0200
Date: Mon, 31 Aug 2026 14:12:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prasanth <prasanth.padarthi10@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Message-ID: <daf98fe8-70f9-410e-8a2a-042a671086c2@lunn.ch>
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
 <d60f234e-1b9e-44cc-9bad-da79e794fe44@lunn.ch>
 <CAMFFDGgTnNouukst3V1rEg0NCNMW-BZ6tM6+fbQc0zeXaOb72w@mail.gmail.com>
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
In-Reply-To: <CAMFFDGgTnNouukst3V1rEg0NCNMW-BZ6tM6+fbQc0zeXaOb72w@mail.gmail.com>

On Mon, Aug 31, 2026 at 06:43:46AM +0530, Prasanth wrote:
> Hi Andrew,
> 
> I do not currently have the PCB layout or trace-length information, so I cannot
> prove that the board provides the TX delay externally.
> 
> What I have validated on hardware is:
> 
> rgmii: fails, with RX CRC errors and no valid RX traffic
> rgmii-rxid: passes, 5000/5000 packets, 0% loss, no RX CRC errors
> rgmii-id: also passes with the same traffic test
> 
> This shows that the RTL8211F RX internal delay is required, but it does not
> establish where the TX delay is provided.
> 
> Given that I cannot provide PCB-level evidence for the TX delay, would you
> prefer that I use rgmii-id for the next revision?

There has been a number of threads about the Aspeed SoC. It typically
has delays enabled in its MAC, by the bootloader. The Linux MAC driver
does not disable this, nor does it mask the value passed to the
PHY. So you see many Aspeed .dts files incorrectly using 'rgmii'. Over
the last couple of years i have been pointing out this problem, but
nobody has stepped up to fix the issue. Most DT developers just leave
the Ethernet node out, in order to get something merged.

You case is interesting, because you are not suggesting 'rgmii'. So it
could be there is more going on.

If you look in the email archives you should find the information
about where to configure the delay in the hardware. You might want to
read it out to understand how the bootloader has configured the
hardware.

    Andrew

