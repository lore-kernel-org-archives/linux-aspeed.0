From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 5 Nov 2021 18:59:11 +0100
Subject: [PATCH 2/2] drm: Remove CONFIG_DRM_KMS_CMA_HELPER option
In-Reply-To: <202111012344.tYv3YxkG-lkp@intel.com>
References: <20211101081751.24613-3-tzimmermann@suse.de>
 <202111012344.tYv3YxkG-lkp@intel.com>
Message-ID: <YYVw70934dYhyGVZ@phenom.ffwll.local>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 01, 2021 at 11:59:15PM +0800, kernel test robot wrote:
> Hi Thomas,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on next-20211029]
> [cannot apply to drm/drm-next shawnguo/for-next pinchartl-media/drm/du/next v5.15 v5.15-rc7 v5.15-rc6 v5.15]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Thomas-Zimmermann/drm-Small-CMA-cleanups/20211101-161911
> base:    bdcc9f6a568275aed4cc32fd2312432d2ff1b704
> config: x86_64-randconfig-a004-20211101 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 82ed106567063ea269c6d5669278b733e173a42f)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/c3c7ec5f9ccd90e78f0f2d3143505db4060bbf17
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Thomas-Zimmermann/drm-Small-CMA-cleanups/20211101-161911
>         git checkout c3c7ec5f9ccd90e78f0f2d3143505db4060bbf17
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: module drm_cma_helper uses symbol dma_buf_vmap from namespace DMA_BUF, but does not import it.
> >> ERROR: modpost: module drm_cma_helper uses symbol dma_buf_vunmap from namespace DMA_BUF, but does not import it.

I guess this is simply because kbuild tests on top of linux-next, where
the namespacing is a bit funny. We might need a fixup when we backmerge.

Either way this looks like a good simplification to me, on the series:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
