Return-Path: <linux-aspeed+bounces-3663-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD4D105F787
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Mar 2026 10:10:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXKvP4JcYz3cNQ;
	Fri, 13 Mar 2026 21:08:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773396529;
	cv=none; b=SkwRVE2YNcyF1FR+2OJECndojIHKsjzuiT/EUb/Qh4WHcekZN+sIBQPbloWBiGMUvAOUHCylEHSb6ju1F7snDGkqMuFhukyMoZ6icZ4jWTMbTEq9pJ4oVqgyIG4pMt6T7XOZPAxeE8MHb65rZelfW0GTs+53EZefKs22oP1GYunHp7Lyehd6NLIwMwNRJgj19rNz9jhX4VWTYIlkQiSml9116sTg3q3j8vxbcFO7EPTOZZkU8zk0du9N0tgQJMe8qnp3ntPUd2H+Yx+StRQPa10evkkEvvmj888wMCTtXEKh3xfQTVWUY5m74v4u61//n30UeW1LA6azyspVbsEQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773396529; c=relaxed/relaxed;
	bh=swohX3WwzkGFerzDSyUCwpC9K0sjW9sQSN9/bItQrsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOTCvE6vZfIjg+HJju2EUSITZ7mPE1obh77sD6dw8ww/QTzTa3yWPc5zfk4SgJGpD4tdDZeEpqLifEQTznazc2ird0w0UBprrJbPyuAiaEoVov1Tw94MtEBhnHEkvHGQji2y2w/dGS3bWyLVa+qtGNpJhcFuKvIH/E+hOgrHbpJHcmLOuDpQlJZtF+qk5HiM5odR5YqDMmcDrNpM10XA2FbxY+2Vb9bKNLRtq7D6TetXVtokC3Zmq1qhQyux5LeraqHSRDE3SErcRZjKRUdpmgDXVY8Imb6KorvZuNba97feoTpFambzYRESSaygWBdvkglCousDUfCGlEz7w/FupA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qi3s8cTt; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qi3s8cTt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXKvM1rhDz3cJr
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Mar 2026 21:08:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773396528; x=1804932528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b2hRF1Ae+cNYOQ+zp+3vzd0GVOF9OpTvByNvMFv9yNo=;
  b=Qi3s8cTt4fa+1echFS2y5slNLUvKW8g1d/ytr38NlQePhZBZkD/mTCPo
   Iy5G6MOTTqx2KyiDURIZjjS1QTz9yIkQgtn+lJfRUOmw0Q5trBYOrCl+B
   DIJSksd6gJxE4UFJaa5WLWq6GI0yYcMH3MqbXfsUzmAPE34xWXynsEeNM
   GpQ4YqNz4q1NeJtx29IryNehQZ9rMZSeQpr7V9wfaKhDhavoPlC8B28CM
   BZcip2OMRa4E0WhgycXrHlWOQ18FeXLcgDeb3++klWurayjsWKX2AVGOt
   QSvrVtY1NvCFN1arJc1HvXaLx/EdP2h2yfN1iQzhsV7eCW01wg8JZpkQh
   A==;
X-CSE-ConnectionGUID: UT530UvuQd+3BEE/h3QNIw==
X-CSE-MsgGUID: Wsc0oWz2SMSbZIQvl02UOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85202699"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="85202699"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 03:08:42 -0700
X-CSE-ConnectionGUID: 8yQHrP2UTTKqM/tDC1MDPg==
X-CSE-MsgGUID: 8udDjgPLSba2N4bP7KJYrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="226077796"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 03:08:40 -0700
Date: Fri, 13 Mar 2026 12:08:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	morris_mao@aspeedtech.com
Subject: Re: [PATCH] iio: adc: aspeed: Reserve battery sensing channel for
 on-demand use
Message-ID: <abPiJEOL40C5eR1k@ashevche-desk.local>
References: <20260313-adc-v1-1-7a2edb4e5664@aspeedtech.com>
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
In-Reply-To: <20260313-adc-v1-1-7a2edb4e5664@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 13, 2026 at 06:02:16PM +0800, Billy Tsai wrote:
> For controllers with battery sensing capability (AST2600/AST2700), the last
> channel uses a different circuit design optimized for battery voltage
> measurement. This channel should not be enabled by default along with other
> channels to avoid potential interference and power efficiency issues.
> 
> Changes made:
> - Introduce aspeed_adc_get_active_channels() to return the number of
>   channels that should be enabled by default
> - For battery sensing capable controllers, exclude the last channel
>   from the default channel enable mask
> - Enable the battery sensing channel only when explicitly accessed
>   via read_raw()
> - Replace hardcoded channel numbers with ASPEED_ADC_BATTERY_CHANNEL macro
> - Add helper functions for cleaner channel management

Why not series of patches each for the change made?

> This ensures optimal power efficiency for normal ADC operations while
> maintaining full functionality when battery sensing is needed.

-- 
With Best Regards,
Andy Shevchenko



