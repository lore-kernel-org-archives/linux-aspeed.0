Return-Path: <linux-aspeed+bounces-4493-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918A2C44507
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Jul 2026 09:00:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1kQ66SRzz3c1g;
	Fri, 17 Jul 2026 19:00:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784278814;
	cv=none; b=IDfavlGBcSyowgkpVTGO3w1Mp8L4ukA27SYYHyVSaXLh3/z+SfKjVE0zAsUTdEImUFXnISAxrwazTeJcoND6rv9kqQ7gP6dRVkjcfzOtA1qUO0vO9VplHpHWP1ABc2UTBU7kbQgIPLlYfhRHwRYo5816Kvwae8aFVa8sr1oFvUgXiExls/cRCVVgjbvF8K2rU+gyvWh3DrKPhQzZfodM6pc6o46BCFH+LEOXrhRL9Jn2b60x4eAoK/h3L2FJttsXOMG3pndD3Z/yJiglVQrs5KwdiuoSWg0VfyXegbbd/jMEpZOCJmYhFE1ciUzuAdrZbwZdwxX2QZY9ELbLOH2tjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784278814; c=relaxed/relaxed;
	bh=HdyH+mHN8a2J7OlMEjFJZq3VZYV32+BYv7pNQsjlN00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCCj3ux48ukMbxt6aNGpIOLieKN4tLJSlJA6lxCJIPfz1Zq0VsmJCCsuZ3nrigMfl2Pe+8e1w985Obmm9b7oOfZKfCAHBdEXRyFIm2wciukNLHzKr7sl4AhT5sm6l9R3bqPDbHtvkqFdNYU0rGzLC12V6FELcWLWSulhJVhQ5PEbSeWteaGWQ9ni9OEYUSHex0AdS6k7Ly6VW6DEOekg8iYwjCwyYo3z2ZSFFCqEhhUPZoj//jCDMOHFNsBmudGtTbCQXY95VOTJy/MzrOrTXgVUZEfC5sTzunnDDQQaguKedvYkuz78siDB/cx4/3OCmJy2yIvuYABUprGo7VHwGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=ehmHWhUC; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=ehmHWhUC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
X-Greylist: delayed 2573 seconds by postgrey-1.37 at boromir; Fri, 17 Jul 2026 19:00:14 AEST
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1kQ60ct2z3bxR
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jul 2026 19:00:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=HdyH+mHN8a2J7OlMEjFJZq3VZYV32+BYv7pNQsjlN00=; 
	b=ehmHWhUC43YfLnCGY64zhfR4L6qL2mTGmKkzRDJqIJ8bFUn6kOsN/ySdcXtqp7kLhViBRo7v3dE
	hGuY2ZwGabcpaBtZ4nM2Dh2lPa7HQmPZJHzb351k8M4qHqWVtaPbFq4iexT0zddwYwP7TzvnJ/TLO
	xDrwLJ+YuGYItrq7phyJZtj4ttL2tmvZRzWKm1I9RnzToU1HVC39HhadshyrVq44xdtJse1K/fkzj
	puBpRVteH5z955KPaSm0fsjXZ2auHx2Mozkcgka6KVlBxx8YYmiqfwblHY2S12DUi3jQDxCNDCMr6
	NdNat+wdSXAuzUnDOtGmWTi+G9WC6HCPRA8Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wkdkr-0000000EOC7-0wH2;
	Fri, 17 Jul 2026 16:17:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Jul 2026 18:17:09 +1000
Date: Fri, 17 Jul 2026 18:17:09 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Narasimharao Vadlamudi <ahmisaranrao@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Neal Liu <neal_liu@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	YueHaibing <yuehaibing@huawei.com>, linux-aspeed@lists.ozlabs.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: aspeed: Propagate platform_get_irq() errors
Message-ID: <alnlBV1PwFkfpPfr@gondor.apana.org.au>
References: <20260710110729.224090-1-ahmisaranrao@gmail.com>
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
In-Reply-To: <20260710110729.224090-1-ahmisaranrao@gmail.com>

On Fri, Jul 10, 2026 at 04:37:29PM +0530, Narasimharao Vadlamudi wrote:
> platform_get_irq() returns a positive IRQ number on success and a negative
> error code on failure. aspeed_acry_probe() and aspeed_hace_probe()
> already detect negative returns, but both convert every failure to -ENXIO.
> 
> Return the original error code so callers can handle errors such as
> -EPROBE_DEFER correctly.
> 
> Fixes: 2f1cf4e50c95 ("crypto: aspeed - Add ACRY RSA driver")
> Fixes: 70513e1d6559 ("crypto: aspeed - Fix check for platform_get_irq() errors")
> Signed-off-by: Narasimharao Vadlamudi <ahmisaranrao@gmail.com>
> ---
>  drivers/crypto/aspeed/aspeed-acry.c | 2 +-
>  drivers/crypto/aspeed/aspeed-hace.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

