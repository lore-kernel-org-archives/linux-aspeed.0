From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 13 Apr 2021 09:15:55 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_16/21]_ipmi:_kcs=5Fbmc:_Add_a_"raw"_character_de?=
 =?UTF-8?Q?vice_interface?=
In-Reply-To: <CAK8P3a3RXr5CR7DJgD9rEkN8owpPxXRgzRnPB_5LuQcHkzc4LA@mail.gmail.com>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-16-andrew@aj.id.au>
 <CAK8P3a1HDQdbTAT4aRMLu-VFz720ynPqPHG5b22NZ5p5QfUqOw@mail.gmail.com>
 <ba63f830-4758-49aa-a63e-f204a8eec1b4@www.fastmail.com>
 <CAK8P3a3RXr5CR7DJgD9rEkN8owpPxXRgzRnPB_5LuQcHkzc4LA@mail.gmail.com>
Message-ID: <e2d7268b-bdaf-45bf-bb21-a5b9f7e985a4@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 12 Apr 2021, at 18:18, Arnd Bergmann wrote:
> On Mon, Apr 12, 2021 at 3:33 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > On Fri, 9 Apr 2021, at 17:25, Arnd Bergmann wrote:
> > > On Fri, Mar 19, 2021 at 7:31 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > >
> > > > The existing IPMI chardev encodes IPMI behaviours as the name suggests.
> > > > However, KCS devices are useful beyond IPMI (or keyboards), as they
> > > > provide a means to generate IRQs and exchange arbitrary data between a
> > > > BMC and its host system.
> > >
> > > I only noticed the series after Joel asked about the DT changes on the arm
> > > side. One question though:
> > >
> > > How does this related to the drivers/input/serio/ framework that also talks
> > > to the keyboard controller for things that are not keyboards?
> >
> > I've taken a brief look and I feel they're somewhat closely related.
> >
> > It's plausible that we could wrangle the code so the Aspeed and Nuvoton
> > KCS drivers move under drivers/input/serio. If you squint, the i8042
> > serio device driver has similarities with what the Aspeed and Nuvoton
> > device drivers are providing to the KCS IPMI stack.
> 
> After looking some more into it, I finally understood that the two are
> rather complementary. While the  drivers/char/ipmi/kcs_bmc.c
> is the other (bmc) end of drivers/char/ipmi/ipmi_kcs_sm.c, it seems
> that the proposed kcs_bmc_cdev_raw.c interface would be
> what corresponds to the other side of
> drivers/input/serio/i8042.c+userio.c.

Right. I guess the question is should we be splitting kernel subsystems 
along host/bmc lines? Doesn't feel intuitive, it's all Linux, but maybe 
we can consolidate in the future if it makes sense?

> Then again, these are also on
> separate ports (0x60 for the keyboard controller, 0xca2 for the BMC
> KCS), so they would never actually talk to one another.

Well, sort of I guess. On Power systems we don't use the keyboard 
controller for IPMI or keyboards, so we're just kinda exploiting the 
hardware for our own purposes.

> 
> > Both the KCS IPMI and raw chardev I've implemented in this patch need
> > both read and write access to the status register (STR). serio could
> > potentially expose its value through serio_interrupt() using the
> > SERIO_OOB_DATA flag, but I haven't put any thought into it beyond this
> > sentence. We'd need some extra support for writing STR via the serio
> > API. I'm not sure that fits into the abstraction (unless we make
> > serio_write() take a flags argument?).
> >
> > In that vein, the serio_raw interface is close to the functionality
> > that the raw chardev provides in this patch, though again serio_raw
> > lacks userspace access to STR. Flags are ignored in the ->interrupt()
> > callback so all values received via ->interrupt() are exposed as data.
> > The result is there's no way to take care of SERIO_OOB_DATA in the
> > read() path. Given that, I think we'd have to expose an ioctl() to
> > access the STR value after taking care of SERIO_OOB_DATA in
> > ->interrupt().
> >
> > I'm not sure where that lands us.
> 
> Based on what I looked up, I think you can just forget about my original
> question. We have two separate interfaces that use an Intel 8042-style
> protocol, but they don't really interact.

Right, this is still true given Power doesn't care for keyboards or 
IPMI via the keyboard controllers; the two still don't interact.

Andrew
