Return-Path: <linux-aspeed+bounces-2503-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08156CCD195
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 12:32:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cp43V4Sglz3cYx;
	Fri, 17 Oct 2025 23:32:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760704374;
	cv=none; b=U2AVTUgpgK7d7AMzizuabv69J+PIzlOwzLwRcrQMXTZDKaqr6aWcYBvnWQHTf/k3gWkSZpgcrGrAryQquIN8hrLBkZgMfzwOU+HncIXc3OGu9t5tVNJfFEwD+jZsc28na8iznHCGBdjdwh4rUlGSgs/nhhTIs+UEGNdhK0xZdRkA5a2HK1Iyh5pqs3JMHbg/QB/sy2Be89pQVKhBxMeG5zVWKXk1WMGFoeI39/F/2FuJbTlJcyEBq0zVKTVuidADmXgbqaJLdKU1JskdaS34gB04Tzvj1KLX3OCIbkilbuZjMRx52sHZ/Lh+HCOowp2mZTD1Xm8tk23g1+O1k2VA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760704374; c=relaxed/relaxed;
	bh=4lviR4y4KLE3n7RRy47fCgv6ELqJOqJ04I0KWYPDO7E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oC/s2FYSodxpSB+QwdJQszmPhNx6VQuywOF/PWbkwHu6uH2Gh/9zVfqYHCXjAPfRHHifU/tmuLRt3ZEmhM4EwraxaT/0Gt8R8GCS3L/LlxeQ9U24orrCCudJhR/HvU/i7oM0j4WJt7Se4OcAuLNRNioE88MmAxretAj0vBIqTlS0++OCjnr12PCnSgLPzEWK4ikxd+ibu7fK/ppUSHu1uJA0jfXQpgWT2DA5NLkIprXHfK1WdcPHxxShclWn6Z5rp52lhCawdZmsi4qdinrnfBiMA6mo7qR+pAT8fW81/h5M/tdMtkq7lYwT2EaPMoFDXn1nFP5Svt3UklVqdB5TUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=E5Md/483; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=noname.nuno@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=E5Md/483;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=noname.nuno@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp43T0S5Tz3cYg
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 23:32:52 +1100 (AEDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4710665e7deso8962895e9.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 05:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760704369; x=1761309169; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4lviR4y4KLE3n7RRy47fCgv6ELqJOqJ04I0KWYPDO7E=;
        b=E5Md/483pBf3eqD3RcXed1jMyKmdvkOg2UhEpDTntx1cpfCmkLP6ECSyLVc2pokgK6
         YmOSY/TuhjVcLGrr3LHF+RuSJYe05rqW/mQO08yBrAlSn13mUI7cISNlKQnnnm0hWsha
         XHDQ/ELGhjf/1B4Nycahg2+qQ7bsmoptSetSFiqICaMxwCiiqagG58w6jIJHtti+OQtR
         B4fZQdIaTD0OwG9yl23KAuM0IWL7Hzcf8jpewi7PZkHGl0J6OdyH/DFtDjmYIphw2v1s
         7rFq7O+25t/aKvvcXJIiWwHSJLf7ndBHJrlN0bWMxEoEk6n10Sk6vPPwUP1j11MzW5k9
         8BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760704369; x=1761309169;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4lviR4y4KLE3n7RRy47fCgv6ELqJOqJ04I0KWYPDO7E=;
        b=cLCowq4vOa7oAwoYvNscTxGyvyNzUztWl6Uh/Sa0/oI3aCyt4RKgdv5VZIEowVD8T1
         1IdYNfMEf1t0VIp0C7A09EGHADgcXs0B9jpmKLPbhYKDP2Em43VQUyCSxCSaLbKTqTw/
         4fXwEx1ScGaRP1j1bFzZOJw3cbmUGlsKD40//wz69KZ+L7SUSxdF6+2jil1Z5pDHlcMz
         T5nRmLncn5D/UIsDuB4zZThMEyabgbd7VDq7zR8OoSvElpzY7OTaCiPAIg2V6RnO1KNv
         e+fQ6/rjOyDgqxG5KQkFe3FdbWUc6M/zowVRwUlO13j2wOOGwpBEy9rNIs2JWbUl3I/H
         U6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVNk6RXCjTFvNFpA/UH32fnSBxzwqJazh7GE1ECtmGfWZthY1nUiPz2sSWifKlXtkgjB5B+xo99VAaKOWk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyBQ17hV2FsUHbQoi8MFEfzueYu7A0w1kxPp8WhRA6zSqfOjLa8
	TkYfjUANS2SD245WIhbtSzlcSSRNaKjiNzm1jlUY8rtu1iPEuuTstfaN
X-Gm-Gg: ASbGnctmn8PK6colw0dEjjBLP7n05hegrV595kG5bC73zdYNFKuRGw+mWZjlMal+SGd
	oQSs16mrw8a7mpXsXRVEtS/dL5gL1GyeV4+ACs3Q4Sp6IXlbRcoEJjxB0/0II1Pj36PEPmVC8cF
	zdgEKPL13LgERKKU7AzvalM7Ne27/dCx0WLiqJmTBiklu1A8+DWY+CgIOKsWKL/P3CB8MQYiFxF
	gv4eGE3hxY3+LQFu/JJX060jNzVeLjXQa237WNkV127kX8H7ZGmgZenG6TuFUfP4DZZGkGyXAPs
	rKTU6bZ9jjwQ9UFLdYfhjCEemPSAftbPXgfyJEl1SFkvxYiILw6wgK6G+npDIjSdlZ/rfsxlngk
	0fh9klfykXQfqepDlMNGnnbXmP243HF3TXFxYcwO4oLAsmE0bq1f+J86sMBymoDM1jChjHrN5sY
	IipWM=
X-Google-Smtp-Source: AGHT+IE4Z4uZhoJlnHZ4fZWGzVqlXcJ3VtJT0uS7DlsTcLhos7f+a2+qMfmhSL+PiYtMShO/dK+2CQ==
X-Received: by 2002:a05:600c:548c:b0:468:9e79:bee0 with SMTP id 5b1f17b1804b1-471177bc126mr27325425e9.0.1760704368843;
        Fri, 17 Oct 2025 05:32:48 -0700 (PDT)
Received: from [10.5.0.2] ([195.158.248.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4270539be85sm5263938f8f.7.2025.10.17.05.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 05:32:48 -0700 (PDT)
Message-ID: <f2b879d3e8120c7aeb0e6c9a5fd45b15a2b8e5a0.camel@gmail.com>
Subject: Re: [PATCH v4 2/4] bitfield: Add non-constant field_{prep,get}()
 helpers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette	
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre	
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu	 <herbert@gondor.apana.org.au>, David Miller
 <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Joel Stanley	 <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori	 <cmo@melexis.com>, Jonathan
 Cameron <jic23@kernel.org>, Lars-Peter Clausen	 <lars@metafoo.de>, Jacky
 Huang <ychuang3@nuvoton.com>, Shan-Chun Hung	 <schung@nuvoton.com>, Yury
 Norov <yury.norov@gmail.com>, Rasmus Villemoes	 <linux@rasmusvillemoes.dk>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai	 <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Jakub Kicinski	 <kuba@kernel.org>, Alex
 Elder <elder@ieee.org>, David Laight	 <david.laight.linux@gmail.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,  Jason Baron
 <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
 <tony.luck@intel.com>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Kim Seer Paller <kimseer.paller@analog.com>, David Lechner	
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, 
 Andy Shevchenko	 <andy@kernel.org>, Richard Genoud
 <richard.genoud@bootlin.com>, Cosmin Tanislav	 <demonsingur@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Jianping Shen	
 <Jianping.Shen@de.bosch.com>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-edac@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, 	linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, 	linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron	
 <Jonathan.Cameron@huawei.com>
Date: Fri, 17 Oct 2025 13:33:19 +0100
In-Reply-To: <67c1998f144b3a21399672c8e4d58d3884ae2b3c.1760696560.git.geert+renesas@glider.be>
References: <cover.1760696560.git.geert+renesas@glider.be>
	 <67c1998f144b3a21399672c8e4d58d3884ae2b3c.1760696560.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
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

On Fri, 2025-10-17 at 12:54 +0200, Geert Uytterhoeven wrote:
> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.=C2=A0 However, it is very common to prepare or extract bitfiel=
d
> elements where the bitfield mask is not a compile-time constant.
>=20
> To avoid this limitation, the AT91 clock driver and several other
> drivers already have their own non-const field_{prep,get}() macros.
> Make them available for general use by consolidating them in
> <linux/bitfield.h>, and improve them slightly:
> =C2=A0 1. Avoid evaluating macro parameters more than once,
> =C2=A0 2. Replace "ffs() - 1" by "__ffs()",
> =C2=A0 3. Support 64-bit use on 32-bit architectures.
>=20
> This is deliberately not merged into the existing FIELD_{GET,PREP}()
> macros, as people expressed the desire to keep stricter variants for
> increased safety, or for performance critical paths.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Crt Mori <cmo@melexis.com>
> ---

Hopefully this gets merged soon. About time to have these variants (I do ha=
ve a
driver submitted - in review - which is adding yet another variant of this)
=20
Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> v4:
> =C2=A0 - Add Acked-by,
> =C2=A0 - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocat=
e
> =C2=A0=C2=A0=C2=A0 power management debugfs helper APIs") in v6.17-rc1,
> =C2=A0 - Convert more recently introduced upstream copies:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - drivers/edac/ie31200_edac.c
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - drivers/iio/dac/ad3530r.c
>=20
> v3:
> =C2=A0 - Add Acked-by,
> =C2=A0 - Drop underscores from macro parameters,
> =C2=A0 - Use __auto_type where possible,
> =C2=A0 - Correctly cast reg to the mask type,
> =C2=A0 - Introduces __val and __reg intermediates to simplify the actual
> =C2=A0=C2=A0=C2=A0 operation,
> =C2=A0 - Drop unneeded parentheses,
> =C2=A0 - Clarify having both FIELD_{GET,PREP}() and field_{get,prep}(),
>=20
> v2:
> =C2=A0 - Cast val resp. reg to the mask type,
> =C2=A0 - Fix 64-bit use on 32-bit architectures,
> =C2=A0 - Convert new upstream users:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - drivers/crypto/intel/qat/qat_common/adf_=
gen4_pm_debugfs.c
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - drivers/gpio/gpio-aspeed.c
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - drivers/iio/temperature/mlx90614.c
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - drivers/pinctrl/nuvoton/pinctrl-ma35.c
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - sound/usb/mixer_quirks.c
> =C2=A0 - Convert new user queued in renesas-devel for v6.15:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - drivers/soc/renesas/rz-sysc.c
> ---
> =C2=A0drivers/clk/at91/clk-peripheral.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/clk/at91/pmc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 3 --
> =C2=A0.../intel/qat/qat_common/adf_pm_dbgfs_utils.c |=C2=A0 8 +----
> =C2=A0drivers/edac/ie31200_edac.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 +--
> =C2=A0drivers/gpio/gpio-aspeed.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 5 +--
> =C2=A0drivers/iio/dac/ad3530r.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 --
> =C2=A0drivers/iio/temperature/mlx90614.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +--
> =C2=A0drivers/pinctrl/nuvoton/pinctrl-ma35.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 4 ---
> =C2=A0drivers/soc/renesas/rz-sysc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +-
> =C2=A0include/linux/bitfield.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 36 +++++++++++++++++++
> =C2=A0sound/usb/mixer_quirks.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 4 ---
> =C2=A011 files changed, 42 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-
> peripheral.c
> index e700f40fd87f9327..e7208c47268b6397 100644
> --- a/drivers/clk/at91/clk-peripheral.c
> +++ b/drivers/clk/at91/clk-peripheral.c
> @@ -3,6 +3,7 @@
> =C2=A0 *=C2=A0 Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.co=
m>
> =C2=A0 */
> =C2=A0
> +#include <linux/bitfield.h>
> =C2=A0#include <linux/bitops.h>
> =C2=A0#include <linux/clk-provider.h>
> =C2=A0#include <linux/clkdev.h>
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 5daa32c4cf2540d7..543d7aee8d248cdb 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -117,9 +117,6 @@ struct at91_clk_pms {
> =C2=A0	unsigned int parent;
> =C2=A0};
> =C2=A0
> -#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> -#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> -
> =C2=A0#define ndck(a, s) (a[s - 1].id + 1)
> =C2=A0#define nck(a) (a[ARRAY_SIZE(a) - 1].id + 1)
> =C2=A0
> diff --git a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
> b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
> index 69295a9ddf0ac92f..4ccc94ed9493a64c 100644
> --- a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
> +++ b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
> @@ -1,18 +1,12 @@
> =C2=A0// SPDX-License-Identifier: GPL-2.0-only
> =C2=A0/* Copyright(c) 2025 Intel Corporation */
> +#include <linux/bitfield.h>
> =C2=A0#include <linux/bitops.h>
> =C2=A0#include <linux/sprintf.h>
> =C2=A0#include <linux/string_helpers.h>
> =C2=A0
> =C2=A0#include "adf_pm_dbgfs_utils.h"
> =C2=A0
> -/*
> - * This is needed because a variable is used to index the mask at
> - * pm_scnprint_table(), making it not compile time constant, so the comp=
ile
> - * asserts from FIELD_GET() or u32_get_bits() won't be fulfilled.
> - */
> -#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> -
> =C2=A0#define PM_INFO_MAX_KEY_LEN	21
> =C2=A0
> =C2=A0static int pm_scnprint_table(char *buff, const struct pm_status_row=
 *table,
> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
> index 5a080ab65476dacf..dfc9a9cecd74207d 100644
> --- a/drivers/edac/ie31200_edac.c
> +++ b/drivers/edac/ie31200_edac.c
> @@ -44,6 +44,7 @@
> =C2=A0 * but lo_hi_readq() ensures that we are safe across all e3-1200 pr=
ocessors.
> =C2=A0 */
> =C2=A0
> +#include <linux/bitfield.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/pci.h>
> @@ -139,9 +140,6 @@
> =C2=A0#define IE31200_CAPID0_DDPCD		BIT(6)
> =C2=A0#define IE31200_CAPID0_ECC		BIT(1)
> =C2=A0
> -/* Non-constant mask variant of FIELD_GET() */
> -#define field_get(_mask, _reg)=C2=A0 (((_reg) & (_mask)) >> (ffs(_mask) =
- 1))
> -
> =C2=A0static int nr_channels;
> =C2=A0static struct pci_dev *mci_pdev;
> =C2=A0static int ie31200_registered =3D 1;
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 7953a9c4e36d7550..3da999334971d501 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -5,6 +5,7 @@
> =C2=A0 * Joel Stanley <joel@jms.id.au>
> =C2=A0 */
> =C2=A0
> +#include <linux/bitfield.h>
> =C2=A0#include <linux/cleanup.h>
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/gpio/aspeed.h>
> @@ -31,10 +32,6 @@
> =C2=A0#include <linux/gpio/consumer.h>
> =C2=A0#include "gpiolib.h"
> =C2=A0
> -/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> -#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
> -#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) &
> (_mask))
> -
> =C2=A0#define GPIO_G7_IRQ_STS_BASE 0x100
> =C2=A0#define GPIO_G7_IRQ_STS_OFFSET(x) (GPIO_G7_IRQ_STS_BASE + (x) * 0x4=
)
> =C2=A0#define GPIO_G7_CTRL_REG_BASE 0x180
> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> index 6134613777b8e1d4..b97b46090d808ee7 100644
> --- a/drivers/iio/dac/ad3530r.c
> +++ b/drivers/iio/dac/ad3530r.c
> @@ -53,9 +53,6 @@
> =C2=A0#define AD3530R_MAX_CHANNELS			8
> =C2=A0#define AD3531R_MAX_CHANNELS			4
> =C2=A0
> -/* Non-constant mask variant of FIELD_PREP() */
> -#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) &
> (_mask))
> -
> =C2=A0enum ad3530r_mode {
> =C2=A0	AD3530R_NORMAL_OP,
> =C2=A0	AD3530R_POWERDOWN_1K,
> diff --git a/drivers/iio/temperature/mlx90614.c
> b/drivers/iio/temperature/mlx90614.c
> index 8a44a00bfd5ece38..1ad21b73e1b44cb0 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -22,6 +22,7 @@
> =C2=A0 * the "wakeup" GPIO is not given, power management will be disable=
d.
> =C2=A0 */
> =C2=A0
> +#include <linux/bitfield.h>
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/gpio/consumer.h>
> @@ -68,10 +69,6 @@
> =C2=A0#define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 100=
0) */
> =C2=A0#define MLX90614_CONST_FIR 0x7 /* Fixed value for FIR part of low p=
ass filter
> */
> =C2=A0
> -/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> -#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
> -#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) &
> (_mask))
> -
> =C2=A0struct mlx_chip_info {
> =C2=A0	/* EEPROM offsets with 16-bit data, MSB first */
> =C2=A0	/* emissivity correction coefficient */
> diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
> b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
> index cdad01d68a37e365..8d71dc53cc1de1f8 100644
> --- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
> +++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
> @@ -81,10 +81,6 @@
> =C2=A0#define MVOLT_1800			0
> =C2=A0#define MVOLT_3300			1
> =C2=A0
> -/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> -#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
> -#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) &
> (_mask))
> -
> =C2=A0static const char * const gpio_group_name[] =3D {
> =C2=A0	"gpioa", "gpiob", "gpioc", "gpiod", "gpioe", "gpiof", "gpiog",
> =C2=A0	"gpioh", "gpioi", "gpioj", "gpiok", "gpiol", "gpiom", "gpion",
> diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.=
c
> index 9f79e299e6f41641..73eaf8b9d69f7208 100644
> --- a/drivers/soc/renesas/rz-sysc.c
> +++ b/drivers/soc/renesas/rz-sysc.c
> @@ -5,6 +5,7 @@
> =C2=A0 * Copyright (C) 2024 Renesas Electronics Corp.
> =C2=A0 */
> =C2=A0
> +#include <linux/bitfield.h>
> =C2=A0#include <linux/cleanup.h>
> =C2=A0#include <linux/io.h>
> =C2=A0#include <linux/mfd/syscon.h>
> @@ -16,8 +17,6 @@
> =C2=A0
> =C2=A0#include "rz-sysc.h"
> =C2=A0
> -#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> -
> =C2=A0/**
> =C2=A0 * struct rz_sysc - RZ SYSC private data structure
> =C2=A0 * @base: SYSC base address
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 7ff817bdae19b468..c999fe70076f6684 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -220,4 +220,40 @@ __MAKE_OP(64)
> =C2=A0#undef __MAKE_OP
> =C2=A0#undef ____MAKE_OP
> =C2=A0
> +/**
> + * field_prep() - prepare a bitfield element
> + * @mask: shifted mask defining the field's length and position
> + * @val:=C2=A0 value to put in the field
> + *
> + * field_prep() masks and shifts up the value.=C2=A0 The result should b=
e
> + * combined with other fields of the bitfield using logical OR.
> + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> + */
> +#define field_prep(mask, val)						\
> +	({								\
> +		__auto_type __mask =3D (mask);				\
> +		typeof(mask) __val =3D (val);				\
> +		unsigned int __shift =3D sizeof(mask) <=3D 4 ?		\
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __ffs(__mask) :
> __ffs64(__mask);	\
> +		(__val << __shift) & __mask;	\
> +	})
> +
> +/**
> + * field_get() - extract a bitfield element
> + * @mask: shifted mask defining the field's length and position
> + * @reg:=C2=A0 value of entire bitfield
> + *
> + * field_get() extracts the field specified by @mask from the
> + * bitfield passed in as @reg by masking and shifting it down.
> + * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
> + */
> +#define field_get(mask, reg)						\
> +	({								\
> +		__auto_type __mask =3D (mask);				\
> +		typeof(mask) __reg =3D=C2=A0 (reg);				\
> +		unsigned int __shift =3D sizeof(mask) <=3D 4 ?		\
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __ffs(__mask) :
> __ffs64(__mask);	\
> +		(__reg & __mask) >> __shift;	\
> +	})
> +
> =C2=A0#endif
> diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
> index 828af3095b86ee0a..6eee89cbc0867f2b 100644
> --- a/sound/usb/mixer_quirks.c
> +++ b/sound/usb/mixer_quirks.c
> @@ -3311,10 +3311,6 @@ static int snd_bbfpro_controls_create(struct
> usb_mixer_interface *mixer)
> =C2=A0#define RME_DIGIFACE_REGISTER(reg, mask) (((reg) << 16) | (mask))
> =C2=A0#define RME_DIGIFACE_INVERT BIT(31)
> =C2=A0
> -/* Nonconst helpers */
> -#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> -#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> -
> =C2=A0static int snd_rme_digiface_write_reg(struct snd_kcontrol *kcontrol=
, int
> item, u16 mask, u16 val)
> =C2=A0{
> =C2=A0	struct usb_mixer_elem_list *list =3D snd_kcontrol_chip(kcontrol);

