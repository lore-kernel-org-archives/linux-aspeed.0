Return-Path: <linux-aspeed+bounces-3618-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D42CFC9EF8
	for <linux-aspeed@archiver.kernel.org>; Sat,  7 Mar 2026 10:55:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fSgD847RSz3c9x;
	Sat, 07 Mar 2026 21:55:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772880936;
	cv=none; b=A9bFQqonAigAJIYGjIKYHqWcYpcihO/Q+/LZICA8m+QHt4FRhRAB7QaoJAuahBCpFRtivGch79zdRbEJzjSN8Dqb+Lyl0sEgnWz30iJzLpi4kOxUrFduJqT4w08p2Fic0NGupOYfwYwXrWxxB3sANN26nZD4BFCLwUE87PP/EogKl335In5+nTqBWNzu1GfqsUKDxFEW3a+goIcA0L6k5LRVI6Fc6aIwTJCBO5A1XI7RHsrp+sJmIrxIxS8WhHGZWKGEJJ7/YHaBL4GVIS8BrNIX+M5WLvaO3DfvXCLcsm9gE90qVJtejPxAq32v1BkHFY98U7EJ9pj7OnD8u5P0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772880936; c=relaxed/relaxed;
	bh=VPjCzpZwhzvEIRjxFR+lnnsQkRJjsbFMQyF1ixNeFiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY0dcihN8t6BiPxtv1Wk/zECjgxwXPiL9MOMByQ9330BLyUElmBdp4z4CkFsi+KTZbKIdaINJUHNhu69Z80/+tAX3VV1iElIDJ/z5f4Hnu0VdOVvcbAU56EszeFoCN1oL9ZeVI9c0I5hynwxTzb8hAKVswmK43/negZ1Ae7mDdxzkA+5SR3yNXYM0d6R7ytIjTNS2C419Wt+kVesGp56yWC2LuCkgslg7g21LXQQngFGCaXwUppKha89vXUQdMKxFCeW6ek7tr7PK3W3E+dKZdSjl1DkSNpOS7gyvvE+HYnQvhWtXffqi6BhWBVcSv5Vgzj5qwofGklz3+GcXbHfcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gBwF1jya; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gBwF1jya;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fSgD76Rtfz2xT4;
	Sat, 07 Mar 2026 21:55:35 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A88014095C;
	Sat,  7 Mar 2026 10:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC4DC19422;
	Sat,  7 Mar 2026 10:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772880933;
	bh=0owm4mKObWbnUeGHMN4y2SQdPXnXIhv9skTRR518J/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBwF1jyaAvo+N9jckDoGQIt0wrQcCufpP7DMH9TRanNgHbvOTlB96BFmvXNJL2fQz
	 eTm/ZClYSUzv5tAxOhY1lKB+Wqxr8/XAPSofHt7JHe3VMZs2UTSzqmD+aaLvp9b4TU
	 JwmwqQrBFm1rTXolEfdIeDvaenB8Lo0XGpK8/2doz9If0QCrrityNU9A2wSdM9wbUc
	 SvWF92XmE5YttrtY/S+gGPj5ksxJ+QsPG4Fhp+OHBftrI0nmV0AUHUDnsH8w8lIaZJ
	 WbWdogZaLuawLZ/n7metr92eUMxo4zfwA6lB/LXyaCyCFO1pkzsPHHTuen2Zu0SPe3
	 vUVl6OT8W6B7Q==
Date: Sat, 7 Mar 2026 11:55:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: pinctrl: Add
 aspeed,ast2700-soc0-pinctrl
Message-ID: <20260307-weightless-quirky-spoonbill-dacd89@quoll>
References: <20260306-upstream_pinctrl-v4-0-ad4e8ab8b489@aspeedtech.com>
 <20260306-upstream_pinctrl-v4-2-ad4e8ab8b489@aspeedtech.com>
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
In-Reply-To: <20260306-upstream_pinctrl-v4-2-ad4e8ab8b489@aspeedtech.com>

On Fri, Mar 06, 2026 at 08:40:26PM +0800, Billy Tsai wrote:
> +          - USB2BDBP
> +          - USB2BH
> +          - USB2BHBP
> +          - USB3A
> +          - USB3AAP
> +          - USB3ABP
> +          - USB3B
> +          - USB3BAP
> +          - USB3BBP
> +          - VB0
> +          - VB1
> +          - VGADDC
> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +additionalProperties: false

I guess the mess with examples is partially my fault of imprecise
feedback. Rob asked you to add the example to main MFD device, but:
1. maybe he assumed there will be separate binding for parent device?
2. you added it in wrong patch (pinctrl patch changing MFD!),
3. it was also incomplete that time.

The example - if you tested your v3 - was needed to actually validate
and point errors. My bad I asked to drop it.

So now you have a mess - incorrect, non-validated (example-less) and
maybe even incomplete binding.

Please post complete ast2700 SCU binding - what children do you have? If
none of ones mentioned in the binding apply, then why the binding
mentions them? why do you allow p2a if 2700 does not have it? And
smp-ram?

And if 2700 has silicon-id, interrupt controller, pinctrl etc, then why
none of them were present in the example you added?

But more importantly, none of this was actually built tested/checked
against DTS thus I cannot accept it. We are back to basics... post your
COMPLETE DTS somewhere and provide link to it.

Best regards,
Krzysztof


