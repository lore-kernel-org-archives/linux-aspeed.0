From: kernel test robot <lkp@intel.com>
Date: Wed, 17 Apr 2024 06:45:54 +0800
Subject: [PATCH 2/9] dt-bindings: rtc: google,goldfish-rtc: move to
 trivial-rtc
In-Reply-To: <20240408-rtc_dtschema-v1-2-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-2-c447542fc362@gmail.com>
Message-ID: <202404170656.LoL9eBYs-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Javier,

kernel test robot noticed the following build warnings:

[auto build test WARNING on fec50db7033ea478773b159e0e2efb135270e3b7]

url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/dt-bindings-rtc-orion-rtc-move-to-trivial-rtc/20240408-235612
base:   fec50db7033ea478773b159e0e2efb135270e3b7
patch link:    https://lore.kernel.org/r/20240408-rtc_dtschema-v1-2-c447542fc362%40gmail.com
patch subject: [PATCH 2/9] dt-bindings: rtc: google,goldfish-rtc: move to trivial-rtc
reproduce: (https://download.01.org/0day-ci/archive/20240417/202404170656.LoL9eBYs-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404170656.LoL9eBYs-lkp at intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/devicetree/bindings/sound/fsl-asoc-card.txt references a file that doesn't exist: Documentation/devicetree/bindings/sound/fsl,asrc.txt
   Warning: Documentation/gpu/amdgpu/display/display-contributing.rst references a file that doesn't exist: Documentation/GPU/amdgpu/display/mpo-overview.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
