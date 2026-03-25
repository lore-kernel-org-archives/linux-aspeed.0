Return-Path: <linux-aspeed+bounces-3760-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CB31075269
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Mar 2026 01:46:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgV9p4QFdz2ygh;
	Wed, 25 Mar 2026 12:46:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774403166;
	cv=none; b=MkyvA1EtrqESPefMzuiI9MAD7UB2yyWwNOzu4hyFS8b1C5t9cmBju9JKYWLMREHsrwPBE1Y/C8eHh2C+DA+uPtR4f2O6eOy80FW0r/JDUt68GPWhNNCHyNWs6jLYV+N+1mEkXircyMWCOQva+FCCQBh4kB3r/MXUPAeDkrTxuiSKShSyVPi59CQdqWPQ4JDKhJaLzXOw/ooznPFXUelxcumWaRGuPWPg9nUOMyLkM5GxvUGT3KaLB5aSoFDWDjweGzP5GclzKSh6AS+tjCovV6supQ+M3fZNncPsWtvmq+5TadrMN+78S2yBWoe0HCOi2mjzWY98X3CaEzTGCOnYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774403166; c=relaxed/relaxed;
	bh=07p2AHTHoMybNDBcsrSuuplzOKpydQ2b3XLkDqGvEbg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=JKXk8W7CgJTFq2gWPhj3a/QNBHKy9Ihb2jbGBhNDQTMXKADAGbCsxywwR4sqZkQelCTtwPPULniDke2/dmX9erKrtj++Y56dpT8nb0DGo3aMQdzpD4Xui6oR8pCYW95Fkubi0FQbR+M5ahLovD5ZTaFYJ1nQgh7j11nQct99CQfGhYcDgM6zfKRAbTzlrOzg43xCFdmHzuR12t1kczpVL2DY+2+ukF52hw0gc36rAw/sigM4jt8+rOQsHShlpAhSrEu6jmtfhse3jhMg+azB+5IO4oRn2/APPln39NPE8Mm17zj6pkVwuDzuAbuPY4re2kUoPyjhTqZ8uF1Rfbj0nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P44exNmx; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P44exNmx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgV9m62DFz2y7r;
	Wed, 25 Mar 2026 12:46:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3951260103;
	Wed, 25 Mar 2026 01:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82E9C19424;
	Wed, 25 Mar 2026 01:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774403161;
	bh=HvRVk/YPY3gKc9XAyt9raBZ1qgC/+JELgZiZx+SJ6N4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=P44exNmxQ70a5hsAAw7auqSfc7E3xhP6zmBLbY4VKOeDbOBlza3XzQg6kWsfAEFW4
	 cxI9ZsxnlQhX9NxVYWkUAdeng9+r8dhX1Mr0hig5YUDL/Yr8c5UPAjWhSxiW1CCZ1D
	 qKBJyAingduujPrMri2ea23aolKVEqeXU3CUIvZEVczw73geOtQ5rqVYe4vxQW1PM4
	 KjkJa4P0bYdQY4fC6Yk1YdbFO25qrm0jaz73De8BF3IAnl/pleeGI6tadvBh5ypnE5
	 K92aL6SnMpHQUMSE54vM7nGYX5crg96AMONStV7M3W1ZL1M/1hSbrRMMPsY238m1GR
	 q/XKQSgLSUtIg==
Date: Tue, 24 Mar 2026 20:46:00 -0500
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
Cc: jk@codeconstruct.com.au, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Rayn Chen <rayn_chen@aspeedtech.com>, linux-arm-kernel@lists.infradead.org, 
 linux-i2c@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>, 
 andriy.shevchenko@linux.intel.com, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
 linux-aspeed@lists.ozlabs.org, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com>
References: <20260324-upstream_i2c-v27-0-f19b511c8c28@aspeedtech.com>
 <20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com>
Message-Id: <177440316087.2477729.6574194979133287654.robh@kernel.org>
Subject: Re: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties


On Tue, 24 Mar 2026 11:06:27 +0800, Ryan Chen wrote:
> The AST2600 I2C controller supports three transfer modes (byte, buffer,
> DMA). Add "aspeed,transfer-mode" so DT can select the preferred transfer
> method per controller instance. Also add the "aspeed,global-regs"
> phandle to reference the AST2600 global registers syscon/regmap used by
> the controller.
> 
> These properties apply only to the AST2600 binding and are not part of
> the legacy binding, which uses a mixed controller/target register layout
> and does not have the split register blocks or these new configuration
> registers. Legacy DTs remain unchanged.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v27:
> - change aspeed,transfer-mode to aspeed,enable-dma.
> ---
>  .../devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.example.dtb: i2c@80 (aspeed,ast2600-i2c-bus): Unevaluated properties are not allowed ('aspeed,transfer-mode' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/aspeed,ast2600-i2c.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


