From: kernel test robot <lkp@intel.com>
Date: Wed, 21 Sep 2022 17:48:40 +0800
Subject: [PATCH v9 3/4] media: aspeed: Support aspeed mode to reduce
 compressed data
In-Reply-To: <20220921025112.13150-4-jammy_huang@aspeedtech.com>
References: <20220921025112.13150-4-jammy_huang@aspeedtech.com>
Message-ID: <202209211741.XHu8zd6f-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jammy,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on next-20220920]
[cannot apply to linus/master v6.0-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jammy-Huang/add-aspeed-jpeg-support-for-aspeed-video/20220921-105350
base:   git://linuxtv.org/media_tree.git master
config: arm-multi_v5_defconfig (https://download.01.org/0day-ci/archive/20220921/202209211741.XHu8zd6f-lkp at intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/99c2bf6f1dccc310cb9b2d9916292766f00ffb4f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jammy-Huang/add-aspeed-jpeg-support-for-aspeed-video/20220921-105350
        git checkout 99c2bf6f1dccc310cb9b2d9916292766f00ffb4f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/media/platform/aspeed/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/aspeed/aspeed-video.c:487:27: warning: unused variable 'compress_scheme_str' [-Wunused-const-variable]
   static const char * const compress_scheme_str[] = {"DCT Only",
                             ^
   In file included from drivers/media/platform/aspeed/aspeed-video.c:24:
   In file included from include/linux/videodev2.h:61:
   include/uapi/linux/videodev2.h:1776:2: warning: field  within 'struct v4l2_ext_control' is less aligned than 'union v4l2_ext_control::(anonymous at include/uapi/linux/videodev2.h:1776:2)' and is usually due to 'struct v4l2_ext_control' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           union {
           ^
   2 warnings generated.


vim +/compress_scheme_str +487 drivers/media/platform/aspeed/aspeed-video.c

   486	
 > 487	static const char * const compress_scheme_str[] = {"DCT Only",
   488		"DCT VQ mix 2-color", "DCT VQ mix 4-color"};
   489	static const char * const format_str[] = {"Standard JPEG",
   490		"Aspeed JPEG"};
   491	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
