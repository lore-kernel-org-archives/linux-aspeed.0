Return-Path: <linux-aspeed+bounces-963-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FE5C282DE
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Mar 2025 18:02:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z7y1K1R3Zz3c7j;
	Fri,  7 Mar 2025 05:02:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741284133;
	cv=none; b=MczpV5cKwjdiYxwTqtOUq+8ZNXMFD+2I1yUfiHEI2xU5lxPPLR8c+Z7Oucp06V+yONlBp4BEXdLAW3DR0JcdR75Z1UGAkws3ExSF61SriOrHX488XTwSxsd7XzfICeRCJe4BYb1EH2mjClKAGdVtwcG7NnSbhyz9m3mq2XAVo/sGpP2v3Wm4cF8NGe0FEzwVdJUZOCSi0R2SNtFdy80P2yR75Ttue8X4oK5lz9TwQ8Q8mpLwcM8lHVCjjYJknP/GhhVil7nyvVPEH4UGm61FaBvaP/z9MXcangRJsPVN7hnY/wPNrunDJ6XkA/MNNcSoyUeX4rLQqMDI/btit3pI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741284133; c=relaxed/relaxed;
	bh=cT/90xZaViu9n21Bl3syCt1wWI2oqW2FHfa0uBqaKIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJo2a+oI42tgCNnFTNiuDk6g5KlhZQEuQx44EbJoAeFSF0lqx/QVrjrGbaWEQ8p426HdAJ+uPebKCqciqFnMNC11OBZspkYBTBBWIjvUaKHW3gnK5GDh/SGF2MegrnYB6UyQ6NpY/adCLRuxWzSVSd3FxhIh2F/GCptiqUSBc41/diG6NgSuD3ZwtSWTS1/bT9O/DBnZuMyAoj3/vjmuBloCJTCgbe1TB4MzyoTYaomU/uDOP1S1zrJV5y5WnYRthfoFBqaeQUtq2HYF8vBJUmPcYeDlUUWM22UVz8RkPQSjqkj0yv8ZPG8IRVYOckHrZZ4cKGohBaSKUeZ9rSzjiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=afiJshKk; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=afiJshKk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z7y1G2v2Mz2yFK
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Mar 2025 05:02:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741284131; x=1772820131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aS4+MiTQzEhxzLiPX4aqCukgIbUCu3ZfrqEOUCUr7XI=;
  b=afiJshKkmNU/2fBC4WbPKknX0R2L69JkHdHppbig+B6nHX4qHLTzy9MS
   ehevNi9uwJkJyzKs7sn6o4nXP7H7wG8CJh1PaN2zaeDWY1yrRrkjdbxRK
   7nVPWekF88lp7sTd+PnLZmobJX65O2m5Ke2Kn0SU278W6BfhwlhRh8pmw
   dwSsUcJbTcCxDoCV1DsZ8xab/IvSW59Qj9xMe4HtEMOj3Y8Vw2WVc+Ovg
   Uc0z5syPCk42N02r8i57vBxP8UBuMf0S/eFxranViB2LhZqU/MH7jrEY0
   c2gwVVIuPk7P9H1SAohAF2wP5H55faWLNepjBtJ5JOSaLHusBrztjbrHm
   g==;
X-CSE-ConnectionGUID: 3GOjC+jFSHy5u+WoVgeaiw==
X-CSE-MsgGUID: SbdWwP8iReKjwNZHDQbdbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42447283"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42447283"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 10:01:54 -0800
X-CSE-ConnectionGUID: gNpnIM6CT4yTMEC2oo0i5w==
X-CSE-MsgGUID: 7bbIzenPRDe7V8jlIyKzsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="119280835"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 06 Mar 2025 10:01:51 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqFXY-000NQI-0V;
	Thu, 06 Mar 2025 18:01:48 +0000
Date: Fri, 7 Mar 2025 02:01:04 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v9 3/3] clk: aspeed: add AST2700 clock driver
Message-ID: <202503070117.mMjnpop8-lkp@intel.com>
References: <20250224095506.2047064-4-ryan_chen@aspeedtech.com>
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
In-Reply-To: <20250224095506.2047064-4-ryan_chen@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.14-rc5 next-20250306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-binding-clock-ast2700-modify-soc0-1-clock-define/20250224-175830
base:   linus/master
patch link:    https://lore.kernel.org/r/20250224095506.2047064-4-ryan_chen%40aspeedtech.com
patch subject: [PATCH v9 3/3] clk: aspeed: add AST2700 clock driver
config: powerpc64-randconfig-r121-20250306 (https://download.01.org/0day-ci/archive/20250307/202503070117.mMjnpop8-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250307/202503070117.mMjnpop8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503070117.mMjnpop8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/clk/clk-ast2700.c:1066:92: sparse: sparse: Using plain integer as NULL pointer

vim +1066 drivers/clk/clk-ast2700.c

   952	
   953	static int ast2700_soc_clk_probe(struct platform_device *pdev)
   954	{
   955		const struct ast2700_clk_data *clk_data;
   956		struct ast2700_clk_ctrl *clk_ctrl;
   957		struct clk_hw_onecell_data *clk_hw_data;
   958		struct device *dev = &pdev->dev;
   959		void __iomem *clk_base;
   960		struct clk_hw **hws;
   961		char *reset_name;
   962		int ret;
   963		int i;
   964	
   965		clk_ctrl = devm_kzalloc(dev, sizeof(*clk_ctrl), GFP_KERNEL);
   966		if (!clk_ctrl)
   967			return -ENOMEM;
   968		clk_ctrl->dev = dev;
   969		dev_set_drvdata(&pdev->dev, clk_ctrl);
   970	
   971		spin_lock_init(&clk_ctrl->lock);
   972	
   973		clk_base = devm_platform_ioremap_resource(pdev, 0);
   974		if (IS_ERR(clk_base))
   975			return PTR_ERR(clk_base);
   976	
   977		clk_ctrl->base = clk_base;
   978	
   979		clk_data = device_get_match_data(dev);
   980		if (!clk_data)
   981			return -ENODEV;
   982	
   983		clk_ctrl->clk_data = clk_data;
   984		reset_name = devm_kasprintf(dev, GFP_KERNEL, "reset%d", clk_data->scu);
   985	
   986		clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, clk_data->nr_clks),
   987					   GFP_KERNEL);
   988		if (!clk_hw_data)
   989			return -ENOMEM;
   990	
   991		clk_hw_data->num = clk_data->nr_clks;
   992		hws = clk_hw_data->hws;
   993	
   994		if (clk_data->scu)
   995			ast2700_soc1_configure_i3c_clk(clk_ctrl);
   996	
   997		for (i = 0; i < clk_data->nr_clks; i++) {
   998			const struct ast2700_clk_info *clk = &clk_data->clk_info[i];
   999			void __iomem *reg;
  1000	
  1001			if (clk->type == CLK_FIXED) {
  1002				const struct ast2700_clk_fixed_rate_data *fixed_rate = &clk->data.rate;
  1003	
  1004				hws[i] = devm_clk_hw_register_fixed_rate(dev, clk->name, NULL, 0,
  1005									 fixed_rate->fixed_rate);
  1006			} else if (clk->type == CLK_FIXED_FACTOR) {
  1007				const struct ast2700_clk_fixed_factor_data *factor = &clk->data.factor;
  1008	
  1009				hws[i] = devm_clk_hw_register_fixed_factor(dev, clk->name,
  1010									   factor->parent->name,
  1011									   0, factor->mult, factor->div);
  1012			} else if (clk->type == DCLK_FIXED) {
  1013				const struct ast2700_clk_pll_data *pll = &clk->data.pll;
  1014	
  1015				reg = clk_ctrl->base + pll->reg;
  1016				hws[i] = ast2700_clk_hw_register_dclk(reg, clk->name, clk_ctrl);
  1017			} else if (clk->type == CLK_HPLL) {
  1018				const struct ast2700_clk_pll_data *pll = &clk->data.pll;
  1019	
  1020				reg = clk_ctrl->base + pll->reg;
  1021				hws[i] = ast2700_clk_hw_register_hpll(reg, clk->name,
  1022								      pll->parent->name, clk_ctrl);
  1023			} else if (clk->type == CLK_PLL) {
  1024				const struct ast2700_clk_pll_data *pll = &clk->data.pll;
  1025	
  1026				reg = clk_ctrl->base + pll->reg;
  1027				hws[i] = ast2700_clk_hw_register_pll(i, reg, clk->name,
  1028								     pll->parent->name, clk_ctrl);
  1029			} else if (clk->type == CLK_UART_PLL) {
  1030				const struct ast2700_clk_pll_data *pll = &clk->data.pll;
  1031	
  1032				reg = clk_ctrl->base + pll->reg;
  1033				hws[i] = ast2700_clk_hw_register_uartpll(reg, clk->name,
  1034									 pll->parent->name, clk_ctrl);
  1035			} else if (clk->type == CLK_MUX) {
  1036				const struct ast2700_clk_mux_data *mux = &clk->data.mux;
  1037	
  1038				reg = clk_ctrl->base + mux->reg;
  1039				hws[i] = devm_clk_hw_register_mux_parent_data_table(dev, clk->name,
  1040										    mux->parents,
  1041										    mux->num_parents, 0,
  1042										    reg, mux->bit_shift,
  1043										    mux->bit_width, 0,
  1044										    NULL, &clk_ctrl->lock);
  1045			} else if (clk->type == CLK_MISC) {
  1046				const struct ast2700_clk_pll_data *misc = &clk->data.pll;
  1047	
  1048				reg = clk_ctrl->base + misc->reg;
  1049				hws[i] = ast2700_clk_hw_register_misc(i, reg, clk->name,
  1050								      misc->parent->name, clk_ctrl);
  1051			} else if (clk->type == CLK_DIVIDER) {
  1052				const struct ast2700_clk_div_data *div = &clk->data.div;
  1053	
  1054				reg = clk_ctrl->base + div->reg;
  1055				hws[i] = devm_clk_hw_register_divider_table(dev, clk->name,
  1056									    div->parent->name, 0,
  1057									    reg, div->bit_shift,
  1058									    div->bit_width, 0,
  1059									    div->div_table,
  1060									    &clk_ctrl->lock);
  1061			} else if (clk->type == CLK_GATE_ASPEED) {
  1062				const struct ast2700_clk_gate_data *gate = &clk->data.gate;
  1063	
  1064				reg = clk_ctrl->base + gate->reg;
  1065				hws[i] = ast2700_clk_hw_register_gate(dev, clk->name, gate->parent,
> 1066								      reg, gate->bit, gate->flags, 0);
  1067	
  1068			} else {
  1069				const struct ast2700_clk_gate_data *gate = &clk->data.gate;
  1070	
  1071				reg = clk_ctrl->base + gate->reg;
  1072				hws[i] = devm_clk_hw_register_gate_parent_data(dev, clk->name, gate->parent,
  1073									       0, reg, clk->clk_idx, 0,
  1074									       &clk_ctrl->lock);
  1075			}
  1076	
  1077			if (IS_ERR(hws[i]))
  1078				return PTR_ERR(hws[i]);
  1079		}
  1080	
  1081		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_hw_data);
  1082		if (ret)
  1083			return ret;
  1084	
  1085		return aspeed_reset_controller_register(dev, clk_base, reset_name);
  1086	}
  1087	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

