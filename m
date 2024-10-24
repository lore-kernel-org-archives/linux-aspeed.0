Return-Path: <linux-aspeed+bounces-30-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914C7D1036C
	for <linux-aspeed@archiver.kernel.org>; Thu, 24 Oct 2024 20:45:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZHxC6hm3z3bZs;
	Fri, 25 Oct 2024 07:45:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729802735;
	cv=none; b=iku4PivzV6xxrfCo3Q0g8o3rel6l6iu54AEwht72IxcBEpox32B5i/pP4isSbRYMnnoj9taZT7IW1rDmE2aRC6rqBgmH0h3Lg8F/dONanQDzqKss8Yh4fqJMwRQDPTztf6i+A+l799wb08R9YLRG4LlJqO0s6Ur17qojXPTzuKn5x6grkOoc0GOTmTCdBVF0GGNAympY4Xfr+39zzOTg+6sPXw83QhiDLgau1aYwUh1ozIfUfr+5JD1t5jcbFJ4L4dDGEdUc3fk6rCpp440XMv0Utj4yKCm7wBz2T0CcFrrNCDaZNvFOGaGzzV0YNXNl3Z1f6W0RH2J5Enyqk8akGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729802735; c=relaxed/relaxed;
	bh=A2BChVIbZ2q7ifiiOeKthq7YCyppfKNI8HhcmImvUV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3qgMyLcIqtTgTOnwisUWAX4TU0BJz2MiRoJiC6w7JQn4w9n2QMsgJmFlDgpvpzHNnjMUCe7G2rSO/4MLKxKQC0Ing7n1nwlblMqvrR69zi56lSeDmviMdnCpkuA+4F8R6Xtx7by2EtkoA7bX+f44mTlKabNvF4RilKekUc/WbUT/Cdnf2DEqQV6JXydo+XAz2De0H2RU/eWpLYU5DE8W3737sSOwJDmH9X1zGbO+mp/1kCtnScf2Q9DGKLOyQBWZBEya4m4EZZMH3mGQUKJA4PkRdhOQfeagh6FuDkG9tvDTMubbQrRLP163F4OW5v3bPnX0cWBBjldIdkHh6A3jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aYQZYDYZ; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aYQZYDYZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZHx84byWz30Ns
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Oct 2024 07:45:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729802733; x=1761338733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ucJbwvBiLsWRpla8htTc6H7ChqcVCWNJxbQadeAGzmY=;
  b=aYQZYDYZ7KfKQwANJTGtC8K3PUQ25Qbew0g+OJecKH9fra5gmfN1uFDO
   AJgzvSWW7kkehdfwCwpQmuOyVnjQmIl6mttsBvKOpE8RQpeHdBozWUS8K
   xr9/VeghlbTQE1FtsLR26vfCr+n30/HdWgD4uuXKlQIEqcCTDWS3V9hpJ
   S9F3W+cnh51PDvzvHAAUqUWy0VNR3eVE86QNEsmMtBqbLi1sYYNMXzInQ
   ng3BEmIF9uKgXxz/cNLqZ292eGAJSF63bxqeHaWe0zqgUh6/+QwxA8iZ1
   Xc9qP7K+pgjlwrWbW9XdIaeGJdPzJfkwtjlaUmuRBFm60ba7CYzpS7wQV
   A==;
X-CSE-ConnectionGUID: 2uMycukNTPGkdkukz/8SOw==
X-CSE-MsgGUID: 9XzvI/KJRaq3pgfPcVbd+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40076655"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="40076655"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 13:45:26 -0700
X-CSE-ConnectionGUID: a80PQk+CTeWoZxyfSaCU0Q==
X-CSE-MsgGUID: A2lUjMM7QYCvJ0mjQUtLcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="84668190"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 24 Oct 2024 13:45:22 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t44hr-000X8a-2u;
	Thu, 24 Oct 2024 20:45:19 +0000
Date: Fri, 25 Oct 2024 04:44:50 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 3/3] clk: aspeed: add AST2700 clock driver.
Message-ID: <202410250433.GvMiJrDV-lkp@intel.com>
References: <20241023090153.1395220-4-ryan_chen@aspeedtech.com>
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
In-Reply-To: <20241023090153.1395220-4-ryan_chen@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on pza/reset/next lee-mfd/for-mfd-next lee-leds/for-leds-next linus/master lee-mfd/for-mfd-fixes v6.12-rc4 next-20241024]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-mfd-aspeed-support-for-AST2700/20241023-170434
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20241023090153.1395220-4-ryan_chen%40aspeedtech.com
patch subject: [PATCH v6 3/3] clk: aspeed: add AST2700 clock driver.
config: loongarch-randconfig-r054-20241024 (https://download.01.org/0day-ci/archive/20241025/202410250433.GvMiJrDV-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410250433.GvMiJrDV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410250433.GvMiJrDV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/clk-ast2700.c:17:
>> include/soc/aspeed/reset-aspeed.h:14:5: warning: no previous prototype for 'aspeed_reset_controller_register' [-Wmissing-prototypes]
      14 | int aspeed_reset_controller_register(struct device *clk_dev, void __iomem *base,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/aspeed_reset_controller_register +14 include/soc/aspeed/reset-aspeed.h

1476d29e4461f6 Ryan Chen 2024-10-23   9  
1476d29e4461f6 Ryan Chen 2024-10-23  10  #if IS_ENABLED(CONFIG_RESET_ASPEED)
1476d29e4461f6 Ryan Chen 2024-10-23  11  int aspeed_reset_controller_register(struct device *clk_dev, void __iomem *base,
1476d29e4461f6 Ryan Chen 2024-10-23  12  				     const char *adev_name);
1476d29e4461f6 Ryan Chen 2024-10-23  13  #else
1476d29e4461f6 Ryan Chen 2024-10-23 @14  int aspeed_reset_controller_register(struct device *clk_dev, void __iomem *base,
1476d29e4461f6 Ryan Chen 2024-10-23  15  				     const char *adev_name)
1476d29e4461f6 Ryan Chen 2024-10-23  16  {
1476d29e4461f6 Ryan Chen 2024-10-23  17  	return -ENODEV;
1476d29e4461f6 Ryan Chen 2024-10-23  18  }
1476d29e4461f6 Ryan Chen 2024-10-23  19  #endif /* if IS_ENABLED(CONFIG_RESET_ASPEED) */
1476d29e4461f6 Ryan Chen 2024-10-23  20  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

