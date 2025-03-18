Return-Path: <linux-aspeed+bounces-1028-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAB6C282EC
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Mar 2025 01:24:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGvJG2x7zz2yVb;
	Tue, 18 Mar 2025 12:24:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742261054;
	cv=none; b=KdYgmXZVDob4ztaGVQK8arlSfwUncw7i0nNfAlC/acUQzgaqBdEgbLgSAzd6Q7WAI6nUzz2fqVaDkc4H1oFzEX6RHZZxAwIydrJaMyoXrkq5TeGb4q9Whqpy5Pv+3U1nCExJvodNLdt+Kf3wvRdUvUXd4zyPhFLU5lMM2/wsAZe7wRLBAsaZ6K09FpmYm4cRZEGryfh0nJC79VgfyH1q490KZSAkXUoBLjFpBdKzGIEEbHaiwRkKwDRA+hLzoJhfc0L96tuxVW/j7WHNLow51s2u4bg3ONrRUVn/Ezau0o5tM2gBf75orv5+nEMOBmfwHIJlN9r43Q9/K2Cqyvh22A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742261054; c=relaxed/relaxed;
	bh=oMfWmktpO5zxS6QrUvvJTFoOQx0wf0RVH1WYkmIBE4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YSBNoZGV1HcdzyATdXax0NW+v9fF8KYnFP9gFIm9Q6JwTuSIqophd6JCG7YM/SwY7lB1iSbzEDYc1O570If+aRoYisJhyR/7seE/9uwvmoClp0DI4Kz/oIjCjceNB1cEj8Nx9nllMf2krYqO8q4uMbLS1Cs3SWz3ScoTHr6mEHiHzpelaovQ/Wkp2mKTC1MuRUjXMeYH0nU6VULY4oKzmWBU2qPLKBWxAUcDvWbBn2KoDY+JEM29GHZVbIWDfjE0bnzBlKH2JsYt0/kmv5xbTWl1GmrQUBUpZjbaM827e65mbMQVmOmlT31J/TChsn7BXQfjQ98uw5RrronNKFffeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=gKheE7nk; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=gKheE7nk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGvJF6DBPz2yN3
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Mar 2025 12:24:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742261053;
	bh=oMfWmktpO5zxS6QrUvvJTFoOQx0wf0RVH1WYkmIBE4w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gKheE7nkHHrYa81pj3sE05H0URAhJNVuDUirz7G+9ICCPCdhtph4aZJ+bosokKi9Z
	 38BoVsdQHhZzBwsuoD3MmJVFlRD71cHhnX8Z3fZaxstOgEAxirPoTYLT8i+QhNkQhW
	 Yyf5WgsJKVSSbGUpL9GeZPjaMe7Xe8TrPjTA0FBZ+hVOID0SFAO8u9LVfyNjCtolxU
	 Wqh6CFADRYZ8JuSzLRdCr+1/T2+4OA9uTPzoqnthTDjC6SSMIzyFULEh2QFl7tCSZf
	 4rFBtF7O3ycxB7HYVwuAY1DSDAiD7LZj1vueJJhp5GxMtJnA68E3yJrIDZlPJocf9A
	 /3R40MSPiHQ4Q==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6291777BB4;
	Tue, 18 Mar 2025 09:24:10 +0800 (AWST)
Message-ID: <2cf6056212d0eaae0946fd374edce1947afed93f.camel@codeconstruct.com.au>
Subject: Re: [PATCH 12/15] gpio: aspeed: use lock guards
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij
 <linus.walleij@linaro.org>, Michael Hennerich
 <michael.hennerich@analog.com>,  Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Mun Yew Tham <mun.yew.tham@intel.com>,
 Joel Stanley <joel@jms.id.au>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 18 Mar 2025 11:54:10 +1030
In-Reply-To: <20250303-gpiochip-set-conversion-v1-12-1d5cceeebf8b@linaro.org>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
	 <20250303-gpiochip-set-conversion-v1-12-1d5cceeebf8b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Mon, 2025-03-03 at 14:18 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Reduce the code complexity by using automatic lock guards with the raw
> spinlock.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Nice!

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

