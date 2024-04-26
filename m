From: kernel test robot <lkp@intel.com>
Date: Fri, 26 Apr 2024 08:21:53 +0800
Subject: [PATCH v3 10/14] dt-bindings: i2c: i2c-fsi: Switch to yaml format
In-Reply-To: <20240425213701.655540-11-eajames@linux.ibm.com>
References: <20240425213701.655540-11-eajames@linux.ibm.com>
Message-ID: <202404260842.hNo9YEmT-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240424]
[also build test WARNING on linus/master v6.9-rc5]
[cannot apply to robh/for-next broonie-spi/for-next andi-shyti/i2c/i2c-host v6.9-rc5 v6.9-rc4 v6.9-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eddie-James/dt-bindings-spi-Document-the-IBM-Power-SPI-controller/20240426-054336
base:   next-20240424
patch link:    https://lore.kernel.org/r/20240425213701.655540-11-eajames%40linux.ibm.com
patch subject: [PATCH v3 10/14] dt-bindings: i2c: i2c-fsi: Switch to yaml format
reproduce: (https://download.01.org/0day-ci/archive/20240426/202404260842.hNo9YEmT-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404260842.hNo9YEmT-lkp at intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/i2c/i2c-fsi.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
