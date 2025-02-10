Return-Path: <linux-aspeed+bounces-692-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35A4C02198
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Feb 2025 10:29:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ys1693KgPz2ysf;
	Mon, 10 Feb 2025 21:29:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739183377;
	cv=none; b=IjhMQoe7ff9NcJ5K5jm1p3p5Hi31bn0XRUU6lLnWSLf/VXt+sz4GQXTopra+8ZjeNRFNr5C7nGPD+Cu+i/IVpt4xTlsg757lZf1KHK9OaQQnj5CBZwqvRwRR0G8YPueOhhB+jFnyFbOkG8XwAYHfgyolBNiEmIrPVdb9lOX/7L2mXW4fG1rcN8cjjw1N89yURpIMAdPKvGFkHSbfrKEKNW/hUcTDdmV+/KHf0AWrRuju63AJ0WS+RudTTlepPdsF3byZyHgkZpcjRyRJwqB/rbEQwm+NeVjUgrcFcubvq8Xj2eJdxXc7PFigxvUAhD4tkm1c63IQbSc3Thasy2SthQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739183377; c=relaxed/relaxed;
	bh=01lUzP8wdVQFGy/4bYY7OHZm7ouGxZ5M7LAy0u1RmF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Whh4p0xfFET+gRIhz7KFo5sGwz20SOdW0o76FuzyLWkrw1WgaovH0yQn9Gt1hs/3hZG8GuMio7eFU1RH/d76B8NYYSQTDjjuiEwS/kGxQXcjXAqFbMEyMzzY+09xj8JBDIcpVeOvC0PP7dBH0s/IH6377Zljdl2dI/rqkHodWD/FzApttC/ugH06ekL9SGc7+v/qAqlCCVOnYZTmt9P6h+2Gi+o/GzLYeYAqi5UYl5JdPcOqbF2EN4g03uE0e3rZupuV2y5O1tw3kGdbdfAzl93a8YZMwN1tYzJtt90nJxwoIa9cSNLord6tZ5hyl2ar/2wTik+k1B52b7LnLzyiag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JPjhb7as; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JPjhb7as;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ys1686G7Gz2yXY;
	Mon, 10 Feb 2025 21:29:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BA9FBA40F31;
	Mon, 10 Feb 2025 10:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E2CC4CED1;
	Mon, 10 Feb 2025 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739183373;
	bh=33TmnyQ62etwSFwnvL/fzHi+qX4T+4T29KP7HM0RYP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPjhb7asSJnPsUiNzzeMLsh4W0FOdcbrjA2v90FR9nMGG6nTkaHRZuAiGK7YjEjJe
	 I6iUGB6Yo0PtwD1LqSd8aDL2J0j+8j7Tn3PFoCwWvkFXa4Z+vo6GhwbwzqeKNcDaZA
	 I/ReN7ESzLG6sF5Cls6YhjZ7wU9kZRolrxhULHFT5mXmdPMXbncAV/0LEygsJEQ5tQ
	 pqQ0lU/fH9a3UMFbKMxudZyjjZGweRkuAHNJghBZEkcvHBS7WZMLfbnEQTQQXhHCfE
	 3sg2jE7tgeU4aNU+Xw0J9ZX9+ZRxjgsGFoJ3JvYDEQ8HGUGbO2/0v0OR0jlTxNgtil
	 GaIOdG+5MfU0A==
Date: Mon, 10 Feb 2025 11:29:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: eajames@linux.ibm.com, mchehab@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au, 
	linux-media@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] media: dt-bindings: aspeed,video-engine: Convert to
 json schema
Message-ID: <20250210-crow-of-famous-drizzle-a4bb03@krzk-bin>
References: <20250207101458.3757723-1-jammy_huang@aspeedtech.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250207101458.3757723-1-jammy_huang@aspeedtech.com>

On Fri, Feb 07, 2025 at 06:14:58PM +0800, Jammy Huang wrote:
> Convert aspeed-video.txt to yaml format.
> Update aspeed-video.txt to aspeed,video-engine.yaml in MAINTAINER file.
> 
> Additional changes:
> - Two phandle properties, 'aspeed,scu' and 'aspeed,gfx', are added for
>   video engine to capture video from sources other than VGA.

Where is the justification I asked for? I made it even with bold font so
you will notice that this justification is required. Are you adding
these properties because you want new features? If so, that's separate
commit. If not, then what is the real reason of adding them?

> - Update examples and include appropriate file directives to resolve
>   errors identified by `dt_binding_check` and `dtbs_check`.

Examples are not binding, so that's not really needed to mention.

Best regards,
Krzysztof


