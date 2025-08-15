Return-Path: <linux-aspeed+bounces-1979-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE55CA0EE4
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Aug 2025 21:19:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3Zjv5LdQz3cjT;
	Sat, 16 Aug 2025 07:19:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755292755;
	cv=none; b=HR916JaV9Syp8+99Q977V59EOmUJ9bCM+fcnQKSubFvNyJq2L6MnbhTR1yzZKnAmmN9TpwyQiCaDoxKKQ+ZODdI4xXPJjKxkNqVfutMqH2Peraf/G11YMvbHumOu3O5sVhCslu0UXSbpoCy7Zu+KBxoKxnXXppL35AlPjNtLoFX/GlPhgdq2tgh8Q0UtscGn4rGC9e7/dVukesRGF+5YuOufvYknE/X1hlJvhBMldk2/a7bNzjU/6cIXAB7Rv/m/XJtlBMok9EfUaYOdBJ5uuxUbYOOzMATayK+nDkA8Y3ZB+HEXuLHQDnceVZyefsUJSCbVH1BJM6ACmKmzdq+qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755292755; c=relaxed/relaxed;
	bh=ZvE7HcSrm1TIupvk7fabk+Gqg2aIlpj0qnYEvjTM0ns=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ig2LPE9GdmfFn0hkUEulqzDjoPicA54+In/fKejPRQWVk1Sdiq6f3VPQoGb7dRFl0o7oQta7NyQfpDFlk5LM/I8e79o15YwL7x1maqU9Lk11FG6tuioWV2ym+y06yIyPgSfY9fPg09wcHXAJ85wvP0eOGpw0ZnzgtwVO3I6+YtHxGlSNoeUpaLqQGbTssH07Pq43y+WSkBaPt9yhGnYwHjcCZYeAlhH0PUFkyy6dLx4O5EYNyMpq5vWfUKiYLSGNzCEGqEnLo8R5yZ10W9+0mABchxqcM0L76z7NLd5W3Q6sR9TDgIvg4bavT/3zzD8ZcnOKz1DW8ujkO6oY0Lo6gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IsEt8QSy; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IsEt8QSy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3Zjt2gkzz3cjQ
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 07:19:14 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FB5544D79;
	Fri, 15 Aug 2025 21:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C7EC4CEF8;
	Fri, 15 Aug 2025 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755292750;
	bh=K+r06jLu5/QfCZbN9piqdk/fiyOGa1TyF6QkY5xklXQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=IsEt8QSynFtXD1ppIMy6AyN46/r047g46cJcO6Fnm0A0yh+84FoNWyizkrNntmYrF
	 ATInUU6ByuKliIMsIlocgSgfhe3f9NlYYwlHwfqu2l38TqT3oNT5wjjLvFz+ZXFzC2
	 2fCGv0bWrWRoWzkMr4mrdHq2+Zt0OWylWuHhgrAgWXxSyQGGz1ijTdIV92JC3bm4oL
	 GEokvA1QfeE6WIhntjac/k65bxdohAqh+eu6Dl1yGHAsfueEViFyG4JeH4OgelV5Pf
	 A+rmN0XB4RvY314InNBPak8WyZCgfHH0D7XfYVfoT8jdVlGDAWvmrOXO4gEFKfMC0a
	 yu7t2cPtj11Ew==
Date: Fri, 15 Aug 2025 16:19:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-aspeed@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, Joel Stanley <joel@jms.id.au>
To: Fred Chen <fredchen.openbmc@gmail.com>
In-Reply-To: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
References: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
Message-Id: <175529259974.3212367.16366822597087067588.robh@kernel.org>
Subject: Re: [PATCH v2 0/4] Revise Meta Santabarbara devicetree


On Thu, 14 Aug 2025 21:16:56 +0800, Fred Chen wrote:
> Summary:
> Revise linux device tree entry related to Meta (Facebook) Santabarbara.
> 
> Change log
> v1 -> v2:
>   - add 'bmc_ready_noled' LED and update commit message
>   - add sgpio line name for leak detection
> v1:
>   - add sensor nodes for extension board
>   - add mctp node for NIC
>   - adjust LED configuration
> 
> Fred Chen (4):
>   ARM: dts: aspeed: santabarbara: add sensor support for extension
>     boards
>   ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
>   ARM: dts: aspeed: santabarbara: Adjust LED configuration
>   ARM: dts: aspeed: santabarbara: add sgpio line name for leak detection
> 
>  .../aspeed-bmc-facebook-santabarbara.dts      | 857 +++++++++++++++++-
>  1 file changed, 853 insertions(+), 4 deletions(-)
> 
> --
> 2.49.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/v6.17-rc1-9-g8e4021078863 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250814131706.1567067-1-fredchen.openbmc@gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dtb: mctp@10 (mctp-i2c-controller): 'label' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/net/mctp-i2c-controller.yaml#






