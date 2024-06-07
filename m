From: kernel test robot <lkp@intel.com>
Date: Fri, 7 Jun 2024 17:44:36 +0800
Subject: [PATCH] arm: dts: aspeed: Use standard 'i2c' bus node name
In-Reply-To: <20240531193115.3814887-1-robh@kernel.org>
References: <20240531193115.3814887-1-robh@kernel.org>
Message-ID: <202406071717.2B7aM49z-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on krzk/for-next linus/master v6.10-rc2 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Herring-Arm/arm-dts-aspeed-Use-standard-i2c-bus-node-name/20240601-033514
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240531193115.3814887-1-robh%40kernel.org
patch subject: [PATCH] arm: dts: aspeed: Use standard 'i2c' bus node name
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406071717.2B7aM49z-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406071717.2B7aM49z-lkp at intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts:541.10-555.4: Warning (avoid_unnecessary_addr_size): /ahb/apb/bus at 1e78a000/i2c at 480/gpio at 77: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

vim +541 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts

36d96827f480e9 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Quan Nguyen  2022-08-17  532  
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  533  &i2c8 {
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  534  	status = "okay";
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  535  
e998856086a41d arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts Chanh Nguyen 2023-10-05  536  	temperature-sensor at 48 {
e998856086a41d arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts Chanh Nguyen 2023-10-05  537  		compatible = "ti,tmp112";
e998856086a41d arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts Chanh Nguyen 2023-10-05  538  		reg = <0x48>;
e998856086a41d arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts Chanh Nguyen 2023-10-05  539  	};
e998856086a41d arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts Chanh Nguyen 2023-10-05  540  
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28 @541  	gpio at 77 {
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  542  		compatible = "nxp,pca9539";
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  543  		reg = <0x77>;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  544  		gpio-controller;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  545  		#address-cells = <1>;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  546  		#size-cells = <0>;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  547  		#gpio-cells = <2>;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  548  
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  549  		bmc-ocp0-en-hog {
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  550  			gpio-hog;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  551  			gpios = <7 GPIO_ACTIVE_LOW>;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  552  			output-high;
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  553  			line-name = "bmc-ocp0-en-n";
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  554  		};
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  555  	};
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  556  };
695cb117ac2a36 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts        Chanh Nguyen 2023-02-28  557  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
