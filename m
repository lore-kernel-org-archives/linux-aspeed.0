From: kernel test robot <lkp@intel.com>
Date: Tue, 30 Mar 2021 08:23:10 +0800
Subject: [PATCH 11/22] ARM: dts: aspeed: rainier 4U: Fix fan configuration
In-Reply-To: <20210329150020.13632-12-eajames@linux.ibm.com>
References: <20210329150020.13632-12-eajames@linux.ibm.com>
Message-ID: <202103300844.JoddBvER-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie,

I love your patch! Yet something to improve:

[auto build test ERROR on soc/for-next]
[also build test ERROR on v5.12-rc5 next-20210329]
[cannot apply to joel-aspeed/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Eddie-James/ARM-dts-aspeed-Updates-for-Rainier-and-Everest-machines/20210329-230220
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm-defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/9c182646738dfcf45429b03a326f2b1bcef985ef
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Eddie-James/ARM-dts-aspeed-Updates-for-Rainier-and-Everest-machines/20210329-230220
        git checkout 9c182646738dfcf45429b03a326f2b1bcef985ef
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts:43.1-6 Label or path fan4 not found
>> Error: arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts:48.1-6 Label or path fan5 not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 54352 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210330/85ee958d/attachment-0001.gz>
