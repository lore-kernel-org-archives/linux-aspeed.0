From: Tao Ren <rentao.bupt@gmail.com>
Date: Sun, 18 Jul 2021 18:03:46 -0700
Subject: [PATCH 0/4] ARM: dts: aspeed: Enable ADC for wedge100 BMC
In-Reply-To: <CACPK8Xdgp50KbVvhSbhrwUiTB6MJ5PoBzV9n18ubZAAOprOGiw@mail.gmail.com>
References: <20210719001724.6410-1-rentao.bupt@gmail.com>
 <CACPK8Xdgp50KbVvhSbhrwUiTB6MJ5PoBzV9n18ubZAAOprOGiw@mail.gmail.com>
Message-ID: <20210719010346.GA6817@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 19, 2021 at 12:21:20AM +0000, Joel Stanley wrote:
> On Mon, 19 Jul 2021 at 00:17, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > The patch series enables ADC for Facebook Wedge100 BMC platform.
> >
> > Patch #1 enables ADC in Facebook AST2400 common dtsi because ADC is used
> > on all the Facebook AST2400 Network BMC platforms.
> >
> > Patch #2 removes the redundant ADC entry from Wedge40 dts.
> >
> > Patch #3 removes the redundant ADC entry from Galaxy100 dts.
> >
> > Patch #4 enables the ADC voltage sensoring channels in Wedge100 dts.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> Thanks Tao, I will apply these for v5.15.

Thanks Joel!


Cheers,

Tao
