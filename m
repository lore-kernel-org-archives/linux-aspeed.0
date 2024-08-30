From: kernel test robot <lkp@intel.com>
Date: Fri, 30 Aug 2024 08:21:39 +0800
Subject: [PATCH v6 1/2] dt-bindings: media: convert aspeed-video.txt to
 dt-schema
In-Reply-To: <20240829064508.3706672-2-jammy_huang@aspeedtech.com>
References: <20240829064508.3706672-2-jammy_huang@aspeedtech.com>
Message-ID: <202408300813.2RN73Kn4-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jammy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 47ac09b91befbb6a235ab620c32af719f8208399]

url:    https://github.com/intel-lab-lkp/linux/commits/Jammy-Huang/dt-bindings-media-convert-aspeed-video-txt-to-dt-schema/20240829-144721
base:   47ac09b91befbb6a235ab620c32af719f8208399
patch link:    https://lore.kernel.org/r/20240829064508.3706672-2-jammy_huang%40aspeedtech.com
patch subject: [PATCH v6 1/2] dt-bindings: media: convert aspeed-video.txt to dt-schema
reproduce: (https://download.01.org/0day-ci/archive/20240830/202408300813.2RN73Kn4-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408300813.2RN73Kn4-lkp at intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/media/aspeed-video.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
