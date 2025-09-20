Return-Path: <linux-aspeed+bounces-2298-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5E6CAC5A5
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Sep 2025 12:59:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cTTwT6FRwz2ytg;
	Sat, 20 Sep 2025 22:59:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758373161;
	cv=none; b=MLOirZxXb2ok64YbYUOLglQx+lqv0DiJlldJ+EiAS+YvsnSyTvPbeUwgTWZyBfHaNbmBF6KX78bwDEEihCcXcAhbprjIphjBGO1hrlvyC5Z6fzTibXItWHDP7LkrmobxFgH3b66BU1umGwq7eIQFu9hB7iiivrVEJow0mwbAWTKrFnwJT50sTpMMk2Kke0mK7HkzU0ZQ0a+XVvVmV6n2yAn27xkHFlOainK4QaHAHmIJH/EGgowoAa1AlNpe57ohkR8M3GpV5e/Pkm0LESxuZAiO/Pyl5baSO4QhqAtym7NXZvqjYBhaYW/yvCMXcbrmFOvmN44foFZM5CKunxKEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758373161; c=relaxed/relaxed;
	bh=Gihya9xP0fAcqsxzSzES+1BCfKN/8rEUF3BTdeplS64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qnh/5KO1WZsDONhUFlMUbsEMacOLZQyaPJqyVzv7rGtLmnVcExTy9OADwqzAGoWtqsu7A44dosK/2srveQD3CfqYPlN20iSUYoLvM1CV0hQ1s0yVL/etegQEjgz8yP+uaavWc4BVqmdGnc8HMbkkEdUVcVpDUpG7CT6Q3hCOipx80xl1IqDCznNgfEZGgqRdpzgblmW74hxridiYGLc9XUguV9DZOG+Gy0Ginazz+UF1fEUzP/oqG81rOrlleCATAQNAOOU6mkUwXXxLoyiXC4DcxzKHpZ6skKastnbbXEoQaY67avvWINaYTNfFfRmC08of7xZLEMWs4x3w4DFohA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=mlutS17W; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=mlutS17W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
X-Greylist: delayed 2079 seconds by postgrey-1.37 at boromir; Sat, 20 Sep 2025 22:59:19 AEST
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cTTwR6JbFz2xgX
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Sep 2025 22:59:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:cc:to:subject:message-id:date:from:reply-to;
	bh=Gihya9xP0fAcqsxzSzES+1BCfKN/8rEUF3BTdeplS64=; b=mlutS17W7yGIqhdfi1idO6nGob
	czgsUB/fZ/9YSk0UXQNqq2kkv6rrIBIbqoFGHs5FsN70xtSIbNBx4wpbkLK34OGTcxKdk39f2ZHt4
	I/YFgc7KbUiJquNnJ5TO2teOt+hJGjAlDyvf6/0hKgQ0ES451eXDCw1/EfS5KQgz9/YGtocmNPrH2
	7Dy+NDITl0wVWEzhBdtLULqvyBoJ8WFuHOGxm5rccB0mMeydzP1ERdViZeOIcUcmsNniDLdG7Oue7
	3QRyu6ikDglunhBZt8ewIthuWYaULvRwph5QTKoTRhkpph1kXabfGyYmg/fiZSK4VwW/DwqHeWn4N
	q2b9FAyA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uzwdc-00704n-0p;
	Sat, 20 Sep 2025 20:24:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 20 Sep 2025 20:24:24 +0800
Date: Sat, 20 Sep 2025 20:24:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Neal Liu <neal_liu@aspeedtech.com>,
	"David S. Miller" <davem@davemloft.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Johnny Huang <johnny_huang@aspeedtech.com>,
	Dhananjay Phadke <dphadke@linux.microsoft.com>,
	linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: aspeed - Fix dma_unmap_sg() direction
Message-ID: <aM6c-LsUNPN3CJ3m@gondor.apana.org.au>
References: <20250910082232.16723-3-fourier.thomas@gmail.com>
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
In-Reply-To: <20250910082232.16723-3-fourier.thomas@gmail.com>

On Wed, Sep 10, 2025 at 10:22:31AM +0200, Thomas Fourier wrote:
> It seems like everywhere in this file, when the request is not
> bidirectionala, req->src is mapped with DMA_TO_DEVICE and req->dst is
> mapped with DMA_FROM_DEVICE.
> 
> Fixes: 62f58b1637b7 ("crypto: aspeed - add HACE crypto driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
> v1->v2:
>   - fix confusion between dst and src in commit message 
> 
>  drivers/crypto/aspeed/aspeed-hace-crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

