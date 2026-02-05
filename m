Return-Path: <linux-aspeed+bounces-3489-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E52E91297
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Feb 2026 14:41:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6KfY73Zgz2yF1;
	Fri, 06 Feb 2026 01:41:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770302485;
	cv=none; b=osND25S7bgqLGwxwUw3cMxPRxgKSgY4oWQMnprR8fs2qmQ8PUyaXcjIEfANXpDXJVvuUsGYAHsL/mrdRD7ks7TVIsKUu7cdw6gQ8JA2SP9FLK6T76bXBbovnmqeJj3+ZpYXNehfKrJMMK6bRpHQeT0q3FwGqO/+zpPyNjGCmqkqHqY6KH7ZcGsDxqZB60eFm/hjZWeThz21kyDZDapDJHCDkyFf/7jAT27VKF1Em3Q6zgapcKuepF17KRhGNLywfxT+jrbT8Pf+H44nd1HNBr8XNc74amFaSA3VlM+rtTzYVg7X6fbfCsRAnW84aw3gkXylv+RQUcpm+ji2UO9oxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770302485; c=relaxed/relaxed;
	bh=hJZMDuGBu6bDqq7PQS6TPcdQWOAxcmlel2iQ5QBK3Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBPz0mH6+cesTnjpUG9Iqz+zSaTmpoGqwXy6ziRM37mwzAIVhVL2nMSvDTgqM0pWkUlvCRSPduEY/5eQ2s7s18KjrOVguKYhdrs9yHhnDsDmAX3a1mOwz+kcFkosKck6vXMo+zKiQyQIzJawCBEK9TQEK5PHViV0K53S1NkschNLNdRa/JiUc+np2OCGpSlO5qdit/VcjNLRR2jLSTv270x3h0rTbVUaVAQ3qsfB3Cfw7D4skaAp3fu+uY70HEGGiFk7ih4nqsTauAIsICyIfDOShz9mptptYQnM9pXXVYdkH5QU80WQPyT0OVzGXokszVE/PBveUtcbVFiRAJAZ+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qr2hDi7M; dkim-atps=neutral; spf=pass (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qr2hDi7M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6KfV5DqZz2xrk
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Feb 2026 01:41:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770302484; x=1801838484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FmPLymbxSkS6U6kJpeEY2WkMo/UmdyrGf9Tt681r5mY=;
  b=Qr2hDi7MwWn2ZYiMmZKASk9USUap9GH0pFaA8EMlENs0yrX9qekRANaU
   gl86oE8m73hgSqkKXLJb3O68YSu/ICIAJVJgnPW2H2eux7NobUcVFpDwa
   5g9sXfTJDOk8uaEaEcQqKUfoZNzw3sDkAuSM2l6no1YSxZ9CD816J4Y0w
   YV8g0hGf6AjHX00QT0LhrZjsZQtU8RVQAPpKdKLOBH6YecnCg1urgyVag
   EjDJBca84M0KMPuBTPo1lV8s+3qOMiA4MbaNurTwtAwOynLtqnsRRqSkP
   vkUj9whs0qDj7Hzv8y5/1rNPpw6IILlRuskcoEXq4xQ8iz8egfL+uBJDM
   w==;
X-CSE-ConnectionGUID: 8D9ubLM8SrOLLzaT9Mij8A==
X-CSE-MsgGUID: ev9jAO+dRXCEAVFLFB6KKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71491811"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71491811"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 06:41:17 -0800
X-CSE-ConnectionGUID: gwzhyyZTTlyt4QR0mPSMeQ==
X-CSE-MsgGUID: //mxS/HdQ7ujR8qFHU0j5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="215064085"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 05 Feb 2026 06:41:12 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vo0Xd-00000000jsy-0v0o;
	Thu, 05 Feb 2026 14:41:09 +0000
Date: Thu, 5 Feb 2026 22:40:38 +0800
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
Message-ID: <202602052259.vW8lLakZ-lkp@intel.com>
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
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20260205/202602052259.vW8lLakZ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602052259.vW8lLakZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602052259.vW8lLakZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/err.h:8,
                    from include/linux/cleanup.h:6,
                    from include/linux/irqflags.h:17,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/parisc/include/asm/cmpxchg.h:87,
                    from arch/parisc/include/asm/atomic.h:10,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:67,
                    from drivers/irqchip/irq-ast2700-intc0.c:9:
>> arch/parisc/include/uapi/asm/errno.h:7:9: warning: 'ENOMSG' redefined
       7 | #define ENOMSG          35      /* No message of desired type */
         |         ^~~~~~
   In file included from drivers/irqchip/irq-ast2700-intc0.c:8:
   include/uapi/asm-generic/errno.h:23:9: note: this is the location of the previous definition
      23 | #define ENOMSG          42      /* No message of desired type */
         |         ^~~~~~
>> arch/parisc/include/uapi/asm/errno.h:8:9: warning: 'EIDRM' redefined
       8 | #define EIDRM           36      /* Identifier removed */
         |         ^~~~~
   include/uapi/asm-generic/errno.h:24:9: note: this is the location of the previous definition
      24 | #define EIDRM           43      /* Identifier removed */
         |         ^~~~~
>> arch/parisc/include/uapi/asm/errno.h:9:9: warning: 'ECHRNG' redefined
       9 | #define ECHRNG          37      /* Channel number out of range */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:25:9: note: this is the location of the previous definition
      25 | #define ECHRNG          44      /* Channel number out of range */
         |         ^~~~~~
>> arch/parisc/include/uapi/asm/errno.h:10:9: warning: 'EL2NSYNC' redefined
      10 | #define EL2NSYNC        38      /* Level 2 not synchronized */
         |         ^~~~~~~~
   include/uapi/asm-generic/errno.h:26:9: note: this is the location of the previous definition
      26 | #define EL2NSYNC        45      /* Level 2 not synchronized */
         |         ^~~~~~~~
>> arch/parisc/include/uapi/asm/errno.h:11:9: warning: 'EL3HLT' redefined
      11 | #define EL3HLT          39      /* Level 3 halted */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:27:9: note: this is the location of the previous definition
      27 | #define EL3HLT          46      /* Level 3 halted */
         |         ^~~~~~
>> arch/parisc/include/uapi/asm/errno.h:12:9: warning: 'EL3RST' redefined
      12 | #define EL3RST          40      /* Level 3 reset */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:28:9: note: this is the location of the previous definition
      28 | #define EL3RST          47      /* Level 3 reset */
         |         ^~~~~~
>> arch/parisc/include/uapi/asm/errno.h:13:9: warning: 'ELNRNG' redefined
      13 | #define ELNRNG          41      /* Link number out of range */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:29:9: note: this is the location of the previous definition
      29 | #define ELNRNG          48      /* Link number out of range */
         |         ^~~~~~
>> arch/parisc/include/uapi/asm/errno.h:14:9: warning: 'EUNATCH' redefined
      14 | #define EUNATCH         42      /* Protocol driver not attached */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:30:9: note: this is the location of the previous definition
      30 | #define EUNATCH         49      /* Protocol driver not attached */
         |         ^~~~~~~
>> arch/parisc/include/uapi/asm/errno.h:15:9: warning: 'ENOCSI' redefined
      15 | #define ENOCSI          43      /* No CSI structure available */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:31:9: note: this is the location of the previous definition
      31 | #define ENOCSI          50      /* No CSI structure available */
         |         ^~~~~~
>> arch/parisc/include/uapi/asm/errno.h:16:9: warning: 'EL2HLT' redefined
      16 | #define EL2HLT          44      /* Level 2 halted */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:32:9: note: this is the location of the previous definition
      32 | #define EL2HLT          51      /* Level 2 halted */
         |         ^~~~~~
>> arch/parisc/include/uapi/asm/errno.h:17:9: warning: 'EDEADLK' redefined
      17 | #define EDEADLK         45      /* Resource deadlock would occur */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:7:9: note: this is the location of the previous definition
       7 | #define EDEADLK         35      /* Resource deadlock would occur */
         |         ^~~~~~~
>> arch/parisc/include/uapi/asm/errno.h:19:9: warning: 'ENOLCK' redefined
      19 | #define ENOLCK          46      /* No record locks available */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:9:9: note: this is the location of the previous definition
       9 | #define ENOLCK          37      /* No record locks available */
         |         ^~~~~~
>> arch/parisc/include/uapi/asm/errno.h:20:9: warning: 'EILSEQ' redefined
      20 | #define EILSEQ          47      /* Illegal byte sequence */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:67:9: note: this is the location of the previous definition
      67 | #define EILSEQ          84      /* Illegal byte sequence */
         |         ^~~~~~
>> arch/parisc/include/uapi/asm/errno.h:22:9: warning: 'ENONET' redefined
      22 | #define ENONET          50      /* Machine is not on the network */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:47:9: note: this is the location of the previous definition
      47 | #define ENONET          64      /* Machine is not on the network */
         |         ^~~~~~
>> arch/parisc/include/uapi/asm/errno.h:23:9: warning: 'ENODATA' redefined
      23 | #define ENODATA         51      /* No data available */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:44:9: note: this is the location of the previous definition
      44 | #define ENODATA         61      /* No data available */
         |         ^~~~~~~
>> arch/parisc/include/uapi/asm/errno.h:24:9: warning: 'ETIME' redefined
      24 | #define ETIME           52      /* Timer expired */
         |         ^~~~~
   include/uapi/asm-generic/errno.h:45:9: note: this is the location of the previous definition
      45 | #define ETIME           62      /* Timer expired */
         |         ^~~~~
>> arch/parisc/include/uapi/asm/errno.h:25:9: warning: 'ENOSR' redefined
      25 | #define ENOSR           53      /* Out of streams resources */
         |         ^~~~~
   include/uapi/asm-generic/errno.h:46:9: note: this is the location of the previous definition
      46 | #define ENOSR           63      /* Out of streams resources */
         |         ^~~~~
>> arch/parisc/include/uapi/asm/errno.h:26:9: warning: 'ENOSTR' redefined
      26 | #define ENOSTR          54      /* Device not a stream */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:43:9: note: this is the location of the previous definition
      43 | #define ENOSTR          60      /* Device not a stream */
         |         ^~~~~~
>> arch/parisc/include/uapi/asm/errno.h:27:9: warning: 'ENOPKG' redefined
      27 | #define ENOPKG          55      /* Package not installed */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:48:9: note: this is the location of the previous definition
      48 | #define ENOPKG          65      /* Package not installed */
         |         ^~~~~~
>> arch/parisc/include/uapi/asm/errno.h:29:9: warning: 'ENOLINK' redefined
      29 | #define ENOLINK         57      /* Link has been severed */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:50:9: note: this is the location of the previous definition
      50 | #define ENOLINK         67      /* Link has been severed */
         |         ^~~~~~~
   arch/parisc/include/uapi/asm/errno.h:30:9: warning: 'EADV' redefined
      30 | #define EADV            58      /* Advertise error */
         |         ^~~~
   include/uapi/asm-generic/errno.h:51:9: note: this is the location of the previous definition
      51 | #define EADV            68      /* Advertise error */
         |         ^~~~
   arch/parisc/include/uapi/asm/errno.h:31:9: warning: 'ESRMNT' redefined
      31 | #define ESRMNT          59      /* Srmount error */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:52:9: note: this is the location of the previous definition
      52 | #define ESRMNT          69      /* Srmount error */
         |         ^~~~~~
   arch/parisc/include/uapi/asm/errno.h:32:9: warning: 'ECOMM' redefined
      32 | #define ECOMM           60      /* Communication error on send */
         |         ^~~~~
   include/uapi/asm-generic/errno.h:53:9: note: this is the location of the previous definition
      53 | #define ECOMM           70      /* Communication error on send */
         |         ^~~~~
   arch/parisc/include/uapi/asm/errno.h:33:9: warning: 'EPROTO' redefined
      33 | #define EPROTO          61      /* Protocol error */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:54:9: note: this is the location of the previous definition
      54 | #define EPROTO          71      /* Protocol error */
         |         ^~~~~~
   arch/parisc/include/uapi/asm/errno.h:35:9: warning: 'EMULTIHOP' redefined
      35 | #define EMULTIHOP       64      /* Multihop attempted */
         |         ^~~~~~~~~
   include/uapi/asm-generic/errno.h:55:9: note: this is the location of the previous definition
      55 | #define EMULTIHOP       72      /* Multihop attempted */
         |         ^~~~~~~~~
   arch/parisc/include/uapi/asm/errno.h:37:9: warning: 'EDOTDOT' redefined
      37 | #define EDOTDOT         66      /* RFS specific error */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:56:9: note: this is the location of the previous definition
      56 | #define EDOTDOT         73      /* RFS specific error */
         |         ^~~~~~~
   arch/parisc/include/uapi/asm/errno.h:38:9: warning: 'EBADMSG' redefined
      38 | #define EBADMSG         67      /* Not a data message */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:57:9: note: this is the location of the previous definition
      57 | #define EBADMSG         74      /* Not a data message */
         |         ^~~~~~~
   arch/parisc/include/uapi/asm/errno.h:39:9: warning: 'EUSERS' redefined
      39 | #define EUSERS          68      /* Too many users */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:70:9: note: this is the location of the previous definition
      70 | #define EUSERS          87      /* Too many users */
         |         ^~~~~~
   arch/parisc/include/uapi/asm/errno.h:40:9: warning: 'EDQUOT' redefined
      40 | #define EDQUOT          69      /* Quota exceeded */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:105:9: note: this is the location of the previous definition
     105 | #define EDQUOT          122     /* Quota exceeded */
         |         ^~~~~~
   arch/parisc/include/uapi/asm/errno.h:41:9: warning: 'ESTALE' redefined
      41 | #define ESTALE          70      /* Stale file handle */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:99:9: note: this is the location of the previous definition
      99 | #define ESTALE          116     /* Stale file handle */
         |         ^~~~~~
   arch/parisc/include/uapi/asm/errno.h:42:9: warning: 'EREMOTE' redefined
      42 | #define EREMOTE         71      /* Object is remote */
         |         ^~~~~~~
   include/uapi/asm-generic/errno.h:49:9: note: this is the location of the previous definition
      49 | #define EREMOTE         66      /* Object is remote */
         |         ^~~~~~~
   arch/parisc/include/uapi/asm/errno.h:43:9: warning: 'EOVERFLOW' redefined
      43 | #define EOVERFLOW       72      /* Value too large for defined data type */
         |         ^~~~~~~~~
   include/uapi/asm-generic/errno.h:58:9: note: this is the location of the previous definition
      58 | #define EOVERFLOW       75      /* Value too large for defined data type */
         |         ^~~~~~~~~
   arch/parisc/include/uapi/asm/errno.h:47:9: warning: 'EBADE' redefined
      47 | #define EBADE           160     /* Invalid exchange */
         |         ^~~~~
   include/uapi/asm-generic/errno.h:33:9: note: this is the location of the previous definition
      33 | #define EBADE           52      /* Invalid exchange */
         |         ^~~~~
   arch/parisc/include/uapi/asm/errno.h:48:9: warning: 'EBADR' redefined
      48 | #define EBADR           161     /* Invalid request descriptor */
         |         ^~~~~
   include/uapi/asm-generic/errno.h:34:9: note: this is the location of the previous definition
      34 | #define EBADR           53      /* Invalid request descriptor */
         |         ^~~~~
   arch/parisc/include/uapi/asm/errno.h:49:9: warning: 'EXFULL' redefined
      49 | #define EXFULL          162     /* Exchange full */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:35:9: note: this is the location of the previous definition
      35 | #define EXFULL          54      /* Exchange full */
         |         ^~~~~~
   arch/parisc/include/uapi/asm/errno.h:50:9: warning: 'ENOANO' redefined
      50 | #define ENOANO          163     /* No anode */
         |         ^~~~~~
   include/uapi/asm-generic/errno.h:36:9: note: this is the location of the previous definition
      36 | #define ENOANO          55      /* No anode */


vim +/ENOMSG +7 arch/parisc/include/uapi/asm/errno.h

^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16    6  
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   @7  #define	ENOMSG		35	/* No message of desired type */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   @8  #define	EIDRM		36	/* Identifier removed */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   @9  #define	ECHRNG		37	/* Channel number out of range */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @10  #define	EL2NSYNC	38	/* Level 2 not synchronized */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @11  #define	EL3HLT		39	/* Level 3 halted */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @12  #define	EL3RST		40	/* Level 3 reset */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @13  #define	ELNRNG		41	/* Link number out of range */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @14  #define	EUNATCH		42	/* Protocol driver not attached */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @15  #define	ENOCSI		43	/* No CSI structure available */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @16  #define	EL2HLT		44	/* Level 2 halted */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @17  #define	EDEADLK		45	/* Resource deadlock would occur */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   18  #define	EDEADLOCK	EDEADLK
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @19  #define	ENOLCK		46	/* No record locks available */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @20  #define	EILSEQ		47	/* Illegal byte sequence */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   21  
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @22  #define	ENONET		50	/* Machine is not on the network */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @23  #define	ENODATA		51	/* No data available */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @24  #define	ETIME		52	/* Timer expired */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @25  #define	ENOSR		53	/* Out of streams resources */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @26  #define	ENOSTR		54	/* Device not a stream */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @27  #define	ENOPKG		55	/* Package not installed */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   28  
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @29  #define	ENOLINK		57	/* Link has been severed */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @30  #define	EADV		58	/* Advertise error */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @31  #define	ESRMNT		59	/* Srmount error */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @32  #define	ECOMM		60	/* Communication error on send */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @33  #define	EPROTO		61	/* Protocol error */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   34  
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @35  #define	EMULTIHOP	64	/* Multihop attempted */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   36  
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @37  #define	EDOTDOT		66	/* RFS specific error */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @38  #define	EBADMSG		67	/* Not a data message */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @39  #define	EUSERS		68	/* Too many users */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @40  #define	EDQUOT		69	/* Quota exceeded */
0ca43435188b9f9 arch/parisc/include/uapi/asm/errno.h Eric Sandeen        2013-11-12  @41  #define	ESTALE		70	/* Stale file handle */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @42  #define	EREMOTE		71	/* Object is remote */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @43  #define	EOVERFLOW	72	/* Value too large for defined data type */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   44  
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   45  /* these errnos are defined by Linux but not HPUX. */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   46  
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @47  #define	EBADE		160	/* Invalid exchange */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @48  #define	EBADR		161	/* Invalid request descriptor */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @49  #define	EXFULL		162	/* Exchange full */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @50  #define	ENOANO		163	/* No anode */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @51  #define	EBADRQC		164	/* Invalid request code */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @52  #define	EBADSLT		165	/* Invalid slot */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @53  #define	EBFONT		166	/* Bad font file format */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @54  #define	ENOTUNIQ	167	/* Name not unique on network */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @55  #define	EBADFD		168	/* File descriptor in bad state */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @56  #define	EREMCHG		169	/* Remote address changed */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @57  #define	ELIBACC		170	/* Can not access a needed shared library */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @58  #define	ELIBBAD		171	/* Accessing a corrupted shared library */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @59  #define	ELIBSCN		172	/* .lib section in a.out corrupted */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @60  #define	ELIBMAX		173	/* Attempting to link in too many shared libraries */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @61  #define	ELIBEXEC	174	/* Cannot exec a shared library directly */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @62  #define	ERESTART	175	/* Interrupted system call should be restarted */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @63  #define	ESTRPIPE	176	/* Streams pipe error */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @64  #define	EUCLEAN		177	/* Structure needs cleaning */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @65  #define	ENOTNAM		178	/* Not a XENIX named type file */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @66  #define	ENAVAIL		179	/* No XENIX semaphores available */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @67  #define	EISNAM		180	/* Is a named type file */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @68  #define	EREMOTEIO	181	/* Remote I/O error */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @69  #define	ENOMEDIUM	182	/* No medium found */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @70  #define	EMEDIUMTYPE	183	/* Wrong medium type */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @71  #define	ENOKEY		184	/* Required key not available */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @72  #define	EKEYEXPIRED	185	/* Key has expired */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @73  #define	EKEYREVOKED	186	/* Key has been revoked */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @74  #define	EKEYREJECTED	187	/* Key was rejected by service */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   75  
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   76  /* We now return you to your regularly scheduled HPUX. */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   77  
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @78  #define	ENOTSOCK	216	/* Socket operation on non-socket */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @79  #define	EDESTADDRREQ	217	/* Destination address required */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @80  #define	EMSGSIZE	218	/* Message too long */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @81  #define	EPROTOTYPE	219	/* Protocol wrong type for socket */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @82  #define	ENOPROTOOPT	220	/* Protocol not available */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @83  #define	EPROTONOSUPPORT	221	/* Protocol not supported */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @84  #define	ESOCKTNOSUPPORT	222	/* Socket type not supported */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @85  #define	EOPNOTSUPP	223	/* Operation not supported on transport endpoint */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @86  #define	EPFNOSUPPORT	224	/* Protocol family not supported */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @87  #define	EAFNOSUPPORT	225	/* Address family not supported by protocol */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @88  #define	EADDRINUSE	226	/* Address already in use */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @89  #define	EADDRNOTAVAIL	227	/* Cannot assign requested address */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @90  #define	ENETDOWN	228	/* Network is down */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @91  #define	ENETUNREACH	229	/* Network is unreachable */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @92  #define	ENETRESET	230	/* Network dropped connection because of reset */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @93  #define	ECONNABORTED	231	/* Software caused connection abort */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @94  #define	ECONNRESET	232	/* Connection reset by peer */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @95  #define	ENOBUFS		233	/* No buffer space available */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @96  #define	EISCONN		234	/* Transport endpoint is already connected */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @97  #define	ENOTCONN	235	/* Transport endpoint is not connected */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @98  #define	ESHUTDOWN	236	/* Cannot send after transport endpoint shutdown */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @99  #define	ETOOMANYREFS	237	/* Too many references: cannot splice */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @100  #define	ETIMEDOUT	238	/* Connection timed out */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @101  #define	ECONNREFUSED	239	/* Connection refused */
3eb53b20d7bd137 arch/parisc/include/uapi/asm/errno.h Helge Deller        2016-08-20  102  #define	EREFUSED	ECONNREFUSED	/* for HP's NFS apparently */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @103  #define	EHOSTDOWN	241	/* Host is down */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @104  #define	EHOSTUNREACH	242	/* No route to host */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  105  
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @106  #define	EALREADY	244	/* Operation already in progress */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @107  #define	EINPROGRESS	245	/* Operation now in progress */
f5a408d53edef3a arch/parisc/include/uapi/asm/errno.h Guy Martin          2014-01-16  108  #define	EWOULDBLOCK	EAGAIN	/* Operation would block (Not HPUX compliant) */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @109  #define	ENOTEMPTY	247	/* Directory not empty */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @110  #define	ENAMETOOLONG	248	/* File name too long */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @111  #define	ELOOP		249	/* Too many symbolic links encountered */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @112  #define	ENOSYS		251	/* Function not implemented */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  113  
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  114  #define ECANCELLED	253	/* aio request was canceled before complete (POSIX.4 / HPUX) */
05aa10de701409b include/asm-parisc/errno.h           Grant Grundler      2005-10-21 @115  #define ECANCELED	ECANCELLED	/* SuSv3 and Solaris wants one 'L' */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  116  
4750e2c0c59e0c8 include/asm-parisc/errno.h           Joe Korty           2005-05-01  117  /* for robust mutexes */
4750e2c0c59e0c8 include/asm-parisc/errno.h           Joe Korty           2005-05-01 @118  #define EOWNERDEAD	254	/* Owner died */
4750e2c0c59e0c8 include/asm-parisc/errno.h           Joe Korty           2005-05-01 @119  #define ENOTRECOVERABLE	255	/* State not recoverable */
4750e2c0c59e0c8 include/asm-parisc/errno.h           Joe Korty           2005-05-01  120  
7d217d7ffc3433d arch/parisc/include/asm/errno.h      Alexander Beregalov 2009-06-07 @121  #define	ERFKILL		256	/* Operation not possible due to RF-kill */
^1da177e4c3f415 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  122  
69ebb83e13e5142 arch/parisc/include/asm/errno.h      Ying Huang          2011-01-30 @123  #define EHWPOISON	257	/* Memory page has hardware error */
69ebb83e13e5142 arch/parisc/include/asm/errno.h      Ying Huang          2011-01-30  124  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

