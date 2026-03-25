Return-Path: <linux-aspeed+bounces-3767-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B08103A9A7
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Mar 2026 11:21:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgkx71n2Rz2xSX;
	Wed, 25 Mar 2026 22:20:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774437659;
	cv=none; b=cMTP9BFCo1wxcS4r5zFJp5JHlru0pVBEhVujMaWXDfcHzvKM5kBvBc5mM9WixcN3U2YJtHTilW29Mq6ucEvb+LYMIxk1wwohktuxdmtfOn2Vbxk463Sfajd2Ow6I5DN3+JDxn9mFcoL7tZ8833APzWT9Wd4pB4tBGIcQi3/oZGXc7TEVodP0zzlYkz/3gkV5dw3JVTHYZ+2NtswaIagFX8UBXqvo4IimZM/vCBGYL40ADK6/BWHGzZq1aJv/HbLtMf8EYaUgxi6c3eGIyo5owrixrc5MQy8OPy7mDJ6WTkhqK5aH1zCX0Ekrw7G03YFD3Fd6Y03r64T9rabxPgFLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774437659; c=relaxed/relaxed;
	bh=AAZwoz6zJrlCvSg5nIwe/xNEemY6Jvq8kD+By9rF1Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDAajPheJMWhDOAsqkqU230Sd5bVb+tstYKwMyphiq2v9/Z5cORolbeJbeDXrLm8Z0n0+wXqNt9PN6yH4VV/7SZTh9NMWO0Ax0zvSUnr0aN1t2BzHG7tFrpjnKO+oO6mvqoJe97RqaB0atuqRieQVC1XMhC1uzbr0Xfh8pe/UKK4pM2685oYt0V0ZSdjE0OaSkky9WMwgFVzgoABvHNacC1zcJNy88hauUdS1sLgXdHsp5NE9DovUOv9OWQG0/Tnzx7bTjI3HIlsr4pMo86DLlFUrgURFPCpS9FSFOticLpzREbo+C6eM9TNm5eEsOel5mSVt+vkZqw4v8e3nDS3hQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AWiqudD1; dkim-atps=neutral; spf=temperror (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AWiqudD1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgkx40Zv3z2xPL;
	Wed, 25 Mar 2026 22:20:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774437656; x=1805973656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TVTcQb5blXw3BEZG0IaidyohTKbDsy4QnSKmj9ruqUo=;
  b=AWiqudD1IBg7oq4LAEEEwg70WVO5jINrcaL/R+soPgZCcn967o0lw0Q9
   VvYlXdCD0568CRhsQbef5Pd8K+QBIMh3vTGv1UKaIOfgPfD1B/hwW02Eu
   TpKrSb4gDEAVDsegSoIcI9bUFhkB7ZMC1AvmwJUteLOoRsDYbkLhgvJtf
   TZOb1tNyxFKMw2E0J4CN413BvrSh2tzpvItZJdNyQ2lf+oAsfNEB5wfsq
   1ChLQ7T96CjgZPkI1Rf3fwkfa5OT6F7rvKU1RIW3W50oIjJXANRBtNfn/
   qRFqcPOgQVM5JAaL4+75JXLIgK9g9Co2xLuEfhIxLDoA+KmUcp/YG2wh4
   Q==;
X-CSE-ConnectionGUID: y6KZ76xrQJuOOo05cBwNeg==
X-CSE-MsgGUID: y7JetStKRcKFSaLnBHPJZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="78069424"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="78069424"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 04:20:31 -0700
X-CSE-ConnectionGUID: gUUN8aQtQuOki9WyooG9HA==
X-CSE-MsgGUID: KF6uE9rERyaXq4YCDcDQEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="226294612"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Mar 2026 04:20:27 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5MHg-000000006jB-0AT4;
	Wed, 25 Mar 2026 11:20:24 +0000
Date: Wed, 25 Mar 2026 19:20:12 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, jk@codeconstruct.com.au,
	andriy.shevchenko@linux.intel.com,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rayn Chen <rayn_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v27 3/4] i2c: ast2600: Add controller driver for AST2600
 new register set
Message-ID: <202603251922.TFJuUipj-lkp@intel.com>
References: <20260324-upstream_i2c-v27-3-f19b511c8c28@aspeedtech.com>
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
In-Reply-To: <20260324-upstream_i2c-v27-3-f19b511c8c28@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-i2c-Split-AST2600-binding-into-a-new-YAML/20260325-112805
base:   6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
patch link:    https://lore.kernel.org/r/20260324-upstream_i2c-v27-3-f19b511c8c28%40aspeedtech.com
patch subject: [PATCH v27 3/4] i2c: ast2600: Add controller driver for AST2600 new register set
config: i386-buildonly-randconfig-003-20260325 (https://download.01.org/0day-ci/archive/20260325/202603251922.TFJuUipj-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260325/202603251922.TFJuUipj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603251922.TFJuUipj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-ast2600.c:955:15: error: no member named 'dma_abailable' in 'struct ast2600_i2c_bus'; did you mean 'dma_available'?
     955 |         if (i2c_bus->dma_abailable)
         |                      ^~~~~~~~~~~~~
         |                      dma_available
   drivers/i2c/busses/i2c-ast2600.c:271:9: note: 'dma_available' declared here
     271 |         bool                    dma_available;
         |                                 ^
   1 error generated.


vim +955 drivers/i2c/busses/i2c-ast2600.c

   916	
   917	static int ast2600_i2c_probe(struct platform_device *pdev)
   918	{
   919		struct device *dev = &pdev->dev;
   920		struct ast2600_i2c_bus *i2c_bus;
   921		struct reset_control *rst;
   922		struct resource *res;
   923		u32 global_ctrl;
   924		int ret;
   925	
   926		if (!device_property_present(dev, "aspeed,global-regs"))
   927			return -ENODEV;
   928	
   929		i2c_bus = devm_kzalloc(dev, sizeof(*i2c_bus), GFP_KERNEL);
   930		if (!i2c_bus)
   931			return -ENOMEM;
   932	
   933		i2c_bus->reg_base = devm_platform_ioremap_resource(pdev, 0);
   934		if (IS_ERR(i2c_bus->reg_base))
   935			return PTR_ERR(i2c_bus->reg_base);
   936	
   937		rst = devm_reset_control_get_shared_deasserted(dev, NULL);
   938		if (IS_ERR(rst))
   939			return dev_err_probe(dev, PTR_ERR(rst), "Missing reset ctrl\n");
   940	
   941		i2c_bus->global_regs =
   942			syscon_regmap_lookup_by_phandle(dev_of_node(dev), "aspeed,global-regs");
   943		if (IS_ERR(i2c_bus->global_regs))
   944			return PTR_ERR(i2c_bus->global_regs);
   945	
   946		regmap_read(i2c_bus->global_regs, AST2600_I2CG_CTRL, &global_ctrl);
   947		if ((global_ctrl & AST2600_GLOBAL_INIT) != AST2600_GLOBAL_INIT) {
   948			regmap_write(i2c_bus->global_regs, AST2600_I2CG_CTRL, AST2600_GLOBAL_INIT);
   949			regmap_write(i2c_bus->global_regs, AST2600_I2CG_CLK_DIV_CTRL, I2CCG_DIV_CTRL);
   950		}
   951	
   952		i2c_bus->dev = dev;
   953		i2c_bus->multi_master = device_property_read_bool(dev, "multi-master");
   954		i2c_bus->dma_available = device_property_read_bool(dev, "aspeed,enable-dma");
 > 955		if (i2c_bus->dma_abailable)
   956			i2c_bus->mode = DMA_MODE;
   957		else
   958			i2c_bus->mode = BUFF_MODE;
   959	
   960		if (i2c_bus->mode == BUFF_MODE) {
   961			i2c_bus->buf_base = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
   962			if (IS_ERR(i2c_bus->buf_base))
   963				i2c_bus->mode = BYTE_MODE;
   964			else
   965				i2c_bus->buf_size = resource_size(res) / 2;
   966		}
   967	
   968		ast2600_i2c_set_xfer_mode(i2c_bus, i2c_bus->mode);
   969	
   970		/*
   971		 * i2c timeout counter: use base clk4 1Mhz,
   972		 * per unit: 1/(1000/1024) = 1024us
   973		 */
   974		ret = device_property_read_u32(dev, "i2c-scl-clk-low-timeout-us", &i2c_bus->timeout);
   975		if (!ret)
   976			i2c_bus->timeout = DIV_ROUND_UP(i2c_bus->timeout, 1024);
   977	
   978		init_completion(&i2c_bus->cmd_complete);
   979	
   980		i2c_bus->irq = platform_get_irq(pdev, 0);
   981		if (i2c_bus->irq < 0)
   982			return i2c_bus->irq;
   983	
   984		platform_set_drvdata(pdev, i2c_bus);
   985	
   986		i2c_bus->clk = devm_clk_get(i2c_bus->dev, NULL);
   987		if (IS_ERR(i2c_bus->clk))
   988			return dev_err_probe(i2c_bus->dev, PTR_ERR(i2c_bus->clk), "Can't get clock\n");
   989	
   990		i2c_bus->apb_clk = clk_get_rate(i2c_bus->clk);
   991	
   992		i2c_parse_fw_timings(i2c_bus->dev, &i2c_bus->timing_info, true);
   993	
   994		/* Initialize the I2C adapter */
   995		i2c_bus->adap.owner = THIS_MODULE;
   996		i2c_bus->adap.algo = &i2c_ast2600_algorithm;
   997		i2c_bus->adap.retries = 0;
   998		i2c_bus->adap.dev.parent = i2c_bus->dev;
   999		device_set_node(&i2c_bus->adap.dev, dev_fwnode(dev));
  1000		i2c_bus->adap.algo_data = i2c_bus;
  1001		strscpy(i2c_bus->adap.name, pdev->name);
  1002		i2c_set_adapdata(&i2c_bus->adap, i2c_bus);
  1003	
  1004		ret = ast2600_i2c_init(i2c_bus);
  1005		if (ret < 0)
  1006			return dev_err_probe(dev, ret, "Unable to initial i2c %d\n", ret);
  1007	
  1008		ret = devm_request_irq(dev, i2c_bus->irq, ast2600_i2c_bus_irq, 0,
  1009				       dev_name(dev), i2c_bus);
  1010		if (ret < 0) {
  1011			ret = dev_err_probe(dev, ret, "Unable to request irq %d\n",
  1012					    i2c_bus->irq);
  1013			goto err;
  1014		}
  1015	
  1016		writel(AST2600_I2CM_PKT_DONE | AST2600_I2CM_BUS_RECOVER,
  1017		       i2c_bus->reg_base + AST2600_I2CM_IER);
  1018	
  1019		ret = devm_i2c_add_adapter(dev, &i2c_bus->adap);
  1020		if (ret)
  1021			goto err;
  1022	
  1023		ret = sysfs_create_file(&dev->kobj, &dev_attr_xfer_mode.attr);
  1024		if (ret)
  1025			goto err;
  1026	
  1027		return 0;
  1028	
  1029	err:
  1030		writel(0, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
  1031		writel(0, i2c_bus->reg_base + AST2600_I2CM_IER);
  1032		return ret;
  1033	}
  1034	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

