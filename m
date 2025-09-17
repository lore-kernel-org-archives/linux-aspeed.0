Return-Path: <linux-aspeed+bounces-2257-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1E2CAC59D
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 15:12:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRj1S40h1z2yDr;
	Thu, 18 Sep 2025 01:12:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758121948;
	cv=none; b=LIlaaNSV4uE936RHspHwLV18q/UfqeVK8hd1O11x5I6n6X1z/Dx02xfAoNDyVn/Rkp28gn/R9R/NwLJ329nACAzqwW9MMf0MALByjl1wpwG8HllfrIwf+HNEcJwjspaUAX5Al7vwShPFy9uSN5Ci58/wrdCj2APgAINKrjUvt3CUoppD51Z0Rk0o91Zq+tIgRI6VnfYEM6W/0ww1xz7f99Bs2WnOjLlxevZXw9AyJjlXEGV2T6WaM3KVeNH7LM++Ajl0/9N95bBEIhGahV7mcxnfRz4M7Vq40yEs1Ufrn5/9FQu5TFM1RnNDP3yEWQiGLcx92AXdgVpNM0SkUg2hpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758121948; c=relaxed/relaxed;
	bh=SbUH+ytp/I7r/qS0bTCYNaSJzrM2N4H+oZ5XzytcBc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lxj2PjAOdt57DPf8VlsPvJsTelB20ATgmgn0SiUcw6BcnKDmz3qIQkbMqb+wWrTT/sf8g1zn64LUPMgO1HBOBbbEAGRZLTeJXyIYKt8zeghn7fI8ZxU9UybOGsEQ1ETiTePeLWH/BnCBnt/tYO5UAY7CXgPS03CiF/TmG7tOPjqIIGGbF8uUgvIM10JizgA5HC55TMaDoYI8brGo8VjPkent8x7DB1MV5ClHTEp53K+fI90NEMK7P9sW5efDsuowDdVoS7/tbjq5MjftL8gpTB1AZS3DaNYYGsuxZc9sCh2lE/p5BEQK//jkxQPFaZjm3uYXDqcDU9LYVO9aZJ/j9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=GI2hr8NU; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=GI2hr8NU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRj1R4vR1z2xnk
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 01:12:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SbUH+ytp/I7r/qS0bTCYNaSJzrM2N4H+oZ5XzytcBc8=; b=GI2hr8NUA/wBoWosZZr4g/4/8R
	lh/GHsVJEfQBe1JCCzTQcDmOYfx8xG4Lb9qNRvwPqQmVv8MP8Qgy7rc/DDVgKctW/899gLrFqCP/t
	VLGWtcNnnByIsFzV8Ahz0ux9ZpaNZ8sCdyE1SgnOcJj3s0pCJLVe4JZoNmBVJKweRSrM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uytpK-008hZD-5s; Wed, 17 Sep 2025 17:12:10 +0200
Date: Wed, 17 Sep 2025 17:12:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
Message-ID: <9bb9929a-8130-48da-983e-2901a7c3da36@lunn.ch>
References: <20250917074812.4042797-1-kevin.tung.openbmc@gmail.com>
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
In-Reply-To: <20250917074812.4042797-1-kevin.tung.openbmc@gmail.com>

On Wed, Sep 17, 2025 at 03:48:08PM +0800, Kevin Tung wrote:
> Summary:
> Add device tree for the Meta (Facebook) Yosemite5 compute node,
> based on the AST2600 BMC.
> 
> The Yosemite5 platform provides monitoring of voltages, power,
> temperatures, and other critical parameters across the motherboard,
> CXL board, E1.S expansion board, and NIC components. The BMC also
> logs relevant events and performs appropriate system actions in
> response to abnormal conditions.
> 
> Kevin Tung (2):
>   dt-bindings: arm: aspeed: add Meta Yosemite5 board
>   ARM: dts: aspeed: yosemite5: Add Meta Yosemite5 BMC

The threading between your patches are broken? How did you send them?
git send-email? b4 send?

	Andrew

