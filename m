Return-Path: <linux-aspeed+bounces-2693-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B455ECCF9EB
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Oct 2025 19:49:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxd9t1F7yz302b;
	Thu, 30 Oct 2025 06:49:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761767378;
	cv=none; b=CJhH0mGkoyUWc0kFl4S1S7NkYhzTWsjcZ2M/ashY5wkAgBjKyDnwGelbTUmbG7Rr7GafAtLnUhZlvziotzbGrqkgHr4gabLn1WYBMX5uwq02vSNiiiB+sReoRK9JCPmb9IkXMEKyN6zVWdKub2MUZyrDDQY36m7VkmdVqM7EXzIIwkFRhkfLhtmYo4dpsVGtEy0AStT5YBHOGyK0/MwUVVtxUf9PdgmtMSKVI/CAgVLUPwjR0lIkSuEMEu++l3P4MGX6Lul+yEHIZOK9/DTk+jwQxagHv6ikTGQX1JliF4Pszjvek6j79AP9vO/DGkxL5D0GfalE7crDVXP/ypHzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761767378; c=relaxed/relaxed;
	bh=LPaxln2EBfuYN49brJhOaJT913pHIinxeWLCiPWa9ts=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=I5UrQUiebQN9JHBqhTkI58jIOpnPX1jwvXzsuMAbTvm9lalpvlpQ4jsmuxssPx1nLd8mjBRcU0Gv1k+3B9W9lwljMMyGVai1C0809bG3cGyM4jEEt31r31/2op5YXdWj1A0a7Ot/VPwkiMjU7/xaYOsX+0ePN6H4madxhePq+w7tBcvcLZ/wApnkA5CVm9aG0hsSpjNLF4g7lj6HEXwPWZXcdUgS5mDdl/ISuiiLGkS0mp9cFe8FNk8Anx9yJWEnxxcFonE7rdA7M/hZhRY6CR9VsHkF6EXdxiMOLnmSG4itj7lyJBTvuf8qhxY9JhCqYhPdiejE99mtcLlTM8kKJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eBTsrI1y; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eBTsrI1y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxd9r5tQVz2yjm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Oct 2025 06:49:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BA72444198;
	Wed, 29 Oct 2025 19:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596C6C4CEF7;
	Wed, 29 Oct 2025 19:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761767373;
	bh=cgW3eaNa1qTxN0mCfqwnT+I4/Tb+epp984COA7HO+0E=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=eBTsrI1yyG/5IEBOvpulu2NhU99j0sEVLtdj8hbSkWDsiMAYCUJg4ULJKi8yRVk2D
	 wnHzaS7GDiEDzkSeW8qzXfrjrf989UcPqwvuaanih9J1yswudljclqy7geLsKf27bi
	 YJoEWXmdeqGFcMNpKog7EeL7YdvNghoVk48LDUuX0jg5hFhMVmwz1zfsLtdJwjIiZb
	 N16/SJNKr+BN3tcnk9I6U1MYcvl+CE5qvdrkf3mIYhNnXNr3OGCUMAJ/qbNU2Xn8rf
	 zONEsmd/lUy/EASyRwrpv0g5Jk+xl47waAewpAD/v+28gBwn06vC0MiSxxfZymkPl4
	 p2SzxTBjr8gRg==
Date: Wed, 29 Oct 2025 14:49:32 -0500
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
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
 linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, 
 linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Joel Stanley <joel@jms.id.au>
To: "Rob Herring (Arm)" <robh@kernel.org>
In-Reply-To: <20251029185448.2121857-1-robh@kernel.org>
References: <20251029185448.2121857-1-robh@kernel.org>
Message-Id: <176176737216.2539117.14470144508390937372.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: hwmon: Convert aspeed,ast2400-pwm-tacho
 to DT schema


On Wed, 29 Oct 2025 13:54:47 -0500, Rob Herring (Arm) wrote:
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.example.dtb: fan-controller@1e786000 (aspeed,ast2500-pwm-tacho): #cooling-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/thermal/thermal-cooling-devices.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251029185448.2121857-1-robh@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


