From: Joel Stanley <joel@jms.id.au>
Date: Fri, 5 Nov 2021 01:58:13 +0000
Subject: [PATCH v2] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
In-Reply-To: <CABoTLcS=s0XuM9jiisYW3=1gXtiwP8WeopqTOeBwnTX1XCky9Q@mail.gmail.com>
References: <20211105005955.107419-1-osk@google.com>
 <CACPK8XcXR=V5-Q+sC4MniNJZJgvbiysFD-5yu6v30_2BwDRTSA@mail.gmail.com>
 <CABoTLcS=s0XuM9jiisYW3=1gXtiwP8WeopqTOeBwnTX1XCky9Q@mail.gmail.com>
Message-ID: <CACPK8XebNsSr3wiMdMxDwQuMGX3p0g2Kid91dekUc6TGcHqfYQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 5 Nov 2021 at 01:47, Oskar Senft <osk@google.com> wrote:
>
> Hi Joel
>
> Oh man, this is embarrassing!

Don't worry about it. I'm a bit confused as to why I didn't see it
this morning; I thought I did a build test then.

>
> > I applied this and tried comple testing, and got this warning:
> >
> >   DTC     arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb
> > ../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:217.4-14: Warning
> > (reg_format): /ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 0:reg:
> > property has invalid length (4 bytes) (#address-cells == 2,
> > #size-cells == 1)
> > [...]
> > You need to add this to the nct node:
> >
> > #address-cells = <1>;
> > #size-cells = <0>;
> Oh yeah, of course. It's even in the example in the binding that I wrote.
>
> > Did you see this with your testing? I'm building on top of v5.15 and
> > my distro's dtc is 1.6.0.
> I built (as part of OpenBMC) and ran (on actual HW), but these
> warnings don't make it out to the console. In my "defense", I did run
> checkpatch.pl, though.
>
> Is there an easy way for me to see these types of warnings? Or should
> they really come out as errors?

Good question. v5.15 adds -Werror to the top level makefile, but as
these warnings come from the device tree compiler they won't cause the
build to fail. We should probably fix that, as I consider any dtc
warning cause to rework the patch.

I test the kernels independently of yocto; I recommend doing that with
a cross compiler when submitting patches upstream. My flow looks like
this:

CROSS_COMPILE="ccache arm-linux-gnueabi-" ARCH=arm make
O=aspeed-g5-dev aspeed_g5_defconfig
CROSS_COMPILE="ccache arm-linux-gnueabi-" ARCH=arm make -j8 O=aspeed-g5-dev -s
qemu-system-arm -M rainier-bmc -nographic -net nic -kernel
aspeed-g5-dev/arch/arm/boot/zImage -dtb
aspeed-g5-dev/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dtb -initrd
/home/joel/dev/kernels/misc/broomstick.cpio.xz -append
'console=ttyS4,115200n8 quiet' -no-reboot

A few notes:
 - I use the cross compiler from my distro. Debian unstable has GCC
11.2.0, which is the same as openbmc. You can use the compiler from
your openbmc build tree if you aren't able to install a modern
compiler

 - Using ccache is optional

 - building with -s means warnings stand out

 - if you're working on device trees and want to ensure your binary is
being built each time, omit the -s and build the 'dtbs' target

 - booting in qemu is a quick smoke test. You don't need to your board
supported in qemu to test it (although it does help to avoid warnings
from eg. i2c devices that won't probe if the hardware isn't present)

 - adding 'quiet' to the qemu command line again makes it easier to
pick out warnings

That's a bit about how I work. You don't have to follow my work flow,
but feel free to cherry pick bits that are useful.

>
> I'll fix and send a PATCH v3.
>
> I'm really sorry, this shouldn't be so much work for you!

No problem at all. Good work on iterating quickly.

Cheers,

Joel

>
> Oskar.
