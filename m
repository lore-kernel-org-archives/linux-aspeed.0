Return-Path: <linux-aspeed+bounces-2922-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A78CEACEF
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Nov 2025 04:32:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d8vwv1zNfz2xS2;
	Mon, 17 Nov 2025 15:32:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763353951;
	cv=none; b=QKO/SNmCnmmCISvmaEig5t7qa4TklVZmf++z/wecPo54nt3LmAp9OXEHHqXA2o26q70yBG/6OYDNBagNJhrbFnYZRS3yF2m+yT9PGYVYnZ1i0czhTwCye/oxslCv6dOHhePDlxJkV35VB4UuqXthbHUt7DB9jkXtUuWocrXQwIZ95Sx3OpozUq8KtdgmQP1pOF7Ua1OwERMR93gN+DQFrmGkq8nNZM6D5cbgQopFqvnE1WxuHOavbmND7SARHn81fqOQNhnpttEn7h4MXOyKJGrSL+cbUI3UMxUkFCqEhdPctBhXKTN6NezvOEIxWwoD8q18G5I8tGLcReT9uI5+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763353951; c=relaxed/relaxed;
	bh=yBh/kaRoByn6GV6GRxpAfMDmXSxqGAofk5vXsebspKg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NzwO5EPmeYAV0myLgHSYPSHM+g3EKhfTXcMKPgsmaUBy9pZfivzsIVtau+WTxn3JW0LSdbb12TWKSncYNkfy3LaF5OGG3lkdXrRrHPevmRNoGSv8oJTMLA2WPz8fXli0Cj6dvh0VUvzHvREbpZcPdCyqh3xp4qxMXn9+klD44xZ4MTaJ390teowqPNnQH6RfkZCUQZwuOsvufOKGuLQPVhGKqllShdqTSNsBcewST6S1SbpIeUxEa7d6Khq4bXoopuFm2NW0cg/O8XC7uBLMNFEWeqJhjtNRPvNMptyra738OKU/xTDkRRBQnH+Ry2uxRHoOFqRaSAnWpYOZlLc/BA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eS8uyNUd; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eS8uyNUd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d8vwt1Pkzz2xQr;
	Mon, 17 Nov 2025 15:32:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 67D6141878;
	Mon, 17 Nov 2025 04:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C383C4CEF5;
	Mon, 17 Nov 2025 04:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763353947;
	bh=HL6MeUGnbH+gyiyOSqBbks00vNfOL44P0gMp+dpGVxk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=eS8uyNUdvX+Eb9FUkupN5W9tMTE4VtZXmnOBnD1FAxPktA7J8tjfmrRa18EQr7Axr
	 M0qb9yn8mZicfgAEbhaLP2G92N8qKf3jqHVbV2G3hHlJFfjvVamIc/QUBiiSVv3n19
	 rfjWTmGsyv4p/SyiZ5L2PBF7iBjgHG/HkxvThyRBeTaLa41N+6cmR7kSo6qHbZkKtB
	 CGECLvha9J0avRzEC1UU1+Oy+R9KHcUVW+kywJsXcDYXJeQZkYFHzwx3wDDnmE5eTc
	 dggKcVI/FJj8MKL3ut5dYjx6m0QJ6805S2oJHpNeV/HXuN1W6f9GO8E1LDZ42j9TU2
	 zHfv9Zrirsbyw==
Date: Sun, 16 Nov 2025 22:32:25 -0600
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
Cc: openbmc@lists.ozlabs.org, andi.shyti@kernel.org, 
 andriy.shevchenko@linux.intel.com, bmc-sw@aspeedtech.com, 
 jk@codeconstruct.com.au, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, joel@jms.id.au, 
 andrew@codeconstruct.com.au, p.zabel@pengutronix.de, conor+dt@kernel.org, 
 naresh.solanki@9elements.com, krzk+dt@kernel.org, benh@kernel.crashing.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
To: Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20251117025040.3622984-2-ryan_chen@aspeedtech.com>
References: <20251117025040.3622984-1-ryan_chen@aspeedtech.com>
 <20251117025040.3622984-2-ryan_chen@aspeedtech.com>
Message-Id: <176335394552.766711.17435291607317271489.robh@kernel.org>
Subject: Re: [PATCH v23 1/4] dt-bindings: i2c: Split AST2600 binding into a
 new YAML


On Mon, 17 Nov 2025 10:50:37 +0800, Ryan Chen wrote:
> The AST2600 I2C controller introduces a completely new register
> map and Separate control/target register sets, unlike the mixed
> layout used in AST2400/AST2500.
> 
> In addition, at new AST2600 configuration registers and transfer
> modes require new DT properties, which are incompatible with
> existing bindings. Therefore, this creates a dedicated binding
> file for AST2600 to properly describe these new hardware
> capabilities.
> 
> A subsequent change will modify this new binding to properly
> describe the AST2600 hardware.
> 
> The example section updated to reflect the actual AST2600 SoC
> register layout and interrupt configuration.
> Reference: aspeed-g6.dtsi (lines 885-897)
> 
> -I2C bus and buffer register offsets
>  - AST2600 I2C controller register base starts from 0x80, and the
>    buffer region is located at 0xc00, as defined in AST2600 SOC
>    register map.
> 
> -Interrupt configuration
>  - AST2600 I2C controller are connected to ARM GIC interrupt
>    controller rather than the legacy internal interrupt controller.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../bindings/i2c/aspeed,ast2600-i2c.yaml      | 66 +++++++++++++++++++
>  .../devicetree/bindings/i2c/aspeed,i2c.yaml   |  3 +-
>  2 files changed, 67 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml:25:1: [warning] too many blank lines (2 > 1) (empty-lines)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251117025040.3622984-2-ryan_chen@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


