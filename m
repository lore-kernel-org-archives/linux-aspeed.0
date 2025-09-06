Return-Path: <linux-aspeed+bounces-2163-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F211CA1002
	for <linux-aspeed@archiver.kernel.org>; Sat,  6 Sep 2025 17:13:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cK0D53TFdz3cYq;
	Sun,  7 Sep 2025 03:13:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757178805;
	cv=none; b=kZjk7H6LJOMqSPHsW/etRsPHLRaO622ED3mzolyJZWuDWoCIWvuo8RqdYG7o0TAvK9XPfFmHXlD/Z0XhQTzCPecSmop/4CduONPoEnF3G3PFNjQuj8XeS4P0k/NbkfFn8ZG4Ldmy6a07JpedFOTmA7Ms632J5WCZGWCmAV29hUklsMJeT3JQgToMr7K6u7m5C4dGHeuwq2W9RWFB2LULk8SWs9gK+hGJjWbYstYgg2cb7UuRyvvLaaYWGrkcE3v/bDK5lenhbDC5CHdSqlM1NZ4d3biFWSIVZDWNf496DeXaiOTRv/nR+Q3WlAHc3jghDTcMrx/HvLLsVaqoknfcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757178805; c=relaxed/relaxed;
	bh=QeLnel44jgOiYNiaqvGTFJsZYpBvv9pN2W15LbKBpBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ky0K+sOztTNoOPulcMjU2l6dn+wkq3nfulMdTAxV9vOY23/GY6qwcEve0a2yvkBsXD8wpUjAAQiPT7DbeV2X5phYFya8p7Ds+sM3BrXWRfF2r+2eBmaEUqaDzRSsK1BpoSfKIs0GnztR7s2usoSt9x63Akf2/BUb0jCpuzyhzivPLxJjfCoP29EvuObOC5MZhWyoA16rDSLGU4j6vKJ4qSl7AGzP4vrr/ZlMGsS0XijGx7pizhyONP+K16dws4hMYE+u26Mh8ey6AUYfCSEBdnRfFnVl13frvXEPOq29MtmjZp5El5dhYDNk6OQtBsoWiXWjs5wRphN2VqYWQdR3yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rzo1XuZz; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rzo1XuZz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cK0D302kDz3c7q
	for <linux-aspeed@lists.ozlabs.org>; Sun,  7 Sep 2025 03:13:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757178804; x=1788714804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mv/Y3kvQFgparfIlQNQwNiMV1wrcDKs1S8/YH+Ac6po=;
  b=Rzo1XuZzEf2awQCfEFvsP6bsfjlLUAINaJPaQ9shjFB+VvQfRb3fPhdf
   qymSErwoxdkZoTYGV3cO+pvQUVRYsEaH8fxgF00tpaldueHz8KlvVbd+Q
   ARzIkaYWYb1frl11ywcyoDyGz/Oorh32YB2edASfc6LAjWzzgildEML9T
   MgK+7dv4Ye9hfJSKvrOyhmQklyxY36V/7mzGviPxOkT73H4hQiDzU4/VR
   l0BkvPWDVq5v0KjQMpheYEcGL7g3lm9KQEoU71iDjJS7ZpKvxfz3MDnV8
   tX8v22JGDaq5TOrroDfOvL2J4bfCYi2os8PlTe7ZkXtODlXPUZ052be70
   A==;
X-CSE-ConnectionGUID: GNwzS/X7QxW9syIW8CtPOw==
X-CSE-MsgGUID: 70FA6BYbTUmao8+Duljfwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="70926736"
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="70926736"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 10:13:11 -0700
X-CSE-ConnectionGUID: 3WS+ZCjMTFaHD/3JOA6TTw==
X-CSE-MsgGUID: 0iif958RTK6QdgJj0vJWIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="172298134"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 06 Sep 2025 10:13:07 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuwTI-0001g7-1o;
	Sat, 06 Sep 2025 17:13:04 +0000
Date: Sun, 7 Sep 2025 01:12:31 +0800
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
Subject: Re: [PATCH v3 1/4] irqchip/aspeed-scu-ic: Refactor driver to support
 variant-based initialization
Message-ID: <202509070058.3Z4AtICl-lkp@intel.com>
References: <20250906014846.861368-2-ryan_chen@aspeedtech.com>
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
In-Reply-To: <20250906014846.861368-2-ryan_chen@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on robh/for-next lee-mfd/for-mfd-next lee-mfd/for-mfd-fixes linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/irqchip-aspeed-scu-ic-Refactor-driver-to-support-variant-based-initialization/20250906-095043
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20250906014846.861368-2-ryan_chen%40aspeedtech.com
patch subject: [PATCH v3 1/4] irqchip/aspeed-scu-ic: Refactor driver to support variant-based initialization
config: arm-randconfig-001-20250906 (https://download.01.org/0day-ci/archive/20250907/202509070058.3Z4AtICl-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7fb1dc08d2f025aad5777bb779dfac1197e9ef87)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250907/202509070058.3Z4AtICl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509070058.3Z4AtICl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-aspeed-scu-ic.c:79:34: warning: variable 'mask' is uninitialized when used here [-Wuninitialized]
      79 |                 writel((readl(scu_ic->base) & ~mask) |
         |                                                ^~~~
   drivers/irqchip/irq-aspeed-scu-ic.c:55:24: note: initialize the variable 'mask' to silence this warning
      55 |         unsigned int sts, mask;
         |                               ^
         |                                = 0
   1 warning generated.


vim +/mask +79 drivers/irqchip/irq-aspeed-scu-ic.c

    49	
    50	static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
    51	{
    52		struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
    53		struct irq_chip *chip = irq_desc_get_chip(desc);
    54		unsigned long bit, enabled, max, status;
    55		unsigned int sts, mask;
    56	
    57		chained_irq_enter(chip, desc);
    58	
    59		/*
    60		 * The SCU IC has just one register to control its operation and read
    61		 * status. The interrupt enable bits occupy the lower 16 bits of the
    62		 * register, while the interrupt status bits occupy the upper 16 bits.
    63		 * The status bit for a given interrupt is always 16 bits shifted from
    64		 * the enable bit for the same interrupt.
    65		 * Therefore, perform the IRQ operations in the enable bit space by
    66		 * shifting the status down to get the mapping and then back up to
    67		 * clear the bit.
    68		 */
    69		sts = readl(scu_ic->base);
    70		enabled = sts & scu_ic->irq_enable;
    71		status = (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
    72	
    73		bit = scu_ic->irq_shift;
    74		max = scu_ic->num_irqs + bit;
    75	
    76		for_each_set_bit_from(bit, &status, max) {
    77			generic_handle_domain_irq(scu_ic->irq_domain,
    78						  bit - scu_ic->irq_shift);
  > 79			writel((readl(scu_ic->base) & ~mask) |
    80			       BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT),
    81			       scu_ic->base);
    82		}
    83	
    84		chained_irq_exit(chip, desc);
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

