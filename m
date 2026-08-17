Return-Path: <linux-aspeed+bounces-4743-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86564C5B572
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Aug 2026 07:51:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNlQh1YcPz2yFK;
	Mon, 17 Aug 2026 17:51:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786953100;
	cv=none; b=VlogNU8ROw42Qmipb44g0DjRcHr/ufMxQHQ3rY0bDXTC9gbj15S0T67qexQraYI2zt3eo2g85cnV7tgjsc6iYP1A9v5PnYVGzLIaTYjRIjdp0XtxYEmyG3J3nbfbIlmZ8Ys78CfK+8i16FLRH0B8xRUw80R6FOF9I8Fby2y+znmpXeqOGDNi0n0d562zUsttvGAXf1/OdXz6EKiyzFxumabo2+FjtDC6iSB+1rePFAEUwTeP7skreWhUn1DWbi1sGtfMjVxuV8iLjPtmynKhr88CvKjF2i0AxzrLu6UDri9v75M4RFUpjrXOd0b8Q+a4bypjSID02Ywqi131wQYwww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786953100; c=relaxed/relaxed;
	bh=5ZYQOAJ6LqVx/y2pX8CakYIeDZQAZDDnBuPRyOAH8pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew9XLH9dVxCQXbWYOF3yYXh/dTuQlKavNAEnahNQBbXXvUb49pxgnPxaMqGV5uf309lKMLkiB6ZkfgCHMrQcsXmh9ietypGxiZ9CG343JyXbAeApvwSJpIXJ7XxczCGn3xO81FPItyg/0+6AGSiA9VlL6rNKzGLyRab8yTrBhIlCETwc9Ic3AmSKAZm/PuvOVwrEpule52JyuzPjN+gnKzRsYaV5NtEf/JYEAWdhUuC2nJYfte4smXzfLH3cKafW99Bicsft3XzrLUadahvLC8yqqyigIzVFc19LHwzX8PwTUyryL8nr5WllljMtj8SD9kykpdauF4TIjtBEqZ+hPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NU90Nc47; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NU90Nc47;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNlQg3SDCz2xy6
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Aug 2026 17:51:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9230960120;
	Mon, 17 Aug 2026 07:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258EA1F000E9;
	Mon, 17 Aug 2026 07:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786953096;
	bh=5ZYQOAJ6LqVx/y2pX8CakYIeDZQAZDDnBuPRyOAH8pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NU90Nc47IvDFoPD8YQ2vm1Bt10nUJvfBqtw/JxNTOLs5Qo4wB9UIk7hEGlbBqyXnL
	 73+ujLyrJY5Q+a97d1uqQ9A0TcickJgoQfLDET/Bb9g8k+iEYG3K2CXYiRgzPTWQFI
	 kidOAkkBOSuGLN96qzuxgeWKD4w3oDAN8j1jwIkXxOn2Olyp7k8YvnCe9YE5o2PQf2
	 m4sh1891AiQScZ9yGUNNxLbo79qSre2ixAV9ukGQsw3PYIh4RtxospXMkbmvtbJWZ/
	 GP8fsuq6jJ8CJLsqf5Sewb766Jbm4k7+WOh3yR7/GRJh9lIyq2wPkPMNSRTx0kJ24D
	 tJgqHFFSiBeTA==
Date: Mon, 17 Aug 2026 09:51:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	Borislav Petkov <bp@suse.de>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/7] dt-bindings: edac: aspeed: Add AST2700 SDRAM EDAC
Message-ID: <20260817-origami-chicken-of-popularity-6f205c@quoll>
References: <20260812-edac-v1-0-03992edea297@aspeedtech.com>
 <20260812-edac-v1-1-03992edea297@aspeedtech.com>
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
In-Reply-To: <20260812-edac-v1-1-03992edea297@aspeedtech.com>

On Wed, Aug 12, 2026 at 01:48:25PM +0800, Ryan Chen wrote:
> Add the "aspeed,ast2700-sdram-edac" compatible and note DDR5 support.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml         | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


