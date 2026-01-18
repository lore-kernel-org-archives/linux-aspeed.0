Return-Path: <linux-aspeed+bounces-3375-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597A6D4A5F4
	for <linux-aspeed@archiver.kernel.org>; Sun, 18 Jan 2026 10:21:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dv8l60y0Pz2xSZ;
	Sun, 18 Jan 2026 21:21:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768731698;
	cv=none; b=gUlhgVI6Xg4d6MIxDFxgFLBGNcN5KRKK/4Mcqcd+S9vnrWe1yfpBwlyujkff9TL9DzL4gy3PVbyZzEvSmUvX/KRDAG4LKBfTxcfTf06Q9c+oH+y6qw+NZiYO7doIq3rQZ/j6fyRWWMjpvXZ0IoXF0heuAZENK8cnCc05sJwAdQ57e6BuKsD8T5loKhyzEJ1DSJzYdfJTGjKAf6gvtQLHheV/rPPfHsyZqs47Oeotylj2IMsQy1ECq+5inw08hoSixgohA6CFF/EXXI1dtpJcQX+s2W3Zq/nfYdxstpkEkV50IReebsHcSD0zF4sNXwQJrgjKW5/jKhWqFvy+8dKz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768731698; c=relaxed/relaxed;
	bh=djacek+PzgljqUNpxKG/4FqVUvzF3crvBXQh2ZcVR6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkApeQfZ2d4KfoOpBpKbZfaGjx9ENJwqTRHkQWpD6/Q46b+fvrGi3S2xf0MoGDLmqTbYTSdCzE7ufKA2tupLk/K4WSSW47ZxnrEfUAxWx8jwfDlOh3gi8ZjWAiSb5jHCzUEBm+laUlcpJioix8k5tsdnTunvjlqczYpJ9lTS4f5h9NlrEA+YgpynW7oUSwb49cgkBZlpzW+zxLBZTvhbtD+whpiKA1uLLU1olncwqzUwFkkzAAvBwjyQAb/7iyI2F5VMpdhBiHGUlcKSIHW1q8Ou3AjThoXclX5QTwhkkl31dhg6H/5osgXkXeHn5TjGvjUK3jVLnRIrjxDIxyDybA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C42Pc/2a; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C42Pc/2a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dv8l521CCz2xJ5
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 21:21:37 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4AF6441A0A;
	Sun, 18 Jan 2026 10:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FAAC116D0;
	Sun, 18 Jan 2026 10:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768731692;
	bh=MJ/WTcCQVn5ZPmWc0MlqQHQO30rxkRLjFAJjMF+vpdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C42Pc/2aoxnPfLZTVaspSQ7sLfoI1nqCfz6LUamigZ16zFYqwXA1PVYgn/d2zOdJR
	 sNFTCRvgAZ7RqnaAv4K9N7UXYtPr06+ejcItBIWazrTmPMBawvzxlTS5ACy1lznj2b
	 o3TsceRQIptk+OXVwrJtbYpVRrHIkkUzPvKqLcmA1pI6aCRni6HyHcld3vZYChZZq6
	 c2m8/dXXSmzCh7EZ9/Y8lylwTOo2rTE/JqXmiuMxEifR6DpLxme5sPu5y/taerBP1m
	 lAlkDe+cZ725rC5OqU2zl8lO4dA4AbMmHxmc2CEdI0B+LLlTdqKfKtKru32m1fFfKs
	 RMK6O5cJ5N9lQ==
Date: Sun, 18 Jan 2026 11:21:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, bmc-sw@aspeedtech.com
Subject: Re: [PATCH 4/5] dt-bindings: gpio: aspeed,sgpio: Support ast2700
Message-ID: <20260118-cunning-robin-of-greatness-4c735a@quoll>
References: <20260117-upstream_sgpio-v1-0-850ef3ffb680@aspeedtech.com>
 <20260117-upstream_sgpio-v1-4-850ef3ffb680@aspeedtech.com>
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
In-Reply-To: <20260117-upstream_sgpio-v1-4-850ef3ffb680@aspeedtech.com>

On Sat, Jan 17, 2026 at 07:17:11PM +0800, Billy Tsai wrote:
> The AST2700 is the 7th generation SoC from Aspeed, featuring two SGPIO
> master controllers: both with 256 serial inputs and outputs.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


