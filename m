Return-Path: <linux-aspeed+bounces-810-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94836C021B3
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Feb 2025 07:16:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1X9209xyz2ypV;
	Mon, 24 Feb 2025 18:16:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740381397;
	cv=none; b=dxbCffSgEnDvKRCB7R6DypieVWxvyWlG7vxIEnW9m5BBkUqZxR/TfNGkBYNFSrjkglCRyUV+7u/rbCBCi2wF5amwKsl02xdu4VBdKVAWtERPiCGY3mMH87o6rmCeI4fc06DbrsnAq1LJZfmgFC2gRyInA40KH6k7tiDsnIAJ83N9osCIHrV/R25RqUhyzVfk+m5t5uKTRZIX5/9XgWOpmqPIp18FFO+kgHtkup4x3OcSVnyZsuqQvKAwRxyQM/uQCfpCn3vUCZC1tBI+/btO5ea+mPtceAiAVYpUORV9x+4DRenV3F+x04HgA5qxjQVCa3393E1+gpdfRrzEb7HYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740381397; c=relaxed/relaxed;
	bh=8F627ALJhleDf0joQLUIY5WzrQ4sqzAfgG0V7XR4JzM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=N3sbzazBKpodoeNmA9WpHaXk+FsSx02P/IZN2P4S16BHaKYctXn+ZADwk9HgljkAIeoLQ9U6UlI4WRVqHjIixGxrsIcssiz6Z3cdVL6x1kSE0DS66xum1R/4gsgju4QLykfDsxpORRn8ycKP9ZZU5F+IIKHlWPvOObAJLmi2bYHZUZ7c29TOoO7MT21Q335ppI/Y6qOTUkVXY0UR9OPU4BCa4PWgCkgsXo/Cf6IV1L60enXi8uYz/88GCKTJMZJNLBoYe9hdZH1+yBfCTNdwcLjyXE0DvoebISktrS5vBO75M77iArF4k/x5EItgcuqR5ybvDAu77+lZNvTwR50Nlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dCsrvMjQ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dCsrvMjQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z1X911Rbvz2yXs;
	Mon, 24 Feb 2025 18:16:37 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 41E766117D;
	Mon, 24 Feb 2025 07:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48827C4CED6;
	Mon, 24 Feb 2025 07:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740381394;
	bh=2pBGmTogQCkZU/xIxkV1ntJSYG2JD2YqKohqWLQmXu4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=dCsrvMjQLCzpbeyKIBH+s0BVDBGeHCz9RrZkebic83ktfM4vw0gqL8fje2cJ5ce7e
	 BaDVvtxsrgzSHK+16pwIQsUc5y3vkghLu8MY96zCwSEVhw6Pb2HYEDKE2jfCqmE8TC
	 Vtdc5FOmfpVaPd4TNIxN73EtlG0TwoJae/v9IRjHuOfHYL/Evaz+dIDXafrvMlZZ/J
	 x+Y92P5h6+h+F+IN6f9lZ1QOhhC7uTYvI4FhKjz+E3qEX8Gp8GA69GF2iSD31NXE/o
	 NspuiHPWB2/ZlbdGfFFJssj9Nrdvt5VtS5f0Ym8k/mHGz0Ssto5wY6vU7rc6qO1fmw
	 YE8PdOQ2jmDNQ==
Date: Mon, 24 Feb 2025 01:16:32 -0600
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
Cc: benh@kernel.crashing.org, linux-i2c@vger.kernel.org, 
 andrew@codeconstruct.com.au, openbmc@lists.ozlabs.org, 
 p.zabel@pengutronix.de, linux-kernel@vger.kernel.org, andi.shyti@kernel.org, 
 krzk+dt@kernel.org, devicetree@vger.kernel.org, joel@jms.id.au, 
 andriy.shevchenko@linux.intel.com, conor+dt@kernel.org, 
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
To: Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20250224055936.1804279-2-ryan_chen@aspeedtech.com>
References: <20250224055936.1804279-1-ryan_chen@aspeedtech.com>
 <20250224055936.1804279-2-ryan_chen@aspeedtech.com>
Message-Id: <174038139252.1126908.7016492425946254564.robh@kernel.org>
Subject: Re: [PATCH v16 1/3] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2


On Mon, 24 Feb 2025 13:59:34 +0800, Ryan Chen wrote:
> Add ast2600-i2cv2 compatible and aspeed,global-regs, aspeed,enable-dma
> and description for ast2600-i2cv2.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml:82:1: [error] duplication of key "allOf" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml:82:1: found duplicate key "allOf" with value "[]" (original value: "[]")
make[2]: *** Deleting file 'Documentation/devicetree/bindings/i2c/aspeed,i2c.example.dts'
Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml:82:1: found duplicate key "allOf" with value "[]" (original value: "[]")
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/i2c/aspeed,i2c.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1511: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250224055936.1804279-2-ryan_chen@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


