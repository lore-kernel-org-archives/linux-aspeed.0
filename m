Return-Path: <linux-aspeed+bounces-245-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0DFE7717F
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Dec 2024 16:29:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBll90WhSz30HH;
	Tue, 17 Dec 2024 03:29:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734366565;
	cv=none; b=T6Wn+I7+YEU/4W2rXjGKOtHfKnQ2f4bE7z38Mz7Bv92Se/dDaS6jyNsvsg4JbLeKWHYqTiORfbQYR45ANTiJYm1xeYrROzazG65DvLh11AmYQftHEDogkV2bIVRgbqPP9pEpuZ8WYAFssgwRKIKXLO9wu1IdadlBOCxsC6Ax947NHeRXP5LHoAx+2MreC7xtn0Sa75tQtSgrVFMmuuwIPCx09dKNzMDgVB6IMPED/M0zVXOTeeDTFtZAj1wxLAmOV205issUsNdEFTRQ3JHJR2HOTu5ezhtR+ujo9G/N8959cQowlv+wYpbnyRw/p4daBjcUskbHLV582ubQ4825cA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734366565; c=relaxed/relaxed;
	bh=cZOb4Oup51mkztZb/UWtRpPWTGZ+DRoM9v65S3bfnts=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=nfTERVni77+2k/clV0YshJNR0U2QUXq3ZYDG2knBYWD7EIBKn2iTgjDVY1d7jKKJkspH7thIQarSibKktBojjlDTpQ56J43xf2BVob/eNDmPnEHuZZ1CB/9YSAaFrpYbdtU/0MExsL+jQd1vWO3vLK32JGuwi+GvNWZpLwkp+x2peN1zYg3uxZ+LXON59ZwsiZAG+xcOo6C67/0XnefWHAw7RqMiSUfegl3UtZvVnZiTx4wG498E17OxzwzYz7CfqeCAid/Y0bUW0HI3NRrdzfGP77aNz9+oQL6n3BWr5JCg7dEAuo5j4ldmqzJa8kDqaOaufDgHUsOuhWsSiJ4/aQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Roi7m7tT; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Roi7m7tT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBll76B6dz30Gm
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Dec 2024 03:29:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CA1815C5FDA;
	Mon, 16 Dec 2024 16:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76040C4CED0;
	Mon, 16 Dec 2024 16:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734366558;
	bh=eTH5PAJYArUjyYFUhkavXr9IHbyJp0cHmZVtDEdnjTA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Roi7m7tTvG8r+dOMRufBtBzf5LMU1seuLVmkSmHbU3rEmITSOGpJPXpjrhRr6X/Hw
	 HjJNiLkX/IW0bMxbpw8I7wXh2MYhrvMJhlBy9D5p7t7HDayiUqPKsRawGDGMovBNlS
	 avFCa7hVK+M+YD265Uh72h9hwn8tGEtfrsQuVmO6n24edW5BlwsRWomv+RYm5062dz
	 ITYKSdLGCLsY/0nuuRu3xeW+So58/l4eeCXi4FPGK0wtN10XmDGoDR4YfAIyqSobCa
	 EKeJEo+JrYhxJiit9foSGLVBy/GqYkyGTePRQtBGUgGQvaGbbHcSryDpo13zLU/db7
	 8vatbl3MVjO4w==
Date: Mon, 16 Dec 2024 10:29:15 -0600
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
Cc: andrew@codeconstruct.com.au, linux-arm-kernel@lists.infradead.org, 
 krzk+dt@kernel.org, eajames@linux.ibm.com, joel@jms.id.au, 
 devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, conor+dt@kernel.org
To: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20241213145037.3784931-1-ninad@linux.ibm.com>
References: <20241213145037.3784931-1-ninad@linux.ibm.com>
Message-Id: <173436597537.264948.12611164276777551472.robh@kernel.org>
Subject: Re: [PATCH v1 0/8] DTS updates for system1 BMC


On Fri, 13 Dec 2024 08:50:26 -0600, Ninad Palsule wrote:
> Hello
> 
> Please review the patch set. It has various device tree changes for
> system1 BMC after hardware testing.
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
> Ninad Palsule (1):
>   ARM: dts: aspeed: system1: Disable gpio pull down
> 
>  .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 178 ++++++++++++------
>  1 file changed, 119 insertions(+), 59 deletions(-)
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


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20241213145037.3784931-1-ninad@linux.ibm.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: ethernet@1e660000: phy-mode:0: 'rgmii-rxid' is not one of ['rgmii', 'rmii']
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: gpio@1e780000: 'fan_controller_reset', 'isolate_errs_cpu1', 'rtc_reset', 'srtc_reset' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: rtc_reset: $nodename:0: 'rtc_reset' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: srtc_reset: $nodename:0: 'srtc_reset' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: fan_controller_reset: $nodename:0: 'fan_controller_reset' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: isolate_errs_cpu1: $nodename:0: 'isolate_errs_cpu1' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb@1e780000/bus@1e78a000/i2c@280/bmc_slave@10: failed to match any schema with compatible: ['ipmb-dev']






