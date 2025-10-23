Return-Path: <linux-aspeed+bounces-2575-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC69ECCD193
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Oct 2025 05:00:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4csYkW1x5Gz2xpn;
	Thu, 23 Oct 2025 16:00:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761195619;
	cv=none; b=PDf1W4JjVCSk4o/iCZHj2NokwNRb0jX8dXGhK0TiO/amONZS/g3L9Qgh2FYeM8pOevaoiY6dEJWzW1zHc5VV424NoixrFsQSGL+3mTn5opBbrLrl2B9AlcfWxKpnjoL6xhQw64lFwlSatDeClphH3kRkCI3zMw4amUgWbpnhISG8/cQ5Uer2x6ACP0LGAvEuBtRJlaXBQpT2Cmr2spkjVuYl05W+YFXhQ4DmxDmVt/B4w2pyfuTM2KHwlHFT9ygkrPJNLTXmZ1Xabz3NydHFLr/Pwt2kfOtE61b/sJZcWrhDP9cRUQQnPzNTUS+8XwoRnEfR8/BEA63t+nuz1Npt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761195619; c=relaxed/relaxed;
	bh=rF34TyMXjGlqnz4VoV+LRea+gcOnSTSfnchR0MLkbZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfZ36OtGcm0oEoYSetMA9H/wwxzvfhipL+IGb7CWQHdig2uedwEQO0g165HEh0xWbeh+d9AwPiTeAv7/vLF25uhD1XBHKMays/09ZocCn1SzZJTCQMbibH79thukwCJftlmRcnnCwcQbvsZZu8j7F/KGY0rY1x+SOueeZCjnRNhTTpd0aW12Forp7voBWiWe2edYwYYHNLa8BQm17ozgWDIGoyNdkYsFdJNjpr4OhUh7XePm5gbOUYmrTYkEALkvo/dUBBPPF5ToOR/Bg9vKMs4vY0IeRltJ3daqDTpyLVtyGZMstJZmnOK5xDYg8Dlb/isoCrMM021iga5TitOOaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=EsA98BBU; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=EsA98BBU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4csYkS6Yx6z2xS9
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Oct 2025 16:00:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=rF34TyMXjGlqnz4VoV+LRea+gcOnSTSfnchR0MLkbZU=; 
	b=EsA98BBUcYgv90WePfYVkp5iIZthfKbwWg4eggacbq4SONi8muRl+YN9cltdyaMsUCQFz3jPol+
	pUvs7UBgJTm7cP59uCeX0R9wqsbW7lErcPvdDGfLeqv6HY7/YizAQ93zSqD44H6lN/aGillTp8eYd
	/frAHlzZYM2jbV5PSE+1JGJUKVWMpSSw5EEsswH3uK7mQzCaS+YWROb2+ORckfbbhSxq0w8kq/tAQ
	qYZG8PdNpz8vOvqFapaoAS6c5o7D4MQILJu41yJbChb3EfeIdnTUmYxvoxsNKnO1vrvo4vrPn4OfH
	/4wEe+7SCUm5FQmrEz8Xj1DWqls8gRo/thGQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vBnQc-00EsHx-0p;
	Thu, 23 Oct 2025 12:59:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Oct 2025 12:59:58 +0800
Date: Thu, 23 Oct 2025 12:59:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: neal_liu@aspeedtech.com, davem@davemloft.net, joel@jms.id.au,
	andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: aspeed - fix double free caused by devm
Message-ID: <aPm2Tql4npKIokVY@gondor.apana.org.au>
References: <20251020101109.1030-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20251020101109.1030-1-vulab@iscas.ac.cn>

On Mon, Oct 20, 2025 at 06:11:09PM +0800, Haotian Zhang wrote:
> The clock obtained via devm_clk_get_enabled() is automatically managed
> by devres and will be disabled and freed on driver detach. Manually
> calling clk_disable_unprepare() in error path and remove function
> causes double free.
> 
> Remove the manual clock cleanup in both aspeed_acry_probe()'s error
> path and aspeed_acry_remove().
> 
> Fixes: 2f1cf4e50c95 ("crypto: aspeed - Add ACRY RSA driver")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/crypto/aspeed/aspeed-acry.c | 2 --
>  1 file changed, 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

