Return-Path: <linux-aspeed+bounces-921-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22BFC021B8
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 09:08:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6VGL2TSQz30WS;
	Tue,  4 Mar 2025 20:08:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741079306;
	cv=none; b=RWHfbBhDtizFraHLehS2T5wI3Clj5/ClSAvVwUx9Ap5OTkk/DnLQP37953NiCYawXG8WrzvA62PvgSxAHWDzc71HhCZWIfKKFV2vosu0+3GUVG1jNQfSlky+VEYKXYSEiC+/f8yA6HP+cwTb1/9114Hi7B2jaxBNSLGyPT7TFUtVRMA2Wd4MEM7S4UYN8IbLblbFodpvkMbI7lU3iEDcZ6JQo6Y2CWpPT4GwgOray2DApU/CJlJMltQd7r6hzxHEy6WQ0SHyHKTeBte+rbXxV8084kr5Mrxyla1zNpzQ9mc6ycbPE7hRpe9ACkgzphXYKHkukIkQKvgjsRj05a3TuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741079306; c=relaxed/relaxed;
	bh=iTG8fxlmYXAlax6nSmeXc8A6YgmKjSnnFRoCzKTT16E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9CIvBLDoDSGwDWWc364MfSPbtpkEalw5WWhsi79Q7bl3Vtr7yANIXnxHTGZ5Qd75NVbmuOyyp9buDqeGG7XNXGzkxsLnmgwtwMD+BCw6YESN1ZZqYal+2f4+CrUwx5F8Cgc6HyDUU066xuwO1eCr/rIb9EDylBjtiTFbtrJF/WVN1zDItg66MIPFvW6FwYEJA0WoYji751KILFM3KMiGdvifVCZPx2bL2yMDs+H5o25f6L3I9n52me/JppxE9RmPzpmulHOyJhS8Z5z5aBpxr1VcSQ2aoaS3qVhqwnpGd9CEcBlYZbQOnwdA0a9lxl7TOTshBfnPAU0Ogff75p/hA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c5fzkrS7; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c5fzkrS7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6VGJ2jMNz30WQ
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 20:08:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741079305; x=1772615305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GXuRz06hDfIRTVBK7Y7J5u3Fy/4jNuBeBSyafYInY64=;
  b=c5fzkrS7PerSNZLuodmyjKWLPsUleINo1H9SBq8RNAL+xGd6ZKECEWIG
   1CCVcCnk9eHco+l0O/DcSKawWwDipwSa8xGqNkjB20TnNq60a5RVkMQU7
   8vNAPQvgcn5IZK5od1VfalIzQpssx4yjmV2bAEFgKIMPapjizpuwHl6SU
   uXd04GHXg+r94QGWtnGrDo/7FMWo9hlsuVZBrMnZrnifpBcaHXNPH7Ntg
   p/EyV5XEEbLMeU4RaRLeCmumQLQaVUW8bkygE93SHiDZTXjHo93hRlAiW
   vqXYybqMjygR+ljzAe9g7mxG88qH2RqNlHzDDqc9RGrAKuY26FcmHjJpt
   w==;
X-CSE-ConnectionGUID: aZBhRAqhS+yINaH/M2oaDQ==
X-CSE-MsgGUID: yJBOy7v0SzS+mZLdbJgYRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53391434"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="53391434"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 01:08:20 -0800
X-CSE-ConnectionGUID: WsdSvD8kQSqq8xlLa15QJg==
X-CSE-MsgGUID: wBNumz0fSaSG5Y1WNX0q2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119230033"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 04 Mar 2025 01:08:16 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpOG5-000JWI-26;
	Tue, 04 Mar 2025 09:08:13 +0000
Date: Tue, 4 Mar 2025 17:07:44 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mun Yew Tham <mun.yew.tham@intel.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, patches@opensource.cirrus.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 02/15] gpio: adnp: use lock guards for the I2C lock
Message-ID: <202503041612.G8O0Bdrg-lkp@intel.com>
References: <20250303-gpiochip-set-conversion-v1-2-1d5cceeebf8b@linaro.org>
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
In-Reply-To: <20250303-gpiochip-set-conversion-v1-2-1d5cceeebf8b@linaro.org>

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9778568dede2166c7bd124d473f9ec365f782935]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-74x164-use-new-line-value-setter-callbacks/20250303-212738
base:   9778568dede2166c7bd124d473f9ec365f782935
patch link:    https://lore.kernel.org/r/20250303-gpiochip-set-conversion-v1-2-1d5cceeebf8b%40linaro.org
patch subject: [PATCH 02/15] gpio: adnp: use lock guards for the I2C lock
config: x86_64-buildonly-randconfig-001-20250304 (https://download.01.org/0day-ci/archive/20250304/202503041612.G8O0Bdrg-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503041612.G8O0Bdrg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503041612.G8O0Bdrg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpio-adnp.c:241:8: warning: variable 'isr' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     241 |                         if (err < 0)
         |                             ^~~~~~~
   drivers/gpio/gpio-adnp.c:265:14: note: uninitialized use occurs here
     265 |                 pending &= isr & ier;
         |                            ^~~
   drivers/gpio/gpio-adnp.c:241:4: note: remove the 'if' if its condition is always false
     241 |                         if (err < 0)
         |                         ^~~~~~~~~~~~
     242 |                                 continue;
         |                                 ~~~~~~~~
   drivers/gpio/gpio-adnp.c:235:25: note: initialize the variable 'isr' to silence this warning
     235 |                 u8 changed, level, isr, ier;
         |                                       ^
         |                                        = '\0'
>> drivers/gpio/gpio-adnp.c:245:8: warning: variable 'ier' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     245 |                         if (err < 0)
         |                             ^~~~~~~
   drivers/gpio/gpio-adnp.c:265:20: note: uninitialized use occurs here
     265 |                 pending &= isr & ier;
         |                                  ^~~
   drivers/gpio/gpio-adnp.c:245:4: note: remove the 'if' if its condition is always false
     245 |                         if (err < 0)
         |                         ^~~~~~~~~~~~
     246 |                                 continue;
         |                                 ~~~~~~~~
   drivers/gpio/gpio-adnp.c:241:8: warning: variable 'ier' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     241 |                         if (err < 0)
         |                             ^~~~~~~
   drivers/gpio/gpio-adnp.c:265:20: note: uninitialized use occurs here
     265 |                 pending &= isr & ier;
         |                                  ^~~
   drivers/gpio/gpio-adnp.c:241:4: note: remove the 'if' if its condition is always false
     241 |                         if (err < 0)
         |                         ^~~~~~~~~~~~
     242 |                                 continue;
         |                                 ~~~~~~~~
   drivers/gpio/gpio-adnp.c:235:30: note: initialize the variable 'ier' to silence this warning
     235 |                 u8 changed, level, isr, ier;
         |                                            ^
         |                                             = '\0'
   3 warnings generated.


vim +241 drivers/gpio/gpio-adnp.c

   225	
   226	static irqreturn_t adnp_irq(int irq, void *data)
   227	{
   228		struct adnp *adnp = data;
   229		unsigned int num_regs, i;
   230	
   231		num_regs = 1 << adnp->reg_shift;
   232	
   233		for (i = 0; i < num_regs; i++) {
   234			unsigned int base = i << adnp->reg_shift, bit;
   235			u8 changed, level, isr, ier;
   236			unsigned long pending;
   237			int err;
   238	
   239			scoped_guard(mutex, &adnp->i2c_lock) {
   240				err = adnp_read(adnp, GPIO_PLR(adnp) + i, &level);
 > 241				if (err < 0)
   242					continue;
   243	
   244				err = adnp_read(adnp, GPIO_ISR(adnp) + i, &isr);
 > 245				if (err < 0)
   246					continue;
   247	
   248				err = adnp_read(adnp, GPIO_IER(adnp) + i, &ier);
   249				if (err < 0)
   250					continue;
   251			}
   252	
   253			/* determine pins that changed levels */
   254			changed = level ^ adnp->irq_level[i];
   255	
   256			/* compute edge-triggered interrupts */
   257			pending = changed & ((adnp->irq_fall[i] & ~level) |
   258					     (adnp->irq_rise[i] & level));
   259	
   260			/* add in level-triggered interrupts */
   261			pending |= (adnp->irq_high[i] & level) |
   262				   (adnp->irq_low[i] & ~level);
   263	
   264			/* mask out non-pending and disabled interrupts */
   265			pending &= isr & ier;
   266	
   267			for_each_set_bit(bit, &pending, 8) {
   268				unsigned int child_irq;
   269				child_irq = irq_find_mapping(adnp->gpio.irq.domain,
   270							     base + bit);
   271				handle_nested_irq(child_irq);
   272			}
   273		}
   274	
   275		return IRQ_HANDLED;
   276	}
   277	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

