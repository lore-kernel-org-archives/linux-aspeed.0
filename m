From: kernel test robot <lkp@intel.com>
Date: Fri, 19 Nov 2021 11:15:17 +0800
Subject: [PATCH v7] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <20211118160301.GA19542@gmail.com>
References: <20211118160301.GA19542@gmail.com>
Message-ID: <202111191127.YohreYbs-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Kumar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.16-rc1 next-20211118]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Kumar-Thangavel/Add-payload-to-be-32-bit-aligned-to-fix-dropped-packets/20211119-000541
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 42eb8fdac2fc5d62392dcfcf0253753e821a97b0
config: m68k-randconfig-r005-20211118 (attached as .config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f4e0a51f25ba398ad7f2e3efa5076b2e0ad24e3b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kumar-Thangavel/Add-payload-to-be-32-bit-aligned-to-fix-dropped-packets/20211119-000541
        git checkout f4e0a51f25ba398ad7f2e3efa5076b2e0ad24e3b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/ncsi/ncsi-cmd.c:21:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
      21 | const static int padding_bytes = 26;
         | ^~~~~


vim +/static +21 net/ncsi/ncsi-cmd.c

    20	
  > 21	const static int padding_bytes = 26;
    22	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28516 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211119/1480de93/attachment-0001.gz>
