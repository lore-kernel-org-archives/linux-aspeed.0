From: Tao Ren <rentao.bupt@gmail.com>
Date: Fri, 24 Jul 2020 00:57:40 -0700
Subject: [PATCH v2 0/3] ARM: dts: aspeed: fixup wedge40 device tree
In-Reply-To: <CACPK8XdiHLcBBhXjCpTZotVPuRj4bFh0x8TFhSj1TBK2xB0SiQ@mail.gmail.com>
References: <20200723230539.17860-1-rentao.bupt@gmail.com>
 <CACPK8XdiHLcBBhXjCpTZotVPuRj4bFh0x8TFhSj1TBK2xB0SiQ@mail.gmail.com>
Message-ID: <20200724075739.GA4327@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 24, 2020 at 05:32:30AM +0000, Joel Stanley wrote:
> On Thu, 23 Jul 2020 at 23:05, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > The patch series update several devices' settings in Facebook Wedge40
> > device tree.
> >
> > Patch #1 disables a few i2c controllers as they are not being used at
> > present.
> >
> > Patch #2 enables adc device for voltage monitoring.
> >
> > Patch #3 enables pwm_tacho device for fan control and monitoring.
> >
> > Tao Ren (3):
> >   ARM: dts: aspeed: wedge40: disable a few i2c controllers
> >   ARM: dts: aspeed: wedge40: enable adc device
> >   ARM: dts: aspeed: wedge40: enable pwm_tacho device
> 
> I have merged this series into the aspeed dt-for-5.9 branch.
> 
> Cheers,
> 
> Joel

Thanks a lot Joel. Have a great weekend.


Cheers,

Tao
