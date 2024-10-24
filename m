Return-Path: <linux-aspeed+bounces-24-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA26ACE8E6E
	for <linux-aspeed@archiver.kernel.org>; Thu, 24 Oct 2024 12:54:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZ5TC0KT0z2yj3;
	Thu, 24 Oct 2024 23:54:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729774446;
	cv=none; b=CaP7XcceqeKDI5BRXK4qv5AjEaRFZeuG3NC+ixH4tzVkzze4DR3eehTJ+ouXvueJLj6X3zKgeBQfLiKV08bUYpwOb0QYrfjby5anp6XNMJMnU/71yxxaa6Zs1eNBED2HFf3kl56uIOn3XrrLyrhkDfJ4+41e41CHNBHBJhWMAhc04ii4XdNGvgZQlmzFUv7JW0LWSeTdpvmNIg2NS37FjfkGU2nQyhcEu8WMNk3t/Z7fVMJaRw+g5NQLhg9Mmx4YSxMIfUR5az4qsUtSmgSPkOY66hkuJS8MVS8N9Qh0R9+fP0/cC3VeBtMUXf7LlFe5T3U3YTWxjjUNhCQIVkIBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729774446; c=relaxed/relaxed;
	bh=JCRJdYh2csJ+89h1hlReDsgz7vlEUdYt46ocV+NkEwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuELLocEaD32duCFiAh3MOCEED9mReuP1Pn3MIzQ+oKN2LPkKZannHpKPYXaXRiuonz14Qbm4NysXfl+upnh3qo69f21+Z2bEuvRXHwq8at6azG0E3cKz0SV7Jvls+OlBG+UFiPnUBlS9q1o8m4g7TgoxJyHaOMK2oa4b8WDQ0gz0zsJO4FB+rPf8XwgyZoYkgcg6eKTQBWYnCVl2VOzjjRx7WLwDBIkgoOTk48DefTQq9BDrPnqnJtGv9AQfE/2oUkw4vrGIl79lGRXuk8QFcnz8Yo9Ya+0sMAt0N1iINIRT9iwyWiqJxPYoqs2gUvFbARqdMjMp7eG1qFdGsB9gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i+60y10u; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i+60y10u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZ5T822cPz2yYk
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Oct 2024 23:54:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729774444; x=1761310444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HUuhAWk3dXLnQPMq/6w0jxdCVg118X9Z6g0zogfDEU8=;
  b=i+60y10uqnZb/2w2/aaK7VXe7pCS314O7HZnfH5PdJ/j0eVBAdIMu/wP
   63zPxBk8CmTe86+hB9QUWD6jBMMeEJ24SE0L6aJ6kd8Q9tG52nPAhfopj
   z0C9FMOAnbk7itc++0IKgLLvRNEdZJgoyV5XR/dMKBZPQZk8tFC94IDfA
   Flgth8dDeLn3iAHLSi+ScFXLDpvXTdXhN2jzrQQKZ1Wgvq091y5+POoA+
   KMhPNBlyznL0oMuG5AjRCN5UYC29qfl4r6L6vFQzM4Cjt4UqqwymRVxmG
   fVNWGBsRFksX0zWKc4OLOuze2AdcFTevhff40ufY+otADl/kfPnCinJu+
   A==;
X-CSE-ConnectionGUID: PuySkkghQfakHfesoeKg0g==
X-CSE-MsgGUID: Is/5hgg1TWuopI9a596Iww==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="33305517"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="33305517"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 05:53:58 -0700
X-CSE-ConnectionGUID: CYQhb0LyQ/O314nR33NJFw==
X-CSE-MsgGUID: T60QwaPzQhGgKJLZPt2oiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="84560553"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 24 Oct 2024 05:53:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3xLc-000WRA-04;
	Thu, 24 Oct 2024 12:53:52 +0000
Date: Thu, 24 Oct 2024 20:53:28 +0800
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
Message-ID: <202410242017.1valHJUC-lkp@intel.com>
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
config: arm64-randconfig-r133-20241024 (https://download.01.org/0day-ci/archive/20241024/202410242017.1valHJUC-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce: (https://download.01.org/0day-ci/archive/20241024/202410242017.1valHJUC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410242017.1valHJUC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/clk-ast2700.c:17:
>> include/soc/aspeed/reset-aspeed.h:14:5: warning: no previous prototype for function 'aspeed_reset_controller_register' [-Wmissing-prototypes]
      14 | int aspeed_reset_controller_register(struct device *clk_dev, void __iomem *base,
         |     ^
   include/soc/aspeed/reset-aspeed.h:14:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      14 | int aspeed_reset_controller_register(struct device *clk_dev, void __iomem *base,
         | ^
         | static 
   1 warning generated.


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

