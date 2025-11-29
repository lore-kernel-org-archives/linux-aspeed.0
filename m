Return-Path: <linux-aspeed+bounces-3018-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB65CFD2F6
	for <linux-aspeed@archiver.kernel.org>; Sat, 29 Nov 2025 12:45:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dJVJK1HGQz2yvH;
	Sat, 29 Nov 2025 23:45:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764420337;
	cv=none; b=XuWjLrevszRxTXzPDCNHGmS7qI9CLwos8tAv0XepF3R0XCTcItobmd93aPNxRFuKD1F9L3j9twq9fk5PZ7TWyG2XfaHIkEOdiJY5xttiRqeb6HA07d9uDl7HtzIfD6NHOyajt2jY1+4fmolkxW3iCAWGhuJofSUSV/5kLtzukxk11UrZG1Mxk1CYlipnZYMSEiOrpmwgHrQokkrfhwilXAS1wHiKWRiWxAozTWNoby6tT5aTr6wZ1T/qqvKrZRLcCZRIwNi+ZjAmA6C3uki5/1rcuB5P1IoSwpisbJ9HZiVUS+hn1Or+f/DzDp1IL9BFB8H6GfJSbLz2tmsL4Ycvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764420337; c=relaxed/relaxed;
	bh=TImXxPp3fH8t3WgGQuC2IHIt10tqIWX7TcyUqtyR31I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TdjBIYRXu+63pCCtY6GkmZCupz61xd2u+l3QguXweZzoDse2TLT71WupROmXYiBrBQprJnnusSjBye4BLkVJJk7YZEuxZCe91wIBihl5O6rHnWNwpnepAMaq/xofYlWjofVXkG6+oLX8MN1SuL0W0W0yqPQD3qlkR4qz+jMOhJciOnnUnV8U6K/3WMtF6FEaiC5nFgfH4E2vSzEla12ffOqYY5gUCVO8SIxdt4ejH9bMNzsdiBk+Um1pQWhRWeL9CAtuDAsbyk3EUq/jEDy5pSvfM813XZc+fr2K+N4LszXipiJI/0reJp2dvAp0jTTogE9PGF6WcwFybN3Nv8wc9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KpLK2to1; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KpLK2to1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dJVJH0rF7z2xQs
	for <linux-aspeed@lists.ozlabs.org>; Sat, 29 Nov 2025 23:45:32 +1100 (AEDT)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 09F734E41971;
	Sat, 29 Nov 2025 12:45:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BBCF760706;
	Sat, 29 Nov 2025 12:45:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 109BA11910699;
	Sat, 29 Nov 2025 13:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764420325; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TImXxPp3fH8t3WgGQuC2IHIt10tqIWX7TcyUqtyR31I=;
	b=KpLK2to1cF7NAB3dxoOLV/QWk7f3DOgDWnlCCQ/eWjBGe2OiLoz4MRPaxtNjJ5LhgTdO2x
	liQWrTjoV8SzbJ0IRNAWzjSTpxuBdKdZK+nMBBo+lz6eN4ScfF10Zi8hpoNB3oNhnhPAkB
	EBcOP1L5+m8y1BhDyM8QV2Sd1zOhoSjtmlz4x+NWF5bSJDvmY6HuADwinRYPvMGebmhy3r
	ecHZmVrqRYz0ygRRnstaU1i/ARfGhaUjItbgMb+f1cIphEqym8E4UMuA0rRIXKXq4K6uEQ
	20vrn9fsYJ9NCOmjJv1jyigd96ejKGwakw15qyOFOaK5wOwWkE03lUfTBtfXBQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yury Norov <yury.norov@gmail.com>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Nicolas
 Ferre <nicolas.ferre@microchip.com>,  Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  Giovanni Cabiddu
 <giovanni.cabiddu@intel.com>,  Herbert Xu <herbert@gondor.apana.org.au>,
  David Miller <davem@davemloft.net>,  Linus Walleij
 <linus.walleij@linaro.org>,  Bartosz Golaszewski <brgl@bgdev.pl>,  Joel
 Stanley <joel@jms.id.au>,  Andrew Jeffery <andrew@codeconstruct.com.au>,
  Crt Mori <cmo@melexis.com>,  Jonathan Cameron <jic23@kernel.org>,
  Lars-Peter Clausen <lars@metafoo.de>,  Jacky Huang
 <ychuang3@nuvoton.com>,  Shan-Chun Hung <schung@nuvoton.com>,  Rasmus
 Villemoes <linux@rasmusvillemoes.dk>,  Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>,  Johannes Berg
 <johannes@sipsolutions.net>,  Jakub Kicinski <kuba@kernel.org>,  Alex
 Elder <elder@ieee.org>,  David Laight <david.laight.linux@gmail.com>,
  Vincent Mailhol <mailhol.vincent@wanadoo.fr>,  Jason Baron
 <jbaron@akamai.com>,  Borislav Petkov <bp@alien8.de>,  Tony Luck
 <tony.luck@intel.com>,  Michael Hennerich <Michael.Hennerich@analog.com>,
  Kim Seer Paller <kimseer.paller@analog.com>,  David Lechner
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  Andy Shevchenko
 <andy@kernel.org>,  Richard Genoud <richard.genoud@bootlin.com>,  Cosmin
 Tanislav <demonsingur@gmail.com>,  Biju Das <biju.das.jz@bp.renesas.com>,
  Jianping Shen <Jianping.Shen@de.bosch.com>,  Nathan Chancellor
 <nathan@kernel.org>,  Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-renesas-soc@vger.kernel.org,
  linux-crypto@vger.kernel.org,  linux-edac@vger.kernel.org,
  qat-linux@intel.com,  linux-gpio@vger.kernel.org,
  linux-aspeed@lists.ozlabs.org,  linux-iio@vger.kernel.org,
  linux-sound@vger.kernel.org,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v6 11/26] mtd: rawnand: sunxi: #undef
 field_{get,prep}() before local definition
In-Reply-To: <703d7eec56074148daed4ea45b637f8a83f15305.1762435376.git.geert+renesas@glider.be>
	(Geert Uytterhoeven's message of "Thu, 6 Nov 2025 14:33:59 +0100")
References: <cover.1762435376.git.geert+renesas@glider.be>
	<703d7eec56074148daed4ea45b637f8a83f15305.1762435376.git.geert+renesas@glider.be>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Sat, 29 Nov 2025 13:45:09 +0100
Message-ID: <87h5udm2i2.fsf@bootlin.com>
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
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 06/11/2025 at 14:33:59 +01, Geert Uytterhoeven <geert+renesas@glider.be>=
 wrote:

> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Finally applied to nand/next, will be part of the next merge window.

Thanks,
Miqu=C3=A8l

