From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 27 Feb 2024 16:55:29 +0200
Subject: [PATCH v2 14/14] serial: 8250_uniphier: Switch to use
 uart_read_port_properties()
In-Reply-To: <2cb457a6-0039-e4fe-3668-690e6355771d@socionext.com>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
 <20240226142514.1485246-15-andriy.shevchenko@linux.intel.com>
 <2cb457a6-0039-e4fe-3668-690e6355771d@socionext.com>
Message-ID: <Zd334bOasYXT37gW@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 27, 2024 at 06:43:51PM +0900, Kunihiko Hayashi wrote:
> Hi,
> 
> On 2024/02/26 23:19, Andy Shevchenko wrote:
> > Since we have now a common helper to read port properties
> > use it instead of sparse home grown solution.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I confirmed that it works properly.
> 
> Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you for testing!

-- 
With Best Regards,
Andy Shevchenko


