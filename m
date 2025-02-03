Return-Path: <linux-aspeed+bounces-626-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E2DC02198
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Feb 2025 00:41:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yn4L80NVrz2xQ8;
	Tue,  4 Feb 2025 11:41:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.252.22.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738589911;
	cv=none; b=Tyduyyjc63ojJRSKmuYvSQtjUmk+2p4aRBXGBTuRLbGJhKifW06xYCEP9nuPHTfER6Obh35vcAO0HLTY3mR0MsSot4K1Ml3E7KQUCqXIqGFyPGC38K9kHysi5NBH/1ULdI7xfdmyxyUZz+ylAaPIXELJiTVWE36g3V/7LWj9hvKB9JCc8549Nqt3y5166V5jILt1qSNDl6+U7Q71tAgEzMFq9Bv1EMVwVyTzz1rDvkAD8qUlP6sAqWxdpoPgZpbS7VzscWtcX1bBJYbGPpE4XVKi3AReW6u5EauvF7jjQ28l5CwPE0ic1JVI9ZGYBS+AnMIvyA0HaBZXZTa52+A9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738589911; c=relaxed/relaxed;
	bh=/g4W8zsNjOkB4DJtFhM/WsfKs6gE5EsQ2w79HWI72oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDXePcX7fBBZ5mS4KHib0zxffyo1bE/bHrIyeb0KLj27hKbiCxkGvhHl0YvM0RsQcVF946bXYCTIOzA3B9bFxu3xU3IPWlF4hR6b6TyH1onf13+sTSTc7CSBRgbnZmMTQrIfZbi6WZAtcFnbXlM76MN6ndtGOoZDS4iknqzumn1fwC24LQnG+g64kQFuHoSV6GHGTsoIdD30pXA5Pf3lN/JGzzAMNPGcCGSQ5C+JtzeFsHAk3gOe48o48tm35wovjnDe45vR+X7RTFJYg8jm2WbUdMHb55oT/kB51wj+UmLVltvGlTuPc7iMx4qi5GJyR2FaqWQN5EYx7VCwE2AazQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=XwYwJD9q; dkim-atps=neutral; spf=pass (client-ip=193.252.22.70; helo=out.smtpout.orange.fr; envelope-from=mailhol.vincent@wanadoo.fr; receiver=lists.ozlabs.org) smtp.mailfrom=wanadoo.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=XwYwJD9q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wanadoo.fr (client-ip=193.252.22.70; helo=out.smtpout.orange.fr; envelope-from=mailhol.vincent@wanadoo.fr; receiver=lists.ozlabs.org)
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YmndK0yZZz2xsW
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Feb 2025 00:38:27 +1100 (AEDT)
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id ewd2tOy0dEoZKewdIt5Ip4; Mon, 03 Feb 2025 14:37:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1738589839;
	bh=/g4W8zsNjOkB4DJtFhM/WsfKs6gE5EsQ2w79HWI72oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XwYwJD9qo2zk974igNaK7YRqOSOeQpGfDoLCz5WdqzVZVaQCeXRz5fRwVtek4nccr
	 IIPachRHSkoVTOEAWF+Q1RzHqSOorzh7zXI195lPeh6rI9NWNNeXuWFRvNezWJTw3p
	 PujsqHiaXsnhXn4ml0tu+soSLAwHQx/2ykUaxgbrj/FrCgmqj2lH181uuMut8tBYuy
	 aja0FJrJQgnw/6NiWOYkVZxNTWgTqVbG3qy26HXJ2+cOUzaAglixyIojvdf5gfQ1kK
	 saeXLw4BQa+dsq1UxBUW8SPV6tQMuEPXP5HvV9PLKQ6hwtsv5+NhzubCQc+XQUYX3M
	 ZF/4/IEW0rvcw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 03 Feb 2025 14:37:19 +0100
X-ME-IP: 124.33.176.97
Message-ID: <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
Date: Mon, 3 Feb 2025 22:36:43 +0900
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
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
To: Johannes Berg <johannes@sipsolutions.net>,
 Yury Norov <yury.norov@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>
References: <cover.1738329458.git.geert+renesas@glider.be>
 <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr> <Z5-xMUqrDuaE8Eo_@thinkpad>
 <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/02/2025 at 16:44, Johannes Berg wrote:
> On Sun, 2025-02-02 at 12:53 -0500, Yury Norov wrote:
>>
>>> Instead of creating another variant for
>>> non-constant bitfields, wouldn't it be better to make the existing macro
>>> accept both?
>>
>> Yes, it would definitely be better IMO.
> 
> On the flip side, there have been discussions in the past (though I
> think not all, if any, on the list(s)) about the argument order. Since
> the value is typically not a constant, requiring the mask to be a
> constant has ensured that the argument order isn't as easily mixed up as
> otherwise.

If this is a concern, then it can be checked with:

  BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask) &&
                   __builtin_constant_p(_val),
                   _pfx "mask is not constant");

It means that we forbid FIELD_PREP(non_const_mask, const_val) but allow
any other combination.

> With a non-constant mask there can also be no validation that the mask
> is contiguous etc.
> 
> Now that doesn't imply a strong objection - personally I've come to
> prefer the lower-case typed versions anyway - but something to keep in
> mind when doing this.
> 
> However, the suggested change to BUILD_BUG_ON_NOT_POWER_OF_2 almost
> certainly shouldn't be done for the same reason - not compiling for non-
> constant values is [IMHO] part of the API contract for that macro. This
> can be important for the same reasons.

Your point is fair enough. But I do not see this as a killer argument.
We can instead just add below helper:

  BUILD_BUG_ON_STATICALLY_NOT_POWER_OF_2()

But, for the same reason why I would rather not have both the
FIELD_{PREP,GET}() and the field_{prep,get}(), I would also rather not
have a BUILD_BUG_ON_NOT_POWER_OF_2() and a
BUILD_BUG_ON_STATICALLY_NOT_POWER_OF_2().

If your concern is the wording of the contract, the description can just
be updated.


Yours sincerely,
Vincent Mailhol


