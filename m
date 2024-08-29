From: kernel test robot <lkp@intel.com>
Date: Thu, 29 Aug 2024 08:18:29 +0800
Subject: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
In-Reply-To: <20240828062740.1614744-4-ryan_chen@aspeedtech.com>
References: <20240828062740.1614744-4-ryan_chen@aspeedtech.com>
Message-ID: <202408290836.KrEafUdK-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.11-rc5 next-20240828]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-reset-Add-AST2700-reset-bindings/20240828-143005
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20240828062740.1614744-4-ryan_chen%40aspeedtech.com
patch subject: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
config: microblaze-randconfig-r111-20240829 (https://download.01.org/0day-ci/archive/20240829/202408290836.KrEafUdK-lkp at intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240829/202408290836.KrEafUdK-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408290836.KrEafUdK-lkp at intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/clk/clk-ast2700.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
>> drivers/clk/clk-ast2700.c:100:10: sparse: sparse: Initializer entry defined twice
   drivers/clk/clk-ast2700.c:107:10: sparse:   also defined here

vim +100 drivers/clk/clk-ast2700.c

    66	
    67	static const struct ast2700_reset_signal ast2700_reset0_signals[] = {
    68		[SCU0_RESET_SDRAM] = { 1, SCU0_RESET_CTRL1, BIT(0) },
    69		[SCU0_RESET_DDRPHY] = { 1, SCU0_RESET_CTRL1, BIT(1) },
    70		[SCU0_RESET_RSA]     = { 1, SCU0_RESET_CTRL1, BIT(2) },
    71		[SCU0_RESET_SHA3]	= { 1, SCU0_RESET_CTRL1, BIT(3) },
    72		[SCU0_RESET_HACE]	= { 1, SCU0_RESET_CTRL1, BIT(4) },
    73		[SCU0_RESET_SOC]	= { 1, SCU0_RESET_CTRL1, BIT(5) },
    74		[SCU0_RESET_VIDEO]	= { 1, SCU0_RESET_CTRL1, BIT(6) },
    75		[SCU0_RESET_2D]	= { 1, SCU0_RESET_CTRL1, BIT(7) },
    76		[SCU0_RESET_PCIS]	= { 1, SCU0_RESET_CTRL1, BIT(8) },
    77		[SCU0_RESET_RVAS0]		= { 1, SCU0_RESET_CTRL1, BIT(9) },
    78		[SCU0_RESET_RVAS1]		= { 1, SCU0_RESET_CTRL1, BIT(10) },
    79		[SCU0_RESET_SM3]		= { 1, SCU0_RESET_CTRL1, BIT(11) },
    80		[SCU0_RESET_SM4]		= { 1, SCU0_RESET_CTRL1, BIT(12) },
    81		[SCU0_RESET_CRT0]	= { 1, SCU0_RESET_CTRL1, BIT(13) },
    82		[SCU0_RESET_ECC]	= { 1, SCU0_RESET_CTRL1, BIT(14) },
    83		[SCU0_RESET_DP_PCI]	= { 1, SCU0_RESET_CTRL1, BIT(15) },
    84		[SCU0_RESET_UFS]	= { 1, SCU0_RESET_CTRL1, BIT(16) },
    85		[SCU0_RESET_EMMC]	= { 1, SCU0_RESET_CTRL1, BIT(17) },
    86		[SCU0_RESET_PCIE1RST]	= { 1, SCU0_RESET_CTRL1, BIT(18) },
    87		[SCU0_RESET_PCIE1RSTOE]	= { 1, SCU0_RESET_CTRL1, BIT(19) },
    88		[SCU0_RESET_PCIE0RST]		= { 1, SCU0_RESET_CTRL1, BIT(20) },
    89		[SCU0_RESET_PCIE0RSTOE]	= { 1, SCU0_RESET_CTRL1, BIT(21) },
    90		[SCU0_RESET_JTAG]	= { 1, SCU0_RESET_CTRL1, BIT(22) },
    91		[SCU0_RESET_MCTP0] = { 1, SCU0_RESET_CTRL1, BIT(23) },
    92		[SCU0_RESET_MCTP1]		= { 1, SCU0_RESET_CTRL1, BIT(24) },
    93		[SCU0_RESET_XDMA0]	= { 1, SCU0_RESET_CTRL1, BIT(25) },
    94		[SCU0_RESET_XDMA1]	= { 1, SCU0_RESET_CTRL1, BIT(26) },
    95		[SCU0_RESET_H2X1]	= { 1, SCU0_RESET_CTRL1, BIT(27) },
    96		[SCU0_RESET_DP]	= { 1, SCU0_RESET_CTRL1, BIT(28) },
    97		[SCU0_RESET_DP_MCU]	= { 1, SCU0_RESET_CTRL1, BIT(29) },
    98		[SCU0_RESET_SSP]	= { 1, SCU0_RESET_CTRL1, BIT(30) },
    99		[SCU0_RESET_H2X0]	= { 1, SCU0_RESET_CTRL1, BIT(31) },
 > 100		[SCU0_RESET_PORTA_USB]	= { 1, SCU0_RESET_CTRL2, BIT(0) },
   101		[SCU0_RESET_PORTA_PHY3]	= { 1, SCU0_RESET_CTRL2, BIT(1) },
   102		[SCU0_RESET_PORTA_XHCI]	= { 1, SCU0_RESET_CTRL2, BIT(2) },
   103		[SCU0_RESET_PORTB_VHUB1]	= { 1, SCU0_RESET_CTRL2, BIT(3) },
   104		[SCU0_RESET_PORTB_PHY3]	= { 1, SCU0_RESET_CTRL2, BIT(4) },
   105		[SCU0_RESET_PORTB_XHCI]	= { 1, SCU0_RESET_CTRL2, BIT(5) },
   106		/*PORTA EHCI/VHUB share reset */
   107		[SCU0_RESET_PORTA_USB]	= { 1, SCU0_RESET_CTRL2, BIT(6) },
   108		/*PORTB EHCI/VHUB share reset */
   109		[SCU0_RESET_PORTB_USB]	= { 1, SCU0_RESET_CTRL2, BIT(7) },
   110		[SCU0_RESET_UHCI]	= { 1, SCU0_RESET_CTRL2, BIT(8) },
   111		[SCU0_RESET_TSP]	= { 1, SCU0_RESET_CTRL2, BIT(9) },
   112		[SCU0_RESET_E2M0]	= { 1, SCU0_RESET_CTRL2, BIT(10) },
   113		[SCU0_RESET_E2M1]	= { 1, SCU0_RESET_CTRL2, BIT(11) },
   114		[SCU0_RESET_VLINK]	= { 1, SCU0_RESET_CTRL2, BIT(12) },
   115	};
   116	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
