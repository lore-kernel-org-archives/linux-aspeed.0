Return-Path: <linux-aspeed+bounces-1140-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9E7C3600B
	for <linux-aspeed@archiver.kernel.org>; Mon, 31 Mar 2025 16:00:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZRG7j57gsz2yqT;
	Tue,  1 Apr 2025 03:00:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743436849;
	cv=none; b=AU7aM2KQOrkSvyLfZg5jzHeSxhOqmzrD4dJT7GOblj08Ho/ZxnRhe3+qwcNKl6K5TpVw9GnjtYjGI6yDB/ljNPDrS9fZ/jYTBg+7yiYbAJmkyMYao7RXlq9ZZIJq9/abzShkuQAdSDiueMPWvWoRYJS9Wg5W/bnc/lC+WEnNLiaCaVSp/TC9JMV9H/CFroS9YNav8l2JSNpLn8rB5BNKsxCrtkQ9T4csYICvsCu1/WaYtg4OQNYO2/fzI92ntjHnJPHJjOwxzTdU2kQfyFyIuX4ogtT8zOUMYp4AP1QoZRbv3qPgrSRiF2nKMo3gFjuJQxA9tc1SkjNyS1ArPNRMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743436849; c=relaxed/relaxed;
	bh=Kz+gGzeTBo0hUtiidDOMRNHIoPTNB4AIw1KRyjmjNsg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=F4Z4yaV2TGILQIu7644LvP6x187qCdjgeqj2ctQ6VeaLpLneJY4V4HmuFL6bEKm8EBMbzIZORIKLoWp2Uq0X/Kxyjc8wy+Ubq8zJUs1G6ayhM7Rbhsk37QZob0gea5zLYJ8MLsd5JmTb2Y/blZrkByr+lfY1HNleld73roX3CEQfjBJNzZP5dZSNWivjiGZHWbzohADIcIJlmAgc7f5PGcvJcgBmp7Em0DJmdUQs2FmjzfOKF9X026wAiB+NEpw+9SzPJGnlxPDpcAwQG2d73vdqcAox790M87RXzGXSUC0LQrZPoiyMwIVFYg4nONOs+sGDtCmMehFnuMbqnsSuBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=jO/g70FK; dkim-atps=neutral; spf=pass (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=jO/g70FK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 825 seconds by postgrey-1.37 at boromir; Tue, 01 Apr 2025 03:00:46 AEDT
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZRG7f3lfYz2xGF
	for <linux-aspeed@lists.ozlabs.org>; Tue,  1 Apr 2025 03:00:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743436840; x=1744041640; i=markus.elfring@web.de;
	bh=Kz+gGzeTBo0hUtiidDOMRNHIoPTNB4AIw1KRyjmjNsg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jO/g70FKD6QOIuMSrPg6zTnCnKJFQ9Am6iqEpzfbhk/AwD/ofCnF9bo+8EpBUlBd
	 KZHIzVSlUq6JMVkm4jGeQ5UFYha/XcYgXW5t22XTEpJ4kZQlTec21D2Xqspq7N+2z
	 F481eQz2Eq4azp9/+/NfLTHU5+aEOz0xzIsZcs00qLqpvR+Ws3xlLIjjmjLRZYi86
	 7AykYsGdDx+XqJb3y6U1IIqw60VcO1qg0wBMXJb7ie8kj0lT61R823Y27bozQayNY
	 nnlCfpJXPjfV6rPoTJ9TKkWlkzW+sZv2NQRMKS6Wk/khnIvlLTbJZ8HjtHOHZ3kAf
	 j4GpwZmI/nFzkoSSnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.37]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6YN9-1u1jFf2SqX-008yog; Mon, 31
 Mar 2025 17:46:22 +0200
Message-ID: <81279dfd-0586-4f12-a3f7-1a4397646d43@web.de>
Date: Mon, 31 Mar 2025 17:46:19 +0200
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
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Arnd Bergmann <arnd@arndb.de>,
 Gabriel Somlo <gsomlo@gmail.com>, Herve Codina <herve.codina@bootlin.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20250331151238.13703-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v2] drivers/misc: Add NULL check in
 aspeed_lpc_enable_snoop
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250331151238.13703-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WfXRpbQOzLQioeHvBg7xpO/cP8XzGV5HOiQ5vEjZppXgQuQv+NL
 n0UTjaqgXwqIyaWmd6UDf7i0nkt57HOEZWSbM1gUxV4lpe9x8GWHfI8bRB5olWjUgs8DHUv
 +llfLsiCShjT6BGwiChGyy2s8fusZf+EhZUxHg+47IfKKnBAkjvCj8DSQ5hDR8d7mWK04jL
 pBG1DiPtekLq029E+oX/w==
UI-OutboundReport: notjunk:1;M01:P0:ssSfErmprO0=;G6O75M9UyXqBBHj3XGRiCkQYC1Y
 sEGG2dMz3n49DUsaF3Xom9mx2sVzmo5PYC39S5koxdjh5FJ8HWInC4wQXMeEVvl+qyEOguxe4
 BQh8fbh7IfnHL8gCcLoqaZwaqzTGRtuo75riGg/mqYZNkFJhJMh0y7VKswDWz07gQiAio+ZY7
 c+zJ3pN5nur58sRf/I/kW1ziJc1lQ9tuR4X+VgcHO9kUVK+2jbHYAOU7N0laHZC/1/w6pD2KV
 Uul79sY6bZAo/xE0y39AQNJCMfTWC2L58jMnEnS4qqBJt+d+fw2CBFk/gmvc2NP+3CpUrlBgZ
 /txNh2CYZEdzuyvj5y6bYMit1owB8etscmJynxH0urLZu35G55ZFUxob7QRb5c3paekitkyRg
 +VomaCI/wgGAfXg2SLZigx1e+IGJ97BACYgEpjxduLZk6edNgSCRqNR4unaPOSVYvr5KnJFaE
 I6nqcGpJqLlCcx53nS78V0tGF9nogJ0X7z3ZTirGuzf4o3dc5A09GSVfHtsNSopwaJBw25dyD
 tnO63pSFKzlbHkJp2C/xknCDoCMtwYxUCSJ15X6TExHpPp0j9SQuuMQr5zjD/TgeYXrf2/dav
 AB8NCt/vash8IwCpqrxVHbR/ylM/Ft4geG8vM1PEXzjjImRO+sogCxEqxEKjAVSTZT72vNkKx
 8zTHGBvYw4bvxIRK6SzyvNpIJP2wiYRQTuAW/a05URXLg0nTezuWwvqUf99WyV+xD+8k7cqZB
 CgW1pJhUCQmwieNR5DEbfhPJDJzUOJDXW6PGWfRuW/kos8JSoedDlM2Wbq19fsa1uSYseIkKt
 qGhM6CsKgdXHyPGc+GlZzdthgPQj1Z+TSW/Ae45tDTcq4kQ339nkzLPVpl+BqErlrv6O1nJj1
 j/x1Qgf0EQVndlQsyGhrHLJ9KK9h0VMhTRrf17t1zhtOJmc7aJz7kjcZpvaUnO196v4ATlck/
 ncSA2m0hOBsWgs1vlwldPfkkYr7c0i0Q/2E/rxGDJDBrEabsyk0pUQjNi2XR0ty9JlDSTwEY/
 M9X7dRny2kWHRGJ5DbYQ3PP5HQWHghUf3s/Ih6BJ19GpI9PS+TulM1FHZIQJDHQgY1WoSRUOh
 /5z6qwupj2wXF+sfUQ8ZllAiwp9+9phbHsrp5pqSXAFC4qRfB2cujMFf9wi+SDa0naC0bXI+a
 AFXxnBQgoq/Oq33pnTnBTy3q9612vhDfTPj66m+kuV4mHEX/qZ+iw7x8RL10Wim8jNh8YEV79
 ZXq9m6XQssnn5ONneUR533fNvusmbffD3o6dzgENhrYryeZAYKlz/I1eqftrplOaIPZpHbZao
 Fy0shbQnXg5yIVjEVHCM4hv1z29gXAXoYJF7+rP6pHramkeurcptRO7WfTL6fmEhP4rxPxf1v
 vQzEaQcwS7yEwbUw4MerIrPh8o/9TwM9hVPHzm2pIWvlK+9gKapIbD7IsKxqUfXU/LnXFwQQA
 C/GvXyMRZnC3uRI4ZJj1NexO/mxJGNmKxlDzgn0EYVsqB84Sk+1nBHirJ+8BxjAgmR5tZqw==

> devm_kasprintf() returns NULL if memory allocation fails. Currently,
=E2=80=A6
                 call?                               failed?


An other subsystem specification might be more desirable.
https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/lo=
g/drivers/soc/aspeed/aspeed-lpc-snoop.c?h=3Dnext-20250331


=E2=80=A6
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -200,6 +200,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc=
_snoop *lpc_snoop,
>  	lpc_snoop->chan[channel].miscdev.minor =3D MISC_DYNAMIC_MINOR;
>  	lpc_snoop->chan[channel].miscdev.name =3D
>  		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
> +	if (!lpc_snoop->chan[channel].miscdev.name)
> +		return -ENOMEM;
=E2=80=A6

Can a blank line be preferred after such a statement?


* May the array access be simplified another bit here?
* How do you think about to store a pointer to a corresponding data struct=
ure member
  in an additional local variable?


Regards,
Markus

