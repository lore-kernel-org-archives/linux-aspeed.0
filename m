Return-Path: <linux-aspeed+bounces-3791-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC8710F2871
	for <linux-aspeed@archiver.kernel.org>; Fri, 27 Mar 2026 20:58:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjCfd6R15z2yVt;
	Sat, 28 Mar 2026 07:58:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774645113;
	cv=none; b=YpCuKXpcy9BDsmGSxnTM0cW0LrqVGruHB9cXjJni7FKGhbRC9SHunLbVlYJ09yciCbeZwaUDd1hH+ggsZmivC6gcIj9n+SJry4fVHhDkqgyRNfEW7GtXZAsQ6aeZt8rhcaiD6b+K5i2EJhCziJsh2NEFGKTKDwO4op/HNrdfJzKmT1JhrWSQ4tAeAM+XbxAwxreVvs0MIvtNVW5gLGfoj22S1lF2QpRXgJjyzGVK5ow4CBmBtj7chHLi6CwRPrEVt3GGEdi3gTFV8Tzcs75doICE7zdOayhjWEf2z6iheuYGux7AgKBIRkZP9o9LKgoxuyfJs75bOGzywzb/1RK7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774645113; c=relaxed/relaxed;
	bh=DwAKLwoYIfJJCtkX3cFuEqma6KKhnGBwbiyeffmGJmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWpWNjWxKbrlKwfoZqLpkUpahNkGgk1QDuIHB9fOm2pHn4d8V74lHP9FpkED6PeeUwSrzlreJg/ifjFTZ5HGBE2NwaeUAddC80Y/kyLaN813ODyn557k1ezxYSG2LeRDQfNMIwUgmKASvKWnqQ8WcpPW6X3AbqT/nQcPHgcTS5t00e687R9WKS1tV5hqW+NCPfDwzYJ6knQ2UpxL30YpeLFQ/nF3o8YbxZppeYNa4cRNB8w6JWVSqwIQI3AG+Gka/XAgWW1DAHpZcGCIjNsvArCKjxsDpK82XqcAkPOD/IylMn8LxjVpvs90LJGhu73cXkKDfcMWqmcpKr14NR16Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gsrfWlra; dkim-atps=neutral; spf=pass (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gsrfWlra;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjCfb080nz2yS4
	for <linux-aspeed@lists.ozlabs.org>; Sat, 28 Mar 2026 07:58:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774645111; x=1806181111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SQR0YyvvNKZ19ivSH0b+y9Tjg/QCeOc1Y/8TMEN1CZY=;
  b=gsrfWlra4xdkarPOuu2MdyGSExjDG838aQr/sKzHQgSgLFle6lA2KJOl
   9OU6jtyyFZImTpcgJ45jtUwHhRd0xLYaGWonANdgppWSzDXR/pBxphxJO
   xOhGw5XlqA4QuRqPALllfOeRbMlm8To0usBRWpBdQOvyV0Wr97kDgnhAK
   uYUYdaHUxVgLyQGuvv5egwslIcVJYYqYAN1HC7x45LevRliwTqiO+0BRP
   +go/NYQ36q/4Glca45hB9GceIQZOaOmIfUt4jtKo73U+GDJgPPqOJQoCY
   M5RCf1IWqB9n0/1AUCZe+ENbtxzttYZj58tvhFvEBIzOhJPyYrppQXIXd
   Q==;
X-CSE-ConnectionGUID: pH8Xp1MwRwaWXZEJlT83gQ==
X-CSE-MsgGUID: TJvg/9qwQ16l2oI6SQdZng==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75439712"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="75439712"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:58:25 -0700
X-CSE-ConnectionGUID: UYhKLyDwTgG2QT2x7s+T8g==
X-CSE-MsgGUID: hT6cdgmqQ9CvuiYlrtr0LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="221023310"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 27 Mar 2026 13:58:21 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6EG2-00000000Ak1-2ELz;
	Fri, 27 Mar 2026 20:58:18 +0000
Date: Sat, 28 Mar 2026 04:58:07 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v3 3/4] irqchip/ast2700-intc: Add KUnit tests for route
 resolution
Message-ID: <202603280415.xv0eHt8u-lkp@intel.com>
References: <20260326-irqchip-v3-3-366739f57acf@aspeedtech.com>
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
In-Reply-To: <20260326-irqchip-v3-3-366739f57acf@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-interrupt-controller-Describe-AST2700-A2-hardware-instead-of-A0/20260327-190127
base:   6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
patch link:    https://lore.kernel.org/r/20260326-irqchip-v3-3-366739f57acf%40aspeedtech.com
patch subject: [PATCH v3 3/4] irqchip/ast2700-intc: Add KUnit tests for route resolution
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20260328/202603280415.xv0eHt8u-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603280415.xv0eHt8u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603280415.xv0eHt8u-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/irqchip/irq-ast2700-intc0-test.c: In function 'aspeed_intc0_resolve_route_c1i1o1mc0i2o1':
>> drivers/irqchip/irq-ast2700-intc0-test.c:351:1: warning: the frame size of 1296 bytes is larger than 1280 bytes [-Wframe-larger-than=]
     351 | }
         | ^
   drivers/irqchip/irq-ast2700-intc0-test.c: In function 'aspeed_intc0_resolve_route_c1i2o2mc0i1o1':
   drivers/irqchip/irq-ast2700-intc0-test.c:292:1: warning: the frame size of 1296 bytes is larger than 1280 bytes [-Wframe-larger-than=]
     292 | }
         | ^


vim +351 drivers/irqchip/irq-ast2700-intc0-test.c

   293	
   294	static void aspeed_intc0_resolve_route_c1i1o1mc0i2o1(struct kunit *test)
   295	{
   296		struct device_node intc0_node = {
   297			.fwnode = { .ops = &intc0_fwnode_ops },
   298		};
   299		struct aspeed_intc_interrupt_range c1ranges[] = {
   300			{
   301				.start = 0,
   302				.count = 1,
   303				.upstream = {
   304					.fwnode = &intc0_node.fwnode,
   305					.param_count = 1,
   306					.param = { 510 }
   307				}
   308			},
   309		};
   310		static const u32 c1outs[] = { 0 };
   311		struct aspeed_intc_interrupt_range resolved;
   312		struct aspeed_intc_interrupt_range intc0_ranges[] = {
   313			{
   314				.start = 192,
   315				.count = 1,
   316				.upstream = {
   317					.fwnode = NULL,
   318					.param_count = 0,
   319					.param = {0},
   320				}
   321			},
   322			{
   323				.start = 208,
   324				.count = 1,
   325				.upstream = {
   326					.fwnode = NULL,
   327					.param_count = 0,
   328					.param = {0},
   329				}
   330			}
   331		};
   332		struct aspeed_intc0 intc0 = {
   333			.ranges = {
   334				.ranges = intc0_ranges,
   335				.nranges = ARRAY_SIZE(intc0_ranges),
   336			}
   337		};
   338		const struct irq_domain c0domain = {
   339			.host_data = &intc0,
   340			.fwnode = &intc0_node.fwnode
   341		};
   342		int rc;
   343	
   344		rc = aspeed_intc0_resolve_route(&c0domain, ARRAY_SIZE(c1outs), c1outs,
   345						ARRAY_SIZE(c1ranges), c1ranges,
   346						&resolved);
   347		KUNIT_EXPECT_EQ(test, rc, 0);
   348		KUNIT_EXPECT_EQ(test, resolved.start, 0);
   349		KUNIT_EXPECT_EQ(test, resolved.count, 1);
   350		KUNIT_EXPECT_EQ(test, resolved.upstream.param[0], 510);
 > 351	}
   352	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

