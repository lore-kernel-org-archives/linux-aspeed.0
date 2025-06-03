Return-Path: <linux-aspeed+bounces-1296-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AFDC5AE59
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Jun 2025 09:42:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBQjp0rZYz2yKq;
	Tue,  3 Jun 2025 19:42:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748943758;
	cv=none; b=cGl2Ome2f5mTVGagsTTnLX4OzRMj0o9X8kaXYj1C2vyU226KPoveim024Cg+hUvcsxoEHJNkO3II8g5NXtHiB3R2GkqQVe9ngr4zTb6UOFRQxjvdk+mmvhHzD6eOMPExz2Bvz/D9TgSSEKjmJ/K2FOFC6H1vkw3k67Wdd8Ya/cRsC1NZucZhw0LhisB7c82jsI0iXbLwl9+1QG3kQtQBEzubVIQbPNqng30CPMmIw6UHY2G84PY1ppuaAyBGvuHAlMnirMiJYLpmN6nJBsFb/OOSKiWLPLMtNXZSw3F4X5SoTZI7tiTdzdyt/yi0EgFwRyZl9+Qb3tykKk1cBE1TZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748943758; c=relaxed/relaxed;
	bh=zEodPovTTAvnmzNUTxzbBUHYxKJDkUSLU0GlJpaXIFM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=VXv8wuNbrzkFNyBeKj3GtWlMZ/itWNBPVqORlE0/lw0WE2Sl7rglLs7W2Bim3XIsEh2MZcNmSY+ZzJZgkl8sdzEoUxGGn79G2diEqtpEX/2eajCRFmZzKGoWxC0WyeEn/G7ajHkwOM3WIsYhIpF2nGQC+7AvWbNpd4MW9c2uVAosmRg578dTPg4YpEbcJiYQy8i8V3PoVbaKdL4272pOLke0MthQROZ1KTCQLXRIiMRnBLIQkIbl1M38/+dB19iVaY0Laqd6kTOIWZCFvCcwDqp82UVxCpwnG/2uU16zUZt+OhkajBlShReeUs2ruThocvdnamZT0oxufs6kiuGrFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Hkite6jM; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Hkite6jM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBQjn0K41z2xDD
	for <linux-aspeed@lists.ozlabs.org>; Tue,  3 Jun 2025 19:42:37 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B57F65C54F3;
	Tue,  3 Jun 2025 09:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCF6C4CEED;
	Tue,  3 Jun 2025 09:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748943754;
	bh=dbV/utlJZsAmXKza9Scy8Pvl3ynRvyPanNSPnq6zrJg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Hkite6jMMxAGOm50Ea2u62+Aep6JFDMPsX1jjU94Oe8lbTEiQTz9l5H137JrOLWBa
	 5fYPC67RSKTfte0X06ogcsaKBQ4iPotQCQMbY14IOv87Tp69e0Hgp7ecAlVZR77qEO
	 XOne9yF+muIfRfuHG/LxGd+GiBC221jT6MHtyf9CwOFd6ju9pbeVGL5xRWrK4SmzE4
	 Dm9pifWH9JD6cg7H9y3xl/zZcGvHalV/hWiuo6M3MjjPEF8E1p3HdIjAHHuMSGtSPG
	 tP98ZDF1uXOaaIS928Q+u+Gvym9V1Z1Stdb7anXKpHMM9t/mBSkH4OMGTjoXwBGB0u
	 fxlFJ4rNI0TDg==
Date: Tue, 03 Jun 2025 04:42:32 -0500
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
Cc: krzk+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 joel@jms.id.au, linux-kernel@vger.kernel.org, jassisinghbrar@gmail.com, 
 conor+dt@kernel.org, andrew@codeconstruct.com.au
To: Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <20250603075450.133604-2-jammy_huang@aspeedtech.com>
References: <20250603075450.133604-1-jammy_huang@aspeedtech.com>
 <20250603075450.133604-2-jammy_huang@aspeedtech.com>
Message-Id: <174894375223.360822.13996455735829436919.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC


On Tue, 03 Jun 2025 15:54:49 +0800, Jammy Huang wrote:
> Introduce the mailbox module for AST27XX series SoC, which is responsible
> for interchanging messages between asymmetric processors.
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  .../mailbox/aspeed,ast2700-mailbox.yaml       | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.example.dts:29.27-28 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1519: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250603075450.133604-2-jammy_huang@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


