Return-Path: <linux-aspeed+bounces-770-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A240BC021AD
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Feb 2025 00:42:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YyHfX0rJjz30Ds;
	Wed, 19 Feb 2025 11:42:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739925748;
	cv=none; b=EPsJwJT+jAZhRot82xuqwy6pBepJQVcYn1biR1q0LJImYMaIsEq2y/cQA9fGgQpDl0OwvS7ShiPjCn3RObzc2KLyF+TGaHWNbkK1hiKdLpxac/T7ZyIn6sh6yaGozF8RY1EDyYUzN/Op3Bb//cHXchRxKHKSZA/4I6XJ1d3bEyi5x7pl2+TXezLpTK9knVNI9Dg6e7V/1Mi0fv57nRVZwVCXW2aaHsUShgX6S/Or+RKWEWUkje8fQrs0C9nl4+sOe415x/hg6VMo9JS9J+LEgdZ/7lLXrrhf2IxY3JOnTLg+BFEzlw//xx8aV46FP96avC4LCg+lrj3z3R74SQe3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739925748; c=relaxed/relaxed;
	bh=VFwmDv5rtIpq4doJVM3pQVXJ8CnZ6EnDY9JTLGFwHHs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ZyZ1nBbEP5PuWkz36DKr1qHdDwGQ3kjuk7AOB/rAC8VjN3jhrLLb2BqhPduJPDS5+5JrlCBjlwbwNMk7JZOCYALBhk3Q0v+0DoB9VRTIZO43Q8FWqjePogKImZE6lMDq8wRFodlXja3K2amZYSLjkVfzb1PJIn3zFQ6rH/0n5DxGaP9n0a2kL2D7uvzfzz2zVcvI00c8NdSSoy9Xo5KCLw5YTQcJqfQBjFvlURQIPo16z5VamS+K6gOYo0EZpMsIzv+enhYZGsvHv5TmcjuhdXKxS7eS9ks1/Wdu/cAoHuXcf3tc2EvR8OlAFOdcGTc0tJ5od2W6q+Gwlh04AdKIPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ilbw/hED; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ilbw/hED;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YyHfW0x0Bz2yMh
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 11:42:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B19EC5C5E93;
	Wed, 19 Feb 2025 00:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9352BC4CEE6;
	Wed, 19 Feb 2025 00:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739925743;
	bh=BwGnr0m0xhmBvURW6iahNgzC2tdJQtDHH3iqzOTLvFI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Ilbw/hEDJPwc1Sh+JkMlQA5h+OID6m/Osf++dMsXsuSDlpKfnk/r28dj1vugS7fBp
	 dDtlMtOciF380qWvnfEDLW0fjc2wqFx86/wlSOUAkpNkoTH0hSa9/jS9rT1QnFYxFq
	 1nmIrnKUda3u8qXJCcixgyrDY3w5AtOBds1/1XS3EH6mjmIBo8WfszmAnJWKg/oA4b
	 77mB4vBkxGzHtPo5pUv7S/RCP7e65yokhXWy22pBk4lb5XNEsvCN+ecBn62Mvb1DjT
	 k6VYLbGR2vbsFvGQ8pvJCrG0e2gEIr2dAFItnO0j88+jtPhaujY/8l7yX821F+XO5l
	 8xOIQ5Y5OiTcA==
Date: Tue, 18 Feb 2025 18:42:22 -0600
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
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Eddie James <eajames@linux.ibm.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Guenter Roeck <linux@roeck-us.net>, linux-arm-kernel@lists.infradead.org, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, devicetree@vger.kernel.org
To: Heyi Guo <guoheyi@linux.alibaba.com>
In-Reply-To: <20250218031709.103823-1-guoheyi@linux.alibaba.com>
References: <20250218031709.103823-1-guoheyi@linux.alibaba.com>
Message-Id: <173992516523.2065435.15405371370616212583.robh@kernel.org>
Subject: Re: [PATCH 1/2] driver/aspeed-wdt: fix pretimeout for counting
 down logic


On Tue, 18 Feb 2025 11:16:58 +0800, Heyi Guo wrote:
> Aspeed watchdog uses counting down logic, so the value set to register
> should be the value of subtracting pretimeout from total timeout.
> 
> Fixes: 9ec0b7e06835 ("watchdog: aspeed: Enable pre-timeout interrupt")
> 
> Signed-off-by: Heyi Guo <guoheyi@linux.alibaba.com>
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/watchdog/aspeed_wdt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
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


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250218031709.103823-1-guoheyi@linux.alibaba.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: watchdog@1e785000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: watchdog@1e785040: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: watchdog@1e785080: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: watchdog@1e7850c0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#






