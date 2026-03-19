Return-Path: <linux-aspeed+bounces-3717-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE131091934
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Mar 2026 23:55:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcMyC6GVcz2xnh;
	Fri, 20 Mar 2026 10:55:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773964515;
	cv=none; b=XSyTj9Si1v0w2oqiXcRuPMJfheI7DT+R5X/foyWx1CXNYD+OhKOfc5MdM4X8C6qp8W12sI2ZMRFDxZJDgCHBszFu+MAAaaz6UsF9cKgMX7auwKWq47Tf6xLWRTx8QytOkkvNUIPWAx3doMxjumslFBRJjWKtp4lvLHgTnonWq+eOV//9jF3jCzRFaQy/zaUsIpf1BtcINwWGenrYu5QT1I9l7mqE8F0eGBdZEV3XMhvgig59JzgWWkHE3b76XkXhBqM2NVO6PfvehaG+jd5CxpogJ+RXVNCvfOuIj61qVhJdRsYos+I49+RoiNBYXQW+CkDcVs3DRd1inp9E01Q34w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773964515; c=relaxed/relaxed;
	bh=waf2PG8psEUFk3GCO5J738brbUdR7U/sXIHicgDZK3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mw/OBvgtfainY+Kdd8kULKd3ZUPQCgU+Knge+gikHBrsIPf/EC6IlXtTdlqCzEPRN87UEY6hhYxgUiUqtut6ZMBeQ3XhJRCa46P8PVxLnvwz7ablFsTZKzdAh+asGIazh7ZMtCCrxfsCOrZ6CeIB3L3sr5ALX81414iwc1+wrgMu1tGkz0mfyFxVhw3PlSHQT0pda6zfYwvo1I1joVAes19TQYoogkQfxoMpgrjdJbSLEwOP5G4c9WGycpOXKfLWs/eoGsqYMM7K0jeelscFP9bkPxa4drmtlhRX3J/tDqAktiyZYFro0o/+szQpIAAUv89AIsG6W4cUxYptTvwiTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OFCn2Miu; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OFCn2Miu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcMy82x5Yz2xN2;
	Fri, 20 Mar 2026 10:55:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773964513; x=1805500513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r/SbXPFP/ykN1nLBK9p10AiU3ezsLWp1iV0fpBfCrpY=;
  b=OFCn2MiueOgHq2BQCnc0WCazDmmQ4FSb9ptQZg27xfAQtObXCFTJeRSG
   Razj71OE0T7/pauQ7eCmP/BFlz/VUhHb2ZN3lNDUlEogQyyZe4G0gDfxY
   NSs8UchNBNLegnH8J6vjBwSU3VYWalkPdcLCPz94cD5VqlZhUgog82AMY
   HJO3lJxOtDkTPQ23HuHMB0Qn+H5F7FZtB2Lni06zpNOQ3Pdd7zQUBM3xW
   mRd1wDHnTffe/bbioAXe4eioPW9V6dM/jRK1ANV4mqGgP8bSjonWOPIvF
   7q0rYkYvzzI3mPQwqs/8zJRuw+N7ejSZ1I0vGcNKo7A1CAxuGSYqjZJAz
   g==;
X-CSE-ConnectionGUID: NCCGbZjZRg67PM4cgaPe4Q==
X-CSE-MsgGUID: J61uyi8iQ8e38tamKqDKDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="62612636"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="62612636"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 16:55:07 -0700
X-CSE-ConnectionGUID: HphZLJquTpmTIN6wubYLGw==
X-CSE-MsgGUID: 4aygXDj7Tv618DsIpcD7yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="261016791"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 19 Mar 2026 16:55:03 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3NCe-000000001nJ-25Ey;
	Thu, 19 Mar 2026 23:55:00 +0000
Date: Fri, 20 Mar 2026 07:53:04 +0800
From: kernel test robot <lkp@intel.com>
To: aspeedyh <yh_chung@aspeedtech.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	maciej.lawniczak@intel.com, aspeedyh <yh_chung@aspeedtech.com>
Subject: Re: [PATCH 5/7] soc: aspeed: Add eSPI flash channel support
Message-ID: <202603200700.6fddOZHQ-lkp@intel.com>
References: <20260313-upstream_espi-v1-5-9504428e1f43@aspeedtech.com>
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
In-Reply-To: <20260313-upstream_espi-v1-5-9504428e1f43@aspeedtech.com>

Hi aspeedyh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a]

url:    https://github.com/intel-lab-lkp/linux/commits/aspeedyh/dt-bindings-soc-aspeed-Add-AST2600-eSPI-controller/20260315-101647
base:   0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
patch link:    https://lore.kernel.org/r/20260313-upstream_espi-v1-5-9504428e1f43%40aspeedtech.com
patch subject: [PATCH 5/7] soc: aspeed: Add eSPI flash channel support
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260320/202603200700.6fddOZHQ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260320/202603200700.6fddOZHQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603200700.6fddOZHQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/soc/aspeed/espi/ast2600-espi.c: In function 'ast2600_espi_flash_reset':
   drivers/soc/aspeed/espi/ast2600-espi.c:137:16: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     137 |         reg |= FIELD_PREP(ESPI_CTRL_FLASH_TAFS_MODE, flash->tafs.mode);
         |                ^~~~~~~~~~
   drivers/soc/aspeed/espi/ast2600-espi.c: In function 'ast2600_espi_flash_remove':
>> drivers/soc/aspeed/espi/ast2600-espi.c:172:35: warning: variable 'flash' set but not used [-Wunused-but-set-variable]
     172 |         struct aspeed_espi_flash *flash;
         |                                   ^~~~~
   drivers/soc/aspeed/espi/ast2600-espi.c: In function 'ast2600_espi_flash_get_hdr':
   drivers/soc/aspeed/espi/ast2600-espi.c:194:20: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     194 |         hdr->cyc = FIELD_GET(ESPI_FLASH_RX_CTRL_CYC, reg);
         |                    ^~~~~~~~~


vim +/flash +172 drivers/soc/aspeed/espi/ast2600-espi.c

   169	
   170	int ast2600_espi_flash_remove(struct aspeed_espi *espi)
   171	{
 > 172		struct aspeed_espi_flash *flash;
   173		u32 reg;
   174	
   175		flash = &espi->flash;
   176	
   177		writel(ESPI_INT_EN_FLASH, espi->regs + ESPI_INT_EN_CLR);
   178	
   179		reg = readl(espi->regs + ESPI_CTRL);
   180		reg &= ~(ESPI_CTRL_FLASH_TX_DMA_EN
   181			 | ESPI_CTRL_FLASH_RX_DMA_EN
   182			 | ESPI_CTRL_FLASH_SW_RDY);
   183		writel(reg, espi->regs + ESPI_CTRL);
   184	
   185		return 0;
   186	}
   187	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

