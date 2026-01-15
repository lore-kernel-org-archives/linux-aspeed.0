Return-Path: <linux-aspeed+bounces-3349-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592A9D46603
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 17:16:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsV5J6846z2yFm;
	Fri, 16 Jan 2026 04:16:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768497396;
	cv=none; b=daGzY/eLoLjexUXuDMAgN5dByBUZBD29xDLoJ4v21hMdSBLk8T93/EULtd/NLQaAxu4xg/7PBJzlOab0ZkpD+6LXQwB85pIARQvsZUh/2yJHXHQN+jKmArpaGOmGxMj7NI3pU6G46/9wqpmUxmXMqBuJVWoKlN5vEzSv/c2FOlYMHIKoszJ4Vfxwxcd6e1fVeHwM5Mun5o+yFIFWUthZWw/njF2sHSCp44BbxwW0HgwGsBReg5Q4Y4zgMNE0XOGbjrBfKrfQU+uUVMuRL2VuIJJvtDL265d0ij2hlwdyAZTn7wybvawQjZv78d4TNhJpm4PT1gnNuevnrHIgHa2grA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768497396; c=relaxed/relaxed;
	bh=nTQZnv34DAjTZEd7quvl5eWf+Bs88jcQBsc8cMge4ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ol5UlNWEquGTvcF7wWQpmVWTgu69Q+vyBADeUAm4SUYLHdZGNAA211JmSqQqaOz5putstc6PHSuxH3I4wElTvmszVtyGGDr0LkbwtYn8SvTFlekbBuHHAMJRmO7lm9SboPm/CYiyFY1VjbtgkLmCp179lrxxvGKBt22eYmgADvPM5kKKvMqSqm0pFc2VFvmELieigPtA0FwdpoucOnKc66LBKYZccY6/vmRnL/CgvThJ8vmQ84wNgmp9vRlUnszvRHzxzv6LyV3Fza/9J0Jfn2ZqUM8Hv30dWD2j5v8y0G7tEqefm06dNwlJqhrvoK20z27PHPYAark/zUqBuScuog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KlESdXIR; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KlESdXIR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsV5H6mSPz2xNg
	for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Jan 2026 04:16:35 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A7D5060007;
	Thu, 15 Jan 2026 17:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E66C116D0;
	Thu, 15 Jan 2026 17:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768497392;
	bh=EoDuHPKYADtTQ3CbH8ajn3cz4Fwrwq6IKHjrNnSNqVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlESdXIRDi4LaDQt/CNKvfnKjJ7Y6Snc9KH+I3n6uqvXVDaiD4jZonAkz0RnY/GL4
	 GArii35s6IZn9a/VYHwwlHrTzMC3vtBQ3r7Ytdvly+/ZbnHNqztKL/2BdT/FpIX642
	 pXqXb8QllzIwqfiOB3DMMA+jIvzb/MPRjHqx9o5KgjbLEp+bDjg4MBGAUHkyvsfGkL
	 YAiO6lSUymNqEMVRqCF8UlmBAu5tURwePPF/G1aNsiGLYTLamyrpQmYvHf8k+ISQnT
	 9NVBQ/Paj2Z6XSTvkKb5IWXSVGtGudZO50YkPbINj2jsI9QIjJrNz5/9Vm5igbRy1Z
	 Hp9f4ilsveKnQ==
Date: Thu, 15 Jan 2026 11:16:31 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: Document smp-memram subnode for
 aspeed,ast2x00-scu
Message-ID: <176849739064.906870.7559981756194987059.robh@kernel.org>
References: <20260109-dev-dt-warnings-mfd-v1-1-1aabe37e9a14@codeconstruct.com.au>
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
In-Reply-To: <20260109-dev-dt-warnings-mfd-v1-1-1aabe37e9a14@codeconstruct.com.au>


On Fri, 09 Jan 2026 17:05:18 +1030, Andrew Jeffery wrote:
> The platform initialisation code for the AST2600 implements the custom
> SMP bringup protocol, and searches for the relevant compatible. As a
> consequence, define the requisite node and the compatible string, which
> in-turn tidies up the dtb check results.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> Hello,
> 
> This change was original part of an RFC series tidying up the AST2600
> EVB devicetree at [1]. Many of those ended up being merged directly, so
> I'm splitting out what remains into separate, smaller series.
> 
> Please review.
> 
> Changes since RFC:
> - Address the warning from Rob's bot
> - Tidy a description line that was dropped unnecessarily
> - Remove RFC label
> 
> Link: https://lore.kernel.org/all/20251211-dev-dt-warnings-all-v1-16-21b18b9ada77@codeconstruct.com.au/ [1]
> ---
>  .../devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


