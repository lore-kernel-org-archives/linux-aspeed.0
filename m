From: kbuild test robot <lkp@intel.com>
Date: Sun, 16 Dec 2018 16:13:05 +0800
Subject: [PATCH] ARM: dts: aspeed: Add KCS support for LPC BMC
In-Reply-To: <20181210200753.3018124-2-vijaykhemka@fb.com>
References: <20181210200753.3018124-2-vijaykhemka@fb.com>
Message-ID: <201812161620.RyKCAcib%fengguang.wu@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vijay,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on joel-aspeed/for-next]
[also build test ERROR on v4.20-rc6 next-20181214]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Vijay-Khemka/ARM-dts-aspeed-Add-KCS-support-for-LPC-BMC/20181211-074230
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git for-next
config: arm-multi_v5_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed-g5.dtsi:333.45-46 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30313 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20181216/5f615423/attachment-0001.gz>
