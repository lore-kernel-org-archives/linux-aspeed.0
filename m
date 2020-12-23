From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 23 Dec 2020 02:53:33 +0000
Subject: [PATCH 2/3] aspeed-video: clear spurious interrupt bits
 unconditionally
In-Reply-To: <CACPK8XeOZEkpAKcyhZLeMdGzbwtFmdGEnL6QXp0VK1HL_O2pSg@mail.gmail.com>
References: <20201215024542.18888-1-zev@bewilderbeest.net>
 <20201215024542.18888-3-zev@bewilderbeest.net>
 <CACPK8XczCUgqOENABoDbc-qwbMxOh=1OUyBtuHSmDG_Zo571Wg@mail.gmail.com>
 <20201222191433.3dgnfwyrod4tnvaf@hatter.bewilderbeest.net>
 <CACPK8XeOZEkpAKcyhZLeMdGzbwtFmdGEnL6QXp0VK1HL_O2pSg@mail.gmail.com>
Message-ID: <HK0PR06MB338018668005D679C51EF69AF2DE0@HK0PR06MB3380.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Joel Stanley <joel@jms.id.au>
> Sent: Wednesday, December 23, 2020 9:07 AM
> To: Zev Weiss <zev@bewilderbeest.net>; Ryan Chen
> <ryan_chen@aspeedtech.com>
> Cc: Eddie James <eajames@linux.ibm.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>; Andrew Jeffery <andrew@aj.id.au>;
> linux-media at vger.kernel.org; OpenBMC Maillist <openbmc@lists.ozlabs.org>;
> Linux ARM <linux-arm-kernel@lists.infradead.org>; linux-aspeed
> <linux-aspeed@lists.ozlabs.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Subject: Re: [PATCH 2/3] aspeed-video: clear spurious interrupt bits
> unconditionally
> 
> On Tue, 22 Dec 2020 at 19:14, Zev Weiss <zev@bewilderbeest.net> wrote:
> >
> > On Mon, Dec 21, 2020 at 10:47:37PM CST, Joel Stanley wrote:
> > >On Tue, 15 Dec 2020 at 02:46, Zev Weiss <zev@bewilderbeest.net> wrote:
> > >>
> > >> Instead of testing and conditionally clearing them one by one, we
> > >> can instead just unconditionally clear them all at once.
> > >>
> > >> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> > >
> > >I had a poke at the assembly and it looks like GCC is clearing the
> > >bits unconditionally anyway, so removing the tests provides no change.
> > >
> > >Combining them is a good further optimization.
> > >
> > >Reviewed-by: Joel Stanley <joel@jms.id.au>
> > >
> > >A question unrelated to this patch: Do you know why the driver
> > >doesn't clear the status bits in the interrupt handler? I would
> > >expect it to write the value of sts back to the register to ack the
> > >pending interrupt.
> > >
> >
> > No, I don't, and I was sort of wondering the same thing actually --
> > I'm not deeply familiar with this hardware or driver though, so I was
> > a bit hesitant to start messing with things.  (Though maybe doing so
> > would address the "stickiness" aspect when it does manifest.)  Perhaps
> > Eddie or Jae can shed some light here?
> 
> I think you're onto something here - this would be why the status bits seem to
> stick until the device is reset.
> 
> Until Aspeed can clarify if this is a hardware or software issue, I suggest we ack
> the bits and log a message when we see them, instead of always ignoring them
> without taking any action.
> 
> Can you write a patch that changes the interrupt handler to ack status bits as it
> handles each of them?
> 
Hello Zev, before the patch, do you met issue with irq handler? [continuous incoming?]

In aspeed_video_irq handler should only handle enable interrupt expected.
   u32 sts = aspeed_video_read(video, VE_INTERRUPT_STATUS);
 + sts &= aspeed_video_read(video, VE_INTERRUPT_CTRL);

Ryan

> >
> >
> > Zev
> >
