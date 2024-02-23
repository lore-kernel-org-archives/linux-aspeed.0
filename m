From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 23 Feb 2024 17:02:29 +0200
Subject: [PATCH v1 10/14] serial: 8250_of: Switch to use
 uart_read_port_properties()
In-Reply-To: <ad91eec0-39da-4b9c-8da7-f1e98bb4565b@broadcom.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-11-andriy.shevchenko@linux.intel.com>
 <0a828f2c50de712940fb9a881702ac1678a35b7c.camel@codeconstruct.com.au>
 <ZddKzHplwOX7naLv@smile.fi.intel.com>
 <Zdd5m2xIPlGI0_Qv@smile.fi.intel.com>
 <Zdd6lnXwvpPPUhRR@smile.fi.intel.com>
 <e5fd9d8b-84eb-4ef9-82ab-ff4ecc41c0d5@broadcom.com>
 <ad91eec0-39da-4b9c-8da7-f1e98bb4565b@broadcom.com>
Message-ID: <ZdizhVPfwFp72ioI@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 22, 2024 at 11:54:46AM -0800, Florian Fainelli wrote:
> On 2/22/24 09:39, Florian Fainelli wrote:
> > On 2/22/24 08:47, Andy Shevchenko wrote:

...

> > Thanks, on 8250_bcm7271.c with the above hunk applied, I did not spot
> > any differences between the values returned by stty or a cat
> > /sys/class/tty/ttyS0/* before or after, the console remained fully
> > functional. I will see if I can run an additional test where I removed
> > the DT's "clocks" property and confirm that the fall back to
> > "clock-frequency" works.
> 
> Also appears to work properly on a Raspberry Pi 4 with the console using the
> bcm2835-aux driver, will provide Tested-by tags on the next submission,
> thanks!

Thank you for prompt testing on real HW!

-- 
With Best Regards,
Andy Shevchenko


