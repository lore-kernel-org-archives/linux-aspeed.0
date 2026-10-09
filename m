Return-Path: <linux-aspeed+bounces-5166-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94275CA6012
	for <linux-aspeed@archiver.kernel.org>; Fri,  9 Oct 2026 10:33:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1NVw25j9z2yTH;
	Fri, 09 Oct 2026 21:33:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791542008;
	cv=none; b=ice0UlE68PF1vl98FXlb1DCoykImbRnY4qBjiuFnT9rWOmxAiFYJKS9cCmcORw9PhLtJNr8tN4oFrajtxwunFFnLKgnfEJDfJG7O5HJQjYDagb4FEUhtWLa/W/xIdgmFHq+UNL9OSvA9zO1/b2iqX9LoVyShB5a5JEjcfNkXtrreHaWT85DvmKzDmaEBueu6mayvsdBbDJFxzQgyqnJ19SvXJsrz69q2W2VKfn+WdsSJbGBW2Xz+o7pX2WLmu3WmVIOFZ4mtGToFM0+pETdrmUSZkL+eKFARYcfMBeCeMfXHkdI3Pw/CPT3Iq8Qx0VIZeT5yPH4ky/8fAW7wAdb1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791542008; c=relaxed/relaxed;
	bh=HtCYHP8bkaekZ1veqlqX8aXKZ4Lf0sSj0bK6Dp/TMpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSMyZCLqP+RFzVFL03tunTVBe1dk/Wt8rSYYoNC0AEImRqs+DfljOp9loienpqalQAjJvA3ZD4CSKIWhfJSPctCfQ8T4xWtZ5R3F2GtGaIzu1h5JQa1mHHUyaBmuQ5qflFZW4HbwXanvPvVcFfEA6P0FtjGyY5HZxQ/K431zm1eKOVNEn+jcgHUlegb0RpwwQKL8If13IcxV7l5PIXBfg/3qpjb2m+6VlYYD1Bscol7xuySn9ubmwvFhGSPjI16DtzUyqSjBUDcbriGnmjcp+iSvkRLSMJuPHJP6eMy8Hz7crRnEBzVof+cL3aZ8hA2LecH3K/1gl/HSthj2o4gCFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaUM1kYa; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaUM1kYa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1NVv3Jvrz2y1W
	for <linux-aspeed@lists.ozlabs.org>; Fri, 09 Oct 2026 21:33:27 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7DE4660DBB;
	Fri,  9 Oct 2026 10:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683DE1F000FF;
	Fri,  9 Oct 2026 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791542005;
	bh=HtCYHP8bkaekZ1veqlqX8aXKZ4Lf0sSj0bK6Dp/TMpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WaUM1kYadguyw8AItenfIPKE+2el6/RQ4bJ8E+TYjvKl4Il9CdtIZWShD9/VD3/it
	 9aq9OUbP4tKmDKhdenx9cC6kzeXTgCt9UYIAHBj6J6Ti39TqubXCUVZr4QEx1jpy+H
	 zToPjLf2lBqGro4dxedF+SQG8Eku5lZRo4Fcgf1MCRcIdQAarEQ7GqlR9AwcVqs9I9
	 FawLC9aanhudklh9wqqfnJwTw2Nf81SrEjiD69L+UXoRlcEQmaDJb0DqeTU2M+0RhU
	 uy+RjX84pLmZm7sNntHuNsG6Zd/Z+Id6/WbBTF4sngHLNcVLuMHgaUytAjHDb5l2bO
	 IFvu16Cb/XBpg==
Date: Fri, 9 Oct 2026 12:33:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, linux-aspeed@lists.ozlabs.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] phy: aspeed: Add ASPEED PCIe PHY driver
Message-ID: <20261009-cherry-caribou-of-glamour-adaba4@quoll>
References: <20261008-aspeed_pcie_phy-v1-0-96764937aef0@aspeedtech.com>
 <20261008-aspeed_pcie_phy-v1-2-96764937aef0@aspeedtech.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008-aspeed_pcie_phy-v1-2-96764937aef0@aspeedtech.com>

On Thu, Oct 08, 2026 at 07:28:20PM +0800, Jacky Chou wrote:
> Introduce support for Aspeed PCIe PHY controller available in
> AST2600/2700.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/phy/aspeed/Kconfig           |  12 +-
>  drivers/phy/aspeed/Makefile          |   1 +
>  drivers/phy/aspeed/phy-aspeed-pcie.c | 237 +++++++++++++++++++++++++++++++++++

And unlike 10 previous versions, this wasn't even built!

Best regards,
Krzysztof


