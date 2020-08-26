From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 26 Aug 2020 01:59:11 +0000
Subject: [PATCH 3/5] i2c: aspeed: Mask IRQ status to relevant bits
In-Reply-To: <20200825200523.GA22083@taoren-ubuntu-R90MNF91>
References: <20200820161152.22751-1-eajames@linux.ibm.com>
 <20200820161152.22751-4-eajames@linux.ibm.com>
 <CACPK8XdG1+3eQPQ71fZYZdHwcn8WNLQKF=5iKrOvGhLwispSQA@mail.gmail.com>
 <8fc365dd-8a89-9e5c-ed70-093ef2bf7265@linux.ibm.com>
 <20200825200523.GA22083@taoren-ubuntu-R90MNF91>
Message-ID: <f84a5ad1064142b78b3fc5eeb4659627@TWMBX02.aspeed.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Tao Ren [mailto:rentao.bupt at gmail.com]
> Sent: Wednesday, August 26, 2020 4:05 AM
> To: Eddie James <eajames@linux.ibm.com>
> Cc: Joel Stanley <joel@jms.id.au>; devicetree <devicetree@vger.kernel.org>;
> linux-aspeed <linux-aspeed@lists.ozlabs.org>; dmitry.torokhov at gmail.com;
> Brendan Higgins <brendanhiggins@google.com>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Rob Herring <robh+dt@kernel.org>;
> linux-i2c at vger.kernel.org; linux-input at vger.kernel.org; Ryan Chen
> <ryan_chen@aspeedtech.com>
> Subject: Re: [PATCH 3/5] i2c: aspeed: Mask IRQ status to relevant bits
> 
> On Tue, Aug 25, 2020 at 02:47:51PM -0500, Eddie James wrote:
> >
> > On 8/25/20 1:38 AM, Joel Stanley wrote:
> > > On Thu, 20 Aug 2020 at 16:12, Eddie James <eajames@linux.ibm.com>
> wrote:
> > > > Mask the IRQ status to only the bits that the driver checks. This
> > > > prevents excessive driver warnings when operating in slave mode
> > > > when additional bits are set that the driver doesn't handle.
> > > >
> > > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > > > ---
> > > >   drivers/i2c/busses/i2c-aspeed.c | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/i2c/busses/i2c-aspeed.c
> > > > b/drivers/i2c/busses/i2c-aspeed.c index 31268074c422..abf40f2af8b4
> > > > 100644
> > > > --- a/drivers/i2c/busses/i2c-aspeed.c
> > > > +++ b/drivers/i2c/busses/i2c-aspeed.c
> > > > @@ -604,6 +604,7 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq,
> void *dev_id)
> > > >          writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
> > > >                 bus->base + ASPEED_I2C_INTR_STS_REG);
> > > >          readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> > > > +       irq_received &= 0xf000ffff;
> > > >          irq_remaining = irq_received;
> > > This would defeat the check for irq_remaining. I don't think we want to do
> this.
> > >
> > > Can you explain why these bits are being set in slave mode?
> >
> >
> > No, I don't have any documentation for the bits that are masked off
> > here, so I don't know why they would get set.
> >
> > The check for irq_remaining is still useful for detecting that the
> > driver state machine might be out of sync with what the master is doing.
> 
> I have a similar patch in my local tree, and the reason being: AST2600 I2C
> Controller may set I2CD10[25:24] to report Current Slave Parking Status
> (defined in new register I2CS24) even though the new register mode is off. The
> 2 bits can be ignored in legacy mode, and Ryan from ASPEED could confirm it.
Yes, in AST2600 i2cd10[25:24] will be the same with new mode register i2cs24[25:24]
Thanks Tao.
> 
> 
> Cheers,
> 
> Tao
