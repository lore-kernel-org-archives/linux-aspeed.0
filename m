From: kernel test robot <lkp@intel.com>
Date: Thu, 25 Nov 2021 16:38:00 +0800
Subject: [PATCH 3/3] ARM: aspeed: Add secure boot controller support
In-Reply-To: <20211117035106.321454-4-joel@jms.id.au>
References: <20211117035106.321454-4-joel@jms.id.au>
Message-ID: <202111251600.hBmyvSD0-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on soc/for-next rockchip/for-next shawnguo/for-next v5.16-rc2 next-20211125]
[cannot apply to arm/for-next arm64/for-next/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Joel-Stanley/ARM-aspeed-Secure-Boot-Controller-support/20211117-115258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: sparc64-randconfig-s032-20211118 (https://download.01.org/0day-ci/archive/20211125/202111251600.hBmyvSD0-lkp at intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/5057997868102d26f0af9c8d769a4809a3bd60be
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Joel-Stanley/ARM-aspeed-Secure-Boot-Controller-support/20211117-115258
        git checkout 5057997868102d26f0af9c8d769a4809a3bd60be
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sparc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/soc/aspeed/aspeed-socinfo.c:166:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/soc/aspeed/aspeed-socinfo.c:166:38: sparse:     expected void *base
   drivers/soc/aspeed/aspeed-socinfo.c:166:38: sparse:     got void [noderef] __iomem *
>> drivers/soc/aspeed/aspeed-socinfo.c:171:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/soc/aspeed/aspeed-socinfo.c:171:46: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/aspeed/aspeed-socinfo.c:171:46: sparse:     got void *
>> drivers/soc/aspeed/aspeed-socinfo.c:173:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *base @@
   drivers/soc/aspeed/aspeed-socinfo.c:173:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/soc/aspeed/aspeed-socinfo.c:173:25: sparse:     got void *base

vim +166 drivers/soc/aspeed/aspeed-socinfo.c

   126	
   127	static int __init aspeed_socinfo_init(void)
   128	{
   129		struct soc_device_attribute *attrs;
   130		struct soc_device *soc_dev;
   131		struct device_node *np;
   132		void __iomem *reg;
   133		bool has_chipid = false;
   134		bool has_sbe = false;
   135		u32 siliconid;
   136		u32 chipid[2];
   137		const char *machine = NULL;
   138	
   139		np = of_find_compatible_node(NULL, NULL, "aspeed,silicon-id");
   140		if (!of_device_is_available(np)) {
   141			of_node_put(np);
   142			return -ENODEV;
   143		}
   144	
   145		reg = of_iomap(np, 0);
   146		if (!reg) {
   147			of_node_put(np);
   148			return -ENODEV;
   149		}
   150		siliconid = readl(reg);
   151		iounmap(reg);
   152	
   153		/* This is optional, the ast2400 does not have it */
   154		reg = of_iomap(np, 1);
   155		if (reg) {
   156			has_chipid = true;
   157			chipid[0] = readl(reg);
   158			chipid[1] = readl(reg + 4);
   159			iounmap(reg);
   160		}
   161		of_node_put(np);
   162	
   163		/* AST2600 only */
   164		np = of_find_compatible_node(NULL, NULL, "aspeed,ast2600-sbc");
   165		if (of_device_is_available(np)) {
 > 166			void *base = of_iomap(np, 0);
   167			if (!base) {
   168				of_node_put(np);
   169				return -ENODEV;
   170			}
 > 171			security_status = readl(base + SEC_STATUS);
   172			has_sbe = true;
 > 173			iounmap(base);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
