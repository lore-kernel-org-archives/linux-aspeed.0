From: Mark Brown <broonie@kernel.org>
Date: Wed, 4 Nov 2020 20:39:55 +0000
Subject: [v2 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
In-Reply-To: <20201103072202.24705-5-chin-ting_kuo@aspeedtech.com>
References: <20201103072202.24705-1-chin-ting_kuo@aspeedtech.com>
 <20201103072202.24705-5-chin-ting_kuo@aspeedtech.com>
Message-ID: <20201104203955.GA4795@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 03, 2020 at 03:22:02PM +0800, Chin-Ting Kuo wrote:
> Add driver for ASPEED BMC FMC/SPI memory controller which
> supports spi-mem interface.

This breaks the build for me with an x86 allmodconfig:

/mnt/kernel/drivers/spi/spi-aspeed.c: In function 'aspeed_2600_spi_dma_checksum':
/mnt/kernel/drivers/spi/spi-aspeed.c:195:9: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  writel((uint32_t)ast_ctrl->chips[cs].ahb_base_phy,
         ^
/mnt/kernel/drivers/spi/spi-aspeed.c: In function 'aspeed_spi_decode_range_config':
/mnt/kernel/drivers/spi/spi-aspeed.c:488:27: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   chip[cs].ahb_base_phy = (void __iomem *)start_addr_phy;
                           ^
In file included from /mnt/kernel/include/linux/printk.h:409,
                 from /mnt/kernel/include/linux/kernel.h:16,
                 from /mnt/kernel/include/linux/clk.h:13,
                 from /mnt/kernel/drivers/spi/spi-aspeed.c:11:
/mnt/kernel/drivers/spi/spi-aspeed.c: In function 'aspeed_spi_exec_op':
/mnt/kernel/drivers/spi/spi-aspeed.c:619:44: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
   ctrl_val, addr_mode_reg, addr_data_mask, (uint32_t)op_addr);
                                            ^
/mnt/kernel/include/linux/dynamic_debug.h:129:15: note: in definition of macro '__dynamic_func_call'
   func(&id, ##__VA_ARGS__);  \
               ^~~~~~~~~~~
/mnt/kernel/include/linux/dynamic_debug.h:161:2: note: in expansion of macro '_dynamic_func_call'
  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
  ^~~~~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dev_printk.h:123:2: note: in expansion of macro 'dynamic_dev_dbg'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c:618:2: note: in expansion of macro 'dev_dbg'
  dev_dbg(dev, "ctrl: 0x%08x, addr_mode: 0x%x, mask: 0x%x, addr:0x%08x\n",
  ^~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c: In function 'aspeed_spi_dirmap_read':
/mnt/kernel/drivers/spi/spi-aspeed.c:651:25: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
  dev_dbg(ast_ctrl->dev, "read op:0x%x, addr:0x%llx, len:0x%x\n",
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dynamic_debug.h:129:15: note: in definition of macro '__dynamic_func_call'
   func(&id, ##__VA_ARGS__);  \
               ^~~~~~~~~~~
/mnt/kernel/include/linux/dynamic_debug.h:161:2: note: in expansion of macro '_dynamic_func_call'
  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
  ^~~~~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dev_printk.h:123:2: note: in expansion of macro 'dynamic_dev_dbg'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dev_printk.h:123:23: note: in expansion of macro 'dev_fmt'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                       ^~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c:651:2: note: in expansion of macro 'dev_dbg'
  dev_dbg(ast_ctrl->dev, "read op:0x%x, addr:0x%llx, len:0x%x\n",
  ^~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c: In function 'aspeed_spi_dirmap_write':
/mnt/kernel/drivers/spi/spi-aspeed.c:676:25: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
  dev_dbg(ast_ctrl->dev, "write op:0x%x, addr:0x%llx, len:0x%x\n",
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dynamic_debug.h:129:15: note: in definition of macro '__dynamic_func_call'
   func(&id, ##__VA_ARGS__);  \
               ^~~~~~~~~~~
/mnt/kernel/include/linux/dynamic_debug.h:161:2: note: in expansion of macro '_dynamic_func_call'
  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
  ^~~~~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dev_printk.h:123:2: note: in expansion of macro 'dynamic_dev_dbg'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dev_printk.h:123:23: note: in expansion of macro 'dev_fmt'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                       ^~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c:676:2: note: in expansion of macro 'dev_dbg'
  dev_dbg(ast_ctrl->dev, "write op:0x%x, addr:0x%llx, len:0x%x\n",
  ^~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c: At top level:
/mnt/kernel/drivers/spi/spi-aspeed.c:820:17: error: initialization of 'ssize_t (*)(struct spi_mem_dirmap_desc *, u64,  size_t,  void *)' {aka 'long int (*)(struct spi_mem_dirmap_desc *, long long unsigned int,  long unsigned int,  void *)'} from incompatible pointer type 'int (*)(struct spi_mem_dirmap_desc *, uint64_t,  size_t,  void *)' {aka 'int (*)(struct spi_mem_dirmap_desc *, long long unsigned int,  long unsigned int,  void *)'} [-Werror=incompatible-pointer-types]
  .dirmap_read = aspeed_spi_dirmap_read,
                 ^~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c:820:17: note: (near initialization for 'aspeed_spi_mem_ops.dirmap_read')
/mnt/kernel/drivers/spi/spi-aspeed.c:821:18: error: initialization of 'ssize_t (*)(struct spi_mem_dirmap_desc *, u64,  size_t,  const void *)' {aka 'long int (*)(struct spi_mem_dirmap_desc *, long long unsigned int,  long unsigned int,  const void *)'} from incompatible pointer type 'int (*)(struct spi_mem_dirmap_desc *, uint64_t,  size_t,  const void *)' {aka 'int (*)(struct spi_mem_dirmap_desc *, long long unsigned int,  long unsigned int,  const void *)'} [-Werror=incompatible-pointer-types]
  .dirmap_write = aspeed_spi_dirmap_write,
                  ^~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c:821:18: note: (near initialization for 'aspeed_spi_mem_ops.dirmap_write')
cc1: some warnings being treated as errors
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20201104/35ff5d1c/attachment.sig>
