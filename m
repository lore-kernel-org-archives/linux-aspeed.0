Return-Path: <linux-aspeed+bounces-1002-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C226C282EC
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 08:01:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGS8x0mW3z2yfP;
	Mon, 17 Mar 2025 19:01:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742198481;
	cv=none; b=arhGaIZIDg5f27riYXlFajs9DhCQAuFGjnmcZdhMTOwypQikr9oAMV8y/HgBC9Neb31wt4clGG5ghQ3fCAP3EoJI15o/CpSa1/DVD0WdXG7Wa7jDXOgVJ0+0SAkOWG3CeGPwIaqoGZHkZzMEu+G2j4NxyTmUxklfoI7D+PB2AkAYWthgiyhNjadV+ukyadk3UXQYYkBXEZ7umIlVvnh+AVJH90gRPccqSxJm5RQYCDsJTfFR5W9hA1z6adE3RMU4QO7/DUAQ66AbZ2iy+M2Ebjvwm5l6my5wLTIM3/7HwVEYCNzE4IT04jOrdgziwYqwCCVsOVTKkv0Ei3o0uJJvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742198481; c=relaxed/relaxed;
	bh=vaiyWbIz6Oj82hUDQViuJJ3GQPXALCUTLWwNLfrR6gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEfnHkuH//gU4IaB9fAlueqp/OICzWY2eLcJzrmNXyhxAaaIYzuIAjL+2UxTs5gaKugraPrgRlOlOX+XwxWaMmCES2id555K+zbeuww9bD9jJmgu1F76xeT08FW5bHhW1wPwnE4UcIT0gW7cjolR8gkiVtOClbnpJWV1j+xz2aQjwxAVAth35EQEl/i52zix1ptiggVTDh9vzyLHAquPoReH81EeFTkp7f/Qe+1+B476iGqr+G/gnMmKHk11RrknE/plHo+CdNXt91ooNvUmbq/qh5gIMJnShihpBRHZB5JcL0/JpsT/78qY13MWY2Al0wpdJMi2Av9cHXMSREK6Ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NIR5mYlO; dkim-atps=neutral; spf=none (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NIR5mYlO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Mon, 17 Mar 2025 19:01:19 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGS8v3Sjjz2ydl
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Mar 2025 19:01:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742198480; x=1773734480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WcJorY7PCd1uLYcrL2Xac0peBqgqcHLr4/yCJRQ9DGw=;
  b=NIR5mYlOUe9tKvR1ig0StPv3gLX+ZuHpAOt8tU9T+3G/KQep4V9vVSVl
   44DFINK4bvZEHPQR3IhaxxTv8mb5BIEIl8ikGLXPZfAWcFhTAPstWiI/1
   0I6iXgCr7vVJOq/VEDumZO9nL9z0gqBnNuprErg2cAUuf/ydDMJZfHt0n
   2J9REGlQY+RU3GNDIwSj8O3+JMUkKYlfWEaTKDKTKbaBnrwRddduciW2K
   kEBa3C99XkJJwb+9AFqf0BB7/+d/LPuYo1oqBp79rKtaIzt8o8WStI/ut
   MdsjNQSJaGiUf8xW9EqqvnylXSdsl3Gzq5HUTT9N2y3cEW5IGgFSe53NN
   w==;
X-CSE-ConnectionGUID: JV5CVZEGQtO+9MNejVwsQw==
X-CSE-MsgGUID: VgkeIFW/TqWmOOrJ/0fj0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="43383616"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="43383616"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 01:00:12 -0700
X-CSE-ConnectionGUID: aE6cL5gsQ3avEEOtd25fgg==
X-CSE-MsgGUID: U1U/tNhnTbWmIps9Wc5uMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="121674712"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 01:00:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tu5OG-00000003FIn-2NTM;
	Mon, 17 Mar 2025 10:00:04 +0200
Date: Mon, 17 Mar 2025 10:00:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
	benh@kernel.crashing.org, joel@jms.id.au, andi.shyti@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andrew@codeconstruct.com.au, p.zabel@pengutronix.de,
	linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v16 2/3] i2c: aspeed: support AST2600 i2c new register
 mode driver
Message-ID: <Z9fWhGDrUbAmGRl0@smile.fi.intel.com>
References: <20250224055936.1804279-3-ryan_chen@aspeedtech.com>
 <202502280902.U0gLDhve-lkp@intel.com>
 <Z8GuOT5bJL7CdXX6@smile.fi.intel.com>
 <fec0a1c8-251b-491e-893d-11a8186a2128@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fec0a1c8-251b-491e-893d-11a8186a2128@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 17, 2025 at 08:48:03AM +0100, Krzysztof Kozlowski wrote:
> On 28/02/2025 13:38, Andy Shevchenko wrote:
> > On Fri, Feb 28, 2025 at 09:28:59AM +0800, kernel test robot wrote:
> >> Hi Ryan,
> >>
> >> kernel test robot noticed the following build warnings:
> >>
> >> [auto build test WARNING on andi-shyti/i2c/i2c-host]
> >> [also build test WARNING on linus/master v6.14-rc4 next-20250227]
> >> [If your patch is applied to the wrong git tree, kindly drop us a note.
> >> And when submitting patch, we suggest to use '--base' as documented in
> >> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >>
> >> url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-i2c-aspeed-support-for-AST2600-i2cv2/20250224-140221
> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
> >> patch link:    https://lore.kernel.org/r/20250224055936.1804279-3-ryan_chen%40aspeedtech.com
> >> patch subject: [PATCH v16 2/3] i2c: aspeed: support AST2600 i2c new register mode driver
> >> config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20250228/202502280902.U0gLDhve-lkp@intel.com/config)
> >> compiler: mips-linux-gcc (GCC) 14.2.0
> >> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280902.U0gLDhve-lkp@intel.com/reproduce)
> >>
> >> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >> the same patch/commit), kindly add following tags
> >> | Reported-by: kernel test robot <lkp@intel.com>
> >> | Closes: https://lore.kernel.org/oe-kbuild-all/202502280902.U0gLDhve-lkp@intel.com/
> >>
> >> All warnings (new ones prefixed by >>):
> > 
> > My gosh, this is valid report. But it looks like a preexisted issue.
> > Can somebody fix this, please?
> 
> 
> That was three weeks ago and still no responses from Aspeed or
> contributors from here.
> 
> I think this tells a lot about aspeedtech.com patchsets on the list.

Yeah...

-- 
With Best Regards,
Andy Shevchenko



