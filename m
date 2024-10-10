From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 10 Oct 2024 16:40:15 +0300
Subject: [PATCH v14 2/3] i2c: aspeed: support AST2600 i2c new register
 mode driver
In-Reply-To: <202410051547.vOL3qMOc-lkp@intel.com>
References: <20241002070213.1165263-3-ryan_chen@aspeedtech.com>
 <202410051547.vOL3qMOc-lkp@intel.com>
Message-ID: <ZwfZP0LeqKobdbgK@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Oct 05, 2024 at 03:36:16PM +0800, kernel test robot wrote:
> Hi Ryan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on v6.11]
> [cannot apply to andi-shyti/i2c/i2c-host v6.12-rc1 linus/master next-20241004]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-i2c-aspeed-support-for-AST2600-i2cv2/20241002-150410
> base:   v6.11
> patch link:    https://lore.kernel.org/r/20241002070213.1165263-3-ryan_chen%40aspeedtech.com
> patch subject: [PATCH v14 2/3] i2c: aspeed: support AST2600 i2c new register mode driver
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241005/202410051547.vOL3qMOc-lkp at intel.com/config)
> compiler: sh4-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410051547.vOL3qMOc-lkp at intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410051547.vOL3qMOc-lkp at intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/i2c/busses/i2c-ast2600.c: In function 'ast2600_i2c_setup_buff_tx':
> >> drivers/i2c/busses/i2c-ast2600.c:437:41: error: implicit declaration of function 'get_unaligned_le16'; did you mean 'get_unalign_ctl'? [-Wimplicit-function-declaration]
>      437 |                                         get_unaligned_le16(&msg->buf[i2c_bus->master_xfer_cnt + i]);
>          |                                         ^~~~~~~~~~~~~~~~~~
>          |                                         get_unalign_ctl
> >> drivers/i2c/busses/i2c-ast2600.c:441:41: error: implicit declaration of function 'get_unaligned_le24'; did you mean 'get_unalign_ctl'? [-Wimplicit-function-declaration]
>      441 |                                         get_unaligned_le24(&msg->buf[i2c_bus->master_xfer_cnt + i]);
>          |                                         ^~~~~~~~~~~~~~~~~~
>          |                                         get_unalign_ctl
> >> drivers/i2c/busses/i2c-ast2600.c:445:41: error: implicit declaration of function 'get_unaligned_le32'; did you mean 'get_unalign_ctl'? [-Wimplicit-function-declaration]
>      445 |                                         get_unaligned_le32(&msg->buf[i2c_bus->master_xfer_cnt + i]);
>          |                                         ^~~~~~~~~~~~~~~~~~
>          |                                         get_unalign_ctl

You need to add

#include <asm/unaligned.h>

_after_ other #include <linux/*.h> in the code.

-- 
With Best Regards,
Andy Shevchenko


