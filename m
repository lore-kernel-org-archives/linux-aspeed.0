From: kernel test robot <lkp@intel.com>
Date: Sat, 2 Sep 2023 04:42:33 +0800
Subject: [PATCH v2 1/1] soc/aspeed: Add host side BMC device driver
In-Reply-To: <20230823173104.3219128-2-ninad@linux.ibm.com>
References: <20230823173104.3219128-2-ninad@linux.ibm.com>
Message-ID: <202309020400.PQMeauEC-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ninad,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.5 next-20230831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ninad-Palsule/soc-aspeed-Add-host-side-BMC-device-driver/20230824-013703
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20230823173104.3219128-2-ninad%40linux.ibm.com
patch subject: [PATCH v2 1/1] soc/aspeed: Add host side BMC device driver
config: m68k-randconfig-r004-20230902 (https://download.01.org/0day-ci/archive/20230902/202309020400.PQMeauEC-lkp at intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230902/202309020400.PQMeauEC-lkp at intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309020400.PQMeauEC-lkp at intel.com/

All errors (new ones prefixed by >>):

   drivers/soc/aspeed/aspeed-host-bmc-dev.c: In function 'aspeed_pci_host_bmc_device_probe':
>> drivers/soc/aspeed/aspeed-host-bmc-dev.c:98:22: error: implicit declaration of function 'pci_request_region'; did you mean 'pci_request_regions'? [-Werror=implicit-function-declaration]
      98 |                 rc = pci_request_region(pdev, i, DRIVER_NAME);
         |                      ^~~~~~~~~~~~~~~~~~
         |                      pci_request_regions
>> drivers/soc/aspeed/aspeed-host-bmc-dev.c:176:17: error: implicit declaration of function 'pci_free_irq_vectors'; did you mean 'pci_alloc_irq_vectors'? [-Werror=implicit-function-declaration]
     176 |                 pci_free_irq_vectors(pdev);
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 pci_alloc_irq_vectors
   cc1: some warnings being treated as errors


vim +98 drivers/soc/aspeed/aspeed-host-bmc-dev.c

    42	
    43	static int aspeed_pci_host_bmc_device_probe(struct pci_dev *pdev,
    44			const struct pci_device_id *ent)
    45	{
    46		struct uart_8250_port uart;
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
    74		nr_entries = pci_alloc_irq_vectors(pdev, 1, BMC_MULTI_MSI,
    75					PCI_IRQ_MSIX | PCI_IRQ_MSI);
    76		if (nr_entries < 0) {
    77			pci_bmc_dev->legacy_irq = 1;
    78			pci_read_config_word(pdev, PCI_COMMAND, &config_cmd_val);
    79			config_cmd_val &= ~PCI_COMMAND_INTX_DISABLE;
    80			pci_write_config_word((struct pci_dev *)pdev, PCI_COMMAND, config_cmd_val);
    81	
    82		} else {
    83			pci_bmc_dev->legacy_irq = 0;
    84			pci_read_config_word(pdev, PCI_COMMAND, &config_cmd_val);
    85			config_cmd_val |= PCI_COMMAND_INTX_DISABLE;
    86			pci_write_config_word((struct pci_dev *)pdev, PCI_COMMAND, config_cmd_val);
    87			rc = pci_irq_vector(pdev, BMC_MSI_IDX_BASE);
    88			if (rc < 0) {
    89				dev_err(dev, "pci_irq_vector() returned error %d msi=%u msix=%u\n",
    90					-rc, pdev->msi_enabled, pdev->msix_enabled);
    91				goto out_free1;
    92			}
    93			pdev->irq = rc;
    94		}
    95	
    96		/* Get access to the BARs */
    97		for (i = 0; i < BAR_MAX; i++) {
  > 98			rc = pci_request_region(pdev, i, DRIVER_NAME);
    99			if (rc < 0) {
   100				dev_err(dev, "pci_request_region(%d) returned error %d\n", i, rc);
   101				goto out_unreg;
   102			}
   103	
   104			pci_bmc_dev->bars[i].bar_base = pci_resource_start(pdev, i);
   105			pci_bmc_dev->bars[i].bar_size = pci_resource_len(pdev, i);
   106			pci_bmc_dev->bars[i].bar_ioremap = pci_ioremap_bar(pdev, i);
   107			if (pci_bmc_dev->bars[i].bar_ioremap == NULL) {
   108				dev_err(dev, "pci_ioremap_bar(%d) failed\n", i);
   109				rc = -ENOMEM;
   110				goto out_unreg;
   111			}
   112		}
   113	
   114		/* ERRTA40: dummy read */
   115		(void)__raw_readl((void __iomem *)pci_bmc_dev->bars[BAR_MSG].bar_ioremap);
   116	
   117		pci_set_drvdata(pdev, pci_bmc_dev);
   118	
   119		for (i = 0; i < VUART_MAX_PARMS; i++)
   120			pci_bmc_dev->lines[i] = -1;
   121	
   122		/* setup VUART */
   123		for (i = 0; i < VUART_MAX_PARMS; i++) {
   124			memset(&uart, 0, sizeof(uart));
   125			vuart_ioport[i] = 0x3F8 - (i * 0x100);
   126			vuart_sirq[i] = 0x10 + 4 - i - BMC_MSI_IDX_BASE;
   127			uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
   128			uart.port.uartclk = 115200 * 16;
   129	
   130			if (pci_bmc_dev->legacy_irq) {
   131				uart.port.irq = pdev->irq;
   132			} else {
   133				rc = pci_irq_vector(pdev, vuart_sirq[i]);
   134				if (rc < 0) {
   135					dev_err(dev,
   136						"pci_irq_vector() returned error %d msi=%u msix=%u\n",
   137						-rc, pdev->msi_enabled, pdev->msix_enabled);
   138					goto out_unreg;
   139				}
   140				uart.port.irq = rc;
   141			}
   142			uart.port.dev = dev;
   143			uart.port.iotype = UPIO_MEM32;
   144			uart.port.iobase = 0;
   145			uart.port.mapbase =
   146					pci_bmc_dev->bars[BAR_MSG].bar_base + (vuart_ioport[i] << 2);
   147			uart.port.membase =
   148					pci_bmc_dev->bars[BAR_MSG].bar_ioremap + (vuart_ioport[i] << 2);
   149			uart.port.type = PORT_16550A;
   150			uart.port.flags |= (UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE);
   151			uart.port.regshift = 2;
   152	
   153			rc = serial8250_register_8250_port(&uart);
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
 > 176			pci_free_irq_vectors(pdev);
   177	
   178		pci_clear_master(pdev);
   179	out_free0:
   180		kfree(pci_bmc_dev);
   181	out_err:
   182	
   183		return rc;
   184	}
   185	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
