From: Jamin Lin <jamin_lin@aspeedtech.com>
Date: Fri, 18 Jun 2021 11:58:55 +0800
Subject: [PATCH 3/3] i2c:support new register set for ast2600
In-Reply-To: <YMslyzUKp/7J0ncu@smile.fi.intel.com>
References: <20210617094424.27123-1-jamin_lin@aspeedtech.com>
 <20210617094424.27123-4-jamin_lin@aspeedtech.com>
 <YMslyzUKp/7J0ncu@smile.fi.intel.com>
Message-ID: <20210618035855.GB31659@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 06/17/2021 10:36, Andy Shevchenko wrote:
> On Thu, Jun 17, 2021 at 05:43:40PM +0800, Jamin Lin wrote:
> > Add i2c new driver to support new register set for AST2600.
> > AST2600 support three modes for data transfer which are
> > byte mode, buffer mode and dma mode, respectively.
> > The global driver of i2c is used to set the new register
> > mode and define the base clock frequency
> > of baseclk_1~baseclk_4.
> > 
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > ---
> >  drivers/i2c/busses/Kconfig              |   11 +
> >  drivers/i2c/busses/Makefile             |    1 +
> >  drivers/i2c/busses/ast2600-i2c-global.c |  205 +++
> >  drivers/i2c/busses/ast2600-i2c-global.h |   25 +
> >  drivers/i2c/busses/i2c-new-aspeed.c     | 1796 +++++++++++++++++++++++
> 
> I commented _something_ (but read comments carefully, they will cover much
> more). The overall it seems you have to:
>  - shrink the code base by at least ~15% (it's possible), i.e. -200 LOCs
Can you describe it more detail?
Do you mean I should separate the patch file to fix size limitation? 
>  - rethink how you do calculations and bit operations
>  - better code style
>
Thanks for your review and very good suggestion
I will update them and sent patch again.
By the way, I received test failed email from Robot due to compiling
warning. I will fix them, too. 

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
