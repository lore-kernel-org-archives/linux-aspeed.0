From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 13 Apr 2023 19:12:13 +0300
Subject: [PATCH v9 2/2 RESEND] i2c: aspeed: support ast2600 i2c new
 register mode driver
In-Reply-To: <ZDgpkK/Dv3y1LUe2@smile.fi.intel.com>
References: <20230413075327.1397306-1-ryan_chen@aspeedtech.com>
 <20230413075327.1397306-3-ryan_chen@aspeedtech.com>
 <ZDgpkK/Dv3y1LUe2@smile.fi.intel.com>
Message-ID: <ZDgp3VrjW1YdC16z@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 13, 2023 at 07:10:56PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 13, 2023 at 03:53:27PM +0800, Ryan Chen wrote:
> > Add i2c new register mode driver to support AST2600 i2c
> > new register mode. AST2600 i2c controller have legacy and
> > new register mode. The new register mode have global register
> > support 4 base clock for scl clock selection, and new clock
> > divider mode. The i2c new register mode have separate register
> > set to control i2c master and slave.
> 
> There is already i2c-aspeed.c in the kernel. Can you elaborate what's wrong
> with the extending existing driver? (It seems to me that so called "legacy"
> mode is exactly what is being serviced by that driver.)

Okay, it seems the answer is in cover letter.

-- 
With Best Regards,
Andy Shevchenko


