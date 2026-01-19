Return-Path: <linux-aspeed+bounces-3396-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43997D29C28
	for <linux-aspeed@archiver.kernel.org>; Mon, 19 Jan 2026 14:21:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvt0x5c33z3bjb;
	Tue, 20 Jan 2026 01:21:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768832465;
	cv=none; b=V/sT9WwXZK9+/flOxHtk8qtqJrX/VgwlqaVPpSDrDtRmUiw7Jx5cCf/rSU4kIfZCuadaWKFVNRFvq63+1luv+MrxJSrX1FNx+T9R8Bh5o69A3NkX8kEMsfoQNETZ/U96FaM8Yc2TZuXvx0GQI6xA8tuxcgPDdBBKxG9Ymuutl19gwg0sHp5rkkgWCfVHjdn9A7UGGp12+/ZHy/5MDCGMwtBl+HaOGNF2X3KGU7M5cEenPxM1a+32O6q+zV+/+UWbi/SIcoRtvFRA7GReES9k/R6ax3sFyASpJbLAi6iksx1u9B2AMUCcTE5TxTonx15I6fwKJejUfYh1AsyJKdgG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768832465; c=relaxed/relaxed;
	bh=c7Ep0GD4eG911kODoOvUPprYM2xLb7geaPpEU8Rcz+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POrzz3NWM8qF2oilAtWEbH/EiJRAbXhouz+9UWjWjeYUcvmLnui01onGSeSTTfPwSfJFs9hERN9Brbb6bL5MN6PGmmlIlCf/awtVHLQgrX28uEFU9k5ZSj/Gv6fm7C6p5egbetHUOVkGF6kt7nc2aX2y7JwZxGtpjV1QxIbdr/Ljb+yFrWybSRAn7/wUpwgkefpwC/Jqw8UfCTkFmHYXZzVy/Q8f0QWeUY9YGhiWW85rPA5/fx6B/ka891tyMoXG3+HlohlQLl+MCs4socYHL3Aj6wOIxl1JzZRXBzilh4LncJ0OQaKJK3r9bkqm2B1hpYx3f0J6vulEOF50CLu1/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=CA3py8ft; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=CA3py8ft;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvt0v0T71z3bf8
	for <linux-aspeed@lists.ozlabs.org>; Tue, 20 Jan 2026 01:21:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c7Ep0GD4eG911kODoOvUPprYM2xLb7geaPpEU8Rcz+g=; b=CA3py8ftIBYki7YqehhBkcUCAE
	Jq7C+1KCwjIrVDFC+GK3VKxuTunuovVb/OOJLH4mvTDrjY9ZYAsq64o/VUCK+zUCJVX18CKCiZgwJ
	nlEuzXZNNYKP51fFNdGzccFRUqUQ3D7Cv9ycIXAkCOtHHRr9Ap3iqOw2o8Cp1r46+4wU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhq7T-003VPQ-Ln; Mon, 19 Jan 2026 15:20:39 +0100
Date: Mon, 19 Jan 2026 15:20:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Jeffery <andrew@aj.id.au>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH 3/5] gpio: aspeed-sgpio: Create llops to handle hardware
 access
Message-ID: <bb5bdcf2-6bd3-49c7-b3e5-210b7f332137@lunn.ch>
References: <20260117-upstream_sgpio-v1-0-850ef3ffb680@aspeedtech.com>
 <20260117-upstream_sgpio-v1-3-850ef3ffb680@aspeedtech.com>
 <55fbb766-12b5-441a-b06c-d807097e5476@lunn.ch>
 <OSQPR06MB725219B6ED261DBB4E8BC33D8B88A@OSQPR06MB7252.apcprd06.prod.outlook.com>
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
In-Reply-To: <OSQPR06MB725219B6ED261DBB4E8BC33D8B88A@OSQPR06MB7252.apcprd06.prod.outlook.com>

> We did consider regmap. However, llops is intended to abstract not only
> register
> 
> access but also layout-specific bit mapping, which is difficult to express
> 
> cleanly with a flat regmap interface.

O.K. I was just thinking, if you can swap to regmap, you could maybe
then go one step further and use gpio_regmap_register(). But if you
have extra logic in here, that will not work.

     Andrew

