Return-Path: <linux-aspeed+bounces-2702-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8EDCCF9F8
	for <linux-aspeed@archiver.kernel.org>; Thu, 30 Oct 2025 08:23:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxxvV3C6wz2yvv;
	Thu, 30 Oct 2025 19:23:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761812598;
	cv=none; b=HySifPMdOpirOhwoC0JU5CLdAHhwoyOMj7exdMIZM+IVIV1OJGdrKoliH2hwKKPWg9bKI8FgLGa8/dat8bkagRAF2dwZXBJUG5p5VfN7C0Lye2fQ8soJY95OyF6wKLOSuCNemL7RsBka5efHaA8ewQK/KpMHHXfZ5zDV+FMbRcybLCxwIcQqIpN/uyCIFv50I+PVnjfiD1UTa8m5Ywi8JEJfDVxz00yYFy7yFV+xrPo/6rne8Ptuq9+0X6hMikbcknV+9OuWXlkKt+3w+JPV7x4Qw5cFAXCw84aY7hfcrzYB4yXKWh6rD7ZmG/4dKOvYA48//JHYmWY2LcECazi9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761812598; c=relaxed/relaxed;
	bh=mlhldOdvaZaZ1srD5ujBcQc7mljH6nOsOP3aJyeImGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZHPYR7QSOyhvnp71kVqKA9hMHGPo+7Y2ZpFrnJb5EFrsYQWHz81g1gjjOrfxUqdEp9l6gslksmlVT+rNIYAgr/vE3kaeQ26nvaaRSMZ7zK2cFgAUJ3MdMod7NhiUs84eua7eDfb92RjpA7FS9y0ey2dGzkfBS+zjbFqUc1xvAY7WGEUm72kfgu/vzX53IjpPMTWUKx7LaFqdX/g+x1z42SwjrBqWpDd6yAqGbJaZyIO6hsdAF6slNntWiLAkf+NZa0Bv/7S1iZs6KhAt0N546fB464H3sU3oHEsaiLXgegVDexc5pjNzc0yi/ryR3ogL/TQoPb2QqPElcquoD9R+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f7zxrP78; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f7zxrP78;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxxvT2pfDz2xxS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Oct 2025 19:23:17 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4D41043967;
	Thu, 30 Oct 2025 08:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98014C4CEF1;
	Thu, 30 Oct 2025 08:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761812594;
	bh=cRGe7WHHw1LCeccNstuWW+P/ZSv12NIwuoWjOgarCIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7zxrP78KLIn7rJa+lpFRnHDGsei5y5pkM56Ke9U5jrC2ifsXej5C5GllJs8a9tQu
	 J/ZDekzbyKARQF/w4JRHaKsjFAzcrmPcaD/YOKGsCyUFktU/LqyBTScliEuD2P8DzS
	 naF/jtNiTJVRaDbLahNkneYi3smJnP/bHSz02jBCCg0V6pVIm04Je5SWBfoSLTOO0k
	 Qxhmr2+tBtjM4LqPLRSHsS8JpBizv/VMqwiqgEc05WGmgRIMO5MvDqtay/0zgkyIH7
	 ehD3qGVX1rsaNeoBVrUGCoho3p6ATff8xItvaCzSkHRsSMgQIgwk41l+CqbUMPIuTp
	 5S4Ok1oBSd1VQ==
Date: Thu, 30 Oct 2025 09:23:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Convert aspeed,ast2400-pwm-tacho to
 DT schema
Message-ID: <20251030-zealous-amiable-gorilla-b64ffc@kuoka>
References: <20251029185448.2121857-1-robh@kernel.org>
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
In-Reply-To: <20251029185448.2121857-1-robh@kernel.org>

On Wed, Oct 29, 2025 at 01:54:47PM -0500, Rob Herring (Arm) wrote:
> Convert the ASpeed fan controller binding to DT schema format.
> 
> The '#cooling-cells' value used is 1 rather than 2. '#size-cells' is 0
> rather 1.
> 
> Some users define more that 8 fan nodes where 2 fans share a PWM. The
> driver seems to let the 2nd fan just overwrite the 1st one. That also
> creates some addressing errors in the DT (duplicate addresses and wrong
> unit-addresses).
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../hwmon/aspeed,ast2400-pwm-tacho.yaml       | 105 ++++++++++++++++++
>  .../bindings/hwmon/aspeed-pwm-tacho.txt       |  73 ------------
>  2 files changed, 105 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml
> new file mode 100644
> index 000000000000..018249f97a5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml
> @@ -0,0 +1,105 @@

Missing SPDX. Few other checkpatch warnings like typos. I guess you will
see it in the Patchwork, so just writing here that it should not be
picked up by PWM folks.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,ast2400-pwm-tacho.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2400/AST2500 PWM and Fan Tacho controller

Best regards,
Krzysztof


