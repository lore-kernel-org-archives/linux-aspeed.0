Return-Path: <linux-aspeed+bounces-2844-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18CDCCFA13
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Nov 2025 13:35:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4DMF0MnDz2yrm;
	Mon, 10 Nov 2025 00:35:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762695337;
	cv=none; b=X0QaBjwb60qdqn1s3WTUP89Dj8d+qEAouNoDo9oc9Z6TqqIoljWzZa4yO4UCv05iUb00miMq1abMusCNvuoxdqh/C0PzpSYem6kL0N569U//idtz8LiB7WAJixg0qJTQQ5VFIqGpNNQVr8NyL8Nx/61GORz2V0++LD/LLiHBZc4xC8EKTo+GxHjMxJTIIp/W2l3glf+0JLbczEMgArRRg3qx4RG/i1slFXiHqL7oJ7bS5jUuYd7xQvTneL1yoPRnw0eYx7I8CTHs/w+5nJWgUfDtqHGEL2grOvBkw/paI1ai7RVf3HUsGAz2xb15K0DRmQuyZk1UpbpEDK74cXJq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762695337; c=relaxed/relaxed;
	bh=1lefflMraCHr+sWHVHbgPHN40f0is5iaMzcdBjTpgz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jr3ML/tQfzS6gpQQVa84CnVZTR3TjyYW4hDXf2DFj75g/DBV0WYzslapQle/fu+IpPmymJZU93T1srSuB3dB3ML7TScld4rvDJqezwvq+CE5ljsKx6uE+vCKLMUHXRp8C/aXxbZYnSeYHzrwjNt4TwWMQY2agTC7bS+Xik+m8TTRwfE1UmHCmpNQwnQgMYb5LaoWChzgQET1vjq85Cx/tcRzCmuPUsA7HDJVV/Gnfml6iMiL71AkdjWpCnQuC4Ngccxo5nTMEWMGyV/OenOUh6e3iCz9Pexd4hV66hdHDSqnrjCx7/DJapbcFFUmNeeybi6KH32Bo6H+b8oDTICgUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OUq4YlSc; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OUq4YlSc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4DMD1W9Vz2xlQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 00:35:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 482B74065F;
	Sun,  9 Nov 2025 13:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73F0C19423;
	Sun,  9 Nov 2025 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762695333;
	bh=75xVTH6rL41i5gNYi5D5wNYFSB4OID9FByUjwxNSe6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OUq4YlScR9Yr3lqdI8+Yp0fI/C5dkrRC8Cq+F3uyLXMiZuA7Hfzg0VIC4P2u9QNCf
	 C9AHZ2WTv5ZZUwgeHDjJ7ysaW4HPELl7S/VLwzmiEWmH9x7XuuSN+Ln99YomjKvbMq
	 i3MhKBHc5WBbb6gdQpeOjbaUu7qebuQ00zSVfr+hMjBXHDv4tF+JB3hNcGYAPVP0Bg
	 YBFDxk8I51LYyPl31nWk18LZDNHXhTQPG0l9XQKqXzTP5bnECbCZypFzgHezD1SqP0
	 VkIWa5JPPo0EKvKltofU/ebvRFI1V7map8EhrzGaM4iK3tb4gIY5z3XHz3ztCpG+JO
	 I0PjTLazIvM+Q==
Date: Sun, 9 Nov 2025 13:35:13 +0000
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
Subject: Re: [PATCH v6 05/26] iio: dac: ad3530r: #undef field_prep() before
 local definition
Message-ID: <20251109133513.195e6baa@jic23-huawei>
In-Reply-To: <a2466d9201cb8c25504e25ac531a69ef8bd6e958.1762435376.git.geert+renesas@glider.be>
References: <cover.1762435376.git.geert+renesas@glider.be>
	<a2466d9201cb8c25504e25ac531a69ef8bd6e958.1762435376.git.geert+renesas@glider.be>
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

On Thu,  6 Nov 2025 14:33:53 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Prepare for the advent of a globally available common field_prep() macro
> by undefining the symbol before defining a local variant.  This prevents
> redefinition warnings from the C preprocessor when introducing the common
> macro later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> ---
> v6:
>   - No changes,
> 
> v5:
>   - New.
> ---
>  drivers/iio/dac/ad3530r.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> index 6134613777b8e1d4..5684d11137f29948 100644
> --- a/drivers/iio/dac/ad3530r.c
> +++ b/drivers/iio/dac/ad3530r.c
> @@ -54,6 +54,7 @@
>  #define AD3531R_MAX_CHANNELS			4
>  
>  /* Non-constant mask variant of FIELD_PREP() */
> +#undef field_prep
>  #define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
>  
>  enum ad3530r_mode {


