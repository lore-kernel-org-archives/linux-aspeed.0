Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA98606A321
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Nov 2026 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9KB8bNW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZz3m5k41z2y2h;
	Fri, 27 Nov 2026 01:11:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795702260;
	cv=none; b=iRrQnqwYzLrB0145BjQMy65AvMjRNg0ckLS7cWJLzB7ceDkl9lqeCdB//8YzJvP/Ask+6GgblvDrAHLYnknTywkzKZwVKBnaMsFVQ8DBYK4wHE8YGnUihZE5qu/Z/MW5VaJqXRChw3u89TwJHyYHM0Dg3xf0DJyepjiz6lO9xwbTTAPf8Qw1PmeKDUmophwlRnU+NPhigQEzVAt9Vk11AzlvSphpCPyu2UVcHNZM2DtB4TwK8puEX9NTo9NL7YwgW5N9nKw8bkWSrDkFclkETSpaUEREqt4FRNwzEUmWE05BHU9SXTsmBWq15ZA9U0KNQbQ9sjjF+5T6xfT9S9e+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795702260; c=relaxed/relaxed;
	bh=mmhdqFI00N1WBlVnl/3cbJ793dbxFER3bru1NLYoAdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWgruJKeins/zjslffU493plKEt03h2EJc9mTsb22K/tELusmTjOzcCud7cSEL9L/CpFjvJ6bhXIQqWGQ78XKuZAPqu1621IS9LFjf5X9r6RhOuNXq0Jbg5lAurSXWXKnOJURMB2NP2cwa72HRaY2YXiVdsbtr8ct56KahVmfpP62EiHyNewJaLYxVHgcvOEMI/CzJBMK3ZHjrJzvwT1D7wcs8QtRrngSlvFKwoE+hrHLO83C7DjoOR2BPW9fNdFDCaJyO3ix0SitwOSId2tR6rbzFd/tu6iY7XBG1XjGtRgR2fVI1Ki8EKxoG52Qvl3LOU/rnlzqIhg4Wk6nxjs0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9KB8bNW; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9KB8bNW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jZz3m14Myz2xMt
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Nov 2026 01:11:00 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id C282D43450;
	Thu, 26 Nov 2026 14:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B813A1F000EE;
	Thu, 26 Nov 2026 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702257;
	bh=mmhdqFI00N1WBlVnl/3cbJ793dbxFER3bru1NLYoAdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U9KB8bNWd9736dk/QI6XKLJjRYslrkd8KUeSXKqHqSbtayZiQGSalZq70LYAEGGwD
	 xSrpz3rzgTpnCGUcVA3+yiVkaourMgSk/mSYNUaaO/BVf+HypFVwooM02RvQm59eQQ
	 q7hg+bTb9YxPzMGZWFlINbuYMwFNG3edahazUhwKTY6Mnx3II9kfjbnh0zAwCr0LOf
	 oebPmei6y/82sNcAt/XiWg/KVWZeAaGfUtad1YqAff8ZK6GnbPWStx/1P9ZX8zfPro
	 0GGXzEsx05hK/p6f5Ht7NomI0PEZvM1jFrXmSYlOsQfccWN+BmFaNgW6ezvDEE5x6v
	 BU1l5fmAtNDHA==
Date: Thu, 26 Nov 2026 15:10:53 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] gpio: aspeed: Fix potential coprocessor bank map leak
Message-ID: <st3vyhktf65rk3jzhxdefjnhsl6xxqhsu6dvi7pbudppfgt3jg@qon74p7q44vw>
References: <20261124135833.2275409-1-liguangshuo@mail.sdu.edu.cn>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124135833.2275409-1-liguangshuo@mail.sdu.edu.cn>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 09:58:32PM +0800, Guangshuo Li wrote:
> The coprocessor bank map is allocated lazily but is never freed when
> the GPIO controller is removed. Its only owner is the device-managed
> GPIO private data.
> 
> Allocate the map with the controller's managed resources before
> registering the GPIO chip, so chip removal finishes before the map
> is freed. Round up the bank count to cover a partial last bank.
> 
> This issue was found by our static analysis tool under development.
> 
> Fixes: a7ca13826e47 ("gpio: aspeed: Add interfaces for co-processor to grab GPIOs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> ---
> Changes in v2:
>   - Use a managed array allocation instead of a cleanup action.
>   - Allocate before GPIO-chip registration so teardown callbacks finish
>     before the bank map is freed.
>   - Round up the array size to cover a partial last bank.

Please also include a lore link to the previous versions in the
changelog.

Bart

