Return-Path: <linux-aspeed+bounces-4000-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60737CD342F
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 May 2026 01:31:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9HsV6BpPz2xfB;
	Wed, 06 May 2026 11:31:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778031086;
	cv=none; b=hZHuN/yIB+xLlrTN5LYd1XAU9CWVRQquePinkiwUFFgbRhJTd9T4SBD9U0V8majElsEwT6fq90Fp+oPkk2KCHPkn5MxpXI2JZOkcLIWPgAW6ngFTFFhYR/iV46kLXy43osCuuiM3Cuu4a4I2N88q+Rc5y5hauneXtFCJWYeguYVWSuur7+ySbyD0ceeZzWmrkyLkxAFWL30sUOoriPHfNCs86PWyKAedCOJQtrRGbwc4hRPXfsDMXAjYcCiziyXQowc1lFQmbfJ1oFUY9pXzpPPKpb+XGzPNh9O0PII9Yt1ObEKgndI3NjFCwzP4A8bJn4GRESUoQg00EsqL0ir7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778031086; c=relaxed/relaxed;
	bh=j5DW3jTO9eA2U0B2B7EG/QgJNumeWedc8beO5QJcqXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxc4YtnzCt65Ke1ZoXIuxJ4FDMa6yguO1HDI8a0xG8eHacjKVpVsXteF1hbt1FMLLuRJuF635R76Ni4zwSjhLf/MWmFPX2YxlWOUvDpgbWKWND311o6AlIekjyIJArZrWhdmozHCBx1vOVy8Vgz8RunIBcqmNcst66Dk+o1HVjXNYMoYAAFd/dSFCreUyJA/jaIhuSF031VHr/EoJr8nKLZKaoQEK0xVWSB+9859v3KMRuwvigkVxIY8oT/8TLdCZEyOCewDh5j+r2x9tWFP3L8L8SI2yvmBhqRqvJcJsKwXtfwEhq2F/YkNXVQsUNIf/Jt1TTzaYOvx5fEFvv/p2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=epU1cA3k; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=epU1cA3k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9HsV1H0Jz2xdR;
	Wed, 06 May 2026 11:31:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 66FD460123;
	Wed,  6 May 2026 01:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7982C2BCB4;
	Wed,  6 May 2026 01:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778031083;
	bh=o2yy2Ww9i8w4gC0U+2YoW4VSEUxmrqIBx+Xo75LoX1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epU1cA3klIDMZmbe9hL+8MnWKyObxZIooq0sRL5JIKYas2TmzTa13g2/yv9VuZORh
	 XrHPPoRbcsnHfg4TqGwOgeCFlTeURJINvzMu2iCR2/YvAzu/GWB4k3bPYWJlGd57V2
	 4lu5djbXVU+F8w/WNmPawGsGNd3xbnUMQseazanwywzbZGsjjb/lWO/y7aAGXgFO7Y
	 ry+7LBHj2eJf2Dxs0v3HVCA5uzHLHS0ffezdvR08F2//BiYMEAw5ISIBm22osmymHT
	 mdSYe+cipA7QnicXft2QLiHe6IUR2ugzpVw+AmVHdnwVYw3WbNZ3+S2GXaZ+VCzx6I
	 V2dWtoXGE99Rw==
Date: Tue, 5 May 2026 20:31:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-clk@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 2/3] dt-bindings: mfd: aspeed,ast2x00-scu: Describe
 AST2700 SCU0
Message-ID: <177803108003.262903.4940784340519563848.robh@kernel.org>
References: <20260428-upstream_pinctrl-v8-0-eb8ef9ab0498@aspeedtech.com>
 <20260428-upstream_pinctrl-v8-2-eb8ef9ab0498@aspeedtech.com>
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
In-Reply-To: <20260428-upstream_pinctrl-v8-2-eb8ef9ab0498@aspeedtech.com>


On Tue, 28 Apr 2026 17:49:46 +0800, Billy Tsai wrote:
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
>  .../bindings/mfd/aspeed,ast2x00-scu.yaml           | 114 +++++++++++++++++++++
>  1 file changed, 114 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


