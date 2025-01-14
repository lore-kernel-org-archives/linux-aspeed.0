Return-Path: <linux-aspeed+bounces-483-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E205C02183
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jan 2025 23:58:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXmKQ0yh8z2yVd;
	Wed, 15 Jan 2025 10:58:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736899082;
	cv=none; b=KL73Hcn4TiyJXm4qb5lexkYQSXkV9OQU3afaeRVDrlbTpSyj/LCGW7zSu5nGM+aU42OxT7Zk7sjUgLMGmlfazJOpu4wFITn70AQEQP02XCwHOXNELm/r7JkNnuZBsBzfZfq1CpEeoK6yS7JGKeJRfbAZp5cNx9MUYTTGAjNNLxdhswtQ/suKiBoJPZseOIkCekNV2vd8CkEdBdPPbLaTCY8DJZ0HclMOu1/dF2eNvYeqoPMReSbJf50JY3WA9VFWScIaVeTcHLTpIvhuvE6UeUsCq2caPaUT2Mg9GVCOT66xmweS5aLbIPW8vP27ESKi9mMUKZVZiFDqFCfNJECt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736899082; c=relaxed/relaxed;
	bh=96OHoOwSN+R+9ZgJ6AGbG6E0JjTK7ibX/wrqTSKXGbo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Jocvd+o5UwCIWKglyP6j3I2Zqt/LoSQfvMt8l5Rl81JV/uaDwxF463r1X9iVNEJTiFVfOW/j/PpnonI75VJT2uCIMimJyDQ1JKLGJjWAgi6+t2rArfR0P8c3g/eAOVEIw8nzHx9cOnqwsNDnU8ZTYSFQYyztbc29BzRTBbwjHscNUJHeKt3hOw+t8o1RE543+PcsqwAviSlyJFcZkKN9l069H+C4Igy3yIn+UmCXIRuLlPSjzcBP2ImxTQgTxr+lCR6Qqe8V3gtmGt9D/3YgWbW+E28EVEXUTYLH+MSdcAQ3rK3Axx3dx+ts02UhcIHd4X1jjUskNShJCjXV4rMllA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YR4jv4Vq; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YR4jv4Vq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXmKP44Fwz2yVV
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jan 2025 10:58:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 33BD35C5A5A;
	Tue, 14 Jan 2025 23:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EA0C4CEDF;
	Tue, 14 Jan 2025 23:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736899078;
	bh=tpzPtlhfSg1oMQzL2Ct27bJY5cpUAeZYKUcwY61RUAs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YR4jv4VqMwHB30SIKNMX6+CkulB9Ga/HxazCKrQ9IEhW3b/hkvOihD10wmNx5Zwep
	 xgfu+TfRDvQSNWzq+8nyUNAmlBR4NBhplr8wvhekLzglPGcNjTNu9GPdn6wVp4yCMJ
	 cB+8b70SUbUZECxB/C9SOvcS993DDbrPCKVhNekVJsEnDJ23Rywpi2j2yI8IRb8KSi
	 ndbzYFzP7E/ezdJa8n1pRKj9+3TwSEnWczBn2EHciN9COm2PPFSXlCg3fUbT5VkQIs
	 t4uAsa9uobHF8IBR1P+LB6GGxx3R0XxsgDAoDKZjatJ1Nc5cGFNhYhFuvAIUy2jqGB
	 FVzZJOsLOGrOQ==
Date: Tue, 14 Jan 2025 17:57:57 -0600
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
Cc: andrew+netdev@lunn.ch, pabeni@redhat.com, 
 linux-arm-kernel@lists.infradead.org, edumazet@google.com, joel@jms.id.au, 
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
 davem@davemloft.net, kuba@kernel.org, 
 openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, conor+dt@kernel.org, eajames@linux.ibm.com, 
 minyard@acm.org
To: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250114220147.757075-4-ninad@linux.ibm.com>
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-4-ninad@linux.ibm.com>
Message-Id: <173689907575.1972841.5521973699547085746.robh@kernel.org>
Subject: Re: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing


On Tue, 14 Jan 2025 16:01:37 -0600, Ninad Palsule wrote:
> Allow parsing GPIO controller children nodes with GPIO hogs.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250114220147.757075-4-ninad@linux.ibm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


