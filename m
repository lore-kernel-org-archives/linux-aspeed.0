From: kernel test robot <lkp@intel.com>
Date: Tue, 3 Nov 2020 08:33:30 +0800
Subject: [PATCH 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
 driver
In-Reply-To: <20201102075213.32404-5-chin-ting_kuo@aspeedtech.com>
References: <20201102075213.32404-5-chin-ting_kuo@aspeedtech.com>
Message-ID: <202011030837.7N6VAUp7-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Chin-Ting,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on spi/for-next]
[also build test WARNING on joel-aspeed/for-next robh/for-next v5.10-rc2 next-20201102]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Chin-Ting-Kuo/Porting-ASPEED-FMC-SPI-memory-controller-driver/20201102-155338
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: i386-randconfig-s002-20201103 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.3-76-gf680124b-dirty
        # https://github.com/0day-ci/linux/commit/ea03a6d2bc571f270832134f8fa4aa7d8df7db11
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chin-Ting-Kuo/Porting-ASPEED-FMC-SPI-memory-controller-driver/20201102-155338
        git checkout ea03a6d2bc571f270832134f8fa4aa7d8df7db11
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/spi/spi-aspeed.c:147:10: sparse: sparse: symbol 'aspeed_spi_get_io_mode' was not declared. Should it be static?
>> drivers/spi/spi-aspeed.c:298:5: sparse: sparse: symbol 'aspeed_2600_spi_timing_calibration' was not declared. Should it be static?
>> drivers/spi/spi-aspeed.c:435:6: sparse: sparse: symbol 'aspeed_2600_adjust_decode_sz' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34023 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20201103/cde795f1/attachment-0001.gz>
