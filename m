Return-Path: <linux-aspeed+bounces-3766-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D2B103A9A6
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Mar 2026 10:49:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgkDt5XDWz2xcB;
	Wed, 25 Mar 2026 21:49:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774435774;
	cv=none; b=CskEFMA1MP2OX8yHpCPChVly0IAQr7fIKjExCBUIDbUDjbcmF0U+eNEVDB9LEM65sfBM6u6FeLWKbfqRK6Az0MZf41Dpzy7ynSPxEcncMb6VpJ7GZkOKyXYUmQjC+MWcIh0VAGKLcclyxOkbWj0logJ/rzPsKXKbwmuLzg9jerL1gtJFPHH/YobggKQg1LLcCM68WOGAwu32lcKC9fo87qAAJoV3kz2qcay1T8U5FwRlwhZpJu6PF9AgvQT3UogqFA+YDLnxU1EGshnXQ+TnmBB7Pb1hpIQve6rB9n9udby0m4RHymbV1JscxsA/+NRW6z8napqt+Bh8vfTg+TwPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774435774; c=relaxed/relaxed;
	bh=NM8JSFaEyEeCholdV5PCFvNGSWlHCai+7Rdls4nOTWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWnj0l9DdBptqp/OTWJSua+EAFrDrFAH3HBMS4hUd2asfNs7ws7BmOJAEqjFW4K0Vi3AqGDFQXZCLITv4jGZVgO0TOYyqbtHVd4xr8zyYjJxZITtLaR5xxxgILiBCaUkaGgdYtoP+CP7Yxg8Bv7xMlo9SvfdyrZ/xs31gkUu7Dou6DUmArw957I7sW2lh+/2epSkLjVJ8zfRCNd/aN22duHgfiKtj5T4b0xx99X+Fxq178Sd2XaophopBE7Q6JSXhO8vbmmRcLZrQIijFzVZVZlL6dm8XWy3apML/M29Ys5pcIZCVq9zqM/FxF2iYO+/jt5E8+hSd2c74bMKPkk7UA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ItY7VPdH; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ItY7VPdH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgkDq3pGgz2xS3;
	Wed, 25 Mar 2026 21:49:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774435772; x=1805971772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y4rM1iLTl82BhRRs5Nx7wm1CXx7QRUPDPGxS9HlKH1E=;
  b=ItY7VPdHu+Og9ENKVihM6X9t7FEBAfXfM4SKejlVmmDpts49b0vKkD4x
   tTaZl94QKn4swBIvF1NgAfZctadizMv8R8gAFT5EwdPcex/vl27TW8OtB
   HENckD61d5VA+ov5nvkSckXcohzqSwmI92wYYrmq5AeTJ0aRqd87qjkVy
   vKg+2ftB8ZggtSWABpIwUbzEGMYqct9bnf97LxiYObbIO7ktpdOMerrI/
   m2XqxPMd3EDgKoi0uHcu/hwBmpktWiCxNShjZSR8Rak/F2NItfeTPe7JD
   YuRVIWS7VlcKm7H0YgCBvmKEMBHHAP7YHvdX4mCXiulihbvVQJeI6L6ri
   w==;
X-CSE-ConnectionGUID: Q1CwPsWvTQa1ffWCzhBB8A==
X-CSE-MsgGUID: G1ONRYpRQi27UK4Ruj+SSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79325156"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="79325156"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 03:49:26 -0700
X-CSE-ConnectionGUID: 7OsIQRFCTLuqPlybnrUTfg==
X-CSE-MsgGUID: nOQqZgnMTDyMoRJF43rx7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224905102"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Mar 2026 03:49:21 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5Lna-000000006f7-2Nd7;
	Wed, 25 Mar 2026 10:49:18 +0000
Date: Wed, 25 Mar 2026 18:48:49 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v27 3/4] i2c: ast2600: Add controller driver for AST2600
 new register set
Message-ID: <202603251835.KJc3nKCn-lkp@intel.com>
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
config: sparc-randconfig-r073-20260325 (https://download.01.org/0day-ci/archive/20260325/202603251835.KJc3nKCn-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 8.5.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260325/202603251835.KJc3nKCn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603251835.KJc3nKCn-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/i2c/busses/i2c-ast2600.c: In function 'ast2600_i2c_probe':
>> drivers/i2c/busses/i2c-ast2600.c:955:15: error: 'struct ast2600_i2c_bus' has no member named 'dma_abailable'; did you mean 'dma_available'?
     if (i2c_bus->dma_abailable)
                  ^~~~~~~~~~~~~
                  dma_available


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

