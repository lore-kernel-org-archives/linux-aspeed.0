Return-Path: <linux-aspeed+bounces-1667-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D384BC8303C
	for <linux-aspeed@archiver.kernel.org>; Tue,  8 Jul 2025 07:50:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbtYq33qmz30gC;
	Tue,  8 Jul 2025 17:50:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751961007;
	cv=none; b=j9CMT/+IkAdpBxvZER42txLjcNm2mojg1P/Bk7yKOyZKVnTOZJkk1mY7AFnYWvCIhuPKylMk2vH7H2VN3kFrK1sdBcgJBP/EO0IWYdZPfN7Ex13MKmPwEpJe6lsnWIAcbvICjJ5ouU1TQ5A9wvSioFTIcIKPMCfXHGN8iqJSKr8jmwVA+6LNoiTXNz8Yk9LRQxpV6WKmPiXkWZccsNyM9Uvc8sVQh+ph3MxUWoVppmreFftSqJKeLRqcpUk3aa7Kd+iwWEslvjo9Q99bEGG0gw1JX2cF+T56yK62UUNpucFFDNfNIEUi9pM1xWcLTE/aaoCLYr7pg5LTxjGkZmH2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751961007; c=relaxed/relaxed;
	bh=jx9mdXP3XTnYGREHZQM7KH3I/4ZOVb5wZj75Qk9B47Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBuqEYgA8YrD6UUsxKbyl2O16nJEPV3TzubfqwdtbsMszr6rYvDEkM9oA0azXxwIoQHon6SUe8orJmo7xpCl4aKzUUvpc7MIvynQGmMMxQkmJRx6sAfKfK9X7Oc0ZDGtw9H2IEFxHh9VqH7wPH0dW8aA9V9mTt8SVq1zmai7eVAdUmdbF6EkLwgBlMfxC/66dExM0PrNC5KSxBjss71+Zsmv6zFbR9JGkNH8m5R/j5DZmtcPfsDpocXTvc+4Ct+ZqNOlAjdIZBPNQGwkgCnbSSJfLWXXWcEBh0uRdwcqZVappR8TnN+ZUOK2Yh91DijrK4G7qETpWuol66QWUOPEpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SDdV7w3t; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SDdV7w3t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbtYp5smqz30Wn
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Jul 2025 17:50:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8ED8B5C60FF;
	Tue,  8 Jul 2025 07:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B661EC4CEED;
	Tue,  8 Jul 2025 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751961003;
	bh=XacCg/pWwY0SSi8ng2IgCqBPKaxCukK1XmMQWs135yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDdV7w3twz3NWsBoHo6KNql/vvPCHZe3XbFqCc1ZOPS8Ueze9S97eLF+LJh7Xe88/
	 3JM75pI782wgmDYJ6BUEhIbgtUp2/7xbZPw3K9180EAEt89kPIAeEcqJv8B1ze6WVZ
	 q/LoKNeeV4eb3zEH9eVKQf+fuHAb1P8dHjdapDqTJpfNsE/hs3tllMfu328o9PJTsJ
	 UgUS4CdDif74FHqsWC9S0xvJyg9dCjAMIowJHwLThkDmtp3cI9eV1rtUsnd4gFCpN6
	 UTRtHpvg0QGJ5yOBfYQKPgPr8jxAGJIZHurW1j1ZpA7PdlYPiMyKKov/pOJde+LbXW
	 aY2KQ9fu3FQBQ==
Date: Tue, 8 Jul 2025 09:50:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, horms@kernel.org, 
	jacob.e.keller@intel.com, u.kleine-koenig@baylibre.com, hkallweit1@gmail.com, 
	BMC-SW@aspeedtech.com
Subject: Re: [net-next v3 1/4] dt-bindings: net: ftgmac100: Add resets
 property
Message-ID: <20250708-termite-of-legal-imagination-826a9d@krzk-bin>
References: <20250708065544.201896-1-jacky_chou@aspeedtech.com>
 <20250708065544.201896-2-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20250708065544.201896-2-jacky_chou@aspeedtech.com>

On Tue, Jul 08, 2025 at 02:55:41PM +0800, Jacky Chou wrote:
> Add optional resets property for Aspeed SoCs to reset the MAC and

s/Aspeed SoCs/Aspeed AST2600 SoCs/

> RGMII/RMII.

... because ? It was missing? Incomplete? You changed hardware?

Make the commits useful, explain WHY you are doing, not repeating WHAT
you are doing. What is obvious from the diff. You already got this
feedback with other patches.

> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml       | 23 ++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index 55d6a8379025..a2e7d439074a 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Faraday Technology FTGMAC100 gigabit ethernet controller
>  
> -allOf:
> -  - $ref: ethernet-controller.yaml#
> -
>  maintainers:
>    - Po-Yu Chuang <ratbert@faraday-tech.com>
>  
> @@ -35,6 +32,11 @@ properties:
>        - description: MAC IP clock
>        - description: RMII RCLK gate for AST2500/2600
>  
> +  resets:
> +    maxItems: 1
> +    description:
> +      Optional reset control for the MAC controller

Drop description, redundant and obvious form the schema. It cannot be a
reset for anything else than MAC controller, because this is the MAC
controller. It cannot be "non optional" because schema says it is
optional.

Write concise and USEFUL descriptions/commit messages, not just
something to satisfy line/patch count.

Best regards,
Krzysztof


