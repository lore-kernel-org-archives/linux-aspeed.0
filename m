From: Corey Minyard <minyard@acm.org>
Date: Fri, 22 Jan 2021 09:31:48 -0600
Subject: [PATCH v5 3/5] ipmi: kcs: aspeed: Adapt to new LPC DTS layout
In-Reply-To: <HK0PR06MB3779C3106D2FC593B5E5243F91A00@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-4-chiawei_wang@aspeedtech.com>
 <c8421730-f8a6-46a7-9e2c-9107eb979276@www.fastmail.com>
 <HK0PR06MB3779C3106D2FC593B5E5243F91A00@HK0PR06MB3779.apcprd06.prod.outlook.com>
Message-ID: <20210122153148.GB1157510@minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 22, 2021 at 09:55:56AM +0000, ChiaWei Wang wrote:
> Hi Corey,
> 
> Could you help to review this patch to kcs_bmc_aspeed.c?
> It mainly fixes the register layout/offsets of Aspeed LPC controller.

I am not really qualified to review this.  It looks ok from a structural
and style point of view, but that's all I can tell.  So I'm ok with it.

Acked-by: Corey Minyard <cminyard@mvista.com>

> 
> Thanks,
> Chiawei
> 
> > -----Original Message-----
> > From: Andrew Jeffery <andrew@aj.id.au>
> > Sent: Wednesday, January 20, 2021 1:03 PM
> > Subject: Re: [PATCH v5 3/5] ipmi: kcs: aspeed: Adapt to new LPC DTS layout
> > 
> > 
> > 
> > On Thu, 14 Jan 2021, at 23:46, Chia-Wei, Wang wrote:
> > > Add check against LPC device v2 compatible string to ensure that the
> > > fixed device tree layout is adopted.
> > > The LPC register offsets are also fixed accordingly.
> > >
> > > Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> > > Acked-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> > 
> > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> 
> Thanks for the review.
