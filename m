Return-Path: <linux-aspeed+bounces-5161-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2847ECA6015
	for <linux-aspeed@archiver.kernel.org>; Fri,  9 Oct 2026 06:10:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1Gg83pJxz30VT;
	Fri, 09 Oct 2026 17:10:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791526212;
	cv=none; b=N9mAmP9RORAv5egcHArM4HihZJi/YXVtrclIXtX7zztJoQ8/LXdLF02wvxHui/Nqhl7Qkw8qxfvKLcr/8RCjywvQO9QNx86LXjDHvUBL5O9iu+K4r4N2NNkhSg59cj3kx+bYJfQ/hebgPaSIXSJmkx9uT5ua7bwz0OHCOTrkBQf5H1NJvNyul5JklnCTyEpUl1htTVZ9ZhgziHFUOmdyhX4HQsI6v9K8S1r8ssF2TbvDG/836FEJbPvdrkuJ1tKoPNA1Ph7uEpTlLBypA7i4H676zZevxpy9QyXE4Rj8P0gxt47mLuZ3cgPhaPxl8AEXIP9ztcjf6XX4MvUguE06rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791526212; c=relaxed/relaxed;
	bh=cpB4oW+VzOYkr7heF4ZAZX4wxYt/dyntVxClV6LD6MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VglvhU7AA+8SRNaiIezPUgJSHKC7DRAdSdjI6jhd09z1y6rWr6LTd5nFrxGrQNNkvLwO2VxUimG+lNAKU8cFL7eOOneb3yLDwNYrLHL36oWzvWqQGsKrY687jLyMQ4JyW4/g+r49itiUgEwrAC117snit/iUSizXqynHazMII3DfM4wwkGP4R75s2WvZLi+X6zX5mQutiRCmZnkL3Ljr+Q1cbZ8zGIJTQviCmahxF1hEqQnVGj4dXkuCWzum0PHgoJTZGOZrbqWZ7YKyR+olxhEldf3vIsI/11f/bzke/z1wnHyIXd/6R7JXF50KWBsokam+qwC9yqF36F+TcLe6KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1+U/T1D; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1+U/T1D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1Gg75qfXz30DZ;
	Fri, 09 Oct 2026 17:10:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8018860DBA;
	Fri,  9 Oct 2026 06:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA501F000FF;
	Fri,  9 Oct 2026 06:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791526208;
	bh=cpB4oW+VzOYkr7heF4ZAZX4wxYt/dyntVxClV6LD6MA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D1+U/T1DTXrKOdz8Lv6py/jO8w8IHJBD8IPmHKS0E1Y8KxayrpNP93hBJoSFgfSPV
	 /hFFwtE9RsEYzqPbhs7yhLo8/6lkM9Bjp5autcvT5leBDIChFixFTFlbSGDXnWpkxx
	 /pTSOAXNetSTkdVNPSCMinflG3TKFFJelcPyPyp4Hpm+GZGBogw9k0JTSNhHdFHwQ/
	 JjQxCB0VsSVQq0J8BqxdMSsL/2LaAVfOY6POPlb+YWaldn7Cspw6fs6qIufLRsKsul
	 Y5mb/3mUFgH6wo1ZSBQ8bJAbyVTqxVDIWixETHkd6GJqsb/SBGKHlbdlkxQtRy1+h4
	 IWjOkCneuMW2g==
Date: Fri, 9 Oct 2026 08:10:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, linux-aspeed@lists.ozlabs.org, 
	Linus Walleij <linusw@kernel.org>, openbmc@lists.ozlabs.org, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>, 
	linux-gpio@vger.kernel.org, Ryan Chen <ryan_chen@aspeedtech.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] pinctrl: aspeed-g5: fix device node leak on LPC
 compatible mismatch
Message-ID: <20261009-practical-malachite-scorpion-0be0c5@quoll>
References: <20261009041435.3096107-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261009041435.3096107-1-vulab@iscas.ac.cn>


On Fri, 09 Oct 2026 12:14:35 +0800, Haotian Zhang wrote:
> aspeed_g5_acquire_regmap() takes a reference to the LPC device node with
> of_parse_phandle() and then returns -ENODEV if the node's parent is not
> compatible with "aspeed,ast2500-lpc-v2", without dropping that
> reference. The function is called for every pin configuration, so the
> leaked device_node reference accumulates on such systems.
> 
> Release the node with of_node_put() before returning from the error path.
> 
> Fixes: eaffd32bea0c ("pinctrl: aspeed-g5: Adapt to new LPC device tree layout")
> Assisted-by: DeepSeek-V4.1-Flash
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback.

2. You use multiple identities with this email, thus I actually doubt we speak
   with actual person.

3. Finally, same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document usage of LLM and how what you should not do
if this was posted in a good faith.

Best regards,
Krzysztof





