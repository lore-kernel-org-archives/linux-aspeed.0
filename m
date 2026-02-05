Return-Path: <linux-aspeed+bounces-3490-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DC8E9129A
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Feb 2026 14:53:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6KwH6sXKz2yF1;
	Fri, 06 Feb 2026 01:53:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770303199;
	cv=none; b=mozzYQLYbaU9q2YpWuqxXBam8K0bfT7AWm9s2byEGlVhKNzfnvWPX1rBxZDb+qSsnYe5OnHSO0+UO3dON1biKU4M10y59v51d9gUBnGokbHIOhcrukvw0Mtb+hrwtzky1j+SAidGBb84kLf9PpiSVyAahq3i2m+EGzZxWsHN6SlMysn2b8vAQIVm/IMP86/WKalp/xE5+ZZRcoqwkBrvN2rwi/tYOmK0S4O16/HbJZuxNig36FhIu96iu/N0cEJAgJ3qDC7xObxofeJnAgboFUa67wecmm0igeRol4XmObLzap/5CIkw9yP/B4WULDJrgHFGXL2ks4uMvGyj78g6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770303199; c=relaxed/relaxed;
	bh=bRVWE3ED+qlfGB15yo3/W08UQ3yzieK0S5+5eO797TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSRJyRH3nTKW3eFfyqfxplOUEYO+AGhf5dayOf4bT2B761gbuDVV+0GPCqCs+GcFO+JNw2uQOmzkBeP5ZSdl7DKWpHoyJzYPrsrekGdlSKeEd2pxCdMdIk3oaEhJ9Vv47WyXPC0bIwbuarScNFlqG6YNT2GJ7AAK62qBaBicripSjsXAATL83+LIygTQjLHjpk387XzQgjpp8Ee2z3YtM2Q8Y0LWoYE3/qdkIcchN+2a7i60uS/GtUOzsD1RXGtlIMA1IxKmrNMow/t5IJIi++fwutSvx5IQXze7oceAldddc7cE7Jf5ZBmnzyW37zFpeVS6RvvnpDP7uOgebLzONQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YeQP1UNm; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YeQP1UNm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6KwG3nM1z2xrk
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Feb 2026 01:53:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770303199; x=1801839199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aDtyxCs7lbVhLpfGqokT/Ea6Fj/WXq34jH0cnUcPisk=;
  b=YeQP1UNmEnQdA8BrkMwIWAGfzd5ib+S44MKJ0/2l8W0QgilSFMbxCVxq
   /UJIZxRPnm/YF0bvrd7Hgo/F1jaWXdl/tszuWDAN1LCpyDllb4JHnL5GY
   KTezXr58G/MF96MRhBwdQgPJfTFS/zMrfkRJfw3aIVLRl4+GGu8JeWIBc
   gQNORFMYK8RilhDJHLaporQ0dYIYVuR9/G6AZm5LRqAMsoOiGvAXjha1G
   6+nFZ+g2ER7LTMoIeeqcC8/rmtocilBQl4Li84W+Pe7VCpct/4EDdA51R
   N9yME7w3zu6C32j3lRnITJabGcgXcDoqPOk/4u7/NoVKOpiYLWRfa3tep
   Q==;
X-CSE-ConnectionGUID: jHBG2U6dQQC66f9LT5RzTw==
X-CSE-MsgGUID: 4fUGDvVOSfOL9GWauTc51A==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="59077477"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="59077477"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 06:53:16 -0800
X-CSE-ConnectionGUID: 5/YIgV+0RtmfgWCkQ3QVZw==
X-CSE-MsgGUID: rgbzNb7WRmO4CRpFG8/laQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="233493595"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Feb 2026 06:53:12 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vo0jF-00000000jto-3WuN;
	Thu, 05 Feb 2026 14:53:09 +0000
Date: Thu, 5 Feb 2026 22:52:16 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH 2/4] irqchip/ast2700-intcx: Add AST2700 INTC0/INTC1
 support
Message-ID: <202602052233.HNk5pa4R-lkp@intel.com>
References: <20260205-irqchip-v1-2-b0310e06c087@aspeedtech.com>
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
In-Reply-To: <20260205-irqchip-v1-2-b0310e06c087@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-interrupt-controller-aspeed-Add-ASPEED-AST2700-INTC0-INTC1/20260205-141046
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20260205-irqchip-v1-2-b0310e06c087%40aspeedtech.com
patch subject: [PATCH 2/4] irqchip/ast2700-intcx: Add AST2700 INTC0/INTC1 support
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20260205/202602052233.HNk5pa4R-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602052233.HNk5pa4R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602052233.HNk5pa4R-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/mips/include/asm/errno.h:11,
                    from include/linux/err.h:8,
                    from include/linux/cleanup.h:6,
                    from include/linux/jump_label.h:78,
                    from include/linux/dynamic_debug.h:6,
                    from include/linux/printk.h:621,
                    from include/asm-generic/bug.h:31,
                    from arch/mips/include/asm/bug.h:42,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:6,
                    from ./arch/mips/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/irqchip/irq-ast2700-intc0.c:10:
>> arch/mips/include/uapi/asm/errno.h:18:9: warning: 'ENOMSG' redefined
      18 | #define ENOMSG          35      /* No message of desired type */
         |         ^~~~~~
   In file included from drivers/irqchip/irq-ast2700-intc0.c:8:
   include/uapi/asm-generic/errno.h:23:9: note: this is the location of the previous definition
      23 | #define ENOMSG          42      /* No message of desired type */
         |         ^~~~~~
>> arch/mips/include/uapi/asm/errno.h:19:9: warning: 'EIDRM' redefined
      19 | #define EIDRM           36      /* Identifier removed */
         |         ^~~~~
   include/uapi/asm-generic/errno.h:24:9: note: this is the location of the previous definition
      24 | #define EIDRM           43      /* Identifier removed */
         |         ^~~~~
>> arch/mips/include/uapi/asm/errno.h:20:9: warning: 'ECHRNG' redefined
      20 | #define ECHRNG          37      /* Channel number out of range */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:25:9: note: this is the location of the previous definition
      25 | #define ECHRNG          44      /* Channel number out of range */
         |         ^~~~~~
>> arch/mips/include/uapi/asm/errno.h:21:9: warning: 'EL2NSYNC' redefined
      21 | #define EL2NSYNC        38      /* Level 2 not synchronized */
         |         ^~~~~~~~
   include/uapi/asm-generic/errno.h:26:9: note: this is the location of the previous definition
      26 | #define EL2NSYNC        45      /* Level 2 not synchronized */
         |         ^~~~~~~~
>> arch/mips/include/uapi/asm/errno.h:22:9: warning: 'EL3HLT' redefined
      22 | #define EL3HLT          39      /* Level 3 halted */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:27:9: note: this is the location of the previous definition
      27 | #define EL3HLT          46      /* Level 3 halted */
         |         ^~~~~~
>> arch/mips/include/uapi/asm/errno.h:23:9: warning: 'EL3RST' redefined
      23 | #define EL3RST          40      /* Level 3 reset */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:28:9: note: this is the location of the previous definition
      28 | #define EL3RST          47      /* Level 3 reset */
         |         ^~~~~~
>> arch/mips/include/uapi/asm/errno.h:24:9: warning: 'ELNRNG' redefined
      24 | #define ELNRNG          41      /* Link number out of range */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:29:9: note: this is the location of the previous definition
      29 | #define ELNRNG          48      /* Link number out of range */
         |         ^~~~~~
>> arch/mips/include/uapi/asm/errno.h:25:9: warning: 'EUNATCH' redefined
      25 | #define EUNATCH         42      /* Protocol driver not attached */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:30:9: note: this is the location of the previous definition
      30 | #define EUNATCH         49      /* Protocol driver not attached */
         |         ^~~~~~~
>> arch/mips/include/uapi/asm/errno.h:26:9: warning: 'ENOCSI' redefined
      26 | #define ENOCSI          43      /* No CSI structure available */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:31:9: note: this is the location of the previous definition
      31 | #define ENOCSI          50      /* No CSI structure available */
         |         ^~~~~~
>> arch/mips/include/uapi/asm/errno.h:27:9: warning: 'EL2HLT' redefined
      27 | #define EL2HLT          44      /* Level 2 halted */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:32:9: note: this is the location of the previous definition
      32 | #define EL2HLT          51      /* Level 2 halted */
         |         ^~~~~~
>> arch/mips/include/uapi/asm/errno.h:28:9: warning: 'EDEADLK' redefined
      28 | #define EDEADLK         45      /* Resource deadlock would occur */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:7:9: note: this is the location of the previous definition
       7 | #define EDEADLK         35      /* Resource deadlock would occur */
         |         ^~~~~~~
>> arch/mips/include/uapi/asm/errno.h:29:9: warning: 'ENOLCK' redefined
      29 | #define ENOLCK          46      /* No record locks available */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:9:9: note: this is the location of the previous definition
       9 | #define ENOLCK          37      /* No record locks available */
         |         ^~~~~~
>> arch/mips/include/uapi/asm/errno.h:30:9: warning: 'EBADE' redefined
      30 | #define EBADE           50      /* Invalid exchange */
         |         ^~~~~
   include/uapi/asm-generic/errno.h:33:9: note: this is the location of the previous definition
      33 | #define EBADE           52      /* Invalid exchange */
         |         ^~~~~
>> arch/mips/include/uapi/asm/errno.h:31:9: warning: 'EBADR' redefined
      31 | #define EBADR           51      /* Invalid request descriptor */
         |         ^~~~~
   include/uapi/asm-generic/errno.h:34:9: note: this is the location of the previous definition
      34 | #define EBADR           53      /* Invalid request descriptor */
         |         ^~~~~
>> arch/mips/include/uapi/asm/errno.h:32:9: warning: 'EXFULL' redefined
      32 | #define EXFULL          52      /* Exchange full */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:35:9: note: this is the location of the previous definition
      35 | #define EXFULL          54      /* Exchange full */
         |         ^~~~~~
>> arch/mips/include/uapi/asm/errno.h:33:9: warning: 'ENOANO' redefined
      33 | #define ENOANO          53      /* No anode */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:36:9: note: this is the location of the previous definition
      36 | #define ENOANO          55      /* No anode */
         |         ^~~~~~
>> arch/mips/include/uapi/asm/errno.h:34:9: warning: 'EBADRQC' redefined
      34 | #define EBADRQC         54      /* Invalid request code */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:37:9: note: this is the location of the previous definition
      37 | #define EBADRQC         56      /* Invalid request code */
         |         ^~~~~~~
>> arch/mips/include/uapi/asm/errno.h:35:9: warning: 'EBADSLT' redefined
      35 | #define EBADSLT         55      /* Invalid slot */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:38:9: note: this is the location of the previous definition
      38 | #define EBADSLT         57      /* Invalid slot */
         |         ^~~~~~~
>> arch/mips/include/uapi/asm/errno.h:36:9: warning: 'EDEADLOCK' redefined
      36 | #define EDEADLOCK       56      /* File locking deadlock error */
         |         ^~~~~~~~~
   include/uapi/asm-generic/errno.h:40:9: note: this is the location of the previous definition
      40 | #define EDEADLOCK       EDEADLK
         |         ^~~~~~~~~
>> arch/mips/include/uapi/asm/errno.h:51:9: warning: 'EMULTIHOP' redefined
      51 | #define EMULTIHOP       74      /* Multihop attempted */
         |         ^~~~~~~~~
   include/uapi/asm-generic/errno.h:55:9: note: this is the location of the previous definition
      55 | #define EMULTIHOP       72      /* Multihop attempted */
         |         ^~~~~~~~~
   arch/mips/include/uapi/asm/errno.h:52:9: warning: 'EBADMSG' redefined
      52 | #define EBADMSG         77      /* Not a data message */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:57:9: note: this is the location of the previous definition
      57 | #define EBADMSG         74      /* Not a data message */
         |         ^~~~~~~
   arch/mips/include/uapi/asm/errno.h:53:9: warning: 'ENAMETOOLONG' redefined
      53 | #define ENAMETOOLONG    78      /* File name too long */
         |         ^~~~~~~~~~~~
   include/uapi/asm-generic/errno.h:8:9: note: this is the location of the previous definition
       8 | #define ENAMETOOLONG    36      /* File name too long */
         |         ^~~~~~~~~~~~
   arch/mips/include/uapi/asm/errno.h:54:9: warning: 'EOVERFLOW' redefined
      54 | #define EOVERFLOW       79      /* Value too large for defined data type */
         |         ^~~~~~~~~
   include/uapi/asm-generic/errno.h:58:9: note: this is the location of the previous definition
      58 | #define EOVERFLOW       75      /* Value too large for defined data type */
         |         ^~~~~~~~~
   arch/mips/include/uapi/asm/errno.h:55:9: warning: 'ENOTUNIQ' redefined
      55 | #define ENOTUNIQ        80      /* Name not unique on network */
         |         ^~~~~~~~
   include/uapi/asm-generic/errno.h:59:9: note: this is the location of the previous definition
      59 | #define ENOTUNIQ        76      /* Name not unique on network */
         |         ^~~~~~~~
   arch/mips/include/uapi/asm/errno.h:56:9: warning: 'EBADFD' redefined
      56 | #define EBADFD          81      /* File descriptor in bad state */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:60:9: note: this is the location of the previous definition
      60 | #define EBADFD          77      /* File descriptor in bad state */
         |         ^~~~~~
   arch/mips/include/uapi/asm/errno.h:57:9: warning: 'EREMCHG' redefined
      57 | #define EREMCHG         82      /* Remote address changed */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:61:9: note: this is the location of the previous definition
      61 | #define EREMCHG         78      /* Remote address changed */
         |         ^~~~~~~
   arch/mips/include/uapi/asm/errno.h:58:9: warning: 'ELIBACC' redefined
      58 | #define ELIBACC         83      /* Can not access a needed shared library */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:62:9: note: this is the location of the previous definition
      62 | #define ELIBACC         79      /* Can not access a needed shared library */
         |         ^~~~~~~
   arch/mips/include/uapi/asm/errno.h:59:9: warning: 'ELIBBAD' redefined
      59 | #define ELIBBAD         84      /* Accessing a corrupted shared library */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:63:9: note: this is the location of the previous definition
      63 | #define ELIBBAD         80      /* Accessing a corrupted shared library */
         |         ^~~~~~~
   arch/mips/include/uapi/asm/errno.h:60:9: warning: 'ELIBSCN' redefined
      60 | #define ELIBSCN         85      /* .lib section in a.out corrupted */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:64:9: note: this is the location of the previous definition
      64 | #define ELIBSCN         81      /* .lib section in a.out corrupted */
         |         ^~~~~~~
   arch/mips/include/uapi/asm/errno.h:61:9: warning: 'ELIBMAX' redefined
      61 | #define ELIBMAX         86      /* Attempting to link in too many shared libraries */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:65:9: note: this is the location of the previous definition
      65 | #define ELIBMAX         82      /* Attempting to link in too many shared libraries */
         |         ^~~~~~~
   arch/mips/include/uapi/asm/errno.h:62:9: warning: 'ELIBEXEC' redefined
      62 | #define ELIBEXEC        87      /* Cannot exec a shared library directly */
         |         ^~~~~~~~
   include/uapi/asm-generic/errno.h:66:9: note: this is the location of the previous definition
      66 | #define ELIBEXEC        83      /* Cannot exec a shared library directly */
         |         ^~~~~~~~
   arch/mips/include/uapi/asm/errno.h:63:9: warning: 'EILSEQ' redefined
      63 | #define EILSEQ          88      /* Illegal byte sequence */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:67:9: note: this is the location of the previous definition
      67 | #define EILSEQ          84      /* Illegal byte sequence */
         |         ^~~~~~
   arch/mips/include/uapi/asm/errno.h:64:9: warning: 'ENOSYS' redefined
      64 | #define ENOSYS          89      /* Function not implemented */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:18:9: note: this is the location of the previous definition
      18 | #define ENOSYS          38      /* Invalid system call number */
         |         ^~~~~~
   arch/mips/include/uapi/asm/errno.h:65:9: warning: 'ELOOP' redefined
      65 | #define ELOOP           90      /* Too many symbolic links encountered */
         |         ^~~~~
   include/uapi/asm-generic/errno.h:21:9: note: this is the location of the previous definition
      21 | #define ELOOP           40      /* Too many symbolic links encountered */
         |         ^~~~~
   arch/mips/include/uapi/asm/errno.h:66:9: warning: 'ERESTART' redefined
      66 | #define ERESTART        91      /* Interrupted system call should be restarted */
         |         ^~~~~~~~
   include/uapi/asm-generic/errno.h:68:9: note: this is the location of the previous definition
      68 | #define ERESTART        85      /* Interrupted system call should be restarted */
         |         ^~~~~~~~
   arch/mips/include/uapi/asm/errno.h:67:9: warning: 'ESTRPIPE' redefined
      67 | #define ESTRPIPE        92      /* Streams pipe error */
         |         ^~~~~~~~
   include/uapi/asm-generic/errno.h:69:9: note: this is the location of the previous definition
      69 | #define ESTRPIPE        86      /* Streams pipe error */


vim +/ENOMSG +18 arch/mips/include/uapi/asm/errno.h

61730c538f8281 David Howells 2012-10-09   17  
61730c538f8281 David Howells 2012-10-09  @18  #define ENOMSG		35	/* No message of desired type */
61730c538f8281 David Howells 2012-10-09  @19  #define EIDRM		36	/* Identifier removed */
61730c538f8281 David Howells 2012-10-09  @20  #define ECHRNG		37	/* Channel number out of range */
61730c538f8281 David Howells 2012-10-09  @21  #define EL2NSYNC	38	/* Level 2 not synchronized */
61730c538f8281 David Howells 2012-10-09  @22  #define EL3HLT		39	/* Level 3 halted */
61730c538f8281 David Howells 2012-10-09  @23  #define EL3RST		40	/* Level 3 reset */
61730c538f8281 David Howells 2012-10-09  @24  #define ELNRNG		41	/* Link number out of range */
61730c538f8281 David Howells 2012-10-09  @25  #define EUNATCH		42	/* Protocol driver not attached */
61730c538f8281 David Howells 2012-10-09  @26  #define ENOCSI		43	/* No CSI structure available */
61730c538f8281 David Howells 2012-10-09  @27  #define EL2HLT		44	/* Level 2 halted */
61730c538f8281 David Howells 2012-10-09  @28  #define EDEADLK		45	/* Resource deadlock would occur */
61730c538f8281 David Howells 2012-10-09  @29  #define ENOLCK		46	/* No record locks available */
61730c538f8281 David Howells 2012-10-09  @30  #define EBADE		50	/* Invalid exchange */
61730c538f8281 David Howells 2012-10-09  @31  #define EBADR		51	/* Invalid request descriptor */
61730c538f8281 David Howells 2012-10-09  @32  #define EXFULL		52	/* Exchange full */
61730c538f8281 David Howells 2012-10-09  @33  #define ENOANO		53	/* No anode */
61730c538f8281 David Howells 2012-10-09  @34  #define EBADRQC		54	/* Invalid request code */
61730c538f8281 David Howells 2012-10-09  @35  #define EBADSLT		55	/* Invalid slot */
61730c538f8281 David Howells 2012-10-09  @36  #define EDEADLOCK	56	/* File locking deadlock error */
61730c538f8281 David Howells 2012-10-09   37  #define EBFONT		59	/* Bad font file format */
61730c538f8281 David Howells 2012-10-09   38  #define ENOSTR		60	/* Device not a stream */
61730c538f8281 David Howells 2012-10-09   39  #define ENODATA		61	/* No data available */
61730c538f8281 David Howells 2012-10-09   40  #define ETIME		62	/* Timer expired */
61730c538f8281 David Howells 2012-10-09   41  #define ENOSR		63	/* Out of streams resources */
61730c538f8281 David Howells 2012-10-09   42  #define ENONET		64	/* Machine is not on the network */
61730c538f8281 David Howells 2012-10-09   43  #define ENOPKG		65	/* Package not installed */
61730c538f8281 David Howells 2012-10-09   44  #define EREMOTE		66	/* Object is remote */
61730c538f8281 David Howells 2012-10-09   45  #define ENOLINK		67	/* Link has been severed */
61730c538f8281 David Howells 2012-10-09   46  #define EADV		68	/* Advertise error */
61730c538f8281 David Howells 2012-10-09   47  #define ESRMNT		69	/* Srmount error */
61730c538f8281 David Howells 2012-10-09   48  #define ECOMM		70	/* Communication error on send */
61730c538f8281 David Howells 2012-10-09   49  #define EPROTO		71	/* Protocol error */
61730c538f8281 David Howells 2012-10-09   50  #define EDOTDOT		73	/* RFS specific error */
61730c538f8281 David Howells 2012-10-09  @51  #define EMULTIHOP	74	/* Multihop attempted */
61730c538f8281 David Howells 2012-10-09  @52  #define EBADMSG		77	/* Not a data message */
61730c538f8281 David Howells 2012-10-09  @53  #define ENAMETOOLONG	78	/* File name too long */
61730c538f8281 David Howells 2012-10-09  @54  #define EOVERFLOW	79	/* Value too large for defined data type */
61730c538f8281 David Howells 2012-10-09  @55  #define ENOTUNIQ	80	/* Name not unique on network */
61730c538f8281 David Howells 2012-10-09  @56  #define EBADFD		81	/* File descriptor in bad state */
61730c538f8281 David Howells 2012-10-09  @57  #define EREMCHG		82	/* Remote address changed */
61730c538f8281 David Howells 2012-10-09  @58  #define ELIBACC		83	/* Can not access a needed shared library */
61730c538f8281 David Howells 2012-10-09  @59  #define ELIBBAD		84	/* Accessing a corrupted shared library */
61730c538f8281 David Howells 2012-10-09  @60  #define ELIBSCN		85	/* .lib section in a.out corrupted */
61730c538f8281 David Howells 2012-10-09  @61  #define ELIBMAX		86	/* Attempting to link in too many shared libraries */
61730c538f8281 David Howells 2012-10-09  @62  #define ELIBEXEC	87	/* Cannot exec a shared library directly */
61730c538f8281 David Howells 2012-10-09  @63  #define EILSEQ		88	/* Illegal byte sequence */
61730c538f8281 David Howells 2012-10-09  @64  #define ENOSYS		89	/* Function not implemented */
61730c538f8281 David Howells 2012-10-09  @65  #define ELOOP		90	/* Too many symbolic links encountered */
61730c538f8281 David Howells 2012-10-09  @66  #define ERESTART	91	/* Interrupted system call should be restarted */
61730c538f8281 David Howells 2012-10-09  @67  #define ESTRPIPE	92	/* Streams pipe error */
61730c538f8281 David Howells 2012-10-09  @68  #define ENOTEMPTY	93	/* Directory not empty */
61730c538f8281 David Howells 2012-10-09  @69  #define EUSERS		94	/* Too many users */
61730c538f8281 David Howells 2012-10-09  @70  #define ENOTSOCK	95	/* Socket operation on non-socket */
61730c538f8281 David Howells 2012-10-09  @71  #define EDESTADDRREQ	96	/* Destination address required */
61730c538f8281 David Howells 2012-10-09  @72  #define EMSGSIZE	97	/* Message too long */
61730c538f8281 David Howells 2012-10-09  @73  #define EPROTOTYPE	98	/* Protocol wrong type for socket */
61730c538f8281 David Howells 2012-10-09  @74  #define ENOPROTOOPT	99	/* Protocol not available */
61730c538f8281 David Howells 2012-10-09  @75  #define EPROTONOSUPPORT 120	/* Protocol not supported */
61730c538f8281 David Howells 2012-10-09  @76  #define ESOCKTNOSUPPORT 121	/* Socket type not supported */
61730c538f8281 David Howells 2012-10-09  @77  #define EOPNOTSUPP	122	/* Operation not supported on transport endpoint */
61730c538f8281 David Howells 2012-10-09  @78  #define EPFNOSUPPORT	123	/* Protocol family not supported */
61730c538f8281 David Howells 2012-10-09  @79  #define EAFNOSUPPORT	124	/* Address family not supported by protocol */
61730c538f8281 David Howells 2012-10-09  @80  #define EADDRINUSE	125	/* Address already in use */
61730c538f8281 David Howells 2012-10-09  @81  #define EADDRNOTAVAIL	126	/* Cannot assign requested address */
61730c538f8281 David Howells 2012-10-09  @82  #define ENETDOWN	127	/* Network is down */
61730c538f8281 David Howells 2012-10-09  @83  #define ENETUNREACH	128	/* Network is unreachable */
61730c538f8281 David Howells 2012-10-09  @84  #define ENETRESET	129	/* Network dropped connection because of reset */
61730c538f8281 David Howells 2012-10-09  @85  #define ECONNABORTED	130	/* Software caused connection abort */
61730c538f8281 David Howells 2012-10-09  @86  #define ECONNRESET	131	/* Connection reset by peer */
61730c538f8281 David Howells 2012-10-09  @87  #define ENOBUFS		132	/* No buffer space available */
61730c538f8281 David Howells 2012-10-09  @88  #define EISCONN		133	/* Transport endpoint is already connected */
61730c538f8281 David Howells 2012-10-09  @89  #define ENOTCONN	134	/* Transport endpoint is not connected */
61730c538f8281 David Howells 2012-10-09  @90  #define EUCLEAN		135	/* Structure needs cleaning */
61730c538f8281 David Howells 2012-10-09  @91  #define ENOTNAM		137	/* Not a XENIX named type file */
61730c538f8281 David Howells 2012-10-09  @92  #define ENAVAIL		138	/* No XENIX semaphores available */
61730c538f8281 David Howells 2012-10-09  @93  #define EISNAM		139	/* Is a named type file */
61730c538f8281 David Howells 2012-10-09  @94  #define EREMOTEIO	140	/* Remote I/O error */
61730c538f8281 David Howells 2012-10-09   95  #define EINIT		141	/* Reserved */
61730c538f8281 David Howells 2012-10-09   96  #define EREMDEV		142	/* Error 142 */
61730c538f8281 David Howells 2012-10-09  @97  #define ESHUTDOWN	143	/* Cannot send after transport endpoint shutdown */
61730c538f8281 David Howells 2012-10-09  @98  #define ETOOMANYREFS	144	/* Too many references: cannot splice */
61730c538f8281 David Howells 2012-10-09  @99  #define ETIMEDOUT	145	/* Connection timed out */
61730c538f8281 David Howells 2012-10-09 @100  #define ECONNREFUSED	146	/* Connection refused */
61730c538f8281 David Howells 2012-10-09 @101  #define EHOSTDOWN	147	/* Host is down */
61730c538f8281 David Howells 2012-10-09 @102  #define EHOSTUNREACH	148	/* No route to host */
61730c538f8281 David Howells 2012-10-09  103  #define EWOULDBLOCK	EAGAIN	/* Operation would block */
61730c538f8281 David Howells 2012-10-09 @104  #define EALREADY	149	/* Operation already in progress */
61730c538f8281 David Howells 2012-10-09 @105  #define EINPROGRESS	150	/* Operation now in progress */
0ca43435188b9f Eric Sandeen  2013-11-12 @106  #define ESTALE		151	/* Stale file handle */
61730c538f8281 David Howells 2012-10-09 @107  #define ECANCELED	158	/* AIO operation canceled */
61730c538f8281 David Howells 2012-10-09  108  
61730c538f8281 David Howells 2012-10-09  109  /*
61730c538f8281 David Howells 2012-10-09  110   * These error are Linux extensions.
61730c538f8281 David Howells 2012-10-09  111   */
61730c538f8281 David Howells 2012-10-09 @112  #define ENOMEDIUM	159	/* No medium found */
61730c538f8281 David Howells 2012-10-09 @113  #define EMEDIUMTYPE	160	/* Wrong medium type */
61730c538f8281 David Howells 2012-10-09 @114  #define ENOKEY		161	/* Required key not available */
61730c538f8281 David Howells 2012-10-09 @115  #define EKEYEXPIRED	162	/* Key has expired */
61730c538f8281 David Howells 2012-10-09 @116  #define EKEYREVOKED	163	/* Key has been revoked */
61730c538f8281 David Howells 2012-10-09 @117  #define EKEYREJECTED	164	/* Key was rejected by service */
61730c538f8281 David Howells 2012-10-09  118  
61730c538f8281 David Howells 2012-10-09  119  /* for robust mutexes */
61730c538f8281 David Howells 2012-10-09 @120  #define EOWNERDEAD	165	/* Owner died */
61730c538f8281 David Howells 2012-10-09 @121  #define ENOTRECOVERABLE 166	/* State not recoverable */
61730c538f8281 David Howells 2012-10-09  122  
61730c538f8281 David Howells 2012-10-09 @123  #define ERFKILL		167	/* Operation not possible due to RF-kill */
61730c538f8281 David Howells 2012-10-09  124  
61730c538f8281 David Howells 2012-10-09 @125  #define EHWPOISON	168	/* Memory page has hardware error */
61730c538f8281 David Howells 2012-10-09  126  
61730c538f8281 David Howells 2012-10-09 @127  #define EDQUOT		1133	/* Quota exceeded */
61730c538f8281 David Howells 2012-10-09  128  
61730c538f8281 David Howells 2012-10-09  129  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

