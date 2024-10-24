Return-Path: <linux-aspeed+bounces-27-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E32CE8E7C
	for <linux-aspeed@archiver.kernel.org>; Thu, 24 Oct 2024 14:10:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZ79r0jSLz2yLV;
	Fri, 25 Oct 2024 01:10:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729779055;
	cv=none; b=euAkydjVS4FSGxqJmCQK82C8Ln/eICQw4cnqBEIkhwgTpBmjVZ4xBjhqNcmgu9ADnOToiuRT8VMK1tRqWDJv+lzFtQwGwqeuTy2j/yjX+7E8HhJST3GG7h5gTt6tPoCewPR5sDZIlsDddPou7+2bQUWv7aJXNJuADIY9NNgJ7vxC/RpC3sxixN9OVwyq2ZKBiRKI5IFKwAovLenNH4jMOkWK0wN6s7Nzy0ilxcmEJMa3Fm2zFAv6ie9xclByx4AnqIPLf2Iss3AaByAIITYrHIj6/+fxU7t/m3pzPoVnQIFy8lkOnGuqWVtYHgI7HSK/qH/Zeu/RoThCF0UJVnsrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729779055; c=relaxed/relaxed;
	bh=0oZ0Ac+x+u3ydNa0cYENMIYLIzmnwWSTLS7vwsd90kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McKeKiyVcWm0fmDzqjbjWha8S0RDzi5E+386bpBaJGfPJNaqR5xppRCoRTSDYmoJOXaIDOmxvswAeZ2EqAnZtIZv0pqICwRjSeCtYVi/8uKet9bE1UxvYvGcyiJIHHOOKp0QfT8zif/XxJ9iAdjm/u7w1c0tTQMqBy5rPAOJv1yPbgSlYB4Ct/DCRCvrDL5+71BtUs7VisOpobvPwiQvX8KQn6qA3dVkjY7MDELOaRdJ2waKmIytJuX1CCu5KWvkN7Z/hS7yBGvYVQs4POJD7KBOwWPKsfT9Ofm0hrJ3C/6NMXpxs9VUpv9eb64pk+0ZeHIyofZtBAH9gfbXWGarMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZaXSy15T; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZaXSy15T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZ79p6Gdhz2xrJ
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Oct 2024 01:10:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 63AD55C4B6A;
	Thu, 24 Oct 2024 14:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C82EC4CEC7;
	Thu, 24 Oct 2024 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729779052;
	bh=krhQtm4zm/FOYnIE/tGTH1SAlqRa2tX6XY57qn26xao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZaXSy15To3yTWqZHs3NhtB2LSgH6UAKPlDgAu9RHa7JIE32YuivGXDueV4FJsc0Tw
	 lRqaPHtdG3qBZYD5Qa1rFHI60A/Ycbt1R3a0Tvi4UHj/XI79cjebGX+eXnhOtMxebT
	 LoVkkICu07poQAwYKfRkUyk5ghneAKiIaEcs7Y5cUeRXiNWO8eTopBCuATsoWN8OuE
	 3htET69XX7c7wzvKmIDpHgkiikShCdERETvy10+a/a4DeA1uG3N4db1hJ5VMJ3olRw
	 kH3yqNZuYnYbEr90UV3GeLXvIRW3KNvQZ740p0vydbItEgdY/nMt1vF2bvHHOnMyUn
	 ZO8TO5vQq8cwQ==
Date: Thu, 24 Oct 2024 09:10:50 -0500
From: Rob Herring <robh@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	ukleinek@kernel.org, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v1 1/2] hwmon: (aspeed-g6-pwm-tacho): Extend the
 #pwm-cells to 4
Message-ID: <20241024141050.GA246869-robh@kernel.org>
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
 <20241024071548.3370363-2-billy_tsai@aspeedtech.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024071548.3370363-2-billy_tsai@aspeedtech.com>

On Thu, Oct 24, 2024 at 03:15:47PM +0800, Billy Tsai wrote:
> Add an option to support #pwm-cells up to 4. The additional cell is used
> to enable the WDT reset feature, which is specific to the ASPEED PWM
> controller.

Use subject prefixes matching the subsystem.

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Change-Id: Iefcc9622ac3dc684441d3e77aeb53c00f2ce4097

Drop.

> ---
>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> index 9e5ed901ae54..0cc92ce29ece 100644
> --- a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> @@ -31,7 +31,11 @@ properties:
>      maxItems: 1
>  
>    "#pwm-cells":
> -    const: 3
> +    enum: [3, 4]
> +    description: |
> +      The value should be 4 to enable the WDT reload feature, which will change the duty cycle to
> +      a preprogrammed value after WDT/EXTRST#.
> +      The range for the fourth cell value supported by this binding is 0 to 255.

Wrap lines at 80.

>  
>  patternProperties:
>    "^fan-[0-9]+$":
> @@ -69,3 +73,22 @@ examples:
>          pwms = <&pwm_tach 1 40000 0>;
>        };
>      };
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    pwm_tach: pwm-tach-controller@1e610000 {
> +      compatible = "aspeed,ast2600-pwm-tach";
> +      reg = <0x1e610000 0x100>;
> +      clocks = <&syscon ASPEED_CLK_AHB>;
> +      resets = <&syscon ASPEED_RESET_PWM>;
> +      #pwm-cells = <4>;
> +
> +      fan-0 {
> +        tach-ch = /bits/ 8 <0x0>;
> +        pwms = <&pwm_tach 0 40000 0 128>;
> +      };
> +
> +      fan-1 {
> +        tach-ch = /bits/ 8 <0x1 0x2>;
> +        pwms = <&pwm_tach 1 40000 0 160>;
> +      };
> +    };
> -- 
> 2.25.1
> 

