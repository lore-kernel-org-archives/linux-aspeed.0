Return-Path: <linux-aspeed+bounces-776-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA6CC021AB
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Feb 2025 03:51:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YyMrk05yfz2yvn;
	Wed, 19 Feb 2025 14:51:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739937093;
	cv=none; b=CT6wEEsx66PL9PG9txazq+SoqolFh8I3PYwfC7sqgGjH4mkafzIePKUdq0eUCXMb2EgevczfSDWKwcpmKtKrvPxVHYlsqkRh+2er5vw+jc5oROhxg0Edrw/wSW2zN4vix+L7O//NuuQI8/s13L/4hqqV2t13pKobrJeXqGKVqWvS8skV8haGK+H8E+YZJ6Ua4KZ8jcyu2KVyXZN95Db47E+gpzUQR9hxw2fU7R2WLEA2TUuKq7gx/HJsu0NFOIl4NPKXylREgoPGn9Oh/VW28WzRLfchfyXuD2jARYfnjihEO29H9mWYJYS/efSF1puFk4vYRR5GqpVugxYehYxvlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739937093; c=relaxed/relaxed;
	bh=gLDIcoH8g0PVChUT3kwRLObvHSuon6W2GBImNuIMuVc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kwJoB8sbSqBmevReMwQxAlGOGvQX4EW9aiyDUTM3CxI1n0arMk1hyHz+qs+RRpF/vT5gbI03e5BSnF65l9i8Hb4tT784IbaCc0zavKAz9BTZWIu+N+F/qqhn6sicN6R3uQwujjBaPgv+CjAw+V6C8NrfBq8qYpM88BoITarQmmPDEy+MVuXdo6L/BUouV3cqU9F+9w44DUcP7tBwCwUzRd4xYgnHIGuuHwB9o8OOmrpPF2Y+PUb57WKhmQcpNbYmukygU7269FVZvIJLsV7/uOCzAfAxUJ1GMTlBp+w8j7OEst38grs7pxX6pvNY/A2NxWdwhfjuBxuxELlUDAS6Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GqcsPhBS; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=guoheyi@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GqcsPhBS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=guoheyi@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YyMrh2M30z2yMh
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 14:51:31 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739937087; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=gLDIcoH8g0PVChUT3kwRLObvHSuon6W2GBImNuIMuVc=;
	b=GqcsPhBSSDhJQdN37tB2BekOnyEW56Vwp5EuPim620fSWkro7twyyN8T0T3ImUhf2zHJtUQD/xhUezvt+tNhNwd7Dw2OQJM6jB11EFMHZ4Qdvqj1IZYdJF3/P0+RSjN1xQ+h+POY23iUyOfFhBuIgA1V9pNceTdXzgjGr4aT1XM=
Received: from 30.221.144.226(mailfrom:guoheyi@linux.alibaba.com fp:SMTPD_---0WPnn0O9_1739937085 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 11:51:26 +0800
Message-ID: <5de1e473-9d90-458b-b739-9e912c71febd@linux.alibaba.com>
Date: Wed, 19 Feb 2025 11:51:24 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] driver/aspeed-wdt: fix pretimeout for counting down
 logic
From: Heyi Guo <guoheyi@linux.alibaba.com>
To: Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Eddie James <eajames@linux.ibm.com>
References: <20250218031709.103823-1-guoheyi@linux.alibaba.com>
 <50ab5a0a-b807-4bd7-bda8-7c6f4bfc76fc@roeck-us.net>
 <7e2c5f2c-d07a-472c-aae5-6b639a144d88@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <7e2c5f2c-d07a-472c-aae5-6b639a144d88@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Really sorry for this mail and previous noisy mails; my thunderbird 
client must be misconfigured to send out mail for command + s shortcut 
when I wanted to save draft...

Heyi

On 2025/2/19 11:40, Heyi Guo wrote:
> Hi Guenter,
>
> Thanks for your comments.
>
> On 2025/2/18 13:33, Guenter Roeck wrote:
> > On 2/17/25 19:16, Heyi Guo wrote:
> >> Aspeed watchdog uses counting down logic, so the value set to register
> >> should be the value of subtracting pretimeout from total timeout.
> >>
> >> Fixes: 9ec0b7e06835 ("watchdog: aspeed: Enable pre-timeout interrupt")
> >>
> >> Signed-off-by: Heyi Guo <guoheyi@linux.alibaba.com>
> >>
> >> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> >> Cc: Guenter Roeck <linux@roeck-us.net>
> >> Cc: Joel Stanley <joel@jms.id.au>
> >> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> >> Cc: Eddie James <eajames@linux.ibm.com>
> >> ---
> >>   drivers/watchdog/aspeed_wdt.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> >> index b4773a6aaf8c..520d8aba12a5 100644
> >> --- a/drivers/watchdog/aspeed_wdt.c
> >> +++ b/drivers/watchdog/aspeed_wdt.c
> >> @@ -187,6 +187,13 @@ static int aspeed_wdt_set_pretimeout(struct 
> >> watchdog_device *wdd,
> >>       u32 actual = pretimeout * WDT_RATE_1MHZ;
> >>       u32 s = wdt->cfg->irq_shift;
> >>       u32 m = wdt->cfg->irq_mask;
> >> +    u32 reload = readl(wdt->base + WDT_RELOAD_VALUE);
> >> +
> >
> > It is unusual to use a register value here and not the configured timeout
> > value. I would have assumed that pretimeout is compared against wdt->timout,
> > not against the register value, and that the multiplication with WDT_RATE_1MHZ
> > is done after validation. This needs an explanation.
> It was supposed to be a straight-forward way to check if the pretimeout value is
> supported by the hardware. I can change to wdt->timeout if it is better.
>
> Further, in the case of wdt->timeout > max_hw_heartbeat_ms, shall we restrict
> the pretimeout to be larger than wdt->timeout - max_hw_heartbeat_ms  / 2? For
> the watchdog_kworker works in max_hw_heartbeat_ms  / 2 interval, pretimeout
> event may be triggered unexpected when watchdog is not pinged in
> (max_hw_heartbeat_ms - (timeout - pretimeout)).
>
> >
> >> +    if (actual >= reload)
> >> +        return -EINVAL;
> >> +
> >
> > On top of that, you'll also need to explain why watchdog_pretimeout_invalid()
> > and with it the validation in watchdog_set_pretimeout() does not work for this
> > watchdog and why this extra validation is necessary.
> watchdog_pretimeout_invalid() will return false if wdt->timeout == 0, but we
> can't determine the hardware pretimeout value if timeout == 0 here.
> >
> > Guenter
> >
> >> +    /* watchdog timer is counting down */
> >> +    actual = reload - actual;
> >>         wdd->pretimeout = pretimeout;
> >>       wdt->ctrl &= ~m;

