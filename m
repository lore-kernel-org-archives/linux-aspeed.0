From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 27 Feb 2024 16:55:17 +0200
Subject: [PATCH v2 10/14] serial: 8250_of: Switch to use
 uart_read_port_properties()
In-Reply-To: <caa79772-6a54-48fd-ada2-5e7647b597ba@broadcom.com>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
 <20240226142514.1485246-11-andriy.shevchenko@linux.intel.com>
 <caa79772-6a54-48fd-ada2-5e7647b597ba@broadcom.com>
Message-ID: <Zd331VOwxzU5YUCO@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 26, 2024 at 10:24:30AM -0800, Florian Fainelli wrote:
> On 2/26/24 06:19, Andy Shevchenko wrote:
> > Since we have now a common helper to read port properties
> > use it instead of sparse home grown solution.
> > 
> > Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thank you for testing!

-- 
With Best Regards,
Andy Shevchenko


