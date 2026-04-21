Return-Path: <linux-aspeed+bounces-3940-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAE5F94CA5
	for <linux-aspeed@archiver.kernel.org>; Tue, 21 Apr 2026 18:40:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0WPF65Psz30Wb;
	Wed, 22 Apr 2026 04:40:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776796801;
	cv=none; b=BaUNM9keuN0LF8v5hNOy3mdTVI932g/NiY7DrSotXPiu6GtBxmHG7n9Vvu+EpEtQl5uX6czT/zwPeNWxWS/x3skwpJM7zH7Q+bxNnwTC015jtd/kGI7QcENwdUWpERnwfGA/4IuuUM2ZAxIY6WOovsB1C1b0XKLke4PA7gUD9XOfGS/chrPDB33+9Pg9kOOyjIXaa8g89l3ewyovaFtiYfbOJxeX1QbaeddUFblpiC+IOZi3os0djX97fpkN0HYdOTruH4ceMKp1w+7FNM2CKVw/9cSmjxqn67JlDgZXjQKmTom0nCC6h7NdmUXW+mFXW4hy7i+T41KXhEMCXR/cqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776796801; c=relaxed/relaxed;
	bh=Ni1iBMzVYNVRR/bJsdX3ctQwuS8aUMtC/A2Fbuayo4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3Ems/vBGx65lx4DVKsN3LKdRimvMM5IuyjBCMWXml8zwMJaBczWwkISSShklJ1eqG/nD9Rf7hxvyNddsgUMgx+ZH5YgbdtWunTLT3EXTkG1faRioNsp301euNqTwWz5wXjdOIu3WRGz58pgGijU4hhcNfwjvD7bNG8Uq9SK+GucNFZj7aGyU3MDyiitJ+rZ/tW+A+YiWLJlhnUW8cwa2j1aJyVK6ucAEnqTprglCA0jNO0P7plT9N5Jck/zRVTUKnsuzHBc7DbqlSppiw+Ydf/BnTJrzvF0t+qp+HiI/B9FBbt/ervLt1SKOdkXOQC/W5VDrjbWSJi8Sjane9ZU3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XVpdSQ+R; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XVpdSQ+R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0WPD2j5tz30WX;
	Wed, 22 Apr 2026 04:40:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 278E240144;
	Tue, 21 Apr 2026 18:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA0EC2BCB0;
	Tue, 21 Apr 2026 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776796798;
	bh=50mQHD7FkIRq1YWjICck6T5+Oufmi7QsAhgPHeR0pvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVpdSQ+RtzY6DXBIz5P+utA5Jm+7IvW1PJQT0HkIe/aJYAxaBs6mx5s7PC1H/eCxB
	 ikORpKU+Q5q4nBMfp1sFBgudE5UUmEDscUk7yz0HcDBbRxu/Ay1JridC4AKWyz16aC
	 44Qadg1bUgmus5YzYKdBb4gszgRrBK6hFXg/jwT2Kl51bCFQL44nfEVJ9d9VekL5ft
	 f7LuIifWK+dT8Rsll3YKDiRc8V2+EYyLn6JcXJTXz9usahPwOjSo/h41ryystRCAx7
	 uVlNZUwaZvV7BLC01XAAJUXzXL7YDQXDDbTUGYw/7PlgI7H8acD+u8h8awdRl2xnRW
	 3rhxJIhuN8cEA==
Date: Tue, 21 Apr 2026 13:39:55 -0500
From: Rob Herring <robh@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 2/3] dt-bindings: mfd: aspeed,ast2x00-scu: Describe
 AST2700 SCU0
Message-ID: <20260421183955.GA1448377-robh@kernel.org>
References: <20260416-upstream_pinctrl-v7-0-d72762253163@aspeedtech.com>
 <20260416-upstream_pinctrl-v7-2-d72762253163@aspeedtech.com>
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
In-Reply-To: <20260416-upstream_pinctrl-v7-2-d72762253163@aspeedtech.com>

On Thu, Apr 16, 2026 at 03:29:44PM +0800, Billy Tsai wrote:
> AST2700 consists of two interconnected SoC instances, each with its own
> System Control Unit (SCU). The SCU0 provides pin control, interrupt
> controllers, clocks, resets, and address-space mappings for the
> Secondary and Tertiary Service Processors (SSP and TSP).
> 
> Describe the SSP/TSP address mappings using the standard
> memory-region and memory-region-names properties.
> 
> Disallow legacy child nodes that are not present on AST2700, including
> p2a-control and smp-memram. The latter is unnecessary as software can
> access the scratch registers via the SCU syscon.
> 
> Also allow the AST2700 SoC0 pin controller to be described as a child
> node of the SCU0, and add an example illustrating the SCU0 layout,
> including reserved-memory, interrupt controllers, and pinctrl.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/mfd/aspeed,ast2x00-scu.yaml           | 113 +++++++++++++++++++++
>  1 file changed, 113 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> index a87f31fce019..215ff59b38ea 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> @@ -46,6 +46,17 @@ properties:
>    '#reset-cells':
>      const: 1
>  
> +  memory-region:
> +    items:
> +      - description: Region mapped through the first SSP address window.
> +      - description: Region mapped through the second SSP address window.
> +      - description: Region mapped through the TSP address window.

blank line

> +  memory-region-names:
> +    items:
> +      - const: ssp-0
> +      - const: ssp-1
> +      - const: tsp
> +
>  patternProperties:
>    '^p2a-control@[0-9a-f]+$':
>      description: >
> @@ -87,6 +98,7 @@ patternProperties:
>              - aspeed,ast2400-pinctrl
>              - aspeed,ast2500-pinctrl
>              - aspeed,ast2600-pinctrl
> +            - aspeed,ast2700-soc0-pinctrl
>  
>      required:
>        - compatible
> @@ -156,6 +168,30 @@ required:
>    - '#clock-cells'
>    - '#reset-cells'
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            anyOf:
> +              - const: aspeed,ast2700-scu0
> +              - const: aspeed,ast2700-scu1

More simply expressed as:

contains:
  enum:
    - aspeed,ast2700-scu0
    - aspeed,ast2700-scu1


> +    then:
> +      patternProperties:
> +        '^p2a-control@[0-9a-f]+$': false
> +        '^smp-memram@[0-9a-f]+$': false

