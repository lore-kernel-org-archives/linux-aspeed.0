Return-Path: <linux-aspeed+bounces-2031-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34DACA0EFA
	for <linux-aspeed@archiver.kernel.org>; Fri, 22 Aug 2025 00:12:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7LGr1Dg5z3bb6;
	Fri, 22 Aug 2025 10:12:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755821540;
	cv=none; b=KXLHz5aQDULuUslTj02T4YYrLekinKS+MQFac0vjBNabFNcoNMW9HJzybNu1hPirPdneQAacGObTGYkytUwozHNEg6JkV/WAgVX45IyhIVMcr9PIqFG9+ahHe6eIR+gTX8vesOo7MbkSstwbI5WqElqrWOhLLfdtIza294bSZxWCf7Sk1NqUulrw/rYPKJHGAn01EAbrdF0dhgZ0rB/iit2UyehXyZS9iDX4+AsFb9RPk50jK8Z8cvnbo5ZmP4Qom8LS1xblWY+E2ThtmhxoAD/y71OijaGWTFIyAXpdYgGfRAKwUXVH6SsQukvoXkIW+KX2LuCmOo8jDxB++tM7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755821540; c=relaxed/relaxed;
	bh=0V9vnhvl7kfzNO/a9uciBu9rFyDt7meyaj/wnJfH86E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4urzghflsmqffu0zTFSjV+YL+p6jcPBr1AOy4HDdCiGPmet8IPHdSHYm1SNfxbK1NZCLa31nZsy/5PjzCak/CJ1fRk+93uok3NqzdDLg4qARl48V0lOEu3e9XLkYFd4q1VBc6lKDEfxa0t2epIsFS27+nIGXYENQMiiGudl0baEfK9iQnhhS/cUhLYcqcyCI512Nmdtk5GCc/hLi9PwSbOR7EHA8MmfDH11VwN3R1svA0/5IP+pMg7xHsjFUUI+6Fx1lwr/8VZehQamGPGnC880T3ZiwRTHeBAmlM15TnJNMFUh2ADUND5FVVDUHiDrYivHAI0WTcM6W2/Hye0pzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=hE9vcDcv; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=hE9vcDcv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7LGp32S8z3bb2
	for <linux-aspeed@lists.ozlabs.org>; Fri, 22 Aug 2025 10:12:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0V9vnhvl7kfzNO/a9uciBu9rFyDt7meyaj/wnJfH86E=; b=hE9vcDcvu8i7v5Uh6vAfLCZ32i
	GZ7mT1gdrfNFREwtqr88Ijj/ipJHSsfGjhcO4A/ygORSA94FThY1eRtgRDRs+TwVM7ZECF6tkQiYK
	ynhgDpw8MDLJIG2eN0nJmK6tDak86IkvU19ggl9pv62PQBr1tAgtNSHTvObueR06Nt3s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upFNr-005W4E-6y; Fri, 22 Aug 2025 02:11:55 +0200
Date: Fri, 22 Aug 2025 02:11:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	howard_chiu@aspeedtech.com, arnd@arndb.de, andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [net] ARM: dts: aspeed: ast2600-evb: Correct phy-mode to rgmii-id
Message-ID: <6a3d7eb4-c091-437f-98f8-2b8577e539a7@lunn.ch>
References: <20250821052555.298860-1-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20250821052555.298860-1-jacky_chou@aspeedtech.com>

On Thu, Aug 21, 2025 at 01:25:55PM +0800, Jacky Chou wrote:
> According to the latest ethernet-controller.yaml.
> Since there is no RGMII delay on AST2600 EVB, the phy-mode property of all
> MACs change to "rgmii-id" mode.

> @@ -123,7 +123,7 @@ ethphy3: ethernet-phy@0 {
>  &mac0 {
>  	status = "okay";
>  
> -	phy-mode = "rgmii-rxid";
> +	phy-mode = "rgmii-id";
>  	phy-handle = <&ethphy0>;

How does this change actually work?

I could imaging such a change as part of a patchset which changes the
MAC driver, and how it handles RGMII delays. But on its own, how does
this not break the board?

	Andrew

