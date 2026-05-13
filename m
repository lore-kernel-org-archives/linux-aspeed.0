Return-Path: <linux-aspeed+bounces-4025-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F542CD4F21
	for <linux-aspeed@archiver.kernel.org>; Wed, 13 May 2026 17:05:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gG0Fk4TKHz2xn3;
	Thu, 14 May 2026 03:05:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778691914;
	cv=none; b=XvKlRkS1sl7PT5i+S5FnqGdPQBxapPZqAwpwZx5zrm/kz/xd+rf7qLV2KJjv2mvJVfRe4Rvlh1gauaF8MmjQtqQmLDPA1TzCzZynEx04FbK4QzTIwk3YZ/qBmAEeTx/Mh+eLqCEMXe+JBwrEu06FQRPw8puV5oq9ZnJ+i7DYJpH6B7FUR2ltjHU/BCewU4vwAQfVo/1mLxuInn4fWBTkxuXo7A3htNtJ/C+u5uFsO4Ovb/o8GOuTqDksfpFLs0vRIeoKGa5QRM8GIcvM3c32K80XtUTsda9VuwB9aRja/5cVUhPq/yySYJoGAmLk1I7qdNNDTkahYPQkQhzB1E4JXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778691914; c=relaxed/relaxed;
	bh=gO9a9lTw6u/Y6PbEOxbqkftysVjoFRl2g81+sX/pxL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8Y5dcnf4xe72TWUqMQTQqL4K/p3SSuj0xxbqcB94UQV5Oe4cTHteppZYGJyiLNQ/8FztM7kVOk4cmWKRe0vCXzalNQRGear2D7adNzyZcrv0YcSaz+wWRKZ2T9vc8AFKusNmdvKxXuyyagTkMtfy9CFlL8EaJWalpnbYPeTzaexCVSPkAPwBSnB7PIB0MTSdthVElzF8//9FAT+X1U+KPBIEvRmZLv8ayjYbjbgaIPwn7nk3+Mbcoots+Ocx9F6Q4Hb2Epsr3VQ4lxqk5ERbgzUiHsJmbGrWDjkeOm+5p361D8Ii9mKy4euAtxzvEUZWfRE2QYoF8Yp2OXsx6uN6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oY1+9yFw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oY1+9yFw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gG0Fj3zbGz2xSb;
	Thu, 14 May 2026 03:05:13 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4DD9260126;
	Wed, 13 May 2026 17:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE86DC19425;
	Wed, 13 May 2026 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778691910;
	bh=pD2y133+MNgkoNr3quTW76FGiTi0U6sd84qgVAoBu1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oY1+9yFwysb+cDH0n/dgzJTvyWmbhvdAQhddqS44JEXn5L8gVbWcMAo7qTJYusa4X
	 r/3sh6MeRxRbb/ykQhqT4ZMaCHIeI1r2WB8oSPZDj2DkIIaYIUq8w6Xpo4eZfdR6NU
	 dPkcRlY3Sj6KmLLcKIrTTC/L/NZLfQOJ5z+JFeT2B4OpPWRM5W6Y+EsgfqcXkOi+qp
	 fRIe9Qk4lcQ/ACRc02mPTgtwdkh+KllvoFxthMJ31n8R4rWhD/zlyUeM1Aq2LmJAtb
	 dKIBsqe2M+NDEi0415Laq+bwL1YUqa8kKG2NRSxMWc1Tsq6562u7+CR7a9CuZyBTOy
	 WxK16Cg4W+B0Q==
Date: Wed, 13 May 2026 12:05:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rayn Chen <rayn_chen@aspeedtech.com>, linux-i2c@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, jk@codeconstruct.com.au,
	andriy.shevchenko@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH RESEND v29 1/4] dt-bindings: i2c: Split AST2600 binding
 into a new YAML
Message-ID: <177869190656.1316879.13816659240778800181.robh@kernel.org>
References: <20260513-upstream_i2c-v29-0-fe9926964d55@aspeedtech.com>
 <20260513-upstream_i2c-v29-1-fe9926964d55@aspeedtech.com>
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
In-Reply-To: <20260513-upstream_i2c-v29-1-fe9926964d55@aspeedtech.com>


On Wed, 13 May 2026 13:32:00 +0800, Ryan Chen wrote:
> The AST2600 I2C controller introduces a completely new register layout
> with separate controller and target register blocks, unlike the mixed
> register layout used by AST2400/AST2500.
> 
> Move AST2600 I2C binding from aspeed,i2c.yaml to a dedicated
> aspeed,ast2600-i2c.yaml schema.
> 
> Besides the split, this also adjusts for AST2600-specific requirements.
> - require two reg regions (controller register block + buffer block)
> - use clock-frequency for bus speed description
> - interrupts are required on AST2600
> - use correct DTS coding style in example
> 
> No compatible strings are changed.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v26:
> - commit message: include details of changes from original binding
> - fix example property ordering to follow DTS coding style
> - use consistent "AST2600" naming
> ---
>  .../bindings/i2c/aspeed,ast2600-i2c.yaml           | 62 ++++++++++++++++++++++
>  .../devicetree/bindings/i2c/aspeed,i2c.yaml        |  3 +-
>  2 files changed, 63 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


