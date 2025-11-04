Return-Path: <linux-aspeed+bounces-2723-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE032CCFA03
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Nov 2025 02:39:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0t2W102Wz2yFV;
	Tue,  4 Nov 2025 13:39:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762223971;
	cv=none; b=m8cy7lZkLUipoCBD9HgOoJfHJf5GSk6DELKQMg1mts4zlh3hk5O+jWNtCypAfvNLHsim48TW/6knCgpxAhJLdW1qDBqlFj2vNcOBAVNbjh9RjqQ/0RzWASUvKN+Qof3O4Cgv/01T7NgHEK8rbzsovryztWprkkYsqO1lVjLct/VbWLdLFv+cFH1nTZ/5jL4z35I7y7Dggkadyx1gj7JPwE+k+5J23qgx1vZKPbE1ITshBHOqddKyTZOwP/EVsbTqdhfBZbbMDX10KE8DD0YjG4FGXQnkeNqQeRjuriCwrFseer29wDiiXAL4T7GpwL1sQOllyhtdaeXSx+zuaOVC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762223971; c=relaxed/relaxed;
	bh=8gU4iu/jxMJVno8QaMCLdahHidjmz5hXR/hIiNJxZ5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGzoPGvKVV+CmOgbP2WWkMM49kj8CEDWhH+7eojJn+X+qPp+9iUFzDLMbQUKapRXsIhNMBnru8Y43mEFwg78vXj7joJsZGF7//9PJzA387XPHRmZX8Abxc5Sq+wV2lyTT9v2fYoUI1V+zuvnBKbKfLXRFSGEN/QYqhobtxI0uxBWVS2ylwkQTh07zRZERYCAN0fyLF8sANDCmQXg70zmdXtfbv4QxpLFFssWBdhsNnvxN7FJmY1sedok0y5XYKjKBBkpHGL1WqxzQOZrb5pN4ESr0OYm2c37ie8StpYB2XeTvOJVZMsVq2qW4Mj1dtGnIRnWJ6aw+sP77E+kPILkGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=wzkJVWFw; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=wzkJVWFw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0t2R5zJDz2xS9
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Nov 2025 13:39:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8gU4iu/jxMJVno8QaMCLdahHidjmz5hXR/hIiNJxZ5Q=; b=wzkJVWFwzWwRQDtieVeeWxvCTY
	N+AVdOv9y4J3HJ14l+7IfSo/8GyV3CWeLDyPv/tzevlhm4ggiJ7lt7q8cYRnsp67nL4cgromDXfZC
	0yE0P+zw8htEIQ4gZxOGG/tsE+54jXt0uNMLWeHNXowHaz9BfZhRgB8mk/hi39eZT8zA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vG6we-00Cqbf-KO; Tue, 04 Nov 2025 03:38:52 +0100
Date: Tue, 4 Nov 2025 03:38:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Message-ID: <2424e7e9-8eef-43f4-88aa-054413ca63fe@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
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
In-Reply-To: <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>

On Mon, Nov 03, 2025 at 03:39:16PM +0800, Jacky Chou wrote:
> Create the new compatibles to identify AST2600 MAC0/1 and MAC3/4.
> Add conditional schema constraints for Aspeed AST2600 MAC controllers:
> - For "aspeed,ast2600-mac01", require rx/tx-internal-delay-ps properties
>   with 45ps step.
> - For "aspeed,ast2600-mac23", require rx/tx-internal-delay-ps properties
>   with 250ps step.
> - Both require the "scu" property.
> Other compatible values remain unrestricted.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../devicetree/bindings/net/faraday,ftgmac100.yaml | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index d14410018bcf..de646e7e3bca 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -19,6 +19,12 @@ properties:
>                - aspeed,ast2500-mac
>                - aspeed,ast2600-mac
>            - const: faraday,ftgmac100
> +      - items:
> +          - enum:
> +              - aspeed,ast2600-mac01
> +              - aspeed,ast2600-mac23
> +          - const: aspeed,ast2600-mac
> +          - const: faraday,ftgmac100
>  
>    reg:
>      maxItems: 1
> @@ -69,6 +75,12 @@ properties:
>    mdio:
>      $ref: /schemas/net/mdio.yaml#
>  
> +  scu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the SCU (System Control Unit) syscon node for Aspeed platform.
> +      This reference is used by the MAC controller to configure the RGMII delays.
> +
>  required:
>    - compatible
>    - reg
> @@ -88,6 +100,44 @@ allOf:
>      else:
>        properties:
>          resets: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-mac01
> +    then:
> +      properties:
> +        rx-internal-delay-ps:
> +          minimum: 0
> +          maximum: 1395
> +          multipleOf: 45

I would add a default: 0

> +        tx-internal-delay-ps:
> +          minimum: 0
> +          maximum: 1395
> +          multipleOf: 45

and also here.

> +      required:
> +        - scu
> +        - rx-internal-delay-ps
> +        - tx-internal-delay-ps

and then these are not required, but optional.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-mac23
> +    then:
> +      properties:
> +        rx-internal-delay-ps:
> +          minimum: 0
> +          maximum: 7750
> +          multipleOf: 250
> +        tx-internal-delay-ps:
> +          minimum: 0
> +          maximum: 7750
> +          multipleOf: 250
> +      required:
> +        - scu
> +        - rx-internal-delay-ps
> +        - tx-internal-delay-ps

Same again here.

	Andrew

