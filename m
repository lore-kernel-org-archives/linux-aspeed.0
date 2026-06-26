Return-Path: <linux-aspeed+bounces-4309-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8210CDE011
	for <linux-aspeed@archiver.kernel.org>; Fri, 26 Jun 2026 12:30:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmw490THYz2yVv;
	Fri, 26 Jun 2026 22:30:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782462086;
	cv=none; b=HWCPR9uIVreJ1A5bFZPY8Kn8FIqsViYqu6onj2cVLz1cgUch0lIPv46UyA7YJKOGZsearjWFX2ELkkheP78ZNJICLibN8Ked8H7/s3dVw3pEkZLVz8HLkXcoSUXuGeEXm0C0HvYVNYdnQapUL13xIzOE//vfF1RInuB/w0TZaizwgsY1FWavFWk3AcTfNd+Mm6V2tQ+ff+3gdz6h4xTQbDTUYhFqKOv+Pv9xkZxU32wPUJAfknn7Etd4U/k4TtlKIc2L14Ptd3bCjQfqZmR9UgnNdTzCyD3OXpTw0sbof5/r1777FEgO3dEeP7RxPJ1dVUIIYgVaXqsMtgEZfex2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782462086; c=relaxed/relaxed;
	bh=Xf3kAwe5ywIQY//rN3h6sBdlm1lF9rusVsWktLYdFkk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ig8FvfoInWJh1+6cakIEqYk4HkgwAiNCvR7FuEZbTCJf+3WZbprYILI2eMYV3Ql7sqMHGR1PO+3BhYF39ZuUDEVPdrpr18aP2lZuAv5G82DAbxZXza+DITPxKm/PseqHYm1RXcdU5lI85+fwxBC4H6WDlIjemI91SCrg0Vp1j9XpPQG61vOijz9FFPRIu8CkjjPoedSX3lnHlMKioUDDpNbjm/je5d5Un4iBrQ5IOUFNglS10GCo9WW6pW8uQgKagozhyDE0ds2B6P52DQAbEsMpeKHLMC43cOYa+VL7vt88V0yunM/UNaAns3QKcLYrkCVXpit/mJ75u54m5P5fgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aA/AaODJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aA/AaODJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmpXy56NJz2yVv
	for <linux-aspeed@lists.ozlabs.org>; Fri, 26 Jun 2026 18:21:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C90A6021E;
	Fri, 26 Jun 2026 08:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0AC1F00A3D;
	Fri, 26 Jun 2026 08:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462080;
	bh=Xf3kAwe5ywIQY//rN3h6sBdlm1lF9rusVsWktLYdFkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aA/AaODJC9hNx87l7DWmFqF1ycvUQDGXM6GzZfkNDnaN83wpqMr7NjTKa3W749koe
	 hwI7hQleW1NVEl2PH70tTqE+TBtvDm8AwRL2dm6Hcj+k9PQxhyaItrC9HsLeyyIqR0
	 zndpM5dfZUZ+rxd7ac/2X/rhEe3gGN3uSkL1j5ZvFuZKkz4qiMsVS0UdRBcW255bmd
	 B7KThCYiQMxkacYR+Lx1CIiiqfC6QKOcMNcIWeEeOhqYwGxKSKPiOIfXmLesV17yR2
	 Odx/7NmU+bJ7ZzRHg/3Xun0PK3w6/xBip2pDM77MGz/xkgB+IWxpgu7gJukMW3wPcN
	 lLNjFjZn/RKUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5695239389E8;
	Fri, 26 Jun 2026 08:21:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 0/4] Introduce ASPEED AST27xx BMC SoC
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246206701.3816447.15009741745882675380.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:07 +0000
References: <20260609-upstream_ast2700-v9-0-f631752f0cb1@aspeedtech.com>
In-Reply-To: <20260609-upstream_ast2700-v9-0-f631752f0cb1@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: linux-riscv@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, krzk@kernel.org,
 alexandre.belloni@bootlin.com, linusw@kernel.org, fustini@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 soc@lists.linux.dev, conor.dooley@microchip.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Arnd Bergmann <arnd@arndb.de>:

On Tue, 9 Jun 2026 10:47:17 +0800 you wrote:
> This introduces initial support for the Aspeed AST27xx SoC and the AST2700
> Evaluation Board (EVB) to the Linux kernel. The AST27xx is the 8th
> generation Baseboard Management Controller (BMC) SoC from Aspeed,
> featuring improved performance, enhanced security, and expanded I/O
> capabilities compared to previous generations.
> 
> AST27xx SOC Family
>  - https://www.aspeedtech.com/server_ast2700/
>  - https://www.aspeedtech.com/server_ast2720/
>  - https://www.aspeedtech.com/server_ast2750/
> 
> [...]

Here is the summary with links:
  - [v9,1/4] dt-bindings: arm: aspeed: Add AST2700 board compatible
    https://git.kernel.org/riscv/c/34efd73379ff
  - [v9,2/4] arm64: Kconfig: Add ASPEED SoC family Kconfig support
    https://git.kernel.org/riscv/c/df6f379eb4ac
  - [v9,3/4] arm64: dts: aspeed: Add initial AST27xx SoC device tree
    https://git.kernel.org/riscv/c/e77bb5dc5759
  - [v9,4/4] arm64: configs: Update defconfig for AST2700 platform support
    https://git.kernel.org/riscv/c/512cef2af615

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



