Return-Path: <linux-aspeed+bounces-2663-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FC3CCF9E5
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Oct 2025 20:45:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwQW82PGGz2xQ5;
	Tue, 28 Oct 2025 07:45:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761597924;
	cv=none; b=K2A4IdxOVdk55PNZJDTXeY18nIbpay4HQKO+jIehNCxTApPnEsCScQstBCRirbO+EuSKy+tEMlDGGpvAN7/rddvJI8TVojbuh8JWeG7uREWJrQ3k8L2VKJySp958bC5sa1aw89m4awf+JsxXbuUOIvKDNSeyADrEB5rg5ibx5iuEFcbR31CWf3MpSkqX/ADBu5IKAYNCREwH5ahY52Rc3ntsMPV4bDqHUG+Zs9WkX4TUA4DcN5TKXkyXjyCRxL43H+CatnebcTKTa3v3tAhcbTWVj2CREf3cZTy9EeO5r5JP65Afee6TWfUutM4JnGV8XrIA7L1bxsTK+5iEZxdxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761597924; c=relaxed/relaxed;
	bh=ivu3nqaTqww2kM8ddgXsb86XR8Ecjso6qu9XWZHw9NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtzbrgwJtSQF1h1uiostLh7ng1SjODj8m1cy2ORJ/Cwr7BOkF6GGghZuqtLnndhs+JrGJLa7gmbXnBDCwkKTr7v5nhZtZKlMxjQOx3yL/URNm1FRQYN7FYZup3lkef5T05joF4VfLDFB77IccgvJnRjsr4jx1kE69fGZzWxCoC5TmL/W3If7iElBxfsoyH+so0Cj1Y5fptCf/d28DFuwpF83Hhq1LFrDU7osL24mt+lyEtqK5Vai+EarHvVb5AgVziax+fN0pX4C9uGKu6DU4gsMqtMD+5wBikRUQO9U1VfadDngOStQD1SqHizPNUTZYQiXaW7hnG5P3NGn+M6WPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=D0FvDvo6; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=alexandre.belloni@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=D0FvDvo6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=alexandre.belloni@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 465 seconds by postgrey-1.37 at boromir; Tue, 28 Oct 2025 07:45:22 AEDT
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwQW65dskz2xQ4
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Oct 2025 07:45:21 +1100 (AEDT)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 199381A16C2;
	Mon, 27 Oct 2025 20:37:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D91106062C;
	Mon, 27 Oct 2025 20:37:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6F94102F2494;
	Mon, 27 Oct 2025 21:36:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761597449; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ivu3nqaTqww2kM8ddgXsb86XR8Ecjso6qu9XWZHw9NQ=;
	b=D0FvDvo6wBdzyM4yGf/Mo92JGsnDp3FEhnzQXToKT1lTmRgmCAobeQwwgIerEldSavB9Wj
	8Fa1YqUSJN1a+KiX1LsgxoTiLAWFpjtTkZ/psXHq539twWXUsfVfZ1tOA47yFwLd40ImsE
	G9WDXQxl4673JnnqnSaS0aJnztT1jPuWGeK5RQylZ1VZl0DiiBjKRSdLHbVPGru9aMBn/L
	/NPFjf5YF1MLpjQf7UlDDcAIkfmZHS4oVHjAeodKNVAVJDdwuc8RjEgecO9ymeKN374J5m
	aI0g1qxMk56Vwb3LCXgHJanQvqdAAA00oe5CNpFNb2x5v0Y/CqIa0frpfHITdQ==
Date: Mon, 27 Oct 2025 21:36:40 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org, qat-linux@intel.com,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/23] clk: at91: pmc: #undef field_{get,prep}()
 before definition
Message-ID: <20251027203640291d726b@mail.local>
References: <cover.1761588465.git.geert+renesas@glider.be>
 <a26cfb39f4ac309ffbff339ffa5f54db12bd8c12.1761588465.git.geert+renesas@glider.be>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a26cfb39f4ac309ffbff339ffa5f54db12bd8c12.1761588465.git.geert+renesas@glider.be>
X-Last-TLS-Session-Version: TLSv1.3

On 27/10/2025 19:41:35+0100, Geert Uytterhoeven wrote:
> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> --
> v5:
>   - New.
> ---
>  drivers/clk/at91/pmc.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 5daa32c4cf2540d7..78a87d31463e98b0 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -117,7 +117,9 @@ struct at91_clk_pms {
>  	unsigned int parent;
>  };
>  
> +#undef field_get
>  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#undef field_prep
>  #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
>  
>  #define ndck(a, s) (a[s - 1].id + 1)
> -- 
> 2.43.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

