From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 16 Aug 2021 12:40:55 +0300
Subject: [PATCH 1/2] soc: aspeed: Add LPC mailbox support
In-Reply-To: <20210813054758.13189-2-chiawei_wang@aspeedtech.com>
Message-ID: <202108160813.GOZ1P4Y8-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Chia-Wei,

url:    https://github.com/0day-ci/linux/commits/Chia-Wei-Wang/aspeed-Add-LPC-mailbox-support/20210813-134908
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git for-next
config: openrisc-randconfig-m031-20210816 (attached as .config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/soc/aspeed/aspeed-lpc-mbox.c:230 aspeed_mbox_ioctl() warn: maybe return -EFAULT instead of the bytes remaining?

vim +230 drivers/soc/aspeed/aspeed-lpc-mbox.c

72c5a69dc779f5 Chia-Wei Wang 2021-08-13  214  static long aspeed_mbox_ioctl(struct file *file, unsigned int cmd,
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  215  				 unsigned long param)
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  216  {
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  217  	struct aspeed_mbox *mbox = file_mbox(file);
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  218  	const struct aspeed_mbox_model *model = mbox->model;
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  219  	struct aspeed_mbox_ioctl_data data;
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  220  	long ret;
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  221  
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  222  	switch (cmd) {
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  223  	case ASPEED_MBOX_IOCTL_GET_SIZE:
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  224  		data.data = model->dr_num;
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  225  		ret = copy_to_user((void __user *)param, &data, sizeof(data));

This should be:

	if (copy_to_user((void __user *)param, &data, sizeof(data)))
		return -EFAULT;

72c5a69dc779f5 Chia-Wei Wang 2021-08-13  226  		break;
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  227  	default:
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  228  		ret = -ENOTTY;
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  229  	}
72c5a69dc779f5 Chia-Wei Wang 2021-08-13 @230  	return ret;
72c5a69dc779f5 Chia-Wei Wang 2021-08-13  231  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org

