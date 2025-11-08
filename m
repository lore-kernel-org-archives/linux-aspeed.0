Return-Path: <linux-aspeed+bounces-2838-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBD3CCFA13
	for <linux-aspeed@archiver.kernel.org>; Sat,  8 Nov 2025 17:51:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d3k4X5drXz3c1J;
	Sun,  9 Nov 2025 04:51:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762624268;
	cv=none; b=gVv54KMvB6auyYWhNFBScikyllWMEVy6Qqqrl/VqY9uXrvYuUIB0IKoJWwVEREndnIbEyPq98XMpZCC2S4bWYzR4kjFwFUydQaAS0LMa+dxwjEBWPq9G9yZ/rzisCD6r7niYPJXWP1nqjbadIHKiMCgAjvPQhXV9Rr3v2RhA3xPfHSiUzo6vRFbRNv2xqRNFTgZWgovsjAk3i29FqVelXCtgakBOfdrKsOMs0pNXaw7b3ATo6XlxYMmzbhoFvk7y6kqxrAORB80siOZBplsNAgvUKwxem/KzC+X9OdfGZi8u0uYodyRCmZgV5kTAw4tiie/ZnckxFsnaqy2L1u4/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762624268; c=relaxed/relaxed;
	bh=w5F5crbl5PXGRN0zWCBy1QeKvlywUYTj3rLQO8PeMZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRnwd+e2ODAdR6WIXTAaTAV3ypepseB+3tv7MKRZeoQc9R68GA7eJkbE9JY/uu1eUKXt9B2KSNFBejPD9AwoFrEWrN0uwPlVJXviP4bU8J+1di7heeN2eg80aaw6IgmGpnej9/atZYt5umJ4yJbDHkerhPoN+i7TqCJ+NVB0dSAkpaCqJvMiJiQrZsnddCtA5Kr6JIk5j2a8tk9QZCJUJqE+KEXv8bsc2EOdpgNOd+ncmSvTNYX6FQxCeIU4LGg3CV6ERVjVBjLdRHazgETtLQSNPFqfRHDZaxNTJmW1NcwksRBWJ2jdTDsZfFF2l4ULV0Qltp5ZIGLmZJYpk2gw3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=E/8+gc3y; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=E/8+gc3y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d3k4Q3t0fz3btw
	for <linux-aspeed@lists.ozlabs.org>; Sun,  9 Nov 2025 04:51:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w5F5crbl5PXGRN0zWCBy1QeKvlywUYTj3rLQO8PeMZ4=; b=E/8+gc3yS2jjfM0yGN//wqd4Vo
	PzfTOGt41E1l80JdPzTOxWi1zLCYFAlGK7oyy6ly4WlhemKdvNxLhDEu2u78id1YVT4ZesuIEtbKn
	dmxlFxLBSyEpDaoXePzGt3nj1QFcF7nOSpU/VxmU1ZSCcmb6Sh0zaK3Ln+Nvj1y1nDtY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHn5H-00DOZW-2W; Sat, 08 Nov 2025 18:50:43 +0100
Date: Sat, 8 Nov 2025 18:50:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marc Olberding <molberding@nvidia.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dts: aspeed: Add a dts for the nvidia msx4 hpm
Message-ID: <21b57a52-040b-4376-8ac0-6abdbc8d43c6@lunn.ch>
References: <20251107-msx1_devicetree-v2-0-6e36eb878db2@nvidia.com>
 <20251107-msx1_devicetree-v2-2-6e36eb878db2@nvidia.com>
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
In-Reply-To: <20251107-msx1_devicetree-v2-2-6e36eb878db2@nvidia.com>

> +&mac0 {
> +	// bootloader takes care of proper mac delays for now.
> +	// set the phy mode to rgmii, and if/when the driver is
> +	// fixed, we can make the switchover to rgmii-id
> +	// and have the phy handle the delays.
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy3>;
> +	status = "okay";
> +};

There is some progress being made on this at the moment. So please
just drop this node for the moment. You can add the correct node once
the MAC driver is fixed.

	Andrew

