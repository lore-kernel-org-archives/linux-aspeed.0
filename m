Return-Path: <linux-aspeed+bounces-962-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6947AC282EC
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Mar 2025 23:20:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z7T6S0QSPz30XR;
	Thu,  6 Mar 2025 10:20:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741216799;
	cv=none; b=BnE+zcxPnsqzCKIsu/1VWgC8O/0RO6qykwUERowH4peKJ+iXD1KRJEulZaBd6brzp02Zpzqq3mThscm7+c/ZLvMkVjy0RXeeFQkPlAUOJNs0dJ5whI01tMjGwtEsp570PNMzxxKZKevKDAt9xSAZmD5JZXl8QjlXqNXsis5J7Tga9IPHAiSIlOfDJ64vxJbGTgG2R/biNh3IQpJcjdXfI4hyZRIT7qdnZ/OCMCn1W5F5/KZ/YUsYG97Oo3CUnoQ9gWYH8eH1qe5PRQ8DOtZytfGTDn3Yiux+cardyQHnH6PtJn4pi9j3jXnxjbo7j2Wwc2eG2zjzuY+Yw5q/vUGXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741216799; c=relaxed/relaxed;
	bh=Fo7blU2Bz0ygJPtG4Wn+lGih/daURM9cZ9yeAGPof3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPVYCvYpHboNhtpC6iNwteVpFC0C1tPVLKdLkAQV690zDXOfCxbqpLdR6vDFX8/FQFbRuGwp88O+MuzrxHAbyFKl+DS0AIF8IT+vgVSwY7F0kH7JxTPgfJWoE79ELvWUyUf1JCyGDDNFunRsII5Y/zhet26okIzd4q/Jl6DEUOfyVAhkZ19EzqPKpDh9mArwGOu5DIoUJnmQGMp/opBqpXbti0E6ZPo1oObh9GMWgWLC3haEgXokBKaSn9/hEDLhSxnjjBJ4SgNahqYhvnC/8If6HNQibsfMaUcg2CmTo3My5gG0Up4LNHFwLokV/Ug2bMFoRh8ZzyZNM3jeZWj5Qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WKWIv5Rc; dkim-atps=neutral; spf=pass (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WKWIv5Rc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z7T6N70Ylz30Jc
	for <linux-aspeed@lists.ozlabs.org>; Thu,  6 Mar 2025 10:19:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741216797; x=1772752797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jNjm1cYUFMQZ9mfrDQzo9hhp7ND5yA4DLzm1+XAQYrg=;
  b=WKWIv5Rcd+rdW3dNUri03P+kCmtGkRcjzvn2dkcY9gPle6mXVdJYBU37
   48DpfOBuUWKtQZkr15/ie8+90ZPWZoDQf47JdtzVqCu3H850GCq10cVqa
   fZE5IjrNwpoC8wqpsCVvqmwwN/CLNihJK3uLUAwN0i6b/x+Ac66MtSJw5
   2HLHiV3V9aZ258MUveLqzlSbjR7yc72UmrPHHFJU4UyhcGIfKRkRcaYqQ
   uriFt8nysFcBBk2XtfxFnBm7gUKh5M2hc9vXdsLLJsdE2bWaeQu+EPOcQ
   IIyUEz+HmPMu4CWKH9oPQDPcNLHTC3IhUJdM4vYh5E5SzmYpq+cDkD5Nw
   g==;
X-CSE-ConnectionGUID: pz2jGJ3pRqu3wdN+yRbKTg==
X-CSE-MsgGUID: XQO5MhkSQDeKjW2QOyGsbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59613114"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="59613114"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:19:52 -0800
X-CSE-ConnectionGUID: HlxSlCs0TSCIaan0QpIjmA==
X-CSE-MsgGUID: jCEax0NNT1Cswvrw3DHVZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="149607166"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 05 Mar 2025 15:19:48 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpy1h-000MJ6-2W;
	Wed, 05 Mar 2025 23:19:45 +0000
Date: Thu, 6 Mar 2025 07:19:10 +0800
From: kernel test robot <lkp@intel.com>
To: Kevin Chen <kevin_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, derek.kiernan@amd.com,
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Kevin Chen <kevin_chen@aspeedtech.com>
Subject: Re: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Message-ID: <202503060750.pkwFWR24-lkp@intel.com>
References: <20250304104434.481429-4-kevin_chen@aspeedtech.com>
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
In-Reply-To: <20250304104434.481429-4-kevin_chen@aspeedtech.com>

Hi Kevin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus lee-leds/for-leds-next lee-mfd/for-mfd-next robh/for-next lee-mfd/for-mfd-fixes linus/master v6.14-rc5 next-20250305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kevin-Chen/ARM-dts-aspeed-g6-Add-AST2600-LPC-PCC-support/20250304-194530
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20250304104434.481429-4-kevin_chen%40aspeedtech.com
patch subject: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
config: s390-kismet-CONFIG_MFD_SYSCON-CONFIG_ASPEED_LPC_PCC-0-0 (https://download.01.org/0day-ci/archive/20250306/202503060750.pkwFWR24-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250306/202503060750.pkwFWR24-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503060750.pkwFWR24-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for MFD_SYSCON when selected by ASPEED_LPC_PCC
   WARNING: unmet direct dependencies detected for MFD_SYSCON
     Depends on [n]: HAS_IOMEM [=n]
     Selected by [y]:
     - ASPEED_LPC_PCC [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

