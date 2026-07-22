Return-Path: <linux-aspeed+bounces-4516-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54209C44512
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 06:06:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4kKD5YfXz2y1F;
	Wed, 22 Jul 2026 16:06:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784700384;
	cv=none; b=Jv1MhMcyy/NzfQKQNgMH1kGDzC/YJAyRjSXnbGFpJqcmF3ySx26bUSQ62BYjmjZwXETzVU9Iqkan+8uNAqPXag/ZCs23FdeZQLj01wa1p/eVuopNS65eD1anz1znx+xBPk0asDBCY0NC0ZU/pUG+X6XceevEh3pEthiCL4w6kWLjp8FQjHGUv/jhEsFM+orOaKFoyQd6FOArsxZ4n8/QOsxJR1J3UdxGRGCcsSe4DOBMA8CQDEnipuEp2wF00/LGQ58m+1GS+3Lcfqvi+62IbbLpFaP54mMSCu4gKNHQ6wYmRfduEjdqbyjNnrfrFI2bQas0ne17vWEf01B/KlDSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784700384; c=relaxed/relaxed;
	bh=LN5bdwWceuskaNKmyJkWqtdrVJQGUEM8o5+xyiQlKUE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U8eM3ND0iCOLPJd74JZrnu5EKEqHHl3o5aXYy+D1uCfqvDuYJd7gvoto47UMSdO8cQOH7GvM5E0GzoChtaHocYe3rUukQBwdG1UEIFeMi9+0fPukCVzABc7dPM1ZZFNIQsTwipzOT3xNqdnmt6dYmaUkx/aeNt+pJMnj46xKEpZ6uqhvC0qZiAlLjoGaMsug/X2qD7W3vc9wjLnTMEBY7DoC5/5cUoUCRqUdS2SBXEU1Ell56ReDU+Fh6JiHKTHZf0QThiOwWCx4urbuDMZaYfuxtWBfPE4cXX7mL/jE2tu3rbjHnRMn4Irv+DWIfADR3ZYpV5AADyHaTpuGurS1ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RH3Pfm2f; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RH3Pfm2f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4kKD1xH9z2xJT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 16:06:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784700383;
	bh=LN5bdwWceuskaNKmyJkWqtdrVJQGUEM8o5+xyiQlKUE=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=RH3Pfm2fKMvYCi7wJbahzfRlko43ftqoQEk7VlGj5uI97BRLC7omAXn6tYMryEH1z
	 +9YxADvc3Rw8JoKyX6PHnFhZGNg/zLqvcOmZKFigkDRfd5MlKdCwQirswoMq7TRGg8
	 CkyDXwobBElM6JqKynoJfIaCE6r1S2l5MPHuAb/BNn3zMnbHoG22tNyKvr3sh2cQLW
	 oiUnVSU5aJWVGWPFZ5Xa9OQzddsFDThBMzJVqjlYFI3U7xEzJbq/LxZV+kZ4Z2wSWe
	 zuaP0Ed/qliw0w1XxQWSpHGQPNaebEPgQ7aNG4oVhwJND7Ud6o8pRAOqY/eE73f3JV
	 Lxkqt/cdqL+lw==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 954F265B37;
	Wed, 22 Jul 2026 14:06:22 +0800 (AWST)
Message-ID: <7ce703b95521b11a2ddf978d23466a5acc65ce9d.camel@codeconstruct.com.au>
Subject: Re: [PATCH 03/12] crypto: aspeed - Remove redundant dev_err()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Pan Chuang <panchuang@vivo.com>, Neal Liu <neal_liu@aspeedtech.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
 <davem@davemloft.net>, Joel Stanley	 <joel@jms.id.au>, "moderated
 list:ASPEED CRYPTO DRIVER"	 <linux-aspeed@lists.ozlabs.org>, "open
 list:CRYPTO API"	 <linux-crypto@vger.kernel.org>, "moderated
 list:ARM/ASPEED MACHINE SUPPORT"	 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Date: Wed, 22 Jul 2026 15:36:22 +0930
In-Reply-To: <20260717080045.191538-4-panchuang@vivo.com>
References: <20260717080045.191538-1-panchuang@vivo.com>
	 <20260717080045.191538-4-panchuang@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Fri, 2026-07-17 at 16:00 +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
>=20
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

