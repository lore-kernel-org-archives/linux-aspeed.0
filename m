Return-Path: <linux-aspeed+bounces-2490-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BF4CCD195
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 06:31:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnw236WQqz3cQx;
	Fri, 17 Oct 2025 17:31:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760682667;
	cv=none; b=Mg9PLSJoFXXM7yGPI3BO6Tl/XFe7HzWQuMz1tCAnaa/fR4+PpBrFZgxm7RFZrIwowRq/eVwoB7n1fu1kw70FykLQJIUuWD1vIJSn/Vd/zuH4ODN25Z1Davd/QQCAXXPukivhX4hSob//M9zGcEfDSS4pGn1UOd8PtgcXxb+zDvioonchdFxE9Nn3n3MSJTW4/wUo9VBfavptRdoGJS8JPze7AYZjgpxw7iwg2xe/jEclX2l3suepDuqUB7sXBSYeGQO/vSmVQ28RPZenQA7WJeh/xd7bef8eycblGa06Gov9d6mC7zjTXpc1WaFIKTC6YRqEqxsORk/rKSOdauxz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760682667; c=relaxed/relaxed;
	bh=R2shE/vXKGK6XxDN3EEo6pLrsf8hO3g7K+H5vR1Pf/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ub+aLzEaRJLGMnMeN/FXpGkyKCX2QpQxHxgQeTWwZE66GHHxQ2fkpyau+6clKvoQdl0iKHLblgw6ecJfqmjJTxuypbERNqPmywu2dWnC3lSBy0ECw4afQMVxIA/S/EdkooyJFfe9uFmiRuKrO8N5U8G/qAILU9OVN4G5fFcdje1cA/2zq8uS39sxcXro19cQDH+2nOlmJwRxJYMaejOxBx/MP8DC+NWiJhnkqqCYCe+h9ixaPojB/SPnqt+3A0o8Mf88I1wIidDj/KabucnqY+nVMrpkihGMLPHQ1s4LZ+4p+v+LlYw0rF3S1mzdpMHL2qWYI/r4crqiS5lyEWi5CQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Dk4+OInX; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Dk4+OInX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnw222DC5z2yhX
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 17:31:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760682665;
	bh=R2shE/vXKGK6XxDN3EEo6pLrsf8hO3g7K+H5vR1Pf/s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Dk4+OInXAebpYC/bzwaUKlZrUu+oraR1IiDv+GhH4Mik82X6l/EHqwhdYdFxD9lS0
	 H+TA+9KK7XG+lWKRHkOfhbhccYhMO/vlmRMGoyECB2cZnr7tHhtXeomcWBWbtuiOzd
	 /I8OiuN/Z/11Xuf4ieP6u3hLXesAtSBQNlYnTerFZxB5pU+gzmRa+x4m8Fii+4QyRk
	 CQGqhD5RtxSG1+dRp0BsXlTX/4hTFZmONsvz2dL/xTMMaVAzPpwQyTDuU7RxSDWoGo
	 L/xyI0U5DRd/uGP52+/BEBWYYTl1v8B+K0pRZfy+HO+O9cCdGeayhbVpTu4QXDnu/9
	 xLwecaSHHTRLA==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 26EAE77272;
	Fri, 17 Oct 2025 14:31:05 +0800 (AWST)
Message-ID: <b63b53521d44c1b765cccd3f9f03d7f778b7984c.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/3] gpio: aspeed: remove the "gpiolib.h" include
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij
	 <linus.walleij@linaro.org>, Joel Stanley <joel@jms.id.au>, Kent Gibson
	 <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Bartosz
 Golaszewski	 <bartosz.golaszewski@linaro.org>
Date: Fri, 17 Oct 2025 17:01:04 +1030
In-Reply-To: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
References: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

On Thu, 2025-10-16 at 11:09 +0200, Bartosz Golaszewski wrote:
> gpiolib.h is a header internal to the GPIO core. Drivers should not
> include them. gpio-aspeed only needs to be able to determine the
> hardware offset of the GPIO given the descriptor. Expose the relevant
> symbol in the consumer header which allows us to stop pulling in the
> private one.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For the series:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

