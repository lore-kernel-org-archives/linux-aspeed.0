Return-Path: <linux-aspeed+bounces-4026-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BBFCD4F21
	for <linux-aspeed@archiver.kernel.org>; Wed, 13 May 2026 17:05:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gG0Fz1qZpz2yFP;
	Thu, 14 May 2026 03:05:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778691927;
	cv=none; b=CuH1SVWi08FFjjvLobcDCgjaRKWETShat6Ol66tvxa29TBuKnY4tSzs15jJpHsm3xtyrTrC6TSetmolEf3Hfx7+qW1XM8LpktU1C9ogn34jszsA/nLF30LsUQ0i2H421tp7/Y0D5xywqhBpaIbbEYeDXNqCWsL7DRPaDOphfuiaIKvMMMFrBTavPy5stVuf4F0mboU8pmvTgaLa/QzodKHmyQSeEDLcYxBhhtrFpsPZNQhKCseEW3CYS4Rz1Ae6iIAtraBQXMRpeP/C2zQqMs14G1M7gmao6om+W8nSw6eznvv+nO7/aeM1MZMrTviLspyDpdJCGgKUsFF1GWIhOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778691927; c=relaxed/relaxed;
	bh=icJYeFTllag3ffxTCN1vDadbyqQb3GOCEYSw5I6Hk1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5/ayAyW+HDMz791dC9y0ugSf3sbmO7iTCWYfNR1F7RqlyoVn7I8wCpDBQnOXmY4WH9WW0pdE/MR+pcfYJPy9dpIDdmQMWuV8e2KnKpZi3yihAeHjTT1PpECncxK3/N+sCP1mNeYSK+74LFlYZBGyQ/s9o/27G8ui0AiU7+eIKJXWjByFdWZxiVm8MtFWIVa60Wyf0VbjHw/723ARMrubdae7MytBcdQJl71zdspDqNYcNUm8/3RkArBHBxEJf1beaheDpCo3vICfKio4zpuWDc2F2oYqeKCG1rs374xK3sC1pe+ZUHkN5ZutOjNa07Y6Ttws4osoPy5UkmaFl0DBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j86+vXxl; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j86+vXxl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gG0Fy4Ksyz2xSb;
	Thu, 14 May 2026 03:05:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 804D960126;
	Wed, 13 May 2026 17:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB7BC19425;
	Wed, 13 May 2026 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778691924;
	bh=B+Lh2COB90j5rStyv1o/M72otL7lieSerd5T2ErAozg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j86+vXxlfjczGFOX+pw2QWVO1pf7gG8Ju7jVRxZImVlHVOOmieIPBv8VtlTlUwy5n
	 gDZpvo7NyLdRH4IErvy6qc+UU5lujjiqdj/vGO0eFEkM63ttPt3OG94BV806Y8/VOu
	 jVNFhKC5UCoNC44JizcJAPLx0nLutrMdbwaRBbIx6zUf8H6J1fcYajOd9DCA5fXXof
	 76ZRDXkzXOJhed34Y6tGycA8tcZCQ4q+76SYASz5PP0MbYM/U5uW76Ta5e3ZU4XKNb
	 A3j11fRn+cVfE12gfrklOiJNfb2lRbNV15GCWecFNWTNcHKXUijb9k58ZkoTRGQ64w
	 F//GpFcw4fqvw==
Date: Wed, 13 May 2026 12:05:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	jk@codeconstruct.com.au, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rayn Chen <rayn_chen@aspeedtech.com>, openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH RESEND v29 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs properties
Message-ID: <177869192135.1318285.16876434297246564335.robh@kernel.org>
References: <20260513-upstream_i2c-v29-0-fe9926964d55@aspeedtech.com>
 <20260513-upstream_i2c-v29-2-fe9926964d55@aspeedtech.com>
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
In-Reply-To: <20260513-upstream_i2c-v29-2-fe9926964d55@aspeedtech.com>


On Wed, 13 May 2026 13:32:01 +0800, Ryan Chen wrote:
> Add the aspeed,global-regs phandle to reference the AST2600 global
> registers syscon node, containing the SoC-common I2C register set.
> 
> These properties apply only to the AST2600 binding. Legacy DTs remain
> unchanged.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v29:
> - remove aspeed,enable-dma properties.
> 
> Changes in v28:
> - update commit message correspond with aspeed,enable-dma.
> - remove aspeed,transfer-mode and add aspeed,enable-dma property and
>   description.
> - Fix aspeed,enable-dma description to reflect hardware capability rather
>   than software behavior
> 
> Changes in v27:
> - change aspeed,transfer-mode to aspeed,enable-dma.
> ---
>  Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


