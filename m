Return-Path: <linux-aspeed+bounces-3879-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B111E9DE58
	for <linux-aspeed@archiver.kernel.org>; Thu,  9 Apr 2026 07:30:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frs6C6Ckrz2yVt;
	Thu, 09 Apr 2026 17:30:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775719827;
	cv=none; b=RDT746Vev5Anp4C5i4DIZE2N821DZmRqJvZ9vbYkXVM5T5KOU2GYA8twNJSml4tcfGPF5skGpdSegsop0O5UYMe7Nq1uPmaDwtAgIoyDGD41Jx4ya8LqOWb/4SA3fvVMW0Ytag/hvfIQyVHhTsuP7kF5Cx2/aeR60RY9vJDsT7SWKRlsY5XXUgof1z4yCs0PlPtL7g15nPRoeHXcvw+eOm2E0dbAzJEWQeip48P7XnjziyKmoVA77+MG8qvV0v0KKvUcxSR1+NEewNH/IMKemT4CG9Db08FjGInHEN/PQRg/Rx1E8WoCGe/BtyvK+f81l4Bg2lW7lkCY9mrfihi4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775719827; c=relaxed/relaxed;
	bh=BT4K2Zf/nxxoglAtguOwCkdFi7MIc2xLvXbL9RRrrX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpYepLiiSTyoMV2tLOOqo6pOZ49ZNZLvQwoZq/027YHenjEKBy5a+LBYPnsqgDsfuOeCxyj1JnmA0mwkqhBQ3g/R+K3Nn5XyH0H1Unevs4DMxIsKR4uNxDSYUfqWJfYe19cUsr+H8V1CLvTLMCLDjc4OBDqL0cF9E2Wc4BfwnZ2ew+736h/3gd4VGXXKZw1heBhEapNvv4qus1+ZJqrc22hk5mI6YRhYhXEFRjUFKrsNVfhZZZ38kxgoSVfYL9SwASqhfnYcvSyRHCU1xeqsSWwrbj+ZB5g1Gm48kk6s7T7X+NS0KICDOeGDtghSPi1R4gqLqFAS/tUXsgTPzbTS9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ubxdOzey; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ubxdOzey;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frs6C1GgSz2xTh
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Apr 2026 17:30:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2443D600AD;
	Thu,  9 Apr 2026 07:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4827EC4CEF7;
	Thu,  9 Apr 2026 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775719824;
	bh=vwghWor8OZe17SmQaOpkWmuy9YBmg+3I3XnkIV/bOig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ubxdOzeyBTj+xJL5QphQ13nGFi9Y7uZlWAPeqOQVhIbTssTm5eLVRQfZGM0zCNBP2
	 CuRqfybrbijyPd2NCt9JaXYmSRYiI+ObSkFP89QOPazz6ZKGRlwC2BRRg2LiIaUaUZ
	 vArBk2OpZRCUFWnWxD69y3CShwa7If0gChD47f9b59ibWotr1kowXE7gOoXaP96ymj
	 54R8bO/ZzzCjyDS9y8Rz+ge2M0HXiDnncQGdtibon+vRkHEb4oU3l/o8DpRgUrUWHc
	 D8dbVIw99xyu5lXojtVjYkysEKG+/bjMk4o1ND4HSjv200ODdMIcbC6ixGTeiVhdRs
	 2NXKxf8/6xyoA==
Date: Thu, 9 Apr 2026 09:30:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dawid Glazik <dawid.glazik@linux.intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org, linux-i3c@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Frank Li <Frank.Li@nxp.com>, Maciej Lawniczak <maciej.lawniczak@intel.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>
Subject: Re: [PATCH v3 2/3] ARM: dts: aspeed-g6: Add nodes for i3c controllers
Message-ID: <20260409-massive-natural-crayfish-c1cf2f@quoll>
References: <cover.1775679285.git.dawid.glazik@linux.intel.com>
 <51c4bdc02b45f67a0e32610a228091e137c135a6.1775679285.git.dawid.glazik@linux.intel.com>
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
In-Reply-To: <51c4bdc02b45f67a0e32610a228091e137c135a6.1775679285.git.dawid.glazik@linux.intel.com>

On Wed, Apr 08, 2026 at 10:34:34PM +0200, Dawid Glazik wrote:
> Add the i3c controller devices to the ast2600 g6 common dts. We add all
> 6 busses to the common g6 definition, but leave disabled through the
> status property, to be enabled per-platform.
> 
> Originally-by: Jeremy Kerr <jk@codeconstruct.com.au>

Don't invent tags. This is not used outside of TIP.

> Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
> ---
> v3:
>  - add i3c aliases
>  - rebase on top of latest tree and solve conflicts
>  - as agreed with Jeremy off-list, he said I can take authorship of this going forward
> v2:
>  - use inline bus representation, without the i3c: label
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 97 +++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> index f5641128614f..f986fcbed604 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -29,6 +29,12 @@ aliases {
>  		i2c13 = &i2c13;
>  		i2c14 = &i2c14;
>  		i2c15 = &i2c15;
> +		i3c0 = &i3c0;
> +		i3c1 = &i3c1;
> +		i3c2 = &i3c2;
> +		i3c3 = &i3c3;
> +		i3c4 = &i3c4;
> +		i3c5 = &i3c5;

Bus aliases are not properties of SoC DTSI.

>  		serial0 = &uart1;
>  		serial1 = &uart2;
>  		serial2 = &uart3;
> @@ -1066,6 +1072,97 @@ i2c15: i2c@800 {
>  				};
>  			};
>  
> +			bus@1e7a0000 {
> +				compatible = "simple-bus";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x1e7a0000 0x8000>;
> +
> +				i3c_global: i3c-global@0 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).

Best regards,
Krzysztof


