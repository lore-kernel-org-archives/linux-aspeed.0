Return-Path: <linux-aspeed+bounces-3834-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66447CC6B1D
	for <linux-aspeed@archiver.kernel.org>; Fri,  3 Apr 2026 01:48:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn1p35wnnz2yVP;
	Fri, 03 Apr 2026 12:48:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775180891;
	cv=none; b=RcNdNY50oBt4Of5hUKLfqx9zvUiUpcRX8cFA0BiaHP7aqDCVZ3d38SJ/cdnoL6OGrRybbzkaECS0Qm3kjc6v8ihadBsXvjW5NWM19Qx205nQvdbwW8IlLndzdkdDWkJfEQjVcgZBEKPLQnA0Y+Ngjxby98uSmo2Rz0ERQXjbCbvoOOrW4szb1aPdx+9xFyJ7+8Ig8D0aMdKWqzLjXjCrTU+CVoA8pBRaqOq/wLAaQ38p+TvI7c2TOOU0MZzm958ruYQ56jAQPIpvFILOWyGFCuI92SvZJOiiMsGo0TVdWwhOOL/ou3tZU2elThNzl/57mQAPkKrE6AzGGFR73KA/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775180891; c=relaxed/relaxed;
	bh=+USeSNrd+VSsWq4NWpR8STtSmRmf5rBfxlBSk+ilRjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foQs/rXJRVveII2IOs+LGf008Ue7Gpbk7FohVOEjJR2p7AyDBEIAr/hIoKHXPLWh+EeQWkyT+0BAQ6gxk9+YschyBX9rB/BDWWAJh30scOP5NhT7QkoQLa3fcaZ01hn5UJ0ZTcXSU8mE9KZjEB2bn3aGhFxFAGIBhc461n5dVlQfrjVe89Fvs9QxSMysDOH5zXqKCSP5EDaXjrv2CNTgLDb/gk2ommjSKScKwpo2v2J0d6FfbyzP3CIyYEDFiYUFFfOnNUUKGxaWV8S4EEB9wvJowm4fTqWepW+Hvrtb/sb0AjU8ABbuQpcmS6kpmTfwHirFECY4N9JBqrh4RQ2XPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=AA08h6YE; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=AA08h6YE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
X-Greylist: delayed 2392 seconds by postgrey-1.37 at boromir; Fri, 03 Apr 2026 12:48:09 AEDT
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn1p10Vp5z2xLt
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Apr 2026 12:48:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=+USeSNrd+VSsWq4NWpR8STtSmRmf5rBfxlBSk+ilRjc=; 
	b=AA08h6YEptjPw1421+YEP9vDDsn+1EuiCqm+5zGTK1lJnsyCbFH6dRC6U9wVkitvpmXzxA+8t2w
	DQtagT41wHKDNp7O2/+JWthWqPJTAxTThvmZFRhY321eAcjuflFwbl6NxXb4WElIJuUGbZPuKfuCM
	Ndi77UxTBrmTKU6KlCayvnb9z15qE/x+jptTlwE+/LGurxByoU7YY6efkhzcHwj0h260Ktt41Fibo
	Y846aq+hjxXFM1lbV/A2IqFBjccVdJLRrZQj8f3gf1mylLTSItiAOTmJJZRLcGRbM8O3zxkDgE38C
	ghrlFACL/aK1Hd5ly5W8x2TOa7BfiSW5xNBA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w8SbY-003R2l-08;
	Fri, 03 Apr 2026 09:08:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Apr 2026 09:08:02 +0800
Date: Fri, 3 Apr 2026 09:08:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Neal Liu <neal_liu@aspeedtech.com>,
	"David S. Miller" <davem@davemloft.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: aspeed/hash: Use memcpy_from_sglist() in
 aspeed_ahash_dma_prepare()
Message-ID: <ac8S8jLrZrXg8M-K@gondor.apana.org.au>
References: <20260327092418.10476-1-paul.louvel@bootlin.com>
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
In-Reply-To: <20260327092418.10476-1-paul.louvel@bootlin.com>

On Fri, Mar 27, 2026 at 10:24:18AM +0100, Paul Louvel wrote:
> Replace scatterwalk_map_and_copy() with memcpy_from_sglist() in
> aspeed_ahash_dma_prepare(). The latter provides a simpler interface
> without requiring a direction parameter, making the code easier to
> read and less error-prone.
> 
> No functional change intended.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
> ---
>  drivers/crypto/aspeed/aspeed-hace-hash.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

