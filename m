Return-Path: <linux-aspeed+bounces-2164-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E906BCA1002
	for <linux-aspeed@archiver.kernel.org>; Sat,  6 Sep 2025 21:26:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cK5rG74Wnz3cYR;
	Sun,  7 Sep 2025 07:26:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757193998;
	cv=none; b=YVQILoE1kzbvRV3HXtBee6tZW4IhOwDUfAK5Tgur4rKb0/6FDnlB54taJyvK7j70ti5B0WsxUpXK3IMDwyIjaMjFKKpNt9wqBF0s3v27Z7HINFc6/XSFhexiD3q/SMTANaSbhEXo/8A3ujWEcJx0tFQdKMROL7vybgAawblBhprX8LbkzWAhJCjTdPHBHywU4jYeAA3I5N3H8IxN541WgBtQdduwbhdGrTYO6mCnghUG4bXRooewUAzTQxeoSpggsnb2AA0+rzLsdXsx2L+5KnN7/3Qk3FsMz/dF4y/Q2pZMHHvuQbjAgly6U6CAcyMlC2H11+Qu+PpVzbUcp2J2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757193998; c=relaxed/relaxed;
	bh=bpGvdDDzxeb87tuqFs6ccwLx+keES1rnW17BWnp2DKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjR3Mil0WDMvGrzalDc9JuId+xx2wEHZY7Nn8bQjZjazNAPN3b2YCLLg6x6g5QNJMYeLuWTtYpmOYJ4UtNPNkI3RcNRN/V6LjTIrn46fTMuRrxigU+lCHZweVCS2KW/sIiUQFHuC9gdBT6Dhl5B4G9Lq/GwiIaFgZa524zjAb/n71ah0ODGMvVStOecMsPIrG+JChniGKpN0hLeIR5GX4/2jwYek6Gr73cBbYiBWxaQpBfmDixeKb9rkKayNGFUqQKxC02cFTa4doa3fFBXXNHAW15O+aZYEQMHSjDHB+AERT1xpNS4hpwU/ONXUSA88JfNN6L3Gq87EM5FUe5I8Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jKsZEYKU; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jKsZEYKU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cK5rD6tlTz3cYL
	for <linux-aspeed@lists.ozlabs.org>; Sun,  7 Sep 2025 07:26:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757193997; x=1788729997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CMGs8i3Y8nSpfA6lMpvHldw8w4ip7mYjXqWISfeH/PM=;
  b=jKsZEYKUkWeIXNG+zwcdZdg+3YehNi+ogS09PFpRkTKsnr3UtmJZ4avb
   U8sBjbFI0VQZLZ5k4HBB/rtyp2GMGcC2NdIlszEnDb5FFQs5pGWn/elg1
   eI967CicoEpyY4tOgNuwDC01+ZeuCgmTrlOFtbfXHkdXLsMq4zKQJQvGn
   3B/sptJnZgtMAV2kvK6ppI+p+71xFBwPlcs1zUIp5DTJMG9lghRkE15J/
   ppQYJaGXelZQrWtqR7XfcjCEch+6aUtthgQQKsONp+nPtsWpTrZ2gD/4d
   CZnPHTiZaLTapbHRFSIVFMdB+sKQpkvAhiuSIH5S+my8izdxGwuz8PhmB
   Q==;
X-CSE-ConnectionGUID: 1ZuuVKbtSBySASaWUYevKA==
X-CSE-MsgGUID: 0UKCGShSQjSb5Qgs/VjcsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="58715848"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="58715848"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 14:26:31 -0700
X-CSE-ConnectionGUID: VbX9FkwRSrCKGheZZSUk1w==
X-CSE-MsgGUID: XHIZwNXBQuyDKp8oVdJh6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="172009225"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 Sep 2025 14:26:27 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv0QT-0001np-1W;
	Sat, 06 Sep 2025 21:26:25 +0000
Date: Sun, 7 Sep 2025 05:26:13 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
	Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SCU
 interrupt controllers
Message-ID: <202509070538.5HcCJf2T-lkp@intel.com>
References: <20250906014846.861368-5-ryan_chen@aspeedtech.com>
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
In-Reply-To: <20250906014846.861368-5-ryan_chen@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on robh/for-next lee-mfd/for-mfd-next lee-mfd/for-mfd-fixes linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/irqchip-aspeed-scu-ic-Refactor-driver-to-support-variant-based-initialization/20250906-095043
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20250906014846.861368-5-ryan_chen%40aspeedtech.com
patch subject: [PATCH v3 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SCU interrupt controllers
config: arm-randconfig-001-20250906 (https://download.01.org/0day-ci/archive/20250907/202509070538.5HcCJf2T-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7fb1dc08d2f025aad5777bb779dfac1197e9ef87)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250907/202509070538.5HcCJf2T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509070538.5HcCJf2T-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/irqchip/irq-aspeed-scu-ic.c:93:34: warning: variable 'mask' is uninitialized when used here [-Wuninitialized]
      93 |                 writel((readl(scu_ic->base) & ~mask) |
         |                                                ^~~~
   drivers/irqchip/irq-aspeed-scu-ic.c:69:24: note: initialize the variable 'mask' to silence this warning
      69 |         unsigned int sts, mask;
         |                               ^
         |                                = 0
>> drivers/irqchip/irq-aspeed-scu-ic.c:106:20: warning: variable 'mask' set but not used [-Wunused-but-set-variable]
     106 |         unsigned int sts, mask;
         |                           ^
   2 warnings generated.


vim +/mask +106 drivers/irqchip/irq-aspeed-scu-ic.c

   100	
   101	static void aspeed_scu_ic_irq_handler_split(struct irq_desc *desc)
   102	{
   103		struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
   104		struct irq_chip *chip = irq_desc_get_chip(desc);
   105		unsigned long bit, enabled, max, status;
 > 106		unsigned int sts, mask;
   107	
   108		chained_irq_enter(chip, desc);
   109	
   110		mask = scu_ic->irq_enable;
   111		sts = readl(scu_ic->base + scu_ic->isr);
   112		enabled = sts & scu_ic->irq_enable;
   113		sts = readl(scu_ic->base + scu_ic->isr);
   114		status = sts & enabled;
   115	
   116		bit = scu_ic->irq_shift;
   117		max = scu_ic->num_irqs + bit;
   118	
   119		for_each_set_bit_from(bit, &status, max) {
   120			generic_handle_domain_irq(scu_ic->irq_domain, bit - scu_ic->irq_shift);
   121			writel(BIT(bit), scu_ic->base + scu_ic->isr); // clear interrupt
   122		}
   123	
   124		chained_irq_exit(chip, desc);
   125	}
   126	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

