Return-Path: <linux-aspeed+bounces-967-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC2CC28B2E
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Mar 2025 07:29:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZB7n32ZmMz2xYr;
	Mon, 10 Mar 2025 18:29:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741591751;
	cv=none; b=MGSCfT/o+nuSQ9+Pu1Cm4GCYBnG5TKOKVceoCELWLnjo3uTekYRNQExxMnFR+E700tc34tsB3fnLi0ydyv5xsYqgknWNEEPAOkOhCdnpbk37emqkDvyhVB6HQn1v/TXT8tLp3moobZoE4gLNd+prCifWOoyem5zL2H3T76MSeKBlERhZmClnrXBlYbEeRqvn94QuZ7MhIc9ZyLByZj+SLp1Uhk6uNufi8jFdbfy/tBSNHpkaT4UkJi30pJXHBpqc+Izez5BNGuRX3FoaKCxx+TyI++zEEwtxn+FKsmVUY6WtjizQGhXHzw1qdK7ELq1137V8HxkoV6C1I4Gysgb/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741591751; c=relaxed/relaxed;
	bh=I//R11pZ/daiN1uG0GFWL5OWJgcHhql990ete3j3oC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ch9rP4pJTAHgCN55Lkgj/v9xAzLX01qwxHrFudEKWctUx5WJuuILtsokpRBInu08hC1N9/lAfzSFd4zs3yq7gtoU4FKuh7yOs2XsW+lCh10Mpl5w5C7DmDgZJ3aY8Ow8waR/y5BX5/Z+mpjhVfoMS716Duca+EKSI9jl0UHMlMn2kkgef1XvEypIB1tmwCmGePPvhcU8174Wc9iCfzbk9UyADlMEAV9RZvZpMeZMTgi4m5iqHAIgExAqVmd6621vv15FE3x33Jweb6GYy+hpVwR8Xp7iogfPHYOk2kr44RaaDMbgYUK/CWQKo1szLUCOPH6MT+IbwWcjMMQ7SmqKHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XQ28rdEi; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XQ28rdEi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZB7n10xMpz2x9N
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Mar 2025 18:29:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741591749; x=1773127749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ssEg4vPopMVhOA1s0W0lhcWOtIh6Cxqt2KYRDMOOri4=;
  b=XQ28rdEi1FPxogyWWIE0QUuQ67HjMJKx5kRwhhgVYhG/wecl54ENe6WO
   glmK4hD7VQdT9HO5ywjJ+ABR9O9HtVVW2tY463HkHVDHjGiW4oV7sOI4T
   5Ti+744Dfq+RZC2NdA4mpuMkSaDivQYMlRQP7Os72kh0ux0o2Dw3c2uDF
   1lm2DC/xEjBi/O1wZvuRhLs8MOKMYdNtNVfznxCPpri0cnUkNrQRP/SVh
   ebl0kcdWjf0gy/h0Y7M6lPBkYLhv01tKUlco556+5FfxQx5QtWI+PCOKG
   DYrkGG/nxIardcJx8FFOZso0OlYw4fTf5IkHbtMo3TzXu6S5xdMZKzX+f
   w==;
X-CSE-ConnectionGUID: 7K0yRQtlRBGr0vdJr53Qxg==
X-CSE-MsgGUID: S0XrZshPRquocUGaFXcNAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="65017626"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="65017626"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 00:29:04 -0700
X-CSE-ConnectionGUID: iTIwBm7ARi+jwHUHMJcJjw==
X-CSE-MsgGUID: dq70DRYETUWoDTmHCnfvGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119847504"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 10 Mar 2025 00:29:01 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trXZ9-0003wI-0V;
	Mon, 10 Mar 2025 07:28:50 +0000
Date: Mon, 10 Mar 2025 15:26:49 +0800
From: kernel test robot <lkp@intel.com>
To: Kevin Chen <kevin_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, derek.kiernan@amd.com,
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Kevin Chen <kevin_chen@aspeedtech.com>
Subject: Re: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Message-ID: <202503101519.AIZNCLz1-lkp@intel.com>
References: <20250304104434.481429-4-kevin_chen@aspeedtech.com>
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
In-Reply-To: <20250304104434.481429-4-kevin_chen@aspeedtech.com>

Hi Kevin,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus robh/for-next linus/master v6.14-rc6 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kevin-Chen/ARM-dts-aspeed-g6-Add-AST2600-LPC-PCC-support/20250304-194530
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20250304104434.481429-4-kevin_chen%40aspeedtech.com
patch subject: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
config: s390-randconfig-r112-20250310 (https://download.01.org/0day-ci/archive/20250310/202503101519.AIZNCLz1-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250310/202503101519.AIZNCLz1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503101519.AIZNCLz1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/io.h:14,
                    from include/linux/of_address.h:7,
                    from drivers/mfd/syscon.c:18:
   drivers/mfd/syscon.c: In function 'of_syscon_register':
>> arch/s390/include/asm/io.h:31:17: error: implicit declaration of function 'iounmap' [-Wimplicit-function-declaration]
      31 | #define iounmap iounmap
         |                 ^~~~~~~
   drivers/mfd/syscon.c:157:9: note: in expansion of macro 'iounmap'
     157 |         iounmap(base);
         |         ^~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_SYSCON
   Depends on [n]: HAS_IOMEM [=n]
   Selected by [y]:
   - ASPEED_LPC_PCC [=y]


vim +/iounmap +31 arch/s390/include/asm/io.h

cd24834130ac65 Jan Glauber 2012-11-29  26  
b43b3fff042d08 Baoquan He  2023-07-06  27  /*
b43b3fff042d08 Baoquan He  2023-07-06  28   * I/O memory mapping functions.
b43b3fff042d08 Baoquan He  2023-07-06  29   */
b43b3fff042d08 Baoquan He  2023-07-06  30  #define ioremap_prot ioremap_prot
b43b3fff042d08 Baoquan He  2023-07-06 @31  #define iounmap iounmap
b43b3fff042d08 Baoquan He  2023-07-06  32  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

