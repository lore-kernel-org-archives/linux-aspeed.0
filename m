From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 22 Feb 2024 15:23:24 +0200
Subject: [PATCH v1 10/14] serial: 8250_of: Switch to use
 uart_read_port_properties()
In-Reply-To: <0a828f2c50de712940fb9a881702ac1678a35b7c.camel@codeconstruct.com.au>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-11-andriy.shevchenko@linux.intel.com>
 <0a828f2c50de712940fb9a881702ac1678a35b7c.camel@codeconstruct.com.au>
Message-ID: <ZddKzHplwOX7naLv@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 22, 2024 at 11:07:05AM +1030, Andrew Jeffery wrote:
> On Wed, 2024-02-21 at 20:31 +0200, Andy Shevchenko wrote:
> > Since we have now a common helper to read port properties
> > use it instead of sparse home grown solution.
> 
> I did some brief testing of the series for the Aspeed machines under
> qemu, building them on top of v6.8-rc5:
> 
> export ARCH=arm
> export CROSS_COMPILE=arm-linux-gnueabihf-
> make aspeed_g5_defconfig
> make -j$(nproc)
> qemu-system-arm -M rainier-bmc -nographic -no-reboot -kernel arch/arm/boot/zImage -dtb arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb -initrd ...
> 
> I got an oops during boot, which bisected to this change:

Thank you for prompt testing! I will look at it.

-- 
With Best Regards,
Andy Shevchenko


