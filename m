Return-Path: <linux-aspeed+bounces-813-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C35C021B5
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Feb 2025 09:11:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1ZjG05NHz2yjb;
	Mon, 24 Feb 2025 20:11:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740388273;
	cv=none; b=m0bV9ZkLKzZGX37s1TzEy4Cf88HnFnKIHFfjNSglasUURt02Y6XfIaHb73E7zhEu5328xbQqALMlKfgCyDcjRx9DmEFEzZVOsUOFsChbdQKr/Olt4V0bpCdyiFYcbQpTwvRlQrlCZdae00tRhCGHf3D93AeMVbvXAgxYB0mLtekTeEB92HHLhsQpG4epcdAdqenR9X/zw/mndD0tagSifqwJjOTzMOXQ/YWvQdCBmwF56u3lIzXOLCE2d39Yhc4Av99V/XgvsSCqxkjeh+VetelZ712CRjCdTRF2M2lx4/xGfnSBQgptYuFLBlWhAWPPsAoyAinlEFlHV/GkBEXYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740388273; c=relaxed/relaxed;
	bh=Jm/8ruoAO9qULThvArgpJHnnXXQmdGEmsF1uURgFquw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpPPNIC+AJyzwbyjmoGHewemzAjCaeFD2XqmduSXmP/bE0oNZc+oQeoM/nJxPgIwWgnaVYXRVgspwXB6TxAv1Dy/MM4oVjueEvX1r09z8QZTOrc2iuja1HRJ1NMmeOoaCKTsSELSn6wNHrVBpiimAPUXHzAc7R9Ke/7LM30ydOgzQRCz6gzYowW7uWHrWfGFImN7Xyl3L2CWKlJkh10wmFT6mhYE5EYOsDvxb9nOxFepPrH2UHBJPk4kPvvNRYy9DfSiaB5tigsTFj2UBA66g5WbxKcTx9p5anxVySgG+wTUHksOQ3YQOOaPej+UZSWmSr6deejnycbkY3OST7QRHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UVDyb9A6; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UVDyb9A6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z1Zj95zWBz2yXs;
	Mon, 24 Feb 2025 20:11:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B895A61183;
	Mon, 24 Feb 2025 09:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571D5C4CED6;
	Mon, 24 Feb 2025 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388264;
	bh=paqcVaN+9js9H2BBnIzPb/KQmMraUhcTcdEAOrrYxGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UVDyb9A6iSFEZR+LjdELpEgVGyTrHax22CwW4kimVb/iLXTObfEsv95EuplSKgtBc
	 5oUowBkfia/PWtbiRSow61VRZSQVmbFYD6RuAi+aQDfk5QP5t3a5vTE1HHtVr+B9CK
	 myk1UQDUe+goU/zFwEjgPNeMwTMX64NNYwl34jsmeunRzgU+oexHDv6r+OlHpWtxyt
	 TzfKctNBcaeHe1aHUHgRjNE+k5yxN2tN4eH9gAfY5kzqN7cN0P4vy0gQFGtG/5nylJ
	 p1CFFYYDurj9gQex5jiwi5Ba5lGwPbayQsy2BFTfJ4wzexIHkq5cC4FjIqPAZZz+Rd
	 260/jfeD3TjfQ==
Date: Mon, 24 Feb 2025 10:11:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: benh@kernel.crashing.org, joel@jms.id.au, andi.shyti@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andrew@codeconstruct.com.au, p.zabel@pengutronix.de, andriy.shevchenko@linux.intel.com, 
	linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 1/3] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
Message-ID: <20250224-arrogant-adventurous-mackerel-0dc18a@krzk-bin>
References: <20250224055936.1804279-1-ryan_chen@aspeedtech.com>
 <20250224055936.1804279-2-ryan_chen@aspeedtech.com>
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
In-Reply-To: <20250224055936.1804279-2-ryan_chen@aspeedtech.com>

On Mon, Feb 24, 2025 at 01:59:34PM +0800, Ryan Chen wrote:
> Add ast2600-i2cv2 compatible and aspeed,global-regs, aspeed,enable-dma
> and description for ast2600-i2cv2.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> index 5b9bd2feda3b..356033d18f90 100644
> --- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> @@ -44,12 +44,60 @@ properties:
>      description: frequency of the bus clock in Hz defaults to 100 kHz when not
>        specified
>  
> +  multi-master:
> +    type: boolean
> +    description:
> +      states that there is another master active on this bus

Except that this wasn't ever tested...

Don't duplicate properties. i2c-controller schema has it already.

> +
> +  aspeed,enable-dma:
> +    type: boolean
> +    description: |
> +      I2C bus enable dma mode transfer.
> +
> +      ASPEED ast2600 platform equipped with 16 I2C controllers that share a
> +      single DMA engine. DTS files can specify the data transfer mode to/from
> +      the device, either DMA or programmed I/O. However, hardware limitations

so what is byte mode?

> +      may require a DTS to manually allocate which controller can use DMA mode.
> +      The "aspeed,enable-dma" property allows control of this.
> +
> +      In cases where one the hardware design results in a specific
> +      controller handling a larger amount of data, a DTS would likely
> +      enable DMA mode for that one controller.
> +
> +  aspeed,enable-byte:
> +    type: boolean
> +    description: |
> +      I2C bus enable byte mode transfer.

No, either this is expressed as lack of dma mode property or if you have
three modes, then rather some enum (aspeed,transfer-mode ?)



> +
> +  aspeed,global-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of i2c global register node.

For what? Same question as usual: do not repeat property name, but say
what is this used for and what exactly it points to.

s/i2c/I2C/ but then what is "I2C global register node"? This is how you
call your device in datasheet?


> +
>  required:
>    - reg
>    - compatible
>    - clocks
>    - resets
>  
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-i2cv2

NAK, undocumented compatible.

> +
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2


Best regards,
Krzysztof


