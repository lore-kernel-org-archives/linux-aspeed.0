From: kernel test robot <lkp@intel.com>
Date: Mon, 19 Aug 2024 23:28:04 +0800
Subject: [PATCH v13 2/3] i2c: aspeed: support AST2600 i2c new register
 mode driver
In-Reply-To: <20240819092850.1590758-3-ryan_chen@aspeedtech.com>
References: <20240819092850.1590758-3-ryan_chen@aspeedtech.com>
Message-ID: <202408192327.nZeNynmO-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on andi-shyti/i2c/i2c-host]
[also build test ERROR on linus/master v6.11-rc4 next-20240819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-i2c-aspeed-support-for-AST2600-i2cv2/20240819-173106
base:   https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
patch link:    https://lore.kernel.org/r/20240819092850.1590758-3-ryan_chen%40aspeedtech.com
patch subject: [PATCH v13 2/3] i2c: aspeed: support AST2600 i2c new register mode driver
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240819/202408192327.nZeNynmO-lkp at intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408192327.nZeNynmO-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408192327.nZeNynmO-lkp at intel.com/

All errors (new ones prefixed by >>):

   drivers/i2c/busses/i2c-ast2600.c: In function 'ast2600_i2c_setup_buff_tx':
>> drivers/i2c/busses/i2c-ast2600.c:442:46: error: implicit declaration of function 'get_unaligned_le32' [-Wimplicit-function-declaration]
     442 |                                 wbuf_dword = get_unaligned_le32(wbuf);
         |                                              ^~~~~~~~~~~~~~~~~~


vim +/get_unaligned_le32 +442 drivers/i2c/busses/i2c-ast2600.c

   411	
   412	static int ast2600_i2c_setup_buff_tx(u32 cmd, struct ast2600_i2c_bus *i2c_bus)
   413	{
   414		struct i2c_msg *msg = &i2c_bus->msgs[i2c_bus->msgs_index];
   415		u32 wbuf_dword;
   416		int xfer_len;
   417		u8 wbuf[4];
   418		int i;
   419	
   420		cmd |= AST2600_I2CM_PKT_EN;
   421		xfer_len = msg->len - i2c_bus->master_xfer_cnt;
   422		if (xfer_len > i2c_bus->buf_size) {
   423			xfer_len = i2c_bus->buf_size;
   424		} else {
   425			if (i2c_bus->msgs_index + 1 == i2c_bus->msgs_count)
   426				cmd |= AST2600_I2CM_STOP_CMD;
   427		}
   428	
   429		if (cmd & AST2600_I2CM_START_CMD)
   430			cmd |= AST2600_I2CM_PKT_ADDR(msg->addr);
   431	
   432		if (xfer_len) {
   433			cmd |= AST2600_I2CM_TX_BUFF_EN | AST2600_I2CM_TX_CMD;
   434			/*
   435			 * The controller's buffer register supports dword writes only.
   436			 * Therefore, write dwords to the buffer register in a 4-byte aligned,
   437			 * and write the remaining unaligned data at the end.
   438			 */
   439			for (i = 0; i < xfer_len; i++) {
   440				wbuf[i % 4] = msg->buf[i2c_bus->master_xfer_cnt + i];
   441				if ((i % 4) == 3 || i == xfer_len - 1) {
 > 442					wbuf_dword = get_unaligned_le32(wbuf);
   443					writel(wbuf_dword, i2c_bus->buf_base + i - (i % 4));
   444				}
   445			}
   446	
   447			writel(AST2600_I2CC_SET_TX_BUF_LEN(xfer_len),
   448			       i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
   449		}
   450	
   451		writel(cmd, i2c_bus->reg_base + AST2600_I2CM_CMD_STS);
   452	
   453		return 0;
   454	}
   455	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
