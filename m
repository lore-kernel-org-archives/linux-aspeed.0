Return-Path: <linux-aspeed+bounces-2846-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D15CCFA13
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Nov 2025 13:39:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4DRc6xVHz30M0;
	Mon, 10 Nov 2025 00:39:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762695564;
	cv=none; b=g4G/zDvuY/iNhPByG5UirxH8SlfhLfpWyn5y0PedYH0H4GjJzguzkUC1no8XiXV4GEDr2hkC84GzgPUFQzjE0MKx5cRWWTk0cKSdkACoJ+uRh+piO4o3VwwDtUh51jNhz79MQdOvW5FLwi49GNLNk5S6kYTBg4BY5Cx62tnciCmHmy7H+tI8Od4+y16c26Jb5RdjI01dkw5FDZB1lyGGueyNDvp2OtCW2qfRlYIxCG31NWo4jwWnT2CjnMvNeU7cx8fKKlO+i/0jIZHbtWdyL4/+S16VtyrRYdc0+HkrokVGYAz1Ph8aWIsp+w5oVNP08JvfbnGnlmaF4S0vYZVmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762695564; c=relaxed/relaxed;
	bh=XdPr4dEiHhJ0nx4RbQgokxdeBy4l/0iyJLr4y4wwBiE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ica6HdVq/toqFQPHgasR4MjQchdBH4ThqPmqPtygpUuanKB1C1Y/j1nTLHDgYEkbGgb+++OKtf2/JNBvM0ITO/qGtZLMBJ0+WfzcceKa6nu3tck/z065fX+vKDkXCOIMTd33VX/kC5v5iiaNhtHRsYzlMw9+/WutTpBTDwQ99Lk5DDE+x28r4QuvHijKZMx2Kp21lL8wDR726QlE+nUoFjTh6MlQmAUsqE50DV/aq3wHAakQo/YD2/cKyQXSlE42H9ZXKPh6f248Sx2tXSzNwF9pOBCBc9b0pkwrSVOw/msYwDF7wJInItaYhOS/tb+aLj9NDUFtIky7Exzdrk69hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eRuJdceF; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eRuJdceF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4DRb5j35z2xlQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 00:39:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 73F95600B0;
	Sun,  9 Nov 2025 13:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DF5C4CEF7;
	Sun,  9 Nov 2025 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762695561;
	bh=TmS8CkFMzA8p257zgP8ajlZZj7NKktorZzJfGu8kADk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eRuJdceFQsdR7lWVjZXcQ5eo2LTrpkwCjVnhqhWqMgsWHpPaOmCSWAruleR0rDa3c
	 zewmxH8r/ugX+Auz1z/GzwLYEmryJP7Yxt9ENJ0AKXlgrY5A6lsFG5/fgdl/WlQuI0
	 wm5J1acBHw4E/gK68u06+opel8VRhYcrJcvtOFcncyLFMAVSPe89x4T+DcAQy3aEQQ
	 oX85a3JCzSZAbUxwWvjBgSMTrD8mI2+wsSwQYY/Cvor7FYRe2eXlHmti2qvQabVS0/
	 o+scmlpg9ZtBwS6CeH2c/exLXcnhRK2SIJLAmWLQvpPhhKxsXEyIVR2Jv6uyzWZ37T
	 Qr+4vzbXZuRrg==
Date: Sun, 9 Nov 2025 13:39:04 +0000
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
Subject: Re: [PATCH -next v6 23/26] iio: imu: smi330: Convert to common
 field_{get,prep}() helpers
Message-ID: <20251109133904.5eff2558@jic23-huawei>
In-Reply-To: <a2275bd69f25d33f9fd3345409b2d8ae6285b9a7.1762435376.git.geert+renesas@glider.be>
References: <cover.1762435376.git.geert+renesas@glider.be>
	<a2275bd69f25d33f9fd3345409b2d8ae6285b9a7.1762435376.git.geert+renesas@glider.be>
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

On Thu,  6 Nov 2025 14:34:11 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Drop the driver-specific field_get() and field_prep() macros, in favor
> of the globally available variants from <linux/bitfield.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This will need a revist next cycle. I preferred not to have
the odd looking undef in the driver at introduction so prefixed with smi330_
instead.  Only one instance so it wasn't worth comments to make ti clear what was going on.

J


> ---
> v6:
>   - No changes,
> 
> v5:
>   - New.
> ---
>  drivers/iio/imu/smi330/smi330_core.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
> index a79964fe68fadf47..83e0dff5d973d046 100644
> --- a/drivers/iio/imu/smi330/smi330_core.c
> +++ b/drivers/iio/imu/smi330/smi330_core.c
> @@ -67,12 +67,6 @@
>  #define SMI330_CHIP_ID 0x42
>  #define SMI330_SOFT_RESET_DELAY 2000
>  
> -/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> -#undef field_get
> -#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> -#undef field_prep
> -#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> -
>  #define SMI330_ACCEL_CHANNEL(_axis) {					\
>  	.type = IIO_ACCEL,						\
>  	.modified = 1,							\


