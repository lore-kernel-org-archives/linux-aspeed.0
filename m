Return-Path: <linux-aspeed+bounces-2736-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C51CCF9E3
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Nov 2025 08:20:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d11c074hzz3bfV;
	Tue,  4 Nov 2025 19:20:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762244432;
	cv=none; b=eu8MBMYUWqTwR4OY4JcQz+7gDsvIIuXeJSWVUGEVewBlYmd9htVs3vd5Oy8jlrgqh10373H1n/KgP1Ve06jFuHfLReMGDCSHDjfGl7zC456tzQZN1gXJIraRwOG5iugVNU6myKUA55FwABeUGcBdGEgdvd5Xyj06+O3mIDN5FoV+ykBEzDG2tftT4ahQymoVKXjcJuiu+pmwpd77UVi7zhNIVFRmCyA59IXEwiMWYu40BWSMEWSYnmXJrUBHMZ0BOsXGMlRrnnqF9K5eqMEfaILuFT5QFmJo4BCi3buvzAuAIP31wrwhSoXtyibfp0sbJ2n3SErNKC4WSZQUcLAxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762244432; c=relaxed/relaxed;
	bh=zMrV0kkBUvcC2YSTxGrMfMhO1FmoKqVvwIgiTKba3Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaQeethbfaDhnr/HXQJGMn2o9+iEg6dmnrQn4kAHMhKqwMyYclIDagTvF9dC7PDHxrQ1kxtT5TCsolMa+KFUjbK+bXTC8jNZsoiiluVvcBhX7dHZXkhB+Ew1LjPl/AOJZ7sof658B2yl0Oxxn1aMB8g9h5R58HO/RZMB7VPSMBdaZLEZ0CQVbBjkzjA+dtfrmIMW2TPl9NZFVmFQKvcVr0D856lCwqjKgiVDZxFW2abm9Z9O/93IGNRgrp3TkMG8hnHM6MprMmIYl9xBqghnipqzwocIR/oh7N0a44A07J4fi2iFUc5STpWrJzM+0ETcRItLBDtYbx4rsr5Dib0dng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F/UtMIYU; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F/UtMIYU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d11c01brkz3bf8
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Nov 2025 19:20:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 06354601F4;
	Tue,  4 Nov 2025 08:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB78C4CEF7;
	Tue,  4 Nov 2025 08:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762244429;
	bh=6jABtiP9twriCAafB7qhdYkC2NWk+AwMtjQZTn4C2Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/UtMIYUTCw7UuAF9ifUV2bMlp41aMmcBIUBJORgkZB30LLHmuz5KXhEbbzN934YZ
	 GQhbh+pgeMaaScX3k5Osd9TsIcCBB97MDUtjBNcwPx/VGrSntzG9+96E7QGOZjzlFY
	 bgNFFIar+xKpx2US5yb1If682qFHgNMo/EXBhKSIHVSLgHrDhTCGc/qCmo9kecprat
	 3u4T/P2Qu0Bc83QpxNpHqVmkhIFEX+2KaHtsWYKUO/9gY2zu/iwIDLgxB9WiraWnDk
	 xQynuOYpwwzR9HH05orJUGrVbMH7tqbDr8fiNUIbilQ7Kpy6eaoh2IkY0uge3aR2eM
	 ErY0lNpemZBGA==
Date: Tue, 4 Nov 2025 09:20:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v3 0/4] Add AST2600 RGMII delay into ftgmac100
Message-ID: <20251104-dangerous-auk-of-order-6afab2@kuoka>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
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
In-Reply-To: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>

On Mon, Nov 03, 2025 at 03:39:15PM +0800, Jacky Chou wrote:
> This patch series adds support for configuring RGMII internal delays for the
> Aspeed AST2600 FTGMAC100 Ethernet MACs. It introduces new compatible strings to
> distinguish between MAC0/1 and MAC2/3, as their delay chains and configuration
> units differ.
> The device tree bindings are updated to restrict the allowed phy-mode and delay
> properties for each MAC type. Corresponding changes are made to the device tree
> source files and the FTGMAC100 driver to support the new delay configuration.
> 
> Summary of changes:
> - dt-bindings: net: ftgmac100: Add conditional schema for AST2600 MAC0/1 and
>   MAC2/3, restrict delay properties, and require SCU phandle.
> - ARM: dts: aspeed-g6: Add ethernet aliases to indentify the index of
>   MAC.
> - ARM: dts: aspeed-ast2600-evb: Add new compatibles, scu handle and
>   rx/tx-internal-delay-ps properties and update phy-mode for MACs.
> - net: ftgmac100: Add driver support for configuring RGMII delay for AST2600
>   MACs via SCU.
> 
> This enables precise RGMII timing configuration for AST2600-based platforms,
> improving interoperability with various PHYs
> 
> ---
> v3:
>  - Add new item on compatible property for new compatible strings
>  - Remove the new compatible and scu handle of MAC from aspeed-g6.dtsi
>  - Add new compatible and scu handle to MAC node in
>    aspeed-ast2600-evb.dts
>  - Change all phy-mode of MACs to "rgmii-id"
>  - Keep "aspeed,ast2600-mac" compatible in ftgmac100.c and configure the
>    rgmii delay with "aspeed,ast2600-mac01" and "aspeed,ast2600-mac23"
> v2:
>  - added new compatible strings for MAC0/1 and MAC2/3
>  - updated device tree bindings to restrict phy-mode and delay properties
>  - refactored driver code to handle rgmii delay configuration

That's b4 managed change, so where are the lorelinks? Why are you
removing them?

Since you decided to drop them making it difficult for me to find
previous revisions, I will not bother to look at background of this
patchset to understand why you did that way and just NAK the binding.

Next time, make it easy for reviewers, not intentionally difficult.

Best regards,
Krzysztof


