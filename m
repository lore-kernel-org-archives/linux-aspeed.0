Return-Path: <linux-aspeed+bounces-375-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5402E77188
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 22:35:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YT2mM3DlCz30Vn;
	Thu,  9 Jan 2025 09:34:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736375699;
	cv=none; b=mVpV7wR6LB8Io7f+Jc1zXGMEofq7gcZEH2ZOv1U+cc7n0dclOdY6BDA0fSEbG13J+ckKbelZAoN0u2wdopsf/2aDO4pmrJXn5SaGbs0BavPT/Nj7P8rDyCw17Ywgi9Owk9kPRnaSdBk7s7zqwqXeB0BGkXEvrfzIKWXY4oKm2NA9ptxT04OF5HK9/Q6Hlc+JPYHRnxJOCtMZFOliPG8sHtagQJICtJHsgg+L8G9Ok3yeAG7FCkLBG/s1qwFLQlHvO+1i4IR7Xj0+zYB92unjNA40NHigyeUEhhkExcRKie1hBx4e+tu8dcriV31uYSq08Q/ZNLrnimVAO3MZ8AQCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736375699; c=relaxed/relaxed;
	bh=5jkJGJh6qg7gqpG0258mYZWmPB/PDke8D18KXs7aowM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=fvVlX6k5sdacX16HONB2g+Iv6mnp3kYQ9kLwY4ctDG4m58pPxT2buxdaFewi5H9jD0ksqtlLS91aN0CqFraio1Xlm4nKe4L8cv1A5C4y2Mopo9Kmvh1GqdhAIbVgtsXoeAKqMe3BbS0LIeqUmM3QXT/HjnQI/Ie0oX0VksyhG2sKQJm/uO/ess+u+b7gELOfB5pIR+wNwUiNvez+ZBrJXTfSKjUfc9eqCBlQHp7iX+x2uqg8M7329g+NSmNsMp7JjktxuM/XLyfgtgq2IiuRq/v3NEzkvxTYDO1w3XBw/BPhNlhze1GKkJpN4o3pnYMwIGC9gBBoWWevxWt6ONO/xA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DVL5qOVZ; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DVL5qOVZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YT2mL1KP6z30Vj
	for <linux-aspeed@lists.ozlabs.org>; Thu,  9 Jan 2025 09:34:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 684ABA418B5;
	Wed,  8 Jan 2025 22:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909D3C4CED3;
	Wed,  8 Jan 2025 22:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736375694;
	bh=bavaJ0imBpiVDIZhMho4cmKy8OAAsoDpvSMGWGk11xs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=DVL5qOVZL39UAGjraeHcvN9+EiwMsO5uvCQZuIjivuCx/caoxptFKTqFqZA1Pnlu/
	 oOori9v01SKtm37Tb19Cl9o7owsTUFOSZPuF8lySZN2z4KYY5oAcFg0PeqZo7OjWOp
	 FF7kkNC0eydNPJwl144hT14MUHMyAQ8xzcxK3smzVgu7KiYBsJdty1vVqa9CVViK5P
	 9gAoDmSmuFzudGXdrIc7ip+xq8lP9pDOf07+bJxIj1ZoNQh524/xvpGewpLWCJDhtg
	 DtKVfm/pTNJx6Nrwud6IfixQwB31VRrfK++8NZMWEv4jHf1rGS9QTxvCXmPooB2LAu
	 HFqNdtYQFUB6g==
Date: Wed, 08 Jan 2025 16:34:53 -0600
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
Cc: linux-aspeed@lists.ozlabs.org, davem@davemloft.net, edumazet@google.com, 
 andrew@codeconstruct.com.au, netdev@vger.kernel.org, kuba@kernel.org, 
 joel@jms.id.au, linux-arm-kernel@lists.infradead.org, 
 openipmi-developer@lists.sourceforge.net, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, pabeni@redhat.com, ratbert@faraday-tech.com, 
 eajames@linux.ibm.com, devicetree@vger.kernel.org, andrew+netdev@lunn.ch, 
 minyard@acm.org, krzk+dt@kernel.org
To: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250108163640.1374680-1-ninad@linux.ibm.com>
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
Message-Id: <173637565834.1164228.2385240280664730132.robh@kernel.org>
Subject: Re: [PATCH v3 00/10] DTS updates for system1 BMC


On Wed, 08 Jan 2025 10:36:28 -0600, Ninad Palsule wrote:
> Hello,
> 
> Please review the patch set.
> 
> V3:
> ---
>   - Fixed dt_binding_check warnings in ipmb-dev.yaml
>   - Updated title and description in ipmb-dev.yaml file.
>   - Updated i2c-protocol description in ipmb-dev.yaml file.
> 
> V2:
> ---
>   Fixed CHECK_DTBS errors by
>     - Using generic node names
>     - Documenting phy-mode rgmii-rxid in ftgmac100.yaml
>     - Adding binding documentation for IPMB device interface
> 
> NINAD PALSULE (7):
>   ARM: dts: aspeed: system1: Add IPMB device
>   ARM: dts: aspeed: system1: Add GPIO line name
>   ARM: dts: aspeed: system1: Add RGMII support
>   ARM: dts: aspeed: system1: Reduce sgpio speed
>   ARM: dts: aspeed: system1: Update LED gpio name
>   ARM: dts: aspeed: system1: Remove VRs max8952
>   ARM: dts: aspeed: system1: Mark GPIO line high/low
> 
> Ninad Palsule (3):
>   dt-bindings: net: faraday,ftgmac100: Add phys mode
>   bindings: ipmi: Add binding for IPMB device intf
>   ARM: dts: aspeed: system1: Disable gpio pull down
> 
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    |  44 +++++
>  .../bindings/net/faraday,ftgmac100.yaml       |   3 +
>  .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 177 ++++++++++++------
>  3 files changed, 165 insertions(+), 59 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 
> --
> 2.43.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20250108163640.1374680-1-ninad@linux.ibm.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: gpio@1e780000: 'hog-0', 'hog-1', 'hog-2', 'hog-3' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#






