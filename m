Return-Path: <linux-aspeed+bounces-2694-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D174CCF9EB
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Oct 2025 23:06:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxjYH3vZSz2yx8;
	Thu, 30 Oct 2025 10:06:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761749022;
	cv=none; b=KsauTgns9QMMe7Z6mrPl5gsT/fiNKPWqwkdz5AS4pAA31rKKfLpCisAIYfQzRKSAJQjAAtnUjExKFCBTTLiPP0fQf3McNjnYSgTgYXTq5+7H0VDIhR0nDUd6o2qtZUZJsCwvViwwQPAXccfcyTAgXstvs23+IeMTe9+exyrHoSFq/Bf22chlnvlzjviRDfD8a1wjRaW1Bq5JB4AnO6BfmDpyYd8Ljvm/MsEksOgNlWvrOEq4B1bkhPyc8DPYj9GlSpIA9z4NVfN2maym8b4rMIK1RhxR+BPphvnIdEOy9t8JqpH8zN88j28chOv6XgZNCdxC+sbp05N40rk+h+Z3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761749022; c=relaxed/relaxed;
	bh=YCEuo11ZBMvPKplSQXGviQNPwjkOhxFZqewnhvYiFAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5BBBWaCvc2zPF2F5LbsQ9PMgHDRvvMo1GIHoSQpV85V1FAwJhFpYLlF302OfHHXDyZag/okV+/rULV235880kSV7wjynIx34jX5LXSlWj5wTzYjH5gEXRYZ86GTpcRaxD8Pac8wuwAhPxHLaW8eus7uMSa0NzMpnFlxX0/mMEru5qFIF4PQ3rWef35tos8AwstX7Iesdunji8h5Ro5loqE/8cpIWPhNSpubXh90G1ltpezN5JKxRHCnCf7js3J6kfIjgjNsFY/2yCARr6eOHV4nviC/MJV93EupeaacZvv7y7ipaa96wIhSrNTqRpjOK78AW5ij8AvIqROq6LvnDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EtDNV+gh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EtDNV+gh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxVNs6yD2z2yjm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Oct 2025 01:43:40 +1100 (AEDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-89f54569415so537878185a.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 07:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761749018; x=1762353818; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YCEuo11ZBMvPKplSQXGviQNPwjkOhxFZqewnhvYiFAE=;
        b=EtDNV+ghoBwtn6m3tuNVxhrbHkHg22wuW1dTUX8U37SpJ9+dYaAja4XqNlKnADvv7P
         v5OnbLsTTGOd9NIR26gmBBhEAmv5g0qYg2nTn3IEfpZRhRH7F7ZD8v6mk4yAlaZB4kiz
         zqhp39lnDUesYoCfubpGkbEJZJr0Khsad5rh50UA3+UMj5u9/2EiHvjl5Ho6cVFUNeW3
         A5Ma3InEM4tD20nY7vOmV8LeGpD0AdDtuDuDR5IOrwz4FpzAHclD7WDofel/dFUw34aP
         2yLavUKL+ec7VBeh22EJfpJEKrDUSGDvu19/SvX6EbJ5DrqgvADd0UJrj9ISdhpLj9s0
         rVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749018; x=1762353818;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCEuo11ZBMvPKplSQXGviQNPwjkOhxFZqewnhvYiFAE=;
        b=B6ecH99eWUqyQ3RD8wtvQTWq6+j9w+TIW8zk3hEhzWU3yJCJI1w8Hs7ONPlPYKOJyG
         4gFMOyhujga9NzNpfGzEpW+vSj1SOR0KVpaal5HOFXdtFaudVHvWUr1x6TE/g5tDSFKr
         fCdbKvrvBX91JtQk+JQ8Ojyuh0XxCa3bzfFEGdKB69E0/9Hzt9s6xXIckBcYghcymfQy
         uzvaqvWjIvbKbSEMWhwoPNfuglAzjLv0rpt9KOF2vxfk+uteVT3yT6C+slOD/vK0d5nz
         ETNJwZ8bjjrDcToXxpEBfcNy5Cv7F36hIB4Dxrq5PQozq1CrNtDdkPhpv1UpIOgf+ZjW
         DmqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUctoeL5OOqpQzmiVdSBN46GZaQc/dIUibLyksPwDeqA6456JbtaEsqQgcS5kqal5BZWbjkK6rzzStaMGU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy2TRXWcf91S6l1f2RrPN4CuzUQfhRdrTsn8UV5omOtp0iJaG/k
	7d+Oem9sUwkD63/14VwmtYwpItH1TJQq+bXFsOw4lEFsAFYDchb64sEW
X-Gm-Gg: ASbGncvSiiu8IkOPXHeSYh9lvBdj171pPriNtlMVphKA9JV2ZU4TLVfkbC1L5Lyc/rw
	MW61aqpWPjS3ZTFqCb8pABMDNGE4+vx7rBTLyl9mh4oVMMwYvkY6kUwPv0BwLiC/Cgf0Bp+qK2Z
	MI4PJbcfDQUSIdN3+C2JFrF/rIa0W1kpOy1VcdIgindZ9jfD8n3B4zRxPllU3b16YS4kjwBB7KS
	g8m4185jXm6vBRDTFANdB+nMqDnVsk0nH5qMSKrO0h6KTAOEMtjUcxYBdUyuS8tDot/AdZFy9vM
	0GjFtio8aqAC7ZA4aNHrCWiDCowMIv0AKWy5JFmrCwW803WkRHAY/YL/BjErc32N2Nn46HS8aR/
	BVQMACJcASnfFY9OsvwcqcDF6kFPlzKxjc+iEBtIAc6oQdf4hi2Yi6p0pUei4r9vrZX67tO4p
X-Google-Smtp-Source: AGHT+IHRIj9y57LgRm08PCQ5ag8nDTxAHjyPqcFEyJpmfMgUHtOJ1iinv/hiv9ZRE6XSrJXIT+Ycrw==
X-Received: by 2002:a05:620a:710c:b0:89f:5a59:bf30 with SMTP id af79cd13be357-8a8e58b5164mr388519285a.78.1761749017372;
        Wed, 29 Oct 2025 07:43:37 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8a8179460fasm337345285a.57.2025.10.29.07.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:43:36 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:43:35 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
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
Message-ID: <aQIoF_TPNq13Hc3O@yury>
References: <cover.1761588465.git.geert+renesas@glider.be>
 <03a492c8af84a41e47b33c9a974559805d070d8d.1761588465.git.geert+renesas@glider.be>
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com>
 <aQIlB8KLhVuSqQvt@yury>
 <CAMuHMdUTR2VnQ++j_ccUN3-GzKmSzS3H3QNyYqZNacfOBXD50Q@mail.gmail.com>
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
In-Reply-To: <CAMuHMdUTR2VnQ++j_ccUN3-GzKmSzS3H3QNyYqZNacfOBXD50Q@mail.gmail.com>

On Wed, Oct 29, 2025 at 03:33:49PM +0100, Geert Uytterhoeven wrote:
> Hi Yury,
> 
> On Wed, 29 Oct 2025 at 15:30, Yury Norov <yury.norov@gmail.com> wrote:
> > On Wed, Oct 29, 2025 at 03:19:45PM +0100, Linus Walleij wrote:
> > > On Mon, Oct 27, 2025 at 7:43 PM Geert Uytterhoeven
> > > <geert+renesas@glider.be> wrote:
> > > > Prepare for the advent of globally available common field_get() and
> > > > field_prep() macros by undefining the symbols before defining local
> > > > variants.  This prevents redefinition warnings from the C preprocessor
> > > > when introducing the common macros later.
> > > >
> > > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > Do you want me to just merge this patch to the pinctrl tree or do
> > > you have other plans?
> >
> > There's a couple nits from Andy, and also a clang W=1 warning to
> > address. So I think, v6 is needed.
> 
> Indeed....
> 
> > But overlall, the series is OK, and I'd like to take it in bitmaps
> > branch as it's more related to bits rather than a particular
> > subsystem.
> 
> OK, fine for me (if I can still get an immutable branch ;-)
> 
> Note that as of today there are two more to fix in next:
> commit d21b4338159ff7d7 ("mtd: rawnand: sunxi: introduce ecc_mode_mask
> in sunxi_nfc_caps") in next-20251029
> commit 6fc2619af1eb6f59 ("mtd: rawnand: sunxi: rework pattern found
> registers") in next-20251029

Oh, OK. Didn't actually want to undercut you. :) So, at your
discretion. Just let me know what you'd prefer.

Thanks,
Yury

