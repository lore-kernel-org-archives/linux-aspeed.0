Return-Path: <linux-aspeed+bounces-997-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073FBC28B28
	for <linux-aspeed@archiver.kernel.org>; Sat, 15 Mar 2025 19:43:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFWqT3mQqz3bsM;
	Sun, 16 Mar 2025 06:43:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742067781;
	cv=none; b=EE//6Cr+GFQeZ1NNaUDYxi7JeMojQSOtak9kMMj7wiCGrqqQxPOMXAyKRQdEmklTNp9wNEh3eyOdvI6vgDPCWPHH0Rj137bBbwzPTLILpxF2qzc+BE9ZmNf3+yivFk/5nG5F45fhAzG1+eC16gd1M1dW5ZecT/y6wTahELZWMIfmJ2p1RyR0IaOqqCpzQ90u/nRzHg015vKs38S3O6ffVHTFlmU4yo7ll9FZYlmWoJezrL6C3DDi12VOgtpL1tTE75YdrFlXlckGcWAQXlTWEzHw2tpN9IqWCqp/lucEMSq90CnU1fKvU+tguHwZss1zkopgdSpSathw56zotjoZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742067781; c=relaxed/relaxed;
	bh=sNxSIrHCL91gmyclZ/yV70KnDK2u/Pw3i/c4DMTmPqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pgr7TWVqFcRo1R7cZoqV0w2qS58+97kEzVe2EAukyIPVzLncOe/+lBIjZPVu0ntkup0rXYLvVGDwzxfUgsc2hTXJ4p6lHFFaYfmDPWaBXcD6wQMGVeg5o9JJvucEXnk+aV1wkZrY3MswqSCrDkIwhe0XxMK5vKdIYFZs+V+Mc/r4KUk9rQnPPkEh4rgG4jOAJKqQtGNkKAF8vEfqz1XwYPIBaEGj8jY4Ex9ZHtQWtheiHM8gOMdoOmNruzoqws4GPqjT0qsEhiFDQHPnP/IJFt39bucHw4Ctvp7EeOcDiJJAE+6FVLHEzNWJosL6i5hEBW9wgIn3j1WwyC7cCW+TNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nSC5+Mem; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nSC5+Mem;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFWqQ4f13z3blg
	for <linux-aspeed@lists.ozlabs.org>; Sun, 16 Mar 2025 06:42:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742067779; x=1773603779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k7QoIl8YofamxhmcoyxOoHFFlXOSM056f2rzP6DEE8I=;
  b=nSC5+MemqxaEeuZX0Ajrn1j9TGLcNZykUpcVX5NHFd/VxfhuTphYaOxv
   0wFy9njowKFFGYoHgOqNfsmoSsdZcS67Tvk+vleOiItPksR86C2nMpDKe
   8pfWUhKXO3no8jjxHN5Hm8rhx3IZrwZFCIuMofCkKqUB2yhaaq6f73rMZ
   BMJYGY2PTylu5b9QAxFBYrxIF4Jyq2uvKwUjd2Ur35dBlTuMrDQu52pAA
   90ipAJTnpKHA5CPZ6chtTIDJzt3xRvYzTP2kt2OWhkVECaeueu/r2aI83
   Yx+Mga3uUHAEvoixMmUOL9b1kqE8cy65+C4RGXK48y7SFympgPilSMo52
   Q==;
X-CSE-ConnectionGUID: Xjsxrj5tRWiBeP/PCrR7Mw==
X-CSE-MsgGUID: YBx8Bgd4TOWotBPHknjWcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11374"; a="65663115"
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="65663115"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 12:42:53 -0700
X-CSE-ConnectionGUID: f7Q/uj7oQy64SpeHOB5eUQ==
X-CSE-MsgGUID: X9NTpZFUTSu8D1yzFWWZ2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="122065477"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 15 Mar 2025 12:42:49 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttXPC-000Bbl-1J;
	Sat, 15 Mar 2025 19:42:46 +0000
Date: Sun, 16 Mar 2025 03:41:53 +0800
From: kernel test robot <lkp@intel.com>
To: Kevin Chen <kevin_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, derek.kiernan@amd.com,
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Kevin Chen <kevin_chen@aspeedtech.com>
Subject: Re: [PATCH v3 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Message-ID: <202503160530.EkUNSrkh-lkp@intel.com>
References: <20250310114839.3098148-4-kevin_chen@aspeedtech.com>
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
In-Reply-To: <20250310114839.3098148-4-kevin_chen@aspeedtech.com>

Hi Kevin,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus lee-leds/for-leds-next lee-mfd/for-mfd-next robh/for-next lee-mfd/for-mfd-fixes linus/master v6.14-rc6 next-20250314]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kevin-Chen/dt-binding-aspeed-Add-LPC-PCC-controller/20250310-195011
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20250310114839.3098148-4-kevin_chen%40aspeedtech.com
patch subject: [PATCH v3 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
config: s390-randconfig-002-20250316 (https://download.01.org/0day-ci/archive/20250316/202503160530.EkUNSrkh-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250316/202503160530.EkUNSrkh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503160530.EkUNSrkh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mfd/syscon.c:157:2: error: call to undeclared function 'iounmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           iounmap(base);
           ^
   arch/s390/include/asm/io.h:31:17: note: expanded from macro 'iounmap'
   #define iounmap iounmap
                   ^
   1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_SYSCON
   Depends on [n]: HAS_IOMEM [=n]
   Selected by [y]:
   - ASPEED_LPC_PCC [=y]


vim +/iounmap +157 drivers/mfd/syscon.c

87d687301f38072 Dong Aisheng        2012-09-05   39  
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05   40  static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
87d687301f38072 Dong Aisheng        2012-09-05   41  {
a00406b71c5f08f Fabrice Gasnier     2018-12-12   42  	struct clk *clk;
bdb0066df96e74a Pankaj Dubey        2014-09-30   43  	struct regmap *regmap;
bdb0066df96e74a Pankaj Dubey        2014-09-30   44  	void __iomem *base;
db2fb60cd35d2d0 Damien Riegel       2015-11-30   45  	u32 reg_io_width;
bdb0066df96e74a Pankaj Dubey        2014-09-30   46  	int ret;
bdb0066df96e74a Pankaj Dubey        2014-09-30   47  	struct regmap_config syscon_config = syscon_regmap_config;
ca668f0edfae654 Philipp Zabel       2016-01-29   48  	struct resource res;
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05   49  	struct reset_control *reset;
bdb0066df96e74a Pankaj Dubey        2014-09-30   50  
805f7aaf7fee14a Rob Herring (Arm    2024-12-17   51) 	WARN_ON(!mutex_is_locked(&syscon_list_lock));
805f7aaf7fee14a Rob Herring (Arm    2024-12-17   52) 
82f898f47112bc7 Krzysztof Kozlowski 2024-07-07   53  	struct syscon *syscon __free(kfree) = kzalloc(sizeof(*syscon), GFP_KERNEL);
bdb0066df96e74a Pankaj Dubey        2014-09-30   54  	if (!syscon)
bdb0066df96e74a Pankaj Dubey        2014-09-30   55  		return ERR_PTR(-ENOMEM);
bdb0066df96e74a Pankaj Dubey        2014-09-30   56  
82f898f47112bc7 Krzysztof Kozlowski 2024-07-07   57  	if (of_address_to_resource(np, 0, &res))
82f898f47112bc7 Krzysztof Kozlowski 2024-07-07   58  		return ERR_PTR(-ENOMEM);
ca668f0edfae654 Philipp Zabel       2016-01-29   59  
452d07413954ef3 Hector Martin       2021-08-23   60  	base = of_iomap(np, 0);
82f898f47112bc7 Krzysztof Kozlowski 2024-07-07   61  	if (!base)
82f898f47112bc7 Krzysztof Kozlowski 2024-07-07   62  		return ERR_PTR(-ENOMEM);
bdb0066df96e74a Pankaj Dubey        2014-09-30   63  
ca4582c286aa446 Jason A. Donenfeld  2022-10-08   64  	/* Parse the device's DT node for an endianness specification */
ca4582c286aa446 Jason A. Donenfeld  2022-10-08   65  	if (of_property_read_bool(np, "big-endian"))
ca4582c286aa446 Jason A. Donenfeld  2022-10-08   66  		syscon_config.val_format_endian = REGMAP_ENDIAN_BIG;
ca4582c286aa446 Jason A. Donenfeld  2022-10-08   67  	else if (of_property_read_bool(np, "little-endian"))
ca4582c286aa446 Jason A. Donenfeld  2022-10-08   68  		syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
ca4582c286aa446 Jason A. Donenfeld  2022-10-08   69  	else if (of_property_read_bool(np, "native-endian"))
ca4582c286aa446 Jason A. Donenfeld  2022-10-08   70  		syscon_config.val_format_endian = REGMAP_ENDIAN_NATIVE;
ca4582c286aa446 Jason A. Donenfeld  2022-10-08   71  
db2fb60cd35d2d0 Damien Riegel       2015-11-30   72  	/*
db2fb60cd35d2d0 Damien Riegel       2015-11-30   73  	 * search for reg-io-width property in DT. If it is not provided,
db2fb60cd35d2d0 Damien Riegel       2015-11-30   74  	 * default to 4 bytes. regmap_init_mmio will return an error if values
db2fb60cd35d2d0 Damien Riegel       2015-11-30   75  	 * are invalid so there is no need to check them here.
db2fb60cd35d2d0 Damien Riegel       2015-11-30   76  	 */
db2fb60cd35d2d0 Damien Riegel       2015-11-30   77  	ret = of_property_read_u32(np, "reg-io-width", &reg_io_width);
db2fb60cd35d2d0 Damien Riegel       2015-11-30   78  	if (ret)
db2fb60cd35d2d0 Damien Riegel       2015-11-30   79  		reg_io_width = 4;
db2fb60cd35d2d0 Damien Riegel       2015-11-30   80  
3bafc09e779710a Baolin Wang         2017-12-25   81  	ret = of_hwspin_lock_get_id(np, 0);
3bafc09e779710a Baolin Wang         2017-12-25   82  	if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {
3bafc09e779710a Baolin Wang         2017-12-25   83  		syscon_config.use_hwlock = true;
3bafc09e779710a Baolin Wang         2017-12-25   84  		syscon_config.hwlock_id = ret;
3bafc09e779710a Baolin Wang         2017-12-25   85  		syscon_config.hwlock_mode = HWLOCK_IRQSTATE;
3bafc09e779710a Baolin Wang         2017-12-25   86  	} else if (ret < 0) {
3bafc09e779710a Baolin Wang         2017-12-25   87  		switch (ret) {
3bafc09e779710a Baolin Wang         2017-12-25   88  		case -ENOENT:
3bafc09e779710a Baolin Wang         2017-12-25   89  			/* Ignore missing hwlock, it's optional. */
3bafc09e779710a Baolin Wang         2017-12-25   90  			break;
3bafc09e779710a Baolin Wang         2017-12-25   91  		default:
3bafc09e779710a Baolin Wang         2017-12-25   92  			pr_err("Failed to retrieve valid hwlock: %d\n", ret);
df561f6688fef77 Gustavo A. R. Silva 2020-08-23   93  			fallthrough;
3bafc09e779710a Baolin Wang         2017-12-25   94  		case -EPROBE_DEFER:
3bafc09e779710a Baolin Wang         2017-12-25   95  			goto err_regmap;
3bafc09e779710a Baolin Wang         2017-12-25   96  		}
3bafc09e779710a Baolin Wang         2017-12-25   97  	}
3bafc09e779710a Baolin Wang         2017-12-25   98  
7ff7d5ffb7259f7 Andy Shevchenko     2022-05-31   99  	syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%pa", np, &res.start);
41673c66b3d0c09 Kunwu Chan          2023-12-04  100  	if (!syscon_config.name) {
41673c66b3d0c09 Kunwu Chan          2023-12-04  101  		ret = -ENOMEM;
41673c66b3d0c09 Kunwu Chan          2023-12-04  102  		goto err_regmap;
41673c66b3d0c09 Kunwu Chan          2023-12-04  103  	}
db2fb60cd35d2d0 Damien Riegel       2015-11-30  104  	syscon_config.reg_stride = reg_io_width;
db2fb60cd35d2d0 Damien Riegel       2015-11-30  105  	syscon_config.val_bits = reg_io_width * 8;
ca668f0edfae654 Philipp Zabel       2016-01-29  106  	syscon_config.max_register = resource_size(&res) - reg_io_width;
2e63d6fa113d362 Nishanth Menon      2024-09-03  107  	if (!syscon_config.max_register)
2e63d6fa113d362 Nishanth Menon      2024-09-03  108  		syscon_config.max_register_is_0 = true;
db2fb60cd35d2d0 Damien Riegel       2015-11-30  109  
bdb0066df96e74a Pankaj Dubey        2014-09-30  110  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
56a1188159cb2b8 Limeng              2021-04-07  111  	kfree(syscon_config.name);
bdb0066df96e74a Pankaj Dubey        2014-09-30  112  	if (IS_ERR(regmap)) {
bdb0066df96e74a Pankaj Dubey        2014-09-30  113  		pr_err("regmap init failed\n");
bdb0066df96e74a Pankaj Dubey        2014-09-30  114  		ret = PTR_ERR(regmap);
bdb0066df96e74a Pankaj Dubey        2014-09-30  115  		goto err_regmap;
bdb0066df96e74a Pankaj Dubey        2014-09-30  116  	}
bdb0066df96e74a Pankaj Dubey        2014-09-30  117  
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  118  	if (check_res) {
a00406b71c5f08f Fabrice Gasnier     2018-12-12  119  		clk = of_clk_get(np, 0);
a00406b71c5f08f Fabrice Gasnier     2018-12-12  120  		if (IS_ERR(clk)) {
a00406b71c5f08f Fabrice Gasnier     2018-12-12  121  			ret = PTR_ERR(clk);
a00406b71c5f08f Fabrice Gasnier     2018-12-12  122  			/* clock is optional */
a00406b71c5f08f Fabrice Gasnier     2018-12-12  123  			if (ret != -ENOENT)
a00406b71c5f08f Fabrice Gasnier     2018-12-12  124  				goto err_clk;
a00406b71c5f08f Fabrice Gasnier     2018-12-12  125  		} else {
a00406b71c5f08f Fabrice Gasnier     2018-12-12  126  			ret = regmap_mmio_attach_clk(regmap, clk);
a00406b71c5f08f Fabrice Gasnier     2018-12-12  127  			if (ret)
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  128  				goto err_attach_clk;
a00406b71c5f08f Fabrice Gasnier     2018-12-12  129  		}
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  130  
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  131  		reset = of_reset_control_get_optional_exclusive(np, NULL);
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  132  		if (IS_ERR(reset)) {
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  133  			ret = PTR_ERR(reset);
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  134  			goto err_attach_clk;
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  135  		}
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  136  
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  137  		ret = reset_control_deassert(reset);
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  138  		if (ret)
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  139  			goto err_reset;
39233b7c611248c Paul Cercueil       2019-07-24  140  	}
a00406b71c5f08f Fabrice Gasnier     2018-12-12  141  
bdb0066df96e74a Pankaj Dubey        2014-09-30  142  	syscon->regmap = regmap;
bdb0066df96e74a Pankaj Dubey        2014-09-30  143  	syscon->np = np;
bdb0066df96e74a Pankaj Dubey        2014-09-30  144  
bdb0066df96e74a Pankaj Dubey        2014-09-30  145  	list_add_tail(&syscon->list, &syscon_list);
87d687301f38072 Dong Aisheng        2012-09-05  146  
82f898f47112bc7 Krzysztof Kozlowski 2024-07-07  147  	return_ptr(syscon);
bdb0066df96e74a Pankaj Dubey        2014-09-30  148  
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  149  err_reset:
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  150  	reset_control_put(reset);
7d1e3bd94828ad9 Jeremy Kerr         2023-01-05  151  err_attach_clk:
a00406b71c5f08f Fabrice Gasnier     2018-12-12  152  	if (!IS_ERR(clk))
a00406b71c5f08f Fabrice Gasnier     2018-12-12  153  		clk_put(clk);
a00406b71c5f08f Fabrice Gasnier     2018-12-12  154  err_clk:
a00406b71c5f08f Fabrice Gasnier     2018-12-12  155  	regmap_exit(regmap);
bdb0066df96e74a Pankaj Dubey        2014-09-30  156  err_regmap:
bdb0066df96e74a Pankaj Dubey        2014-09-30 @157  	iounmap(base);
bdb0066df96e74a Pankaj Dubey        2014-09-30  158  	return ERR_PTR(ret);
87d687301f38072 Dong Aisheng        2012-09-05  159  }
87d687301f38072 Dong Aisheng        2012-09-05  160  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

