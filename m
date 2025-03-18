Return-Path: <linux-aspeed+bounces-1029-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CE7C282EC
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Mar 2025 01:25:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGvKJ3cVHz2yVb;
	Tue, 18 Mar 2025 12:25:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742261108;
	cv=none; b=hJLRcTkvwHXXWPOrXSQ6jxzuHbeHX42y590OtD4gSjWRsQeoUDskPgnPv1RwwwJnW/m2hoH34ioV2KWjtIa4g0Wfd2f2HUzDHxkE4W9ub1IpT0rfIYQlBxtN0sUunxkYKS5OfWjTwJqA0p1huPAbzFndR9DWdAV4XFH7xR0o5CCPcuvUnmnDUrerKBdGOxz6yPMHIGGRdkhsbz3tabPNAl28yTtF8bYlFU1gXlPkVZT/tmXe8Osow4lSyBrWJjN/YZFJDuO00byeutAia9q8W+b9lZXsmm1DxxH28qvhfd3I7gFTq3EhrzADOxJYfzEh+8hMdJdPfyx6egUOBcLc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742261108; c=relaxed/relaxed;
	bh=lPmp4bTaoMgGyxKWDl4hyootOO3DyrJbTpPjEsI959o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wt0GVDX+NAIo7zlcIhkvP0oDiuSI7GHY7P+Ew6h5wjSiQh47SIdcnZP7kpPreStgvQ26R77rwNq+lK1EjO0MHqMSq6ujUfhWs8FzKgceO+YGdaYx1vLcedarhP8gJQD+C3kKeZWBXQ7NTmDPpl/OSWgbhAIhD1NBY4JyDobYdJBtX+FlG7YYFG/4D6+uQHnHgKyN9TrKD73T9Iesd2kk8odqgSe7UgVyyGbvt/tJ4nTbjTknlpwm+keMCLMKxiNaBsVa0i80slvrrvLkzgVD68G1nTfea+mVfvEzVf1n4k3T2h/soc+9mzSiEpP0fczDupz5t5cHklMXqsWuIr2mLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bsNvKS6Q; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bsNvKS6Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGvKJ0FxPz2yN3
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Mar 2025 12:25:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742261107;
	bh=lPmp4bTaoMgGyxKWDl4hyootOO3DyrJbTpPjEsI959o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bsNvKS6QD1044iBQatImnxqfM2ryIpayU6Xlej8mBkjEwgHgFdo+R6oFz2U3tP30t
	 Bcq37i1W6QRUC4qYCJqm3SVWHFzrXv/q5burE+CtCXaD0oILvyJgA4DT3mg9z8cIXB
	 Ejdt6SDdKdHeh7JkehZp/FtXZ5lW4CerqNRvXKCAGH1xXj0xZxL3rAMDwzcpkzM0Zm
	 mlCY8Y4FL66Rc9H0ydXLFPJG72PZvR80ZZoTsVMLdgckIU379emKNfAmY5lqhx5FNP
	 ZFgHLFwUS4MzKEKwVBIIeo839By+lfegH9Fx0XXzh6H9zhlTd6zl70ujcF5lCfVrwn
	 ESvNiLxQitVcg==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DA1937A5D1;
	Tue, 18 Mar 2025 09:25:06 +0800 (AWST)
Message-ID: <bbc06c8cfd3ccd1847ec309f0fe4af80649720d4.camel@codeconstruct.com.au>
Subject: Re: [PATCH 13/15] gpio: aspeed: use new line value setter callbacks
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
Date: Tue, 18 Mar 2025 11:55:06 +1030
In-Reply-To: <20250303-gpiochip-set-conversion-v1-13-1d5cceeebf8b@linaro.org>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
	 <20250303-gpiochip-set-conversion-v1-13-1d5cceeebf8b@linaro.org>
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
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

