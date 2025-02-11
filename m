Return-Path: <linux-aspeed+bounces-697-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222C6C0219B
	for <linux-aspeed@archiver.kernel.org>; Tue, 11 Feb 2025 23:57:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ysz045JrTz2yZ6;
	Wed, 12 Feb 2025 10:57:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739318260;
	cv=none; b=JAXpIaBmsDSjslycOFunhBaOAtxnl8D6vUBzPJqGRmzKWNM47agizBCtLT49P1yVcPqE57NgVvLXEEpFTMqWycuCz5C7cPPbLm1LHuAbkHlSaTThSlSUkFHv2TTR4Yp1GaEeJfufrrKkwYPkGMhcBFNmOsELrFprpW6uVWCyOu2j27BrM7jX2HLN/eb14j5pEhtKVmLvp9oBkZT2JFqQWsVT3noZWRMU+qTpC6J+uUDZjAvCmE21fFjS9tszeZgLxrZM9nlRcaxuvUpjenrxOVXQYs84+15Qp32BPtLAIqat4LiaLxBSGqGcOcsILBeofLAB0N15MQdWna7VxJMHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739318260; c=relaxed/relaxed;
	bh=QSq1tI42Abpe9wKSDPaLZqszOnSMDC7NmHe5B2W5PJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiqVpRr0J6NMDDH4GU3DdTpDCpomxB+noqRuiqc+XT4VrKilGs7XxPdoJGZHaSykBefjWK23elLQTszqtb/bkfAYHEax2L9sNI7hgHF9iriv3DkjQGe/SNGuHPv1Mn8kRiL8zL4xMI4weQyaQG+GassAOm9EgEHRQb5qsWkHFt9z5JxYSOqspIQq2YQSsmFf9FFzb8opnzu+x4Fye0PeUOc5l7lg0gLS8FuXobQRxBt6tLUl8vb/GEB2WJxxtDQIPCkxBDnDE7QTi7yEHDZbB9+nKj+P62KBX/aDmpVzRWYK927Myy00Uy4A7X7K+Fh1rbnsQRVLOEUXgxGOEAXikA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fYyJDBoi; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fYyJDBoi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Wed, 12 Feb 2025 10:57:38 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ysz0240dgz2yWK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 12 Feb 2025 10:57:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739318259; x=1770854259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PSn0Zmv5N7ytlJwYw0DWAn3cbqPBj9i+Z2EniPfj4ww=;
  b=fYyJDBoiUeWfsApe8Uyaw5sq/Wb5d5pi6rwMgkiqUCkNJocf1ZI+Wwn3
   rPw+TMQiB7SBe8GTzV+rj1Nbl6bgNnFcPlF1uFl9Gz4Ma8wuFZtCUHNQm
   RX+6f/OhN0KgCNjY3kRBvvn5OP1B8/dqWdKz2zi7Tm8RLnXc80b/ECBIm
   FGaYo2RmTYfm3GQ9OdnYcQGiPTQwKqAJUvtbb8WyivfC6QbLeeuKEqSo/
   lQ6tuvGgahiwh30HeTB0u15RMc6v8eEetxiCZCQJYnMLkJkVkmAvkfaWP
   EE9evh/THyL317QrfLEJy2KuKCRsmP49V1glEvyIH4JH02rBqZLb79ggK
   Q==;
X-CSE-ConnectionGUID: /Feko2AbTEC67ZNAypMkRQ==
X-CSE-MsgGUID: Apv+MTRYTIGQPgtV9ktEng==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="62427124"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="62427124"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 15:56:26 -0800
X-CSE-ConnectionGUID: BGEregKiTOCpjOcaSYt5Ow==
X-CSE-MsgGUID: DUSwUO8RTy6ArYggwXccmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112518747"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 11 Feb 2025 15:56:22 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ti071-0014qp-1u;
	Tue, 11 Feb 2025 23:56:19 +0000
Date: Wed, 12 Feb 2025 07:55:43 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
	linux-clk@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v8 3/3] clk: aspeed: add AST2700 clock driver
Message-ID: <202502120701.cqyc1KZw-lkp@intel.com>
References: <20250210085004.1898895-4-ryan_chen@aspeedtech.com>
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
In-Reply-To: <20250210085004.1898895-4-ryan_chen@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on pza/reset/next linus/master v6.14-rc2 next-20250210]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-binding-clock-ast2700-modify-soc0-1-clock-define/20250210-165421
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250210085004.1898895-4-ryan_chen%40aspeedtech.com
patch subject: [PATCH v8 3/3] clk: aspeed: add AST2700 clock driver
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250212/202502120701.cqyc1KZw-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502120701.cqyc1KZw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502120701.cqyc1KZw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/clk-ast2700.c:369:37: warning: 'd_clk_sels' defined but not used [-Wunused-const-variable=]
     369 | static const struct clk_parent_data d_clk_sels[] = {
         |                                     ^~~~~~~~~~
>> drivers/clk/clk-ast2700.c:353:37: warning: 'soc1_ahb' defined but not used [-Wunused-const-variable=]
     353 | static const struct clk_parent_data soc1_ahb[] = {
         |                                     ^~~~~~~~
>> drivers/clk/clk-ast2700.c:349:37: warning: 'uart16clk' defined but not used [-Wunused-const-variable=]
     349 | static const struct clk_parent_data uart16clk[] = {
         |                                     ^~~~~~~~~
>> drivers/clk/clk-ast2700.c:345:37: warning: 'uart15clk' defined but not used [-Wunused-const-variable=]
     345 | static const struct clk_parent_data uart15clk[] = {
         |                                     ^~~~~~~~~
>> drivers/clk/clk-ast2700.c:341:37: warning: 'uart14clk' defined but not used [-Wunused-const-variable=]
     341 | static const struct clk_parent_data uart14clk[] = {
         |                                     ^~~~~~~~~
>> drivers/clk/clk-ast2700.c:337:37: warning: 'uart13clk' defined but not used [-Wunused-const-variable=]
     337 | static const struct clk_parent_data uart13clk[] = {
         |                                     ^~~~~~~~~
>> drivers/clk/clk-ast2700.c:237:37: warning: 'soc0_ahb' defined but not used [-Wunused-const-variable=]
     237 | static const struct clk_parent_data soc0_ahb[] = {
         |                                     ^~~~~~~~
>> drivers/clk/clk-ast2700.c:209:37: warning: 'soc0_mpll_div8' defined but not used [-Wunused-const-variable=]
     209 | static const struct clk_parent_data soc0_mpll_div8[] = {
         |                                     ^~~~~~~~~~~~~~


vim +/d_clk_sels +369 drivers/clk/clk-ast2700.c

   208	
 > 209	static const struct clk_parent_data soc0_mpll_div8[] = {
   210		{ .fw_name = "soc0-mpll_div8", .name = "soc0-mpll_div8" },
   211	};
   212	
   213	static const struct clk_parent_data mphysrc[] = {
   214		{ .fw_name = "mphysrc", .name = "mphysrc" },
   215	};
   216	
   217	static const struct clk_parent_data u2phy_refclksrc[] = {
   218		{ .fw_name = "u2phy_refclksrc", .name = "u2phy_refclksrc" },
   219	};
   220	
   221	static const struct clk_parent_data soc0_hpll[] = {
   222		{ .fw_name = "soc0-hpll", .name = "soc0-hpll" },
   223	};
   224	
   225	static const struct clk_parent_data soc0_mpll[] = {
   226		{ .fw_name = "soc0-mpll", .name = "soc0-mpll" },
   227	};
   228	
   229	static const struct clk_parent_data axi0clk[] = {
   230		{ .fw_name = "axi0clk", .name = "axi0clk" },
   231	};
   232	
   233	static const struct clk_parent_data soc0_ahbmux[] = {
   234		{ .fw_name = "soc0-ahbmux", .name = "soc0-ahbmux" },
   235	};
   236	
 > 237	static const struct clk_parent_data soc0_ahb[] = {
   238		{ .fw_name = "soc0-ahb", .name = "soc0-ahb" },
   239	};
   240	
   241	static const struct clk_parent_data soc0_uartclk[] = {
   242		{ .fw_name = "soc0-uartclk", .name = "soc0-uartclk" },
   243	};
   244	
   245	static const struct clk_parent_data emmcclk[] = {
   246		{ .fw_name = "emmcclk", .name = "emmcclk" },
   247	};
   248	
   249	static const struct clk_parent_data emmcsrc_mux[] = {
   250		{ .fw_name = "emmcsrc-mux", .name = "emmcsrc-mux" },
   251	};
   252	
   253	static const struct clk_parent_data soc1_clkin[] = {
   254		{ .fw_name = "soc1-clkin", .name = "soc1-clkin" },
   255	};
   256	
   257	static const struct clk_parent_data soc1_hpll[] = {
   258		{ .fw_name = "soc1-hpll", .name = "soc1-hpll" },
   259	};
   260	
   261	static const struct clk_parent_data soc1_apll[] = {
   262		{ .fw_name = "soc1-apll", .name = "soc1-apll" },
   263	};
   264	
   265	static const struct clk_parent_data sdclk[] = {
   266		{ .fw_name = "sdclk", .name = "sdclk" },
   267	};
   268	
   269	static const struct clk_parent_data sdclk_mux[] = {
   270		{ .fw_name = "sdclk-mux", .name = "sdclk-mux" },
   271	};
   272	
   273	static const struct clk_parent_data huartxclk[] = {
   274		{ .fw_name = "huartxclk", .name = "huartxclk" },
   275	};
   276	
   277	static const struct clk_parent_data uxclk[] = {
   278		{ .fw_name = "uxclk", .name = "uxclk" },
   279	};
   280	
   281	static const struct clk_parent_data huxclk[] = {
   282		{ .fw_name = "huxclk", .name = "huxclk" },
   283	};
   284	
   285	static const struct clk_parent_data uart0clk[] = {
   286		{ .fw_name = "uart0clk", .name = "uart0clk" },
   287	};
   288	
   289	static const struct clk_parent_data uart1clk[] = {
   290		{ .fw_name = "uart1clk", .name = "uart1clk" },
   291	};
   292	
   293	static const struct clk_parent_data uart2clk[] = {
   294		{ .fw_name = "uart2clk", .name = "uart2clk" },
   295	};
   296	
   297	static const struct clk_parent_data uart3clk[] = {
   298		{ .fw_name = "uart3clk", .name = "uart3clk" },
   299	};
   300	
   301	static const struct clk_parent_data uart5clk[] = {
   302		{ .fw_name = "uart5clk", .name = "uart5clk" },
   303	};
   304	
   305	static const struct clk_parent_data uart4clk[] = {
   306		{ .fw_name = "uart4clk", .name = "uart4clk" },
   307	};
   308	
   309	static const struct clk_parent_data uart6clk[] = {
   310		{ .fw_name = "uart6clk", .name = "uart6clk" },
   311	};
   312	
   313	static const struct clk_parent_data uart7clk[] = {
   314		{ .fw_name = "uart7clk", .name = "uart7clk" },
   315	};
   316	
   317	static const struct clk_parent_data uart8clk[] = {
   318		{ .fw_name = "uart8clk", .name = "uart8clk" },
   319	};
   320	
   321	static const struct clk_parent_data uart9clk[] = {
   322		{ .fw_name = "uart9clk", .name = "uart9clk" },
   323	};
   324	
   325	static const struct clk_parent_data uart10clk[] = {
   326		{ .fw_name = "uart10clk", .name = "uart10clk" },
   327	};
   328	
   329	static const struct clk_parent_data uart11clk[] = {
   330		{ .fw_name = "uart11clk", .name = "uart11clk" },
   331	};
   332	
   333	static const struct clk_parent_data uart12clk[] = {
   334		{ .fw_name = "uart12clk", .name = "uart12clk" },
   335	};
   336	
 > 337	static const struct clk_parent_data uart13clk[] = {
   338		{ .fw_name = "uart13clk", .name = "uart13clk" },
   339	};
   340	
 > 341	static const struct clk_parent_data uart14clk[] = {
   342		{ .fw_name = "uart14clk", .name = "uart14clk" },
   343	};
   344	
 > 345	static const struct clk_parent_data uart15clk[] = {
   346		{ .fw_name = "uart15clk", .name = "uart15clk" },
   347	};
   348	
 > 349	static const struct clk_parent_data uart16clk[] = {
   350		{ .fw_name = "uart16clk", .name = "uart16clk" },
   351	};
   352	
 > 353	static const struct clk_parent_data soc1_ahb[] = {
   354		{ .fw_name = "soc1-ahb", .name = "soc1-ahb" },
   355	};
   356	
   357	static const struct clk_parent_data soc1_i3c[] = {
   358		{ .fw_name = "soc1-i3c", .name = "soc1-i3c" },
   359	};
   360	
   361	static const struct clk_parent_data canclk[] = {
   362		{ .fw_name = "canclk", .name = "canclk" },
   363	};
   364	
   365	static const struct clk_parent_data rmii[] = {
   366		{ .fw_name = "rmii", .name = "rmii" },
   367	};
   368	
 > 369	static const struct clk_parent_data d_clk_sels[] = {
   370		{ .fw_name = "soc0-hpll_div2", .name = "soc0-hpll_div2" },
   371		{ .fw_name = "soc0-mpll_div2", .name = "soc0-mpll_div2" },
   372	};
   373	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

