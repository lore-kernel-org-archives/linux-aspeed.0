Return-Path: <linux-aspeed+bounces-867-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BEDC19776
	for <linux-aspeed@archiver.kernel.org>; Fri, 28 Feb 2025 12:39:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z477n3sWgz3bsZ;
	Fri, 28 Feb 2025 23:39:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740746373;
	cv=none; b=QRoVvsgyalsqoUfkO212k8sx2Zh5ghHesgqocVQ+iDbwFbq1a+eCI6ft9CCD9D0qS3XuVYg2URIGAa1gvwyjr5u50mReSIxUUMPGzZvEruqBinHPtalt6MXPusEt7JV3xheTMsuMJ9YHSGIUdI2QvCP0dt0gUO8eP4lu0anxB+Ul2LzN+DsPm0z3aEXAeJ67CFLoMR7quSp3YaM1/17+MlEpfZAUsXrzopaP7c9MUjU90VW9MsKUZ/7ET71VcY3OTzPHXVWoFQ2WqvFjZ/REdrLTQtCWshxXxQEOQv4cfw5rkDE4RShXr4wXZFMd9s/+r8l4FdjNGnoUmCNfO2Wx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740746373; c=relaxed/relaxed;
	bh=PFjBbY+XC1UAMgYfJ6fw2q+12gCt9wbXY8XezCsmN6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCJwXxPywPHLAWLaw0x2wPe7DkDg3ek9oVLuET3jqf3QGISraoWeChWpyfW0a14oFn1ojSwNLil+NGKImsyf8cbzA8Gxv8uiBj4NN5/8T+kdSV9PHsLg005r3L1WaKTGxEmqMibn5q90ZYpjQVKnW8/MLo6qsJbFzW6xwz3wOpCns/3L6N/COovUx1ioal50cxHCBkVkZmwoq4hZ4EmOsq8ponyxg1sQBEmPA7Xq5YEiKhJ6uX2ZXHdhdT628VRKvxeNRaEaB+aBReAP5a3YNdZLLKjo761eXGfNa22WmhUXElO/08DOVmwLRfx1kcCccG3ENcJntmqf0FG0JhXp5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I0lZN3xO; dkim-atps=neutral; spf=none (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I0lZN3xO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 63 seconds by postgrey-1.37 at boromir; Fri, 28 Feb 2025 23:39:32 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z477m40jnz2xGw
	for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 23:39:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740746373; x=1772282373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VYX7RMZyCDlc3/89q5oGVMuk0VSFqLZ9SexG0yL3SwM=;
  b=I0lZN3xOYZ4QeKAlP/Cjte6L/DXTjtKsDvV1P7bXNXJmDegKWWy4NH4R
   sS8uU+X/29sBVfqlM0Lc6YUQODxN4KM6tSyBkOw2/Iu/CvXTwdAB4LuLv
   sqfn4BKG4op7vrI2DHGdTRptfzbvrSEgGKayQhSNoGzSioy8bsurzLLjA
   YglafGllfRlH98CZLd+dQdKPZJ6NUWiDGMfddgtZLUXD/dugDNahTpGRn
   ER7xvl5vZyZ3eFkJidFZPRdFg+4QWEaWjaidTxM1A5bw7jL9RR16/Ll6k
   rhLt/BMuOpcRU1Dghphqnlr3nX5EPt4zcApdJa8ExBtYEJ+4Ree94Ovx6
   w==;
X-CSE-ConnectionGUID: XrfsbVdyTp6yDqenJFer0Q==
X-CSE-MsgGUID: JjQNXiEgQLOjweKf7g4q7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="44487572"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="44487572"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:38:25 -0800
X-CSE-ConnectionGUID: XFK1U7eRRnWQ4oGOGKwDHg==
X-CSE-MsgGUID: 9fz0KIp6TWq3kGY8ZRIIpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="117312902"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:38:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnzdB-0000000Fwgv-3Dnc;
	Fri, 28 Feb 2025 14:38:17 +0200
Date: Fri, 28 Feb 2025 14:38:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, benh@kernel.crashing.org,
	joel@jms.id.au, andi.shyti@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	andrew@codeconstruct.com.au, p.zabel@pengutronix.de,
	linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v16 2/3] i2c: aspeed: support AST2600 i2c new register
 mode driver
Message-ID: <Z8GuOT5bJL7CdXX6@smile.fi.intel.com>
References: <20250224055936.1804279-3-ryan_chen@aspeedtech.com>
 <202502280902.U0gLDhve-lkp@intel.com>
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
In-Reply-To: <202502280902.U0gLDhve-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 09:28:59AM +0800, kernel test robot wrote:
> Hi Ryan,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on andi-shyti/i2c/i2c-host]
> [also build test WARNING on linus/master v6.14-rc4 next-20250227]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-i2c-aspeed-support-for-AST2600-i2cv2/20250224-140221
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
> patch link:    https://lore.kernel.org/r/20250224055936.1804279-3-ryan_chen%40aspeedtech.com
> patch subject: [PATCH v16 2/3] i2c: aspeed: support AST2600 i2c new register mode driver
> config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20250228/202502280902.U0gLDhve-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280902.U0gLDhve-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502280902.U0gLDhve-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):

My gosh, this is valid report. But it looks like a preexisted issue.
Can somebody fix this, please?

-- 
With Best Regards,
Andy Shevchenko



