From: Patrick Venture <venture@google.com>
Date: Mon, 30 Mar 2020 07:43:11 -0700
Subject: [Bug Report] soc/aspeed: integer error in
 aspeed_p2a_region_acquire
In-Reply-To: <d694432d-a3f2-4aa1-b9ee-f99f18ee2d99@www.fastmail.com>
References: <BL0PR06MB45481A385F546CF5B6855C16E5CA0@BL0PR06MB4548.namprd06.prod.outlook.com>
 <d694432d-a3f2-4aa1-b9ee-f99f18ee2d99@www.fastmail.com>
Message-ID: <CAO=notwsjF3fVhY6gFVqsxTXYs=D7LHoOUDhcHSJLzRrsA7rGw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 29, 2020 at 5:37 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hi Changming Liu,
>
> I've added Patrick to the thread, who authored the driver.
>
> On Mon, 30 Mar 2020, at 06:07, Changming Liu wrote:
> > Hi Joel and Andrew,
> >
> > Greetings, I'm a first year PhD student who is interested in the usage
> > of UBSan in the linux kernel, and with some experiments I found that in
> > drivers/soc/aspeed/aspeed-p2a-ctrl.c function
> > aspeed_p2a_region_acquire, there is an unsigned integer error which
> > might cause unexpected behavior.
> >
> > More specifically, the map structure, after the execution of
> > copy_from_user at line 180 in function aspeed_p2a_ioctl, is filled with
> > data from user space.  So the code at line 136 that is
> >
> > end = map->addr + (map->length - 1);
> >
> > the subtraction could underflow when map->length equals zero, also,
> > this sum could overflow. As a consequence, the check at line 149 could
> > be bypassed and the following code could be executed.
> >
> > Although the fact that map->addr is a 64-bit unsigned integer and
> > map->length is 32-bit makes the overflow less likely to happen, it
> > seems doesn't eliminate the possibility entirely. I guess a access_ok
> > could do?

I'll take a look, but certainly adding a 32-bit value to a 64-bit
value has the possibility of overflow given a contrived attack
scenario.

> >
> > Due to the lack of knowledge of the interaction between this module and
> > the user space, I'm not able to assess if this is security-related
> > problem. I'd appreciate it very much to hear your valuable opinion on
> > why this could not cause any trouble if it's indeed the case, this will
> > help me under linux and UBSAN a lot! and I'm more than happy to provide
> > more information if needed.
>
> It's certainly not expected behaviour and should be fixed :) We need to check
> if the `end` calculation overflowed, but not using `access_ok()`, as the value of
> `end` is an address in the physical address space of the SoC.
>
> The current behaviour does have a security impact, though probably not in
> the way you're expecting, as the driver itself is a means to violate the SoC's
> security. The SoC is a BMC and exposes several PCIe devices to its host
> (a VGA graphics device and a "BMC" device). Both devices expose
> functionality that allows the host to perform arbitrary reads and writes to the
> BMC's physical address space _if_ the BMC has allowed it to do so. This
> driver controls whether the capability is exposed to the host (disabling
> denies the read capability) and what regions of the SoC's physical address
> space can be written. Regions are roughly broken up into memory-mapped
> flash, BMC MMIO, BMC RAM and BMC LPC host controller.
>
> Practically, enabling any region for write is to some degree unsafe: for instance
> exposing the BMC's RAM to writes doesn't in any way restrict what areas of RAM
> can be written, allowing e.g. arbitrary code injection into the kernel or running
> processes on the BMC. Enabling writes to the BMC MMIO region allows arbitrary
> control of the BMC and its peripherals without having to gain code-execution
> (including escalating by removing write protection for other regions).
>
> The driver exists to assist a trusted firmware update process used on some
> platforms where the host can request (e.g. via IPMI) that BMC RAM be made
> writable, then drop its firmware update payload into a predetermined location
> in physical memory, and finally complete the transfer by requesting that RAM
> region be returned to at least read-only mode.
>
> To unlock unexpected regions of the BMC's address space in this scenario the
> host would also have to exploit IPMI to craft an ioctl() payload with the properties
> to trigger the overflow. Given that it already has complete write access to RAM it
> may be easier to just exploit the BMC kernel directly rather than chain an exploit
> through at least one other userspace process.
>
> Anyway, enough background :) Thanks for the bug report and for analyzing the
> driver. Hopefully Patrick can take a look and cook up a fix.

Yeah, this driver was deliberately written to enable accessing the
memory regions controlled by the BMC, opening a security hole in the
BMC.  It's part of the design.

>
> Andrew
