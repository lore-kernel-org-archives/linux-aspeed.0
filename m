Return-Path: <linux-aspeed+bounces-140-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67913D60D0B
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 Nov 2024 02:18:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xsp8B0YcDz2yMF;
	Tue, 19 Nov 2024 13:18:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731982730;
	cv=none; b=FAjG8FOYhd8AF2FCTaLS+WpN+lumQcE94BeH/ToIkLvQ/xAwjQZf0OKvzCOhOmF/VaM+YMEs9cU8M920Dkqu31G92ZbhA+tncvNqix/FqOTr+XAqIdTE6pcjb9lrud+JbBlCVtqydWh3jNIGRquTFwowMKS98IWkEbzUKsDIeye7nrbXuzBtDxSrBETGiUTQRInLK9QXSVVQzlkXnIbsdf2odoqexG/6JaCbHrgdYjR/N8rasizUM+rjjk/Q3YYut5Kls/DbrTDGfrRMzV+qOKA4dtPZ8XxDP148M2e4+uago+bxaMcskVvxAmYRZKWbhn4p2hQP+/uqzGtrQl6wUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731982730; c=relaxed/relaxed;
	bh=AKexsWnSH++iKlU+BchMFxWV0f36/dz0tcdVIEQsvg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiLeAHRS/5Qp07ivQNl/mLIeDm3HS+C+6TzVfc6dmsE/c2MPB1KoCEqF0Gdq/f1PTTlCbSGt2QGniG95zEai707OdgQLujCFbjLxrP3ewykQpTid6Df+K37uemmg6bERJlcornsenyJPZOWRhfpxSx9NKQOXGl1DIJWx0HEeOKtXYfYIFmptDgEQOQXObBeSAwR2LkkCKhEb9qHrA6Jew8ZyoiDDIcv/q4u0kogaxigCCbh/gP2ysoLT+ow9UHBO3Tn92cbaGzgoENDbiGVhBAkPCxOQatf6xtgZnlKnI54QkUC8eXcf8G8pb6o0jAR4o9BBZb0LGLGzYt9Jz5qmpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=FoRpVWRN; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=FoRpVWRN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xsp89045sz2yFQ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 19 Nov 2024 13:18:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AKexsWnSH++iKlU+BchMFxWV0f36/dz0tcdVIEQsvg4=; b=FoRpVWRN0AyTJEZev+FVhNBVHj
	5/xsNYxf4HOCeqSHtbzissQs1dxF411e5l+8PmCZin9veDYrjVRHpTAHlnbb2yTXqtaCAZrb07tHN
	DaFy4wtE3ClyJFgWz4xOZW8DtXC86fzJ6s9IohxQH/wzHMOurDr29anPNX8D8R1b2NP4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDDNQ-00DjXv-Tj; Tue, 19 Nov 2024 02:50:00 +0100
Date: Tue, 19 Nov 2024 02:50:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next 0/3] Add Aspeed G7 MDIO support
Message-ID: <7368c77e-08fe-4130-9b62-f1008cb5a0dc@lunn.ch>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>

On Mon, Nov 18, 2024 at 06:47:32PM +0800, Jacky Chou wrote:
> The Aspeed 7th generation SoC features three MDIO controllers.
> The design of AST2700 MDIO controller is the same as AST2600.

If they are identical, why do you need a new compatible?

	Andrew

