From: kernel test robot <lkp@intel.com>
Date: Thu, 13 Jan 2022 15:54:26 +0800
Subject: [PATCH v5 08/13] peci: Add support for PECI device drivers
In-Reply-To: <20220112230247.982212-9-iwona.winiarska@intel.com>
References: <20220112230247.982212-9-iwona.winiarska@intel.com>
Message-ID: <202201131534.HcDrC30f-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Iwona,

I love your patch! Perhaps something to improve:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linux/master linus/master v5.16 next-20220112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Iwona-Winiarska/Introduce-PECI-subsystem/20220113-071131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: hexagon-randconfig-r033-20220113 (https://download.01.org/0day-ci/archive/20220113/202201131534.HcDrC30f-lkp at intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/0c9888d465568adc8526df1407c9a75be5ce6cd4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Iwona-Winiarska/Introduce-PECI-subsystem/20220113-071131
        git checkout 0c9888d465568adc8526df1407c9a75be5ce6cd4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/peci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/peci/request.c:111:23: warning: address of array 'req->rx.buf' will always evaluate to 'true' [-Wpointer-bool-conversion]
           if (WARN_ON(!req->rx.buf))
                       ~~~~~~~~~^~~
   include/asm-generic/bug.h:121:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   1 warning generated.


vim +111 drivers/peci/request.c

   101	
   102	static int peci_request_xfer_retry(struct peci_request *req)
   103	{
   104		long wait_interval = PECI_RETRY_INTERVAL_MIN;
   105		struct peci_device *device = req->device;
   106		struct peci_controller *controller = to_peci_controller(device->dev.parent);
   107		unsigned long start = jiffies;
   108		int ret;
   109	
   110		/* Don't try to use it for ping */
 > 111		if (WARN_ON(!req->rx.buf))
   112			return 0;
   113	
   114		do {
   115			ret = peci_request_xfer(req);
   116			if (ret) {
   117				dev_dbg(&controller->dev, "xfer error: %d\n", ret);
   118				return ret;
   119			}
   120	
   121			if (peci_request_status(req) != -EAGAIN)
   122				return 0;
   123	
   124			/* Set the retry bit to indicate a retry attempt */
   125			req->tx.buf[1] |= PECI_RETRY_BIT;
   126	
   127			if (schedule_timeout_interruptible(wait_interval))
   128				return -ERESTARTSYS;
   129	
   130			wait_interval = min_t(long, wait_interval * 2, PECI_RETRY_INTERVAL_MAX);
   131		} while (time_before(jiffies, start + PECI_RETRY_TIMEOUT));
   132	
   133		dev_dbg(&controller->dev, "request timed out\n");
   134	
   135		return -ETIMEDOUT;
   136	}
   137	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
