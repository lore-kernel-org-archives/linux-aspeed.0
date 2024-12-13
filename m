Return-Path: <linux-aspeed+bounces-224-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE41E7717D
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Dec 2024 11:09:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8mmq22zqz3bTJ;
	Fri, 13 Dec 2024 22:08:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734088139;
	cv=none; b=L99zMffRMJJm6USBq3P+kC4pZvrrv0Y3Ac0NUcJ3cIxk9WPsP48zpgc1wxIhXiDbgaybJCqQNywgNOoE8aYSuNpBhGaWXll/sfpjpBQRrzj2Hay0PldCfc6ittouIeWzs4PybyPJoi16sXaRDfEtdFgjDCK7inkhOmvXFMJFfp637LWclBy6xYHzNJHU7VEeGPoCMkMG0OOTkP735eneLhoO/wAZLK5SmPp5PUx3C4xd7nRJOkF43k+J7jqtPx8qOWyzICEyEeqJbQcK8U4Pycmcqw96dqoEJSnhF+Gx5ig/PB0AnO2a7ITTixaqbmA7URuIkgkbK3xR8voqnJFT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734088139; c=relaxed/relaxed;
	bh=Q0PS8MAQEZybHHbs6FZGtMT3Ml/Nc1Pc3JSPi4pTUNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3p/iX8E+YVwPV8lMBMBUP2HuJC3BDN8FmbULbP8WG+6pausxiBRBcQ4cfIk03pkd7DV7UShrxkyk+I0tA6b+OD7tmCeqIsUhDHPFg5+Pm5I1gCcpZvXn/riwzvFqsWXzE/hUGZ8Xa1UWSIATITpnE0kXk1iExvQbH7A5vEPaJBOtlw9fCECH1EnpiD4sWVbzwWpqX0CMhQzbKqzTwV6QRvxp6nIC3iX3UhkTsZdeffFClrgRe9ycjWKyDZQYj5GH235o1skY4EyHixvmS5zzRySVir/WyK60o7Ccwvi7nHYXuqx/Lxs9Shab9cKHZ3xlsSYVWlNfvJdT+0tVArHyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IlcsphOa; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IlcsphOa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8mmp1GRnz30hf
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 22:08:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8ECE3A42ADD;
	Fri, 13 Dec 2024 11:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CD1C4CED0;
	Fri, 13 Dec 2024 11:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734088132;
	bh=Q0PS8MAQEZybHHbs6FZGtMT3Ml/Nc1Pc3JSPi4pTUNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IlcsphOaglpa/Gsl9aKRBly3XeRAr0If8i6t5nFnfRmgB6ceeGeNIGWtVi6G9/Frh
	 XuTUB5aSm5m+KNbzwd8wBa6Uj2Zok1IY/DflaxxbK7gWMc9YZbnDC65ZzHBMcnZQNT
	 qiat+WoiHbJiWvwxOZ2/rDl7VpSz8677MdFJWtxpR/IBNjTNIzHbJc4Og/5TdZRGm8
	 gfrWVUrp7HZMVvX9djfxSw1QuamrtXb35JV2bHlO1mr3ZbGjT+9+ezmAp/Wt7xYjOc
	 K0QoRvQL+Y9ZDrFau8tziqI8fQ3Ml6W5eaFlr5iN/mwgEhPyIBcNvk7N3uUh5yQMsF
	 UTzREiyjFn4tA==
Date: Fri, 13 Dec 2024 12:08:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	eajames@linux.ibm.com, jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, 
	joel@jms.id.au, andrew@codeconstruct.com.au, Delphine_CC_Chiu@wiwynn.com, 
	broonie@kernel.org, peteryin.openbmc@gmail.com, noahwang.wang@outlook.com, 
	naresh.solanki@9elements.com, lukas@wunner.de, jbrunet@baylibre.com, 
	patrick.rudolph@9elements.com, gregkh@linuxfoundation.org, peterz@infradead.org, 
	pbiel7@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v1 3/4] dt-bindings: hwmon: intel,crps185: Add to trivial
Message-ID: <au4mmpxa6tbznu3pcxeu7tri4elvcoyy7l5m5ujdpj7ah3xqrz@ule3ymdiisyj>
References: <20241212214927.3586509-1-ninad@linux.ibm.com>
 <20241212214927.3586509-4-ninad@linux.ibm.com>
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
In-Reply-To: <20241212214927.3586509-4-ninad@linux.ibm.com>

On Thu, Dec 12, 2024 at 03:49:02PM -0600, Ninad Palsule wrote:
> Add INTEL Common Redundant Power Supply Versions crps185 bindings as
> trivial.

becuse they are trivial or you don't care? Some broader context would be
useful here.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


