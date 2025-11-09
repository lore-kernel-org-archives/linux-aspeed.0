Return-Path: <linux-aspeed+bounces-2843-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DBBCCFA13
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Nov 2025 13:35:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4DLW3LSpz2yrm;
	Mon, 10 Nov 2025 00:34:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762695299;
	cv=none; b=f1eGnmxOZfzfkRZX5X90wVdrR9hnKicReb7me46weyUbM7CGhQi9G2mdf8DvRICGfRCcY0nqzD/FllA1S74CtBNeeaUX9/dziUrQIAo1J82+a+MivUeZjuhaxB5CH/InmVrYoSS5MFA5bBLL/1Qp0TDNxHt9o0kEetaFWB+SCsNw8Qvl2EWoFSdCHlRUuqxRUYjx4vm+dKUITvDL7DnGftEo8c1Li6T5yBU8HhqE+GyH9uFAfJ5Noyjqe2xQkebpxqgPXEDPrq9hDPhCpuHUU6gUIoe/a2IiZvloCK0ynxwlVbAXVPiQk/iXW/7bYUKJlqCRlGukBKr6bghoNlXLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762695299; c=relaxed/relaxed;
	bh=HmF9squiLrPCjJX+TbvOoZf+f0AKXHPgdiA4Rvt72X0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DqpbQYsExWyFwe0jyuWCdNmdFTtu2CkMzJ416y+3Z9tViiF0kUxVkk3UF14jKN55kQTxBVXNGLaFkFuRZ9Ao+irP5EwEfJc6c2Jc5mHtO8zRnIXoRvOjX9hpe3i9N/VekzOPPLXP4DNwO5i9BTJkw9LkQjcnvREJHRkSBq1d7/S8clm8h7nLz5rnJHFCoHU52a3Ng7WDY72Vyl7NPhaQZGZVq/verEwqO7UDW8/0/lzJZ0pTFiUgFsVBou8Vdy/ApWGXWFNJrY57BQTVQnbZE7yVclU5gxruceFOcw7L3v6mpMB565n77wLA0LPWpeNpIO2x9PcVvT6cWAdrutqHtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NQyQz3Xu; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NQyQz3Xu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4DLV3SRfz2xlQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 00:34:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F094600AC;
	Sun,  9 Nov 2025 13:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06534C19422;
	Sun,  9 Nov 2025 13:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762695295;
	bh=RT2rRE/ELY9bGrDnosbnveAK4kjkneS/XTqVsxUylns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQyQz3Xu/4ch5jjTTPDSBjeBVRNEYduCHsh+EDx3P6FlYJVpOQX6pKco9OgMOx/in
	 F80rjoMsLS/7XLxYrF1FBo4MLkHRajQPKOTIZOaC/6fi4uIG17iRyOJ0/gCowNRs1d
	 ppYRn1q4Dml/h8MeJM8+xvbkn6hxSYS0Z2rnmdV3FUTzsqvHwhUI9R7XecGmL4AZ66
	 FwIhhM5L3YI62kDlehONx8TWE1Va+28/8EvO//yU3GevKDsQAA9ma5ZjkVGW1Wx847
	 0ivPCgE6pzDWEvB89x/gYKximcAcQCf/eOzmpaCr0FWO1PrXAbtfbX3KfScts9bAF9
	 YRGLPkFrZYHmA==
Date: Sun, 9 Nov 2025 13:34:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yury Norov <yury.norov@gmail.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun
 Hung <schung@nuvoton.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex
 Elder <elder@ieee.org>, David Laight <david.laight.linux@gmail.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Jason Baron
 <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
 <tony.luck@intel.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Kim Seer Paller <kimseer.paller@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>,
 Cosmin Tanislav <demonsingur@gmail.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, Jianping Shen <Jianping.Shen@de.bosch.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org,
 qat-linux@intel.com, linux-gpio@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v6 10/26] iio: imu: smi330: #undef
 field_{get,prep}() before definition
Message-ID: <20251109133439.3d841b5b@jic23-huawei>
In-Reply-To: <54c739d05673e512d091bf78e54cd00e3655d7d4.1762435376.git.geert+renesas@glider.be>
References: <cover.1762435376.git.geert+renesas@glider.be>
	<54c739d05673e512d091bf78e54cd00e3655d7d4.1762435376.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Nov 2025 14:33:58 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
I tweaked the original driver to avoid the naming clash so this can be dropped
and we can replace with the new function next cycle.

Thanks,

Jonathan

> ---
> v6:
>   - No changes,
> 
> v5:
>   - New.
> ---
>  drivers/iio/imu/smi330/smi330_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
> index d9178725ade3da83..a79964fe68fadf47 100644
> --- a/drivers/iio/imu/smi330/smi330_core.c
> +++ b/drivers/iio/imu/smi330/smi330_core.c
> @@ -68,7 +68,9 @@
>  #define SMI330_SOFT_RESET_DELAY 2000
>  
>  /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> +#undef field_get
>  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#undef field_prep
>  #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
>  
>  #define SMI330_ACCEL_CHANNEL(_axis) {					\


