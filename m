Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DAC606A328
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nTz0ICGh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLHDM17BKz2yDc;
	Fri, 06 Nov 2026 09:34:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793876804;
	cv=none; b=YuLzd7OfSPHjyeasJOMOiSLR0L0C9s3glo9KcvpdEA0riOpFjaZu7qYW92RWMP8dgcEnZSB9h31bbasEdwM/E5Wpyn5q5xPf2PeU6uwBigg/DG2ith/ao1sGbcmlxSwodkUw0x6NwSLbYyR2DigPcxifMSBU2YuTlc1pocv22spDoRwGYQn+sTK3PXgI2/7bnOGBtzFoZZVy4lRupOZvIKCfz71DhUOPU32BmiR5LwcIMCkCFBn4YHbMGdalme5X6wAwFx3K5sCDt6KKf3LUuv80PEp+P90LjHkmZX9CePCdHepV2aUlo4peWgKSkfattT8ycv7SFkmKEAtYZnE7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793876804; c=relaxed/relaxed;
	bh=LOaUcszBeFc4BBZTn5mnxjNejVuuHalw0DHWazewRfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdOJ2WYzdcHwqxFSH9Yp0AwJkIsSDbSXcX1zy56O7DTuUa0pgPut8QqPdAm68Vytxe9qm6mQexkNS4DLTzDDCy2+3vwoLFUEYLiV1eorsC7v4YyYNlxPYQROfu37oddcmq48eQqKRK1Rj00nzX04eyOhi1KbTJgK/rlcHiKySJz4DTCG+Tpj8VrPFrU6+Gh7O37BYwLXJ2ViA41pJuVtfiI94GlsQZ7EsybJN6sWlqIH5H2zVXFUFd1hEnZBszmS2NUdUADFmeF4pEbpUzvVVQaKItDg9+4L8Y953N/YO//tJVyVcoKbGUkDOdoH9apXltxF4AbPDXeJ3ocQHPZR1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nTz0ICGh; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nTz0ICGh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKzyn3NZnz2xLt
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 22:06:39 +1100 (AEDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-48e4831c028so1568051f8f.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 03:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793876796; x=1794481596; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LOaUcszBeFc4BBZTn5mnxjNejVuuHalw0DHWazewRfk=;
        b=nTz0ICGhW9Pi7ZO0Q0OMgaLTaws4jCnuaSE5b9ZgOh2g5zuEDRZwzRp/I/0DcI+bzf
         5kilUIDOdCEeZWThqbzqARU4QKYqJOVmUKKGOM9fQhzHq2W7CgrSYoHGTHXq9N/h/rof
         3BfKuTHcyL3jN7uNrYZubIWBpgaQjwLKg5cwRgNYQJaHZXB4vXSGbMNPa1kCIHQMJkjG
         JAt5kLvHNMVy77P9PGE0SVqvD0Tv9ECfyYGUuHj0lNVWajARWtiMogavKaw9kYhAGRLy
         ifEihgwuPI7aWJfzgtrajoKmoyW+CcufndjuYWY+5jKrbUbFdlwzTJaYpz4UUqiVtw9a
         7mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876796; x=1794481596;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LOaUcszBeFc4BBZTn5mnxjNejVuuHalw0DHWazewRfk=;
        b=vudxNlwolGr1JnRgaq/b083DmB5DGSSZBBxheHGe2yGUf/Mr3jtNZ6zB1O3GmutrZt
         5pVJjU4Eudx83SAqPnDh2BmuaH1MItlhgZClUcfFc+zviVuLGc/qkdyts/q/N4sXhqmY
         k+NyxBCsxzlf+z9WFRf32x5JmUFTVokHPYTuSCSm9Sc01Wa2N21bku13/HrcBUmd1lAh
         tKAIhdpzGtthm3552S4kgoOFZZlhdXkE1dNryXM5vRtCYG9wYHnjm9gecOpjoLP/Bjva
         eIYoqIgBEDLODrckNcV9SCr9RJDQkZKpX/O3skCrbJ/s8wlmlSX0KgdBU9WRVFi9a5lG
         K4GA==
X-Forwarded-Encrypted: i=1; AKwUvBxltLtp4rNv8CztXbzRJi0+5/prQQJTYyQSMN4PXMVc05zuLs8a3XGRF5lN419QuOCD3BKyFgdFskaYOfs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+jgrSLXiyESBfd8dbOK1kpjZgU3OGmxsVKBh5xjPSZhgTH2JS3
	fs5DPlXh3F7m0bKboEFOAqNtF0pPCfZnPB4s3uzTYybC1o1pwP/lReZB6XGfOAUGgbw=
X-Gm-Gg: AYBFou0xLX3l7J+M5ETEvONufCCkkFWk5AMVoeawGYruUi/UA2VJW1nug+iL4GzXy9S
	4xkACLHDCQfUDZc4yoydvtAcpm07Upy4eZj8JCZuSBzc63d4Uly6bEak3WRZcfEMK414ueyGjwE
	znBOyj2lw9YF4mHv8GpK0AptWi0VoxDXVMnvMpJm24QE/vvQjKRyJxvwMSKyxjXcT9MQqxHkHLa
	Q6TyWx5hk6X9Betpx6FyaKz8vqwPvxZgOUqP3luh+xk+BJre/8iav31I2vTqf67Nho2P9SFmAW5
	4UfpdG8vVDqqMf+hRfr9f8VUrZ74Dbu3/jCSqnDLOyVWUmGulHVxuZl48B33C+vyIrReEaKqaS3
	+cRJ6K/7Df+7CfrVWOfJa6omrjyDtDT8DDWhYC5POc05s8iY4SSsgE/RHKbiobAHb6Q54NvEV26
	rEzcuoYPWT5uXpYYnaKDWp+A+fdjyZZmlatpzgwCa7LyB49yow1t0QoXvTcD8TKvhnotYHM0j6X
	oDz5uKrFSLWpHrsKWa+rQb6rUwkUlOeFFJdy0v+GWw6mjkggLOQ+38gmCj5vB5wO3Tr5PMTKZpq
	EgL5BG8fmMlKQgUl/7x4+vMDcaQ41p90AU+0gb2N8jEAOh+NPevTWqbRGRjdBYw+ZQ5gsY9nTbj
	3FXPDDc1XiBRpr4Rt
X-Received: by 2002:a05:6000:40e0:b0:48f:bb86:cc03 with SMTP id ffacd0b85a97d-48fbb86d828mr15698548f8f.11.1793876795617;
        Thu, 05 Nov 2026 03:06:35 -0800 (PST)
Received: from localhost (p200300f65f19a904ae40ca5165ccacb8.dip0.t-ipconnect.de. [2003:f6:5f19:a904:ae40:ca51:65cc:acb8])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48fece998absm10176189f8f.22.2026.11.05.03.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:06:34 -0800 (PST)
Date: Thu, 5 Nov 2026 12:06:33 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Imre Kaloz <kaloz@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Daniel Palmer <daniel@thingy.jp>, 
	Romain Perier <romain.perier@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	Hoan Tran <hoan@os.amperecomputing.com>, Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>, 
	Mika Westerberg <westeri@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-hwmon@vger.kernel.org, 
	Matti Vaittinen <mazziesaccount@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>, 
	Viresh Kumar <vireshk@kernel.org>, virtualization@lists.linux.dev, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-tegra@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	Michal Simek <michal.simek@amd.com>, linux-aspeed@lists.ozlabs.org, asahi@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-unisoc@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Michael Buesch <m@bues.ch>, William Breathitt Gray <wbg@kernel.org>, 
	Robert Richter <rric@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 00/23] gpio: Improvements around device-id arrays
Message-ID: <auxh9PxpJScFO3i2@monoceros>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
 <2hfpcbk6r56vvhkqyiex2apl3pinieybad5sd3vkvvabqs3uto@lydt3gin5kxe>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qsdpu7ny4ekdton4"
Content-Disposition: inline
In-Reply-To: <2hfpcbk6r56vvhkqyiex2apl3pinieybad5sd3vkvvabqs3uto@lydt3gin5kxe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--qsdpu7ny4ekdton4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 00/23] gpio: Improvements around device-id arrays
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 09:47:39AM +0100, Bartosz Golaszewski wrote:
> On Tue, Oct 27, 2026 at 11:48:37AM +0100, Uwe Kleine-K=C3=B6nig (The Capa=
ble Hub) wrote:
> > Hello,
> >=20
> > the original motivation for this series are the patches that convert the
> > arrays to use named initializers, see
> > https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylib=
re.com/
> > for the idea behind it. Looking left and right a bit while implementing
> > that, the series grew a bit.
> >=20
>=20
> Hi Uwe!
>=20
> This no longer applies, can you rebase it on top of gpio/for-next and
> resend? I'll apply it right away before any additional conflicts.

Hmm:

	$ git fetch https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git=
 gpio/for-next
	From https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
	 * branch                      gpio/for-next -> FETCH_HEAD

	$ git checkout FETCH_HEAD
	HEAD is now at d66b6b86d5a6 gpio: 74x164: add support for 74lv164 shift re=
gister variant

	$ b4 am -3 2hfpcbk6r56vvhkqyiex2apl3pinieybad5sd3vkvvabqs3uto@lydt3gin5kxe
	Looking up 2hfpcbk6r56vvhkqyiex2apl3pinieybad5sd3vkvvabqs3uto@lydt3gin5kxe
	Analyzing 33 messages in the thread
	Looking for additional code-review trailers on lore.kernel.org
	Analyzing 99 code-review messages
	Checking attestation on all messages, may take a moment...
	---
	  =E2=9C=93 [PATCH v4 1/23] gpio: Remove __maybe_unused annotations from a=
cpi_device_id arrays
	    + Acked-by: Frank Li <Frank.Li@nxp.com> (=E2=9C=97 DKIM/nxp1.onmicroso=
ft.com)
	    + Acked-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com> (=
=E2=9C=93 DKIM/intel.com)
	  =E2=9C=93 [PATCH v4 2/23] gpio: fxl6408: Remove __maybe_unused annotatio=
ns from of_device_id array
	[...]
	 Link: https://patch.msgid.link/cover.1793097104.git.u.kleine-koenig@bayli=
bre.com
	       git checkout -b v4_20261027_u_kleine_koenig_baylibre_com 20a33c6b6c=
be7e4805dfb6cd68816937443aa148
	       git am -3 ./v4_20261027_u_kleine_koenig_gpio_improvements_around_de=
vice_id_arrays.mbx

	$ git am -3 ./v4_20261027_u_kleine_koenig_gpio_improvements_around_device_=
id_arrays.mbx
	Applying: gpio: Remove __maybe_unused annotations from acpi_device_id arra=
ys
	Applying: gpio: fxl6408: Remove __maybe_unused annotations from of_device_=
id array
	Applying: gpio: Drop unused assignment of acpi_device_id driver data
	...
	Applying: gpio: Unify style of pci_device_id arrays
	Applying: gpio: Unify style of various *_device_id arrays

	$ echo $?
	0

Maybe you just need to add `-3` to your workflow? ISTR this should be
the default for b4, but it seems if failed to mention the -3 in the git
am cmdline.

Should I still resend?

Best regards
Uwe

--qsdpu7ny4ekdton4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrsYzcACgkQj4D7WH0S
/k6COAf+I352qHa+kMUOH9ETW9KNHC8dWhUfB6E/IB+8yoRbH4tQy5C0mLg76J11
sJdUuJGD2XjvAv2tgSWACC8Cq1A+CnMvgQXXDsLtC7JuQ0aQYwSFMTIEphdECYue
42itRdsMlxubgjyK4Ku9YeDItioMv2A2EX+InXlNcO6MoK9ty5ZgCfsCY3OyHGVT
OwfU948a3DowaasJORDv1w6dhDNg/sCysegJvjnBoz2vhmoeYeyxxNHTGIzcjxt/
CWYJqu4/QDxJQ9FDuS6d2VhmXYOGL2Dl/wntyyQZjatVXHe6I2wwFBNQoOWJvPaA
BRQb0uNoTqeBvO/Bc5+AYD34/xDKkg==
=tsLa
-----END PGP SIGNATURE-----

--qsdpu7ny4ekdton4--

