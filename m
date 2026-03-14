Return-Path: <linux-aspeed+bounces-3675-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D24D10854A6
	for <linux-aspeed@archiver.kernel.org>; Sat, 14 Mar 2026 20:39:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYCrc63QFz2xlm;
	Sun, 15 Mar 2026 07:39:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773520768;
	cv=none; b=iRO9ujUvdRhdLHZm2lI/Ty10mTJCDEhFy632ybEOO/C+pvSALXpIn3FVzWez9ejOnont/G546mAOxTjpfyFHJPB2pSY3bLHZ5r/wOffqaKiqkJ9LG9L+dqH86nO12zyFa0pQo6JT7p0K9Y4bBsgel/JC98LbwDCq0VrMjrK8DYryy6CMjJVstfv3PWQqDV0upJ8Nj4NFSuBlS/Qxg3P09jQfmCjxmGyPZOBnfwqzSbX6/sDU4pgL9HrxfLD19Ne7OUGfqsJqBPuwZSgVZTjV5XZsSw1G2ouRzd1ue2ca2iIwvfkkUg3jdqnfeRZo15rWK5vn4MTsTq40yRCyYFwkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773520768; c=relaxed/relaxed;
	bh=Qqp8I8J7zCnhDRW64bOPtwztlJzc65B4nZ/a1CzOFAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njELeCxZCr+KnjdwDJaHwQXEVMj26LqoiL5nUlXd4ziJS923nhxuajoEu9EVE3+RlpnOB3lXjvLkku1m4djrWQOj9dQhsu3BYSqU8itaURygrffvWOuqfXzl3iVci40uduHIJ51iGvTgXzgseqir5cJ1CH3d0xl5rTDyqeTcwAiNQZbx+czKWQ/RaOp7kVax0V+bC+zmilWw40f2ziZpAmfg0bK7ZEgTObBxtaMZJWurLr3rbYVfKI8iBIAl1nhd7TpxQFObXe5iNb6cJyeiBTEIXlTRfTDV2XrFTmQOX0MotbhCO77oft6gQ1W5hrPG8TpDVtYb3CTl3zHfg5R4LA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eWXT5mGf; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eWXT5mGf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYCrY54g1z2xdV;
	Sun, 15 Mar 2026 07:39:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773520767; x=1805056767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AukoqsMcYsnDKt5+d2e638BLLQ4ybjY4dyDeaqoO5S4=;
  b=eWXT5mGfENnX0XR8puDpmnJBSv0gnAMtSPMhpuW2wnM/lwdps2RnRbpo
   V5wquZNLa01n9EVc8wCJCB2mD+Tu0PVqmugR0xWLYUGp63pyezUA5X5AC
   1w5n0Yygktx3FzD/vVShkp8J6KZBmcvsg5kalepQH8POvnuFJ3nLBlCv0
   DP7qjOc2ZJ4gUHZYxju/VlolELLFuNs14L35G26/8K+cxdZojB/fnm7z4
   0CknRrIBcJBc3yAAmCHSnMBGjR4O9w+R8ubevVoSLfdFiwnMXG2BItIFt
   T6/IJt0A4X4oaYQPSvkYS+qj6FXX9dDQ3/B6/hNqY1OapWvEkK3xIKcEq
   Q==;
X-CSE-ConnectionGUID: CZ4s5PkUQc+XpK4fAAkaIg==
X-CSE-MsgGUID: ZOd31PQPS6OPIZFHDK5eyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="85214892"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="85214892"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 13:39:22 -0700
X-CSE-ConnectionGUID: /Zma5jHUTamC/jFSOEsqDQ==
X-CSE-MsgGUID: jgQOkDZJRUW7aIRqQu3piw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="217835982"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Mar 2026 13:39:18 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1VlS-000000005ip-3yYv;
	Sat, 14 Mar 2026 20:39:14 +0000
Date: Sun, 15 Mar 2026 04:39:00 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Ryan Chen <ryanchen.aspeed@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: sdhci-of-aspeed: Add ast2700 support
Message-ID: <202603150439.FM8mt7EG-lkp@intel.com>
References: <20260313-sdhci-v1-2-91cea19c8a67@aspeedtech.com>
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
In-Reply-To: <20260313-sdhci-v1-2-91cea19c8a67@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-mmc-sdhci-of-aspeed-Add-ast2700-support/20260314-132323
base:   6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
patch link:    https://lore.kernel.org/r/20260313-sdhci-v1-2-91cea19c8a67%40aspeedtech.com
patch subject: [PATCH 2/2] mmc: sdhci-of-aspeed: Add ast2700 support
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260315/202603150439.FM8mt7EG-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260315/202603150439.FM8mt7EG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603150439.FM8mt7EG-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci-of-aspeed.c: In function 'aspeed_sdc_probe':
>> drivers/mmc/host/sdhci-of-aspeed.c:533:17: error: implicit declaration of function 'reset_control_get_optional_exclusive' [-Wimplicit-function-declaration]
     533 |         reset = reset_control_get_optional_exclusive(&pdev->dev, NULL);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-of-aspeed.c:533:15: error: assignment to 'struct reset_control *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     533 |         reset = reset_control_get_optional_exclusive(&pdev->dev, NULL);
         |               ^
>> drivers/mmc/host/sdhci-of-aspeed.c:537:15: error: implicit declaration of function 'reset_control_deassert' [-Wimplicit-function-declaration]
     537 |         ret = reset_control_deassert(sdc->rst);
         |               ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-of-aspeed.c:537:41: error: 'struct aspeed_sdc' has no member named 'rst'
     537 |         ret = reset_control_deassert(sdc->rst);
         |                                         ^~


vim +/reset_control_get_optional_exclusive +533 drivers/mmc/host/sdhci-of-aspeed.c

   520	
   521	{
   522		struct device_node *parent, *child;
   523		struct reset_control *reset;
   524		struct aspeed_sdc *sdc;
   525		int ret;
   526	
   527		sdc = devm_kzalloc(&pdev->dev, sizeof(*sdc), GFP_KERNEL);
   528		if (!sdc)
   529			return -ENOMEM;
   530	
   531		spin_lock_init(&sdc->lock);
   532	
 > 533		reset = reset_control_get_optional_exclusive(&pdev->dev, NULL);
   534		if (IS_ERR(reset))
   535			return dev_err_probe(&pdev->dev, PTR_ERR(reset),
   536					     "unable to acquire reset\n");
 > 537		ret = reset_control_deassert(sdc->rst);
   538		if (ret)
   539			return dev_err_probe(&pdev->dev, ret,
   540					     "reset deassert failed\n");
   541	
   542		sdc->clk = devm_clk_get(&pdev->dev, NULL);
   543		if (IS_ERR(sdc->clk))
   544			return PTR_ERR(sdc->clk);
   545	
   546		ret = clk_prepare_enable(sdc->clk);
   547		if (ret) {
   548			dev_err(&pdev->dev, "Unable to enable SDCLK\n");
   549			return ret;
   550		}
   551	
   552		sdc->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &sdc->res);
   553		if (IS_ERR(sdc->regs)) {
   554			ret = PTR_ERR(sdc->regs);
   555			goto err_clk;
   556		}
   557	
   558		dev_set_drvdata(&pdev->dev, sdc);
   559	
   560		parent = pdev->dev.of_node;
   561		for_each_available_child_of_node(parent, child) {
   562			struct platform_device *cpdev;
   563	
   564			cpdev = of_platform_device_create(child, NULL, &pdev->dev);
   565			if (!cpdev) {
   566				of_node_put(child);
   567				ret = -ENODEV;
   568				goto err_clk;
   569			}
   570		}
   571	
   572		return 0;
   573	
   574	err_clk:
   575		clk_disable_unprepare(sdc->clk);
   576		return ret;
   577	}
   578	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

