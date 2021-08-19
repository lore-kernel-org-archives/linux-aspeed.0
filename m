From: kernel test robot <lkp@intel.com>
Date: Fri, 20 Aug 2021 01:27:30 +0800
Subject: [PATCH v2 4/5] soc: aspeed: Add eSPI driver
In-Reply-To: <20210819080040.31242-5-chiawei_wang@aspeedtech.com>
References: <20210819080040.31242-5-chiawei_wang@aspeedtech.com>
Message-ID: <202108200149.MsDMcZt1-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Chia-Wei,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on arm/for-next keystone/next soc/for-next rockchip/for-next arm64/for-next/core linus/master joel-aspeed/for-next v5.14-rc6 next-20210819]
[cannot apply to xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Chia-Wei-Wang/arm-aspeed-Add-eSPI-support/20210819-160303
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/cd398492dc8a9d27e1f7b546f1f4df371f058566
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chia-Wei-Wang/arm-aspeed-Add-eSPI-support/20210819-160303
        git checkout cd398492dc8a9d27e1f7b546f1f4df371f058566
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/soc/aspeed/aspeed-espi-ctrl.c:21:
   drivers/soc/aspeed/aspeed-espi-perif.h: In function 'aspeed_espi_perif_pc_get_rx':
>> drivers/soc/aspeed/aspeed-espi-perif.h:106:15: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
     106 |         pkt = vmalloc(pkt_len);
         |               ^~~~~~~
         |               kvmalloc
>> drivers/soc/aspeed/aspeed-espi-perif.h:106:13: warning: assignment to 'uint8_t *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     106 |         pkt = vmalloc(pkt_len);
         |             ^
   drivers/soc/aspeed/aspeed-espi-perif.h: In function 'aspeed_espi_perif_pc_put_tx':
   drivers/soc/aspeed/aspeed-espi-perif.h:163:13: warning: assignment to 'uint8_t *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     163 |         pkt = vmalloc(ioc->pkt_len);
         |             ^
>> drivers/soc/aspeed/aspeed-espi-perif.h:202:9: error: implicit declaration of function 'vfree'; did you mean 'kfree'? [-Werror=implicit-function-declaration]
     202 |         vfree(pkt);
         |         ^~~~~
         |         kfree
   drivers/soc/aspeed/aspeed-espi-perif.h: In function 'aspeed_espi_perif_np_put_tx':
   drivers/soc/aspeed/aspeed-espi-perif.h:230:13: warning: assignment to 'uint8_t *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     230 |         pkt = vmalloc(ioc->pkt_len);
         |             ^
   In file included from drivers/soc/aspeed/aspeed-espi-ctrl.c:23:
   drivers/soc/aspeed/aspeed-espi-oob.h: In function 'aspeed_espi_oob_dma_desc_get_rx':
>> drivers/soc/aspeed/aspeed-espi-oob.h:106:13: warning: assignment to 'uint8_t *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     106 |         pkt = vmalloc(pkt_len);
         |             ^
   drivers/soc/aspeed/aspeed-espi-oob.h: In function 'aspeed_espi_oob_get_rx':
   drivers/soc/aspeed/aspeed-espi-oob.h:203:13: warning: assignment to 'uint8_t *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     203 |         pkt = vmalloc(pkt_len);
         |             ^
   drivers/soc/aspeed/aspeed-espi-oob.h: In function 'aspeed_espi_oob_dma_desc_put_tx':
>> drivers/soc/aspeed/aspeed-espi-oob.h:262:15: error: implicit declaration of function 'vzalloc'; did you mean 'kvzalloc'? [-Werror=implicit-function-declaration]
     262 |         pkt = vzalloc(ioc->pkt_len);
         |               ^~~~~~~
         |               kvzalloc
   drivers/soc/aspeed/aspeed-espi-oob.h:262:13: warning: assignment to 'uint8_t *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     262 |         pkt = vzalloc(ioc->pkt_len);
         |             ^
   drivers/soc/aspeed/aspeed-espi-oob.h: In function 'aspeed_espi_oob_put_tx':
   drivers/soc/aspeed/aspeed-espi-oob.h:334:13: warning: assignment to 'uint8_t *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     334 |         pkt = vmalloc(ioc->pkt_len);
         |             ^
   In file included from drivers/soc/aspeed/aspeed-espi-ctrl.c:24:
   drivers/soc/aspeed/aspeed-espi-flash.h: In function 'aspeed_espi_flash_get_rx':
>> drivers/soc/aspeed/aspeed-espi-flash.h:119:13: warning: assignment to 'uint8_t *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     119 |         pkt = vmalloc(pkt_len);
         |             ^
   drivers/soc/aspeed/aspeed-espi-flash.h: In function 'aspeed_espi_flash_put_tx':
   drivers/soc/aspeed/aspeed-espi-flash.h:186:13: warning: assignment to 'uint8_t *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     186 |         pkt = vmalloc(ioc->pkt_len);
         |             ^
   drivers/soc/aspeed/aspeed-espi-ctrl.c: In function 'aspeed_espi_ctrl_probe':
   drivers/soc/aspeed/aspeed-espi-ctrl.c:93:24: warning: unused variable 'scu' [-Wunused-variable]
      93 |         struct regmap *scu;
         |                        ^~~
   drivers/soc/aspeed/aspeed-espi-ctrl.c:90:18: warning: unused variable 'reg' [-Wunused-variable]
      90 |         uint32_t reg;
         |                  ^~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
   Depends on SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && HAS_DMA
   Selected by
   - SND_ATMEL_SOC_SSC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC
   - SND_ATMEL_SOC_SSC_PDC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && ATMEL_SSC


vim +106 drivers/soc/aspeed/aspeed-espi-perif.h

    46	
    47	static long aspeed_espi_perif_pc_get_rx(struct file *fp,
    48						struct aspeed_espi_ioc *ioc,
    49						struct aspeed_espi_perif *espi_perif)
    50	{
    51		int i, rc;
    52		uint32_t reg;
    53		uint32_t cyc, tag, len;
    54		uint8_t *pkt;
    55		uint32_t pkt_len;
    56		struct espi_comm_hdr *hdr;
    57		unsigned long flags;
    58		struct aspeed_espi_ctrl *espi_ctrl = espi_perif->ctrl;
    59	
    60		if (!espi_perif->rx_ready) {
    61			if (fp->f_flags & O_NONBLOCK)
    62				return -ENODATA;
    63	
    64			rc = wait_event_interruptible(espi_perif->wq, espi_perif->rx_ready);
    65			if (rc == -ERESTARTSYS)
    66				return -EINTR;
    67		}
    68	
    69		/* common header (i.e. cycle type, tag, and length) is taken by HW */
    70		regmap_read(espi_ctrl->map, ESPI_PERIF_PC_RX_CTRL, &reg);
    71		cyc = (reg & ESPI_PERIF_PC_RX_CTRL_CYC_MASK) >> ESPI_PERIF_PC_RX_CTRL_CYC_SHIFT;
    72		tag = (reg & ESPI_PERIF_PC_RX_CTRL_TAG_MASK) >> ESPI_PERIF_PC_RX_CTRL_TAG_SHIFT;
    73		len = (reg & ESPI_PERIF_PC_RX_CTRL_LEN_MASK) >> ESPI_PERIF_PC_RX_CTRL_LEN_SHIFT;
    74	
    75		/*
    76		 * calculate the length of the rest part of the
    77		 * eSPI packet to be read from HW and copied to
    78		 * user space.
    79		 */
    80		switch (cyc) {
    81		case ESPI_PERIF_MSG:
    82			pkt_len = len + sizeof(struct espi_perif_msg);
    83			break;
    84		case ESPI_PERIF_MSG_D:
    85			pkt_len = ((len) ? len : ESPI_PLD_LEN_MAX) +
    86				  sizeof(struct espi_perif_msg);
    87			break;
    88		case ESPI_PERIF_SUC_CMPLT_D_MIDDLE:
    89		case ESPI_PERIF_SUC_CMPLT_D_FIRST:
    90		case ESPI_PERIF_SUC_CMPLT_D_LAST:
    91		case ESPI_PERIF_SUC_CMPLT_D_ONLY:
    92			pkt_len = ((len) ? len : ESPI_PLD_LEN_MAX) +
    93				  sizeof(struct espi_perif_cmplt);
    94			break;
    95		case ESPI_PERIF_SUC_CMPLT:
    96		case ESPI_PERIF_UNSUC_CMPLT:
    97			pkt_len = len + sizeof(struct espi_perif_cmplt);
    98			break;
    99		default:
   100			return -EFAULT;
   101		}
   102	
   103		if (ioc->pkt_len < pkt_len)
   104			return -EINVAL;
   105	
 > 106		pkt = vmalloc(pkt_len);
   107		if (!pkt)
   108			return -ENOMEM;
   109	
   110		hdr = (struct espi_comm_hdr *)pkt;
   111		hdr->cyc = cyc;
   112		hdr->tag = tag;
   113		hdr->len_h = len >> 8;
   114		hdr->len_l = len & 0xff;
   115	
   116		if (espi_perif->dma_mode) {
   117			memcpy(hdr + 1, espi_perif->dma.pc_rx_virt,
   118			       pkt_len - sizeof(*hdr));
   119		} else {
   120			for (i = sizeof(*hdr); i < pkt_len; ++i) {
   121				regmap_read(espi_ctrl->map,
   122					    ESPI_PERIF_PC_RX_PORT, &reg);
   123				pkt[i] = reg & 0xff;
   124			}
   125		}
   126	
   127		if (copy_to_user((void __user *)ioc->pkt, pkt, pkt_len))
   128			return -EFAULT;
   129	
   130		spin_lock_irqsave(&espi_perif->rx_lock, flags);
   131	
   132		regmap_write_bits(espi_ctrl->map, ESPI_PERIF_PC_RX_CTRL,
   133				  ESPI_PERIF_PC_RX_CTRL_PEND_SERV,
   134				  ESPI_PERIF_PC_RX_CTRL_PEND_SERV);
   135	
   136		espi_perif->rx_ready = 0;
   137	
   138		spin_unlock_irqrestore(&espi_perif->rx_lock, flags);
   139	
   140		return pkt_len;
   141	}
   142	
   143	static long aspeed_espi_perif_pc_put_tx(struct file *fp,
   144						struct aspeed_espi_ioc *ioc,
   145						struct aspeed_espi_perif *espi_perif)
   146	{
   147		int i, rc = 0;
   148		uint32_t reg;
   149		uint32_t cyc, tag, len;
   150		uint8_t *pkt;
   151		struct espi_comm_hdr *hdr;
   152		struct aspeed_espi_ctrl *espi_ctrl = espi_perif->ctrl;
   153	
   154		if (!mutex_trylock(&espi_perif->pc_tx_lock))
   155			return -EAGAIN;
   156	
   157		regmap_read(espi_ctrl->map, ESPI_PERIF_PC_TX_CTRL, &reg);
   158		if (reg & ESPI_PERIF_PC_TX_CTRL_TRIGGER) {
   159			rc = -EBUSY;
   160			goto unlock_n_out;
   161		}
   162	
   163		pkt = vmalloc(ioc->pkt_len);
   164		if (!pkt) {
   165			rc = -ENOMEM;
   166			goto unlock_n_out;
   167		}
   168	
   169		hdr = (struct espi_comm_hdr *)pkt;
   170	
   171		if (copy_from_user(pkt, (void __user *)ioc->pkt, ioc->pkt_len)) {
   172			rc = -EFAULT;
   173			goto free_n_out;
   174		}
   175	
   176		/*
   177		 * common header (i.e. cycle type, tag, and length)
   178		 * part is written to HW registers
   179		 */
   180		if (espi_perif->dma_mode) {
   181			memcpy(espi_perif->dma.pc_tx_virt, hdr + 1,
   182			       ioc->pkt_len - sizeof(*hdr));
   183			dma_wmb();
   184		} else {
   185			for (i = sizeof(*hdr); i < ioc->pkt_len; ++i)
   186				regmap_write(espi_ctrl->map,
   187					     ESPI_PERIF_PC_TX_PORT, pkt[i]);
   188		}
   189	
   190		cyc = hdr->cyc;
   191		tag = hdr->tag;
   192		len = (hdr->len_h << 8) | (hdr->len_l & 0xff);
   193	
   194		reg = ((cyc << ESPI_PERIF_PC_TX_CTRL_CYC_SHIFT) & ESPI_PERIF_PC_TX_CTRL_CYC_MASK)
   195			| ((tag << ESPI_PERIF_PC_TX_CTRL_TAG_SHIFT) & ESPI_PERIF_PC_TX_CTRL_TAG_MASK)
   196			| ((len << ESPI_PERIF_PC_TX_CTRL_LEN_SHIFT) & ESPI_PERIF_PC_TX_CTRL_LEN_MASK)
   197			| ESPI_PERIF_PC_TX_CTRL_TRIGGER;
   198	
   199		regmap_write(espi_ctrl->map, ESPI_PERIF_PC_TX_CTRL, reg);
   200	
   201	free_n_out:
 > 202		vfree(pkt);
   203	
   204	unlock_n_out:
   205		mutex_unlock(&espi_perif->pc_tx_lock);
   206	
   207		return rc;
   208	}
   209	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55035 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210820/76379540/attachment-0001.gz>
