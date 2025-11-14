Return-Path: <linux-aspeed+bounces-2900-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D118ACDB481
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Nov 2025 03:36:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d72qP600mz2yv7;
	Fri, 14 Nov 2025 14:36:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763091377;
	cv=none; b=Q/U73hTkWEkygglT2Q3Rw5Dc010LFEtyxOcZoeOqBhnzGvKfayJo+hg7SytG6UHSqWFqxCVIFUZRu8YzaQAi49j8vLngngyfCXxPlf8elKoIpz4AiaI5hvTXG41nisp5lqku09CVOUI866v9hj5qBed12uT00Teintf+TRvOHQJHjHzhWxqOyQWDyHjC3BiJ5f1Z3OTmjec6JxU7n4u30bRl0lplyRXVnMHBD4ydl2BVMWsgm643vnXjtI7YhMJKYOI8cusY1Ynboa2MyRqkj1H4c6WhVRxDM6F4ZtTSyaDTMOHpWa1lEevrXrWDMQA9Cjjd8fYs8YWpZSgpRvHXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763091377; c=relaxed/relaxed;
	bh=To+6ZaYy+eiRsC0ioX7VEavjbMju6hQPTprPPzDVZjU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=okXyitpLbTdbBYh2wTr4D22p4PvC/F8BZ8GVM+FvgUAmWEqd1SuAs9nXM9JTZ3PIjwawDGj7l311+9Lkez1Or4Wah/e8i69i4XFHi2DpbSPhEKcaeR1o4zGDF9kUrb+rY8dkrb7p8hEV03E+8i2scuevMztBMKALnfk37nVgsUT93TZ/Abh0rxajhTXkYoRSYhpIlKYY7Pyw9q7x482uQtaOJVPbwU4Z6yrhY0xNvS6oLMQkuJTuHYgoQTAoCwwck7nHmiZLEp552bLC1oTWDsrGxBYbFHdwKQl9zuyzq++rIpz1PhqGNs7QwWzCO6nx5gZpt1/iIyWeIdkhw254JQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OzOAb5rU reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OzOAb5rU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d72qP27Flz2xnh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Nov 2025 14:36:17 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 42F5C44562;
	Fri, 14 Nov 2025 03:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE349C4CEF1;
	Fri, 14 Nov 2025 03:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763091375;
	bh=To+6ZaYy+eiRsC0ioX7VEavjbMju6hQPTprPPzDVZjU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=OzOAb5rU0m6IeVwvdPx8/jYfCbjGlii0+BThQKKDG6BaMR6U2pMUMxBvvOE03rVK2
	 H8IkOkt7SKe/Vis6y5odzcJLKGY282asdENvNKAZHHtw3Tc0FR42roTN1Pr3bz30N1
	 pKMJN4F68jmmCH4PhnUkdbpGQe9WTfMImZHBRel/01NsaVx7a4pgvLIJyDpq8FkEvS
	 F7gyMdAMGLzRi8Guo0ld5xVF96CEBKAFVs6HD0ZDejQ3hNlhg87beqX3qtJuwj084H
	 gw6LYZ6S5ehc61/nZhd+ctL++INzK/rCm61qHIGvofGModgN1ZnYfdYBu95yEs76I4
	 3MxQNOLx8Au1g==
Content-Type: text/plain; charset="utf-8"
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8014f3aaf8f55f41cb8799b682737882cd1c1112.1762435376.git.geert+renesas@glider.be>
References: <cover.1762435376.git.geert+renesas@glider.be> <8014f3aaf8f55f41cb8799b682737882cd1c1112.1762435376.git.geert+renesas@glider.be>
Subject: Re: [PATCH v6 25/26] clk: renesas: Use bitfield helpers
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
To: Alex Elder <elder@ieee.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Biju Das <biju.das.jz@bp.renesas.com>, Borislav Petkov <bp@alien8.de>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Cosmin Tanislav <demonsingur@gmail.com>, Crt Mori <cmo@melexis.com>, David Laight <david.laight.linux@gmail.com>, David Lechner <dlechner@baylibre.com>, David Miller <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Jacky Huang <ychuang3@nuvoton.com>, Jakub Kicinski <kuba@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Jason Baron <jbaron@akamai.com>, Jianping Shen <Jianping.Shen@de.bosch.com>, Joel Stanley <joel@jms.id.au>, Johannes Berg <johannes@sipsolutions.net>, Jonathan Cameron <jic23@kernel.org>, Kim Seer Paller <kimseer.paller@analog.com>, Lars-Peter Clausen <l
 ars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, Michael Hennerich <Michael.Hennerich@analog.com>, Michael Turquette <mturquette@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Richard Genoud <richard.genoud@bootlin.com>, Richard Weinberger <richard@nod.at>, Shan-Chun Hung <schung@nuvoton.com>, Takashi Iwai <tiwai@suse.com>, Tony Luck <tony.luck@intel.com>, Vignesh Raghavendra <vigneshr@ti.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>
Date: Thu, 13 Nov 2025 18:28:47 -0800
Message-ID: <176308732781.11952.18067279124978377191@localhost.localdomain>
User-Agent: alot/0.11

Quoting Geert Uytterhoeven (2025-11-06 05:34:13)
> Use the FIELD_{GET,PREP}() and field_{get,prep}() helpers for const
> respective non-const bitfields, instead of open-coding the same
> operations.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

