Return-Path: <linux-aspeed+bounces-598-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9A5C02192
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Feb 2025 00:16:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YmRqd1FXKz2xy7;
	Mon,  3 Feb 2025 11:16:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738350223;
	cv=none; b=oV8Y7+pXh/f9biup03vPP0v0336IavmYrnovU3tDB70vw6vz3p64ktkpPlC4N2XoGqWYbwr5mAzTy2suN16awHlp4Ad549R7xcqufTDZ1xLIHeTW4p2NOmQYw7WUYPvBYaZu2Gl7L2zuOE8NwNbkDmG3Wipl3PfgteIr3ISKJw6obZUAqUChR/mfWXJ+ssayZhjkLs/qf+kAbU/YUw7v8/pM1mQVAaShO3Ax8vtnvyyhqOtNz2P61EmdDAPnDKL5WU5rTz1DTuSrtgEl27NWulvo2dxCXGl0aCIuJCAPcyAp1SJLCOfj7ePoXMn0hjDNEIfurR6WzQFhaCRzl1Ukzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738350223; c=relaxed/relaxed;
	bh=pglTObOFT5rBCszltvVnpJmzw8D/oeXug/disPOkEu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBbhvKGA4EZiP7fL6llvgfMRUK94SheN43W2+nxHc18zylfuH0EqcMZpwxwyCZtH+Cd+bM2kb7HYOtNKszUBXyk9W7MZl3hrpwKAKQDyTERWn8Vza6L/IpPxBXfs2TvDQFkZPJHp8Vu57M1qGlwrwMO5AAASMRy2M9+shL7y0yQHV+v9BuNC782v47Y3qF7wdMtraCDen09rk1ncvRWhYvySxEP87ImAmgJmPZvR9d9hifijCmIMoVDzlx5bgG5VAZhkthUI5HmPKoKggOwGHfSnpCaU3Q6LvbGR+9nHt917/eMbv/h5U/OX5+C0vk5gCS+x095BDmy2CYa5DN44Pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hg0PWHzn; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hg0PWHzn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yl4zx4gdWz30Tc
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Feb 2025 06:03:41 +1100 (AEDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-38be3bfb045so2387099f8f.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 31 Jan 2025 11:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738350217; x=1738955017; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pglTObOFT5rBCszltvVnpJmzw8D/oeXug/disPOkEu0=;
        b=hg0PWHznalKDQI4YgcfQf0YZ8RJQDOFdsa6FHG7oCw1FD56KqHNkKnyGShlF/efTS0
         sBOe927PfoCVyqx1lJncCFtsHecUDv9DgijJJaBOlzi75vXS0P0Hvcam4wm5jAKkeNBu
         wbr/Y4K7obK8Lh01mS+bvylMW1/ek+/QjESjFdAOwPqf8JlCNVrPrq/AYdh5bDIUNoc7
         98vlX/F3+seYF0DMuvPT/I+nuUKExW+S42f8K7bDWU0I4Jo8r9cysoTu+Xlr7e4LJzyQ
         VpkC7hxqnIM2NFPpgIjYgKsLp9wUVlZ5Sn5zTkKZt0koQw5GNwKuh593tibAcU/FCCnF
         Hh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738350217; x=1738955017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pglTObOFT5rBCszltvVnpJmzw8D/oeXug/disPOkEu0=;
        b=roqV06R6oyuU/VjMCE86xxBDz27GeFPM/D3MAWl4xaFKDojbtwjzsfbdtZMlu0k3tX
         hcP2eog+aEeyROtQRiGW4+msJ3S6dyaalavfD1BWkvpKkl4SRtAjrvVtN9l38L9SFnTZ
         kHeuxH5+jLL4oXoSu4nE/w0FVL5GRXwOXhuv8SU8CS4ctmye0+AjRGxKXJ6lDfomHL7c
         PkZDzBlxA/KCDw6AFL6HW9DTHqA3lEHbAWlI67yXJb4CwCg4NZcmrO4XIXvgAij4vwCO
         dcHUbxW9qHWxkpNp3MoHPn90Bnwrn0WM28VTxHeyxpMQdws0YEXttwc0mo1XLi4wPf05
         PzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5G4vmRYGe+WNNOARMEt1We1A5IQHEOgRUcBBERUPDI+pnVwuU3VciKHaJh4VAFoKqjOR1XxSDNvGwNgU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyd0P8HRdPQmbB7lregT058+sBLsHaoGiosfM891SE9IMPZxjxv
	mO07InWi3Sy5c0H2qJyO08B3SOikpVL9LgOv3Otd+eAN6A7Zy86D
X-Gm-Gg: ASbGncuZbFLsqkyN3wd9td6b4BQjz0eb9rJZKPLZ7iFV4nsCMSD4m+9b0HwSlDRT+Qu
	S4fdNbCpdOFM5qsoQWgeaLGHFGTqstBdcT3AGBCIhTUqHLk7StxBBd0Ob2I2efeEOqBiAJIMt4j
	4Mycq97AQa6Ln8VaPnaq/Gd6C20d36kXMg1O3kuKZpfHLbvD5LP5Dj1aBwYON7I5hDwIuWHuhon
	BILytbCx0yN/W0zB0TpTA9nCn5KrMf77zhZ0ySJqxY5QIrgWRQhPkyX0atma5HUtTWLTsGHlGVy
	yskAApkqcEJqvpY67zyuJj77PvdrAn+VMhgAZqYXUh3QGtzdqHa5YQ==
X-Google-Smtp-Source: AGHT+IGOWalHkw0VQDuZrFgGWdO/5t7oYMe9eAr7RV/AmNQsKEb7LjEGNkj8XpJngRC9CG3jrtAtQg==
X-Received: by 2002:a5d:5f56:0:b0:386:3d27:b4f0 with SMTP id ffacd0b85a97d-38c60f26459mr3846706f8f.14.1738350217335;
        Fri, 31 Jan 2025 11:03:37 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e23d444bsm64691365e9.8.2025.01.31.11.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:03:36 -0800 (PST)
Date: Fri, 31 Jan 2025 19:03:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
 <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex
 Elder <elder@ieee.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <20250131190335.4c18fb3c@pumpkin>
In-Reply-To: <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
References: <cover.1738329458.git.geert+renesas@glider.be>
	<1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jan 2025 14:46:51 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.  However, it is very common to prepare or extract bitfield
> elements where the bitfield mask is not a compile-time constant.
> 
> To avoid this limitation, the AT91 clock driver and several other
> drivers already have their own non-const field_{prep,get}() macros.
> Make them available for general use by consolidating them in
> <linux/bitfield.h>, and improve them slightly:
>   1. Avoid evaluating macro parameters more than once,
>   2. Replace "ffs() - 1" by "__ffs()",
>   3. Support 64-bit use on 32-bit architectures.
...
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 63928f1732230700..c62324a9fcc81241 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -203,4 +203,38 @@ __MAKE_OP(64)
>  #undef __MAKE_OP
>  #undef ____MAKE_OP
>  
> +/**
> + * field_prep() - prepare a bitfield element
> + * @_mask: shifted mask defining the field's length and position
> + * @_val:  value to put in the field
> + *
> + * field_prep() masks and shifts up the value.  The result should be
> + * combined with other fields of the bitfield using logical OR.
> + * Unlike FIELD_PREP(), @_mask is not limited to a compile-time constant.
> + */
> +#define field_prep(_mask, _val)						\

You don't need an _ prefix on the 'parameters' - it doesn't gain anything.

> +	({								\
> +		typeof(_mask) __mask = (_mask);				\

Use: __auto_type __mask = (_mask);

> +		unsigned int __shift = sizeof(_mask) <= 4 ?		\
> +				       __ffs(__mask) : __ffs64(__mask);	\
> +		(((typeof(_mask))(_val) << __shift) & (__mask));	\

There are a lot of () in that line, perhaps:

		__auto_type(__mask) = (_mask);
		typeof (__mask) __val = (_val);
		unsigned int __shift = ...;

		(__val << __shift) & __mask;

Note the typeof (__mask) - avoids line-length 'bloat' when the arguments are non-trivial.

	David

