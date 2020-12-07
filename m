From: kernel test robot <lkp@intel.com>
Date: Tue, 8 Dec 2020 06:27:55 +0800
Subject: [PATCH v4 4/6] mmc: sdhci-of-aspeed: Add KUnit tests for phase
 calculations
In-Reply-To: <20201207142556.2045481-5-andrew@aj.id.au>
References: <20201207142556.2045481-5-andrew@aj.id.au>
Message-ID: <202012080643.1DqhFDSJ-lkp@intel.com>
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
config: powerpc-allmodconfig (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/0b6ccdd94c4a194549dfc4a3212bd6be5d2841ef
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andrew-Jeffery/mmc-sdhci-of-aspeed-Expose-phase-delay-tuning/20201207-223013
        git checkout 0b6ccdd94c4a194549dfc4a3212bd6be5d2841ef
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> powerpc64-linux-ld: drivers/mmc/host/sdhci-of-aspeed-test.o:(.toc+0x0): undefined reference to `kunit_binary_assert_format'
   powerpc64-linux-ld: drivers/mmc/host/sdhci-of-aspeed-test.o: in function `.aspeed_sdhci_remove':
>> sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_remove+0x34): undefined reference to `.sdhci_remove_host'
>> powerpc64-linux-ld: sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_remove+0x5c): undefined reference to `.sdhci_pltfm_free'
   powerpc64-linux-ld: drivers/mmc/host/sdhci-of-aspeed-test.o: in function `.aspeed_sdhci_get_max_clock':
>> sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_get_max_clock+0x54): undefined reference to `.sdhci_pltfm_clk_get_max_clock'
   powerpc64-linux-ld: drivers/mmc/host/sdhci-of-aspeed-test.o: in function `.aspeed_sdhci_probe':
>> sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_probe+0x8c): undefined reference to `.sdhci_pltfm_init'
>> powerpc64-linux-ld: sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_probe+0x2c0): undefined reference to `.sdhci_get_property'
>> powerpc64-linux-ld: sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_probe+0x374): undefined reference to `.mmc_of_parse'
>> powerpc64-linux-ld: sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_probe+0x3bc): undefined reference to `.mmc_of_parse_clk_phase'
>> powerpc64-linux-ld: sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_probe+0x3d0): undefined reference to `.sdhci_add_host'
>> powerpc64-linux-ld: sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_probe+0x424): undefined reference to `.sdhci_pltfm_free'
   powerpc64-linux-ld: drivers/mmc/host/sdhci-of-aspeed-test.o: in function `.aspeed_sdhci_phase_hs200':
>> sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_phase_hs200+0x270): undefined reference to `.kunit_do_assertion'
>> powerpc64-linux-ld: sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_phase_hs200+0x2f8): undefined reference to `.kunit_do_assertion'
   powerpc64-linux-ld: sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_phase_hs200+0x380): undefined reference to `.kunit_do_assertion'
   powerpc64-linux-ld: sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_phase_hs200+0x410): undefined reference to `.kunit_do_assertion'
   powerpc64-linux-ld: sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_phase_hs200+0x4a8): undefined reference to `.kunit_do_assertion'
   powerpc64-linux-ld: drivers/mmc/host/sdhci-of-aspeed-test.o:sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_phase_hs200+0x530): more undefined references to `.kunit_do_assertion' follow
   powerpc64-linux-ld: drivers/mmc/host/sdhci-of-aspeed-test.o: in function `.aspeed_sdhci_set_clock':
>> sdhci-of-aspeed-test.c:(.text.aspeed_sdhci_set_clock+0x5c4): undefined reference to `.sdhci_enable_clk'
>> powerpc64-linux-ld: drivers/mmc/host/sdhci-of-aspeed-test.o:(.data.rel.aspeed_sdc_driver+0xa0): undefined reference to `sdhci_pltfm_pmops'
>> powerpc64-linux-ld: drivers/mmc/host/sdhci-of-aspeed-test.o:(.data.rel.ro.aspeed_sdhci_ops+0x20): undefined reference to `sdhci_set_uhs_signaling'
>> powerpc64-linux-ld: drivers/mmc/host/sdhci-of-aspeed-test.o:(.data.rel.ro.aspeed_sdhci_ops+0x88): undefined reference to `sdhci_reset'
>> powerpc64-linux-ld: drivers/mmc/host/sdhci-of-aspeed-test.o:(.data.rel.ro.aspeed_sdhci_ops+0xd8): undefined reference to `sdhci_pltfm_clk_get_max_clock'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 71576 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20201208/2ae9c375/attachment-0001.gz>
