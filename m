From: kernel test robot <lkp@intel.com>
Date: Sat, 18 May 2024 09:03:53 +0800
Subject: [PATCH v3 37/40] fsi: core: Add different types of CFAM
In-Reply-To: <20240516181907.3468796-38-eajames@linux.ibm.com>
References: <20240516181907.3468796-38-eajames@linux.ibm.com>
Message-ID: <202405180824.hYqwNWNv-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on andi-shyti/i2c/i2c-host]
[also build test WARNING on robh/for-next broonie-spi/for-next linus/master v6.9 next-20240517]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eddie-James/fsi-hub-Set-master-index-to-link-number-plus-one/20240517-023205
base:   git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
patch link:    https://lore.kernel.org/r/20240516181907.3468796-38-eajames%40linux.ibm.com
patch subject: [PATCH v3 37/40] fsi: core: Add different types of CFAM
config: nios2-randconfig-r071-20240517 (https://download.01.org/0day-ci/archive/20240518/202405180824.hYqwNWNv-lkp at intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240518/202405180824.hYqwNWNv-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405180824.hYqwNWNv-lkp at intel.com/

All warnings (new ones prefixed by >>):

>> drivers/fsi/fsi-core.c:1113:27: warning: no previous prototype for 'fsi_get_cfam_type' [-Wmissing-prototypes]
    1113 | const struct device_type *fsi_get_cfam_type(u32 id)
         |                           ^~~~~~~~~~~~~~~~~


vim +/fsi_get_cfam_type +1113 drivers/fsi/fsi-core.c

  1112	
> 1113	const struct device_type *fsi_get_cfam_type(u32 id)
  1114	{
  1115		u32 major = (id & 0xf00) >> 8;
  1116		u32 minor = (id & 0xf0) >> 4;
  1117	
  1118		switch (major) {
  1119		case 0x9:
  1120			return &cfam_s_type;
  1121		case 0xc:
  1122			if (minor == 0)
  1123				return &cfam_ody_type;
  1124			fallthrough;
  1125		case 0xd:
  1126		default:
  1127			return &cfam_type;
  1128		}
  1129	}
  1130	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
