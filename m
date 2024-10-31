Return-Path: <linux-aspeed+bounces-58-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C88E68940
	for <linux-aspeed@archiver.kernel.org>; Thu, 31 Oct 2024 00:45:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xf4zn0vRdz2yDm;
	Thu, 31 Oct 2024 11:45:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730335557;
	cv=none; b=XfVRbArd0lwl37+5WiF+DrcAdQ7hP8vdrdE91i2T+S3dl/gwPsI7YFJgtBiy87jCXWhX9MdNkj12fsJ71Hb/oQSUzxVmaR/KxN0vVSajxtFZSnXtvBx2PtmeJOIS4rDkBnSFtQAZOnHzoIuwev+RFh7Q9BVbFY09yBoEcBJTctOj4hMiOK5/6L3+Ob36jcDM1oYJFNBA6Acl6D+r6rTh3rUga4wlZF2t0lZoaYa5RGbMmO1mvq42+MlUH4xezVWf8P1ws2wu5qFQR27tGD2cCrhkHp1AegCrmKvkpc+lHndzcZ4Iq+0COxWkYAhdgMnbdGIUrroQ4D3kw8a76iJeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730335557; c=relaxed/relaxed;
	bh=iHOBCHB+gSLuGflh6eXYwG7TlTFnET6Zkxlwir5NgSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNfzqmmsQJ14gwKk9Gk8yJlZSYqBklCeU2uWwFNphZjuy5BKKq4wqB2Y0LBV4hF93z2lfsDgy9bNCSEWWUiH/WexZUFhXSecG3DWTmwfDGvYVp+7obW6I3YRGjI0/eVT5dK0JG+ZMQQhNr6rMs2BuLUUlPB1/91foYcxfFLdrJ/WngThitQufWNMVKQv8r7npVRcZ7TcNGoBMUhAQgBVGsSKldhNSkRRWubRAwwrMq5cWNgPe9e/mKxz2WE8XcjkjXnUV7hjsGDljh+BgZlaZK8LoGqbdARhVsQdmWaIg6WlbXGmPjz/iEj0/lKkwg9fmCwiHEyoVn2wCDwjfCP/GQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aJqh/BuT; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aJqh/BuT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xf4zk2cKQz2xxw
	for <linux-aspeed@lists.ozlabs.org>; Thu, 31 Oct 2024 11:45:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730335555; x=1761871555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oAA+9OSWf2l09wWMiiddhw7UfO+O2McyY//3wWYPwBo=;
  b=aJqh/BuT41lnNfrgqw81jYrqk9lA4NHWcMlf4il7TQ0uOrVO3Fg4jwc9
   5dRV3iq0p2HCp2VdiDSy1L/mJZAwtmDUP1U+TNUxpPxVkTksOhWm5L+KZ
   sEp7Toz4ZGAhMXDIBGaUK6bevdGSTVHTwJnuUX4oXe31nllWgFovq7S1b
   MRx+Jd2Exz59spleyDVdDdwF2V30NyjoL/lAaEuzp7v7GctpxD1wWQeGa
   WP33KzWroVjQ05WsqkFTw3JVFRJv2u2dEIP8RsRUNlX7K6YLcW/hHK69+
   5cUrgH+OzEfANpN7IUIzdtF5+ZoIsl/fi8HCfSwhXf9lH//+sNp5+FOly
   A==;
X-CSE-ConnectionGUID: NZzDUi/gQQGw6NbiTo7Ntw==
X-CSE-MsgGUID: bA9V3zhdQm2RKrJX4v/J3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="40637956"
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="40637956"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 17:45:47 -0700
X-CSE-ConnectionGUID: X4k+Gr8wTfSo4COVZJWTZg==
X-CSE-MsgGUID: bS1Vd3qcQn2WxqGo5GafTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="82790697"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Oct 2024 17:45:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6JJk-000fSq-2D;
	Thu, 31 Oct 2024 00:45:40 +0000
Date: Thu, 31 Oct 2024 08:44:48 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v7 3/3] clk: aspeed: add AST2700 clock driver.
Message-ID: <202410310827.OOitgPg0-lkp@intel.com>
References: <20241028053018.2579200-4-ryan_chen@aspeedtech.com>
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
In-Reply-To: <20241028053018.2579200-4-ryan_chen@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on pza/reset/next lee-mfd/for-mfd-next lee-leds/for-leds-next linus/master lee-mfd/for-mfd-fixes v6.12-rc5 next-20241030]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-mfd-aspeed-support-for-AST2700/20241028-133255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20241028053018.2579200-4-ryan_chen%40aspeedtech.com
patch subject: [PATCH v7 3/3] clk: aspeed: add AST2700 clock driver.
config: csky-randconfig-001-20241031 (https://download.01.org/0day-ci/archive/20241031/202410310827.OOitgPg0-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410310827.OOitgPg0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410310827.OOitgPg0-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/clk/clk-ast2700.o: in function `ast2700_soc_clk_probe':
   clk-ast2700.c:(.text+0x530): undefined reference to `aspeed_reset_controller_register'
>> csky-linux-ld: clk-ast2700.c:(.text+0x558): undefined reference to `aspeed_reset_controller_register'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

