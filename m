Return-Path: <linux-aspeed+bounces-4762-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E832C5DF85
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Aug 2026 06:56:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQZ3j5Mv3z2xJJ;
	Thu, 20 Aug 2026 16:56:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2605:2700:0:5::4713:9cab"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787208993;
	cv=none; b=PCpayp0JSpwVhWOTkhLN4olFMMcHUWY6qnQMw8+DqkgqvxCG+A5KOpCGN2RCPBXVM47zEITfIBecIL6QBn/TUIyb5ADUT44Jebm2KzI9uQLs2yv9Upx3FnsytzX8mpunKZTJ/YWlbuXa78a9sA30eR5y/Rssl3wt2lN8Y0B5vgJ/IuulrHsCPZKqm37Y8qhP1nst4tS3XnStRB4ESRG+hDn7SPm4dtqV8W47SZndmavYA4+pri1VWAz9gvvalvcJdrs/kmQfPouxp89T6Piqpao8HS5jIXo+ejKMvAN2LGPkubewDIWEkRn9TGKR9CjYf7bX7Reu9FaKPQsG06HCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787208993; c=relaxed/relaxed;
	bh=I74YV/Xs1pfjL3V9TczIEk6MvDZlUesCUofNYEE2VhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtHA2PgbKsljHEVpNuMccztqr2xRDjnj/c4eidG8o5G5wSAtHyFlrpSz5nDSYTRiTC0N1oDA1Sdfm/fh6EoXeCo6/Vbd7dTE+/iN8lC8DMeUx0iYztGEHX2mJYKcl4fI7jIfVmjg3Uf9ptvBrERPyJtCyGh96UUA4OvuEiu82WbaKYr1P3+1W/6AjtjbmyfqrpyiEy7vbqHdO+D30lLMdakRdqU77MOGGJ9Q1dZ6CYUuf9gef2bRGCbQqK/lB+MW3ySX1d/prDjt9/Y6wo218SkKLnW63vJrNkpXfu22r82KtLqL1gPf+BCczvaWjwWAhH651ScipZeRuJdMAHnADg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; dkim=pass (1024-bit key; unprotected) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.a=rsa-sha256 header.s=thorn header.b=HPqWC3k/; dkim-atps=neutral; spf=pass (client-ip=2605:2700:0:5::4713:9cab; helo=thorn.bewilderbeest.net; envelope-from=zev@bewilderbeest.net; receiver=lists.ozlabs.org) smtp.mailfrom=bewilderbeest.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.a=rsa-sha256 header.s=thorn header.b=HPqWC3k/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bewilderbeest.net (client-ip=2605:2700:0:5::4713:9cab; helo=thorn.bewilderbeest.net; envelope-from=zev@bewilderbeest.net; receiver=lists.ozlabs.org)
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQZ3f6d2tz2xGZ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Aug 2026 16:56:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1787208981;
	bh=I74YV/Xs1pfjL3V9TczIEk6MvDZlUesCUofNYEE2VhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HPqWC3k/NUJ4eKfZGmfOlQIUzNo1DZ3fzyENBJpQpVyh0bFNQPUqY9nqiazcyQohs
	 u+b9hnzxRuDqXlLUrUBI0XYImuAFtjNhBO+QBI0xJkjx/XVO/MFsfFV+hpCbdfUohg
	 Uh5yQ3TTQV0pZz4bMIZh87dIqB/4y/1qN0T1/qaE=
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:71d1:5c00::171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 78B814C;
	Wed, 19 Aug 2026 23:56:21 -0700 (PDT)
Date: Wed, 19 Aug 2026 23:56:20 -0700
From: Zev Weiss <zev@bewilderbeest.net>
To: Tan Siewert <tan@siewert.io>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] ARM: dts: aspeed: ASRock Rack X470D4U BMC support
Message-ID: <34c111a5-657f-46e2-b963-9876e123f43e@hatter.bewilderbeest.net>
References: <20260816-ts-x470d4u-v4-0-cd08e78287ec@siewert.io>
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
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260816-ts-x470d4u-v4-0-cd08e78287ec@siewert.io>

On Sun, Aug 16, 2026 at 04:05:48AM PDT, Tan Siewert wrote:
>This series adds support for the BMC of the ASRock Rack X470D4U mainboard,
>which uses an ASPEED AST2500.
>
>The mainboard exists in three known flavors, the "normal" X470D4U, the
>X470D4U2-2T (with 2x10G RJ45) and the X470D4U2/1N1 (an ODM version with
>2x1G RJ45 that is now available in retail). The 1N1 version also has a 64MB
>BMC SPI by default, but they are all swappable.
>
>There are two device trees, one that has all the config and uses a 32MB
>flash layout, and another one called "data64" (similar to facebook-fuji)
>that uses the 64MB flash layout.
>
>Please note that this board has been fully reverse-engineered.
>
>Thanks,
>Tan
>
>Signed-off-by: Tan Siewert <tan@siewert.io>

Reviewed-by: Zev Weiss <zev@bewilderbeest.net>


Zev


