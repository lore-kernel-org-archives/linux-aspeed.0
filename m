From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 12 Apr 2021 11:03:52 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_16/21]_ipmi:_kcs=5Fbmc:_Add_a_"raw"_character_de?=
 =?UTF-8?Q?vice_interface?=
In-Reply-To: <CAK8P3a1HDQdbTAT4aRMLu-VFz720ynPqPHG5b22NZ5p5QfUqOw@mail.gmail.com>
References: <20210319062752.145730-1-andrew@aj.id.au>
 <20210319062752.145730-16-andrew@aj.id.au>
 <CAK8P3a1HDQdbTAT4aRMLu-VFz720ynPqPHG5b22NZ5p5QfUqOw@mail.gmail.com>
Message-ID: <ba63f830-4758-49aa-a63e-f204a8eec1b4@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 9 Apr 2021, at 17:25, Arnd Bergmann wrote:
> On Fri, Mar 19, 2021 at 7:31 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The existing IPMI chardev encodes IPMI behaviours as the name suggests.
> > However, KCS devices are useful beyond IPMI (or keyboards), as they
> > provide a means to generate IRQs and exchange arbitrary data between a
> > BMC and its host system.
> 
> I only noticed the series after Joel asked about the DT changes on the arm
> side. One question though:
> 
> How does this related to the drivers/input/serio/ framework that also talks
> to the keyboard controller for things that are not keyboards?

I've taken a brief look and I feel they're somewhat closely related.

It's plausible that we could wrangle the code so the Aspeed and Nuvoton 
KCS drivers move under drivers/input/serio. If you squint, the i8042 
serio device driver has similarities with what the Aspeed and Nuvoton 
device drivers are providing to the KCS IPMI stack.

Both the KCS IPMI and raw chardev I've implemented in this patch need 
both read and write access to the status register (STR). serio could 
potentially expose its value through serio_interrupt() using the 
SERIO_OOB_DATA flag, but I haven't put any thought into it beyond this 
sentence. We'd need some extra support for writing STR via the serio 
API. I'm not sure that fits into the abstraction (unless we make 
serio_write() take a flags argument?).

In that vein, the serio_raw interface is close to the functionality 
that the raw chardev provides in this patch, though again serio_raw 
lacks userspace access to STR. Flags are ignored in the ->interrupt() 
callback so all values received via ->interrupt() are exposed as data. 
The result is there's no way to take care of SERIO_OOB_DATA in the 
read() path. Given that, I think we'd have to expose an ioctl() to 
access the STR value after taking care of SERIO_OOB_DATA in 
->interrupt().

I'm not sure where that lands us.

Dmitry, any thoughts here?

> Are these
> separate communication channels on adjacent I/O ports, or does there
> need to be some arbitration?

As it stands there's no arbitration.

Cheers,

Andrew
