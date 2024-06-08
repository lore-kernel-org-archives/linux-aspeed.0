From: kernel test robot <lkp@intel.com>
Date: Sun, 9 Jun 2024 00:19:03 +0800
Subject: [PATCH v2] i2c: aspeed: Update the stop sw state when the bus
 recovery occurs
In-Reply-To: <20240608043653.4086647-1-tommy_huang@aspeedtech.com>
References: <20240608043653.4086647-1-tommy_huang@aspeedtech.com>
Message-ID: <202406090041.5IMjYB8x-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Tommy,

kernel test robot noticed the following build errors:

[auto build test ERROR on andi-shyti/i2c/i2c-host]
[also build test ERROR on linus/master v6.10-rc2 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tommy-Huang/i2c-aspeed-Update-the-stop-sw-state-when-the-bus-recovery-occurs/20240608-124429
base:   git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
patch link:    https://lore.kernel.org/r/20240608043653.4086647-1-tommy_huang%40aspeedtech.com
patch subject: [PATCH v2] i2c: aspeed: Update the stop sw state when the bus recovery occurs
config: arm-aspeed_g5_defconfig (https://download.01.org/0day-ci/archive/20240609/202406090041.5IMjYB8x-lkp at intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240609/202406090041.5IMjYB8x-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406090041.5IMjYB8x-lkp at intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-aspeed.c:28:39: warning: 'struct aspeed_i2c_bus' declared inside parameter list will not be visible outside of this definition or declaration
      28 | static void aspeed_i2c_do_stop(struct aspeed_i2c_bus *bus);
         |                                       ^~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-aspeed.c: In function 'aspeed_i2c_recover_bus':
>> drivers/i2c/busses/i2c-aspeed.c:192:36: error: passing argument 1 of 'aspeed_i2c_do_stop' from incompatible pointer type [-Werror=incompatible-pointer-types]
     192 |                 aspeed_i2c_do_stop(bus);
         |                                    ^~~
         |                                    |
         |                                    struct aspeed_i2c_bus *
   drivers/i2c/busses/i2c-aspeed.c:28:55: note: expected 'struct aspeed_i2c_bus *' but argument is of type 'struct aspeed_i2c_bus *'
      28 | static void aspeed_i2c_do_stop(struct aspeed_i2c_bus *bus);
         |                                ~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/i2c/busses/i2c-aspeed.c: At top level:
>> drivers/i2c/busses/i2c-aspeed.c:396:13: error: conflicting types for 'aspeed_i2c_do_stop'; have 'void(struct aspeed_i2c_bus *)'
     396 | static void aspeed_i2c_do_stop(struct aspeed_i2c_bus *bus)
         |             ^~~~~~~~~~~~~~~~~~
   drivers/i2c/busses/i2c-aspeed.c:28:13: note: previous declaration of 'aspeed_i2c_do_stop' with type 'void(struct aspeed_i2c_bus *)'
      28 | static void aspeed_i2c_do_stop(struct aspeed_i2c_bus *bus);
         |             ^~~~~~~~~~~~~~~~~~
>> drivers/i2c/busses/i2c-aspeed.c:28:13: warning: 'aspeed_i2c_do_stop' used but never defined
   cc1: some warnings being treated as errors


vim +/aspeed_i2c_do_stop +192 drivers/i2c/busses/i2c-aspeed.c

    27	
  > 28	static void aspeed_i2c_do_stop(struct aspeed_i2c_bus *bus);
    29	
    30	/* I2C Register */
    31	#define ASPEED_I2C_FUN_CTRL_REG				0x00
    32	#define ASPEED_I2C_AC_TIMING_REG1			0x04
    33	#define ASPEED_I2C_AC_TIMING_REG2			0x08
    34	#define ASPEED_I2C_INTR_CTRL_REG			0x0c
    35	#define ASPEED_I2C_INTR_STS_REG				0x10
    36	#define ASPEED_I2C_CMD_REG				0x14
    37	#define ASPEED_I2C_DEV_ADDR_REG				0x18
    38	#define ASPEED_I2C_BYTE_BUF_REG				0x20
    39	
    40	/* Global Register Definition */
    41	/* 0x00 : I2C Interrupt Status Register  */
    42	/* 0x08 : I2C Interrupt Target Assignment  */
    43	
    44	/* Device Register Definition */
    45	/* 0x00 : I2CD Function Control Register  */
    46	#define ASPEED_I2CD_MULTI_MASTER_DIS			BIT(15)
    47	#define ASPEED_I2CD_SDA_DRIVE_1T_EN			BIT(8)
    48	#define ASPEED_I2CD_M_SDA_DRIVE_1T_EN			BIT(7)
    49	#define ASPEED_I2CD_M_HIGH_SPEED_EN			BIT(6)
    50	#define ASPEED_I2CD_SLAVE_EN				BIT(1)
    51	#define ASPEED_I2CD_MASTER_EN				BIT(0)
    52	
    53	/* 0x04 : I2CD Clock and AC Timing Control Register #1 */
    54	#define ASPEED_I2CD_TIME_TBUF_MASK			GENMASK(31, 28)
    55	#define ASPEED_I2CD_TIME_THDSTA_MASK			GENMASK(27, 24)
    56	#define ASPEED_I2CD_TIME_TACST_MASK			GENMASK(23, 20)
    57	#define ASPEED_I2CD_TIME_SCL_HIGH_SHIFT			16
    58	#define ASPEED_I2CD_TIME_SCL_HIGH_MASK			GENMASK(19, 16)
    59	#define ASPEED_I2CD_TIME_SCL_LOW_SHIFT			12
    60	#define ASPEED_I2CD_TIME_SCL_LOW_MASK			GENMASK(15, 12)
    61	#define ASPEED_I2CD_TIME_BASE_DIVISOR_MASK		GENMASK(3, 0)
    62	#define ASPEED_I2CD_TIME_SCL_REG_MAX			GENMASK(3, 0)
    63	/* 0x08 : I2CD Clock and AC Timing Control Register #2 */
    64	#define ASPEED_NO_TIMEOUT_CTRL				0
    65	
    66	/* 0x0c : I2CD Interrupt Control Register &
    67	 * 0x10 : I2CD Interrupt Status Register
    68	 *
    69	 * These share bit definitions, so use the same values for the enable &
    70	 * status bits.
    71	 */
    72	#define ASPEED_I2CD_INTR_RECV_MASK			0xf000ffff
    73	#define ASPEED_I2CD_INTR_SDA_DL_TIMEOUT			BIT(14)
    74	#define ASPEED_I2CD_INTR_BUS_RECOVER_DONE		BIT(13)
    75	#define ASPEED_I2CD_INTR_SLAVE_MATCH			BIT(7)
    76	#define ASPEED_I2CD_INTR_SCL_TIMEOUT			BIT(6)
    77	#define ASPEED_I2CD_INTR_ABNORMAL			BIT(5)
    78	#define ASPEED_I2CD_INTR_NORMAL_STOP			BIT(4)
    79	#define ASPEED_I2CD_INTR_ARBIT_LOSS			BIT(3)
    80	#define ASPEED_I2CD_INTR_RX_DONE			BIT(2)
    81	#define ASPEED_I2CD_INTR_TX_NAK				BIT(1)
    82	#define ASPEED_I2CD_INTR_TX_ACK				BIT(0)
    83	#define ASPEED_I2CD_INTR_MASTER_ERRORS					       \
    84			(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
    85			 ASPEED_I2CD_INTR_SCL_TIMEOUT |				       \
    86			 ASPEED_I2CD_INTR_ABNORMAL |				       \
    87			 ASPEED_I2CD_INTR_ARBIT_LOSS)
    88	#define ASPEED_I2CD_INTR_ALL						       \
    89			(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
    90			 ASPEED_I2CD_INTR_BUS_RECOVER_DONE |			       \
    91			 ASPEED_I2CD_INTR_SCL_TIMEOUT |				       \
    92			 ASPEED_I2CD_INTR_ABNORMAL |				       \
    93			 ASPEED_I2CD_INTR_NORMAL_STOP |				       \
    94			 ASPEED_I2CD_INTR_ARBIT_LOSS |				       \
    95			 ASPEED_I2CD_INTR_RX_DONE |				       \
    96			 ASPEED_I2CD_INTR_TX_NAK |				       \
    97			 ASPEED_I2CD_INTR_TX_ACK)
    98	
    99	/* 0x14 : I2CD Command/Status Register   */
   100	#define ASPEED_I2CD_SCL_LINE_STS			BIT(18)
   101	#define ASPEED_I2CD_SDA_LINE_STS			BIT(17)
   102	#define ASPEED_I2CD_BUS_BUSY_STS			BIT(16)
   103	#define ASPEED_I2CD_BUS_RECOVER_CMD			BIT(11)
   104	
   105	/* Command Bit */
   106	#define ASPEED_I2CD_M_STOP_CMD				BIT(5)
   107	#define ASPEED_I2CD_M_S_RX_CMD_LAST			BIT(4)
   108	#define ASPEED_I2CD_M_RX_CMD				BIT(3)
   109	#define ASPEED_I2CD_S_TX_CMD				BIT(2)
   110	#define ASPEED_I2CD_M_TX_CMD				BIT(1)
   111	#define ASPEED_I2CD_M_START_CMD				BIT(0)
   112	#define ASPEED_I2CD_MASTER_CMDS_MASK					       \
   113			(ASPEED_I2CD_M_STOP_CMD |				       \
   114			 ASPEED_I2CD_M_S_RX_CMD_LAST |				       \
   115			 ASPEED_I2CD_M_RX_CMD |					       \
   116			 ASPEED_I2CD_M_TX_CMD |					       \
   117			 ASPEED_I2CD_M_START_CMD)
   118	
   119	/* 0x18 : I2CD Slave Device Address Register   */
   120	#define ASPEED_I2CD_DEV_ADDR_MASK			GENMASK(6, 0)
   121	
   122	enum aspeed_i2c_master_state {
   123		ASPEED_I2C_MASTER_INACTIVE,
   124		ASPEED_I2C_MASTER_PENDING,
   125		ASPEED_I2C_MASTER_START,
   126		ASPEED_I2C_MASTER_TX_FIRST,
   127		ASPEED_I2C_MASTER_TX,
   128		ASPEED_I2C_MASTER_RX_FIRST,
   129		ASPEED_I2C_MASTER_RX,
   130		ASPEED_I2C_MASTER_STOP,
   131	};
   132	
   133	enum aspeed_i2c_slave_state {
   134		ASPEED_I2C_SLAVE_INACTIVE,
   135		ASPEED_I2C_SLAVE_START,
   136		ASPEED_I2C_SLAVE_READ_REQUESTED,
   137		ASPEED_I2C_SLAVE_READ_PROCESSED,
   138		ASPEED_I2C_SLAVE_WRITE_REQUESTED,
   139		ASPEED_I2C_SLAVE_WRITE_RECEIVED,
   140		ASPEED_I2C_SLAVE_STOP,
   141	};
   142	
   143	struct aspeed_i2c_bus {
   144		struct i2c_adapter		adap;
   145		struct device			*dev;
   146		void __iomem			*base;
   147		struct reset_control		*rst;
   148		/* Synchronizes I/O mem access to base. */
   149		spinlock_t			lock;
   150		struct completion		cmd_complete;
   151		u32				(*get_clk_reg_val)(struct device *dev,
   152								   u32 divisor);
   153		unsigned long			parent_clk_frequency;
   154		u32				bus_frequency;
   155		/* Transaction state. */
   156		enum aspeed_i2c_master_state	master_state;
   157		struct i2c_msg			*msgs;
   158		size_t				buf_index;
   159		size_t				msgs_index;
   160		size_t				msgs_count;
   161		bool				send_stop;
   162		int				cmd_err;
   163		/* Protected only by i2c_lock_bus */
   164		int				master_xfer_result;
   165		/* Multi-master */
   166		bool				multi_master;
   167	#if IS_ENABLED(CONFIG_I2C_SLAVE)
   168		struct i2c_client		*slave;
   169		enum aspeed_i2c_slave_state	slave_state;
   170	#endif /* CONFIG_I2C_SLAVE */
   171	};
   172	
   173	static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus);
   174	
   175	static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
   176	{
   177		unsigned long time_left, flags;
   178		int ret = 0;
   179		u32 command;
   180	
   181		spin_lock_irqsave(&bus->lock, flags);
   182		command = readl(bus->base + ASPEED_I2C_CMD_REG);
   183	
   184		if (command & ASPEED_I2CD_SDA_LINE_STS) {
   185			/* Bus is idle: no recovery needed. */
   186			if (command & ASPEED_I2CD_SCL_LINE_STS)
   187				goto out;
   188			dev_dbg(bus->dev, "SCL hung (state %x), attempting recovery\n",
   189				command);
   190	
   191			reinit_completion(&bus->cmd_complete);
 > 192			aspeed_i2c_do_stop(bus);
   193			spin_unlock_irqrestore(&bus->lock, flags);
   194	
   195			time_left = wait_for_completion_timeout(
   196					&bus->cmd_complete, bus->adap.timeout);
   197	
   198			spin_lock_irqsave(&bus->lock, flags);
   199			if (time_left == 0)
   200				goto reset_out;
   201			else if (bus->cmd_err)
   202				goto reset_out;
   203			/* Recovery failed. */
   204			else if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
   205				   ASPEED_I2CD_SCL_LINE_STS))
   206				goto reset_out;
   207		/* Bus error. */
   208		} else {
   209			dev_dbg(bus->dev, "SDA hung (state %x), attempting recovery\n",
   210				command);
   211	
   212			reinit_completion(&bus->cmd_complete);
   213			/* Writes 1 to 8 SCL clock cycles until SDA is released. */
   214			writel(ASPEED_I2CD_BUS_RECOVER_CMD,
   215			       bus->base + ASPEED_I2C_CMD_REG);
   216			spin_unlock_irqrestore(&bus->lock, flags);
   217	
   218			time_left = wait_for_completion_timeout(
   219					&bus->cmd_complete, bus->adap.timeout);
   220	
   221			spin_lock_irqsave(&bus->lock, flags);
   222			if (time_left == 0)
   223				goto reset_out;
   224			else if (bus->cmd_err)
   225				goto reset_out;
   226			/* Recovery failed. */
   227			else if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
   228				   ASPEED_I2CD_SDA_LINE_STS))
   229				goto reset_out;
   230		}
   231	
   232	out:
   233		spin_unlock_irqrestore(&bus->lock, flags);
   234	
   235		return ret;
   236	
   237	reset_out:
   238		spin_unlock_irqrestore(&bus->lock, flags);
   239	
   240		return aspeed_i2c_reset(bus);
   241	}
   242	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
