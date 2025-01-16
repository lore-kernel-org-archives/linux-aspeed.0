Return-Path: <linux-aspeed+bounces-502-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B010DC02188
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 14:48:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYm2J1VQhz3bhD;
	Fri, 17 Jan 2025 01:48:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737038904;
	cv=none; b=CdQ9ciacp6DyAtA/Dk6fUX6Rs2Py9oOPSmYLP5Bwup6D/9Q/CzIcQ3QTPBWX6t3lSiTOyptNGcARQaHSf7LuNfYm0i6Z5ZrfrWdNhFsFQ5Uz1F4CtWsE1XnVJLKyb6OyiCsLS6EWIN2IVEqjDeU/7844+RwLbB+MItNFnQZ8XJ90iEUhQNs5QQ++AaGZ5yfFHK6e8uSf5jFTyatiY/6rIrfLbX4CRkqVx0Ek1O19zC1m5zECrQHZqQLKpNf+kYhFaP3HNWt635nb2lAYpA2rJtFJfR0rzRxkB2kdBpHuQgzd2CBvjMl+AHKC1JJWEWOWEdAOChFGi/QIYhrgc4QJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737038904; c=relaxed/relaxed;
	bh=fmEL6EhwrC/4U5BAdktF8uXgQAj2y987DowdjfdUmV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDy1i/Wcydmwm43DqQa5UfV0DqOIi66waBI7ggBdRIM4B9Y9CVaigCQHxoPkHr97MID6h1tlQEVN3na/2IbBkaszPPZob+Vt0WUCG2KTPuMyzvrFvsYvUUz/B39B/IAI67K9FRzMd3NZQG8vbEZpWS5WteQRLZDBG1yPuLIKCHxaHoPUKm57aQWDkB114B8J/hmxgpAHahEQGIxzNBhYBy5FaG7T5yQ3CRP370bAzxjJd/C9igTusJy3k5aU2h+QUFwbp27Qt9YrXCUpmQdcDzrbGvXbhPhHjxEDUG8WmRaq+z3HbdgsfKa6mjJSSGcKsClZ8hYduRyVnkZykk0yMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I7gWuPjY; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I7gWuPjY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYm2H2Y3nz2ypP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 01:48:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 18251A41E7C;
	Thu, 16 Jan 2025 14:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C87C4AF09;
	Thu, 16 Jan 2025 14:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737038900;
	bh=kS1K6s9fmeCJ57o2iulNzC774Qqxf86e2tf+WDO/RDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7gWuPjYUDO+/EWctbZWV+AMVHKrCywMDcLItASnzieeMyQY3J5pRyoxlE3HB4JBv
	 yqOxikmYUw658NzU0t5IdPAVxOdMjUzyPTMkyR3BEh/NgyrIdQwT7QElDKGXkaVQ/l
	 1sk0ws2PzulzxViYIwEPQFGG5u+wRF6RaHJqK97MZ1H5su57RFSmKNXNCqtDbTj77F
	 3ccvynueLKPCLuhWyriHbX490mHK9SbDYVNl8ZzuU2EODvhujjW1PPy7e1wAiQREP3
	 p/VgwPuvt2vzwj15L8xSTjKWg3GhMJ5UPRqUHJ3OHo50SMi5uI7IaoEmpkvuBA9yLd
	 fctRPjnDoInQQ==
Date: Thu, 16 Jan 2025 08:48:19 -0600
From: Rob Herring <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, minyard@acm.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
	netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing
Message-ID: <20250116144819.GA2270032-robh@kernel.org>
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-4-ninad@linux.ibm.com>
 <mbtwdqpalfr2xkhnjc5c5jcjk4w5brrxmgfeydjj5j2jfze4mj@smyyogplpxss>
 <20250115142457.GA3859772-robh@kernel.org>
 <a164ab0e-1cdf-427e-bfb7-f5614be5b0fa@linux.ibm.com>
 <oezohwamtm47adreexlgan6t76cdhpjitog52yjek3bkr44yks@oojstup2uqkb>
 <10c06fec-b721-4a7f-b105-c3c4c8358a47@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10c06fec-b721-4a7f-b105-c3c4c8358a47@linux.ibm.com>

On Thu, Jan 16, 2025 at 08:19:25AM -0600, Ninad Palsule wrote:
>    Hi  Krzysztof,
> 
>    On 1/16/25 04:38, Krzysztof Kozlowski wrote:
> 
> On Wed, Jan 15, 2025 at 03:53:38PM -0600, Ninad Palsule wrote:
> 
> +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
> 
> Choose one - suffix or prefix. More popular is suffix.
> 
> I was about to say that, but this matches what gpio-hog.yaml defines.
> Why we did both, I don't remember. We could probably eliminate
> 'hog-[0-9]+' as that doesn't appear to be used much.
> 
> Long term, I want to make all gpio controllers reference a gpio
> controller schema and put the hog stuff there. Then we have the node
> names defined in 1 place.
> 
> Which one of the following are you suggesting?
> 
> "^(.+-hog(-[0-9]+)?)$"
> 
> This. The second part of pattern.
> 
> I'll send a patch for dtschema to drop the prefix version.
> 
>    Thanks. Also thanks for the other patch. It helped a lot.

Please fix your mail client to properly quote replies

Rob

