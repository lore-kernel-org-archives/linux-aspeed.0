Return-Path: <linux-aspeed+bounces-1997-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DE7CA0EE4
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 Aug 2025 13:28:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c5D7s2nwwz3cZB;
	Mon, 18 Aug 2025 23:28:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755523737;
	cv=none; b=KdhIM/E6NfBeXcvqnf8nd1pd8pdkYtn6JDwZZflqn5GgEeW9X8ydYdPfYtQ7zgFg1+SnrO5u2EhQnyPc/Ih461QSq78xmDHt5A4w27qHtGkNeO4A+o3W+Cp57fpc9Ptdvyqcn92+HgRlmaPGJiFdZ7IgLcYzQUMQgCjBiB31m9PpCiBoVcz3Nq5g033Sx3NaRwewAxGvjAto+C7yZ2drXFExKku+kvLm5rhpfpEX2VUAccebKU9m6S6sF7cqVEFkzr0fCfpQehHeRuGZfYT1paVc9+AUJYfnTRzm3CWfRBJc33VhhyHXBOMsdnEJ5W66Itcp/SMSQVN2CZI8sLhAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755523737; c=relaxed/relaxed;
	bh=MaWChzm75NlxUDXwoRa3Ny5ymA7uyfLqxhMSPQgO+EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8VB0KSY8Alp62Bl5pMbwIX/q+/0sR/CeFoVFqCiQowEz4BvDQgGAuBQ4DVKt0G1QMD4Vtzj6dszr5BhWLfzGdKTpPxTqwR1R3ee0vCINHA/ZlhM93RaGCqigjYJWtR3kOqNuaCvgf9EK5Hd727jZXyUK5qlXQ/+Ascs0P0cFAMMYyJOPnOj+jCXcJ4jq8V4QXQo1BVmqtgaJsEHNXbg78jeZrNGwwDMHBCFMH8lmcl+Dlh/IUF1FBAcfkn/4IKHB6jTzqYDPCHJDHvZBBrWmK9zUWbBTPTBfdwec7tdQoASQitqhsi/OuFr+ewHpdwwPCiV4si+7iBhyYyitatNTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UzKL51+l; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UzKL51+l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c5D7r386Sz3cYx
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 Aug 2025 23:28:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EEA525C4BEF;
	Mon, 18 Aug 2025 13:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F16C4CEEB;
	Mon, 18 Aug 2025 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755523733;
	bh=RBe2h9lREBKMOmk9gFLPEM/Gqn8YS4oH4RhZ7ngYXOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzKL51+l7SeFj7U7Tu6qmnCM0DnKHgZbXB2R5bG+feymwxfsZPoEhbY3NNAOrd+j5
	 rYTnggDp0uvf+rEIvs5bDyBqFi5zSlBUX6Ul41V6VH5v3anL8D29xazLs7nnVS7yWx
	 XnuU3+glg5x90JJsU3smQvLEmWLhfGj/RFpcZ+HaDw0zf58CjP/aey0OETt4jPGXpD
	 GIuxyxGJeWcbnjFzi4N5NmjKzUaDG6Vud2R6Kbiwqd9CWHMUmymLc0B6pevLjVLc1v
	 fPqGLWBLn6NkdHFX1/GM7PL+Rkd75t+AT9GqYGqjHABQYavWpIIlvgPlcgCTior7FU
	 M+i6djJxKbmgA==
Date: Mon, 18 Aug 2025 08:28:52 -0500
From: Rob Herring <robh@kernel.org>
To: Marc Olberding <molberding@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 0/3] Adding device tree and binding for Nvidia mgx cx8
 switchboard
Message-ID: <20250818132852.GA882651-robh@kernel.org>
References: <20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com>
 <175530106151.3523036.5305359646677111575.robh@kernel.org>
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
In-Reply-To: <175530106151.3523036.5305359646677111575.robh@kernel.org>

On Fri, Aug 15, 2025 at 06:38:54PM -0500, Rob Herring (Arm) wrote:
> 
> On Fri, 15 Aug 2025 12:45:54 -0700, Marc Olberding wrote:
> > Patch 1 Adds the binding for the Nvidia mgx cx8 switchboard
> > Patch 2 Adds dtsi's for the mgx cx8 switchboard itself
> > Patch 3 Adds the dts for the mgx cx8 switchboard motherboard reference implementation.
> > 
> > This is an Aspeed AST2600 based reference implementation for a BMC
> > managing an Nvidia mgx cx8 switchboard. Dtsi files are broken out for
> > managing the mgx cx8 switchboard over i2c, so that others may reuse these
> > if they choose to implement their own board. There are two dtsi files
> > since the i2c topology is not symmetric between busses going to the mgx cx8
> > switchboard.
> > 
> > Reference to Ast2600 SoC [1].
> > 
> > Link: https://www.aspeedtech.com/server_ast2600/ [1]
> > 
> > 
> > Signed-off-by: Marc Olberding <molberding@nvidia.com>
> > ---
> > Marc Olberding (3):
> >       dt-bindings: arm: aspeed: Add Nvidia's mgx4u BMC
> >       ARM: dts: aspeed: Add device tree includes for the cx8 switchboard
> >       ARM: dts: aspeed: Add device tree for mgx4u BMC
> > 
> >  .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
> >  arch/arm/boot/dts/aspeed/Makefile                  |    1 +
> >  .../boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dts    | 1078 ++++++++++++++++++++
> >  .../dts/aspeed/nvidia-mgx-cx8-switch-north.dtsi    |   80 ++
> >  .../dts/aspeed/nvidia-mgx-cx8-switch-south.dtsi    |   80 ++
> >  5 files changed, 1240 insertions(+)
> > ---
> > base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718

next-20250521!? Why are you using linux-next from 3 months ago?

Base your patches on the latest rc1 unless you have some dependency on 
post rc1 changes. Usually that means you need to base your tree on the 
maintainer's tree the series applies to (ASpeed in this case). 
The *current* linux-next is a shortcut for that.

Rob

