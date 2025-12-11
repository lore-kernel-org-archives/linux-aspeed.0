Return-Path: <linux-aspeed+bounces-3104-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69956D43343
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Dec 2025 19:57:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dS3KM6W08z2xSZ;
	Fri, 12 Dec 2025 06:57:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765483063;
	cv=none; b=kIxIURagBnfx89lNgixPJh2pWcMlWD5erO+e4stX9Y2DivpLKvMYdZxhZvMmYD3qjyOi+Qt9QIVy+PwTYHuvOqUcw3dWwNjcMD/JtTPuNrMzlWM9ryx+eH1MoVmMsv9lKkQEbUUYge3qO990t3yUAJIbmo7ZOdIuBwHDPpZzlB0Kz5kb3VQSENzv5d96/K21kdZsQY53//nnWv2LTBv9UZWQFpjTOnE2+RevJ6Lf2jgFRiSvrMhQO/hBhiBF6y+SgVWpniseJN8qY1W20BUsK5BcRHI2IkfNPUI0K8rPS8bsaVBJgHd9sFiDpfSSqXhNuJ/Ah+tR91DkWILiTArCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765483063; c=relaxed/relaxed;
	bh=j+E6HtIiDXDhcgqqck/Mu1DHq5XAqT+R6wNgEK+D0s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4K47htRO2zFWbRR8Bjwc4nFl63CZRZuFC0NYEFWWd/VHPbpk26hEOaqMHzrTvkpO5Y8hwFCY+lcKKxHT4WVWZ//m4fPXi4Jz/FC+TY581tRxWnwq6Jh/Dy6y9gPRZwbeqoA4BcES2eS15ulaHTQfEjiNWDqNS2QRBE0PCwNrWm4B7RU1oL9VjHbhjyrh6pmLLKTfXURSqR8mL9ousa4UJ0aqAGEhHt69LpRPL82rU8UEOcHc5xmyfUCNUazOu/eeVHKw49cKzoeDg7PlTvEURloa3D92YdOQcHGVygeCN6qrjydKnjC1PsI9eBsNkSIG3g0uYxwbghavV1u4JuwFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IJwriffR; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IJwriffR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dS3KM2gjyz2x9W;
	Fri, 12 Dec 2025 06:57:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ABF9D40E1B;
	Thu, 11 Dec 2025 19:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D7EC4CEF7;
	Thu, 11 Dec 2025 19:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765483061;
	bh=Io33r65MkdLUI5ebj+eMtKFDPiobvPbUbAdbp66gtmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJwriffR9MxTEwDY8BFqGcfGKTyA9NAJZYyNkQxepc3ukZDkbmlLiKZnUuUg5BdpK
	 +rDsFiU20ettgn8YFwTV59q0fKS8i7z9iiB6wl+9lzfRWDAY/Zuj4Y/Myg+zO3UmsY
	 HS/D5dGWLaGcK0X3un+3iTS7eoW1xKKfXGc9h3rIp/GFfx7Q9KASCQ/D4K+bwv5BiT
	 vvrB5Wstcdhi2i18vI+CBPhTlcSAulgmYvhh4QripX7dKRxdFeZpJJASdUAP+stp7E
	 cwsxoA3FUK02G6cbNXED9jumWAIa3H3gqGjX6KJhTwSD3zJwvuwBIbP9LeRKtv0Ecx
	 QUk3WGja0XMpA==
Date: Thu, 11 Dec 2025 13:57:38 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-hwmon@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH RFC 10/16] dt-bindings: crypto: Document aspeed,ahbc
 property for Aspeed ACRY
Message-ID: <176548305816.1801207.6301308659120970227.robh@kernel.org>
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-10-21b18b9ada77@codeconstruct.com.au>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211-dev-dt-warnings-all-v1-10-21b18b9ada77@codeconstruct.com.au>


On Thu, 11 Dec 2025 17:45:52 +0900, Andrew Jeffery wrote:
> The g6 DTSI already provides the property and the driver errors out if
> the AHB controller's syscon can't be located, so define the property and
> mark it as required.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Applied, thanks!


