Return-Path: <linux-aspeed+bounces-4821-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D245C5DF89
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 14:15:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRMlD2zYdz2xnW;
	Sat, 22 Aug 2026 00:15:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=66.235.175.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787321704;
	cv=none; b=KPai1JxTG1WVFP39fyO+rWmtrKzdUN4sekZc4MvpigzBTWwT5Fr+7kGUdwGMc8PyOk2pC8xYgCWtjt2X/2nJFh9ERHGvNVpyM+tf6ZajPkv7FmpRxTVkPEFSDzRetd2tcz4cQlHWl3b8WzOsxSDcBwAKJ5IVXSSwabehpfIIstis/37MUHcLvSB+5xrtfZ/w4wRAF9PuFDoUdjOmynWEZilXWXs+mF6LoZIqBf6zRpo5SEYTvRx6nnQk5hih5DM9BzByLKCRSr8JRK3MYV7B2l6tPvNN0V5fM51DZfBKOqJxiIbrCwf8AFudD1ghvQg2ZwWqiln8NY7PoFXbsloU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787321704; c=relaxed/relaxed;
	bh=K/rYJ4fZhSilGNwmY064VfngAr4dpwpsHUyeKwyptvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mowJddi4ZAP7ZmpKJix59JTLDNdfwSIy5kc3NdJMOWXa3kN+Hn48+1B8K64/DyCS1NCOdaY78yvTpxThVulAKR1RNaFSh024lZNcmgUqFJ4LeEFiYD1D6bkKeFOmhsgrJ2nwJvdU4DA1NMC4/bQNqgLYYmmtHeOtbJ6TyyCyH4K2aFDcOxMW3t4SO5Ip3tY1GQZXWjekRNnMc+HpEJI+27/Qx5W2gS2QVUc6XRS3YmY7E6ZI9UkLs3T2Jg6F1H+UAb/xjiIyApLvj2HsuWFiCqTgFhEGBrMMsAGeCZtev63ZOjJ1iNlLqfQLuvnYf1kF5Bt2u3pqOORShUg5mMxMfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lechnology.com; dkim=pass (2048-bit key; unprotected) header.d=lechnology.com header.i=@lechnology.com header.a=rsa-sha256 header.s=default header.b=sr6TMcnT; dkim-atps=neutral; spf=pass (client-ip=66.235.175.158; helo=galaxy.gendns.com; envelope-from=david@lechnology.com; receiver=lists.ozlabs.org) smtp.mailfrom=lechnology.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lechnology.com header.i=@lechnology.com header.a=rsa-sha256 header.s=default header.b=sr6TMcnT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lechnology.com (client-ip=66.235.175.158; helo=galaxy.gendns.com; envelope-from=david@lechnology.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1786 seconds by postgrey-1.37 at boromir; Sat, 22 Aug 2026 00:15:01 AEST
Received: from galaxy.gendns.com (galaxy.gendns.com [66.235.175.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRMl94XWfz2xWt;
	Sat, 22 Aug 2026 00:15:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K/rYJ4fZhSilGNwmY064VfngAr4dpwpsHUyeKwyptvc=; b=sr6TMcnTl9qCh5RSZeO4vRlT+X
	26RoI97MTXcN3SRY64DN/xA0Nwk7zu0JS2bjkEEBU/cQ2GPOUxh2ekSdZ0RPQOtgpdJYt8rVCQhKS
	SSgN0Kmfqluqi4UksUSVNSKmV7TvNXM3pAQAI8mFQh0lZtOer/oG2tuWInECxCFn7pPbCIFuGwDCX
	WLRCP6iR1pWx5I0ckApDokkrsqs5/s2Kz8FPVOkhR9cy0ROjkwFjMlw7Gcy9I5IIm38VZmIo5KV3k
	tVUHnkY+AdMXJLCRlYFetWU5YLuUayVw3L4gcoPPbYvXMYFfRfIjB4xpWO+8s6cNyWLnjZQdN8Oqm
	CAuI31wA==;
Received: from ip98-183-112-25.ok.ok.cox.net ([98.183.112.25]:62589 helo=[192.168.1.169])
	by galaxy.gendns.com with essmtpa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <david@lechnology.com>)
	id 1wxPYU-00000001l1l-0zsN;
	Fri, 21 Aug 2026 09:45:08 -0400
Message-ID: <1f791d6c-48c4-4266-87d0-c70438ec793d@lechnology.com>
Date: Fri, 21 Aug 2026 08:45:04 -0500
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/45] clk: davinci: Make sure clk_init_data is fully
 initialized
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, arm-scmi@vger.kernel.org, imx@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 soc@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <cover.1787239813.git.geert+renesas@glider.be>
 <f3b503ff3fda049988c3e16071bbbfabf1b04629.1787239813.git.geert+renesas@glider.be>
From: David Lechner <david@lechnology.com>
Content-Language: en-US
In-Reply-To: <f3b503ff3fda049988c3e16071bbbfabf1b04629.1787239813.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.gendns.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: galaxy.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: galaxy.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 



On 8/21/26 3:53 AM, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

(had to trim the recipients to get my mail server to let me send the message)

Reviewed-by: David Lechner <david@lechnology.com>

