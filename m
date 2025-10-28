Return-Path: <linux-aspeed+bounces-2675-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9DACCD1BF
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Oct 2025 16:20:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwwZt3X6Gz3btg;
	Wed, 29 Oct 2025 03:20:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761668422;
	cv=none; b=o0NPq9tLFp9q/eRpi47KSgB5wdk/lIbjVhWqAQvBZllBUuLHCMx3JRYIwIUogOOBsYXnPSci+02db9v3XU+bCA70yPdIOMtNdpIGtKzcb3nFpIs5AO1R7oq+6s579Ko1z6d5Ke/GmNEohcLLk4kSLQ4nrj9gjTb4RuR3qRUcPyGJOk5dm1e6/xGtT+QU0V+mh25A39Se+WSnV9kgK7Yry9BRTZGxoewFThg/461yqooAOms2siibTkJQvUN7EHgXDw5uW5+SmsZcBHppMVBlQ1hJcgp+++rMr9SwVOCyxak9caIBlRJP2pRiuVDBdq/3/lEYmhZnXeBo9faJxAt6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761668422; c=relaxed/relaxed;
	bh=pSosvxi5dPFtdhC5U0/TTS2WAyGF8TeP5oXRsKZhx7U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOlQTzVm7D22OL+qSRnjWPjKqch4CkLSYe4VvisWrkaPOQjEzDGWhsCTDWaaLcQ/K9c+RVf8PNDsCfjFaITbXQJEfg1f4jgy4B/u6WI23Al3OORdNuKPweiQBepI9a9Oi/JWcAQU/W1bbT6AMZLD0E9LFHTMfqIE75n5eDkJJEVA73HXIJ2JAhlxRczxiH1f//4vilBwfNUwUedeLoo/9y28MiyO/RSAqDl2TAz2rSwXPwnGEQvhaZJDVwJrDxNnAu7Gu6J7mp27bfb+5O+yKa5q194IBslYGWNJqvmZnAxZRPzDamaq6tWXP+lFpTPqKLHEo5qbY9OkuqMSad6xIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KjJPEYPJ; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Gw2QrTQ4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KjJPEYPJ; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Gw2QrTQ4; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KjJPEYPJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Gw2QrTQ4;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KjJPEYPJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Gw2QrTQ4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=tiwai@suse.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 416 seconds by postgrey-1.37 at boromir; Wed, 29 Oct 2025 03:20:21 AEDT
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwwZs2PpYz2ypw
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 03:20:21 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C99BD21A64;
	Tue, 28 Oct 2025 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761667999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSosvxi5dPFtdhC5U0/TTS2WAyGF8TeP5oXRsKZhx7U=;
	b=KjJPEYPJ7HZdpBT02TjYQ61cQjBJIEBgA6xrd5hVWW6xAJANi0wiYFNW6d5v7xV2N7YmlE
	h6SetL0FQi/IqvkJSpicxJI7317JmcnGp5XrGSNF69XjHib4Xs4pSezxRpirGmBaonvMPF
	xG/ODKCnE+Q8Gml9lNP6EM6O/Lt0Fag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761667999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSosvxi5dPFtdhC5U0/TTS2WAyGF8TeP5oXRsKZhx7U=;
	b=Gw2QrTQ427yrPNuYnSYVl0sYdSQd5/RgHd0ptf3XwxfdMZudizoPqUBaiHtRb5cqG4Is5B
	5/rgTt+d8ttytfBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761667999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSosvxi5dPFtdhC5U0/TTS2WAyGF8TeP5oXRsKZhx7U=;
	b=KjJPEYPJ7HZdpBT02TjYQ61cQjBJIEBgA6xrd5hVWW6xAJANi0wiYFNW6d5v7xV2N7YmlE
	h6SetL0FQi/IqvkJSpicxJI7317JmcnGp5XrGSNF69XjHib4Xs4pSezxRpirGmBaonvMPF
	xG/ODKCnE+Q8Gml9lNP6EM6O/Lt0Fag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761667999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSosvxi5dPFtdhC5U0/TTS2WAyGF8TeP5oXRsKZhx7U=;
	b=Gw2QrTQ427yrPNuYnSYVl0sYdSQd5/RgHd0ptf3XwxfdMZudizoPqUBaiHtRb5cqG4Is5B
	5/rgTt+d8ttytfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D26E13A7D;
	Tue, 28 Oct 2025 16:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id udwmHJ7rAGmPCAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 28 Oct 2025 16:13:18 +0000
Date: Tue, 28 Oct 2025 17:13:18 +0100
Message-ID: <87o6prf1i9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,	Stephen Boyd
 <sboyd@kernel.org>,	Nicolas Ferre <nicolas.ferre@microchip.com>,	Alexandre
 Belloni <alexandre.belloni@bootlin.com>,	Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,	David Miller
 <davem@davemloft.net>,	Linus Walleij <linus.walleij@linaro.org>,	Bartosz
 Golaszewski <brgl@bgdev.pl>,	Joel Stanley <joel@jms.id.au>,	Andrew Jeffery
 <andrew@codeconstruct.com.au>,	Crt Mori <cmo@melexis.com>,	Jonathan Cameron
 <jic23@kernel.org>,	Lars-Peter Clausen <lars@metafoo.de>,	Jacky Huang
 <ychuang3@nuvoton.com>,	Shan-Chun Hung <schung@nuvoton.com>,	Yury Norov
 <yury.norov@gmail.com>,	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Johannes
 Berg <johannes@sipsolutions.net>,	Jakub Kicinski <kuba@kernel.org>,	Alex
 Elder <elder@ieee.org>,	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,	Jason Baron
 <jbaron@akamai.com>,	Borislav Petkov <bp@alien8.de>,	Tony Luck
 <tony.luck@intel.com>,	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,	David Lechner
 <dlechner@baylibre.com>,	Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,	Richard Genoud
 <richard.genoud@bootlin.com>,	Cosmin Tanislav <demonsingur@gmail.com>,	Biju
 Das <biju.das.jz@bp.renesas.com>,	Jianping Shen
 <Jianping.Shen@de.bosch.com>,	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,	linux-renesas-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,	linux-edac@vger.kernel.org,
	qat-linux@intel.com,	linux-gpio@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,	linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org,	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/23] ALSA: usb-audio: #undef field_{get,prep}() before local definition
In-Reply-To: <8f19d783dd783df5510408ffe9664dc6ef0d9434.1761588465.git.geert+renesas@glider.be>
References: <cover.1761588465.git.geert+renesas@glider.be>
	<8f19d783dd783df5510408ffe9664dc6ef0d9434.1761588465.git.geert+renesas@glider.be>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
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
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[renesas];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,wanadoo.fr];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,microchip.com,bootlin.com,tuxon.dev,intel.com,gondor.apana.org.au,davemloft.net,linaro.org,bgdev.pl,jms.id.au,codeconstruct.com.au,melexis.com,metafoo.de,nuvoton.com,gmail.com,rasmusvillemoes.dk,perex.cz,suse.com,sipsolutions.net,ieee.org,wanadoo.fr,akamai.com,alien8.de,analog.com,bp.renesas.com,de.bosch.com,vger.kernel.org,lists.infradead.org,lists.ozlabs.org];
	R_RATELIMIT(0.00)[to_ip_from(RLr5uiezb5xkkwytzfr8x566qh)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]

On Mon, 27 Oct 2025 19:41:43 +0100,
Geert Uytterhoeven wrote:
> 
> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> --
> v5:
>   - New.
> ---
>  sound/usb/mixer_quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
> index 828af3095b86ee0a..713a8498b975e1ac 100644
> --- a/sound/usb/mixer_quirks.c
> +++ b/sound/usb/mixer_quirks.c
> @@ -3312,7 +3312,9 @@ static int snd_bbfpro_controls_create(struct usb_mixer_interface *mixer)
>  #define RME_DIGIFACE_INVERT BIT(31)
>  
>  /* Nonconst helpers */
> +#undef field_get
>  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#undef field_prep
>  #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
>  
>  static int snd_rme_digiface_write_reg(struct snd_kcontrol *kcontrol, int item, u16 mask, u16 val)

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

