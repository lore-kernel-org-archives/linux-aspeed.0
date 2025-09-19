Return-Path: <linux-aspeed+bounces-2288-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ECACA1013
	for <linux-aspeed@archiver.kernel.org>; Fri, 19 Sep 2025 01:39:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSZtt3d6Kz30Qk;
	Fri, 19 Sep 2025 11:39:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758245990;
	cv=none; b=R7RlOOTX7tqZJFtlwV8kIroPIgW/MFD36vfRgS/KPVJm+8GQkVGzA8WGBQYEcUpl4arnUDJluPHnJjqyIv3uQZIMkhLtzqEtKuanPy9U54VCRnmO5HSkcrxtJe7PtO5Yeodem8FtS5SwRckHobyHW0uiRYi+8S98pfE7cCXgzuQqEbk43IZlhV+Tc//PJwSfar1VOAFZK/0qadkX1CirSMCstZ/ZMIEjpLO6VFOzL43FOLgeZwzxQjwYKgh7io+w5A93ewfy5lAwl6LoAFF5nHioLToSI2/QEAMJVova7wCS2nAGQE/xVSKqwclWpJ3+EZkaKFekOOnhHHgDTIldYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758245990; c=relaxed/relaxed;
	bh=vHqNzBq4yeNhZ0HdWOZVEemDdiXukRj8SR6GX9nPKJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DE9IAZ48Xt+YOyoTWUY+mwnyQHM6ouUwqmNXSXZIpmcW0sOzJbhhDf+gRu75jS4j3b7e5uvSTAMxM4Y/CCDl4V+KjgjDg21g483ZJcjrhGlp7AtUn8rZZJFYJAWin97lWbhpLMlmcIxGnypGrYKPWo9w8JAaWuyWvbhlzo42l/IHzsokPg9bir+Q7vm6rRS3ONpRMylFY9ln0mZg3kGK2zt5m76uoNNqJTEtTGqreRKdfiaOcay9r3Fe8tbQLu0M1KsFsK0jmgT+tOqBcTLQA/QicYwRzIzP5NIR8HgEx4aJyiYkR21celXjNxgrnLjX+w/218Z2jOD3rVIaeG3+aQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=vLbyscUK; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=vLbyscUK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSZtq5Dl2z30QJ
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Sep 2025 11:39:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vHqNzBq4yeNhZ0HdWOZVEemDdiXukRj8SR6GX9nPKJU=; b=vLbyscUKRqRX26JCm76EeKpREM
	IjUcX2kfnSBg/N2JDRUTKr4bnjXdSlMLnBBaabwO73++LyvhvAw+dmiZhNlxpPGUIVGWbw8YITdhy
	zMt72x83bup2sW3J0Cm/BAXnyvOHWy6U2pe8OBgw6Y+o33H4Ky9g/hcYyFKgs435gFTs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzQ5w-008tPH-6h; Fri, 19 Sep 2025 03:39:28 +0200
Date: Fri, 19 Sep 2025 03:39:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marc Olberding <molberding@nvidia.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dts: aspeed: Add a dts for the nvidia msx4 hpm
Message-ID: <ebf28e23-1ee1-456c-8cfd-ee5c02effeeb@lunn.ch>
References: <20250918-msx1_devicetree-v1-0-18dc07e02118@nvidia.com>
 <20250918-msx1_devicetree-v1-2-18dc07e02118@nvidia.com>
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
In-Reply-To: <20250918-msx1_devicetree-v1-2-18dc07e02118@nvidia.com>

> +// bootloader takes care of proper mac delays for now.
> +// phy-mode is here to prevent breakage once the aspeed
> +// mac driver is fixed.
> +&mac0 {
> +	phy-mode = "rgmii-id";

Just for my understanding, by "bootloader takes care of proper mac
delays for now" you mean you have a 'hacked' bootloader which no
longer adds delays, unlike the stock aspeed bootloader which does add
delays? Because otherwise, i don't see how rgmii-id will work.

> +	phy-handle = <&ethphy3>;
> +	max-speed = <1000>;

RGMII cannot do more than 1G, so max-speed is pointless.

	Andrew

