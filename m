Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6B606A31A
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VAfGNY5D
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFNR63lwKz2yVT;
	Thu, 29 Oct 2026 10:11:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793195858;
	cv=none; b=YqFiqfoIZDKyX1eLUCCLWoeGeGwdxhQxP0bHskXjJosdVy0OHArY1+on8tYnOn8pseqSirJE71m7lfrD2/ueRIolLGcG0a1jOP3sx44HqT5x/qrKKQ6/T3mKEu5Gq4HpT8o1hKvtHRW8nb6KmpKAMsBq7Kbykhec4p61K0gTSpdJB8GMU3usnVJDvu0whZu706er8y+mhX5MakEb2f2cwoigT3sE2x5LVmIG04kISiDTC/8PDZ5LsZpyeMQXThMEwzrozhtYOE0Y3TpwYEelg/GMmqoEyoaeUa5uWtgmr5vUXfnQYiHhIkv1azbc25poeviilvmNgHoeinSQhpwVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793195858; c=relaxed/relaxed;
	bh=kjoWncs6Ir+gA9d8rwO7aJw5Gvr2T1m9bpDOqJloaOw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EFhP3wzH2MjxhLMW7DQd/3FFVF1i5UiJt2twIf5GOBCmitSWmI8omcjatxnymKgSDin/7skpF/nS5SrPpjL5ewJtHb3lVseTtKKw4NoxD6THMGHKytJWuUKSPGXlq1v7Zc7yMpKFMTOfYwHhu37hLPCcpbwHlq96eu+uY9NvSMAHy0Y2Z9kE790Eu9YMUmO6cJ3qb2dqbgdrd2BSw6agki/LNI3kojAtxko+ptHVpmP7OKWqsgrIITsN9y7HTN/vU1UI3R1+LymkmHVnLfbG2nJh9rLCFsNQfDi0/9PoDphaT0mVAr8wTEroQDwhdAyCcN8rzo3ETsA3RiJMAXIcWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VAfGNY5D; dkim-atps=neutral; spf=pass (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=alan.borzeszkowski@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VAfGNY5D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=alan.borzeszkowski@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF87c66CJz2xYw;
	Thu, 29 Oct 2026 00:57:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793195854; x=1824731854;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kjoWncs6Ir+gA9d8rwO7aJw5Gvr2T1m9bpDOqJloaOw=;
  b=VAfGNY5DxIoO9hknwud08gScSywCjFTt96/88PkbHcUwFtom8liAYx35
   WLxMgkSKVG4Ubr1FRlJ6ZGYlMdY/+gkKqyk+K5dKOrSWvwdq1hcqSzh0s
   l0tuHVqm3pRFbS4YLdgeoEEZ8SHIIpYaQrR3UAspkJOhb0sRS2lEn3I2l
   er4A3lfKCfYsVwvkMbaIHveK44k8h+1OREvQXjGOc7GkGOzfZWx+JumTA
   eP5X1OLWUxFaz/a3rdLHFjw0xUK3BazEBxTEy8Pm+PToTr8Zfzyz3F4He
   Tiq5eN++LWLPz7qTynY34d402XxRLGZ/Yu/JGrjCSmNiMjj7wmPId57mx
   g==;
X-CSE-ConnectionGUID: fRXIb8dZSRucncclNm4qHA==
X-CSE-MsgGUID: 1BoqYVebQdWjauAIEI9mRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1929847"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1929847"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 06:57:27 -0700
X-CSE-ConnectionGUID: XGvMYi6BQtyLHQWIIJ1jww==
X-CSE-MsgGUID: zT8iJdk1T9Kr8hcOLr1FEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="6667408"
Received: from ncintean-mobl1.ger.corp.intel.com ([10.245.244.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 06:57:14 -0700
Message-ID: <733ef8df15abeeacea0ac12dd93ad1eba5755dbe.camel@linux.intel.com>
Subject: Re: [PATCH v4 00/23] gpio: Improvements around device-id arrays
From: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= "(The Capable Hub)"
	 <u.kleine-koenig@baylibre.com>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, Sakari
 Ailus	 <sakari.ailus@linux.intel.com>, Broadcom internal kernel review list
	 <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli	
 <florian.fainelli@broadcom.com>, Eugeniy Paltsev
 <Eugeniy.Paltsev@synopsys.com>,  Frank Li <Frank.Li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team	 <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Imre Kaloz	 <kaloz@kernel.org>, Conor
 Dooley <conor.dooley@microchip.com>, Valentina Fernandez
 <valentina.fernandezalanis@microchip.com>, Daire McNamara
 <daire.mcnamara@microchip.com>,  Daniel Palmer <daniel@thingy.jp>, Romain
 Perier <romain.perier@gmail.com>, Robert Jarzmik	 <robert.jarzmik@free.fr>,
 imx@lists.linux.dev, 	linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, Hoan Tran	 <hoan@os.amperecomputing.com>,
 Mika Westerberg <westeri@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, 
	linux-hwmon@vger.kernel.org, Matti Vaittinen <mazziesaccount@gmail.com>, 
 "Enrico Weigelt, metux IT consult"	 <info@metux.net>, Viresh Kumar
 <vireshk@kernel.org>, 	virtualization@lists.linux.dev, Yinbo Zhu
 <zhuyinbo@loongson.cn>, Thierry Reding	 <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 	linux-tegra@vger.kernel.org, Geert
 Uytterhoeven <geert+renesas@glider.be>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Srinivas Neeli
 <srinivas.neeli@amd.com>, Michal Simek	 <michal.simek@amd.com>,
 linux-aspeed@lists.ozlabs.org, asahi@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org, 
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-unisoc@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Michael Buesch <m@bues.ch>,
 William Breathitt Gray	 <wbg@kernel.org>, Robert Richter <rric@kernel.org>,
 Andy Shevchenko	 <andriy.shevchenko@linux.intel.com>,
 linux-acpi@vger.kernel.org
Date: Wed, 28 Oct 2026 14:57:11 +0100
In-Reply-To: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, 2026-10-27 at 11:48 +0100, Uwe Kleine-K=C3=B6nig (The Capable Hub)
wrote:
> Hello,
>=20
> the original motivation for this series are the patches that convert
> the
> arrays to use named initializers, see
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre=
.com/
> for the idea behind it. Looking left and right a bit while
> implementing
> that, the series grew a bit.
>=20
> Changes since v3 (available at
> https://lore.kernel.org/all/cover.1793030820.git.u.kleine-koenig@baylibre=
.com
> ):
>=20
> =C2=A0- Picked up review tags (b4 even found some from v2)
> =C2=A0- Add a 2nd MODULE_DEVICE_TABLE(of, ...) in drivers/gpio/gpio-
> mpc5200.c
> =C2=A0=C2=A0 (My grep didn't handle >1 driver per file well), noticed by
> Sashiko
> =C2=A0- New patch to use named initializers for auxiliary_device_id array=
s
> =C2=A0- Fix code style of of_device_id array in drivers/gpio/gpio-grgpio.=
c
> =C2=A0=C2=A0 (My script doesn't handle of_device_id::name) and
> =C2=A0=C2=A0 drivers/gpio/gpio-ppc44x.c (didn't exist yet when I sent v2 =
and
> =C2=A0=C2=A0 failed to notice that for v3)
> =C2=A0- Fix code style of auxiliary_device_id array in
> =C2=A0=C2=A0 drivers/gpio/gpio-shared-proxy.c, missed as I didn't have a =
script
> =C2=A0=C2=A0 for auxiliary_device_id before.
> =C2=A0- Dropped a few broken email addresses from Cc:
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (The Capable Hub) (23):
> [...]
> =C2=A0 gpio: Use named initializers for acpi_device_id array
> [...]
> =C2=A0 gpio: Unify style of acpi_device_id arrays
> [...]
>=20
> [...]
> =C2=A0drivers/gpio/gpio-novalake-events.c |=C2=A0 4 ++--
> [...]
>=20

For gpio-novalake-events

Acked-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>

