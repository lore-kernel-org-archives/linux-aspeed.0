Return-Path: <linux-aspeed+bounces-2453-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC95CCD18E
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 23:21:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmVbQ2YpMz2yGM;
	Wed, 15 Oct 2025 10:21:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760484098;
	cv=none; b=Wl1OC5HvixafvG0/v5gWNvZl5YMcFxlkJrjnNoTN9scQDHN//KwRyXM9Uc8+bobKDX6kbVE2+nHJXpif/0dVVwLsW+1UYTjC3oy6P/pxzchmYNJBEF99Fr6xP+7ivrH1BIzoMvSRa95B8pZfA78gN3QmTVUe5SCi+2vfUezXo7zUuPkRjxsXLjbKzI5RZLK9ah9fn2U33grODj9aRzne6rEw/BNqX83i83deubljHaqCaWDKq0lR8w2Y3txqM3tceFuZfMnSPtsX0dGxCgPUNoHh8N3eBZ+DV32cB6CRwI9awiSnGy1fzVjnKpPjUb1SSrg60wOVcf8at2AuKnGMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760484098; c=relaxed/relaxed;
	bh=OSShFjPEhGZS0W8PMTI5EHo4sFmoEnYAkCUykXUZUtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRhfM/CsDJZ22TYA25i9xk4aVpjTeYRbk8Eu8jZVmpb8vP7wSaIuGHNo9l6l3UFGLL8uTy6+DDnsFqiuT1X6XA8X9kzYtX8k1OzHM/3j2OXkX135xXU+8ZOvIlDaz31btp8TZlemRg/11Pdhj6e3sxjKsUq0XRXakqEoV2oi4putUY4TrC4cArAbAFkXy/t+7fFeHdmfBzZkvLWkWH1C2GjNQeX0bpYeLykR/kw1nUBce5vsRPwZWBfaQuAYFBKp5H29lTu3hVLU6T9NFicxoSbxDlKZXWzPPGXlRSnWjR2mnJ4vksYvzmaS4lc4sk/GyX4RMTH4ftg7CLonqKSXGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=minyard.net; dkim=pass (2048-bit key; unprotected) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=mc+dbgx4; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com; envelope-from=corey@minyard.net; receiver=lists.ozlabs.org) smtp.mailfrom=minyard.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=mc+dbgx4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=minyard.net (client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com; envelope-from=corey@minyard.net; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmVbN6R4Gz2xcB
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 10:21:36 +1100 (AEDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-7a76561c291so3685803a34.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 16:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1760484093; x=1761088893; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSShFjPEhGZS0W8PMTI5EHo4sFmoEnYAkCUykXUZUtk=;
        b=mc+dbgx4wqSHIwXVTiUb/FD8P/fZpb8KM3mxBv089ZWPhMFlzNQ1kayogEalQBMCeZ
         PYbamVJ6HXI2j8T4OwvLBJOXuRUz8G9jdzplBzd8BxMWX+WacGjVL2x0fxjTEW15UwLS
         oLCzU+jVLTIPfoaGlizynwrqxl0FIoLMbv5kMwXL3mkYtQ6KuvSbM8Te0x65cQdBfmZe
         42htOr6JtSQJfeL3JjCN6iShqrLgLgYczbYFJUnkzbjAtnjrrnDQ6xOKIQqUY1N1KpNJ
         GY7UFNPa7soTLoL/nM6xJVWnmnFu10/uBaxcw6mOJVrZPqkwtKD0AnARfQWwvSD9q5BK
         Y7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760484093; x=1761088893;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSShFjPEhGZS0W8PMTI5EHo4sFmoEnYAkCUykXUZUtk=;
        b=G8/VT1IzAe1OKFwCfjSkT/mYd580hF8srur+r35aq/Pse52kulwGehe5Z3Xi6+OmHx
         k2vgtPkyZgrzW5NqHud87GeIONDeXAJ1RaC7bl7WnqvNXBu/Kb2LNRTbEyZIxPSYrQk0
         E4x485f6E7gweFvyFp9LoUMBHVcvZL5j+jXQ00oXPSsbJ879HIZ5ZzQROt2V3iX/tIe8
         BmmuftJrZQSGgdC0woG/XJ2KrP8x0fmwBa9EQgdaHit+EmB63WrPj5fAnYs0WEhMeEkG
         5FUTMJFUPVgu0JevBZlbLmbvysvI0cBCns2dubbD4WLmwGSLk6oBTJd0QkGGnRyspVj5
         cwHA==
X-Forwarded-Encrypted: i=1; AJvYcCW+b2+zOFAoEkMmvHc7HcAYsC+0RKSDz7JpZY6OcGQM+ia/KTm1IFhisBN/1vaNvyQIkyUEewyQejA+fT8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxkNLv5FOfowDlcMOTpAQ4dlhNnkj5o9o3PbpoJJ+LlMrFwQSPo
	x3iRvM9ndOriic9NDuvnUc87j7uKZJWRB1w7K+pJhggwUyp/qKLZNZowEji5x/lfmck=
X-Gm-Gg: ASbGncvjslLP5/FMhCVQLDo4CRDpK0mfDbm6FmGLKjIBynsYoF7BV99h6+QtygqVwEA
	xb3NKw1MrvpCZvX5FddcF8wQRfaotuvdJ3uFTM+hSTmeHyCysMekqqYCxciJSZYop3Pl8cxWUZ4
	Mkr40PTMn+TAkV+JgnKNYpNV5MLXrRSnJIJAbuNRxht9ZoFgvgww1yXei9XsSagVpLmtO8zkFeC
	Xv4DPosdNI5uc+IeWyYQmm41Ax1dqlhJfC/oEpkNCrip+DLonFtqnc5gj601hGld+0UCvDz89WB
	Ssb6sjs/9aXzm2kIUkEuB8yIFyby3gleZ6JeqxCI9NNrPSnC+4+3js/DQFczakZvf/0MLPtlgbu
	dTcFQGX6NNNws6YXYytpDXTy1msx2GPsS53381PYkQ2Zr9ckE0oVVa3g=
X-Google-Smtp-Source: AGHT+IFyq+WDPFYOSKVvyIdkGtxTVAzzTyKhwOBWQXTwZ3nOyJ35Dj36gHaI4KcaGzemEBsN+8m9XA==
X-Received: by 2002:a05:6830:661a:b0:799:bdea:3470 with SMTP id 46e09a7af769-7c0df6bc4famr15912480a34.18.1760484093234;
        Tue, 14 Oct 2025 16:21:33 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:ad63:63fb:ee1c:2ee9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f90510dfsm4856881a34.5.2025.10.14.16.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:21:31 -0700 (PDT)
Date: Tue, 14 Oct 2025 18:21:26 -0500
From: Corey Minyard <corey@minyard.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ipmi: Convert aspeed,ast2400-ibt-bmc to DT
 schema
Message-ID: <aO7a9moI23th0Oo9@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20251014152948.3782738-1-robh@kernel.org>
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
In-Reply-To: <20251014152948.3782738-1-robh@kernel.org>

On Tue, Oct 14, 2025 at 10:29:47AM -0500, Rob Herring (Arm) wrote:
> Convert the aspeed,ast2400-ibt-bmc binding to DT schema format. It's a
> straight-forward conversion.

Queued for 6.19, with Andrew's review.

Thanks,

-corey

> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/ipmi/aspeed,ast2400-ibt-bmc.txt  | 28 ------------
>  .../bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml | 44 +++++++++++++++++++
>  2 files changed, 44 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
>  create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
> deleted file mode 100644
> index 25f86da804b7..000000000000
> --- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -* Aspeed BT (Block Transfer) IPMI interface
> -
> -The Aspeed SOCs (AST2400 and AST2500) are commonly used as BMCs
> -(BaseBoard Management Controllers) and the BT interface can be used to
> -perform in-band IPMI communication with their host.
> -
> -Required properties:
> -
> -- compatible : should be one of
> -	"aspeed,ast2400-ibt-bmc"
> -	"aspeed,ast2500-ibt-bmc"
> -	"aspeed,ast2600-ibt-bmc"
> -- reg: physical address and size of the registers
> -- clocks: clock for the device
> -
> -Optional properties:
> -
> -- interrupts: interrupt generated by the BT interface. without an
> -  interrupt, the driver will operate in poll mode.
> -
> -Example:
> -
> -	ibt@1e789140 {
> -		compatible = "aspeed,ast2400-ibt-bmc";
> -		reg = <0x1e789140 0x18>;
> -		interrupts = <8>;
> -		clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
> -	};
> diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml
> new file mode 100644
> index 000000000000..c4f7cdbbe16b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-ibt-bmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Block Transfer (BT) IPMI interface
> +
> +maintainers:
> +  - Joel Stanley <joel@jms.id.au>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-ibt-bmc
> +      - aspeed,ast2500-ibt-bmc
> +      - aspeed,ast2600-ibt-bmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +
> +    bt@1e789140 {
> +        compatible = "aspeed,ast2400-ibt-bmc";
> +        reg = <0x1e789140 0x18>;
> +        interrupts = <8>;
> +        clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
> +    };
> -- 
> 2.51.0
> 

