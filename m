From: kernel test robot <lkp@intel.com>
Date: Mon, 16 Aug 2021 03:05:15 +0800
Subject: [PATCH 1/2] soc: aspeed: Add LPC mailbox support
In-Reply-To: <20210813054758.13189-2-chiawei_wang@aspeedtech.com>
References: <20210813054758.13189-2-chiawei_wang@aspeedtech.com>
Message-ID: <202108160221.59KN8jgQ-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Chia-Wei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on joel-aspeed/for-next]
[also build test WARNING on v5.14-rc5 next-20210813]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Chia-Wei-Wang/aspeed-Add-LPC-mailbox-support/20210813-134908
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git for-next
config: h8300-randconfig-s031-20210816 (attached as .config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-348-gf0e6938b-dirty
        # https://github.com/0day-ci/linux/commit/72c5a69dc779f5b4af59eb6d47d0e1086be814af
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chia-Wei-Wang/aspeed-Add-LPC-mailbox-support/20210813-134908
        git checkout 72c5a69dc779f5b4af59eb6d47d0e1086be814af
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=h8300 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/soc/aspeed/aspeed-lpc-mbox.c:240:27: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t ( *poll )( ... ) @@     got unsigned int ( * )( ... ) @@
   drivers/soc/aspeed/aspeed-lpc-mbox.c:240:27: sparse:     expected restricted __poll_t ( *poll )( ... )
   drivers/soc/aspeed/aspeed-lpc-mbox.c:240:27: sparse:     got unsigned int ( * )( ... )

vim +240 drivers/soc/aspeed/aspeed-lpc-mbox.c

   232	
   233	static const struct file_operations aspeed_mbox_fops = {
   234		.owner		= THIS_MODULE,
   235		.llseek		= no_seek_end_llseek,
   236		.read		= aspeed_mbox_read,
   237		.write		= aspeed_mbox_write,
   238		.open		= aspeed_mbox_open,
   239		.release	= aspeed_mbox_release,
 > 240		.poll		= aspeed_mbox_poll,
   241		.unlocked_ioctl	= aspeed_mbox_ioctl,
   242	};
   243	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 36610 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210816/c93871a5/attachment-0001.gz>
