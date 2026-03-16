Return-Path: <linux-aspeed+bounces-3692-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB479F506D5
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Mar 2026 14:25:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZHSN73YCz2xlm;
	Tue, 17 Mar 2026 01:25:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773671140;
	cv=none; b=Evw8WZInP4f94TJkB1TrnQLJ0iGmS6mTq8UPhCzNwx0BdSvSw1XLX7+DmZDr/+f1X7QDhNQDPtQCQGgvVxTuwWyYwr35Rlt5zd8ItMOqsZEQAmhG7LDxfhdEQ2alYr3D9ZuiY75GdQF32ciVNErxOYr/9fQWBnIuUdL+JZbR4J2VL2ZSCfIoE9yJ72q9jpueRh0x2gp6o9kERdjFTO1/E4pugGnJWDtOh2wAsFviMJohoZDBzYZBegh2z0SfjtC3J6CKPpTSVZbDkkyOMK1TF1rTNF7S3WUSeLZHspnRvthaq61OMFVraLIzkAxLOEkhMMfltiNiYgunmAn/4XmKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773671140; c=relaxed/relaxed;
	bh=Wk5UVaNS+P8NlqUtcWJ5r7+C8I6RPKAQ8HfHFd9yE7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZZSs7iaPSjgFpc67RepZIcgv47kdyAwA0He5BxveET05Kou4Aq2+0nRDl1EuHOJi9seDeKd/2YKEm2Et9z1PbG+Uf26VSGu+3z7xrorQNx4d1+YmNB3QTYwA/92+V5jVXML8tp6o8DkJyLomKazUBZO1jbYpANekzz399dMGfFB5OPqEFti02kwjlY6VU448B99wT6vw1HMiR49rno4pRFNctvCGp0F9oPAnAGnidGWPQj1X0OABdZZlq5z6XGo060e++ZjDQUAd87a3hjhaMH2yMXssOtod9WGhuTZKcyK/YoUZzW5bNIQaPBKYPgbN0MQpRVfPdY4NmP6miGnig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fse0ISQn; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fse0ISQn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZHSL3gP9z2xS3
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Mar 2026 01:25:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773671138; x=1805207138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BSgg6KtHp+XdA95gnl1/Q020tGtHqDxyhgpg7ceAYDE=;
  b=fse0ISQnf/KkyNfDM5Q4hE+FHz637IcKAYamSxjOKWjrGt+mfFniEC/Y
   WOA/TdBp9pGqkh3Ou2jaolbDJGrXlXz+AZnBgQPaGVu91bHz70I9SpHcP
   q+frJiCyr+0qiUKsv7zFJcg8zIJPNLXMVjUC/afD+AuNNAJe+9JPd6OGC
   GaoKw9YiPHjHvzcV9bu3U1JKKsqEyY5wVuKT/iu74wEZ1Ly6jolw1CwQn
   H7GOjC1zbHTTbeYkPUxURx9MhSVB1p0fXk2smtgsmKFXNbjK/JW8I8/e2
   G1Uzi1vHAJ7cMIdLMoZ82eIUtlKMsDQJR9/RW1nagjUOP08P/dJe8p73p
   g==;
X-CSE-ConnectionGUID: RTDeFtDtTkGwlv2JgClE3A==
X-CSE-MsgGUID: ez19dzpyQ8+BybYbMtNEcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73869890"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="73869890"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:25:32 -0700
X-CSE-ConnectionGUID: 9dSGBVBxSU+QgCbE+j0MPQ==
X-CSE-MsgGUID: ekmacsyCTWuQio6UChNBFw==
X-ExtLoop1: 1
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:25:29 -0700
Date: Mon, 16 Mar 2026 16:25:26 +0200
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
Subject: Re: [PATCH v2 2/3] iio: adc: Enable multiple consecutive channels
 based on model data
Message-ID: <abgS1lOoEO1RTe9X@ashevche-desk.local>
References: <20260316-adc-v2-0-21475a217b09@aspeedtech.com>
 <20260316-adc-v2-2-21475a217b09@aspeedtech.com>
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
In-Reply-To: <20260316-adc-v2-2-21475a217b09@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 11:00:47AM +0800, Billy Tsai wrote:
> Add helpers to generate channel masks and enable multiple ADC channels
> according to the device model's channel count.

...

> +

(1)

> +/*
> + * Enable multiple consecutive channels starting from channel 0.
> + * This creates a bitmask for channels 0 to (num_channels - 1).
> + * For example: num_channels=3 creates mask 0x0007 (channels 0,1,2)
> + */
> +static inline u32 aspeed_adc_channels_mask(unsigned int num_channels)
> +{
> +	if (num_channels == 0)
> +		return 0;

> +	if (num_channels >= 16)
> +		return GENMASK(15, 0);
> +	return GENMASK(num_channels - 1, 0);

This entire function can be folded into

	return BIT(min(num_channels, 16U)) - 1;

Or

	if (num_channels > 16)
		return GENMASK(15, 0);

	return BIT(num_channels) - 1;

> +}

> +/*
> + * Helper function to enable multiple channels in the control register
> + */
> +static inline u32 aspeed_adc_enable_channels(unsigned int num_channels)
> +{
> +	return FIELD_PREP(ASPEED_ADC_CTRL_CHANNEL, aspeed_adc_channels_mask(num_channels));
> +}

> +

One of these (see 1 above) new blank lines should be rather added in the previous patch.

>  /* Battery sensing is typically on the last channel */
>  #define ASPEED_ADC_BATTERY_CHANNEL		7

...

>  	/* Start all channels in normal mode. */
> -	adc_engine_control_reg_val =
> -		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
> -	adc_engine_control_reg_val |= ASPEED_ADC_CTRL_CHANNEL;
> +	adc_engine_control_reg_val = readl(data->base + ASPEED_REG_ENGINE_CONTROL);

> +	adc_engine_control_reg_val |=
> +		aspeed_adc_enable_channels(aspeed_adc_get_active_channels(data));

Why not FIELD_MODIFY()?

>  	writel(adc_engine_control_reg_val,
>  	       data->base + ASPEED_REG_ENGINE_CONTROL);

-- 
With Best Regards,
Andy Shevchenko



