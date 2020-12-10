From: Oskar Senft <osk@google.com>
Date: Thu, 10 Dec 2020 07:33:44 -0500
Subject: [External] Re: [PATCH 1/3] misc: aspeed: Add Aspeed UART routing
 control driver.
In-Reply-To: <X9H4r3XZynGtSDw0@kroah.com>
References: <20201210092853.303-1-wangzhiqiang.bj@bytedance.com>
 <X9HtwHo8s6e2UsAT@kroah.com>
 <CAH0XSJt3=XJ_gQb2rTvbUcbyow2k7E4jfuKGKAKdi+nwdfauVw@mail.gmail.com>
 <X9H4r3XZynGtSDw0@kroah.com>
Message-ID: <CABoTLcSiCsASu_prfxH_sZrm-njcYzkcvrrpS1envj7QvxYtNA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The purpose of this driver is to allow manipulation of the UART routing at
runtime. Setting the routing in the DTS would obviously not allow that.

From what I remember, I used am existing unrelated driver as template.
Apologies for using the wrong APIs - I literally just followed what I had
seen elsewhere.

Since posting this driver, we found that while it solved our initial use
case, that use case has evolved. We're now using Aspeed's VUART where bytes
are routed "manually" (i.e. copied between devices) rather than in
hardware. So I don't need this driver anymore.

If it's still useful to anyone, please take ownership and modify it as
needed to be able to submit it. I'm still happy to keep an eye on it and
help explain its purpose.

Oskar.

On Thu, Dec 10, 2020, 5:28 AM Greg Kroah-Hartman <gregkh@linuxfoundation.org>
wrote:

> On Thu, Dec 10, 2020 at 06:06:59PM +0800, John Wang wrote:
> > On Thu, Dec 10, 2020 at 5:42 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Dec 10, 2020 at 05:28:53PM +0800, John Wang wrote:
> > > > From: Oskar Senft <osk@google.com>
> > > >
> > > > This driver adds sysfs files that allow the BMC userspace to
> configure
> > > > how UARTs and physical serial I/O ports are routed.
> > > >
> > > > Tested: Checked correct behavior (both read & write) on TYAN S7106
> > > > board by manually changing routing settings and confirming that bits
> > > > flow as expected. Tested for UART1 and UART3 as this board doesn't
> have
> > > > the other UARTs wired up in a testable way.
> > > >
> > > > Signed-off-by: Oskar Senft <osk@google.com>
> > > > Signed-off-by: Yong Li <yong.b.li@linux.intel.com>
> > > > Signed-off-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> > > > Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
> > > > ---
> > > >  .../stable/sysfs-driver-aspeed-uart-routing   |  14 +
> > > >  .../misc-devices/aspeed-uart-routing.txt      |  49 +++
> > > >  drivers/misc/Kconfig                          |   6 +
> > > >  drivers/misc/Makefile                         |   1 +
> > > >  drivers/misc/aspeed-uart-routing.c            | 383
> ++++++++++++++++++
> > > >  5 files changed, 453 insertions(+)
> > > >  create mode 100644
> Documentation/ABI/stable/sysfs-driver-aspeed-uart-routing
> > > >  create mode 100644
> Documentation/misc-devices/aspeed-uart-routing.txt
> > > >  create mode 100644 drivers/misc/aspeed-uart-routing.c
> > > >
> > > > diff --git
> a/Documentation/ABI/stable/sysfs-driver-aspeed-uart-routing
> b/Documentation/ABI/stable/sysfs-driver-aspeed-uart-routing
> > > > new file mode 100644
> > > > index 000000000000..5068737d9c12
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/stable/sysfs-driver-aspeed-uart-routing
> > > > @@ -0,0 +1,14 @@
> > > > +What:
> /sys/bus/platform/drivers/aspeed-uart-routing/*/io*
> > > > +Date:                August 2018
> > > > +Contact:     Oskar Senft <osk@google.com>
> > > > +Description: Configures the input source for the specific physical
> > > > +             serial I/O port.
> > > > +Users:               OpenBMC.  Proposed changes should be mailed to
> > > > +             openbmc at lists.ozlabs.org
> > > > +
> > > > +What:
> /sys/bus/platform/drivers/aspeed-uart-routing/*/uart*
> > > > +Date:                August 2018
> > > > +Contact:     Oskar Senft <osk@google.com>
> > > > +Description: Configures the input source for the specific UART.
> > > > +Users:               OpenBMC.  Proposed changes should be mailed to
> > > > +             openbmc at lists.ozlabs.org
> > > > diff --git a/Documentation/misc-devices/aspeed-uart-routing.txt
> b/Documentation/misc-devices/aspeed-uart-routing.txt
> > > > new file mode 100644
> > > > index 000000000000..cf1c2a466875
> > > > --- /dev/null
> > > > +++ b/Documentation/misc-devices/aspeed-uart-routing.txt
> > > > @@ -0,0 +1,49 @@
> > > > +Kernel driver aspeed-uart-routing
> > > > +=================================
> > > > +
> > > > +Supported chips:
> > > > +ASPEED AST2500/AST2600
> > > > +
> > > > +Author:
> > > > +Google LLC
> > > > +
> > > > +Description
> > > > +-----------
> > > > +
> > > > +The Aspeed AST2500/AST2600 allows to dynamically route the inputs
> for the
> > > > +built-in UARTS and physical serial I/O ports.
> > > > +
> > > > +This allows, for example, to connect the output of UART to another
> UART.
> > > > +This can be used to enable host<->BMC communication via UARTs, e.g.
> to allow
> > > > +access to the host's serial console.
> > > > +
> > > > +This driver is for the BMC side. The sysfs files allow the BMC
> userspace
> > > > +which owns the system configuration policy, to configure how UARTs
> and
> > > > +physical serial I/O ports are routed.
> > > > +
> > > > +The driver provides the following files in sysfs:
> > > > +uart1                Configure the input signal to UART1.
> > > > +uart2                Configure the input signal to UART2.
> > > > +uart3                Configure the input signal to UART3.
> > > > +uart4                Configure the input signal to UART4.
> > > > +uart5                Configure the input signal to UART5.
> > > > +io1          Configure the input signal to physical serial port 1.
> > > > +io2          Configure the input signal to physical serial port 2.
> > > > +io3          Configure the input signal to physical serial port 3.
> > > > +io4          Configure the input signal to physical serial port 4.
> > > > +io5          Configure the input signal to physical serial port 5.
> > > > +
> > > > +When read, each file shows the list of available options with the
> currently
> > > > +selected option marked by square brackets "[]". The list of
> available options
> > > > +depends on the selected file.
> > > > +
> > > > +Example:
> > > > +$ cat
> /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
> > > > +[io1] io2 io3 io4 uart2 uart3 uart4 io6
> > > > +
> > > > +In this case, UART1 gets its input signal from IO1 (physical serial
> port 1).
> > > > +
> > > > +$ echo -n "uart3" \
> > > > +
> >/sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
> > > > +$ cat
> /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
> > > > +io1 io2 io3 io4 uart2 [uart3] uart4 io6
> > >
> > > Are you sure there are no other ways to configure this type of thing,
> > > than to a driver-specific sysfs file?
> >
> > I think this is good. but what's your suggestion?
>
> I do not know, but isn't this normally handled in a dts file?  Why must
> it be done "on the fly" like this?
>
> > If I use a driver-specific sysfs and modify the code based on the
> > comments, is this a good direction to go?
>
> That's what you are trying to do here, and is why I am objecting to it
> :)
>
> thanks,
>
> greg k-h
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20201210/164fe167/attachment-0001.htm>
