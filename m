Return-Path: <linux-aspeed+bounces-5151-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E05CA5FFF
	for <linux-aspeed@archiver.kernel.org>; Wed,  7 Oct 2026 20:32:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0Ptt42yFz30V4;
	Thu, 08 Oct 2026 07:32:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791405142;
	cv=none; b=I5cH+Thc7eWY+kxW+NIPiRjgpxWw6fwy0vPyYkVgFncCbYIjD6ulfqV5nIDsXTiB3Hdoqhp8WxPAk5NeJxrsIiaWlRxv2QU5Mlq+j4lqGEtkCAYhyFTZAcprKghshntD+mmDtLBlqdjOWnFqo3R93dBF3DzSR6xwpDQOUCXUv4Xh7H+xLnF251SoBLHGVUWpXVdCEuIb0tSzuFfhQDhV8p2M9+zrzDIZVpMm8bvPBLU9Gw2fJcdewWShhNjckSeF7+GedEXlwG+G/mtIHwFgiPQF6LQM2x3AHZvczmV9q1ASIX/3845HMKFa71Udh/LQNmrJK1uVBUCkOT8qhFXBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791405142; c=relaxed/relaxed;
	bh=33a7FuM1XA/yleJJfc/HZhNZxuDla2AYpsl5P+iHXX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSyajAK8BP0RbRTQo8MojZ7oUoPd2XN4yhM4XRi/f0IQNLBJPvGq24y2fO3khk6jt1zXqcUqpAVEAHsg/l5focaDYhwTIu79SQFrTBRDow/BgQXFt9U1TzqJ78neiaeBc/D2FNv4XdghPK8G6GBFLn4cmSdizqcFBIL/yb09tpuqbF8vUzSdkmjhO0OxyQwKj2g+Enf79y2XGc7NYHKqOoqiW9UOBvf2MRtYNwFquaE4yvsQNUlHkrC2LFtOQUP9ApIckTp2mPkRUpC2ml3/CJWI8G/JdAhcnqrusGOJqyF7b6P5ojNJzFaCA1GoFws365z4URRgUIUEhnkE58dpDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKNO7A2M; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKNO7A2M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0Pts5DrXz30Nl
	for <linux-aspeed@lists.ozlabs.org>; Thu, 08 Oct 2026 07:32:21 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 813E460A81;
	Wed,  7 Oct 2026 20:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DF41F000FF;
	Wed,  7 Oct 2026 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405138;
	bh=33a7FuM1XA/yleJJfc/HZhNZxuDla2AYpsl5P+iHXX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JKNO7A2MR765pe+grZ2PwDrYvBxrTJNTe5/eXVMrPtt9NBTr1PswA3JFdtZsj2D9+
	 AcrQ0Mo4Rb+lTAyg5vIZWYa1j0spxHRdQn2DWKOWiBbduBrWCc5nEOOX7JIPB65oRZ
	 DzZXq4MJT6nce19y0xnahJMvuXmqxgMCK6rxTH1Uds53hwHTC3Qr4LrBXNDCc/qjM+
	 KBz1q03dLWGKSC2c1y+YiQ5vZWLCob48IFz+61808vcMjA5QcdZp1AmqaYqHHDBsWm
	 QLRhGcOsB9iSoH8TxRkod83e4Q0g8ZSnSqGyaykAlICm4MNk3UoKoRm03AR/C5Q22N
	 dnbolY3aXt9Tw==
Date: Wed, 7 Oct 2026 15:32:17 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
	Joel Stanley <joel@jms.id.au>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Stefan Schaeckeler <sschaeck@cisco.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-edac@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 9/9] MAINTAINERS: Step down as Aspeed AST2500 EDAC
 driver maintainer
Message-ID: <179140513668.197997.15808651432801165459.robh@kernel.org>
References: <20261007-edac-v5-0-5c31fc5df4cf@aspeedtech.com>
 <20261007-edac-v5-9-5c31fc5df4cf@aspeedtech.com>
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
In-Reply-To: <20261007-edac-v5-9-5c31fc5df4cf@aspeedtech.com>


On Wed, 07 Oct 2026 14:13:26 +0800, Ryan Chen wrote:
> From: Stefan M Schaeckeler <sschaeck@cisco.com>
> 
> I am stepping down as a maintainer for drivers/edac/aspeed_edac.c and
> Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
> 
> Move my entry from the MAINTAINERS file to CREDITS to reflect my past
> contributions.
> 
> [ ryan: keep the EDAC-AST2500 entry and list myself as its reviewer
>   rather than removing it, and take over the binding's maintainers
>   field ]
> 
> Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Link: https://lore.kernel.org/r/20260920225846.4039017-1-sschaeck@cisco.com
> 
> ---
> Changes in v5:
> - Also hand over the maintainers field inside the binding, which
>   get_maintainer.pl reads directly for .yaml files.
> 
> Changes in v4:
> - Merge Stefan's step-down patch into this one, keeping the MAINTAINERS
>   entry alive with a reviewer instead of removing it.
> 
> Changes in v3:
> - New patch.
> ---
>  CREDITS                                                           | 8 ++++++++
>  .../devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml       | 2 +-
>  MAINTAINERS                                                       | 2 +-
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


