Return-Path: <linux-aspeed+bounces-2695-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB438CCF9EE
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Oct 2025 23:16:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxjmG1mfsz2yyd;
	Thu, 30 Oct 2025 10:16:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761748243;
	cv=none; b=EutuoIyDBsPMNczZb9hZ4Cs1litfDLfKHcMpAceSRsHTQyrWdnvc5+19pVgKg3t1pZP18oto8Z3UdlR/j7Pj9A0k2TWXbIxC06osYE/ntozrpL7PN4KMZ128EsEAURTX0OqfRoie8Nnb2ElQFoiF84Qx3BqZaklhx5fMYF76UATJzYynluTUhuiARUszNQ5FBrpUZ3Z9czR/Zh5p5MYohS1bmAoHK/A/ptVUGo7jTMIWKrj4JEBArrVT8mIWryREc0L11Pddlx4zS5W6hzNk/Ybf/ONf95jJszrlrIdN5MrhRswA54g4RIGZJ8lCuC8JK6WAa4SveD+rnfYWGf/Gog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761748243; c=relaxed/relaxed;
	bh=JnpQqG3KsjO8HR5ITuKL9a0uCELInljqSPlsEDY9f3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlkDL94bQj7eoIL4EYk8EVbo9Pj7guVpwwEIAeke3C8fgsBEzU7tmU9Meqv4SbSFr9X70/Z01ApFKuzhsY2y1XJzjaoOludVz55SwbuNMZ46NAk0vq6quqXsWF1uX/nxKWGnkLSuMzfIpqbcWMKqno/g8uraCYAx+0RDtq+JzPgveaPFLjU7TUwVNQaAMhJmgfF5oytfmiS+qDQWx+AOgqL8O/RC/JRWii6SGCN7jz+oUc7cxoMLONfJCXfZtriRKOsqFzUL6tADbltGPmC4FVIGBE3bFCtFnAThCIhz11alI16orSC8C20p+MPO9Nx37u85QBdaBd/UAkz3Vf8Uog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dBwIwptv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dBwIwptv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxV5s6Tf4z2yjm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Oct 2025 01:30:41 +1100 (AEDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4eba313770dso49600461cf.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761748233; x=1762353033; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JnpQqG3KsjO8HR5ITuKL9a0uCELInljqSPlsEDY9f3Y=;
        b=dBwIwptvE2fFuybgI2QaPEYzvsNWQISw5b+Xu0B5ut+JNF7Uy1+W+Q+YxqGVdVJ5UV
         i1UzCDyEzGyLahvzOVdnYK1tkKDajlRel6/ltu1Tw/YU+Z46KwhqpxSFUbYZ2BsB56sQ
         CpzVZc5XyNHlJpCU2DoEH+BlrFsFlw/XrvCSm33b2JOMjJMP1x2Fbzpy7BHVB2la/qQM
         dNS0UYc1F0J+kNWwMLz0SjiYdiOsys7gSTUjo5EALrrJlI5DcCr4J/DyxQ4b5ao6cF3Y
         BpOcfZsxvE0ldQv7hd5HtLIEb2P+WmhqYKOaEgmNERIJ6i8JUzO8HBe34lw3v2jiekDL
         6Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748233; x=1762353033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnpQqG3KsjO8HR5ITuKL9a0uCELInljqSPlsEDY9f3Y=;
        b=AaDQJTJPy4xkLZaOELayq66nFm+L+Vip9MkFemliO53sjkrKUhNpLdDu04oW9Vn5JL
         N8JmCXknpNiwpJoxy8wP0rZqa40j/Fp7+EXdPA1slOYmh78jkEs5y4P6hsKkDKGE8YSn
         24ykt/W1GQ9GjwhHYuxfeKADfeGHcHvQdUhblDdLDJjWZ4AYzsYH25rrq2BkS8Zrn4wZ
         V+f0N9PwfZlnMCYfBoLU1PW79ouy4IRHxQg9xQrUvhEPgeBd1ZMRzJMhg5iFC5xE+VHw
         5LLst3o2N7Lba0UkOD4Pltx77WGgehVhT4OoQCsgVm7W2KmTw/i8MwOQ6symjL7QNDsE
         tR9g==
X-Forwarded-Encrypted: i=1; AJvYcCUvgCGS1KYPCBFTSWsoRAuBu14x9zW2HanBI3HR06k1XAl/FfwzVh5vsG5JRXQoB4bzZ4XnFKB8Mt3xLYY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzPbWa5WP75tczqJ0vpbG243A8L8KbmPiRJSW4ospYXUC84valV
	SIjUJfiD5yOfkou2zSV6j0tah66zzawlAviDPj6KbDlp6Gd2Rp8cCqSC
X-Gm-Gg: ASbGncuKf+Wkh+RlOteFTPMVrTc0zzbcv1ZVIljTSVEiZS925uM8wMIq6HxtwxVrPIK
	bor06GfxpaAWWq5C31rdwRQFYOi8Dui/XbSKZqloi5gf5D7P3xAk96ZAQ99IuVj2UTdDUarmYFh
	Po3q8XA7iRCfjhWlRY39wvcdfD7VRdrx2XTTBFbST2J1lPZ4iRuKgpYsDYkgE5BXcplHVXj8NVd
	VnWudTqpyae4Xu8HyJOqhKNPA/K+4tobiPa0tbxbbnL8Q/fhHyKDBdvOtXLMAaDJEDWTebxP8QO
	1cDO+2nObl3IID91cijFpqueHNEQebjpw7tM/ny6Yv2/KZvv1iMbPPfZ6rilynATlDBT3tqnbyy
	9yQxYBWNs2WFc8lAhB2EC8isih/Dyp6GvZ/AGp4Pe909pZF+UbQfsAWrEJNyhjirkubOXlQha
X-Google-Smtp-Source: AGHT+IHd6ZEI/4efuxlvOLVTSJQH1JkXxxhkGirHmvwiRC9eDvjzIFKRpIZ05PrXMHCHH/Mrsnw0AA==
X-Received: by 2002:a05:622a:24a:b0:4e8:93fc:f8c9 with SMTP id d75a77b69052e-4ed15b53cd6mr36770551cf.15.1761748233098;
        Wed, 29 Oct 2025 07:30:33 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc51e3809sm96571096d6.26.2025.10.29.07.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:30:32 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:30:31 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
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
Subject: Re: [PATCH v5 07/23] pinctrl: ma35: #undef field_{get,prep}() before
 local definition
Message-ID: <aQIlB8KLhVuSqQvt@yury>
References: <cover.1761588465.git.geert+renesas@glider.be>
 <03a492c8af84a41e47b33c9a974559805d070d8d.1761588465.git.geert+renesas@glider.be>
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com>

On Wed, Oct 29, 2025 at 03:19:45PM +0100, Linus Walleij wrote:
> Hi Geert,
> 
> thanks for your patch!
> 
> On Mon, Oct 27, 2025 at 7:43 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> 
> > Prepare for the advent of globally available common field_get() and
> > field_prep() macros by undefining the symbols before defining local
> > variants.  This prevents redefinition warnings from the C preprocessor
> > when introducing the common macros later.
> >
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Do you want me to just merge this patch to the pinctrl tree or do
> you have other plans?

There's a couple nits from Andy, and also a clang W=1 warning to
address. So I think, v6 is needed.

But overlall, the series is OK, and I'd like to take it in bitmaps
branch as it's more related to bits rather than a particular
subsystem.

Thanks,
Yury

