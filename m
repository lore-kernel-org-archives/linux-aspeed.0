Return-Path: <linux-aspeed+bounces-4109-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA08CD4F3C
	for <linux-aspeed@archiver.kernel.org>; Wed, 20 May 2026 16:19:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLGw45HWRz2xrC;
	Thu, 21 May 2026 02:19:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779293988;
	cv=none; b=UvYj9Ijt2b/RAmcNlqjvr2siEsVOHRcOn0J4+Ye4285l+DMNwm4sr/DWCjyq2tS5WvDOPGFD44EagBAEBHYJd12WMrzOMi7gg2HI79zL7V32eNZZ8q4ofAfXC0AivvrsjoNJwSeIT/glrxJRzsJ2CLJiocs2wgrmugtAyF12KFQedNEQW+1dTegh5/Tf3HJOJuqYJOidX0DDKgrgC7XY6OOO1hWchXONytXt5ScPAJ+We7fZzOIq3Mmh1AhP9YAe+7eK4f7vRmxAgiRm6/7/8wONCHypqPVkUi2yP2VxCTFa6SFoGoFfWYIMqbmPaK+BStumb70e2SVwmBuG08usUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779293988; c=relaxed/relaxed;
	bh=lcFr4GXWcFgpdMsR0YpSiDmQfe7WFM8ih6yZ4Ym8toU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n5DUPC9mD6jB6oLjJMgLkKMT1WQGYtmWC8emeKl+fNxBgl6b/rctTLl7JG320HPvL57oxrVGpTIEqSNZ9U+uSqEjuT536DNPUwtS/AQoDzDU77RNQdSFa8GIO06VmeMoZDtRPL/jNabHta7XwmSWZq0KcQN8f8yjJyxyKg4aeM2MMOtzRrgUOVRm8XU/y6LOnmH0HwDeFvSrL7FBL/zMY10BX9oI3ptgrc1bS3VgUVI2MUvRozv9xigC7fcGURRqNv244ajTZM1pXC28agxBSu6q7T5UvTg4X6p3Q5x1cPDnhIaBOmcRl4mnxPNB7/AXISVCJdILH9tmnRKjVfCDFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAbLHAkM; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAbLHAkM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLGw35Pchz2xqJ;
	Thu, 21 May 2026 02:19:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D16B640D73;
	Wed, 20 May 2026 16:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028501F000E9;
	Wed, 20 May 2026 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779293984;
	bh=lcFr4GXWcFgpdMsR0YpSiDmQfe7WFM8ih6yZ4Ym8toU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UAbLHAkMzuHKyLBGmWUbQOs1aRHHDL4buL7lBKmWTcjjvxVBgQPLHprxAqsF0xcVC
	 bGKFfJBqOhqCGgDyy+ZeE7Cvs3/zqfwhfMtvgQBpaYOLpMsWhSUkr+inXRso39D2HH
	 35afQ8qh3ik7eBX1qIVmbWCfUOycl8BqgtCseG9AZXKUZsSnFUUAkYlal+px4JYbNB
	 yzc2vR7biGKHAB8QCHN1Egl9918+SWHhSvHDg/HFiIQFrkABXa22NhBJvwkquF8R7h
	 N1BGOkdt9V5etiW5CXhwg2li86PjrDc9/rsXD8e+8gggRh/MA2+WG9weLIL+uonrdH
	 bn3+qSLtmsw0Q==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
 linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20260506-upstream_pinctrl-v9-2-0636e22343ad@aspeedtech.com>
References: <20260506-upstream_pinctrl-v9-2-0636e22343ad@aspeedtech.com>
Subject: Re: (subset) [PATCH v9 2/3] dt-bindings: mfd: aspeed,ast2x00-scu:
 Describe AST2700 SCU0
Message-Id: <177929398073.2887671.10050314935691000480.b4-ty@b4>
Date: Wed, 20 May 2026 17:19:40 +0100
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 06 May 2026 16:06:19 +0800, Billy Tsai wrote:
> AST2700 consists of two interconnected SoC instances, each with its own
> System Control Unit (SCU). The SCU0 provides pin control, interrupt
> controllers, clocks, resets, and address-space mappings for the
> Secondary and Tertiary Service Processors (SSP and TSP).
> 
> Describe the SSP/TSP address mappings using the standard
> memory-region and memory-region-names properties.
> 
> [...]

Applied, thanks!

[2/3] dt-bindings: mfd: aspeed,ast2x00-scu: Describe AST2700 SCU0
      commit: 0aac47aa41a1f73752fe3993526494c6df013eac

--
Lee Jones [李琼斯]


