Return-Path: <linux-aspeed+bounces-3473-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C330E8782C
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Feb 2026 13:42:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f54Rh0mXWz30Sv;
	Wed, 04 Feb 2026 00:42:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770126160;
	cv=none; b=nZjYksBrhbjuKoMio/u0A3BLD/n84opaq1KtKdDrdRswjg9HUJWmuKP1pdRGlr8gzRwkzL/MBGgAehJZNetOoGdB1iVvjaSME4LZ93KUISYZpkPSWRDHZXDtJn9t2BKwRzrrObIyLDn3nUQUAkqslyMKtFghFAb7zZRPwxbiGsM1xuUw31HTosrVWuytJEpeaRwp9JX83uYJOmQzvTrzOE5Nhr1xzo7mM60Z0UwPDtmV/KD8i8XyGW4Mv/WaukDPLZeQo48pxQ+n/iKa/RQWIf9Wab+wyRaayjGbzxDpQvYt4kZLTtxZ9d3tRwV5ByOXe/9GUnagP5WwkGutSVVuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770126160; c=relaxed/relaxed;
	bh=IGJeebgEXqWhXRsH4RnElTfr9kixznjS/2CB/02FO0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DajfaaoqXjcXCLMhusEPWVERfn5mvnBjeVZuIi+biMSwypDI/653I3CsmwgL+hggBCB8IWm3UpJsuCZ5YeELJj1v0e3TM92Es5ZFw5EYg9R78/1rQrhbAOQCsizzG/FvdNwSE4FgjN/SXlEQ0nKFOvWPDa+bYb+c5IPuY5AdE//tn8lIsBy4Kp/jfr28ps3Ix8LPUXKSXhbxfTWvuK5+X4Y8/dKl0uAdfW6MaO1vt1BKsZ7YMFMfAzbgTXDE/0U/WsGvOEkmDjmLsWAWigT1VFp+JWTE4a7O6baP5vf06SrHt8NO4iUzBz7g5AEkyg2Ri0KuXhIi7qMqabfaJfASTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=RKlbpjDJ; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=RKlbpjDJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f54Rf14qFz2xS2
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Feb 2026 00:42:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IGJeebgEXqWhXRsH4RnElTfr9kixznjS/2CB/02FO0o=; b=RKlbpjDJ5XhwXMQHJwEDOYWZen
	8hVXGjCJHsSs0LyvjzebOr9bQSe7gKk7FcO36E3f08RxJYTCfgJPybJ7FD4PVePUNcAy20Cvmw5fS
	/UOA/Yidi4aN5lMO8ke4wIAeQYfzVnlMpmUugmHoRKnOyhEIMv5O/WlmE2K0dsh+id/w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vnGfY-005x22-CQ; Tue, 03 Feb 2026 14:42:16 +0100
Date: Tue, 3 Feb 2026 14:42:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>,
	Mike Hsieh <Mike_Hsieh@quantatw.com>,
	Potin Lai <potin.lai@quantatw.com>,
	Roger Kan <Roger.Kan@quantatw.com>
Subject: Re: [PATCH v2 0/2] Add Meta (Facebook) SanMiguel BMC (AST2620)
Message-ID: <3256b313-7671-4fda-9949-766906c344a7@lunn.ch>
References: <20260203-sanmiguel_init_dts-v2-0-6a5682c32b38@gmail.com>
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
In-Reply-To: <20260203-sanmiguel_init_dts-v2-0-6a5682c32b38@gmail.com>

On Tue, Feb 03, 2026 at 05:48:13PM +0800, Potin Lai wrote:
> Add Linux device tree entries for Meta (Facebook) SanMiguel specific
> devices connected to the AST2620 BMC SoC.
> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
> Changes in v2:
> - change mac0 phy-mode to rgmii-id

No other change? Was the previous version broken, and never tested? Is
this version broken and not tested? Is the phy-mode ignored, which
suggests something else is broken?

     Andrew

