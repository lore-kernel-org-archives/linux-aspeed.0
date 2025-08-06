Return-Path: <linux-aspeed+bounces-1922-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51B5C87FD3
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 22:07:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4by4Cx1f65z2xCW;
	Thu,  7 Aug 2025 08:07:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754518061;
	cv=none; b=RDCmzxHjLNBVmNgAve+5cpOBcIfm+hpC+6NgTK2AJWbdjvjoc/yDhkbdx6V1eSdTKRpn3oIHr8d8O757Pkgy1nx2LpSts+MLoVsDJSnyE4MtMxipYq0qAHAh7XTuEq4KAJnaMBvR8R+wNhZFDgLVrHEVeWSBcg/5xhZ42Is0apOFOvphjnMTRyATHxMriL4dqTiU9fjDQWPcTTEG+qiJfAJiiq3DS3uNt6DN+p4S0ehvl/fJeXZH97mUrnIKytpNpZF8XOTyF0vih5T7xCt/UfWbSGTzWGaO/BzMknC2PnQlHMFZKyks6K5f/GGFn85wd5+PxDjVX2fwwXISiQldfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754518061; c=relaxed/relaxed;
	bh=705P54cxWG0H+/57fKH7k9KxxiSTekDbqb/xjmmuIrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMu6UmtX2gIqrZvksM6PnxlzEH92TC8nW3efET853caJEXEoZ/2UbcJK7LNIP5F3UyaMt6tnFdV7tIj6e5Z8zJUZZS/9NVg2aDZ3sqOpfvs4wbTzhuoipmIVsZy254d5+mdAFB8F7zctoQeNhjdKb+Uv62TDqW1avfZEw6Yd5c8PzY4LT8VY0LU9Pr3uxcVD5LJajRDBk77isqok2jTsGk6pXcTuQ2UDv4n+uU8l4UBMeHqgzhQeQiwlfWpFHgDzKRbDf7OqOn655VsfsIoXyVuX4IY8nRpHoI/MswPBAJW9U7c/bGz5aQCat+zTnplrS2a2UesEaPcPy+JX+YZYew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FLXrorsU; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FLXrorsU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4by4Cw3cW9z2xC3
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Aug 2025 08:07:40 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 11FA2A55258;
	Wed,  6 Aug 2025 22:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AE7C4CEE7;
	Wed,  6 Aug 2025 22:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754518057;
	bh=YqPG0QxXPo+6OmTx4iQfLkX9tF9vhfC4FJR2x4SFd00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FLXrorsUM/3HSBQJstMyrR5dWeK61mJA/gb8apoU9151r4rfBOx+SOu9koS/yGBcE
	 lwETwLzO6g3kxDmWXSs5+BVkzchLO00B2B2U0HWk2RBnjfS7kcbAL70DD6igi/5bVH
	 9PRHOP4GLjliRPoYPK5jMLL0PcMK/Dy9CmI7Jmqfbvqw/k1GRTLrfHtRDJY9woWunU
	 6eLZFdRcT6zTQ4fSCyBcehrwOPNPfiGjWf87cn8iZq/HvJQAe8bLaG0VOZvGDFJ29L
	 N+4ogElwlAWHG7YDU73MZ9C/6EQs+OJGYFrzzSyE13N8j2dhyDTFfxNDSEJXhUU1LA
	 cNan2h3/2t6cw==
Date: Wed, 6 Aug 2025 17:07:36 -0500
From: Rob Herring <robh@kernel.org>
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
	andrew@codeconstruct.com.au, conor+dt@kernel.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: iio: Add Infineon DPS310 sensor
 documentation
Message-ID: <20250806220736.GA1741133-robh@kernel.org>
References: <20250806184711.1882725-1-eajames@linux.ibm.com>
 <20250806184711.1882725-3-eajames@linux.ibm.com>
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
In-Reply-To: <20250806184711.1882725-3-eajames@linux.ibm.com>

On Wed, Aug 06, 2025 at 01:47:09PM -0500, Eddie James wrote:
> The DPS310 is a barometric pressure and temperature sensor with
> an I2C interface. Remove it from trivial-devices.yaml and add it's

its

> own documentation.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../iio/pressure/infineon,dps310.yaml         | 44 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  MAINTAINERS                                   |  1 +
>  3 files changed, 45 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> new file mode 100644
> index 000000000000..3c2d807e4939
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/infineon,dps310.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Infineon DPS310 barometric pressure and temperature sensor
> +
> +maintainers:
> +  - Eddie James <eajames@linux.ibm.com>
> +
> +description: |

Don't need '|' here.

With those fixed,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> +  The DPS310 is a barometric pressure and temperature sensor with an I2C
> +  interface.

