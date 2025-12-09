Return-Path: <linux-aspeed+bounces-3065-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22278D3B996
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Dec 2025 20:41:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dQrNy1mLrz2yF1;
	Wed, 10 Dec 2025 07:41:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765312898;
	cv=none; b=PCnbIUSe8bOQn12Im15ziSApco7mesD5tM4kjV/pUfHc4jM+pbQnA8sPyfYabadXSPBnEnbRjB75Kv/I1zzd1gGyFEs7q90uDMk+07tBdgE5LNFhJx/A3CtRjRmjJrt4yTqzqirnnPhVbez6Npl3rwX9DMOtiWZrfLi77OJ3h1JlMROqooWoRdsVcHIj7bbPz+L027ke96LZCfGGpIqum7Qc2o45jMuVIyipY0RPaeXzzOSqBf9aRv1gdsbTWL9U1BH094BYeCVYf60WWqcCQ4QtkwRNC8vD5Kvocbh+fXEwsKifT1WiHvc7uOANeRn+ZfmCAKUA3cJEYwhybwAt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765312898; c=relaxed/relaxed;
	bh=vmsjjjpgLpXOwUIyAxU+dtO80cjSC8pQXKZr/Zixu6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlAHiwhVreBzws/wYqaBk5ZgQi9wopuplNUmpRGuPndRnW6eNbThdqWJt9zf9h7r3phWQ9+eovnak6N8YyReZSau5UkK/mZO7p3J3jQTnQtA3OM1gycoETZDkyxPY+yH/jAFhGBwmBfGrkAxg6staXIS/ORi+wCnaKAWLZPtAOhdwaqX9b7C46tWir2jIcANKevYBksd6zp6MEyAOPAebaUUvwL8gcP1GU8xwTtKNBDCNQfhOLEM8VRsNlo99Em9DMh8eUs5nLpwCu7h2JIpk35d758nyZOC+pMEp49OqRCawT2MLLSFlkZHgn1qANSz/oFgMZii7w6X6GTPd0KH8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DQ0d2tfi; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DQ0d2tfi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dQrNx0DC8z2xHt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Dec 2025 07:41:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 23C2D60051;
	Tue,  9 Dec 2025 20:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AC8C4CEF5;
	Tue,  9 Dec 2025 20:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765312893;
	bh=6UgeHwLWxOpoVYgukx4GdIpLT8XqFIfNQirBTLCXB3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQ0d2tfijNqsU6nLz8VQlelwZ6vOzxxmQnZmKaKoooZqEqXwW7/FhYeVdiwBV1wcg
	 X3UvjtfnjUtZ1cC3KFTuVO6laMAzTENlCzL9XJXfaV7d7pQG6fXrvFuypCu76HnpjE
	 ZBwJZURHFR6ml2mbHeW4tKY+UiNZm6jdjg2jGJepVAqdU8xbGYjeDma8Gv0baamz2T
	 BEHm80uPvonOdqC3sN4LKJuQm97RnoYqOiF5jYjL1JDmvmiF9qR4mGy6//2BcnrQop
	 3EcmrS0WgO+M/UsWZd85UizxcPAnHevgAr/m9S3m3p0bJt0R2Rc1O00CWY5/aRv/Zx
	 LD3M8IQBXtjWw==
Date: Tue, 9 Dec 2025 14:41:30 -0600
From: Rob Herring <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v5 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Message-ID: <20251209204130.GA1056291-robh@kernel.org>
References: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
 <20251205-rgmii_delay_2600-v5-1-bd2820ad3da7@aspeedtech.com>
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
In-Reply-To: <20251205-rgmii_delay_2600-v5-1-bd2820ad3da7@aspeedtech.com>

On Fri, Dec 05, 2025 at 05:53:15PM +0800, Jacky Chou wrote:
> The AST2600 contains two dies, each with its own MAC, and these MACs
> require different delay configurations.
> Previously, these delay values were configured during the bootloader
> stage rather than in the driver. This change introduces the use of the
> standard properties defined in ethernet-controller.yaml to configure
> the delay values directly in the driver.
> 
> Each Aspeed platform has its own delay step value. And for Aspeed platform,
> the total steps of RGMII delay configuraion is 32 steps, so the total delay
> is delay-step-ps * 32.
> Default delay values are declared so that tx-internal-delay-ps and
> rx-internal-delay-ps become optional. If these properties are not present,
> the driver will use the default values instead.
> Add conditional schema constraints for Aspeed AST2600 MAC controllers:
> - For MAC0/1, per delay step for rgmii is 45 ps
> - For MAC2/3, per delay step for rgmii is 250 ps
> - Both require the "aspeed,scu" and "aspeed,rgmii-delay-ps" properties.
> Other compatible values remain unrestricted.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../devicetree/bindings/net/faraday,ftgmac100.yaml | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index d14410018bcf..00f7a0e56106 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -69,6 +69,30 @@ properties:
>    mdio:
>      $ref: /schemas/net/mdio.yaml#
>  
> +  aspeed,scu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the SCU (System Control Unit) syscon node for Aspeed platform.
> +      This reference is used by the MAC controller to configure the RGMII delays.
> +
> +  rx-internal-delay-ps:
> +    description:
> +      RGMII Receive Clock Delay defined in pico seconds. There are 32
> +      steps of RGMII delay for Aspeed platform. Each Aspeed platform has its
> +      own delay step value, it is fixed by hardware design. Total delay is
> +      calculated by delay-step * 32. A value of 0 ps will disable any
> +      delay. The Default is no delay.
> +    default: 0
> +
> +  tx-internal-delay-ps:
> +    description:
> +      RGMII Transmit Clock Delay defined in pico seconds. There are 32
> +      steps of RGMII delay for Aspeed platform. Each Aspeed platform has its
> +      own delay step value, it is fixed by hardware design. Total delay is
> +      calculated by delay-step * 32. A value of 0 ps will disable any
> +      delay. The Default is no delay.
> +    default: 0
> +
>  required:
>    - compatible
>    - reg
> @@ -85,6 +109,9 @@ allOf:
>      then:
>        properties:
>          resets: true
> +        aspeed,scu: true
> +        rx-internal-delay-ps: true
> +        tx-internal-delay-ps: true

There is no need for these (including the 'resets'). Really, the 'if' 
should be negated with a 'not' and this part dropped.

>      else:
>        properties:
>          resets: false

But you need false entries here since these 3 properties are just for 
ast2600.

Rob

