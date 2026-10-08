Return-Path: <linux-aspeed+bounces-5157-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFCACA6015
	for <linux-aspeed@archiver.kernel.org>; Thu,  8 Oct 2026 21:41:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j13NV3gvWz2yPR;
	Fri, 09 Oct 2026 08:41:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791495706;
	cv=none; b=eTci5f3kxTOyYoahbZOK42Yinj1wkE9vIM5kyw6G5UPSKdQDVl+MR5m8eitsxPc3/kGaAINiGTe6hB4FhB1nmvq/61YSr9UyNZ08dqmQET8XEFG26vtMG80io6bAFyMz2zV+b1snN16t6cfJWbAg343gQfqAg3rInSR4eNTt9QjJv9XrtoNlAMneUPJC178q7NNJwQG+hhTsa3PsECsWW3EIdX/iR0VUp+gJ53pgqUJmTSZDP9Tkw6NCGl0k8WP1PlpL6zkDL5Ij0TIjlxVzGI5owiE0Do936M5LXtP4eNd+++UJdwwOSRDL+6wYDPWLChlSVtGKsTKN6UL6hIjsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791495706; c=relaxed/relaxed;
	bh=7gwI1dcyam2yk5wsB6eHTvF/ZEiZ3eztVF1fLP049Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZ6mYhmAZe7EUwWAtCIFTuan5TKDbtd1bHowOKRa0SIVAdpxjXOPo+EEzJ1PXsKjyHCPMTMj6hfc8vZg2waDjYx9sfrnja6em4nTdYidr+QB38Jj3B6VINe8VBa3fQzUyomdnwxnTi7BhbNP1VCeuIDXp4gtRG+mzbuDJrH7nbpx1/VPwy5IowkZP6XXlmZ4uA3vZwkx5qAqGoOVykpCMehvREDTBYL3l1v5RsASgm1aRhcWreZKvLoQ4T87OxjW62vEzOT3ZrikNJRlTyJ35GAoQsQYvhITBeMqdJ6wUDnkgc9uxiQtKgjOqF1BArbJe5LyuuGTBGdzYOZfTKyj4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F5O2lQXr; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F5O2lQXr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Fri, 09 Oct 2026 08:41:43 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j13NR6Y6vz2yPG
	for <linux-aspeed@lists.ozlabs.org>; Fri, 09 Oct 2026 08:41:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791495704; x=1823031704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FonD0lPwatSwc9CLF+o0pnMjNadWk+XyTpxVZVqKIGE=;
  b=F5O2lQXrEKdpZMkPUWp1hl1oXKJmWXlr71D3+ygPHL+cMuOChDpjWIt2
   1UY02Or2fvsv/I0AGy83yx/FQJgnyxwyh9li6LG7/obBPvMPqJ3eMQI13
   1dZ2xwoghZI08JXq0iy11hsBUwPVcj2a2egCZ3EpHLpnr9aseDxXRcA1k
   Sq2wm+n1tzkr9eJGSGOizC2ltOhXpNifVonOZYqPtKl/etdBn+FeP9gBZ
   JPPgAtu+SyPJ5SiQoh4bXEUJ4fEmdRS3OcET9dNGg6EqHeKHpXCfIOlqR
   Yug2eicnfzO6OrZp8Zc9LtM0Bbl4zMjGD729R/TMMgIa/iBzmXmsNt0jU
   g==;
X-CSE-ConnectionGUID: sl+ACkzzRmuiCKeZSz4C+w==
X-CSE-MsgGUID: iNTO7Ln4T1+wmYKCglb9LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="194300"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="194300"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:40:35 -0700
X-CSE-ConnectionGUID: xGEQVSFmQsOKbtW/QJ+sDQ==
X-CSE-MsgGUID: ozfbqNP5R/C4UprFnJ9UQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="1959551"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 08 Oct 2026 14:40:32 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xEvqm-000000004vU-2wDG;
	Thu, 08 Oct 2026 21:40:28 +0000
Date: Fri, 9 Oct 2026 05:40:18 +0800
From: kernel test robot <lkp@intel.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-aspeed@lists.ozlabs.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jacky Chou <jacky_chou@aspeedtech.com>
Subject: Re: [PATCH 2/3] phy: aspeed: Add ASPEED PCIe PHY driver
Message-ID: <202610090555.gWYlVYEL-lkp@intel.com>
References: <20261008-aspeed_pcie_phy-v1-2-96764937aef0@aspeedtech.com>
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
In-Reply-To: <20261008-aspeed_pcie_phy-v1-2-96764937aef0@aspeedtech.com>

Hi Jacky,

kernel test robot noticed the following build errors:

[auto build test ERROR on ea01f446f0682a5e7bd7a275889a890b7e0c6e02]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Chou/dt-bindings-phy-aspeed-Add-ASPEED-PCIe-PHY/20261008-192819
base:   ea01f446f0682a5e7bd7a275889a890b7e0c6e02
patch link:    https://lore.kernel.org/r/20261008-aspeed_pcie_phy-v1-2-96764937aef0%40aspeedtech.com
patch subject: [PATCH 2/3] phy: aspeed: Add ASPEED PCIe PHY driver
config: csky-randconfig-1000-20261009 (https://download.01.org/0day-ci/archive/20261009/202610090555.gWYlVYEL-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610090555.gWYlVYEL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610090555.gWYlVYEL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/io.h:12,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/csky/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:8,
                    from include/linux/cgroup.h:27,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from include/linux/regulator/consumer.h:35,
                    from include/linux/phy/phy.h:17,
                    from drivers/phy/aspeed/phy-aspeed-pcie.c:11:
   drivers/phy/aspeed/phy-aspeed-pcie.c: In function 'ast2600_phy_set_mode':
>> drivers/phy/aspeed/phy-aspeed-pcie.c:16:41: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
      16 | #define  AST2600_PORT_TYPE(x)           FIELD_PREP(AST2600_PORT_TYPE_MASK, x)
         |                                         ^~~~~~~~~~
   arch/csky/include/asm/io.h:31:59: note: in definition of macro 'writel'
      31 | #define writel(v,c)             ({ wmb(); writel_relaxed((v),(c)); mb(); })
         |                                                           ^
   drivers/phy/aspeed/phy-aspeed-pcie.c:94:24: note: in expansion of macro 'AST2600_PORT_TYPE'
      94 |                 writel(AST2600_PORT_TYPE(0x3), pcie_phy->reg + PEHR_GLOBAL);
         |                        ^~~~~~~~~~~~~~~~~
   drivers/phy/aspeed/phy-aspeed-pcie.c: In function 'ast2700_phy_set_mode':
>> drivers/phy/aspeed/phy-aspeed-pcie.c:144:17: error: implicit declaration of function 'FIELD_MODIFY' [-Wimplicit-function-declaration]
     144 |                 FIELD_MODIFY(AST2700_PORT_TYPE_MASK, &cfg_val,
         |                 ^~~~~~~~~~~~


vim +/FIELD_PREP +16 drivers/phy/aspeed/phy-aspeed-pcie.c

    12	
    13	/* AST2600 PCIe Host Controller Registers */
    14	#define PEHR_GLOBAL		0x30
    15	#define  AST2600_PORT_TYPE_MASK		GENMASK(5, 4)
  > 16	#define  AST2600_PORT_TYPE(x)		FIELD_PREP(AST2600_PORT_TYPE_MASK, x)
    17	#define PEHR_LOCK		0x7c
    18	#define  PCIE_UNLOCK			0xa8
    19	
    20	/* AST2700 PEHR */
    21	#define PEHR_MISC_58		0x58
    22	#define  LOCAL_SCALE_SUP		BIT(0)
    23	#define PEHR_MISC_5C		0x5c
    24	#define  CONFIG_RC_DEVICE		BIT(30)
    25	#define PEHR_MISC_60		0x60
    26	#define  AST2700_PORT_TYPE_MASK		GENMASK(7, 4)
    27	#define  PORT_TYPE_ROOT			0x4
    28	#define PEHR_MISC_70		0x70
    29	#define  POSTED_DATA_CREDITS(x)		FIELD_PREP(GENMASK(15, 0), x)
    30	#define  POSTED_HEADER_CREDITS(x)	FIELD_PREP(GENMASK(27, 16), x)
    31	#define PEHR_MISC_78		0x78
    32	#define  COMPLETION_DATA_CREDITS(x)	FIELD_PREP(GENMASK(15, 0), x)
    33	#define  COMPLETION_HEADER_CREDITS(x)	FIELD_PREP(GENMASK(27, 16), x)
    34	#define PEHR_MISC_278		0x278
    35	#define  SET_TO_DOWNSTREAM		BIT(22)
    36	#define  ASSERT_INTERNAL_RESET		BIT(31)
    37	#define PEHR_MISC_280		0x280
    38	#define  SEL_INTERNAL_RESET		BIT(0)
    39	
    40	/**
    41	 * struct aspeed_pcie_phy - PCIe PHY information
    42	 * @dev: pointer to device structure
    43	 * @reg: PCIe host register base address
    44	 * @clk: PCIe reference clock
    45	 * @phy: pointer to PHY structure
    46	 * @platform: platform specific information
    47	 */
    48	struct aspeed_pcie_phy {
    49		struct device *dev;
    50		void __iomem *reg;
    51		struct clk *clk;
    52		struct phy *phy;
    53		const struct aspeed_pcie_phy_platform *platform;
    54	};
    55	
    56	/**
    57	 * struct aspeed_pcie_phy_platform - Platform information
    58	 * @phy_ops: phy operations
    59	 */
    60	struct aspeed_pcie_phy_platform {
    61		const struct phy_ops *phy_ops;
    62	};
    63	
    64	static int ast2600_phy_init(struct phy *phy)
    65	{
    66		struct aspeed_pcie_phy *pcie_phy = phy_get_drvdata(phy);
    67		int ret;
    68	
    69		ret = clk_prepare_enable(pcie_phy->clk);
    70		if (ret)
    71			return ret;
    72	
    73		writel(PCIE_UNLOCK, pcie_phy->reg + PEHR_LOCK);
    74	
    75		return 0;
    76	}
    77	
    78	static int ast2600_phy_exit(struct phy *phy)
    79	{
    80		struct aspeed_pcie_phy *pcie_phy = phy_get_drvdata(phy);
    81	
    82		clk_disable_unprepare(pcie_phy->clk);
    83	
    84		return 0;
    85	}
    86	
    87	static int ast2600_phy_set_mode(struct phy *phy, enum phy_mode mode,
    88					int submode)
    89	{
    90		struct aspeed_pcie_phy *pcie_phy = phy_get_drvdata(phy);
    91	
    92		switch (submode) {
    93		case PHY_MODE_PCIE_RC:
    94			writel(AST2600_PORT_TYPE(0x3), pcie_phy->reg + PEHR_GLOBAL);
    95			break;
    96		default:
    97			dev_err(&phy->dev, "Unsupported submode %d\n", submode);
    98			return -EINVAL;
    99		}
   100	
   101		return 0;
   102	}
   103	
   104	static const struct phy_ops ast2600_phy_ops = {
   105		.init		= ast2600_phy_init,
   106		.exit		= ast2600_phy_exit,
   107		.set_mode	= ast2600_phy_set_mode,
   108		.owner		= THIS_MODULE,
   109	};
   110	
   111	static int ast2700_phy_init(struct phy *phy)
   112	{
   113		struct aspeed_pcie_phy *pcie_phy = phy_get_drvdata(phy);
   114	
   115		return clk_prepare_enable(pcie_phy->clk);
   116	}
   117	
   118	static int ast2700_phy_exit(struct phy *phy)
   119	{
   120		struct aspeed_pcie_phy *pcie_phy = phy_get_drvdata(phy);
   121	
   122		clk_disable_unprepare(pcie_phy->clk);
   123	
   124		return 0;
   125	}
   126	
   127	static int ast2700_phy_set_mode(struct phy *phy, enum phy_mode mode,
   128					int submode)
   129	{
   130		struct aspeed_pcie_phy *pcie_phy = phy_get_drvdata(phy);
   131		u32 cfg_val;
   132	
   133		switch (submode) {
   134		case PHY_MODE_PCIE_RC:
   135			writel(0, pcie_phy->reg + PEHR_MISC_278);
   136			writel(SEL_INTERNAL_RESET, pcie_phy->reg + PEHR_MISC_280);
   137			writel(POSTED_DATA_CREDITS(0xc0) | POSTED_HEADER_CREDITS(0xa),
   138			       pcie_phy->reg + PEHR_MISC_70);
   139			writel(COMPLETION_DATA_CREDITS(0x30) | COMPLETION_HEADER_CREDITS(0x8),
   140			       pcie_phy->reg + PEHR_MISC_78);
   141			writel(LOCAL_SCALE_SUP, pcie_phy->reg + PEHR_MISC_58);
   142			writel(CONFIG_RC_DEVICE, pcie_phy->reg + PEHR_MISC_5C);
   143			cfg_val = readl(pcie_phy->reg + PEHR_MISC_60);
 > 144			FIELD_MODIFY(AST2700_PORT_TYPE_MASK, &cfg_val,
   145				     PORT_TYPE_ROOT);
   146			writel(cfg_val, pcie_phy->reg + PEHR_MISC_60);
   147			writel(ASSERT_INTERNAL_RESET | SET_TO_DOWNSTREAM,
   148			       pcie_phy->reg + PEHR_MISC_278);
   149			break;
   150		default:
   151			dev_err(&phy->dev, "Unsupported submode %d\n", submode);
   152			return -EINVAL;
   153		}
   154	
   155		return 0;
   156	}
   157	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

