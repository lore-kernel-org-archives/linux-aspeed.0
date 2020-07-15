From: kernel test robot <lkp@intel.com>
Date: Thu, 16 Jul 2020 06:50:24 +0800
Subject: [PATCH 1/2] gpio/aspeed-sgpio: enable access to all 80 input &
 output sgpios
In-Reply-To: <20200715135418.3194860-1-jk@codeconstruct.com.au>
References: <20200715135418.3194860-1-jk@codeconstruct.com.au>
Message-ID: <202007160604.Mvm5tO0Y%lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jeremy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on gpio/for-next]
[also build test WARNING on joel-aspeed/for-next v5.8-rc5 next-20200715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeremy-Kerr/gpio-aspeed-sgpio-enable-access-to-all-80-input-output-sgpios/20200715-221503
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next
config: x86_64-allyesconfig (attached as .config)
compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 02946de3802d3bc65bc9f2eb9b8d4969b5a7add8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpio-aspeed-sgpio.c:162:8: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
   static const bool aspeed_sgpio_is_input(unsigned int offset)
          ^~~~~~
   1 warning generated.

vim +/const +162 drivers/gpio/gpio-aspeed-sgpio.c

   161	
 > 162	static const bool aspeed_sgpio_is_input(unsigned int offset)
   163	{
   164		return offset < SGPIO_OUTPUT_OFFSET;
   165	}
   166	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 75338 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200716/3722f2e0/attachment-0001.gz>
