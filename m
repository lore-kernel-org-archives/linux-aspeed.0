Return-Path: <linux-aspeed+bounces-2955-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F8BCF2567
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Nov 2025 07:20:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dBCYZ4lLTz30B7;
	Wed, 19 Nov 2025 18:20:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763536818;
	cv=none; b=CUhOsqlhlOc1wNPoX3RqL1JzJaDxmtPMCVar+bcXLDLUlBH/d7l90Agdtfw2a09FggGIuntmNRNjDQUWEYcClSmhcOYVOu+GkdLQVwowI3P1uTFR8IHNC1lmM4xiwlZQjO8clml9JUgh1Tp1/YWbq5us/54R2i0Xx9DOQr1ttRpiEgeG56P9WzMv8T2y9zdcwcPHgbbxwYW845Nqg9vCTtSm16JNaK3BitHZS1ttCN+i/CalGMbqn/YkwdTKctI6cTbqxFIJNUqQe02WzqUCiZkfiQpKMkPcBHR4IW5waUSpZO2Vg+t9ItFaNy1eabav2tVQQ2iFvZ0VXPGBvYPFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763536818; c=relaxed/relaxed;
	bh=A5s1aWI4zWUrb7+jptllveuGVEMO5Ub33WYiOXodfPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oesNaNIwI68FFxr1MQn9ObnjWVewOOa/OkExpKjIFZ0iclJ4yxy60xsHbtrGMyMS/BmmGzaTRTOWADRIRlRJzwtqZA1qpgNMYllvSceJV9rtPvQmyQfIalQJ7bcpmlA4ivb9I+OHoZRNaHANYtHWEdYUXeJObOlrmLDix+5o9FBfUmu92Qe8Dy7XVq0nEeH+YftHEUm0KwfnJlJimT8+XpIaRhf9Re4kDEv03aj+C3fiQMy4tr75uC5JK6jjkht48j5ZewuzuiuPUM573MCHPKXw0BwrwGqu2WE41lzqP46ASPbGqDuxisXRzIhNdP/eMzz3SYIkIihFTyzAdDFjTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Gm15Ny59; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Gm15Ny59;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBCYY5C3Jz2xqh
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Nov 2025 18:20:17 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 009C043D91;
	Wed, 19 Nov 2025 07:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49EEC19423;
	Wed, 19 Nov 2025 07:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763536814;
	bh=RSm/suJ/Pepr1yB59pObwuGdY4AF0Z9ZtGNsBqUmi+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gm15Ny59BIhiuZbk0udrxSlQTJ4Z3Htko5cmlrG3kyhS4JMXkb3ohZfTTSszP7Op3
	 8Y+mjg170oQM59KieR7Zp9/GcYyl9gFPkcgOM0xG/C6SqhgTLlEbSUAhFdZ+epL1iU
	 8JIVITlUGB5ox9lkpJbCI1nKnqJ/rkL7yceFclWYtLc3cC7GKDSj63rI6sVckdULfG
	 J7GLuhA9pyDn1673wGKFra6+VvMnn206vs4GrCDwTCoth9cYlMfJdt8OTESoSr9lmm
	 qyyWskspgyrzzpG1ekyzKUpRbjizuHMzI4z5VGhpfJbZzOROk/27gDX53g26v+TAsG
	 EpIxh4Eig07OQ==
Date: Wed, 19 Nov 2025 08:20:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add AST2700 compatible
Message-ID: <20251119-married-vehement-nautilus-3542a6@kuoka>
References: <20251118-upstream_pwm_tach-v2-0-4d9bc13d34f9@aspeedtech.com>
 <20251118-upstream_pwm_tach-v2-1-4d9bc13d34f9@aspeedtech.com>
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
In-Reply-To: <20251118-upstream_pwm_tach-v2-1-4d9bc13d34f9@aspeedtech.com>

On Tue, Nov 18, 2025 at 05:11:53PM +0800, Billy Tsai wrote:
> Adds support for the AST2700 PWM/Tach controller by extending the
> compatible string enumeration in the device tree binding.
> 
> The AST2700 PWM/Tach hardware is compatible with the existing binding
> schema and requires no additional properties or modifications beyond
> the new compatible string.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml          | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> index 9e5ed901ae54..8b579321915f 100644
> --- a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> @@ -18,9 +18,13 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - aspeed,ast2600-pwm-tach
> -
> +    oneOf:
> +      # AST2700 with fallback to AST2600

Drop the comments, useless and redundant. We can read the schema.
Inflating code with obvious comments is not making it better.

> +      - items:
> +          - const: aspeed,ast2700-pwm-tach
> +          - const: aspeed,ast2600-pwm-tach
> +      # Only AST2600
> +      - const: aspeed,ast2600-pwm-tach

And why are you removing blank line?

>    reg:

Best regards,
Krzysztof


