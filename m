Return-Path: <linux-aspeed+bounces-2899-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3DBCD4F49
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Nov 2025 03:36:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d72qP0LT6z2ySq;
	Fri, 14 Nov 2025 14:36:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763091376;
	cv=none; b=gs4lqvfqmRD3dPSDn9thxC1hmqHQbCtM8XhatjF2tbNJpe+aus3izawGlQq0gLbWiMeyCyFsdhz/uxN1T5BVSAKE6FqwOiQfavut27Kt6vFFaj4zd4NSONHZT5qtfiNW6wIK/FtWWakZSMWsvQNY97C9MMlcevXYCm0MvmaEuKNsNzVwAcNCAuS0vy9xd0ksk1x28aW6iXA+XAv+niiem05TGvwAkfpLIlOoIyhDsKCpX+OFm7D1aPwBlDNHVqHJk2NjiMT85nMN+d/7k0Fj4j8HpkQ4fo5a1UZV6Iji02oBnyHQcOwplumKvYGBJ0fmM4FjHX9JBFKnjwuNSZRo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763091376; c=relaxed/relaxed;
	bh=XRBfI7gCdxMfJLaXkHGy03GrbCVok28+ep4vK2GpY1c=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=aw6OMcSPMr6tGRdZ88WlSKmqSuFHHbRO3vHgc5c4tPLj+KSEouArMDIrMeLVKDwyaDyGmI0rFVLM10yVQAbxGQzB28aa71mDpnQvVhbzIzp+BftCGypLZScwXu7yp8O7IhWqM3Cu7Oj2a15DC7EyrX0M91ASNSruLxbH+Dn2FuZ8wOlXf7LnaLQM4zHOOzDZ2TIUq61Z4pf61N2vySN98hEOfa+JwWZFM0/KOzznDtGOWM0IkLeWDt3lM1yuKijRIYTLGNshaWXHN/mzUujkliVgvVf4WI6g/F6eYAEVoA/LE+Fbyf7dG9uca0Jc+SxsnXjVzIqCg1HaXHuukzLmOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n7nI17pR reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n7nI17pR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d72qN1mTpz2xnh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Nov 2025 14:36:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4570F41ACE;
	Fri, 14 Nov 2025 03:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FF0C19423;
	Fri, 14 Nov 2025 03:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763091373;
	bh=XRBfI7gCdxMfJLaXkHGy03GrbCVok28+ep4vK2GpY1c=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=n7nI17pRMr1dpfHfU2p0leMeiTeGE8hGKpnT0L8rT84fp93GxrptMg6I85MhEEu6T
	 jyeqVOKpyqNzeKFNanO6fWFdZwxn6N3Wqf2owP5E/4c0JWPkfJYmjEvIloXNPX849E
	 gatEJlaoTBG+p9Azfktd/4kpOVjULM4CdfUK4xbcKwxEcG/DBSpTSBRssx6CQJk3Az
	 QySIcw+Uaeh/dF932gRgnoCwdYt7BV0K+D4VNI4432FRZdIhY2pHnK8ZR30izZsUbk
	 3Losz5abqvpVbFbdNjSRwRRKTMPBTkgKEh2ILGFEgutOUgGfL3HypQyjhc7D4CWY+9
	 knhAzy9slS43Q==
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
In-Reply-To: <7414c080bbacc3c5be00c0eec4f5cbca386acaf3.1762435376.git.geert+renesas@glider.be>
References: <cover.1762435376.git.geert+renesas@glider.be> <7414c080bbacc3c5be00c0eec4f5cbca386acaf3.1762435376.git.geert+renesas@glider.be>
Subject: Re: [PATCH v6 14/26] clk: at91: Convert to common field_{get,prep}() helpers
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
To: Alex Elder <elder@ieee.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Biju Das <biju.das.jz@bp.renesas.com>, Borislav Petkov <bp@alien8.de>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Cosmin Tanislav <demonsingur@gmail.com>, Crt Mori <cmo@melexis.com>, David Laight <david.laight.linux@gmail.com>, David Lechner <dlechner@baylibre.com>, David Miller <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Jacky Huang <ychuang3@nuvoton.com>, Jakub Kicinski <kuba@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Jason Baron <jbaron@akamai.com>, Jianping Shen <Jianping.Shen@de.bosch.com>, Joel Stanley <joel@jms.id.au>, Johannes Berg <johannes@sipsolutions.net>, Jonathan Cameron <jic23@kernel.org>, Kim Seer Paller <kimseer.paller@analog.com>, Lars-Peter Clausen <l
 ars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, Michael Hennerich <Michael.Hennerich@analog.com>, Michael Turquette <mturquette@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Richard Genoud <richard.genoud@bootlin.com>, Richard Weinberger <richard@nod.at>, Shan-Chun Hung <schung@nuvoton.com>, Takashi Iwai <tiwai@suse.com>, Tony Luck <tony.luck@intel.com>, Vignesh Raghavendra <vigneshr@ti.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>
Date: Thu, 13 Nov 2025 18:26:57 -0800
Message-ID: <176308721705.11952.11835271974430936980@localhost.localdomain>
User-Agent: alot/0.11

Quoting Geert Uytterhoeven (2025-11-06 05:34:02)
> Drop the driver-specific field_get() and field_prep() macros, in favor
> of the globally available variants from <linux/bitfield.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

