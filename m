From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 23 Feb 2024 17:01:43 +0200
Subject: [PATCH v1 06/14] serial: 8250_bcm7271: Switch to use
 uart_read_port_properties()
In-Reply-To: <202402231238.AWqLyIoM-lkp@intel.com>
References: <20240221183442.4124354-7-andriy.shevchenko@linux.intel.com>
 <202402231238.AWqLyIoM-lkp@intel.com>
Message-ID: <ZdizV7sbAtCZ4AyO@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 23, 2024 at 12:14:38PM +0800, kernel test robot wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build warnings:

> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402231238.AWqLyIoM-lkp at intel.com/
> 
> All warnings (new ones prefixed by >>):
> 

>    In file included from arch/hexagon/include/asm/io.h:328:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      547 |         val = __raw_readb(PCI_IOBASE + addr);
>          |                           ~~~~~~~~~~ ^

Okay, the above is well known issue with hexagon arch, not related to the series.

> >> drivers/tty/serial/8250/8250_bcm7271.c:938:22: warning: unused variable 'np' [-Wunused-variable]
>      938 |         struct device_node *np = pdev->dev.of_node;
>          |                             ^~

This one is a good catch! Will be fixed in a new version.

-- 
With Best Regards,
Andy Shevchenko


