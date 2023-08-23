From: kernel test robot <lkp@intel.com>
Date: Wed, 23 Aug 2023 15:57:33 +0800
Subject: [PATCH v1 1/1] soc/aspeed: Add host side BMC device driver
In-Reply-To: <20230821183525.3427144-2-ninad@linux.ibm.com>
References: <20230821183525.3427144-2-ninad@linux.ibm.com>
Message-ID: <202308231554.SV5ASPV0-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ninad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.5-rc7 next-20230822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ninad-Palsule/soc-aspeed-Add-host-side-BMC-device-driver/20230822-023858
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20230821183525.3427144-2-ninad%40linux.ibm.com
patch subject: [PATCH v1 1/1] soc/aspeed: Add host side BMC device driver
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230823/202308231554.SV5ASPV0-lkp at intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308231554.SV5ASPV0-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308231554.SV5ASPV0-lkp at intel.com/

All warnings (new ones prefixed by >>):

   drivers/soc/aspeed/aspeed-host-bmc-dev.c: In function 'aspeed_pci_host_bmc_device_probe':
>> drivers/soc/aspeed/aspeed-host-bmc-dev.c:184:1: warning: the frame size of 1072 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     184 | }
         | ^


vim +184 drivers/soc/aspeed/aspeed-host-bmc-dev.c

    42	
    43	static int aspeed_pci_host_bmc_device_probe(struct pci_dev *pdev,
    44			const struct pci_device_id *ent)
    45	{
    46		struct uart_8250_port uart[VUART_MAX_PARMS];
    47		struct device *dev = &pdev->dev;
    48		struct aspeed_pci_bmc_dev *pci_bmc_dev;
    49		int rc = 0;
    50		int i = 0;
    51		int nr_entries;
    52		u16 config_cmd_val;
    53	
    54		pci_bmc_dev = kzalloc(sizeof(*pci_bmc_dev), GFP_KERNEL);
    55		if (!pci_bmc_dev) {
    56			rc = -ENOMEM;
    57			dev_err(dev, "kmalloc() returned NULL memory.\n");
    58			goto out_err;
    59		}
    60	
    61		rc = pcim_enable_device(pdev);
    62		if (rc != 0) {
    63			dev_err(dev, "pcim_enable_device() returned error %d\n", rc);
    64			goto out_free0;
    65		}
    66	
    67		/* set PCI host mastering  */
    68		pci_set_master(pdev);
    69	
    70		/*
    71		 * Try to allocate max MSI. If multiple MSI is not possible then use
    72		 * the legacy interrupt. Note: PowerPC doesn't support multiple MSI.
    73		 */
    74		nr_entries = pci_alloc_irq_vectors(pdev, BMC_MULTI_MSI, BMC_MULTI_MSI,
    75					PCI_IRQ_MSIX | PCI_IRQ_MSI);
    76	
    77		if (nr_entries < 0) {
    78			pci_bmc_dev->legacy_irq = 1;
    79			pci_read_config_word(pdev, PCI_COMMAND, &config_cmd_val);
    80			config_cmd_val &= ~PCI_COMMAND_INTX_DISABLE;
    81			pci_write_config_word((struct pci_dev *)pdev, PCI_COMMAND, config_cmd_val);
    82	
    83		} else {
    84			pci_bmc_dev->legacy_irq = 0;
    85			pci_read_config_word(pdev, PCI_COMMAND, &config_cmd_val);
    86			config_cmd_val |= PCI_COMMAND_INTX_DISABLE;
    87			pci_write_config_word((struct pci_dev *)pdev, PCI_COMMAND, config_cmd_val);
    88			rc = pci_irq_vector(pdev, BMC_MSI_IDX_BASE);
    89			if (rc < 0) {
    90				dev_err(dev, "pci_irq_vector() returned error %d msi=%u msix=%u\n",
    91					-rc, pdev->msi_enabled, pdev->msix_enabled);
    92				goto out_free1;
    93			}
    94			pdev->irq = rc;
    95		}
    96	
    97		/* Get access to the BARs */
    98		for (i = 0; i < BAR_MAX; i++) {
    99			rc = pci_request_region(pdev, i, DRIVER_NAME);
   100			if (rc < 0) {
   101				dev_err(dev, "pci_request_region(%d) returned error %d\n", i, rc);
   102				goto out_unreg;
   103			}
   104	
   105			pci_bmc_dev->bars[i].bar_base = pci_resource_start(pdev, i);
   106			pci_bmc_dev->bars[i].bar_size = pci_resource_len(pdev, i);
   107			pci_bmc_dev->bars[i].bar_ioremap = pci_ioremap_bar(pdev, i);
   108			if (pci_bmc_dev->bars[i].bar_ioremap == NULL) {
   109				dev_err(dev, "pci_ioremap_bar(%d) failed\n", i);
   110				rc = -ENOMEM;
   111				goto out_unreg;
   112			}
   113		}
   114	
   115		/* ERRTA40: dummy read */
   116		(void)__raw_readl((void __iomem *)pci_bmc_dev->bars[BAR_MSG].bar_ioremap);
   117	
   118		pci_set_drvdata(pdev, pci_bmc_dev);
   119	
   120		/* setup VUART */
   121		memset(uart, 0, sizeof(uart));
   122	
   123		for (i = 0; i < VUART_MAX_PARMS; i++) {
   124			vuart_ioport[i] = 0x3F8 - (i * 0x100);
   125			vuart_sirq[i] = 0x10 + 4 - i - BMC_MSI_IDX_BASE;
   126			uart[i].port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
   127			uart[i].port.uartclk = 115200 * 16;
   128			pci_bmc_dev->lines[i] = -1;
   129	
   130			if (pci_bmc_dev->legacy_irq) {
   131				uart[i].port.irq = pdev->irq;
   132			} else {
   133				rc = pci_irq_vector(pdev, vuart_sirq[i]);
   134				if (rc < 0) {
   135					dev_err(dev,
   136						"pci_irq_vector() returned error %d msi=%u msix=%u\n",
   137						-rc, pdev->msi_enabled, pdev->msix_enabled);
   138					goto out_unreg;
   139				}
   140				uart[i].port.irq = rc;
   141			}
   142			uart[i].port.dev = dev;
   143			uart[i].port.iotype = UPIO_MEM32;
   144			uart[i].port.iobase = 0;
   145			uart[i].port.mapbase =
   146					pci_bmc_dev->bars[BAR_MSG].bar_base + (vuart_ioport[i] << 2);
   147			uart[i].port.membase =
   148					pci_bmc_dev->bars[BAR_MSG].bar_ioremap + (vuart_ioport[i] << 2);
   149			uart[i].port.type = PORT_16550A;
   150			uart[i].port.flags |= (UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE);
   151			uart[i].port.regshift = 2;
   152	
   153			rc = serial8250_register_8250_port(&uart[i]);
   154			if (rc < 0) {
   155				dev_err(dev,
   156					"cannot setup VUART@%xh over PCIe, rc=%d\n",
   157					vuart_ioport[i], -rc);
   158				goto out_unreg;
   159			}
   160			pci_bmc_dev->lines[i] = rc;
   161		}
   162	
   163		return 0;
   164	
   165	out_unreg:
   166		for (i = 0; i < VUART_MAX_PARMS; i++) {
   167			if (pci_bmc_dev->lines[i] >= 0)
   168				serial8250_unregister_port(pci_bmc_dev->lines[i]);
   169		}
   170	
   171		pci_release_regions(pdev);
   172	out_free1:
   173		if (pci_bmc_dev->legacy_irq)
   174			free_irq(pdev->irq, pdev);
   175		else
   176			pci_free_irq_vectors(pdev);
   177	
   178		pci_clear_master(pdev);
   179	out_free0:
   180		kfree(pci_bmc_dev);
   181	out_err:
   182	
   183		return rc;
 > 184	}
   185	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
