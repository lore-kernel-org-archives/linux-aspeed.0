Return-Path: <linux-aspeed+bounces-3225-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA481E784BE
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:51:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dffMJ2zfLz2yFc;
	Mon, 29 Dec 2025 12:51:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766505594;
	cv=none; b=DEKGKwmOrE01cHCKrmK+2jdbfF69CmpDrE//u0a/gk+AOJ+KRfMR2OGtsq1R4mAbKtuVfsWwOOfhmfaQrhYmnL/Gv2uyusV68AqwqbOWskwMHdGohixdg397MrVDZlmPr8Epgxjey48MTn5x5uFbJxPoIRQOFGoNjiDkEycndDx9YD9kNxQhnZ0N/nQ2vUSVdQV17xh0A/y2FvzPqeHZdwMWTX/B4UaTr8adTww+vtuG9J47qe+9Vh87utZix0HPOO8rsKqvCwQj6WydpAQxJb/zHnOS9tpfU3g0Xeo9xftj4fPIzqqkZWUV11gK41j1+CooUW6UjgfbldBRfvq42w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766505594; c=relaxed/relaxed;
	bh=t5mJaz6KAlyzeBK3jbtp9RwB6XmiK/tWRemlbfO1E9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeNDttzTD67Ym8k3+rz9PZBaHtvwQyxPA/pmFxxDdjjOM1LIbyhR6LH6ugcOLZppnsXwqhharGXX5hOgLBkw+fSA125/5FiLU7XJiGBugCcxEFr42yii5L+y3pm7Er0KXZVXzVcFu7KbvaHLPTAcIUs+dwyteHK5Nn0DphT/OWT4BNftS07L5VEpJYd78oIm3xMf89xhsU2TqC4sZGTfzCZFCueN0bxT6uKgv80qDXSx1z3TYnZaySuWaC+R6N33+dd0SHva0vcQH6glStnOeooNSvakDoEySIF+mgGw4ew3yCigHwMI5wht40rTATfLcQznLqXSJdR61RZnGmPvFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UeDI8oUb; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UeDI8oUb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbKTP3ljTz2xLR;
	Wed, 24 Dec 2025 02:59:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A760F415EA;
	Tue, 23 Dec 2025 15:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66062C113D0;
	Tue, 23 Dec 2025 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766505561;
	bh=FbWzgepLOv260NOsYwp6cw6dEnGFg6D/tQJ2zegwDW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UeDI8oUbunx4UBfNA6d7KG5fyjjI9KmunMraw0Wx9LS4Hp16nLeZZBz8kyIj52oUv
	 9uRuyPnv20E20eYGmaepK4E7hP/ltzOo6PshS9Z0Dh8yZjmxIzUN8d68qs4Y5FB6ge
	 Zo+5vkJwIxesmQ56/duA4lb4JqSm7FFcHyOxdkLNsHjnhAvhYjqFFUeI3bQuTuR9sL
	 6WA8iJPckwmgiYiynonJ8g3Pb8ONVPP5B0L7ezwkZ2UYiOxDuGAfjV+Eec2asCYsSP
	 rlqz5MfZzR8AJHivVawcVr7LwfVLNerplK5SK43XjEeA16sT09SmSdaJFLylwvGwSw
	 +wThtapcDsxgQ==
Date: Tue, 23 Dec 2025 21:29:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v7 7/7] MAINTAINERS: Add ASPEED PCIe RC driver
Message-ID: <kbads4vnfjf2ce6sks7bvjmhpt73fmvdmrikxwp7y6wjw3flse@5yer3aegbfo6>
References: <20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com>
 <20251216-upstream_pcie_rc-v7-7-4aeb0f53c4ce@aspeedtech.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251216-upstream_pcie_rc-v7-7-4aeb0f53c4ce@aspeedtech.com>

On Tue, Dec 16, 2025 at 09:50:06AM +0800, Jacky Chou wrote:
> Add maintainer for ASPEED PCIe RC driver.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aff3e162180d..c327ea375746 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3900,6 +3900,18 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/aspeed,video-engine.yaml
>  F:	drivers/media/platform/aspeed/
>  
> +ASPEED PCIE CONTROLLER DRIVER
> +M:	Jacky Chou <jacky_chou@aspeedtech.com>
> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> +L:	linux-pci@vger.kernel.org
> +L:	linux-phy@lists.infradead.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
> +F:	Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml
> +F:	drivers/pci/controller/pcie-aspeed.c
> +F:	drivers/phy/aspeed/Kconfig
> +F:	drivers/phy/aspeed/pcie-phy-aspeed.c

PHY drivers and binding belong to a separate entry. So I've removed these while
applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

