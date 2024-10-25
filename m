Return-Path: <linux-aspeed+bounces-36-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E84D0C61B
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Oct 2024 14:57:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZm8y6t24z2xPb;
	Sat, 26 Oct 2024 01:57:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729868242;
	cv=none; b=gk8j2gyY8YGKidpq02d2B+FcfXJUJkUN5bfmDYNm/6phBfDCz+J97Jp0A1QQa9C4MjWe5hlqpqSMHpl5MaYO1pPvEB53HuGyZewKlx16fYCDQVK788SRoafJtZJ8j3ZUyHtHWcs0FjHPOeolWf7AeQ4Qh4dMTpIboOh9XoQui2+PJp9Ay71bPmHtMUNaNzSkUFAMnlFVJN1SKkOVIRtW6Z5fPxgccAqyPII0KWefsrEGizX+FL/0c9ELOCM1shp5SLo7GRDtI1xsdn14yBRfbjeLTgooaKeyU6EXONkKnEdOPvjxxn43AhZt/KjnaoHXtUinswBqqNsCUxfcIpteFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729868242; c=relaxed/relaxed;
	bh=+V+9768taUvAAR9n9sO9MLQWWRG0UQS5MiH998erbmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUAlTYm40FGfnRonETwkxUgiIYeiR0/eL3Ck5qii9T7SSjVCGAKLOe9PrpPp51P6fMWwgFl6gahGnHZs+sMshzdW5YFf/bXBmmUro8KphVdDCXqW2E8OQ2adNVKVIdJo57zMB1llwn2jg+g0JZeyIYAR/CQQXfWtlAFWPVRgkA9pKFwDMSTAw1COIQG/j1HlFS9oP/F8FtmTVnldnP+42Xw+X4qrUH2tDsdn5SsCzoIZUXNggNqjZhcMUFgTZuDD97d7+qCPXZJ8ceHRcZfqPuEz4b12DRLqFKWrbTo2+S9o9Zzhs9IMshPrIWTSOH087qWLc5T6o8kJB15tU60TxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PCShwSZg; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PCShwSZg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZm8v4mQGz2xGt
	for <linux-aspeed@lists.ozlabs.org>; Sat, 26 Oct 2024 01:57:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729868240; x=1761404240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=slQFkpvsOAihEgvv9wUjUeRexTrOCI2advJJoQkRFNw=;
  b=PCShwSZgKrqbQi6Wjz08hMqt5cpaLZI7M7MIlj+DVCNscKwQne4vhlZx
   xfDiVOd02nTDSyBhFgGGOhNEmFYHTWVfegeMKcSc0iVCMLk8Bg3PTmc3X
   kW6xMMDPtP50xeFx6KtS2auHr7EvuN5LaSlqzzDhnU/mISCmgnABpzCCc
   ep17DNwBl6mKDnvgYbyVhKU9Zn6lK2mbwUhCwexkDgAx3BGr+l6Ni66F0
   xwpxM+3Muzm79wvNxbeIoE8V35Au4D9luJ5+AiyjvbW7Asyb7cr1LzlZB
   FQIjO3k1QhDNx/URy3ipsNwcSOcPvlkHSGKBXu536xiB7CqQamdWJlr+2
   A==;
X-CSE-ConnectionGUID: lLP8oaT3Q5epq5X1CPrBfQ==
X-CSE-MsgGUID: 1JbY6xwURcqU6epAcvLqaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="47023395"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="47023395"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:57:12 -0700
X-CSE-ConnectionGUID: kFs+VMZSS8yTo5wXD3UPKA==
X-CSE-MsgGUID: CqzqTi+lQnmMt48hJypgFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="81239477"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Oct 2024 07:57:09 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4LkQ-000YNi-1v;
	Fri, 25 Oct 2024 14:57:06 +0000
Date: Fri, 25 Oct 2024 22:56:45 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 3/3] clk: aspeed: add AST2700 clock driver.
Message-ID: <202410252216.a0X0bOLS-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on pza/reset/next lee-mfd/for-mfd-next lee-leds/for-leds-next linus/master lee-mfd/for-mfd-fixes v6.12-rc4 next-20241025]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-mfd-aspeed-support-for-AST2700/20241023-170434
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20241023090153.1395220-4-ryan_chen%40aspeedtech.com
patch subject: [PATCH v6 3/3] clk: aspeed: add AST2700 clock driver.
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241025/202410252216.a0X0bOLS-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410252216.a0X0bOLS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410252216.a0X0bOLS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: aspeed_reset_controller_register
   >>> referenced by clk-ast2700.c
   >>>               drivers/clk/clk-ast2700.o:(ast2700_soc_clk_probe) in archive vmlinux.a
   >>> referenced by clk-ast2700.c
   >>>               drivers/clk/clk-ast2700.o:(ast2700_soc_clk_probe) in archive vmlinux.a

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

