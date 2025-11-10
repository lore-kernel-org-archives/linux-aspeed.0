Return-Path: <linux-aspeed+bounces-2855-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07269CCFA13
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Nov 2025 12:29:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4prs41zHz2xqL;
	Mon, 10 Nov 2025 23:29:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762777789;
	cv=none; b=hwpThH8KpCBK+aUQXg8hjg71dVXeiTVQPB6MZ/I+PyhJkN4C7gcUKmBlxSrE9Nj2P4qVRxvHhDvZ/BZF7fetZhLNiBu/Lmjvl+UAu5e8+nRwkSSi2gc7Y8XBj6wZaCG44U4VneCi2bL0T08Zw0Fekb6rolHwOtmFvyExKrEq1VK1EZAI9sSS1pwJURtNrpm/+LJFZqsydtr3nvlufIdCTjfMvH2ILAo7gZ2g18b7JG99Ef+1uXdKphaB2Da2sRev+OKNGX7s2JQi66/OVmiAUfBDYRvB6SvrTOpi4li+slSyibnwRxIiJNucQmxhav3fzXfIwwaEx4Zcm6o2A3CTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762777789; c=relaxed/relaxed;
	bh=mNOOJCB8albSnOy2PW8ozy7g2ecjY5FgeI9tcxPt244=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=lojI/NxWQHJmZuoBy0tsdQBei/i2yVID6iDf8eEyG6LDeBN+RuWGtnRmTp0zPtZlYBdZW9pymPA/ii4ZVpnBFFWuL3pW/SNrvv3KxYMYde4SmbYmigv9aAHfUgnduyPfCZlGtIUk8s/GS4lnvs9KzlM5tlEI5e17NUSut5RQddQ5Bq/e9wULby+wam9kpuiPaeo1MEdexKKePbItYKi4tDpqv4ZWmcyXdtTHer23J+1MFqoyeeT0WwIoJH74JmIjyQb7CslCN0vi5VQcDrmiNI6DEd6DK+0W/oZl803Lys9CfLhvvhtOv8ilJ3ugdqobqKA5GmvFe2ptcGhhWIx5Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Vojs3Ny7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Vojs3Ny7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4prr3CXpz2xFT
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 23:29:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AAC4F443AA;
	Mon, 10 Nov 2025 12:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384CFC16AAE;
	Mon, 10 Nov 2025 12:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762777785;
	bh=CHqHQvKuqRvxJRHlw0G9YM2cvk8+dDccmko+WcI99KA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Vojs3Ny7+r1bvs7xTzB+Em17tnHg4ejqwiAsKUBRNYBKq2ESJ8HM7869IXkyne2Ic
	 kQYYlyBmu1zFWRa+XAKfg+syhhn8K7Ke/Aot2v11KTSHp0E+iUNBkh4cD9IDovyqLm
	 I3qy+942BJ+DIqcDZ5xo75PyknQcArDRNJRFGjwoGZrHJkkyzGqNWYn6yS5v1Sfu+F
	 T3edgQ6vZ1QXPQogA+ippFN1frbOwGnby77b3KjRDBEAT/mjKLLSmsiCAn4JPUwmez
	 yfrUUnoHWOXIgAiE4QYBaHHoDbQ7usE/VbAQ4+F+cBaKnNnNbymnEDKXE29apneaw/
	 xxSWFOH6NdReg==
Date: Mon, 10 Nov 2025 06:29:43 -0600
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
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, netdev@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 taoren@meta.com, Po-Yu Chuang <ratbert@faraday-tech.com>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-aspeed@lists.ozlabs.org
To: Jacky Chou <jacky_chou@aspeedtech.com>
In-Reply-To: <20251110-rgmii_delay_2600-v4-1-5cad32c766f7@aspeedtech.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-1-5cad32c766f7@aspeedtech.com>
Message-Id: <176277778351.3693581.6347765163045847296.robh@kernel.org>
Subject: Re: [PATCH net-next v4 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600


On Mon, 10 Nov 2025 19:09:25 +0800, Jacky Chou wrote:
> The AST2600 contains two dies, each with its own MAC, and these MACs
> require different delay configurations.
> Previously, these delay values were configured during the bootloader
> stage rather than in the driver. This change introduces the use of the
> standard properties defined in ethernet-controller.yaml to configure
> the delay values directly in the driver.
> 
> Add the new property, "aspeed,rgmii-delay-ps", to specify per step of
> RGMII delay in different MACs. And for Aspeed platform, the total steps
> of RGMII delay configuraion is 32 steps, so the total delay is
> "apseed,rgmii-delay-ps' * 32.
> Default delay values are declared so that tx-internal-delay-ps and
> rx-internal-delay-ps become optional. If these properties are not present,
> the driver will use the default values instead.
> Add conditional schema constraints for Aspeed AST2600 MAC controllers:
> - For MAC0/1, aspeed,rgmii-delay-ps property is 45 ps
> - For MAC2/3, aspeed,rgmii-delay-ps property is 250 ps
> - Both require the "aspeed,scu" and "aspeed,rgmii-delay-ps" properties.
> Other compatible values remain unrestricted.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../devicetree/bindings/net/faraday,ftgmac100.yaml | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml: properties:aspeed,rgmii-delay-ps: 'anyOf' conditional failed, one must be fixed:
	'maxItems' is a required property
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'type' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('type' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'type' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/cell.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml: properties:aspeed,rgmii-delay-ps:type: 'integer' is not one of ['boolean', 'object']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251110-rgmii_delay_2600-v4-1-5cad32c766f7@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


