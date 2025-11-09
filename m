Return-Path: <linux-aspeed+bounces-2842-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3315CCFA1A
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Nov 2025 13:01:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4Cbs2sLKz2yjr;
	Mon, 10 Nov 2025 00:01:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762693289;
	cv=none; b=U79g3EgjYuPUpA1Kq2rCUUmMeulOlOIPrlYggR+zTbTq7oLPJjB84lGWqDA5RqTyXZ6kx1wPD00PHeY1NXZJDTb+tZJYNjLshZoUZBu0PKXDlfwRnqkP5BRFJxiIhlilWQud41GhQ2FxyQnCEUGg/teZj1ZWELx3DJIRRhY2mYwUkuqsueOJ4fOl9KbYAwlERl5GR01+cA++Zz8AavFMUWgtwHBoBqfaCP+AFj3HCW3UQuoMriqC8K/8sxoAfwNlVwyfprZcpdFWmr2mFgbohEHwcKxsMm/WIePXKRFPG1zsHQ0xp7PyKwFFUVy6FXb8rFLJOBTvexdXzuNAqBLBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762693289; c=relaxed/relaxed;
	bh=VsAMk0j4bUEAq2Xy6R/woGPhVEp5XLvlsFq2aXBkK7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQ1K/93R3z/j/X462Fu6gqnp5MifH7xJqeqemtedeE+kFLfYLCuNILcLNgBDd/KHe9Bzy89zzQSBo3TbEA2Cz3ECFldxsShZtTGIqYKuKFKxE+JFHFqUNvt3L3ZqYxunaoXakWpL/iPWSoBbCUjynH7MXGsohNFJYAT2YAjNamkna70KyRf4G0UJvzfTrTDjIvPhcQCxk2mPnHQDx6pBcNbG3bWSQPMQS2JRQSwL1Ehu2obBw+qXQKHFFEq0vJWQMVf/piG1937tsdbWTimvPCQ/UIC+x9RXA8JsdnGicvIelgS52RHcyppJ3vEXhNOF3ZmX0neq1TW6W4JssUjjkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EiUmTl27; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EiUmTl27;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4Cbr3Qbyz2yFJ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 00:01:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8DE9F43B36;
	Sun,  9 Nov 2025 13:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BF3C4CEF8;
	Sun,  9 Nov 2025 13:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762693285;
	bh=zNi9nu3L6TvcyXChQiHADlE5BR7XOd1UsthZfvb4G1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EiUmTl27nujv51T7if+PVcEwebMCbQCSCq+8xYpaEYI85RENWVNiRhQBbcZizkEcl
	 BoNN96p+WxmZf8XdtZd2JsH89A3j92nUV/nviNZBdoUa+JlTXZfeI1MheP7j0cuQVS
	 h92D51+L7hZ918wSo/TloZRFQb8IuVvMFsY/0olkMlPlIk7n0h9fCRAkSB/zrNZYUy
	 o4R3RMn97X9Qp2F9/enYc19Uabz3of7vben/btpQkQj13pd57/4mn4NtxOfAoZl9rB
	 nGuOIb3srFqktlT4NZZ/24ryLC2SYkCUPIwvyjQnO0esl0QpJC6RsjhO0psREWxDAE
	 TbMdryqtL/QNQ==
Date: Sun, 9 Nov 2025 12:59:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Miller
 <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun
 Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Johannes Berg <johannes@sipsolutions.net>,
 Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, David Laight
 <david.laight.linux@gmail.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, Jason Baron <jbaron@akamai.com>, Borislav
 Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Richard Genoud <richard.genoud@bootlin.com>, Cosmin Tanislav
 <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, Jianping
 Shen <Jianping.Shen@de.bosch.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org,
 qat-linux@intel.com, linux-gpio@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v5 10/23] iio: imu: smi330: #undef
 field_{get,prep}() before definition
Message-ID: <20251109125956.106c9a1a@jic23-huawei>
In-Reply-To: <CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
References: <cover.1761588465.git.geert+renesas@glider.be>
	<97549838f28a1bb7861cfb42ee687f832942b13a.1761588465.git.geert+renesas@glider.be>
	<20251102104326.0f1db96a@jic23-huawei>
	<CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
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

On Mon, 3 Nov 2025 11:09:36 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Jonathan,
> 
> On Sun, 2 Nov 2025 at 11:43, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Mon, 27 Oct 2025 19:41:44 +0100
> > Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> >  
> > > Prepare for the advent of globally available common field_get() and
> > > field_prep() macros by undefining the symbols before defining local
> > > variants.  This prevents redefinition warnings from the C preprocessor
> > > when introducing the common macros later.
> > >
> > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>  
> >
> > So this is going to make a mess of merging your series given this is
> > queued up for next merge window.
> >
> > I can pick this one up perhaps and we loop back to the replacement of
> > these in a future patch?  Or perhaps go instead with a rename
> > of these two which is probably nicer in the intermediate state than
> > undefs.  
> 
> Renaming would mean a lot of churn.
> Just picking up the #undef patch should be simple and safe? The
> removal of the underf and redef can be done in the next cycle.
> Thanks!

Only 1 call of each of these in the driver, so churn is small either way.

To avoid a bisection problem if your tree merges first I need to modify
this stuff in the original patch or leave it for Linus to deal with as
a merge conflict resolution which is mess I'd rather do without.

So I'll rebase now and rename these functions to have an smi330_ prefix.
Better to potentially cause people problems when I have 23 patches
on top of this (and hopefully no one is based on those yet) than when
I have many more.

So tweaked and pushed out a new version where this patch isn't needed.
We can move to your new code next cycle.

Jonathan



> 
> > > --- a/drivers/iio/imu/smi330/smi330_core.c
> > > +++ b/drivers/iio/imu/smi330/smi330_core.c
> > > @@ -68,7 +68,9 @@
> > >  #define SMI330_SOFT_RESET_DELAY 2000
> > >
> > >  /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> > > +#undef field_get
> > >  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > > +#undef field_prep
> > >  #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> > >
> > >  #define SMI330_ACCEL_CHANNEL(_axis) {                                        \  
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


