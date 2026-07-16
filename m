Return-Path: <linux-aspeed+bounces-4489-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4626BC44515
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jul 2026 17:45:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1L6h3P0pz3brH;
	Fri, 17 Jul 2026 03:45:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784223932;
	cv=none; b=GzkPMHzNtFi9QQIt8e/tx7Y+1Tj08wsV+MSsFx2SGvtm45QOum0UWDtdVMhWrOP9QaKliMlm8GT/yG4JCBv+u9iDWZDJgNTeEGpP08mhnL98QIN8O9ygp8V5i/2SeQtj0oOZni/dBMO+ePkps2ILOYYM3qW5WDex3Ju4FUH57p6DAMh6YeoiR4Y5Sl7TdQTxuoi0LHMQTRDhQlEk5zH+uJdei6U3woxQgK8FksMbEQP2JS+tShHp5kZGD3Nmo97ZpuWoZEn4pV4yapIdjvI/lhW7IsjGuAiH19+sDouw0lpx7zNuIPMJz7We70e7LLEGvJBLhuyziLKcVzGuZWvczw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784223932; c=relaxed/relaxed;
	bh=tVLdSx79+8Bzgir/Sc66ApOsik9GIIidNucjbg3PmSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULshgfKM6ym3FLGUTSSKRL2e0++e47cPM0olsIc6MBpEf57w1TwhJtOx1Tgcvw+EyrOgYefrKs0Ei95nkRojQeczRVUPx/0f6S7rG4sgyxtsHW7/nIjEMx/qN5hitv/py1hwppxobRAUWHMZddYh2cZxvJE8KLsKYIC7S/jeSNuQkrmFo77jL7c0oEAtiYzdRyGUtqHSE4dQe6QL2a13Oa4YLX0c6lpR+q6cC6EIMuNAY/Xc/0+iAgSTpWbggiiu84fEZpk8soNwcobdjl/8JSaunO0P2WteKppDWPrYtL4hVk5+7UHgpFf/VoyZQWMmh+v1e0UtAMSVbqbRJTd/XA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WxEqJ51a; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WxEqJ51a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 66 seconds by postgrey-1.37 at boromir; Fri, 17 Jul 2026 03:45:28 AEST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1L6c1fpxz30FB;
	Fri, 17 Jul 2026 03:45:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784223929; x=1815759929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jR5j9NUUUDWrKfOXsM73JV6fyT1VqUxtuhsCIIn6jKM=;
  b=WxEqJ51a59GMuAJAjPa6qq9s1VwGefJhGi1sV21NW/VuEYfEGL7/NRvK
   VtidpVQlrneBwMYyRj4oqbdEW/EMHPUaH77ROwhBQl586C2/EGP+4TJBa
   Q/+5X5cuZbaLJdByamNPq4o8tAOdsx0iqFS/O534VrhRzYGDCVyUFMA/V
   yyJcIYGOtDJhRULn9jOEp4/WN9DTYZ0rxkj08Tkag6Y1GhKJfxZObWhCb
   kFsbW7k0NuFQ60XWUtIKKE1kePEirnFVswY7n9mwivWTmJgzgGyEnfhTF
   +6Aa/7ihI6mZmHMSWFXAAGr2cy3SbXKN1OxRUUGK+uucjol5SQvrMGKOC
   Q==;
X-CSE-ConnectionGUID: SN6X+v/yRDCaZBKnvaSBGA==
X-CSE-MsgGUID: MTl9Sf/nQDC9d9hRlwZgQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="83877234"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="83877234"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:44:15 -0700
X-CSE-ConnectionGUID: aMxhVdAuQT2VWNRoxPa/nw==
X-CSE-MsgGUID: NDeukz9TQ02LlIOQEavzaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="256023287"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:43:55 -0700
Date: Thu, 16 Jul 2026 20:43:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Imre Kaloz <kaloz@openwrt.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Hoan Tran <hoan@os.amperecomputing.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>, virtualization@lists.linux.dev,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Alban Bedel <albeu@free.fr>,
	James Cowgill <james.cowgill@blaize.com>,
	Matt Redfearn <matt.redfearn@blaize.com>,
	Neil Jones <neil.jones@blaize.com>,
	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>,
	Doug Berger <opendmb@gmail.com>, Keerthy <j-keerthy@ti.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Bamvor Jian Zhang <bamv2005@gmail.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Michael Walle <mwalle@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>, linux-aspeed@lists.ozlabs.org,
	asahi@lists.linux.dev, linux-mediatek@lists.infradead.org,
	openbmc@lists.ozlabs.org, linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-unisoc@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Michael Buesch <m@bues.ch>, William Breathitt Gray <wbg@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 00/21] gpio: Improvements around device-id arrays
Message-ID: <alkYWcuMsfE5jkLR@ashevche-desk.local>
References: <cover.1784133987.git.u.kleine-koenig@baylibre.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1784133987.git.u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 06:55:05PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
> 
> as with v1 the original motivation for this series are the patches that
> convert the arrays to use named initializers, see
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
> for the idea behind it. Then by not closing the eyes for small issues
> spotted while working on that, this series grew a bit.
> 
> Changes since v1 (available at
> https://lore.kernel.org/linux-kernel/cover.1784013063.git.u.kleine-koenig@baylibre.com):

Sorry, but at first glance it seems this version is messed up.
I'm not going to look into it deeply, waiting for *carefully*
checked v3...

-- 
With Best Regards,
Andy Shevchenko



