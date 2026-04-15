Return-Path: <linux-aspeed+bounces-3909-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916EEF433CE
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Apr 2026 22:13:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwwQD03YSz2xlk;
	Thu, 16 Apr 2026 08:13:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776291203;
	cv=none; b=ZiSF4mqAg+0MzkYWe4P+AmOaZlewCR85HuRt6kLzk76VYWXSMex8CmIN2t/09K5VUsNYwP2Zg3OAsZQ1IcupsDsza5pctKCPCbLOaH/F84v5Z+wMGgYiaQXzPZIpNHFsrex1Rz/EecvwYOrW17NVATCciAFaaMW39F9Xe/p14EAU22W9eSZ/onhZjpvtqyFHg2o3Nu+w7tH42hCAKsljkj2E5utmFzWiR4/jCQl28V75W54Wa8ylf1xPTR0dqDixfJXozs5lek6s39ttOv7wXvEoyoJwfzGHJVCSrc2dZvOIehUT2obG/ojRIv50uoFr3eidUNV+Hvpzw7l9XLQsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776291203; c=relaxed/relaxed;
	bh=HQHfec3hH72Y3B7+L+P3++YEgIgRyAungMyYeGhbsSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4PglLrwbGpeekuqBZ3zc55A5hJli3hVR1VOM59WUsBan4NWVND1Lda4abWNGYVkigJ5A2+mVKAXsd0UPwd2KCdHFBaFCW3QkbUBttijL1z4j4ElsgJGcu+dggzEx+IaioQOheD/0m0edZ0lKVXAzrMRVp/McDIsDWQxQHG45fMlyk3jpE9VMOvKtsEpx9mhM5mXqDBWMniIDJcPiZSlq26LYTpVyJyU7Cpnl00alSZ/v+kAFPZ4UFHlE0prkpVOQ3dB/4sLTiLhcrcr7dXyH4cs20KSA2HETiaBnbA9BVW6J2XexZRkRNrXdYCiVzredyoQWcYiOU8Dxei/ZBXQhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fxNxNToF; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fxNxNToF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwwQB6p2Xz2xlK
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Apr 2026 08:13:22 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 29F6560121;
	Wed, 15 Apr 2026 22:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ACDC19424;
	Wed, 15 Apr 2026 22:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776291199;
	bh=qSg+kNESVJo61aBZDdNgiU9KJvIQqTHcGul9KHiHi/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fxNxNToFUFgjmJk98CnKj500nmscrXFmTs1IfgrgSZPhnw59DyVmfurlClhf+rMYr
	 I///l/oCbWV4sZ0F0VUO3JewFiCHHrGIgQJfXN0Ns7Nz9UWl08WCTDSGuh6fjAdOR8
	 2E4PH1Ggh04LhZv16g9lS9XbtJrjFd1fmKl9sc12Yw0Hjtl3ULi8UAWTWMPTPJeZJF
	 4oxpWyqFS6JdjI7/0YDl4r9Yk9HYj6P8+SdskXzIpRCYNG/izu+hSnO4ndHdHg751S
	 E+PL4D0LEyDAmI0q/Swnu+FWkuSWvPFKIVCz/MPm9/ckFZxN1EHV+W/3OKW2T0DOFd
	 Ysohiw6Q4gByQ==
Date: Wed, 15 Apr 2026 17:13:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: linux-riscv@lists.infradead.org, Joel Stanley <joel@jms.id.au>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-aspeed@lists.ozlabs.org,
	Thomas Gleixner <tglx@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/4] dt-bindings: interrupt-controller: Describe
 AST2700-A2 hardware instead of A0
Message-ID: <177629119770.789152.6115453884565821746.robh@kernel.org>
References: <20260407-irqchip-v5-0-c0b0a300a057@aspeedtech.com>
 <20260407-irqchip-v5-1-c0b0a300a057@aspeedtech.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-irqchip-v5-1-c0b0a300a057@aspeedtech.com>


On Tue, 07 Apr 2026 11:08:04 +0800, Ryan Chen wrote:
> Introduce a new binding describing the AST2700 interrupt controller
> architecture implemented in the A2 production silicon.
> 
> The AST2700 SoC has undergone multiple silicon revisions (A0, A1, A2)
> prior to mass production. The interrupt architecture was substantially
> reworked after the A0 revision for A1, and the A1 design is retained
> unchanged in the A2 production silicon.
> 
> The existing AST2700 interrupt controller binding
> ("aspeed,ast2700-intc-ic")was written against the pre-production A0
> design. That binding does not accurately describe the interrupt
> hierarchy and routing model present in A1/A2, where interrupts can be
> routed to multiple processor-local interrupt controllers (Primary
> Service Processor (PSP) GIC, Secondary Service Processor (SSP)/Tertiary
> Service Processor (TSP) NVICs, and BootMCU APLIC) depending on the
> execution context.
> 
> Remove the binding for the pre-production A0 design in favour of the
> binding for the A2 production design. There is no significant user
> impact from the removal as there are no existing devicetrees in any
> of Linux, u-boot or Zephyr that make use of the A0 binding.
> 
> Hardware connectivity between interrupt controllers is expressed using
> the aspeed,interrupt-ranges property.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> 
> ---
> Changes in v3:
> - squash patch 5/5.
> - modify wrap lines at 80 char.
> - modify maintainers name and email.
> - modify typo Sevice-> Service
> Changes in v2:
> - Describe AST2700 A0/A1/A2 design evolution.
> - Drop the redundant '-ic' suffix from compatible strings.
> - Expand commit message to match the series cover letter context.
> - fix ascii diagram
> - remove intc0 label
> - remove spaces before >
> - drop intc1 example
> ---
>  .../interrupt-controller/aspeed,ast2700-intc.yaml  |  90 ----------
>  .../aspeed,ast2700-interrupt.yaml                  | 188 +++++++++++++++++++++
>  2 files changed, 188 insertions(+), 90 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


