Return-Path: <linux-aspeed+bounces-3731-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A064108B8ED
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Mar 2026 10:33:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcf6s5ScBz2yYY;
	Fri, 20 Mar 2026 21:33:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774002821;
	cv=none; b=ZuT6ftC982EXm/RdiT9IG3jKlFYhA7Z/wogwGRNjtz3q7JyHA7il9hje2L35Tn8R38hMBZs1dz4NtSwT9QeZVfuq7nQvirRtAxjwTlc5dSdFn02u7pEvfwdInY1Bu5do4TlAyS7uuvqZbZi1bbyj55ztic8dVgpCyS7C6gRgTg4rKXn/mQMoh/PmetdKBCV5k+7rToTm1VeP0xX5jxdwVyU8s1pUV2RT9Fna5kHctWTWdIJvSRTYXF5yhlHjdNAhfbZfKZ0cV2wNAzU1rXuptnVBXvYZqFH3fNQZM5USV1w6rfK6CAkfDti69k96JKyvmr9gBWSPZ7d9ryzVSMJwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774002821; c=relaxed/relaxed;
	bh=qsI+2W7F3CfaJSOjQ36WDkdbEuej6AfQp4Tx6/klAiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu3ORt/Qb24gL2Gbv79bPZayxFGZlualDj2S5w17rMjPyQ1y7bJaxoB/4aRD+vu4VCVPAJUYZZ+CMzo54F8m+XKglHO/h04DOM/eJ3GP1avDHnycMrq1QnmRqh5snJIB+lIjJKSUC5/2FtzA/Y3QDq0ZZUAPxNwRGHLjmfK9PA+hqY98BmL5hdM7bl2XPmcFIATWjC5KXEC6qI0y7/vDiwVFQayRqZaxy8cNfo7v/SZdBtTuRT2vHYoBh3OTJ+H497ksMAZfmP+GsQBvIi+oQaAdLkJZazi4xd1x6citMHXEPzp9a4GAqkrP7ToE/VmYRBKtXgpI7/o1Is3hYaXWGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZI+CxqZ7; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZI+CxqZ7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcf6r5r9hz2yWK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Mar 2026 21:33:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774002821; x=1805538821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LSQf6TghFoqm6GEMOdcWK6utgEtFgdJISULngartkrk=;
  b=ZI+CxqZ7KmskwpQRaBfRcJ/eq0RV7ui+1rSiFFzhAUuR5wF4RzwYHNQx
   QmuURx7dqmwlQR/GBlDYXLel1YyQ7IH/LUkpKeH4hPjJ90x7rOAJG1dzf
   CFOb+4cP++Q1pH6bHDqnDbDqTwPxlZcLyk+54C9sdTQdH5C3J/4+b9MEX
   sWxIQwVuXyg1mHEoTu1Huof5DC1P81Bdu42lrQIeCuH6VsiwF2jgQPPhC
   G4L9YWWhnWlPN1dWTJULnTXK6ZwNTIpLwlVzpANtINpdg9KfPuYB8sl8M
   wZnw3F4ABi1yyjsXMsDiok2ChPBFM9FueDKxY26FxSQIuqhxCZYBO94dV
   w==;
X-CSE-ConnectionGUID: EB6kmHP1Twu/QeVcSCt6LQ==
X-CSE-MsgGUID: yITbSGCXTHCkOorDdoz81Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="78989477"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="78989477"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:33:38 -0700
X-CSE-ConnectionGUID: FEilcUbeSraVdBth6Vgygw==
X-CSE-MsgGUID: 5JXG02puThGdgHPVUyvk/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222340475"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:33:35 -0700
Date: Fri, 20 Mar 2026 12:33:32 +0200
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
Subject: Re: [PATCH v3 4/4] iio: adc: aspeed: Reserve battery sensing channel
 for on-demand use
Message-ID: <ab0ifBMNuY4BwqA5@ashevche-desk.local>
References: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
 <20260320-adc-v3-4-bc0eac04ef7c@aspeedtech.com>
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
In-Reply-To: <20260320-adc-v3-4-bc0eac04ef7c@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 01:46:38PM +0800, Billy Tsai wrote:
> For controllers with battery sensing capability (AST2600/AST2700), the
> last channel uses a different circuit design optimized for battery
> voltage measurement. This channel should not be enabled by default
> along with other channels to avoid potential interference and power
> efficiency issues.
> This ensures optimal power efficiency for normal ADC operations while
> maintaining full functionality when battery sensing is needed.


...

> +			/*
> +			 * After enable a new channel need to wait some time for ADC stable

Missed period at the end. And you probably wanted to say
"...for ADC to stabilize."

> +			 * Experiment result is 1ms.
> +			 */
> +			fsleep(1000);
> +		}

-- 
With Best Regards,
Andy Shevchenko



