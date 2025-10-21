Return-Path: <linux-aspeed+bounces-2548-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5F9CCD184
	for <linux-aspeed@archiver.kernel.org>; Tue, 21 Oct 2025 15:07:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4crbJB2q3Zz30Pl;
	Wed, 22 Oct 2025 02:07:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761059258;
	cv=none; b=QMRo6VArb8drFlM5esXo/nwllh44dywQ1Zb8tDbqFzRaOmHf4z+MCqDtNA9MK8NmeD+Lzho+pXCV8AFwzVE6B2Hf1OF/gwM5xKe0pt5mozf5QeZBl+nQBPayRk0Z/8obNXb6Bj2+A0ixnIR9M2v+P97cHEdDLNWDvwSP9jQXKt1lT/9LpTFu3fQFcOMCpzejaiKufHlAirjh9h8x5zgBTj8+61XC0zATgyzrdjwpfm4BVWIwqnr3P2VDi2p0ho35ddctF9Bjtr2WKv3WYpkymH1s4LOarKm4GSKqfs8AbiHPD8PvFk0YAhaqZgBCu0Ced4aWhs00UuT0yh4tbbXB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761059258; c=relaxed/relaxed;
	bh=hcbKy5tNqR5XvaRJ/EYUruL2pTPsg2ZXQfdQqcxcATY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+pAPmlh170Dy+6UiqVHimf3ucUGUyUvwdWTa+aizIQhwqakzc9x75xNrIpaalm/khzlXM1WS19UrNrQtQJ4/epewfHwyuJ+aY6/cSxiI/iJslbg+DgfYPo6Jlk+TWT/Mj+Zpxt8gEie7Nm+9N9cFRWXL+ujhZj2PtiCkVqxfaW0U0O2LwNplgVceCLd2gFEd3T5GWnIKSIA+33pmDG5DqMxwsRHkfodtSOPF3HZm1FOYH37EMZQT8HCNNnR+yn40PW6+sc7tzU528l2vHfdCQmLksFmLOpJspxrfFDGBJSJESRlogA121X+NnsALPeJ1WFrapAsDOWwBXdneWbfng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZdyIlBs3; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZdyIlBs3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 63 seconds by postgrey-1.37 at boromir; Wed, 22 Oct 2025 02:07:35 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4crbJ772j1z30P3
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Oct 2025 02:07:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761059256; x=1792595256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kaQgFgAUjXn571ByFw9JlPd7Orioww62gS7ZpKn0Vvg=;
  b=ZdyIlBs321hxoCwsG/7xclgmR0NkefzPIcV+2/ya0Ak+Bzwg0NOHt3Bc
   6LbG2TrrjcyJTk/XCNXZNpDXdMqEhYMAmPxFPmUkPECU/jMhlDCsGpnT5
   INQx3vAKqJK/50ZOQ2sb6G50sysWArtjcEMnZN6I6MSVwmTFL7dOXgaSE
   YdBe2UN+FflsUCYwPwJkFUf3dD9drke3nGc8fxil+CM0A/FlY2w3fd2Ey
   DVIvEG6nHJ3ryLo8YaPEK1KlgJm/NGwGCDvvKGYyNAqSkQw6dOjG+CLYj
   zVxfD2mTAJoKa7EZijHPQerMK+wf467bRx4lgoi5XtLKMw3HrLYvSsOT4
   w==;
X-CSE-ConnectionGUID: EDohfv+XT1igOcYqQUbuzA==
X-CSE-MsgGUID: JOL0yMEaTJ+2ChvrtDvOEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63091031"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63091031"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:06:26 -0700
X-CSE-ConnectionGUID: tQQvw3RuTnWZ506CmALQMg==
X-CSE-MsgGUID: jOhEaA77R5WgldYhSU3alw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="207285933"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.148])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:06:24 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vBDwL-00000001We0-1IEe;
	Tue, 21 Oct 2025 18:06:21 +0300
Date: Tue, 21 Oct 2025 18:06:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iio: adc: clear reference voltage bits before
 configuring vref
Message-ID: <aPehbXMDP5xBBSS-@smile.fi.intel.com>
References: <20251021053918.3008654-1-billy_tsai@aspeedtech.com>
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
In-Reply-To: <20251021053918.3008654-1-billy_tsai@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 21, 2025 at 01:39:18PM +0800, Billy Tsai wrote:
> Ensures the reference voltage bits are cleared in the ADC engine
> control register before configuring the voltage reference. This
> avoids potential misconfigurations caused by residual bits.

> Change-Id: I03c036436f376ced8a19fa5d407b7bbb377ae721

What is this?

...

Shouldn't be a Fixes tag provided?

-- 
With Best Regards,
Andy Shevchenko



