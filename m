Return-Path: <linux-aspeed+bounces-2507-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4EFCCD199
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 17:39:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cpBsV4BwYz3cYG;
	Sat, 18 Oct 2025 04:39:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760722782;
	cv=none; b=UzrmmGaOaWMN596q3p0vVCMkb/6W5ZF0xZE64pVYTN4vlLMiSstZUX/KUK7QaoR9qwiEimqLvA5kqpRVopuP7LLlKlqjS/0TrR+NLVLXvNSajvGFnEsWbVDz+VCXt44SZMj+ffmwcQKb7uavU6VA+wefwIdx958EM9wqq49JAsD1toYpi0spctNO+fZHxwP45ATfk81ahHHT8D03tU46FGnF9453kU7iGjAPnyCxfj1RV7b8SEow2NKfSYtLoAbeK5UCqOv99HgOZNtNrCa+fXyCK4SHpzDAEJ4rrEvwGnu2qahDjgEs1Yo10esLjNYEnC4HEw0eVVbLaNybkbbakw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760722782; c=relaxed/relaxed;
	bh=Q1DqJ+UvWcL6yl4Znr/vtGBkqWTaoUBpv2+WrnPtteY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxmXKhHL9Qcq6U5InlTOqpYswxRiAwSChLaEKXF48pOOaeM0RgMv137SJoNq6Jab6GK6eR+RKoMQT0o/2G5RnRxKLeyriykDysc7Ine1Z3EdX9LVinDEyfunH2Lta+Efl9S+wEuESEIJx1IH1d7SdBrW79N+GP4jGwHwB3zov2Lf5oF8ycjIngjb91fn62MV3LVE/Vaip1s36sJdYn1CF2AafP2K1hDywy7ebNqv9V+xPxtleYyqrLupIwP0Tvj0+dZ21o169iA60s7nO42/2pxYrHDU+Emo9eaPf8NO79fhzia+fg2Go3qVvp6Sfcynsi6Nuqe94Zr92g5D+xdZkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NT0kk5AT; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NT0kk5AT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cpBsT3zgNz3bvd
	for <linux-aspeed@lists.ozlabs.org>; Sat, 18 Oct 2025 04:39:41 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1DD0D435DD;
	Fri, 17 Oct 2025 17:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD47C4CEE7;
	Fri, 17 Oct 2025 17:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760722779;
	bh=RLpFlKj0oX6F2FHmvB6odL7qjqFC0HmExWxoVhIdU1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NT0kk5AT8tFG1ex9SS8EUtqaH3MN+k/hRFCGSaqU55hscTm9YrecMaHll0u79zNw6
	 sIBNy7OA9YnQH8zcWJvaMly7J6UxVErlApIMtWqqtxuCay5hHv3uxPVR74IQZH7Eo7
	 POgxmUZCozpR5oUMwioI8150ALcQrPO9kadHLQDIRlSHNVEt+zPMCklNd1E0+Dvk0M
	 FLUc8epgBZ5fXzgVrxCcc2oNTqFhlAuQ56P5auW6pS+BXbjn0jHuPDkH8FdSsJSL4W
	 uFicrrFA5Ph3zrKxR/crhBXdSf97NMqd7lwWACFyVrsYLycFeAVJesTkco7Sb8QbzJ
	 h9rvU97EVVwQg==
Date: Fri, 17 Oct 2025 10:39:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Miller
 <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>, David Laight
 <david.laight.linux@gmail.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH treewide v3 2/4] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <20251017103936.49fbafdd@kernel.org>
In-Reply-To: <CAMuHMdVS5KmVkv_pmc+R-EXik-Z1_7nuiHM=vm1Cu8v91wmLBQ@mail.gmail.com>
References: <cover.1739540679.git.geert+renesas@glider.be>
	<2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
	<20251017081912.2ad26705@kernel.org>
	<CAMuHMdVS5KmVkv_pmc+R-EXik-Z1_7nuiHM=vm1Cu8v91wmLBQ@mail.gmail.com>
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

On Fri, 17 Oct 2025 18:00:41 +0200 Geert Uytterhoeven wrote:
> > +/**
> > + * u32_encode_bits() - prepare a u32 bitfield element (non-const)
> > + * @v: value to put in the field
> > + * @field: shifted mask defining the field's length and position
> > + *
> > + * Equivalent of FIELD_PREP() for u32, field does not have to be constant.
> > + *
> > + * Note that the helper is available for other field widths (generated below).
> > + */
> > +static __always_inline __u32 u32_encode_bits(u32 v, u32 field)
> > +{
> > +       if (__builtin_constant_p(v) && (v & ~field_mask(field)))
> > +               __field_overflow();
> > +       return ((v & field_mask(field)) * field_multiplier(field));  
> 
> Unfortunately gcc emits actual divisions or __*div*() calls, and
> multiplications in the non-constant case.
> 
> So I don't think this is suitable as-is.

Sorry I missed or forgot that you replied :(

The inline helpers exist already have have a lot of uses. If __ffs is
more optimal then why not make existing helpers use it as well? 
It'd be far more beneficial:

$ git grep u32_encode_bits | wc -l
391

Sorry if I'm being slow..

