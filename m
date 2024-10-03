From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 3 Oct 2024 13:15:50 +0300
Subject: [PATCH v14 0/3] Add ASPEED AST2600 I2Cv2 controller driver
In-Reply-To: <SI6PR06MB75359904E108D7D0CC89A329F2712@SI6PR06MB7535.apcprd06.prod.outlook.com>
References: <20241002070213.1165263-1-ryan_chen@aspeedtech.com>
 <Zv1aOedi9xl2mg9b@smile.fi.intel.com>
 <SI6PR06MB75359904E108D7D0CC89A329F2712@SI6PR06MB7535.apcprd06.prod.outlook.com>
Message-ID: <Zv5u1gTK9yug7rbK@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 03, 2024 at 03:41:57AM +0000, Ryan Chen wrote:
> > On Wed, Oct 02, 2024 at 03:02:10PM +0800, Ryan Chen wrote:

...

> > Is it possible to switch to new terminology wherever it's possible?
> > I.e. master --> controller, slave --> target. See, for example, f872d28500bd
> > ("i2c: uniphier-f: reword according to newest specification").
> > 
> Just for cover latter? Or I should modify for each patches commit message?
> Or entire i2c driver statement need switch to target?

I believe everywhere, where it applies: driver code, comments, documentation,
commit messages...

-- 
With Best Regards,
Andy Shevchenko


