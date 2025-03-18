Return-Path: <linux-aspeed+bounces-1031-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC18BC282EC
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Mar 2025 01:27:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGvN71Rcvz2yVb;
	Tue, 18 Mar 2025 12:27:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742261255;
	cv=none; b=BivIcL1mef9LjqjpjSMIfwDZfy5KD3k3aWZuHEsEpcpEtNH1VYYij0+qirCs+kuuxh5GuI89lMKBDUW5aA2XBV6JKTQJ7OAKHWtlKb3USsKf9yeNkNtztiGRfWdg/Zg4PIb7G3ujKJXEqEb5QnXB90iEkMb/n9PzoRyeGAlG3IhRS/6rceVATDS/s2RI6m5DVxxvMOn02wczqsxGi92Hn1xuImjDanqrxnfqk/lsaIXBc2kpTO4dQrgRival6e0ya+9K7SgfT9kBkC0JfQ9bE0L/+KnqQkoYaDUxWDrboFM5RZsPXvGBl0NHamgWV1MibXsAupM8wp2RQQdKHgZzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742261255; c=relaxed/relaxed;
	bh=lPmp4bTaoMgGyxKWDl4hyootOO3DyrJbTpPjEsI959o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A27+3cEE8vaHsb7Yg3iYNMEXIGJvwzLjIy56CkHmjV35PHwvGDjeLEo5hUD/SSuNYq88MTFO5lNDf3U0yMH9gm1oXovvBQygESWVz2cJhRbZR04LGhKsTI7tWX9tannVkoZpOIlnUGG/DyFbJTjkjS9E9ef3ZzV8qE55fyEEjFO3B0MGiQ9nP6HqcNfCNlgVM21/VvNzOYKOptmsnh1YpoTMKErcuGAhkuzwPTU2nyLHdAzJqoyuk01IQnRnfOfTI5OwMOmsAQIicq1jPiLeXH0+7l581xjka5lf8WaQ00aROlJv82Vbx4gnY4FWBhP01W0apMJQE1MrvnO23JgZww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=MQWYmk8T; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=MQWYmk8T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGvN65V7Jz2yN3
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Mar 2025 12:27:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742261254;
	bh=lPmp4bTaoMgGyxKWDl4hyootOO3DyrJbTpPjEsI959o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MQWYmk8TcQXao5iPuOHm2Zq43lqT1nc6k8aJyHOAOo+sXf9VN+kI/vmVrUw5RSa7d
	 KvsGQu8yN7QRfG1FxY95hlna5/EgKwrNLPKgsTWoNkTjz8qwafWIR8ezrvstFUE60J
	 aLR0rKR5FTbQ2K/k3bjTOCkbxAgEOum5VzvjFppbmGxmf7BCRwXLGSpFhB64KsZejS
	 X8ftTyvDt8mtHEHAtjbEWInsnJwCJC9uWlhUWC0ML3u+wTjghbynsrEBkmqonjmMrB
	 bTvn0Epz445EkXjvyKYZDj/Bm+nKkJhL1c5vh6WyUl14Wrw6HidfYlpWzxOLfSdW66
	 2LEOz+VgXTp0Q==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9D1227A5D7;
	Tue, 18 Mar 2025 09:27:33 +0800 (AWST)
Message-ID: <91090eae4f8f4843139ba0a0baf9215965cd44d6.camel@codeconstruct.com.au>
Subject: Re: [PATCH 15/15] gpio: aspeed-sgpio: use new line value setter
 callbacks
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
Date: Tue, 18 Mar 2025 11:57:33 +1030
In-Reply-To: <20250303-gpiochip-set-conversion-v1-15-1d5cceeebf8b@linaro.org>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
	 <20250303-gpiochip-set-conversion-v1-15-1d5cceeebf8b@linaro.org>
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

