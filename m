Return-Path: <linux-aspeed+bounces-1672-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCBCC83F03
	for <linux-aspeed@archiver.kernel.org>; Wed,  9 Jul 2025 13:24:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bcdwx2dvyz30Pn;
	Wed,  9 Jul 2025 23:24:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752067457;
	cv=none; b=FSoEFICH3ozWeteICd0F6hFk2M1SbR2WmsEjfs/p3r6W+kCsPynVCEcw31BlDhkBL7PHk9I1v2O8NaGguyM6ekygbcL2QKGsAzLS/X/XUzc4S8kGc/iPg47Ag6ZLN8tDr3pw8puSPKZld/G78Q2u2kv+fMZ8eRiTFw1NXj1x/8UsmtT9RHQ4AdihQ7dwc4YIeVsKNQNrfn6+FJ0EpXQ6ZuSM+1vYIZeqY5iVrVs5gv/rmpezAeRZ0U7Aew1NP79Gco9M10AWvHU+oWE7ZCXkDS2MoBJfuJjsAOz+B5AI7bT92mCnw0UX5Abiim2w3f/evXVTCSBg5bSORkm9U12+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752067457; c=relaxed/relaxed;
	bh=hQ9HxQ4CL5cwBPjvKDpDZamXchNvQ4T7qK3P3nj85G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+1dZy/FWNcOVCZVVqVyWsqi1nhenfDhseGOopP6R0DzSO/CkF/Z3R1ymaKKdGE3ia6isAVLhDbHvqZLicALtB3akOu+0xOHJpes1J8DlnuOH+hFBIVPyii3UqcuFvBZvdRfPDFKHngTy9X8fmEmnZ3cpOZcgnnSTsQL2FduBxtkZTXtIJtQOxC//rTET8x+SqNcYHOO/QNk63n94yUVFUFyMICO5cW+IqJrmGTTN+m8JGsJb3X/CCAPD5PxTz29TsZghHQtMoKz8k/Dp9QZa49UP1Nwl37gieKKi5jTedvuUC2pCm9anGce/H5h5cxxaIgaZDENh/d1njVRuNWO1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Fe0jgGso; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Fe0jgGso;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bcdwv27FJz2ydj
	for <linux-aspeed@lists.ozlabs.org>; Wed,  9 Jul 2025 23:24:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hQ9HxQ4CL5cwBPjvKDpDZamXchNvQ4T7qK3P3nj85G8=; b=Fe0jgGsoitEJIzGGN64xp/8LbW
	PSANpYST+y4jFNuWxPL1FSw9Flcaw2JOQJMywR6O1NmbtVZaaIcBQ3wgcPIKZTgcvt2Dn424ws8lh
	9BeU8GQk5eVXBWpUMgiEqoUxiNo1BrJuW5CszAKN9N1V4/Fswlmq39ewio9vZF4N7ULg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZUmG-000waz-04; Wed, 09 Jul 2025 15:24:00 +0200
Date: Wed, 9 Jul 2025 15:23:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, horms@kernel.org,
	jacob.e.keller@intel.com, u.kleine-koenig@baylibre.com,
	hkallweit1@gmail.com, BMC-SW@aspeedtech.com
Subject: Re: [net-next v4 4/4] net: ftgmac100: Add optional reset control for
 RMII mode on Aspeed SoCs
Message-ID: <3dee14d4-c8bd-4c27-b9b1-28b449510b84@lunn.ch>
References: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
 <20250709070809.2560688-5-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20250709070809.2560688-5-jacky_chou@aspeedtech.com>

On Wed, Jul 09, 2025 at 03:08:09PM +0800, Jacky Chou wrote:
> On Aspeed SoCs, the internal MAC reset is insufficient to fully reset the
> RMII interface; only the SoC-level reset line can properly reset the RMII
> logic. This patch adds support for an optional "resets" property in the
> device tree, allowing the driver to assert and deassert the SoC reset line
> when operating in RMII mode. This ensures the MAC and RMII interface are
> correctly reset and initialized.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

