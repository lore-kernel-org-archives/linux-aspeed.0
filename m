From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 18 Jun 2021 13:00:47 +0300
Subject: [PATCH 3/3] i2c:support new register set for ast2600
In-Reply-To: <20210618035855.GB31659@aspeedtech.com>
References: <20210617094424.27123-1-jamin_lin@aspeedtech.com>
 <20210617094424.27123-4-jamin_lin@aspeedtech.com>
 <YMslyzUKp/7J0ncu@smile.fi.intel.com>
 <20210618035855.GB31659@aspeedtech.com>
Message-ID: <YMxuz03aTijWH6uj@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 18, 2021 at 11:58:55AM +0800, Jamin Lin wrote:
> The 06/17/2021 10:36, Andy Shevchenko wrote:
> > On Thu, Jun 17, 2021 at 05:43:40PM +0800, Jamin Lin wrote:
> > > Add i2c new driver to support new register set for AST2600.
> > > AST2600 support three modes for data transfer which are
> > > byte mode, buffer mode and dma mode, respectively.
> > > The global driver of i2c is used to set the new register
> > > mode and define the base clock frequency
> > > of baseclk_1~baseclk_4.

> >  - shrink the code base by at least ~15% (it's possible), i.e. -200 LOCs
> Can you describe it more detail?
> Do you mean I should separate the patch file to fix size limitation? 

No. Based on my brief review you introduce to many redundant LOCs (lines of
code). Remove them, refactor the code, make it small and neat and easy to read
and understand. It is possible to achieve!

> >  - rethink how you do calculations and bit operations
> >  - better code style
> >
> Thanks for your review and very good suggestion
> I will update them and sent patch again.
> By the way, I received test failed email from Robot due to compiling
> warning. I will fix them, too.

-- 
With Best Regards,
Andy Shevchenko


