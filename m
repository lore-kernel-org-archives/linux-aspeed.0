Return-Path: <linux-aspeed+bounces-3829-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26107D35171
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Apr 2026 11:33:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm2tc68pLz2ygY;
	Wed, 01 Apr 2026 22:33:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775043224;
	cv=none; b=Jax08vUmdLMNaWEsUGpu/dEJGSDN8MZdRyVFfuI7f0pMmyLZnsHcPNrc/pdofmwHF/JWJgpfoQiYYChzGSAHxX9qo8vAxQ9KEyy+metzwAiNdf7W0H5MyvcQLhD+82GKK17rNU0uJoCmHEwSHUJqL5OVYZt7a7GSELpGeSoj9L9BRry5eVg6lpEucJUrR/y2P3uOJYqIVQ690nl5yGupmzIjhc+JdbL0/Z+tbk1h8T5BT53VfAjD44V2Y6u4SRe8jtrlxmAWt5wV163g+w2ubYibiUpkISg5bfYKrGAIP6QmQeT0AetqPrkwLQfiEin1zoRP+RddreRq+LTkvN7Qqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775043224; c=relaxed/relaxed;
	bh=kVWopCz8SdbyHNeOF4Gzp1FvBN8cu7taYxU6mK0TEUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwC5Si9BuQ9WmR0W9oFBYZuBK9Yuy7pa9ZvUWBbARKB1456APnB2ZJnisR2/33uxeYzifpvk5VZJr7s0IpbS4OoYU4zvKkJA8pUuozBUc1g6x6lpaH8Tn3M1q+2TRR6rH/EvKUXz+jR0E+cx76N+e9EtB7p5j1nl/cn1AJtxYa8jdYiNDuBryHy5iRt3l7O/IhJNh8dFhwKSRnUW66xF8gdYDjzqWrkvqLxOmyOlOZur3Dzkh5b8eL4or3edUVLHq+x7oaSk87wwuyL6FX/1M+otqEISWxl8mME9Ve1A0PU4RdxKmJW1x+ofaTL92Pg1wy+krhwzLz24BYUYM0YIMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tylho3wr; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tylho3wr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm2tb6K7Yz2xgv
	for <linux-aspeed@lists.ozlabs.org>; Wed, 01 Apr 2026 22:33:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D4B6E403E5;
	Wed,  1 Apr 2026 11:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3249DC116C6;
	Wed,  1 Apr 2026 11:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775043220;
	bh=WP7aMfbv/ILGmqyI+0/9zkY2yavAid0gw/ITIKmxPF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tylho3wrCv6pG2LF2mwddsKlQBptnSsWn2JnykRidEfsQ8hwWvZ4SstQWLUXEPCqI
	 x17KikpghkeS34k9BGsUVSITbJ+BzO5VWcgHZ00Mijk5r1kdwgUoSkhUNjQYwvLrHI
	 9Wo23/uO/q12YyuEtlWoHXohdxeW+28Pzv6DggstihDf1s/lcqVTX02Ixtha6jdCJc
	 IxIv4Iq+QhYfIVHroiqz23yu0BJYZ/bqIbS7HNgVqZFgPqLdcPYUr0Tb4cE8Hgo3UW
	 l2pJFpI1Ex5m6oMm5ZfFPuy7au3mpfiYWwX9D9tNXFuG/IPwOcsPDvPr7dVLUSffjp
	 N85af9OpqAq8g==
Date: Wed, 1 Apr 2026 13:33:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: soc <soc@lists.linux.dev>, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [GIT PULL] aspeed: first batch of fixes for v7.0
Message-ID: <20260401-fanatic-benevolent-squid-8118bf@quoll>
References: <4afeb8eaa663835725cebaeb8c1b6f50dce184dd.camel@codeconstruct.com.au>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4afeb8eaa663835725cebaeb8c1b6f50dce184dd.camel@codeconstruct.com.au>

On Thu, Mar 26, 2026 at 01:25:03PM +1030, Andrew Jeffery wrote:
> Hello SoC maintainers,
> 
> I've been intending to send out this fix PR for a while now, but time
> has escaped me recently.
> 
> Andrew
> 
> The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:
> 
>   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed-7.0-fixes-0
> 
> for you to fetch changes up to 7ec1bd3d9be671d04325b9e06149b8813f6a4836:
> 
>   soc: aspeed: socinfo: Mask table entries for accurate SoC ID matching (2026-02-23 09:43:21 +1030)
> 
> ----------------------------------------------------------------
> aspeed: first batch of fixes for v7.0
> 

Thanks, applied

Best regards,
Krzysztof


