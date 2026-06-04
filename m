Return-Path: <linux-aspeed+bounces-4186-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D15CD6E4A
	for <linux-aspeed@archiver.kernel.org>; Thu,  4 Jun 2026 16:16:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWV7t21YYz2yRC;
	Fri, 05 Jun 2026 02:16:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780589818;
	cv=none; b=Wfzt1JklmGvcg57IY6UxpeqeTpVmB/FD503Pb6V65acd0spk58LAyiMQjYOrTln1qYT8qXufOg79eKUgJxyIaruEkQZ5qrHVIVJXXUt5bunQMz50B1uoZgHmA0Sty0yjjprQPqRxZPIawl3dK6Oe20h6gRi+OS88CYT5j3IrnSDbQ1FACmZWacW4ZU089HBTSiCCVIuRqmrjk52bckWE6qygcjwK9t9h6cM4Rjq9eUsWKj5lEBvAqtbnY5XP2XhWzj7Ec70GnYmIoaOMkZpR23Tmpk0fEKjpd7swR175ax+7b20nBJGHYU5KrR7gmJHe1+aTsknNU4A7qPBEjJ+TzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780589818; c=relaxed/relaxed;
	bh=K2gTdGqeWQGOtaG+ilrpEBWckxkrsv+W6qkg6Sctvwc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lLkZzCbCeJ8mnLoqdW7fwHFtg0xnomeZQ/nFWPLQcCtf+qO8kLHkAMtWUoHq0gOOJACaBpYayOstY9ZiXzRIabLuzD/ROSqNSuqrZxtnZgKaSrrgERm2u7rphrwpqPPDcV8+pIHHSFwHgKzosScwWInmyRciJ7Jo+FuMi0qfh8Kn1MCPCw5TF76Sb1gkGw5D/tdVqIYW1gLCkET8Cn97wrI69BmbF3/a6Wzo3aa+0hooGzRIXCcLLRHHh43Zd2GtBMPgorXzABa/xE7Ywyct6kmYL11v+FsKkJ7A7mt0aQGMRbLv5vC/tUGuEO/qo/6vGyTAf9wh8cLTtLO6xOgwSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvJF/1yG; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvJF/1yG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWV7s1byPz2xfB;
	Fri, 05 Jun 2026 02:16:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3EA7E408E2;
	Thu,  4 Jun 2026 16:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9DB1F00893;
	Thu,  4 Jun 2026 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780589815;
	bh=K2gTdGqeWQGOtaG+ilrpEBWckxkrsv+W6qkg6Sctvwc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hvJF/1yG1XBu/K1o5Van8/R29t0hjvN6UK73WdFPAWIBQRbzgDf6IMMlRCY1/oRJJ
	 ymKdiIiVoGnG0Q5e0r5augl4QYSwcTAAN0USPUavLbLYXW7IMqkDrPvD1VkgPmNMZI
	 6zLNL3lnYeSgd+fzJBLYnZURLAC3YiZJ06p1BLu1F0ckRe6UdJ9JPcPRkP4KFCX8WA
	 FAgImivvlr4NFgte2uRi/9o+110jq8aPIVqUgXSKx3npwrqo6z+mNnKrLFuCzsVziG
	 CahWhFZUc8/T+K6dyonjTQXjiREXe8yUy9tBQWKnD5F65R7IN6h8MNyb330PBh7Iza
	 giMd6Vyi9eDWQ==
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linusw@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Bartosz Golaszewski <brgl@kernel.org>, Lee Jones <lee@kernel.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: patrickw3@meta.com, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 BMC-SW@aspeedtech.com, openbmc@lists.ozlabs.org, 
 Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260521-pinctrl-single-bit-v5-1-308be2c160fc@aspeedtech.com>
References: <20260521-pinctrl-single-bit-v5-1-308be2c160fc@aspeedtech.com>
Subject: Re: (subset) [PATCH v5 1/3] dt-bindings: mfd: aspeed,ast2x00-scu:
 Support AST2700 SoC1 pinctrl
Message-Id: <178058981070.94985.5862783114211800915.b4-ty@b4>
Date: Thu, 04 Jun 2026 17:16:50 +0100
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

On Thu, 21 May 2026 17:17:44 +0800, Billy Tsai wrote:
> The AST2700 SoC integrates two interconnected SoC instances, each
> managed by its own System Control Unit (SCU).
> 
> Allow the AST2700 SoC1 pin controller to be described as a child
> node of the SCU by extending the compatible strings accepted by
> the SCU binding.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: mfd: aspeed,ast2x00-scu: Support AST2700 SoC1 pinctrl
      commit: e78aa289e86e3e5da6fd115e6a0faf1623bacb05

--
Lee Jones [李琼斯]


