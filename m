Return-Path: <linux-aspeed+bounces-5123-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E677BCA5FDD
	for <linux-aspeed@archiver.kernel.org>; Sat,  3 Oct 2026 14:40:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxpGK4qXfz2y32;
	Sun, 04 Oct 2026 00:40:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791038409;
	cv=none; b=JDntfqhZjiSVgIV2nYi0FXMA3DZMULIOGXxz0++XjOQ9qMfbxkYVX7kLbKKnE/gxfagpjbVoa/cOs8CI9Jwo5v+imNlaPVw3diDqQ+yWsActqzDUu3/whLUgNLTh0f3enFHXvwfiFlqsWO+OY9iQ/BaIitO/UtPNAbaK9+ZeZ47012aYyOhmkTvvm95f98zCtKGgJNylhv8I/gM1ecIeKK1wlWZqWzW7aRhBEANX8oGPx8+S1qma9ZgNIQBG/+WusRX88PVkQbuH5jy7ayxScJbgYWyo4cos1criiy3Dd1jwqEF+L9lFnvL33xYvFw8IzBPmEJwKHfJlLDNAuHQTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791038409; c=relaxed/relaxed;
	bh=CTabz4k5Pu6RL0JYLkoNNQQVHbYboO3IWOxirWvU088=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lf4yP/HWqtmDG2osWMrgFJByX/MImvQM7vhBBxWeLKepbVfu9iBKGm06T1VBmu2NfQMgGQKZObuwlxeNh0Ng17YuF8IJpTSwCGMzLczAEuKYEOlt2/CgOcCebDrcIGSkU1IftgI5ucLnWRZsPxyP5CUsMbKfBR/VAeq/WS1b0Xkj6PXyRGF/wePOfxLPsX8UaKhCSlQ4AJt6eg3uQpcDskRLVZWEjPQ7r1xjSIZXxoaOD4fuRrQqEIh9sHccN9y8wM1lY1a5SJM69G/k0k2fUNKTlZH5lxDw8ASfYg9i/yZW2M4WTp4FezteP5vC5Ee2dbDSBilkL2Y9/GN9MfHROQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8KKBSqd; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8KKBSqd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxpGJ5jM8z2y2K
	for <linux-aspeed@lists.ozlabs.org>; Sun, 04 Oct 2026 00:40:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 100AC43F81;
	Sat,  3 Oct 2026 14:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1D71F0089B;
	Sat,  3 Oct 2026 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791038405;
	bh=CTabz4k5Pu6RL0JYLkoNNQQVHbYboO3IWOxirWvU088=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H8KKBSqd1lH0Fx13M/hdBhHXIVsjXUY29DeHXhIVdOmKjKEX/QgLfSm/Xsrp8CmTc
	 H8pEQcZCCz2OYKD6ocLSGdywoW3a4X43NL62xecE8aKvLPr+LYlivANEKH3z9A3oga
	 Z1tFrwik1JiJ903uFLy6l8/FxZJI+sC3vA6U122n6mI0/2lxFXbb+xTJv9DvnL+Cmu
	 RSFWMWzkec/Nq/eqSTthzF/HEzhovWtiSljIYRyk4JwfnxmRoKcdotFf+9OP1V+qYt
	 22WJPi4uaDFLPEDuCdzLXIBNDUY4pkIWrIEF/Ilh1gFrFI0cL8b5ULYo70GbVCA6kU
	 kJFkTMx//2dFA==
Date: Sat, 3 Oct 2026 16:40:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dawid Glazik <dawid.glazik@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, maciej.lawniczak@intel.com
Subject: Re: [PATCH 1/4] dt-bindings: arm: aspeed: Add Intel AVCRP board
Message-ID: <20261003-effective-acoustic-toucanet-7f615f@quoll>
References: <cover.1790344811.git.dawid.glazik@linux.intel.com>
 <63367a27ef8c7f27a9d273b65b02b02009d149c6.1790344811.git.dawid.glazik@linux.intel.com>
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
In-Reply-To: <63367a27ef8c7f27a9d273b65b02b02009d149c6.1790344811.git.dawid.glazik@linux.intel.com>

On Fri, Oct 02, 2026 at 06:32:42PM +0200, Dawid Glazik wrote:
> Add a compatible string for Intel AVCRP BMC board.
> 
> Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 8ec7a3e74a21..2c8180e49b2f 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -106,6 +106,7 @@ properties:
>                - ibm,rainier-bmc
>                - ibm,sbp1-bmc
>                - ibm,system1-bmc
> +              - intel,avcrp-bmc

Why breaking the order? I could imagine people adding to the end,
because they do not care yet still follows some logic. But this
counters any logic.

>                - ibm,tacoma-bmc

Best regards,
Krzysztof


