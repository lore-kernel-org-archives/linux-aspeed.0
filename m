Return-Path: <linux-aspeed+bounces-547-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5F7C02182
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Jan 2025 22:17:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YfFfy4wmJz2xC3;
	Fri, 24 Jan 2025 09:17:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737670634;
	cv=none; b=l0N1RrMKNfmNHYUw/YMVtETdBxF/ZtUyjFonV3j6tT0LutJfe8HRHyEcUb8LWrgHYZf8RhiSxwgUaSd4uc4ImhvqBDq5iYi7AYbrNbIACvDvl3/f/ZftxK43lsmJuZHh7tRaKgy5npdW5qt8kjBU/oo/5/FhzX9GFsucVusIQKATeVhRbLsFVLjzYg/ZISTw5kJIF7OuDh5mhwt1Vuu2jxDzAGIKVK9Y+ZD9P4u7Yc3k3huvGwm3oJG/KzO43lYOkCnKKnh0bSB2hci8eDh4XWkCWmxBAwUdOLjuAMrkGM4DyvK/Ch2IgPvz/uvObaU15ItJipkHh/foF4QAEbtDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737670634; c=relaxed/relaxed;
	bh=Oq5Svr+0mkoExl6RExPJDLf8AuUnGZxC8idcmofzQaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxhdaBCZ9nXOvPBIBkNJk8g7WqieYQsniI3tpYl2ZuY7AFqiIGvddkqnqIrvPXQ89zI/XEw70pn5slbtL97ksGuK8y+tY46Ts5PAMORclg/F3djegKvxDMarqZ3rWQQsHtQRsyqh4WQzoo7+2RxPdYDB9S8hatv3E4GsHN9gWKXGkRbmaKkNBnqljMxZDfaUGFKcx3urwbSS9IimxrtMhBASEX0dxGJ1W+UMF7xL2bua7DNlpR9jimtV40gR9Iac+cHx/oeP+hPpnRNuQLTM6K7uR8FLZVRY8QY/7WvUP+kClbqmrxbnAJRppn0M4Bafq2SLtFm2Dh61bNLMqlNjsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N4R4wPYq; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N4R4wPYq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YfFfy0Dlqz2xBk
	for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Jan 2025 09:17:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7570E5C54F0;
	Thu, 23 Jan 2025 22:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA96C4CED3;
	Thu, 23 Jan 2025 22:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737670631;
	bh=pcG2D2/E0u37nyJWQeA42BhrzuRLXs0n2hWP0puC9mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4R4wPYqGTTiYnldH6jl4hR7pTwLxm1N71v7m5eehLbDNhx+4mJyeyqxiR4pFwI0h
	 BzRQ3n+ZUAgEwvc/4Y5lI7iZ+ncK5tubXKO7UKpRdK4bKBQm9EudmHDLsJXh5EwPOa
	 QjSuiqxT0/Hetex3f6MmQggKiggCAIBtUlqvdcDSscMT/Lve8uS38Wyg3GRSfyr6cD
	 bDZj4PoYC7S8FKd/BwB0XJ+jxpy83STlru5dq0DXwLPPRZFgUURvm70nA/IWJBegL3
	 WGwaeSntD53ucCbC2AqECdcEAHJftzwl/qu33tBvVmrOD/yqI95kMCNF4K3CKWszYS
	 C7GaiHLKajSaA==
Date: Thu, 23 Jan 2025 16:17:10 -0600
From: Rob Herring <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: minyard@acm.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing
Message-ID: <20250123221710.GA448645-robh@kernel.org>
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-4-ninad@linux.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116203527.2102742-4-ninad@linux.ibm.com>

On Thu, Jan 16, 2025 at 02:35:18PM -0600, Ninad Palsule wrote:
> Allow parsing GPIO controller children nodes with GPIO hogs.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> index b9afd07a9d24..0497d19a60e9 100644
> --- a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> @@ -46,6 +46,12 @@ properties:
>      minimum: 12
>      maximum: 232
>  
> +patternProperties:
> +  "^(.+-hog(-[0-9]+)?)$":

This can be further simplified to: "-hog(-[0-9]+)?$"

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


BTW, no need to ping. You can check the status of binding patches in 
patchwork[1].

Rob

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/list/

