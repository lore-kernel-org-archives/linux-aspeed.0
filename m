Return-Path: <linux-aspeed+bounces-2037-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6B4CA0EEB
	for <linux-aspeed@archiver.kernel.org>; Fri, 22 Aug 2025 13:39:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7hBg0YBQz3cgJ;
	Fri, 22 Aug 2025 23:39:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755869995;
	cv=none; b=j+V7PPD7s70hQzbJLV0gDyKTcpSSQzyDxV89ZzddSwqH9l5/qTay0qN92S+L+kMQWBkBNALCoVG602bPHTe8NzpqOzBQIHbSKoZwhY4qCwYHYgZDhl5hBkbenVf9Iej8L9ZzoTSMZyGimD9fuHSNLVP5HOcIswbDFO4j7qJCBP1Cs0e4oTZAZi1TFcxaCTn2/rNoTP/prIh6KRx5hTjIOW5XoDIzcciOh1fdYESWruaVILmPDXkGqcBGrGraQpJSWGaUls0oRiagiPurrBxEQFqRGcil9MgRtHRrBrIzBLqFhDdo38CIwpkrqKukFdtEdKRdFJt4+U2wH96XIeQOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755869995; c=relaxed/relaxed;
	bh=7nqi6ndzvBOlgTtBY+hRKwio60aQLK3AVnHRvI8S3l4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ZH93hDWv0DcVli5mR+Bzqhla6YPPnrcbGANYaOT0hw4tmx3xgxxLbVM3h/YniBojfl0UBqAGd0Q5v4yJuXxfhqiBWL/zEMGs6WV+jIDVszaY2IOJV0FcUrMa04cdG2J421ykrncMQzL5Wn3I1Qas7pRTMpds8qJTTkOt0Wup/qWd6lKAfvzAb/3MfHGKSAyglpvhBXExmJN0tjhwS6T1qTtOOV3fgYh4tIeY73A/xpiYacwNKo25IkWV00MXPH9umFv/z1kiPmmQpE72EFF5MZbR4lej/Iy0Mu7nYTOOwxE9HUoGUNGii3PNCXOhnHpVxQFo/VIyqxMQk6fSPIHPNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hUU75Hmf; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hUU75Hmf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7hBc0ZgQz3cfv
	for <linux-aspeed@lists.ozlabs.org>; Fri, 22 Aug 2025 23:39:52 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0EC91A58A68;
	Fri, 22 Aug 2025 13:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C458C113CF;
	Fri, 22 Aug 2025 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755869988;
	bh=6lls2PNqv82LA24JN17rWOxhT+KBp/xw1JLS07INPPU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=hUU75Hmf/NOkMXHK7mzYKoStE7q2Eza75mREBzEjUfXfoP3AIklheGU0FjV2eHAEY
	 UPq585Ft6/G4Xhv52F43ySLRyr38rI0KBLlBaUMNk2FiDzXXNkD2g4iL4W0e2KPCXw
	 NSZIY+cZKT8qdyeCmwhpdFMh3eXcH9b/XruFvadtJ+B6GO0asik1ftd517tzTqM64a
	 tYI/beKAXzv9c9Ek2kVq/2iC6Cn/ktdAbHTJ5uQLO44Sn34QsAff1zbIb51LvaGucQ
	 Z0hdip00uq0aogFSKCplh8qU/MD891lGqh1NN6a25ZK/HHllQQvtRQHefJB2BlsPSA
	 hz1e7uW29jRTA==
Date: Fri, 22 Aug 2025 08:39:47 -0500
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
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>
In-Reply-To: <20250822061454.2610386-1-peteryin.openbmc@gmail.com>
References: <20250822061454.2610386-1-peteryin.openbmc@gmail.com>
Message-Id: <175586978615.3467242.392732396361998421.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Revise Meta(Facebook) Harma BMC(AST2600)


On Fri, 22 Aug 2025 14:14:50 +0800, Peter Yin wrote:
> Summary:
> Revise linux device tree entry related to Meta(Facebook) Harma
> specific devices connected to BMC(AST2600) SoC.
> 
> commit-id: 2236141ed3d6f31f53147c26208dafef6051ae43
> 
> v1 -> v2
>   - Patch 0002 - add power-12v-memory-good
> 
> v1
>   - Patch 0001 - add power monitor support
>   - Patch 0002 - revise gpio name
> 
> Peter Yin (2):
>   ARM: dts: aspeed: harma: add power monitor support
>   ARM: dts: aspeed: harma: revise gpio name
> 
>  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 27 ++++++++++++-------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> --
> 2.43.0
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
 Base: tags/v6.17-rc1-14-g326d25198112 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250822061454.2610386-1-peteryin.openbmc@gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']






