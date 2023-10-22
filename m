From: kernel test robot <lkp@intel.com>
Date: Sun, 22 Oct 2023 08:16:25 +0800
Subject: [PATCH v5 1/3] ipmi: Move KCS headers to common include folder
In-Reply-To: <20231010122321.823-2-aladyshev22@gmail.com>
References: <20231010122321.823-2-aladyshev22@gmail.com>
Message-ID: <202310220806.BmOW2atE-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Konstantin,

kernel test robot noticed the following build errors:

[auto build test ERROR on cminyard-ipmi/for-next]
[also build test ERROR on linus/master v6.6-rc6 next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Konstantin-Aladyshev/ipmi-Move-KCS-headers-to-common-include-folder/20231010-202425
base:   https://github.com/cminyard/linux-ipmi for-next
patch link:    https://lore.kernel.org/r/20231010122321.823-2-aladyshev22%40gmail.com
patch subject: [PATCH v5 1/3] ipmi: Move KCS headers to common include folder
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20231022/202310220806.BmOW2atE-lkp at intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231022/202310220806.BmOW2atE-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310220806.BmOW2atE-lkp at intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kcs_bmc_client.h:8,
                    from drivers/char/ipmi/kcs_bmc_cdev_ipmi.c:11:
>> include/linux/kcs_bmc.h:42:9: error: unknown type name 'spinlock_t'
      42 |         spinlock_t lock;
         |         ^~~~~~~~~~


vim +/spinlock_t +42 include/linux/kcs_bmc.h

faae6e391eda73 drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08  31  
d4e7ac68f771ad drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08  32  struct kcs_bmc_device {
d4e7ac68f771ad drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08  33  	struct list_head entry;
20d60f61c58e8c drivers/char/ipmi/kcs_bmc.h Haiyue Wang    2018-02-02  34  
d4e7ac68f771ad drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08  35  	struct device *dev;
20d60f61c58e8c drivers/char/ipmi/kcs_bmc.h Haiyue Wang    2018-02-02  36  	u32 channel;
20d60f61c58e8c drivers/char/ipmi/kcs_bmc.h Haiyue Wang    2018-02-02  37  
20d60f61c58e8c drivers/char/ipmi/kcs_bmc.h Haiyue Wang    2018-02-02  38  	struct kcs_ioreg ioreg;
20d60f61c58e8c drivers/char/ipmi/kcs_bmc.h Haiyue Wang    2018-02-02  39  
d4e7ac68f771ad drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08  40  	const struct kcs_bmc_device_ops *ops;
20d60f61c58e8c drivers/char/ipmi/kcs_bmc.h Haiyue Wang    2018-02-02  41  
d4e7ac68f771ad drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08 @42  	spinlock_t lock;
d4e7ac68f771ad drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08  43  	struct kcs_bmc_client *client;
20d60f61c58e8c drivers/char/ipmi/kcs_bmc.h Haiyue Wang    2018-02-02  44  };
d4e7ac68f771ad drivers/char/ipmi/kcs_bmc.h Andrew Jeffery 2021-06-08  45  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
