Return-Path: <linux-aspeed+bounces-5190-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26618CC6B08
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 Oct 2026 13:43:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3wXT0vQQz3brM;
	Wed, 14 Oct 2026 00:43:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791899017;
	cv=none; b=k3PFistFnANI0o693KrNRPHh8UIL26WVgV+NHyvKkgtSkJywTBSYwuz9quzYGZ79DZgC/oVybdpMzhWFcJvYm1QOjpExVjLwafFvGMWqCYLsOGA4E+QK5oz7F1T+re79IljmjuB8XZpx2zqQEIYH9kINdKlfouunEayLibxAv4mieHMh4wiMMjs7BEAP32VsaD6WO9OTNk7WQRubsmTA4cbfxSG7qEIRqgmSivxmP/l+cHrBYJva/QWajBOlGmG0GeFSVXmi0WnYULK2LboNuajrg56+KNyFX3VsvoW8oFotyCz6hSftZJ8HcMeGMW6w/oclezEWPS/oRSPWI2q17g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791899017; c=relaxed/relaxed;
	bh=SvaIBb8eShlEtCC/Ab3b8/Z6rxM8bwQTp9G8b5F7vDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwAJbFkXaDOIK5JWoKDuXLSP3UtsrOjXPgWaCUnkF2olGDGsqQMguE8maXAcnJoPs6iDJe6y1VCeoanBagpWEcdIPouiQQ+y89rmYDsproS96eaOWZiTF+2F6McZlriH3RPVo30tbB8w/lePMNpoG7O+2FnyJJOsBc/8MKW+iOqX6g0Lr+w/t+Expqh4tX/siePzwk1GVRqNLdhGC1zjsNc9nsZNPCTvYM6YaDPU7oT+bp9mXk/5IqpjVIWLgNbJd481WNBFfpcmNyn6R4nc8HxJpQSbt68B/qMfjyP2W6IBki35FEv4aIVShBeaq8wrF+KSaxKyUu3crZssn41ThA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DOnzdMgm; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DOnzdMgm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Wed, 14 Oct 2026 00:43:34 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3wXQ0pBjz3br2
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 00:43:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791899014; x=1823435014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=47Ugmu/MXcINVLz36piL1JROl9v9e1tY83Sfw+DVcuU=;
  b=DOnzdMgmCcl/RJCa3NzV8OCDDhzcMQ5ntv+fitBDcR9ToHzFApK2uQSm
   9eRKDiY5ftoRGDyJUFra71qwntCMxyYVTmEV3DhyQE+pPO8fG1JPO6RBR
   eQ369L9XFi3CvAhRPGoLVS/VtP4NKyjDgLW7pfDoNItq23XXaLgxSUPNy
   YZa5E7/KJGtqoVuBOexGfc5VkoRbGC8LhBDRljWctahfGHGau1z33l/dr
   qRt6IW08/eVBEuWwudBHyKazC04yR14q0DKDW4vkHKPx9DCjLBm60Si/D
   b+0ACq7CbPp3Gt6Cm0C11iynqc7dZjoeju1BQO+Pr2+d94hwxpviWU7I3
   g==;
X-CSE-ConnectionGUID: XSixi9m1Q9mvtI4yKKfgvQ==
X-CSE-MsgGUID: V+x7IEzISnGJkFcVZ3Z0BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="633428"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="633428"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:42:25 -0700
X-CSE-ConnectionGUID: 1rsirYx7QQWSpEQLINJRXw==
X-CSE-MsgGUID: c9T0gSdUTQCfhwUxRTS5/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1090773"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:42:16 -0700
Date: Tue, 13 Oct 2026 16:42:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>,
	gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-parisc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 6/6] serial: 8250: make port operations work on struct
 uart_8250_port
Message-ID: <as41NVTyPHp8cMS-@ashevche-desk.local>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
 <as3etnbZatn4sbfx@ashevche-desk.local>
 <c6b08f53-b5ee-44c8-93d1-54fdf5994ed2@kernel.org>
 <as31PsESOgLUhMB6@ashevche-desk.local>
 <b404f3d7-1b2d-418a-8634-72c61ce33f8b@kernel.org>
 <as4JDXOIGvCbAnE_@debian>
 <f808883b-464e-4de8-a0c1-f799fd3d755e@kernel.org>
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
In-Reply-To: <f808883b-464e-4de8-a0c1-f799fd3d755e@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 01:06:41PM +0200, Jiri Slaby wrote:
> On 13. 10. 26, 12:51, Alejandro Colomar wrote:
> > 	alx@debian:~/src/linux/linux/master$ time rg -n ARRAY_SIZE | wc -l
> > 	58957
> > 
> > 	real	0m0.512s
> > 	user	0m0.490s
> > 	sys	0m0.974s
> > 
> > It's around 50% faster, which I wouldn't call orders of magnitude.
> 
> If you pipe rg's output somewhere, it no longer works in parallel.

Ha-ha! It means it's useless, as it outputs (as of your example) directly to
the console without any pager, so one can't simply look backwards (it's limited
by the terminal emulator scroll-back buffer).

> Are we really about to discuss this?

Up to you, I think `git grep` wins anyway by several reasons (at lest for me).

-- 
With Best Regards,
Andy Shevchenko



