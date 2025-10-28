Return-Path: <linux-aspeed+bounces-2672-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A632CCF9E0
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Oct 2025 14:20:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwswh12zLz304x;
	Wed, 29 Oct 2025 01:20:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::22c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761661236;
	cv=none; b=ETtq1eqyjnPt5aJ4+Y1cFQxl8eOc/eOB1kut0i+5RTV/0cy6zu+QSt43n69k80ajployOMOv+ZuXBx3XZFxqZLyfplVlsmPzC39rJgzb0Gb0UKCcRuUsAdB9Lmv6ADQYm3lsktmYI0iTt8k7O4b58Ev+aUwxtvRcMyVtISfyfPdA5PtM6dvTo1AxVHNLjOsFkWu1mH86kQ/Tukwqy0cHcJ/luZJu2YBacDSFER8Lgao7xQVaYWD9p3j7PIqRpQFgQVqWpe2EUd90VEGNg5gngQ1jH/QJMW0dpsaQ/+bNCC8rHZsBKZ5uh7OVpoqcFT9osoiiNfT8vBhU3r4nwhhrQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761661236; c=relaxed/relaxed;
	bh=sOmSiTMyA8cqAorOzkSzQ5xujNoDEMVqXsbHnkkNM1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHcflTnkgaROADLZfwxbDFViICBJ01Nd/P+9ubi77FcLhujHESal2pO5r0wZKbtJYMa6qHzkp5F3uOPc2iuWzm9Jce6eMWAIRYTHIe/xC8G7snMDgCeLlXf+1YY+pSld5YNZ+w8RuUYpY42nOs/7CQCWQZ9msTj/shelZQtrGBKoTOvwVrXmOnQyWANqnm6fElKewAk7Ly7fw8wN8FZT2iXHXqbPQl9izNabMe6t4Eyl3O4CT5Gn15UQHPNdauCfwinZUnCITrt353aS+g3rkyMp90uY/FgGj8ESERq8/a0jjSHYsr8vy/8RL6U3yDBCte4wku3fWtIQ+EoNKvh/Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=VNyVdBha; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::22c; helo=mail-lj1-x22c.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=VNyVdBha;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::22c; helo=mail-lj1-x22c.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwswd3tjDz2xS2
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 01:20:31 +1100 (AEDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-376466f1280so90823261fa.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Oct 2025 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761661227; x=1762266027; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOmSiTMyA8cqAorOzkSzQ5xujNoDEMVqXsbHnkkNM1c=;
        b=VNyVdBhad0ZQOTC4+XfgwTE2NSlbvzP5IH8IloTm9CPVgYcE66PqBhGSyyygXC9pmx
         sQjC7LKrrT6FUhT4c+Tin6K8K2tjF+8C25qvhgcEqhA69L6WRQOZ7ILifL5dsMLUf/9t
         gLnwKkVakmLmYuph+0/CN259o22fFV7fCiIYoFjiONohyZ5v2Q3GpOL5IYRUcfAP2zKv
         09X5CbXwy8R3fH2vYm7vACEDe+uk3865zu87lnk8xJkqDgJ8uogZRrxNDlqchUInsKXH
         TqyzBuigz5zK5rWEsakGapHyC+n7GxFtXvh7IqbDrVGpTPVZ+6h7ESrafxPETmw3Heyt
         mEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761661227; x=1762266027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOmSiTMyA8cqAorOzkSzQ5xujNoDEMVqXsbHnkkNM1c=;
        b=s2jKyA02EdZcR+j3rLTZ9BBGoRy4vsWO2OKT08EPfT6TWkdm6VLtCqrDhIdCKgqQT4
         H37DE91KlfZaf6TNAm4OKBGszOxn41QT+eqN8zjD2U6ceh2aiKLfdVO/Pa5QHfD4+Gp/
         w7sY4ySHkVf4FowBzfnhxO528Uk3d96s4E9L7R0fN5diWbv/aHN2950eV5xiwUuJPIou
         7Y4mgHe9JdfhfWJnUfEX91xYDtIBnotlPhy8btqS+CsxV/+6k9RnudASvjnfgoIWW8F/
         +MxqL6q6rMxNXwEw2/ga7cbljMGsUBvmSMmDSEKType1itF/eRX68FUrurBaxKQoL4Tf
         lUrg==
X-Forwarded-Encrypted: i=1; AJvYcCWwpwawonHGP908TOQkN5833tCok1fJBZWmo2q3y/ZJX2EovcktM0K/UnkKXzS7mpP+2L04CRPJ/FqeOGc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwFvn/oq1jKhhrAkenXrV3F4hmxcxGiVZIulcUadmbYIE0zwwlb
	K3o/T8qZ8dDayw5oeyCRAr4iYWmDhkg9WiiuLuisEjjCCgp9czbJc27w1q6hO7l4fyZUYlhsKZA
	rN/81gEeEOrPIZKGgzIB/4c7At8sz95LAh/phFBWCqw==
X-Gm-Gg: ASbGnctnDpFAzbe8NiNufPzVXlgk9ZdMjb77PhC8O5O6SdCNy2mP+HvQcw6CCBemUuE
	vjkte3vrEClSgDbpbs25MXWHOw3VN3AOZS8freY0NJdepQF3nU7miKgSN4s3bkEJg61/iKioA6f
	yP+Gou+7clCfRbIgXt3LBDopVY46At1oJDcLpieM28hmpMv1kVlUadQ+DOtQ9kbVbXQ4DtkJc06
	OxnA0c+nRDOG/h1ejmKTAMDw/UvJhsncPbG3MQ8LLlvv9CcK9WEl8rmK0CMgBDOaXoPbOntQgoe
	n6ats2CTFEsujZRU1ecdKLl2qzo=
X-Google-Smtp-Source: AGHT+IEa9/49xzFtkrl2WuFSbF2nGR0Ee3sa2JYGGK47IcVnnhS7gaKd3pqPtDHg3v3/2iaUnvbb9dKc2W6cTL8KA/s=
X-Received: by 2002:a05:651c:2354:10b0:351:62e3:95d6 with SMTP id
 38308e7fff4ca-3790773c607mr10303011fa.28.1761661226962; Tue, 28 Oct 2025
 07:20:26 -0700 (PDT)
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
References: <cover.1761588465.git.geert+renesas@glider.be> <76ac5587c5ff3aae3c23f7b41e2f3eacb32ebd21.1761588465.git.geert+renesas@glider.be>
In-Reply-To: <76ac5587c5ff3aae3c23f7b41e2f3eacb32ebd21.1761588465.git.geert+renesas@glider.be>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 Oct 2025 15:20:13 +0100
X-Gm-Features: AWmQ_bkGEmC8OCwW4QksGegCfgNPPWl_EjVB0knvBjv-hfBoqYq6hENcwtWJ0QE
Message-ID: <CAMRc=MdcH-56_cJ7oDUhHRsJRnDqbss5ET-3yGrBffGmEK_ieQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/23] gpio: aspeed: #undef field_{get,prep}() before
 local definition
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Kim Seer Paller <kimseer.paller@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Jianping Shen <Jianping.Shen@de.bosch.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 7:42=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
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
>  drivers/gpio/gpio-aspeed.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 7953a9c4e36d7550..ef4ccaf74a5b379e 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -32,7 +32,9 @@
>  #include "gpiolib.h"
>
>  /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> +#undef field_get
>  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#undef field_prep
>  #define field_prep(_mask, _val)        (((_val) << (ffs(_mask) - 1)) & (=
_mask))
>
>  #define GPIO_G7_IRQ_STS_BASE 0x100
> --
> 2.43.0
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

