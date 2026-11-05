Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9100F606A338
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F48IXlgi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL4KQ0npHz2xN4;
	Fri, 06 Nov 2026 01:23:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793888586;
	cv=none; b=l+uS3nNKJWiiQofwlNxMCW0P++3diVB0yvo0tQzHa9vbBheX2wWxlwo62WHmSicSg7+IZdkvFukC/ClIKQRz0NVF58BD0q/0GbA32B+o0+HuzA27LaedHwrEdmgQxbZKOVY0RbkvWKw2L1bZhPGAeJnOm3RqAxQKn60wIdh55hywH96ycfSmLG3s2X/6mHXARi555QPOpp4ct8WJYD3rp1eK/I+pJuQGnfENHy0uMieU2YVI3dnS3oZM3AV0iJjx0HFcjOFCVdLnTeoglU2I79lQZGsYVUUVYxk0QGkCVuYtKMimGzMt2KgSo1PtKGCj5Xk64FknmAQV7I0jsxx+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793888586; c=relaxed/relaxed;
	bh=fr/sToHFkpF9BPihxA953uG8doO1fE0lFSHPRxWhDoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyXIBSLBFcUBNdrYsmEDGe66Mbif3Chx5bRzr4ZIeJ25dmPn06/IhtWhCNYFElZCRk3NJ31EHo6zKvex1unEXZYh2m2jPFR+tmJDefv4Tn4zuQlOERfQ96D8I7XA6KcFxwriWTHKrjVb1jurty42bsBSK8DT8LJZsXEMtLlHKpqI41c5dgmt2V3BnEqM3wOehjOwWOdLWg+BaVmjED3SQsSVb2k883aM+rZix7LXcB0o5lOvSFRP9WIRhoZmWvTdrlYdtXm8YrHpQo1CAxvORFSt3+EDX/6D1hY9itG8nr/PPCP6WvyjeFaq+bUekXkU0vyL30ZGBiPLRdip/xNfhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F48IXlgi; dkim-atps=neutral; spf=pass (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F48IXlgi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL4KM2QCtz2x9c
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 01:23:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793888584; x=1825424584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8aE99+VJcMQQ2lFtFNMEVuo+WAHaGpOaIlVw0wUkjj8=;
  b=F48IXlgilTX9L5/2aOhNWdfO26H/gYTfC8nD2Fdw6t15euW6qNOFb34R
   EBhqx8UAWbkGdR2fOPRcIlIsMshaz2upEekliWW65NcjhoAsN+HRGD5HQ
   1lxZNtn7AVQ0hCBYfGaKXZoaLGk/7gUNqJMSxRoo34BehWtyAM0fJ5yjr
   +itEUcFTbAkeEjKzVrAZTIIFLXcs0MfbblzMTtlcwkOx8niodBPxbOMw7
   u/J6df+lcDR5kyDFPBb8/ejp6e5hvfm64qY2JryGpO4IzO7OYQDLCN/uc
   uRrgHRn7tja8Ubjmomt/OKCjKEeus/1HPX9h71UXYCfxTUAuraf3mjcqd
   g==;
X-CSE-ConnectionGUID: N4FfgSvaQKCvdrQlG9W6TQ==
X-CSE-MsgGUID: UOYJ1ryMS0SZsqrg4RqgIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2703093"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2703093"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:22:59 -0800
X-CSE-ConnectionGUID: /K275MsMS2iu65atWdhLvw==
X-CSE-MsgGUID: RsKg5am+RfCPmB5pvRDPCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7192371"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:22:47 -0800
Date: Thu, 5 Nov 2026 16:22:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Imre Kaloz <kaloz@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Hoan Tran <hoan@os.amperecomputing.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-hwmon@vger.kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>, virtualization@lists.linux.dev,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>, linux-aspeed@lists.ozlabs.org,
	asahi@lists.linux.dev, linux-mediatek@lists.infradead.org,
	openbmc@lists.ozlabs.org, linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-unisoc@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Michael Buesch <m@bues.ch>, William Breathitt Gray <wbg@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 00/23] gpio: Improvements around device-id arrays
Message-ID: <auyRNagFOmxf_3nW@ashevche-desk.local>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
 <2hfpcbk6r56vvhkqyiex2apl3pinieybad5sd3vkvvabqs3uto@lydt3gin5kxe>
 <auxh9PxpJScFO3i2@monoceros>
 <le5gbua6s2mhhv32di4j77qr2we5z5ngzyzmiemhodmblvjiji@q4wf5tdgrbtv>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <le5gbua6s2mhhv32di4j77qr2we5z5ngzyzmiemhodmblvjiji@q4wf5tdgrbtv>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 01:25:34PM +0100, Bartosz Golaszewski wrote:
> On Thu, Nov 05, 2026 at 12:06:33PM +0100, Uwe Kleine-König (The Capable Hub) wrote:
> > 
> > Maybe you just need to add `-3` to your workflow? ISTR this should be
> > the default for b4, but it seems if failed to mention the -3 in the git
> > am cmdline.
> > 
> > Should I still resend?
> 
> No, it's alright. I would have preferred a clean b4 shazam but that
> works too, thanks.

To make that one should really have a unbiased base with the gpio/for-next,
say v7.4-rc1. Then with --base present `b4 shazam` should follow that.

-- 
With Best Regards,
Andy Shevchenko



