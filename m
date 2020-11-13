From: Tao Ren <rentao.bupt@gmail.com>
Date: Thu, 12 Nov 2020 16:34:20 -0800
Subject: [PATCH 0/4] ARM: dts: aspeed: Add Facebook Galaxy100 BMC
In-Reply-To: <CACPK8Xf07AZNb3K76sDsZDHNOPuhpkkUGST0=RTCTS5BXgncmA@mail.gmail.com>
References: <20201111232330.30843-1-rentao.bupt@gmail.com>
 <CACPK8XdC8FRKOLQ9e583gVuDrL5829MOfx5L=O68dou6mjW_6g@mail.gmail.com>
 <20201112031828.GA4495@heinlein>
 <CACPK8Xf07AZNb3K76sDsZDHNOPuhpkkUGST0=RTCTS5BXgncmA@mail.gmail.com>
Message-ID: <20201113003419.GA12608@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 12, 2020 at 05:49:30AM +0000, Joel Stanley wrote:
> On Thu, 12 Nov 2020 at 03:18, Patrick Williams <patrick@stwcx.xyz> wrote:
> >
> > On Wed, Nov 11, 2020 at 11:34:10PM +0000, Joel Stanley wrote:
> > > On Wed, 11 Nov 2020 at 23:23, <rentao.bupt@gmail.com> wrote:
> > > >
> > > > From: Tao Ren <rentao.bupt@gmail.com>
> > > >
> > > > The patch series adds the initial version of device tree for Facebook
> > > > Galaxy100 (AST2400) BMC.
> > > >
> > > > Patch #1 adds common dtsi to minimize duplicated device entries across
> > > > Facebook Network AST2400 BMC device trees.
> > > >
> > > > Patch #2 simplfies Wedge40 device tree by using the common dtsi.
> > > >
> > > > Patch #3 simplfies Wedge100 device tree by using the common dtsi.
> > > >
> > > > Patch #4 adds the initial version of device tree for Facebook Galaxy100
> > > > BMC.
> > >
> > > Nice. They look good to me.
> > >
> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > >
> > > Is there another person familiar with the design you would like to
> > > review before I merge?
> >
> > Also,
> >
> > Reviewed-by: Patrick Williams <patrick@stwcx.xyz>
> 
> Thanks. I have merged them into the aspeed tree for 5.11.
> 
> Cheers,
> 
> Joel

Thank you Joel.

BTW, I sent out another 2 patches for AST2500 dts earlier this week; not
sure if they were successfully delivered; if not, I will resend them
earlier next week.


Cheers,

Tao
