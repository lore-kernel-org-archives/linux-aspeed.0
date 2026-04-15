Return-Path: <linux-aspeed+bounces-3908-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDE5F433CE
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Apr 2026 22:11:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwwMX3XZNz2xlK;
	Thu, 16 Apr 2026 08:11:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776291064;
	cv=none; b=ekJx3HL0n7YJU+cDWvhQomLb0JJy/sW+pZgFnOzTZCt07jxo5BesqhSbMoE9QMwsBfvyHgmjOs+wSEnvO7w6wiDZBRrHo381pV2Mkx4CdU7wwEJx4o1cj8euh5gNNORkSGew0VifyeawAkQP6oCZaEpGKQHVNGHdwEfd25bcvjrv4RFORVFPTaWN2tsj/mPpnQhKNSXuJnFYXddBlrriKp2GYY8eVsMIsPslACa4mYOIGwjLG2DrG6kJY5IQhdz4XOrufE6MIre5IbtJX/MRVkZ3oiHmqp4xN49sIcZI/vrLDj0UXfbEM9JNYWvdal+3k8PwVzYxR8I/ylSYdo4+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776291064; c=relaxed/relaxed;
	bh=BZdrZIkOSqbzGAWUiUFdmBRnxHfqO64E/VC6vDSmexI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om/5mtS4rIFmObUXdfqo0rNw4tNf4cBiTo46XjQW1WfJTJC4AmavCrfW+OVIlpfDveor8UgPryqeNTGUFGkuPz9T9GTITe+Ik8BDk8xp+aqf12I9hwRCh9jlXDX1OKu6v7Dv5Uql44tWKqgDOVfiGm4lAcUpMdGuDTydI5G6eQyjnx0bi+Ju3brOq3mBfzOI7LPkuN3GUGYbsvzS56JxXMRTybNVqtmLOs9KZSUFsvUWd4NgqxRzh1pZFjwqNm1tfHILB5LlfXw41YFF/44XBRVAT8mNwZuAkfmolP5s/CfSkMmlOKKJak11Bov0I5n7Nw2hjsIVltg9teUrYgIbfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p0G82jNv; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p0G82jNv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwwMW2NPvz2xc8
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Apr 2026 08:11:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 33D90415F6;
	Wed, 15 Apr 2026 22:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9759C2BCB3;
	Wed, 15 Apr 2026 22:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776291061;
	bh=4MjkOgWu+H/4IbKFLTcEqaA80AYv/7LFnNzAZ1Q9/eY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0G82jNvv+WdUrzCg0FXEUgFE67KoF8lsRoHLR1Eixg/LXzBOmBt72ny96ygZ1Yh7
	 5pjtAjRmscQPZ3vzTHEJVK2X3F5iY9VBGqR24yPawyJQ/gAIlyZBVqDlxU6RxtLQOu
	 GIOuEzZ4IIVyp1JVp1Bd0caHsANeP3Y9FjSY0dKokZFCp73u2B9/2SZh9VaeNP9dKw
	 bDqy1aSrrHxSChU/DDEkPqQ/9mXmyBZFULTx7CeyP1LoiLkGahr6y7zWTmj5JAf+iF
	 LSKM2823g0Z3h0jTPv9V+xvD6mu4GBgiebxCOKq/m8zV5ubcEy7dHDB71HDaXfInaG
	 zk3lxaVX52GYQ==
Date: Wed, 15 Apr 2026 17:10:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: astewart@tektelic.com, linux-arm-kernel@lists.infradead.org,
	Mark Brown <broonie@kernel.org>, bhelgaas@google.com,
	maz@kernel.org, linux@armlinux.org.uk, kees@kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Saravana Kannan <saravanak@kernel.org>, netdev@vger.kernel.org,
	linux-serial@vger.kernel.org, davem@davemloft.net, andrew@lunn.ch,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, brgl@kernel.org,
	jirislaby@kernel.org, mani@kernel.org,
	Johan Hovold <johan@kernel.org>, linux-aspeed@lists.ozlabs.org,
	linux-pci@vger.kernel.org, kuba@kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	andriy.shevchenko@linux.intel.com,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alexey Kardashevskiy <aik@ozlabs.ru>, lgirdwood@gmail.com,
	andrew@codeconstruct.com.au, hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
	Eric Dumazet <edumazet@google.com>, linux-usb@vger.kernel.org,
	alexander.stein@ew.tq-group.com,
	Robin Murphy <robin.murphy@arm.com>, pabeni@redhat.com,
	devicetree@vger.kernel.org, driver-core@lists.linux.dev,
	joel@jms.id.au, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 8/9] driver core: Replace dev->of_node_reused with
 dev_of_node_reused()
Message-ID: <177629105858.764226.5689083905556313606.robh@kernel.org>
References: <20260406232444.3117516-1-dianders@chromium.org>
 <20260406162231.v5.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
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
In-Reply-To: <20260406162231.v5.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>


On Mon, 06 Apr 2026 16:23:01 -0700, Douglas Anderson wrote:
> In C, bitfields are not necessarily safe to modify from multiple
> threads without locking. Switch "of_node_reused" over to the "flags"
> field so modifications are safe.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Not fixing any known bugs; problem is theoretical and found by code
> inspection. Change is done somewhat manually and only lightly tested
> (mostly compile-time tested).
> 
> (no changes since v4)
> 
> Changes in v4:
> - Use accessor functions for flags
> 
> Changes in v3:
> - New
> 
>  drivers/base/core.c                      | 2 +-
>  drivers/base/pinctrl.c                   | 2 +-
>  drivers/base/platform.c                  | 2 +-
>  drivers/net/pcs/pcs-xpcs-plat.c          | 2 +-
>  drivers/of/device.c                      | 6 +++---
>  drivers/pci/of.c                         | 2 +-
>  drivers/pci/pwrctrl/core.c               | 2 +-
>  drivers/regulator/bq257xx-regulator.c    | 2 +-
>  drivers/regulator/rk808-regulator.c      | 2 +-
>  drivers/tty/serial/serial_base_bus.c     | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c | 2 +-
>  include/linux/device.h                   | 7 ++++---
>  12 files changed, 17 insertions(+), 16 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


