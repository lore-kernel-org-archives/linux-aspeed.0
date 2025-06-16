Return-Path: <linux-aspeed+bounces-1484-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C44C71159
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Jun 2025 23:52:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLmyk0Vljz305n;
	Tue, 17 Jun 2025 09:52:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750117966;
	cv=none; b=bcervOyFNTVVhQRN8NFsCcQBg0NIXZr7HfSWXZtrynQnd6t1hGfyNPSjnlX/RkULCLlQvrmM7DiMOhyK/izC7nJTcrcFFYe3MS7ZXmvC/J1Q2HxWoln6s4HOZyzFfHFS+HjQrVK2IA3SFkClinXCUF+cTJzkX805LL5vP5Se4/ymYFurHKVFeJH644ck0641BMfci31bm5n6sIkm9F7u7/I1YxfFopnTS7viHhMo/FrtbFHESA0tE+uAqOcchGibbjCxpxE9IvdglyYW/EySi3TZYs7gfeeyy1X9H0035g9iNitdOWZSXR6X8BOk7Iut5nLWuf1ENXOqXpyGOWGxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750117966; c=relaxed/relaxed;
	bh=Nx2VXidiB5UsT2nnGwnvJjTlLUfXLsHpiKrWVggKhyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmtyiRei/pw0arCfMfHJPLVlX6x/VSQN/w+6brnA6n1DbwhuM61Tz5jF18MOqlUdpOpduAo+wIiSwG38QHEZzcBZXbxhRwPPpOu4XTNZl2728LKUwWlLv6bPnQ8RYV6g8oS5Xm9ZaYqx/AzZOJ/IV/uEYZ9+RzAvnL/YjBJLaQCz+6un0iuMw0x2CWwKse8CSU4SRX2la4pNmOcBqwxtrDvNlrJa+E91rcR3Gfp7aE7IaI80JFPLcmYbac7BlB6ZdcLGCvLswbqegaFSFN0wczLFhIDahp836aCfJJzVjUrzTK3vYzTyhz+1DPNrjJinijInD/5ySErNXKzmTFsHYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=oAeIQ271; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=oAeIQ271;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLmyg5X38z2xKh
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Jun 2025 09:52:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Nx2VXidiB5UsT2nnGwnvJjTlLUfXLsHpiKrWVggKhyM=; b=oAeIQ271lYVhYBQevrGYAx60dK
	aMJQ5JVPKwVEyOWyncFuLKaa0JHTZ98Ge2aK4dPo4TZ3Cw0nB45mojyvV9K6xU1QOrbLhJMv4xLlL
	KCysaQDLjz40DQBjvJyoYTenAAyXY0f7V+8AB0UOx0QMRU3o5KwYhpNVtMfYF/MdvnJ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRJcq-00G6c1-5V; Tue, 17 Jun 2025 01:52:28 +0200
Date: Tue, 17 Jun 2025 01:52:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Donald Shannon <donalds@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: aspeed: Add device tree for Nvidia's GB200
 UT3.0b platform BMC
Message-ID: <34be8ac4-8414-423e-a6e3-a566ad1e9f11@lunn.ch>
References: <20250603203241.727401-1-donalds@nvidia.com>
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
In-Reply-To: <20250603203241.727401-1-donalds@nvidia.com>

> +&mac0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	phy-mode = "rgmii-rxid";
> +	max-speed = <1000>;

Yet more broken aspeed DT. Don't you monitor other patches sent to for
aspeed BMCs, see what has been rejects as wrong and avoid the same
mistake yourself?

Please search the list for why these last two lines are wrong.

	Andrew

