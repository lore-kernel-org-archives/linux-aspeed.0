Return-Path: <linux-aspeed+bounces-1242-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A616C54F30
	for <linux-aspeed@archiver.kernel.org>; Tue, 27 May 2025 17:56:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6L0q6sjZz2xjK;
	Wed, 28 May 2025 03:56:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748368587;
	cv=none; b=Y1XxyjezHL6v+IydhfTwvKbcLXjKT+PmilJrpUo5si2DXO1GZ38SuaHTN7Hcp8XK9TOAzM+O3Y0WZmW42exGuJXwWHKqqZPDhPD4FqzKWGOr8vKWYUSR/V7s9yJpyt68tb0KZ8wWL7Mwfw/Jsx40HGy7iWNsmKX59pT8dyEMnAefGhkGtL2D0ExLrlQBE2e3hBxsDbFIx2hbmrPygF7A8hl38imR9tdz9JiMkH3tjD27qE8TnMMhUvfSgYLQXDG9e6SSp++WmomeSp6WEebzalONiDxasukCeI1cmlAhPGmC3fZ0POyYcPI1ETPvUd7hWLPq5g9d1DymX9X93YWB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748368587; c=relaxed/relaxed;
	bh=hKfS10Ix09HXSAe6fouGr/qZEU1ful/OQ7NhKqZZ3GU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=BquWlrVGKclUK2I50IFb5xMMPdOuYaPokCx/0paj9hy4TbfAQXMEwtKrSsflZuJvhmzNBFu4YAwVSkBI0V3x5u9+GojGg7S5rBvfj7Jq891JGigEvJT6YQyRhuWyDmiWUwbheJqlhb78Yd+toQcl5wmWWjq8XRZGZOhTvEbSZFr9J+UJeTe/MnKdLi4xSqS3hj8T4FrWAFPmQD2Xm+6OqRrZErKz2WtMQk1vOqnV8i7vJt41gS5F3KwvI3SeHYepvD93y6v0i29AmwRVGzzE75x08hZx6qJjSp1AGO0KSsqYTT4dgAu0Tyzein4YVtEzoPr9ocbgqha10dWVcRJ8Ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pMlTMlYA; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pMlTMlYA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6L0p5Xytz2xPL
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 03:56:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E3DC4AA0F;
	Tue, 27 May 2025 17:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCD1C4CEED;
	Tue, 27 May 2025 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748368584;
	bh=sV+VhsTFkVG+PDShstWZZdPvkV2+Hq/qwiK6U/6fXX4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=pMlTMlYA7liTZY9OykGRA3FaijfG6V9VIWY5Ld8zatBhpjG4hSogpxyr9bSf5UqJh
	 8iWA5Y3nICnvHva2hPy7O96VjfGDSNFWmL5vshJtgbPvkmOtjOro6W0NRN7bNmqkgP
	 TUnr1VfvE0b524sw5rYpAz3q7jrhDu5MdQhZMqHnjr6lUkMa8GzkHSUJ6CNtJiO9sL
	 tkhSiGusHHXmAaOOJPsduatEs16UfTxqF08vbAeGVBlKRMoQIXMxyMYf8X2sD268Hx
	 dyYrjIx7QcHfw0WKB6BPHDgjMkOTpGFXOBikATkXZv6+yEDCYanjnGnutVk/HGntOR
	 mqo12813VnD0w==
Date: Tue, 27 May 2025 12:56:22 -0500
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
Cc: Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Ed Tanous <etanous@nvidia.com>, 
 linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 devicetree@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Leo Huang <leohu@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Deepak Kodihalli <dkodihalli@nvidia.com>
To: Willie Thai <wthai@nvidia.com>
In-Reply-To: <20250525-dts-v1-0-9ac63ad3bf15@nvidia.com>
References: <20250525-dts-v1-0-9ac63ad3bf15@nvidia.com>
Message-Id: <174836830738.840800.7951224308265522325.robh@kernel.org>
Subject: Re: [PATCH 0/3] ARM: dts: aspeed: nvidia: Update DTS to support
 GB200NVL hardware


On Sun, 25 May 2025 18:20:16 +0000, Willie Thai wrote:
> Update the DTS file for the GB200NVL hardware change.
> 
> Signed-off-by: Deepak Kodihalli <dkodihalli@nvidia.com>
> Signed-off-by: Ed Tanous <etanous@nvidia.com>
> Signed-off-by: Leo Huang <leohu@nvidia.com>
> Signed-off-by: Willie Thai <wthai@nvidia.com>
> 
> Signed-off-by: Willie Thai <wthai@nvidia.com>
> ---
> Willie Thai (3):
>       ARM: dts: aspeed: nvidia: gb200nvl: Add VCC Supply
>       ARM: dts: aspeed: nvidia: gb200nvl: Enable i2c3 bus
>       ARM: dts: aspeed: nvidia: gb200nvl: Repurpose the HMC gpio pin
> 
>  .../dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts  | 39 ++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> ---
> base-commit: 13c9c6eabf033ed4f369ad4d29bdc58ed4a411e3
> change-id: 20250525-dts-8eca0cb6dfae
> 
> Best regards,
> --
> Willie Thai <wthai@nvidia.com>
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
 Base: using specified base-commit 13c9c6eabf033ed4f369ad4d29bdc58ed4a411e3

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250525-dts-v1-0-9ac63ad3bf15@nvidia.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: i2c@200 (aspeed,ast2600-i2c-bus): Unevaluated properties are not allowed ('vcc-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: i2c@280 (aspeed,ast2600-i2c-bus): Unevaluated properties are not allowed ('vcc-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: i2c@300 (aspeed,ast2600-i2c-bus): Unevaluated properties are not allowed ('vcc-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: i2c-mux@74 (nxp,pca9546): Unevaluated properties are not allowed ('vcc-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: i2c-mux@74 (nxp,pca9546): Unevaluated properties are not allowed ('vcc-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: i2c@380 (aspeed,ast2600-i2c-bus): Unevaluated properties are not allowed ('vcc-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: i2c@480 (aspeed,ast2600-i2c-bus): Unevaluated properties are not allowed ('vcc-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: i2c@500 (aspeed,ast2600-i2c-bus): Unevaluated properties are not allowed ('vcc-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: i2c@780 (aspeed,ast2600-i2c-bus): Unevaluated properties are not allowed ('vcc-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dtb: i2c@800 (aspeed,ast2600-i2c-bus): Unevaluated properties are not allowed ('vcc-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#






