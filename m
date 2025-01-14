Return-Path: <linux-aspeed+bounces-465-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9CCC02180
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jan 2025 00:07:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YX8Zw4F77z2yvk;
	Tue, 14 Jan 2025 11:07:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736813256;
	cv=none; b=j7TIp65GHbQP7AHitGWPe5mchn9VP551WgM2MXx0i8PMpSGnCzZ2q8jdU75XUQb334sfSUw5MohgvEyo7cdzek79ZdgW6blM3beoMlick9eaD59pey5HrTXMknrs/mi0seJLB7aiAA2AEzxYZtKN5q1km1sLuIsgWiYCQaU2KsA5V+IQIx54hfohGnj66a6JMTXOMFa2urb4T26oc6Ui0RDSBcdX4GP9uz3mnQij0uPzrTMhNACNapg0EcrWlxBmTpcNOjNRb/oCYzagcLJEZ8ze4QTa025YGo1WzfeN+NmPcOS0hX7NTdogGoi9uFqSjG+OG0h2thVqU27sgjJqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736813256; c=relaxed/relaxed;
	bh=69NwRHPDpUPhrQVlnwmwVJ/LoaQPQWrcqlUlf4HPYdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScdBZa9EVP4te+dPaoIB3JGFZLEGdIx68KzpU6YsO+FbhlSPKeiZevATK70XuZydVp6IAY9ZjEUNyY3JxhQmkbdUau884E3kPLiB7nK/I+D6G76gaBlWFOlIorx4fdPgApdMHxQUVFlrgpYpte2B28aY219td7FNf4uV7CjSIRnEFfIOprTFVgPT/0Jvaov5URS07aRlrZ15X+XpBJfI4pjBiI2OBCvdQxx9whm4vhYQIkl4UMv/8CaVteFEQIootna7Ob/mUjr4Q6K87CJTlZzE1gr/LYwWKLMMobnuMvKmGjKNlIE6cbAmH1rpBks1ALKetD8BFrKiOxHiLtpbwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gOTFj0wR; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gOTFj0wR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YX8Zv2Z2mz2yMX
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jan 2025 11:07:35 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 235C3A40883;
	Tue, 14 Jan 2025 00:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8A6C4CED6;
	Tue, 14 Jan 2025 00:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736813249;
	bh=YFHHVZRBvQPdmgWH/zLMVMHmLYNVEI8tzbQwTlW2Ih0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOTFj0wRO1DfGUp6+VPCpqUafTsi7L81Xr/N1PyvWv1a0wb1I4O86uruKRYFwp/yb
	 igPuym1uXdVCyaO46OsTWZUuJAeWGwjtlxxC8TFV3UYQ7vSkFlpWbKNa+ttNjOZmS8
	 DqED6du4VBtXZGo24cMncrjO+hPNftFqjQ2ivI/4lO/jbzA89ZglO+T2AL/lgVeyl+
	 ri9/TJeJp7GMU4FOlVQfq5iRNAJHTgDVY59qI3DaMhQXZ6DWnW+B3v2AiqX+EF7MvC
	 xzTniRwae/Ojf+PxOth+YwBTUMArkHFSH4ZpuPDAh+QcNg4CK4BoHzKC4ZKB/x+ki5
	 M53UnNGvTfAmQ==
Date: Mon, 13 Jan 2025 18:07:27 -0600
From: Rob Herring <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: linux-aspeed@lists.ozlabs.org, davem@davemloft.net, edumazet@google.com,
	andrew@codeconstruct.com.au, netdev@vger.kernel.org,
	kuba@kernel.org, joel@jms.id.au,
	linux-arm-kernel@lists.infradead.org,
	openipmi-developer@lists.sourceforge.net, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, pabeni@redhat.com,
	ratbert@faraday-tech.com, eajames@linux.ibm.com,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch, minyard@acm.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH v3 00/10] DTS updates for system1 BMC
Message-ID: <20250114000727.GA3693942-robh@kernel.org>
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <173637565834.1164228.2385240280664730132.robh@kernel.org>
 <a8893ef1-251d-447c-b42f-8f1ebc9623bb@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8893ef1-251d-447c-b42f-8f1ebc9623bb@linux.ibm.com>

On Mon, Jan 13, 2025 at 01:52:01PM -0600, Ninad Palsule wrote:
> Hello,
> 
> On 1/8/25 16:34, Rob Herring (Arm) wrote:
> > On Wed, 08 Jan 2025 10:36:28 -0600, Ninad Palsule wrote:
> > > Hello,
> > > 
> > > Please review the patch set.
> > > 
> > > V3:
> > > ---
> > >    - Fixed dt_binding_check warnings in ipmb-dev.yaml
> > >    - Updated title and description in ipmb-dev.yaml file.
> > >    - Updated i2c-protocol description in ipmb-dev.yaml file.
> > > 
> > > V2:
> > > ---
> > >    Fixed CHECK_DTBS errors by
> > >      - Using generic node names
> > >      - Documenting phy-mode rgmii-rxid in ftgmac100.yaml
> > >      - Adding binding documentation for IPMB device interface
> > > 
> > > NINAD PALSULE (7):
> > >    ARM: dts: aspeed: system1: Add IPMB device
> > >    ARM: dts: aspeed: system1: Add GPIO line name
> > >    ARM: dts: aspeed: system1: Add RGMII support
> > >    ARM: dts: aspeed: system1: Reduce sgpio speed
> > >    ARM: dts: aspeed: system1: Update LED gpio name
> > >    ARM: dts: aspeed: system1: Remove VRs max8952
> > >    ARM: dts: aspeed: system1: Mark GPIO line high/low
> > > 
> > > Ninad Palsule (3):
> > >    dt-bindings: net: faraday,ftgmac100: Add phys mode
> > >    bindings: ipmi: Add binding for IPMB device intf
> > >    ARM: dts: aspeed: system1: Disable gpio pull down
> > > 
> > >   .../devicetree/bindings/ipmi/ipmb-dev.yaml    |  44 +++++
> > >   .../bindings/net/faraday,ftgmac100.yaml       |   3 +
> > >   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 177 ++++++++++++------
> > >   3 files changed, 165 insertions(+), 59 deletions(-)
> > >   create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> > > 
> > > --
> > > 2.43.0
> > > 
> > > 
> > > 
> > 
> > My bot found new DTB warnings on the .dts files added or changed in this
> > series.
> > 
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> > are fixed by another series. Ultimately, it is up to the platform
> > maintainer whether these warnings are acceptable or not. No need to reply
> > unless the platform maintainer has comments.
> > 
> > If you already ran DT checks and didn't see these error(s), then
> > make sure dt-schema is up to date:
> > 
> >    pip3 install dtschema --upgrade
> > 
> > 
> > New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20250108163640.1374680-1-ninad@linux.ibm.com:
> > 
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: gpio@1e780000: 'hog-0', 'hog-1', 'hog-2', 'hog-3' do not match any of the regexes: 'pinctrl-[0-9]+'
> > 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> 
> This is a false positive. So ignoring it.

No, it is not. You need to define hog nodes in aspeed,ast2400-gpio.yaml. 
See other GPIO controller bindings that do this.

Rob

