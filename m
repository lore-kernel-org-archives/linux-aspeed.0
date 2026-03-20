Return-Path: <linux-aspeed+bounces-3730-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E37C108B8ED
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Mar 2026 10:31:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcf4n5dyzz2yYY;
	Fri, 20 Mar 2026 21:31:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774002713;
	cv=none; b=nsSnR7yzqojkJXXbrg2+o7Ye/sxdp8v0/7LtHMKygzJnBrXIG2XjIDsJX/EvsiD/gd4r9++rnxCmT3sxHCvNEpfn71B8vouNl7zfAdR4skAG08Ceatb6iz6rtmjdgROyYtGwj4NSoP+QGTTPONu0wbCX6ThFYUP/lN6aXhKKxhuxaHg5X2TzenL9uCnyZAdXtioVYSE/S182EXXBhlzc0Dp51N0MZG1ZjjoOQeCr05w7SsuqbdillfvMmSvmsgIwJImaFTL6FFEI51WY332f3blHGBWWIa4Rdr7qUOmkv8ACqM7MM0Mej9ZM8HIRibkS5LeEp6HmUkObqSx6+JXWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774002713; c=relaxed/relaxed;
	bh=+QqAXd2vpQ8qISDA9ynM6KZSRW1nNUGkKU4X69DBcWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTVzvdjJ7MECE/2Jp0lCjeK+Z7+UeWykiouhGvO2fPWRF5vcpYYCXBg4LueoABjfNQZX6HPzXl6o5Kc791Z1LlWQV/2t8o+2MZx+/CxIUvnELHMSKJtS5Ai5ZJpA8y/DpNduyIU/rLZVYtwI4iNCGhAKljKHuOl3WdiyIzrh2TuyJDHZfxa8D3C+jWgpU3Z21OeaCn2LxQtJePC5pvsFMJdj+DZYYQDslXhuCgpQ8i00LphvU7FVjEid1qdyFo46vjWticiMN7GYGOha7mUdbvfOrsyBaGcWRiSLyqgzcdSXbJdNZfZudUvKk5mCj0ZAy6YkZjT0VVS3CNb6M4Rcgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HVXztChU; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HVXztChU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcf4k6Ngxz2yWK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Mar 2026 21:31:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774002711; x=1805538711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FuyuF6cs3y/UPu3j5OaECQ1GK3ebCt60+TAC0A5pjBI=;
  b=HVXztChUfY22DxM9zvrdhZ7Af3CiCJJ+X7qXAEsLhrblBsmqrp9CM3tF
   UfVStnuQ0OkUQ4mbfL+TaS8hw3CuG5W/UUR77Ip+EUz8DvY4Cn6Q5i/pE
   7YIKpOipt3ldyj0WRgqoNsZD+BIYKGIbIWOqCOXR5FBgKuPhkIJdyV3QT
   JfcfIAVxO8ZWlHAQyZgKieCGBZRBiToGbP4VLSofdvW/NW0liQmgYuxKh
   yBk77CENjn3OlGuQvOIWKdYZp86mfSBAZ0VkTDhsmKT4pnL5iyg6jSsBd
   JgHV9QgthkZdxyLCC3pWZd3IJahBr87dcbBk7f8a6ujxbajggJzf3LID9
   A==;
X-CSE-ConnectionGUID: JWvhb0DDTLSwAuaGzeDsEg==
X-CSE-MsgGUID: pmtXLZJvSVyHIMbpEd1+aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74266032"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74266032"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:31:47 -0700
X-CSE-ConnectionGUID: cEr5vsElS/SoNYs1tc2rkw==
X-CSE-MsgGUID: mbnQAE46S0y+yWubfuve9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="218618516"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:31:43 -0700
Date: Fri, 20 Mar 2026 12:31:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	morris_mao@aspeedtech.com
Subject: Re: [PATCH v3 3/4] iio: adc: aspeed: Replace mdelay() with fsleep()
 for ADC stabilization delay
Message-ID: <ab0iDUp6t2LuGlAA@ashevche-desk.local>
References: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
 <20260320-adc-v3-3-bc0eac04ef7c@aspeedtech.com>
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
In-Reply-To: <20260320-adc-v3-3-bc0eac04ef7c@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 01:46:37PM +0800, Billy Tsai wrote:
> The ADC stabilization delays in compensation mode and battery sensing
> mode do not require atomic context. Using mdelay() here results in
> unnecessary busy waiting.
> 
> Replace mdelay(1) with fsleep(1000) to allow the scheduler to run other
> tasks while waiting for the ADC to stabilize.
> 
> Also fix a minor typo in the comment ("adc" -> "ADC").

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I haven't suggested the idea, I only suggested to use fsleep() for the purpose.

-- 
With Best Regards,
Andy Shevchenko



