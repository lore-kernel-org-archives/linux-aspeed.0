Return-Path: <linux-aspeed+bounces-3826-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A5810F9307
	for <linux-aspeed@archiver.kernel.org>; Tue, 31 Mar 2026 23:35:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flky31tGKz2yVt;
	Wed, 01 Apr 2026 10:35:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775000139;
	cv=none; b=NrzGZLa8ooAIdUFM36klyrSEUZ2d0BheeC9dSIQ/zGSn8WsXGGBUqdwA46lePUxIB4htaYzyTGZRsLX9DfzZ65mBrHQ4UEMQWbDAJQwmoyoccv1DDTxP/3deNpP7+FGZjXyjyB51R+FV3vFcq7UoRV9h8dY/f2IdH3WKRvgOip2YKITw/AAeiixfxslF1GgSV+h20ZIA/PHjQf9EjXoiiDujZV8JaZtBHGZXUwZ4DpGCSNVmlCHj2cnO7Kcq9/NpJRwHQhvR+QlYJy6HWvRi3TVKT7H4nGlVDdjiEjMVwSVjuCDXpMQEDge49F2++46tDtwDjvHZTgSU5Xh4xwKwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775000139; c=relaxed/relaxed;
	bh=HVS8vnwDDp67iG/gjIG0ZPUsJ3Y7Nryk4cO6gyrgH3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKWtm5fUg6hOyGNQbglhxkZ1hAgpM1AlOCrjNRXxqQ//qBXtbdQCG76pXyR3B1WDcMXmxZyZnSFcbeThKGW19aI6XUGtNWy1q2mUWlT3wnJJ9r9zMu6o9kRysFc2x5UMemyFmAtvNlFpLV63BoAGzvAjbzM+w9buHPgCbY6xvp3o64NpELO/YWADz7sONKTV3ialefq40thwuoESZ76LGqkyAZ5AL6NZjZFjaCGRho6qIG8PPgW9bIiBO1WOaESvlrJccrP0GJaJBTsJz6NYWTvCLMs9t18ts07dStnXgJgU0SNTkFebS2bYiz8XViVgtJO2EZjOTrYyPrXKaZrhxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=AN8sx1Qj; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=AN8sx1Qj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flky12c9Qz2yVT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 01 Apr 2026 10:35:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HVS8vnwDDp67iG/gjIG0ZPUsJ3Y7Nryk4cO6gyrgH3o=; b=AN8sx1QjM5M3zl1AAI2+qM9R0h
	xAB/+4IuhBDvVwyAKmk410FBG0H1Nat2S7mFTBxvzyutBnf+EuyCJIbegiitKb9lJqWmB60CfVCku
	GRbY0RUs1BeNYhCGQ1fOvHxwZ621eAT2WAGUmIAIBrGWxVQ2Lc1oMWFDUDzySHSIbcfQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7ic9-00EG6P-To; Wed, 01 Apr 2026 01:35:17 +0200
Date: Wed, 1 Apr 2026 01:35:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: aspeed: Enable networking for Asus Kommando
 IPMI Card
Message-ID: <95d6ae8e-6832-468b-9e04-dae1337a87f7@lunn.ch>
References: <20260331-asus-kommando-networking-v2-1-f7d72ae5d40d@gmail.com>
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
In-Reply-To: <20260331-asus-kommando-networking-v2-1-f7d72ae5d40d@gmail.com>

On Tue, Mar 31, 2026 at 09:18:00AM -0500, Anirudh Srinivasan wrote:
> Adds the DT nodes needed for ethernet support for Asus Kommando, with
> phy mode set to rgmii-id.
> 
> When this DT was originally added, the phy mode was set to rgmii (which
> was incorrect). It was suggested to remove networking support from the
> DT till the Aspeed networking driver was patched so that the correct phy
> mode could be used.
> 
> The discussion in [1] mentions that u-boot was inserting clk delays that
> weren't needed, which resulted in needing to set the phy mode in linux
> to rgmii incorrectly. The solution suggested there was to patch u-boot to
> no longer insert these clk delays and use rgmii-id as the phy mode for
> any future DTs added to linux.
> 
> This DT was tested (on the OpenBMC u-boot fork [2]) with a u-boot DT
> modified to insert clk delays of 0 (instead of patching u-boot itself).
> [3] adds a u-boot DT for this device (without networking) and describes
> how to patch it to add networking support. If this patched DT is used,
> then networking works with rgmii-id phy mode in both u-boot and linux.
> 
> [1] https://lore.kernel.org/linux-aspeed/ef88bb50-9f2c-458d-a7e5-dc5ecb9c777a@lunn.ch/
> [2] https://github.com/openbmc/u-boot/tree/v2019.04-aspeed-openbmc
> [3] https://lore.kernel.org/openbmc/20260328-asus-kommando-v2-1-2a656f8cd314@gmail.com/
> 
> Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>

Thanks for the updated commit message.

Is anybody trying to get the changes in the forked version upstream?
It seems like a reasonable way to solve the problem, at least for new
boards.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

