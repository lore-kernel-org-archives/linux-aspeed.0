Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E64606A326
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Nov 2026 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exKS5AOW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVvcf3cZbz2xqh;
	Fri, 20 Nov 2026 10:21:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795130514;
	cv=none; b=NXN8Ws1AAwOdnaiunXn67CfFMz3jHiVaVMGm79QahXO+uy/ukmu9OBxcQhRFEc43w7+I3QDYotiWQdXge5JcsuS8B5F+tm64uNtXwnOnIimtdIYG6drPTJh2A5+DjUNF1a64G68yEOwb9vY1etLY21N1jXyBPRsZSbivfy89zixHRvdPhGM4PnZd6PWyZFTN7j8umY39fu6v8ebn/9fcKyI9N359wFg30tAXAFPWMiGUHxBVetia9KqXNIJcqLYEh+eGpNepK9ioqTqj1AO1EWkULLCalhi3W+NCuLZn8hlIucvO+JJYqqvazeFwcalPtrBOzHG7sslgOllyu/fNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795130514; c=relaxed/relaxed;
	bh=EGAR8AwNfaaNnY+c/wiFpYuTC+Sl5mX+8pWJKXAFaeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUaEYT/qZxxrmKbLHjHkf2LKnc6jkdls2grtZOZVzwtuslfkHPDm0lvBX0bxsMFU16XGDQHUqC6X0LzUUwdpgl11Wal3m+qs76RTV0oTnOsgKunL6wiAp8wFOfXJQEhBshHNhkwDswcFONiVMQJ/YwPlJSHqf7WOFLsHP1b7BQ4T6AeSeC4QZH4PK/IfAX6JculLaVGvgUXPQmF8VzMS9SMtH1F9jLI1zW877X4uayVx11dpt5GiXwAGs1bUWHIo59BYcjuRzNxkOvCPsRLAuQf9aEn8fUNK7Q60oXqzoFi2cKZKW6k7FxMS0TyNBU2dtIs/gvzHOWTEJUa9kuSdKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exKS5AOW; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exKS5AOW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVvcd1zv6z2xmh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Nov 2026 10:21:53 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8B2EA61107;
	Thu, 19 Nov 2026 23:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1B31F000C4;
	Thu, 19 Nov 2026 23:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795130510;
	bh=EGAR8AwNfaaNnY+c/wiFpYuTC+Sl5mX+8pWJKXAFaeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=exKS5AOWd6cAQi3uKf0M74CRJzeUBwGdpYRoTjlYR7fTPEjOcGC4rXhLCfilnGMOj
	 GbyKnhzg6qW78qHFLa4/ixUSdp5vLI4GUzXd6MiavClaZjFKuf467oG9sF3G3l0hlY
	 CBhaIimtghJ0QNny8wVb/xbPZmBcPbRbG+h4P5/CGhM7rZip08eVsIa5UoQLhMGQsA
	 IKNucTsQGrmQSMTcLb0400X5qWSeKCoyoaPE0nnle+m7Y32qNkeR2QYh2lk1W1zmdF
	 uTcWQw2gZap4gAsBB8JK9G8gOIskT8M4mEXIJUACjZRTuKrcqfH1syxTtOXv4X+0Gd
	 UETr2tmDegMsQ==
Date: Thu, 19 Nov 2026 17:21:46 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org, tbevis@amazon.com,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	linux-arm-kernel@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 2/9] dt-bindings: i3c: Document the AST2700 I3C
 controller
Message-ID: <179513050618.1478011.10339945188286451327.robh@kernel.org>
References: <20261111-b4-i3c-hci-ast2700-v2-0-4d8fff5c5196@aspeedtech.com>
 <20261111-b4-i3c-hci-ast2700-v2-2-4d8fff5c5196@aspeedtech.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-b4-i3c-hci-ast2700-v2-2-4d8fff5c5196@aspeedtech.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 11 Nov 2026 11:16:30 +0800, Billy Tsai wrote:
> The AST2700 I3C controller implements the MIPI I3C HCI programming
> model, extended with an ASPEED in-house control block and a PHY
> programming window advertised through an HCI vendor extended
> capability.
> 
> The controller takes a core clock for PHY timing and two resets,
> named in reset-names as the controller's own reset and its DMA engine
> reset.
> 
> Boards without external I3C pull-up resistors can use the PHY's
> built-in pull-ups instead, selected with bias-pull-up; the achievable
> strength set depends on which pin group backs the bus, since that
> fixes the pin voltage domain. Reuse bias-pull-up (pincfg-node.yaml)
> for the strength in Ohms; it is declared on this node rather than a
> pin-config node since the pull-up switch is part of the I3C PHY, not
> the broader SoC pin control IPs.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> 
> ---
> We considered expressing bias-pull-up's dependency on a pinctrl state
> in the schema, but couldn't find a clean way to say "depends on
> whichever pinctrl-N is active" without hard-coding pinctrl-0
> specifically, which would be wrong in general (a node's active pin
> state doesn't have to sit at index 0). We've added pinctrl-0 to the
> example to illustrate the typical usage instead, without a formal
> schema-level dependency.
> ---
>  .../bindings/i3c/aspeed,ast2700-i3c-hci.yaml       | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


