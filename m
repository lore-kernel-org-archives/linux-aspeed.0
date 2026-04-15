Return-Path: <linux-aspeed+bounces-3911-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E258F433CF
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Apr 2026 22:32:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwwqf6XVrz2ySc;
	Thu, 16 Apr 2026 08:31:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776292318;
	cv=none; b=dkbiffgl6wdWUjBnaKBxrFk6aeHAhVCgx2EEKsmD3xjukIKapGcHGXFIHBMHojgZ2L5X6rhGwN6iDDQ7yodo9zU0FTCl8hy2qXE3/giPxUthY6M/sHzPBroVm12cfhniDpfsCxOoM1JV5u5vg63fROxOIJW6s8HjOisWgl5wJQg9d/8stQc7RRFWL7vTFoOaBdCZ4HK26aaDKzxxgj15fK18PZYbN7CLb7HxfpDGe4t0I6DZKlh5V1jqWEnmcJXkF7F3tZv/NnB9fp1tm2X3vEwU+Gih6vywf20yPNme4IzGLSHT98WHsxsknnSS8q9NoAzqV/aPjiphxuY4lM9kAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776292318; c=relaxed/relaxed;
	bh=nXlOXson+ZOeKet8SZPRBk7wXfDuJIIqtNcyxVWMftI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=VVplGv0/hl1yJ1fC50/8AV++R716s4f0PrHSmBpobEZjBJSlvQYNqKSfORFOGUmgFONlq0eYn6Vwp3CUZ1Uo4LYizF6kyDALQJy6JGKHJnZi4pfoVysotR34apUID8CCQICVTgUMh3vXFsQwBMdrWBHVRtRERdUFzWzGIDLZK7PnR1JG7xX749mpR7P24VcB8DWqa7dd6Ai2WZFqZKsFcXmgFx9UxaXvWCN6u/mRfGY2uM8g5jnmPvY0E3ZYopKfXe1ErhnNaXe2niWnkgazNf6TyzvE+kocfOqXbp3Gb89vib5A4KdOvfXIbeZvX9YDsAsareSm1P4UaCfuUu8TRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uJ5VWjvM; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uJ5VWjvM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwwqd5ss8z2xlm;
	Thu, 16 Apr 2026 08:31:57 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D2DBF60180;
	Wed, 15 Apr 2026 22:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B73C19424;
	Wed, 15 Apr 2026 22:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776292315;
	bh=WPuIjMAw2ocla7dY4PH5AfZDm54Cudg1cBk8x+T2SWo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=uJ5VWjvMoT3HFcDUCZIjlcya34Wb+vN/KoNeCdTsmgE0YpuNfEF7a8tR5VJUYNKtD
	 ZLMiZJ3TRHtJiiWzSLEgNT8KNDwHCFE8yyBFY30yBgTT+deMu0BopFqUETadRqZN+v
	 d7kEb26guP4aMc8y4lA/wJprSezQyaf+103VrbqK7aP0ycrmy95ktZxaJ9/QGlOkH8
	 YiZ5gjfKqHOcVGyl0SPffjtIJ3nhiQxDcVDvm0dXD+Vk3zdjQfbWCrIBQieSMd7oTk
	 uqpvT/oqyEP1VeNp+Idtogxc3N4Fut0riuoME02qVOR1t5eoo1K9tOjjRiv5Mzir3a
	 hnzfJ9FhivtTA==
Date: Wed, 15 Apr 2026 17:31:53 -0500
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
Cc: linux-arm-kernel@lists.infradead.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Bartosz Golaszewski <brgl@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Lee Jones <lee@kernel.org>, Andrew Jeffery <andrew@aj.id.au>, 
 Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-gpio@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
To: Billy Tsai <billy_tsai@aspeedtech.com>
In-Reply-To: <20260414-upstream_pinctrl-v6-2-709f2127da33@aspeedtech.com>
References: <20260414-upstream_pinctrl-v6-0-709f2127da33@aspeedtech.com>
 <20260414-upstream_pinctrl-v6-2-709f2127da33@aspeedtech.com>
Message-Id: <177629231119.934339.16424036449507234934.robh@kernel.org>
Subject: Re: [PATCH v6 2/3] dt-bindings: mfd: aspeed,ast2x00-scu: Describe
 AST2700 SCU0


On Tue, 14 Apr 2026 17:39:00 +0800, Billy Tsai wrote:
> AST2700 consists of two interconnected SoC instances, each with its own
> System Control Unit (SCU). The SCU0 provides pin control, interrupt
> controllers, clocks, resets, and address-space mappings for the
> Secondary and Tertiary Service Processors (SSP and TSP).
> 
> Describe the SSP/TSP address mappings using the standard
> memory-region and memory-region-names properties.
> 
> Disallow legacy child nodes that are not present on AST2700, including
> p2a-control and smp-memram. The latter is unnecessary as software can
> access the scratch registers via the SCU syscon.
> 
> Also allow the AST2700 SoC0 pin controller to be described as a child
> node of the SCU0, and add an example illustrating the SCU0 layout,
> including reserved-memory, interrupt controllers, and pinctrl.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/mfd/aspeed,ast2x00-scu.yaml           | 112 +++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml: allOf:1: 'then' is a dependency of 'if'
	hint: Keywords must be a subset of known json-schema keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml: allOf:1: 'then' is a dependency of 'else'
	hint: Keywords must be a subset of known json-schema keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260414-upstream_pinctrl-v6-2-709f2127da33@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


