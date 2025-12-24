Return-Path: <linux-aspeed+bounces-3206-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156B1E7542A
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Dec 2025 09:11:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbmMX3PYbz2yFY;
	Wed, 24 Dec 2025 20:11:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766567480;
	cv=none; b=oOKY1bJZBveZZqwni7GXX3UDlPu7vqcZS9IoDf6k6ytDIos5/J/2vdq1s+TRCF+pbT4mM6zXJ7NE63gGKBbtzNAIxRtYZrBmqbts2EQFIY/tq5t4MzORV84ioFc6yGXN7/xpmyW5838L7TEtuHocebemgKPN6KhwOzma1u47m30LDREWfmOctRlj5deJzacwlc8dDqWbSR/OR5Pa6QoaYRR9tb5rGhhow4KUwbFB+EGWyZ7q+z61bplxB8w4nkERnyhSK3qfg5/1yCaKKTaWPZwu+Gk2NMwInA0ubWfKwdhUSglOszjwoAcEHjocS8jA51XfYBsnh30N12bHHGSJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766567480; c=relaxed/relaxed;
	bh=i1MUqHk/z+4tmfJsTEaw4AodDbdxLboDzXBsWvpAHnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZFP042mmOdrO69B2m+oFdLPHVlggCwm7Jz59iFAPMwDd/CZN0/pDgdTpeFm32KDlP6tCF31hPURs/bpoKY3wAzAwFfwCfX/w+yksxnD7qNqslMaCCMysGbqCqSUFTC+GjFLtPz8IoCmAyYBRaImVP5wlRQCqenYv/IdU0f/pP9cUwS3Eu4SjIcbVRsu0NQlMUZNi7JVhzj2wuwGzR96dfPkY5ieCaHqvqVzR7jKTEZGDO/Y5cAgsEWgCE8+Rzk2tUDvfcivMXkomskk2l8isBrGZEaixjG+n+lHlB9SgJexzutpp4Isva1sWJM52OS7A7DuohZGzmWCX7QjgIKXtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Xjj3dNOq; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Xjj3dNOq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbmMW1MpXz2xqf
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 20:11:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2B63640359;
	Wed, 24 Dec 2025 09:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C25C4CEFB;
	Wed, 24 Dec 2025 09:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766567447;
	bh=5vZOqdUCDqHKRalg9x266UN32kb30vjOJx380+ZbytU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xjj3dNOqpXV5XAnck73qHs/iMJ1+AxC5UmpkrF64RUM053N/Ws+nZHcmYNLw0WFTF
	 NeAA3iaE22t3razdlkooo6/U0Jmn7MXtLE8qQtmfjItt0bo4+tTNrVl5Tv6FgKHNlJ
	 3B+QXSakc7rm0kvDJ5poOz8jgjwFuFtRUo7/ADzVPt7IwSNn6QOHeJGmJ0V7hR9JFV
	 u+0/tjzBr4q7frg7kZaTpvPHJmc5WtpBK0Ip9JH6bCKFhFpJ0keaX09Gf1IrNDiuGi
	 WeYQ3m6jY2euXmNPNUlEGywLhotW9aB++iQg/5ezDrabfzblYhIuWIhIzH3xejDI1i
	 yuoZPQm7SpIlQ==
Date: Wed, 24 Dec 2025 10:10:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: aspeed: add Meta ventura2 board
Message-ID: <20251224-bustard-of-major-growth-b9cd89@quoll>
References: <20251224-ventura2_initial_dts-v2-0-f193ba5d4073@gmail.com>
 <20251224-ventura2_initial_dts-v2-1-f193ba5d4073@gmail.com>
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
In-Reply-To: <20251224-ventura2_initial_dts-v2-1-f193ba5d4073@gmail.com>

On Wed, Dec 24, 2025 at 02:44:38PM +0800, Kyle Hsieh wrote:
> Document the new compatibles used on Facebook ventura2.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
>

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof


