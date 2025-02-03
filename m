Return-Path: <linux-aspeed+bounces-621-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30013C02196
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Feb 2025 15:31:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ymr864RJqz2xk7;
	Tue,  4 Feb 2025 02:31:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:242:246e::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738596710;
	cv=none; b=GrhscE+WdsChW4AWHkebiSVZWxf4inoXw8CwKlL+fdPIIhqJ0Aow0+4eouPXD55HzaDMqTcMKEnyyaYqHQgAgUGjEdI/LNb91KM6Hhe0AXe2lQuSQvoGvq0H20mZhcNJ3aEz0FmHyptFiQ7SpgpDndHGXSvnt0jukq3vciGd0GGiytnD8VRYObkoKCOCCg2NBBZEXyVt3w5HqJCYtNS2ukJyPtK/2HCtbtkysqMTksxAI072EV/lSdoMwjgYfM+8TWtQyW9FOT6mA0VYgvMCNZ0D4ySHnchydWVI5VGh1zuj8ueVwlnzWCp14MB4yFX6pfMLFFDb8+h0SrqqQ0kTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738596710; c=relaxed/relaxed;
	bh=PAvOtJHsIMS59RfRzFfMyl8id23TWAECc7EwAHrUKlY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XXSEHs9XdNmybcm4y+W7Rp8eqrzHSkm4/6yiqd4leCHlD7P0x4VYQ19T5zTooF0KXUCEMOksZByUVlTBscTBmoQHDgvCg1e4x+Igs46PCtsCWhECab5kN0kXMtveeUW15WoU+dAGk1vadJmGycozimcUll+6OMK2do2acyTt2Uvik4njwxcuEsN+xhU9DUa0+ncUlvOwRny9/Hwb8rb4WpMmR6vO6M6BFXGyKdPdyGfCHybPpLJ4rZ3RU5rTZWtBgLShYhl/pV03eD0OISrPBUZ328vFeJHdylmE6I0OiUqnvhgOinNzew5IvfvBG5PfkwNR9B5Dr4rNvL5/QwbjOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; dkim=pass (2048-bit key; secure) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=WPKbYP2m; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:242:246e::2; helo=sipsolutions.net; envelope-from=johannes@sipsolutions.net; receiver=lists.ozlabs.org) smtp.mailfrom=sipsolutions.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=WPKbYP2m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sipsolutions.net (client-ip=2a01:4f8:242:246e::2; helo=sipsolutions.net; envelope-from=johannes@sipsolutions.net; receiver=lists.ozlabs.org)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ymr854YDyz2xJ8
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Feb 2025 02:31:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PAvOtJHsIMS59RfRzFfMyl8id23TWAECc7EwAHrUKlY=;
	t=1738596709; x=1739806309; b=WPKbYP2m554oV92ofNHXgmK4f5Kczfmx2KPMeDJ7kzv1Sml
	y1H3j1+rZ0GesRwgqUY5RZsVVrDmBPHmpxMcL0DNzmIvmAikxh7BFhj4iy4ABbQ2g8ZExVnUlpK2C
	GsK61+rWhqpm1tth0kgHRNRp0cpkz+gwtfAwc5g/rHbQANNEruTT4Pf1Xq5CSlWhnCwiIbxYfzKP9
	IEm9aMR8rkQBGczMUdSCY7UdN6VS75As6bv/VjRl6H11vZbLpPA5zN6thqtKcpAp2rOXzjCmPbLR2
	lQ1sulqkjKmvqann1uS8o9cDlWWI/at8loLohsF6z7VllXRMpRr8sIgJtkM1PmVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1teyQE-00000001gus-0LFB;
	Mon, 03 Feb 2025 16:31:38 +0100
Message-ID: <2904baea9188a4707d4b5a9a6bfa517a54323f8a.camel@sipsolutions.net>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
From: Johannes Berg <johannes@sipsolutions.net>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov
	 <yury.norov@gmail.com>
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
Date: Mon, 03 Feb 2025 16:31:36 +0100
In-Reply-To: <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
References: <cover.1738329458.git.geert+renesas@glider.be>
	 <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
	 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
	 <Z5-xMUqrDuaE8Eo_@thinkpad>
	 <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net>
	 <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
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

On Mon, 2025-02-03 at 22:36 +0900, Vincent Mailhol wrote:
> > On the flip side, there have been discussions in the past (though I
> > think not all, if any, on the list(s)) about the argument order. Since
> > the value is typically not a constant, requiring the mask to be a
> > constant has ensured that the argument order isn't as easily mixed up a=
s
> > otherwise.
>=20
> If this is a concern, then it can be checked with:
>=20
>   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask) &&
>                    __builtin_constant_p(_val),
>                    _pfx "mask is not constant");
>=20
> It means that we forbid FIELD_PREP(non_const_mask, const_val) but allow
> any other combination.

There almost certainly will be users who want both to be non-constant
though, and anyway I don't understand how that helps - if you want to
write the value 0x7 to the (variable) mask 0xF then this won't catch
anything?

> > However, the suggested change to BUILD_BUG_ON_NOT_POWER_OF_2 almost
> > certainly shouldn't be done for the same reason - not compiling for non=
-
> > constant values is [IMHO] part of the API contract for that macro. This
> > can be important for the same reasons.
>=20
> Your point is fair enough. But I do not see this as a killer argument.
> We can instead just add below helper:
>=20
>   BUILD_BUG_ON_STATICALLY_NOT_POWER_OF_2()
>=20
> But, for the same reason why I would rather not have both the
> FIELD_{PREP,GET}() and the field_{prep,get}(), I would also rather not
> have a BUILD_BUG_ON_NOT_POWER_OF_2() and a
> BUILD_BUG_ON_STATICALLY_NOT_POWER_OF_2().
>=20
> If your concern is the wording of the contract, the description can just
> be updated.

No, I just think in both cases it's really bad form to silently update
the contract removing negative assertions that other people may have
been relying on. Not because these trigger today, of course, but because
they may not have added additional checks, or similar.

So arguably then you should have BUILD_BUG_ON_CONST_NOT_POWER_OF_2() or
so instead, so that all existing users are unaffected by the updates,
and similarly that's an argument for leaving FIELD_* versions intact. Or
I guess one could change all existing users to new ones accordingly, say
FIELD_*_CONST_MASK(), but that's pretty annoying too.

johannes

