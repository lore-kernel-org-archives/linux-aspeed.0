Return-Path: <linux-aspeed+bounces-2513-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB12CCD184
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 23:51:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cpM6406hJz3cZ0;
	Sat, 18 Oct 2025 10:51:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760719039;
	cv=none; b=kbWla6b+/j3BEeXXrddSkDYgaeX67fH2R/iPyoCff2B5V8Yse4mDnRoon1/gsgcqAJJVD6YHv3Jr7SZ6sqfpsQGkTzGtG7GoGi6sYmw0VYfN4uGcREruRiW9m7xD/Y/yr+nBoo6/WTLR25YGAdtx4Zdkc8WSOWZApwTVKvYIHngE/Ukp9eY485LUZjJ3jUVUPOV+f+KokZ6o1WXHzv88QuRz+HMwg80UjBNO1lH2lL1E6OJwQ8wp5VPv2ewSJXawFq1wDzGj7fZ5GslQAJB8SRvAE7wTiw1bsmBhFGJQGE0lwkWe1BhI4TlyeUUcWPCWN/DBaOzWBGBGg4xLxny5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760719039; c=relaxed/relaxed;
	bh=lZqTIsgME323ZkO31yyQWUQxJPAMGciP0ot1SYinmXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYaUsrDq9RtCtJp5VYVpKVuWMuYyAmEVcID3lHg98GYh666X030PH1GSVfBaHz7Rf9ZTtN/7Jlufyyz97wftaBZF0IV5KwRawNkhLDG5K5bhUcUM5Sa8WkO3lTCLTsmYHFmb508HNWvZv+/jwm4zGB4fX0FFl4ODfBnwTjQnc+kXpw2TeJS3pAh2bKvk38AjbPyfYjEiWRzRicFuz+AoiV15e6zqKSI917mMyeK+9aqZHiOSe77eEoyWMpg5mwiRmwo0OhGyJMU8rQSs+ekXkeV+A3RZXZlPcFl42tIM3Ghf7G/nRxllcMzYjmCSMhovvn+rRfwNpS1iT8bakWqCAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=m7SdnzFA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=m7SdnzFA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp9TT2fTTz3cYP
	for <linux-aspeed@lists.ozlabs.org>; Sat, 18 Oct 2025 03:37:16 +1100 (AEDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-81efcad9c90so38179986d6.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760719032; x=1761323832; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZqTIsgME323ZkO31yyQWUQxJPAMGciP0ot1SYinmXM=;
        b=m7SdnzFAIG1GQpCKDs2bQHeOX2mZARu7bRndSjJxrPaYR2EvsJvPw6/65Yek1/xzqC
         eA6XCdIKmlN0BC1KqiULawqCiI9/1818l9C9H8f/0kWTPz4vQeZNL+SFRq4EoEdixO1+
         8QGx1X0moQOktezHB3Pvrd7jZJZA+nl/GYqtSipL8S6FDj711XnogIQn0sIIgO2ndSVi
         BYp8kcWiSHW4qXXVweldadoxyscuTkDqjtUilmoK/bPFHYGsmymYXSNo1FYC28XwJkBF
         O5YZJd+fmHJs+mlRaXu4ec5wPWxgpnwEHaJC0wWbytUKUI9gogrVTowiQ2JYh3wkVjrM
         Q1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719032; x=1761323832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZqTIsgME323ZkO31yyQWUQxJPAMGciP0ot1SYinmXM=;
        b=Tw/lqVOJNs0kmfhwl6aGLTZMyPgPH8Hm12xVtUxrtnuMIA+q3kHSQc17X+Sc7d+yd6
         vYNxvR4PDfv0JRhFy1MEwUSnuPX8SFEb8De/Gv6diDja0G6VDeIG+YhXVntThu0DIFVx
         geVMCrqBiTlX17tJXve3wf9K1QSNUXGt2lRNnjvloY8lqHvzpXCKRKPIUbOnZho1kNLe
         V2OFI6SGavbzW/XFze2+lgIqiWNe5em5kYSCjIkLTlc0hA/H0kj++/I0Wgsc7SDuGyI/
         lc0XcD2kx4q1KlIuRYQyBo1vqVzB3EPjUUA54kyTfOKivlfPaHS36EQQdmJeRndYU+Td
         g21w==
X-Forwarded-Encrypted: i=1; AJvYcCXX2E/B9Ja8eXy9818u5NatthSQPq0iVQxGeXSwjAtBq6X6+cfwWPVrFy+AzSNlR/W19QMfYBI4ZY+GXBc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxiJMO9HyLQCnszL84o+7y1Vn1IxutcKpAtoe58th1GROD5f/iY
	72YM/y2lC7sBDRwRYXddjkGJzEKca7cJz2ImK70ptB4YiU6jbclEjpGz
X-Gm-Gg: ASbGncv8UzLjKilgHVm8ek2ryYLGN7DEbAaCeBZkX/fRRTGm+No/b17aoNo0z/oAl6j
	FnHvKj7rJySoivNxP49CfYGVFjrSfhknJqbMCag4/OL615EVQ7U3VCESH01gMW0Q+3eMI7v1b9P
	SyfSI+hx7fSVUAbuyIy6T1zxj26Noy593JQrME+s75tf7MsyjYMXtTqE5c8e/RLMR7sR082EAnS
	qPWfVyR0Esqjtx+ihKdw5Z4/sjl96OJuxQgw8IfO+COA1DY3Vk3Xv7WjRu3LN4823n88INnNfLw
	dFMTRJSTP4UZgqiAnFl9qGt5uswU4TNLV2pV25+BwOjTetierOcAFBNryCNkDt1civMLSHirrfB
	6PXSsWMzsEn1KCivjf39raIgrPyR/9n2z5bSVkaKww7tVzlot8PXOJBqtr6cEEuyQ/EzFSHtNpD
	Y3BUOFOKs=
X-Google-Smtp-Source: AGHT+IEBLNSjsT2f6SbTw5aTPGakjHLdlQrL5hue+DxfPG8mzc3zrpMssrggDkT+31HrLygOdkrpIg==
X-Received: by 2002:ad4:594b:0:b0:87c:2920:5730 with SMTP id 6a1803df08f44-87c29205b08mr24398926d6.40.1760719031704;
        Fri, 17 Oct 2025 09:37:11 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d91324sm1575686d6.65.2025.10.17.09.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:37:11 -0700 (PDT)
Date: Fri, 17 Oct 2025 12:37:09 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
Subject: Re: [PATCH v4 1/4] bitfield: Drop underscores from macro parameters
Message-ID: <aPJwtZSMgZLDzxH8@yury>
References: <cover.1760696560.git.geert+renesas@glider.be>
 <792d176149bc4ffde2a7b78062388dc2466c23ca.1760696560.git.geert+renesas@glider.be>
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
In-Reply-To: <792d176149bc4ffde2a7b78062388dc2466c23ca.1760696560.git.geert+renesas@glider.be>

On Fri, Oct 17, 2025 at 12:54:09PM +0200, Geert Uytterhoeven wrote:
> There is no need to prefix macro parameters with underscores.
> Remove the underscores.
> 
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - Update recently introduced FIELD_MODIFY() macro,
> 
> v3:
>   - New.
> ---
>  include/linux/bitfield.h | 106 +++++++++++++++++++--------------------
>  1 file changed, 53 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 5355f8f806a97974..7ff817bdae19b468 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -60,68 +60,68 @@
>  
>  #define __bf_cast_unsigned(type, x)	((__unsigned_scalar_typeof(type))(x))
>  
> -#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
> +#define __BF_FIELD_CHECK(mask, reg, val, pfx)				\
>  	({								\
> -		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
> -				 _pfx "mask is not constant");		\
> -		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
> -		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
> -				 ~((_mask) >> __bf_shf(_mask)) &	\
> -					(0 + (_val)) : 0,		\
> -				 _pfx "value too large for the field"); \
> -		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
> -				 __bf_cast_unsigned(_reg, ~0ull),	\
> -				 _pfx "type of reg too small for mask"); \
> -		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
> -					      (1ULL << __bf_shf(_mask))); \
> +		BUILD_BUG_ON_MSG(!__builtin_constant_p(mask),		\
> +				 pfx "mask is not constant");		\
> +		BUILD_BUG_ON_MSG((mask) == 0, pfx "mask is zero");	\
> +		BUILD_BUG_ON_MSG(__builtin_constant_p(val) ?		\
> +				 ~((mask) >> __bf_shf(mask)) &	\
> +					(0 + (val)) : 0,		\
> +				 pfx "value too large for the field"); \
> +		BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >	\
> +				 __bf_cast_unsigned(reg, ~0ull),	\
> +				 pfx "type of reg too small for mask"); \
> +		__BUILD_BUG_ON_NOT_POWER_OF_2((mask) +			\
> +					      (1ULL << __bf_shf(mask))); \
>  	})

Hi Geert,

Thanks for the series!

I agree that underscored parameters are excessive. But fixing them has
a side effect of wiping the history, which is a bad thing.

I would prefer to save a history over following a rule that seemingly
is not written down. Let's keep this untouched for now, and if there
will be a need to move the code, we can drop underscores as well.

Meanwhile you (and David) can propose a corresponding rule in
coding-style.rst and a checkpatch warning. That way we at least will
stop merging a new code of that style.

Thanks,
Yury

