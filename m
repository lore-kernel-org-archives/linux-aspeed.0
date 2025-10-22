Return-Path: <linux-aspeed+bounces-2567-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1E0CCD1AB
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Oct 2025 08:29:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cs2Qk0K20z2yrb;
	Wed, 22 Oct 2025 19:29:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761121790;
	cv=none; b=mO5UyvfBm1fOrvoeBoeJiKRysoExE2WZPuNo/bEXXLWlx87nyen7iLcaH1arP3LfE3iHXmnoPIS+KG2koLskOvtiYGoRNzAifwKG13LMtNy0WLKcIudq5drjVPoh/6x+cDaLbMhshA3+nc3AmzOhR9UG6Q48v6mA9BU0sZlag1/HrWIn6fj3W+FppWa5o4iJwZlykL0pIvro1+i+9Sg/Bgn9Mm7I0UHJgUuClP3ys0UnBTmTBGq5Nq3RwYYgJCXurBTjEL+G23kKEPQDIuaq7Am+KLWcKucG0ZyS9ui5H/lgXWFqQ4oloQFUvBqMlyaHKSEO6iC4JwzWefMRVjiY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761121790; c=relaxed/relaxed;
	bh=jVE8RS+ZFEFVaHbUbLK1+/R0KLHVMvTv6V13dVpnfeY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NNa77Lx6A+1HUEOwbvQW+rNsRlaxbKXwY9miLi/aowk/C7bhRYhlM6Hp7kYdtisg2YeirjO5Isqa5MXDLPNat9d5rNBrW0IF1AoekIovF2c8UPruPn72OFRMT37+EsT0HxrqJxgbHXSzNf55qChWeAxgyN88Q//oXf0drMBXRYXOx1pFOLMrcJQSd+RyfE9Go+9oOf4/AKa2Q8mGXVLRthuWzlzKSyuiNeFTEbvPpolNezAYumsaGKYi5NgCUnF3/8WOIQRRHsY6Z8+tD7zNoJZHJd6c8nd3qrMSQb5FBQXZJGO/OGuSb/ADm89I4Dw4vDTtPFvQwxAQoLkSBeAPjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WlvaVfNC; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WlvaVfNC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cs2Qj3MClz2yjx
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Oct 2025 19:29:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1A8DC628F5;
	Wed, 22 Oct 2025 08:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4832C4CEF5;
	Wed, 22 Oct 2025 08:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761121786;
	bh=bJvkdLkKFo0sTg8s8eWRSm9R4+waidmhRJp00c5NgGo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=WlvaVfNCIyo0A4mIEINni15Pmtn2QUO/oxkwZyta/5wSgisbjCfOWSke/UqJucMpR
	 h6BjpROGL77x5P72guB7+pxCArRuVD8PBpJz5akRFSUf/ZwqZbPj0rmmK4hKu1M+G3
	 Xe/446NTd49UIcVX6NT5waN3TKkEOBFzOE+Mrglsjl5aUSx0G1wEh2knXIcNuNl2f4
	 abRjfaFDFM+xU8HxAWtYAkIFXvrAXm/GsDtIWyHhjUJ/DyYVhNQnXR8BjtULqPqiBF
	 3qjmjHWuDvMquALiJRvU08PJqjSMxiSToG84NJB02WYcQpHTuZtKlAIrGvymMBl9hY
	 xekgbD/yoq0VQ==
Date: Wed, 22 Oct 2025 03:29:45 -0500
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
Cc: Thomas Gleixner <tglx@linutronix.de>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, jk@codeconstruct.com.au, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Chen <kevin_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20251022065507.1152071-2-ryan_chen@aspeedtech.com>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
 <20251022065507.1152071-2-ryan_chen@aspeedtech.com>
Message-Id: <176112178506.2826837.14168081869073363718.robh@kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller:
 aspeed,ast2700: Add support for INTC hierarchy


On Wed, 22 Oct 2025 14:55:05 +0800, Ryan Chen wrote:
> AST2700 contains two-level interrupt controllers (INTC0 and INTC1),
> each with its own register space and handling different sets of
> peripherals.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../aspeed,ast2700-intc0.yaml                 | 97 +++++++++++++++++++
>  .../aspeed,ast2700-intc1.yaml                 | 94 ++++++++++++++++++
>  2 files changed, 191 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc0.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc1.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc1.yaml:94:7: [error] no new line character at the end of file (new-line-at-end-of-file)
./Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc0.yaml:97:7: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251022065507.1152071-2-ryan_chen@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


