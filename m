Return-Path: <linux-aspeed+bounces-3277-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F0AD2502E
	for <linux-aspeed@archiver.kernel.org>; Sun, 11 Jan 2026 21:10:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dq7Sm5CLyz2xRv;
	Mon, 12 Jan 2026 08:10:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768165816;
	cv=none; b=fjNJM8VTKzvBuhxm2/aRu0Q0V3MD+rpTKjZvUbvr3crCSTXo2ItHU5yqDtRP8Z74RMQFWzv8CEcjeh2zuy+cB8orxv4Aozm5yaNrKyMqA0/NF8mjrdyQjIZO9SZjIq01GLqLbjH7Xng3FXjvxxQAR29D3li3kpY5qQGY+zYyo1DwoB7xHEkWi2VUDwYBMrCZJJESbBnXCo+wBuPDAN2ovKecH9FLHgItfF0mu88iDuioLLuhRYrzsyR8JgEsPdV0T96+OPxAHBZrmpjTbYVSPaUmyjKmEEruIx0BdjpxX6IxATGzBa5UB5C4fStV2OEKOsSFR2CnvD5U2tQoRzZPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768165816; c=relaxed/relaxed;
	bh=ss3B6MRAGxluOfMk+Ev7z+q95mmBhKsL2hIyydgCPbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj6d+qtB8Fm1EcnOXgRp4gOKrQ78CrMC6448nQ15utWu7PGg3U1iF7e2XFq1wetiU6oU1B4r78h+pO+oTGutrsvlTp4I+ch7VTVq4e0V+IlMspNKX40qCnx46IZKEnY+BWAqpSwNngKlor+1/tLUoO8DsjwwT4iaK/9e5ANJyfpE5viQdXVNctBFmIOLQnW1Io6M9GrFLIUS90OcYNp5FjxP2RY7JskkLXa+Ir/loAG3r7FMNOSYwYZd4jBXvAaxGhqPb8Q0OyktknDYj0+ytOhatiDwF8pXbaZv538s4wvI/vKMKrBzYSiUlnvLYU+C/5uL370DcyqxVyi18L8u8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=1sv7RSXE; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=1sv7RSXE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dq7Sk50vRz2xQr
	for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 08:10:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ss3B6MRAGxluOfMk+Ev7z+q95mmBhKsL2hIyydgCPbg=; b=1sv7RSXEIg2Tt+1Q9QvtJP4p0r
	grxYVR9RFSsjp9kCPIhciD4JuwcJsUq5XsJRGGtlFnGfCIPCdQbQIW3kDtVaFmqGkizT1eIZDlkwC
	fvRRIXDdn07ufceWRSAf73V2QXXYyVolrTCiXGfb1Mel2BDdNWFHl4V2znx1IaWFXUas=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vf2h0-002MOs-Hk; Sun, 11 Jan 2026 22:09:46 +0100
Date: Sun, 11 Jan 2026 22:09:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add Asus IPMI card
Message-ID: <fdfb7212-5133-4cf4-9448-15cbbaa34eff@lunn.ch>
References: <20260111201040.162880-1-anirudhsriniv@gmail.com>
 <20260111201040.162880-3-anirudhsriniv@gmail.com>
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
In-Reply-To: <20260111201040.162880-3-anirudhsriniv@gmail.com>

> +&mac2 {
> +	status = "okay";
> +
> +	/* Bootloader sets up the MAC to insert delay */
> +	phy-mode = "rgmii";

There has been many discussions about this. This is broken, 'rgmii'
means the PCB adds the delays, not the MAC/PHY pair.

Please drop Ethernet support until aspeed fix the broken MAC driver.

       Andrew

