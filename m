Return-Path: <linux-aspeed+bounces-2153-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548B2CA0FED
	for <linux-aspeed@archiver.kernel.org>; Fri,  5 Sep 2025 08:12:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cJ8Fy5b1tz3bhY;
	Fri,  5 Sep 2025 18:12:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757059926;
	cv=none; b=BF0gKZRj7DrVkcxQa3cfmoNVG4YVWH0sKk6140onJ+NY4rKi+UPjq7uqEV4XSWfiuhrgl1KbNQ2vhgQBH4iaPwXOkfo3l13kRJK5TuFxQRlaLMrEpiZf2yEv1IevvkKEKSZ0vIc1vwk6wIzMryOGX2fLRFORpR5KsgfK+v930jRayw9GG3WbaaNCUsXnsjiGt32i0JD9wDXAHpk9FKkK1DxR0FfhW/o6FWv+jRONpkhHnQ+RdEnZe2BplldIRyJvntVT59ihe2WydDhxOjZhGHTU+7A3f6qPYYV1CCKRvZDIOOpJ4wAgalCktHh0aRfMoHnTXJUljfvzw4Cmqs6dYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757059926; c=relaxed/relaxed;
	bh=LqrJFDIp3Qk8Daspity93aOZRCLtvYxKedurcvKPi2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBcFN8xlUK7dCPC8tf10/qFXlZLmCfh6V4TFcaktCGw6+4EwtvVyrVYvc6iyMHsykJcHyNK8+eOc3LtUVdTcNQVlJvRYUlUEyBLWYBntAcux/sx+5R6S0kPxczFwvHVsNEPw9yNbt8E0ssVxGPtfzCZx87h/BGS4O6tESzQfqTv7LvEI16zqsn69JkJkF2cpbntghsPgEXE7PctMAMT8j6UDcy0fViA7pvsbHTLTzjBiDyA6jqb/SR6D0hTHEE1wv6KFQy7dz5Dg2V8IZCsbMpFkXlzaxlZimSn/KU7+W6u4HOEftCbOmyIeUr9t42LZVfgLI4Re/wF2yJ1duMWfWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rjBIK5wn; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rjBIK5wn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cJ8Fy0Sqcz3bh6;
	Fri,  5 Sep 2025 18:12:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6B513442CA;
	Fri,  5 Sep 2025 08:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0666C4CEF1;
	Fri,  5 Sep 2025 08:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757059923;
	bh=mNHu3Dq59LBMQxbgLxMaQI+8a9Nh6j71J6ILlJhwpkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjBIK5wn6f7pd2b8kgpHsnktswpp0jsDZKR+mzoJkrpRqXsGOQ8Hq09cIY3lkFHJg
	 nzUh8vJeVvCdy9sg3kNocvcU8WKjE48Xzke8Ix1mGA+L6jOujXWlGqEKQiScJzXtiT
	 5hu0HdszSfr9/RVGP78AH7xeJ5J0/kP61EnA1qETBh7gigujUy74ck5aukJnDbbpdo
	 ceEGFRzCva4VFLytCgA8BZFa31Uh77McjxyDjNeh9C9WbrRs7irDuQZ2wO9B2dsW3q
	 R4hHdZ5RcHXuB6vVQasltt21cL+OyQihQpV+b/IXU6ogkDBDmcHSHfmCi11schly5c
	 SSVP5k2l+rypA==
Date: Fri, 5 Sep 2025 10:12:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	linus.walleij@linaro.org, brgl@bgdev.pl, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 0/4] Add pinctrl support for AST2700 SoC
Message-ID: <20250905-rough-notorious-leech-dd7a0d@kuoka>
References: <20250904103401.88287-1-billy_tsai@aspeedtech.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904103401.88287-1-billy_tsai@aspeedtech.com>

On Thu, Sep 04, 2025 at 06:33:57PM +0800, Billy Tsai wrote:
> Document and add the pinctrl driver for AST2700 SoC.
> 
> Changes since v1:
> - Update pinctrl aspeed binding files.

Anything is an update.

Really too vague and some time ago I am sure I complained about this to
Aspeed.

Best regards,
Krzysztof


