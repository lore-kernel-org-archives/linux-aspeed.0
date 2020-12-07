From: kernel test robot <lkp@intel.com>
Date: Tue, 8 Dec 2020 00:55:41 +0800
Subject: [PATCH v4 2/6] mmc: sdhci-of-aspeed: Expose clock phase controls
In-Reply-To: <20201207142556.2045481-3-andrew@aj.id.au>
References: <20201207142556.2045481-3-andrew@aj.id.au>
Message-ID: <202012080031.ulKkOJTH-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

I love your patch! Yet something to improve:

[auto build test ERROR on joel-aspeed/for-next]
[also build test ERROR on linus/master v5.10-rc7 next-20201207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andrew-Jeffery/mmc-sdhci-of-aspeed-Expose-phase-delay-tuning/20201207-223013
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git for-next
config: i386-randconfig-c001-20201207 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/32790700ff748c3f5b3bb32c29d7ed4478c2d6ac
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andrew-Jeffery/mmc-sdhci-of-aspeed-Expose-phase-delay-tuning/20201207-223013
        git checkout 32790700ff748c3f5b3bb32c29d7ed4478c2d6ac
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "mmc_of_parse_clk_phase" [drivers/mmc/host/sdhci-of-aspeed.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31915 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20201208/a4801f17/attachment-0001.gz>
