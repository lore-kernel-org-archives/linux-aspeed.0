From: kbuild test robot <lkp@intel.com>
Date: Mon, 25 May 2020 04:11:30 +0800
Subject: [PATCH 21/21] drm/zte: Use GEM CMA object functions
In-Reply-To: <20200522135246.10134-22-tzimmermann@suse.de>
References: <20200522135246.10134-22-tzimmermann@suse.de>
Message-ID: <202005250411.9jaBgbT9%lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Thomas,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20200519]
[cannot apply to sunxi/sunxi/for-next joel-aspeed/for-next shawnguo/for-next stm32/stm32-next linus/master pinchartl-media/drm/du/next v5.7-rc6 v5.7-rc5 v5.7-rc4 v5.7-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Thomas-Zimmermann/drm-Convert-most-CMA-based-drivers-to-GEM-object-functions/20200522-215754
base:    fb57b1fabcb28f358901b2df90abd2b48abc1ca8
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> drivers/gpu/drm/zte/zx_drm_drv.c:39:2: error: 'DRM_GEM_CMA_VMAP_DRIVER_OPS' undeclared here (not in a function); did you mean 'DRM_GEM_CMA_DRIVER_OPS'?
39 |  DRM_GEM_CMA_VMAP_DRIVER_OPS,
|  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
|  DRM_GEM_CMA_DRIVER_OPS

vim +39 drivers/gpu/drm/zte/zx_drm_drv.c

    36	
    37	static struct drm_driver zx_drm_driver = {
    38		.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
  > 39		DRM_GEM_CMA_VMAP_DRIVER_OPS,
    40		.fops = &zx_drm_fops,
    41		.name = "zx-vou",
    42		.desc = "ZTE VOU Controller DRM",
    43		.date = "20160811",
    44		.major = 1,
    45		.minor = 0,
    46	};
    47	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 74772 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200525/e8300bee/attachment-0001.gz>
