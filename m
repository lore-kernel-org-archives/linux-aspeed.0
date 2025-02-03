Return-Path: <linux-aspeed+bounces-607-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0F9C02195
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Feb 2025 08:28:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ymflx0wkCz2xsW;
	Mon,  3 Feb 2025 19:28:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:242:246e::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738571325;
	cv=none; b=bBEyuiiuqvOtuT0XvsC9o+GGdzAeTgomTFOt/g3pvEFimEpPHVlCk8vG8ImacEk/1ssd4oLU9akentRV9seLTlbmg6wdOgawPULZ1HoN3fiuSZMPYG2zML7Z8ljIk0P8UbAccD2NrY780HadNFrxzd8Z5ytl1YILyiAblQpoNh0vOGZWCeB9WF/F/+QkHZGvQe1lxfEwx3tgGykHUmQdI5dXiAC0hmM7jQl8vgIg9jxOcOm4TNCD8vx8k+x20T+1I6pHIpHV6cI2hdv7s9gXdTdnlTCXLEr12y4bT083uEbfb2jxOWh1eyja1YEj4PZptUtLNxXy1PibRpBw4Ie47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738571325; c=relaxed/relaxed;
	bh=x1beuisn9wdEKP1QdS1UhUe3+GT+LqGgI15rKS+Adds=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UUW9c5wDpDl1jy45RCqPhcC37QJ69trSx7CJ0sx/xLV1muNRNQWhvwns7CiR57eDDLBJBs0jWzO0tBcxyXpUYq7QjS+QdlCQcpsqTYttfjoix9BbsR2/dT+Tq/hYCBdxlJ3rSQVLApYsV9tSK+FWq5iHEnCnLfhTLbawyi+Zea62ZoQrQ9urTfX3lKAnWf7OmT/vdhIiYSXkNkFbQSJQGxOX9Zn3OlwCebryq4d4H/A3nWOE9GBMj5qtJw/UwNfk01ueAxwab1ybMEaP7HZUz3gnv0j1aUKs1cm1LM3qFEi23oSeV4LBWjYHmcsiurn1nL6FlXnxcOPve9J483FCsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; dkim=pass (2048-bit key; secure) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=RW5mKUuK; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:242:246e::2; helo=sipsolutions.net; envelope-from=johannes@sipsolutions.net; receiver=lists.ozlabs.org) smtp.mailfrom=sipsolutions.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=RW5mKUuK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sipsolutions.net (client-ip=2a01:4f8:242:246e::2; helo=sipsolutions.net; envelope-from=johannes@sipsolutions.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 2643 seconds by postgrey-1.37 at boromir; Mon, 03 Feb 2025 19:28:43 AEDT
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ymflv4lsKz2xf2
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Feb 2025 19:28:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=x1beuisn9wdEKP1QdS1UhUe3+GT+LqGgI15rKS+Adds=;
	t=1738571323; x=1739780923; b=RW5mKUuK45RzUP9GTYtuHxaM6WxYdQpoX7Vkv28fSkPeTj8
	6jo+j+Co99C/xHBrW8MQ8erxU8klexUCzSJSlE1/0ixAOR7wvnAKojEhPc5Ao3qfZZhc7V68YC+UD
	NxuOGrE1YA4nV0e2rgPl1W1nX2993Io5KhddJxWSqFdKGjQeEJAlUwmFpqLc22E0BMX5MxSXPJDm3
	MdK1muRgUK03cOY0GnWRPJHB5fQgh+k0R7yaM+jL54OL5q+xIarK+jugClIivjHML3Xl72uBJvjZu
	1bPeCXq/2H+3XRsaYkkKvF8FfCGRK8tQIFC9JtG8yPEaPVFgmQAbmgZ7EDuk2l5g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ter7q-00000001RTp-38Nc;
	Mon, 03 Feb 2025 08:44:11 +0100
Message-ID: <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
From: Johannes Berg <johannes@sipsolutions.net>
To: Yury Norov <yury.norov@gmail.com>, Vincent Mailhol
	 <mailhol.vincent@wanadoo.fr>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk@vger.kernel.org,
 	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, 	linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, 	linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Turquette	 <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre	
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu	 <herbert@gondor.apana.org.au>, "David S . Miller"
 <davem@davemloft.net>,  Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Jonathan Cameron
 <jic23@kernel.org>,  Lars-Peter Clausen	 <lars@metafoo.de>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung	 <schung@nuvoton.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Jakub Kicinski <kuba@kernel.org>, Alex Elder
 <elder@ieee.org>
Date: Mon, 03 Feb 2025 08:44:06 +0100
In-Reply-To: <Z5-xMUqrDuaE8Eo_@thinkpad>
References: <cover.1738329458.git.geert+renesas@glider.be>
	 <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
	 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
	 <Z5-xMUqrDuaE8Eo_@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
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
X-malware-bazaar: not-scanned

On Sun, 2025-02-02 at 12:53 -0500, Yury Norov wrote:
>=20
> > Instead of creating another variant for
> > non-constant bitfields, wouldn't it be better to make the existing macr=
o
> > accept both?
>=20
> Yes, it would definitely be better IMO.

On the flip side, there have been discussions in the past (though I
think not all, if any, on the list(s)) about the argument order. Since
the value is typically not a constant, requiring the mask to be a
constant has ensured that the argument order isn't as easily mixed up as
otherwise.

With a non-constant mask there can also be no validation that the mask
is contiguous etc.

Now that doesn't imply a strong objection - personally I've come to
prefer the lower-case typed versions anyway - but something to keep in
mind when doing this.

However, the suggested change to BUILD_BUG_ON_NOT_POWER_OF_2 almost
certainly shouldn't be done for the same reason - not compiling for non-
constant values is [IMHO] part of the API contract for that macro. This
can be important for the same reasons.

(Obviously, doing that change now doesn't invalidate existing code, but
it does remove checks that may have been intended to be present in the
code.)

johannes

