From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 23 May 2024 14:07:32 -0500
Subject: [PATCH v6 17/20] ARM: dts: aspeed: Add IBM Huygens BMC system
In-Reply-To: <202405232008.olE9azVd-lkp@intel.com>
References: <20240522192524.3286237-18-eajames@linux.ibm.com>
 <202405232008.olE9azVd-lkp@intel.com>
Message-ID: <36030de9-0b05-4ab8-a603-510602d0fdf8@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 5/23/24 07:48, kernel test robot wrote:
> Hi Eddie,
>
> kernel test robot noticed the following build errors:


Silly mistake. If this patch can be dropped from the series, I can send 
an updated Huygens DTS after this series is merged, unless I need to do 
a v7.


Thanks,

Eddie


>
> [auto build test ERROR on andi-shyti/i2c/i2c-host]
> [also build test ERROR on linus/master v6.9 next-20240523]
> [cannot apply to robh/for-next broonie-spi/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Eddie-James/spi-dt-bindings-Document-the-IBM-FSI-attached-SPI-controller/20240523-033334
> base:   git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
> patch link:    https://lore.kernel.org/r/20240522192524.3286237-18-eajames%40linux.ibm.com
> patch subject: [PATCH v6 17/20] ARM: dts: aspeed: Add IBM Huygens BMC system
> config: arm-randconfig-001-20240523 (https://download.01.org/0day-ci/archive/20240523/202405232008.olE9azVd-lkp at intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405232008.olE9azVd-lkp at intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405232008.olE9azVd-lkp at intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> Error: arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-huygens.dts:13.2-37 Properties must precede subnodes
>     FATAL ERROR: Unable to parse input tree
>
