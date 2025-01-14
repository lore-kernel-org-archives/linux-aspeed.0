Return-Path: <linux-aspeed+bounces-482-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B12E77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jan 2025 23:58:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXmKN1mLJz2yVX;
	Wed, 15 Jan 2025 10:58:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736899080;
	cv=none; b=VACA7nSNE3qDtQKXAAfvEITprJE6sunV7F5ELJjhx2vuwHM2/qbP2FVbkX6ukO9cPbwP71hHMVCy30GeP/y0z8SgBI65F0d2ZbZk+9J0P34KZ7Hj+lByASgBxChDuW+/ntToJGk2Sk3FZT1vIvxeNj4vYuirFoZobpXwJFqfhxGobTj7VrvQkhXrUPEqoZs/1vqgLS6GYIKj5dH/sVfQIRW8/KOSLgzKzAzvK0B9Fk2U+FsS2UM8KX9F7mFTw0PybDyTxk1MiM4AfYJN1U2ohcx9LcybnGVJ1ituDmoTVBhOVAXXpZOF0/D0ciN7+DFWH4UVdMli4MqLv6LorU1AvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736899080; c=relaxed/relaxed;
	bh=Lgpd9qSYbSO27cTLVVtK32TzSRP1yS2DhHPZv759j/0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=TNQiewH7cXR8w0OD88n1otf2BiUzMkNV7XImwa3juTxVW3ZgkUDUmeS9VeNy5/Y3P7kJ5bR7qE7KFPXMMkB6SBZcIBOqIkrwLLHkLKJzcAAij0yD1CkWiQbQzuhy48CSrdxopQ79hTNuHd96c9jAxJag7GUvXEkJkRxxXZJY4bAHYigBuiHQ/cnoeQDsbJfvwuef5qqkKZAUEJtPZAdogABwkl4x811iYz7BdUBPDA2zSUzWERKs9uq/ohUH+6lwysoudj8aalU3wJkEmqnA73MtuN82+YfXD6uHOrUtwRfCIiVPIWY3pADO9sqv4RWIKMVo8MN+15/JdPOKMgsiCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jxngMlvI; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jxngMlvI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXmKM1sllz2yVV
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jan 2025 10:57:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A9B475C5944;
	Tue, 14 Jan 2025 23:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29BAC4CEDD;
	Tue, 14 Jan 2025 23:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736899077;
	bh=qYcadH5zTVf6YXQcR12gkpEXX8NXXimDRL8MXEYl88I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=jxngMlvI1aMH7uwkSNtEMSo14UCuU2hwadYpy8TGifVRhFKGYRXkjD8bHJaeDuGjp
	 AeuWNlEeSkWvTVqZZHSyoVuIEOfWATWVpJfr1CTZkPcPUqxjNsTEQhSov8/KnowEL5
	 CvQg9E8qJCtw9Il4ZjD2H2I9Cqly4JEQPTspsZBthQy65l6WPXtta9EFp6hG+9UKnI
	 m9DFyGiLnsMunIEMMhHIEgusMkuF1M6leSBraIeKhJCHqf92d865JChCjeNBvTyU4f
	 cdFhJabsFOTtH0IsfqAktwOWynpwEd9PBgziJ0YRbPkQaTNAXtDIM5zA+LO6T1/lM/
	 pTET4Szz1XfIQ==
Date: Tue, 14 Jan 2025 17:57:55 -0600
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
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew@codeconstruct.com.au, 
 davem@davemloft.net, edumazet@google.com, 
 openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 joel@jms.id.au, linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, 
 conor+dt@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
 minyard@acm.org, eajames@linux.ibm.com, 
 linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org
To: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250114220147.757075-3-ninad@linux.ibm.com>
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-3-ninad@linux.ibm.com>
Message-Id: <173689894057.1969633.10540050942005147267.robh@kernel.org>
Subject: Re: [PATCH v5 02/10] bindings: ipmi: Add binding for IPMB device
 intf


On Tue, 14 Jan 2025 16:01:36 -0600, Ninad Palsule wrote:
> Add device tree binding document for the IPMB device interface.
> This device is already in use in both driver and .dts files.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dts:24.32-33 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250114220147.757075-3-ninad@linux.ibm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


