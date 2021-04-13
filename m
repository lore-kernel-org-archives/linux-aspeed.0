From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 13 Apr 2021 10:22:11 +0200
Subject: [PATCH v2 16/21] ipmi: kcs_bmc: Add a "raw" character device
 interface
In-Reply-To: <e2d7268b-bdaf-45bf-bb21-a5b9f7e985a4@www.fastmail.com>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-16-andrew@aj.id.au>
 <CAK8P3a1HDQdbTAT4aRMLu-VFz720ynPqPHG5b22NZ5p5QfUqOw@mail.gmail.com>
 <ba63f830-4758-49aa-a63e-f204a8eec1b4@www.fastmail.com>
 <CAK8P3a3RXr5CR7DJgD9rEkN8owpPxXRgzRnPB_5LuQcHkzc4LA@mail.gmail.com>
 <e2d7268b-bdaf-45bf-bb21-a5b9f7e985a4@www.fastmail.com>
Message-ID: <CAK8P3a1VFKuewt65RUK6hFAhZYSFFVUX7_nuJLoZW2WoPXGVTw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 13, 2021 at 1:45 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> On Mon, 12 Apr 2021, at 18:18, Arnd Bergmann wrote:
> > On Mon, Apr 12, 2021 at 3:33 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > On Fri, 9 Apr 2021, at 17:25, Arnd Bergmann wrote:
> > > > On Fri, Mar 19, 2021 at 7:31 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > >
> > > > > The existing IPMI chardev encodes IPMI behaviours as the name suggests.
> > > > > However, KCS devices are useful beyond IPMI (or keyboards), as they
> > > > > provide a means to generate IRQs and exchange arbitrary data between a
> > > > > BMC and its host system.
> > > >
> > > > I only noticed the series after Joel asked about the DT changes on the arm
> > > > side. One question though:
> > > >
> > > > How does this related to the drivers/input/serio/ framework that also talks
> > > > to the keyboard controller for things that are not keyboards?
> > >
> > > I've taken a brief look and I feel they're somewhat closely related.
> > >
> > > It's plausible that we could wrangle the code so the Aspeed and Nuvoton
> > > KCS drivers move under drivers/input/serio. If you squint, the i8042
> > > serio device driver has similarities with what the Aspeed and Nuvoton
> > > device drivers are providing to the KCS IPMI stack.
> >
> > After looking some more into it, I finally understood that the two are
> > rather complementary. While the  drivers/char/ipmi/kcs_bmc.c
> > is the other (bmc) end of drivers/char/ipmi/ipmi_kcs_sm.c, it seems
> > that the proposed kcs_bmc_cdev_raw.c interface would be
> > what corresponds to the other side of
> > drivers/input/serio/i8042.c+userio.c.
>
> Right. I guess the question is should we be splitting kernel subsystems
> along host/bmc lines? Doesn't feel intuitive, it's all Linux, but maybe
> we can consolidate in the future if it makes sense?

We actually have a number of subsystems with somewhat overlapping
functionality. I brought up serio, because it has an abstraction for multiple
things that communicate over the keyboard controller and I thought
the problem you were trying to solve was also related to the keyboard
controller.
It is also one of multiple abstractions that allow you to connect a device
to a uart (along with serdev and tty_ldisc, probably at least one more that
you can nest above or below these).

Consolidating the kcs_bmc.c interface into something that already
exists would obviously be best, but it's not clear which of these that
should be, that depends on the fundamental properties of the hardware
interface.

> > Then again, these are also on
> > separate ports (0x60 for the keyboard controller, 0xca2 for the BMC
> > KCS), so they would never actually talk to one another.
>
> Well, sort of I guess. On Power systems we don't use the keyboard
> controller for IPMI or keyboards, so we're just kinda exploiting the
> hardware for our own purposes.

Can you describe in an abstract form what the hardware interface
can do here and what you want from it? I wonder if it could be
part of a higher-level interface such as drivers/mailbox/ instead.

         Arnd
