Return-Path: <linux-aspeed+bounces-3050-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03FBD2F7E7
	for <linux-aspeed@archiver.kernel.org>; Fri,  5 Dec 2025 12:31:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dN9jY2svPz2xPT;
	Fri, 05 Dec 2025 23:31:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764937905;
	cv=none; b=jdjkMbk8Ii96UX5u+LowXe/SAGX6EJrUXf49PTVyu/6LzmCl/byBSuYkZMj9WZTU6e6YsodyuT8R5Vx99AZ0bQXNwAK2a8aB+WUkfPY7vAgKCaZdJPWxFGQCnHq2OzSgo7ho5RK7GSez4Nq0r6JJGX7PkcS26d8h7wAOcfpLkF0ALbYtcAG7B+qgb9riW1PSO3BoadRLxwCF7fLLCey2xLA73O5ywPHH5iihzeJEyuBALwfsq1dO3D57WJEwrY02ryimuU4E0c4owD+3L86ZaU9nsUAP3qK0KVabLHZijVhqL5QX2NcobG/8299Me47SYOyaQx0CsyemZvJ5RpXb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764937905; c=relaxed/relaxed;
	bh=l4F7qYqLZeOCrE0lRTQguiPWaKCW91ggfPfoAAiaTBI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ZOLGZBWnW7Op/0UoebUPkfTihUh2loOr59c24SeHN26vY33GzSM68VzPzZoXcCU2uTTusGxmvXFY4oGf+zax8Elbp3363V+zGYgwIvyBcCGAfv/W4vv0KwYMsgCtHeDG4zTdEmyS0W9qp+5CL7mYFzRGBqTjUfCVOl796+X7XbXqQbloKfhsSPp/miXH23OSfytLBoR4p2mrVurcDO8M7E9QeYaOsF1JZcYbYTuDlcD2pQpDpEE1tcSdWRSYYD5CQlSJT8kdNi3VcVazncWJs62RHRFlRxcz9cDMNDCDFhv4UrRTYfNSzAQJg6amJN9yWlfOY7Cx/bjo2RJUMIUIIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tXhIB5b0; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tXhIB5b0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dN9jW6bW5z2xP8
	for <linux-aspeed@lists.ozlabs.org>; Fri, 05 Dec 2025 23:31:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CBD6B441D4;
	Fri,  5 Dec 2025 12:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F46C4CEF1;
	Fri,  5 Dec 2025 12:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764937900;
	bh=+CRp8yynNybcaLkCmQEtMgcN2+GKbGVhIF5SJyTicA8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=tXhIB5b0mw0rKTR8eoXzV6oxQnxEw/MzuhlOAvEmOsk57XOh9k4uL8rF2J6AUNVTV
	 ONYrWBrxjMW2IczWFxsNsRKQGPnHy3feKLHvqUNSEnpTMzBxQmaSSZf5gUEavb1z7R
	 V80WFmiCmR30pCYp4QIDFAynSg+HhDbeJJOFe6RStTj5YnYSWbjMfvMsRICH0a1WPl
	 09Lmc5z5Nq7NJMipN/9sVTRA8DqkwOqqfksHtnT9lbzeNPXPguuvgxrWmidL4WTw7O
	 Go5BUZBaiCmjrLBM8mY6Y2hUhHT8H/EaorozADDM1vSPz7yxX74eiz1ZWsTqMF8cfZ
	 O9F9pIJh7KlUA==
Date: Fri, 05 Dec 2025 06:31:37 -0600
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
Cc: Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org
To: Rebecca Cran <rebecca@bsdio.com>
In-Reply-To: <20251204210238.40742-4-rebecca@bsdio.com>
References: <20251204210238.40742-1-rebecca@bsdio.com>
 <20251204210238.40742-4-rebecca@bsdio.com>
Message-Id: <176493761251.3641290.13291920660908033862.robh@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: hwmon: (aspeed,g5-pwm-tacho) Move
 info from txt to yaml


On Thu, 04 Dec 2025 14:02:36 -0700, Rebecca Cran wrote:
> Move the documentation for the aspeed,ast2400-pwm-tacho and
> aspeed,ast2500-pwm-tacho devices from a text file to yaml file.
> 
> This allows for dts files containing these devices to be validated.
> 
> Where the text file documenation of required properties differ from the
> implementation, prefer the implementation and update the schema to
> match.
> 
> "#size-cells" was 1 but implementation is 0.
> "#cooling-cells" was marked as required but appears optional.
> 
> In the fan subnode, "cooling-levels" is optional according to the code
> in drivers/hwmon/aspeed-pwm-tacho.c.
> 
> Signed-off-by: Rebecca Cran <rebecca@bsdio.com>
> ---
>  Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml | 91 ++++++++++++++++++++
>  Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt  | 73 ----------------
>  2 files changed, 91 insertions(+), 73 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/hwmon/aspeed,g5-pwm-tacho.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml
cooling-levels: size (6) error for type uint32-array
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.example.dtb: pwmtachocontroller@1e786000 (aspeed,ast2500-pwm-tacho): '#cooling-cells' does not match any of the regexes: '^fan@[0-9]+$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/hwmon/aspeed,g5-pwm-tacho.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.example.dtb: pwmtachocontroller@1e786000 (aspeed,ast2500-pwm-tacho): fan@0:cooling-levels: b'}\x97\xb1\xcb\xe5\xff' is not of type 'array'
	from schema $id: http://devicetree.org/schemas/hwmon/aspeed,g5-pwm-tacho.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.example.dtb: fan@0: cooling-levels: b'}\x97\xb1\xcb\xe5\xff' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251204210238.40742-4-rebecca@bsdio.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


