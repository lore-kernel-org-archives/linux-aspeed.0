Return-Path: <linux-aspeed+bounces-4339-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FA2C43458
	for <linux-aspeed@archiver.kernel.org>; Fri,  3 Jul 2026 09:52:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs8Dy6p7Jz2xdb;
	Fri, 03 Jul 2026 19:52:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783072354;
	cv=none; b=Af0n/EiqjhHZSY5f+TciKMpDy+cDUxTfEgy8EE3cdvdJeCFfGTkX0Ikqjhu5r0JVmc42TaZj1iUe9Zqgg2gw/W48edI5oDRSFN04/9G+rPAfSUICPRbwtAnm3tVgn8v08iVGy3PnjRYdRPGRJXb29ujygM0OHaLoT5mcxyyl8YPUggDqok2FHth52oen4NI6Ps2TARxV7VOAleoItuQQBW5f7wYEuIxZKhI3ovPHhICtCFM9oVNNQHJdvGDcRx20EqhyoWAwZwZBRGowVSxpXAGn3ZjpTn0gzlHwpItlBPH2dU5T4RAnr4inO4+mxCwSixkEl++5bUqzA8Z7O+4c/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783072354; c=relaxed/relaxed;
	bh=GKEsNOedviw9g/4cQlmclfv8VVYF3FHxpuZoJOIlKeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7LhHGslvVKGTOrQbAsFeYrfdUc2WUFvAatydVHs02Ct9VEHmjM0JkZicDr4doa5QyJBuQpvxWST5WTxtBDeifMjTEuqEquPY2wmTXTHwBm2EOP8MqLmAbPecjIeu7zw4cpRqfgBIZDt8J0sXvqyKwYkN2Dovxd3But5lWMGBj5iYesLYHu2tA+QcYedKMqECxgAttB9nwTnYtwTUYI5T/XnEreGVp4qkoK6QBW9QxeBSgUCXELDyodOXkp8pLPG8yFZOVeNwja4XgpCZCir/ULkd3R09hM9ftTP7NGm6gLq2yVRRR6dMeN5qCqWnflpXqcYX3fS6+kaHSVZFfijww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xcv7NoB9; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xcv7NoB9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs8Dy29Zvz2xPb
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 19:52:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 79F1543C74;
	Fri,  3 Jul 2026 09:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E3F1F000E9;
	Fri,  3 Jul 2026 09:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783072352;
	bh=GKEsNOedviw9g/4cQlmclfv8VVYF3FHxpuZoJOIlKeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xcv7NoB9dWDICdJH7Zmx1qdxndTSrCEdI5rFcOUWYAeyLCTvqi7Bh2XZLgBb7VAqs
	 loylffvgv5wbLH/csdbg/lZ2dLeOWGi1MnY/p6y6PEuboKaEifao0IaXfkpE36seh4
	 4l/CkYblQwGC6PyXsvXHVqn0rnYWIsgnbDQ0UZYwxKqP9CsQQMBs5bDG+WXMF6rVrx
	 S6hcecZD8fgXaBOy/ahwWrorBeYT8SwOA+svrqIwlUE01VSIqPwaDyPQWjZtIxw2Iz
	 qVEgZbXZ9WaN7UHXq+AeCOS1VJe9jCe/A05VA92F1b7uA5vF0NXNBzSytOzbjMm/yr
	 p+5knsIq9hJkA==
Date: Fri, 3 Jul 2026 11:52:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Huang <jackyhuang@nvidia.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: Add NVIDIA VR-NVL BMC
Message-ID: <20260703-prodigious-coyote-of-culture-11ddcb@quoll>
References: <20260702165524.2168091-1-jackyhuang@nvidia.com>
 <20260702165524.2168091-2-jackyhuang@nvidia.com>
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
In-Reply-To: <20260702165524.2168091-2-jackyhuang@nvidia.com>

On Fri, Jul 03, 2026 at 01:55:23AM +0900, Jacky Huang wrote:
> Add NVIDIA's VR-NVL BMC board compatible.
> 
> Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


