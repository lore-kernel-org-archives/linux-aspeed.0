Return-Path: <linux-aspeed+bounces-486-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91DEC02180
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Jan 2025 08:45:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY02Z0h6lz30MM;
	Wed, 15 Jan 2025 19:45:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736930758;
	cv=none; b=IzSgr6sxix+tBUBp17kkG/iU2zxUI6Om/H5onAvmZ6NTGTcT4LyR435gT5+G8/ff6FXaagm9uJ0rEDSy5ouvRKwr/Wu8ApY5yfyTNLTTCQhlaF5goFrt23A9ASJC/ARRf5+ssf+X+BbjjJYS/AV6X+jZDJv1Gd93bVJuo65ESsWKciOiVYodeuV/fmFrFx+uPq5WhO2ZsjtVh8J8LbXRbBQXZxShaLmimSUL2KBwRtmkkunk8+cPCG0D+O3G0RG34WBLLw0gTvXq1NIpISywqgpCoSgEKJcjsk2wgEkKIpqZtj0V3Luady6PExgGI7elSbSgkPpY4t2bCQRhUqel1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736930758; c=relaxed/relaxed;
	bh=NZzAaGpNJQnNH4596dN2jZE4+Wk1VnOd5wMlBtov1n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr4k4PsI1WMR1v9EIICj7tvWWlnbAOAQRfmf7yktWan+FAcY8FSf4WpHiebTHD1j08/DQ5gfkrBdOsJNC9bFSuXPpO9syewLVyjPFBCNB6FjJsxXea6cHSFqAQre1S2enNEzisD32r6U3aIx6JjKJrwX1aFI+RdMXl01/ZKbCOCgvA9fCcl3mjsqgl40AWceG4Ps8E9ay5FJGcerNp/w1nj6Ia4JXda32/GcRZ802Y61R6NgCPaCvshxU6jMEWuNK/166BKbZOgKP2KtlSbG3M8zjIMykJqF8DkjFfeXyoorSRi37FTDRU9uxelpNfFdITtoXYQhBGRN2187ekInWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qcxC6SzV; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qcxC6SzV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY02X6DdDz2yq4
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jan 2025 19:45:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A6C7DA4186F;
	Wed, 15 Jan 2025 08:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8FFC4CEDF;
	Wed, 15 Jan 2025 08:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736930753;
	bh=BO+3m4FMfOEG/15U7sR7NT9LJguDOTS3576NIxYCBC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcxC6SzVOVwXLkfQSuzJsVT1MbWuFE4DDr9Lmivl1awzuPTfYhtERml6+ZC1PhY3i
	 E05cAcYI5oEg/VnRWQwfJZhslpuwCsVVI3K3k/uH9xtXZ7yCJf/5xe5/SSeF+o2VHL
	 LGu3WkcCOtQHu6Ri0NKZ3oPHPplPkBr/4CXAebb+bc8YuF3ncvIlHJEwrk9T15/Rjc
	 buCSPyl8nZjxCkJZcNuOjphLNrOctF2hhaPnSO5T0AS34Ii2KHquycjySlvOPxZYLf
	 vDksmIIexXrJtsr0S+gzVQhn15ZIX7Y4OYAJ+S989RAHX80XhDs8Y76x0V8FycvmmZ
	 lK2QqzNmRTNXA==
Date: Wed, 15 Jan 2025 09:45:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, openipmi-developer@lists.sourceforge.net, 
	netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	devicetree@vger.kernel.org, eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing
Message-ID: <mbtwdqpalfr2xkhnjc5c5jcjk4w5brrxmgfeydjj5j2jfze4mj@smyyogplpxss>
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-4-ninad@linux.ibm.com>
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
In-Reply-To: <20250114220147.757075-4-ninad@linux.ibm.com>

On Tue, Jan 14, 2025 at 04:01:37PM -0600, Ninad Palsule wrote:
> Allow parsing GPIO controller children nodes with GPIO hogs.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> index b9afd07a9d24..b9bc4fe4d5a6 100644
> --- a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> @@ -46,6 +46,12 @@ properties:
>      minimum: 12
>      maximum: 232
>  
> +patternProperties:
> +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":

Choose one - suffix or prefix. More popular is suffix.

Best regards,
Krzysztof


