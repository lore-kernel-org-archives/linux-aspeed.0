From: Julia Lawall <julia.lawall@lip6.fr>
Date: Sun, 17 Nov 2019 12:17:19 +0100 (CET)
Subject: [PATCH 06/12] drivers/soc: Add Aspeed XDMA Engine Driver (fwd)
Message-ID: <alpine.DEB.2.21.1911171216090.2641@hadrien>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Please check on the missing iounmap issue.  Patches have beenf
forwarded for the other issues.

julia

---------- Forwarded message ----------
Date: Sun, 17 Nov 2019 16:34:53 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 06/12] drivers/soc: Add Aspeed XDMA Engine Driver

In-Reply-To: <1573244313-9190-7-git-send-email-eajames@linux.ibm.com>
References: <1573244313-9190-7-git-send-email-eajames@linux.ibm.com>

Hi Eddie,

I love your patch! Perhaps something to improve:

[auto build test WARNING on joel-aspeed/for-next]
[also build test WARNING on v5.4-rc7 next-20191115]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Eddie-James/Aspeed-Add-SCU-interrupt-controller-and-XDMA-engine-drivers/20191110-064846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git for-next
:::::: branch date: 7 days ago
:::::: commit date: 7 days ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> drivers/soc/aspeed/aspeed-xdma.c:614:2-8: ERROR: missing iounmap; ioremap on line 580 and execution via conditional on line 612
--
>> drivers/soc/aspeed/aspeed-xdma.c:756:2-9: line 756 is redundant because platform_get_irq() already prints an error
--
>> drivers/soc/aspeed/aspeed-xdma.c:610:2-3: Unneeded semicolon
   drivers/soc/aspeed/aspeed-xdma.c:738:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
