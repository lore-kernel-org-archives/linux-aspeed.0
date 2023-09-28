From: kernel test robot <lkp@intel.com>
Date: Fri, 29 Sep 2023 06:58:15 +0800
Subject: [PATCH 3/3] mctp: Add MCTP-over-KCS transport binding
In-Reply-To: <20230928123009.2913-4-aladyshev22@gmail.com>
References: <20230928123009.2913-4-aladyshev22@gmail.com>
Message-ID: <202309290613.qxRTI9f7-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Konstantin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cminyard-ipmi/for-next]
[also build test WARNING on linus/master v6.6-rc3 next-20230928]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Konstantin-Aladyshev/ipmi-Move-KCS-headers-to-common-include-folder/20230928-203248
base:   https://github.com/cminyard/linux-ipmi for-next
patch link:    https://lore.kernel.org/r/20230928123009.2913-4-aladyshev22%40gmail.com
patch subject: [PATCH 3/3] mctp: Add MCTP-over-KCS transport binding
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230929/202309290613.qxRTI9f7-lkp at intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309290613.qxRTI9f7-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309290613.qxRTI9f7-lkp at intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:8,
                    from include/linux/skbuff.h:28,
                    from include/linux/if_arp.h:22,
                    from drivers/net/mctp/mctp-kcs.c:16:
   drivers/net/mctp/mctp-kcs.c: In function 'mctp_kcs_validate_data':
>> drivers/net/mctp/mctp-kcs.c:121:25: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'long unsigned int' [-Wformat=]
     121 |                         "%s: KCS binding header error! len = 0x%02x, but should be 0x%02x",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/net/mctp/mctp-kcs.c:120:17: note: in expansion of macro 'dev_err'
     120 |                 dev_err(mkcs->client.dev->dev,
         |                 ^~~~~~~
   drivers/net/mctp/mctp-kcs.c:121:89: note: format string is defined here
     121 |                         "%s: KCS binding header error! len = 0x%02x, but should be 0x%02x",
         |                                                                                      ~~~^
         |                                                                                         |
         |                                                                                         unsigned int
         |                                                                                      %02lx


vim +121 drivers/net/mctp/mctp-kcs.c

    95	
    96	static int mctp_kcs_validate_data(struct mctp_kcs *mkcs,
    97					  struct mctp_kcs_header *hdr, int len)
    98	{
    99		struct net_device *ndev = mkcs->netdev;
   100		struct mctp_kcs_trailer *tlr;
   101		u8 pec;
   102	
   103		if (hdr->netfn_lun != MCTP_KCS_NETFN_LUN) {
   104			dev_err(mkcs->client.dev->dev,
   105				"%s: KCS binding header error! netfn_lun = 0x%02x, but should be 0x%02x",
   106				__func__, hdr->netfn_lun, MCTP_KCS_NETFN_LUN);
   107			ndev->stats.rx_dropped++;
   108			return -EINVAL;
   109		}
   110		if (hdr->defining_body != DEFINING_BODY_DMTF_PRE_OS_WORKING_GROUP) {
   111			dev_err(mkcs->client.dev->dev,
   112				"%s: KCS binding header error! defining_body = 0x%02x, but should be 0x%02x",
   113				__func__, hdr->defining_body,
   114				DEFINING_BODY_DMTF_PRE_OS_WORKING_GROUP);
   115			ndev->stats.rx_dropped++;
   116			return -EINVAL;
   117		}
   118		if (hdr->len != (len - sizeof(struct mctp_kcs_header) -
   119				 sizeof(struct mctp_kcs_trailer))) {
   120			dev_err(mkcs->client.dev->dev,
 > 121				"%s: KCS binding header error! len = 0x%02x, but should be 0x%02x",
   122				__func__, hdr->len,
   123				(len - sizeof(struct mctp_kcs_header) -
   124				 sizeof(struct mctp_kcs_trailer)));
   125			ndev->stats.rx_length_errors++;
   126			return -EINVAL;
   127		}
   128	
   129		pec = generate_pec((u8 *)(hdr + 1), hdr->len);
   130		tlr = (struct mctp_kcs_trailer *)((u8 *)(hdr + 1) + hdr->len);
   131		if (pec != tlr->pec) {
   132			dev_err(mkcs->client.dev->dev,
   133				"%s: PEC error! Packet value=0x%02x, calculated value=0x%02x",
   134				__func__, tlr->pec, pec);
   135			ndev->stats.rx_crc_errors++;
   136			return -EINVAL;
   137		}
   138		return 0;
   139	}
   140	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
