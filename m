Return-Path: <linux-aspeed+bounces-4464-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9D2C43458
	for <linux-aspeed@archiver.kernel.org>; Mon, 13 Jul 2026 07:08:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzD7S554Yz2yVv;
	Mon, 13 Jul 2026 17:08:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783926532;
	cv=none; b=jSNgoliBs4xI0Xw5nD7mK1cL4nbf0qMw8mfru+Dwe/cDwcFcxMTw4dddSsMjEetflhO/p5WUoFPpNvB/3aOX1Di2dM/JkVOH3NIOR/my+TeXWx5QnqZig42w94NRGhmjpLLiBATL4h1EHzH6Vpt0ENBf+rub/kFk53GaqMKzLV7ge+QiSvTHyZQ2SM6sHmCSym4qjVvFHFw9lqmB7oPNBRS0PAawU765dfyQ8o0lL/QkkPs2dx1jRDVYqvst0c5toe95EpKbllEPASudJYVZf+9Vv7Ayb2v/lCupefNauAaa7cHyZeCAwThALWUmFBKBhvwj/NjgyrWbJ6YEGvGmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783926532; c=relaxed/relaxed;
	bh=McdvidCR7TQEjAKv3Qut/R/RNS5+oe9QxMO4j5MP8sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVyRQT4oWfNHy7ePtNQv1xn6phSesP05PCC5c7glMjMvES5+t84iRk1fLKUUzI2Jnw9WAkqOTC6trwZgtJEFEt5INydkA0RRiLp7Uw01T+fg1g5SBqmL5O+tX8dtZ6jd8fIMQ77H/Q8xDCOLXqSZyicDCgo+T+dcKyNp5/i1ODJ4gZar6VYk380FTEmacjPTNu04by5hArUYTTHhrFykn5xxAWXZEIVEx76ByHQn5A5gxFLl7HvSl8R4O+bp0pn3zsLbgbhHSIghuJi4kYAoi5pgGqlbccre7OKqdquv5DedkdxcT5L9CsX1M4nGBNyu4De4x1MgAolfc+npI8/ivA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpWanYjG; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpWanYjG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzD7S0Y1Cz2xqM;
	Mon, 13 Jul 2026 17:08:51 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C695F43A01;
	Mon, 13 Jul 2026 07:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FAC1F00A3A;
	Mon, 13 Jul 2026 07:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783926529;
	bh=McdvidCR7TQEjAKv3Qut/R/RNS5+oe9QxMO4j5MP8sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LpWanYjGj8VyzgBqDaEEHyFNlminBsoo33C+aS6o4//ty4qE+Mw+mropG2qLwcBtb
	 07XPwGYCbnU1DWk2ewh/xriCEKiEoku6Qn/a8chJLayYh773QQ0Yq9HkED36R7M1eZ
	 KuCZokrNQrzH2dW9D0deUOu3gBuGBsVYqVXZkmJ9+hTsYT36m/WEpFkUWAJIR43l2P
	 z42aLkZNdpmAH9SojCbzO08iBkN3nh6VZSQfoORWVzTO4VTbNjo2/2A81k7+NA9jTW
	 pDzwgj+EVTxHJe766RqWYNj8EGK3JpZVjv/U1QrczWKQFggIfP2yDaStIjawy+7wtu
	 PGdjZQ3dodRpQ==
Date: Mon, 13 Jul 2026 09:08:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: usb: Add Aspeed AST2700 DWC3 controller
Message-ID: <20260713-comical-kickass-anaconda-bfb0ca@quoll>
References: <20260710-xhci-v2-1-f292c4f7339a@aspeedtech.com>
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
In-Reply-To: <20260710-xhci-v2-1-f292c4f7339a@aspeedtech.com>

On Fri, Jul 10, 2026 at 10:51:35AM +0800, Ryan Chen wrote:
> The Aspeed AST2700 SoC integrates the Synopsys DesignWare USB3 core with
> no vendor glue logic: it is functionally compatible with snps,dwc3, uses
> the standard DWC3 clocks, and the only SoC-specific part is a USB3 PHY
> that is handled by a separate driver.
> 
> Add a dedicated binding document rather than adding the compatible and a
> conditional to snps,dwc3.yaml. This follows the established per-vendor DWC3
> convention (apple,dwc3.yaml, socionext,uniphier-dwc3.yaml, ...) and keeps
> the AST2700-specific constraints - notably the mandatory USB3 PHY - out of
> the generic schema.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


