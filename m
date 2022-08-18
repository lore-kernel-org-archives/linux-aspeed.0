From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 18 Aug 2022 14:06:40 +0200
Subject: [PATCH v3 2/2] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Mitchell BMC
In-Reply-To: <CACPK8XdDpG3ONM1=-E6qvHL1FgMNWSMPoL_sVGJK6BmmnT3w_w@mail.gmail.com>
References: <20220817071539.176110-1-quan@os.amperecomputing.com>
 <20220817071539.176110-3-quan@os.amperecomputing.com> <CACPK8XdDpG3ONM1=-E6qvHL1FgMNWSMPoL_sVGJK6BmmnT3w_w@mail.gmail.com>
Message-ID: <CAK8P3a2LZKfZpdTQ-R4o9mJ6dk52VRF+Bxj=PJEx-1MA4yH8+w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 18, 2022 at 9:33 AM Joel Stanley <joel@jms.id.au> wrote:
> > +
> > +/ {
> > +       model = "Ampere Mt.Mitchell BMC";
> > +       compatible = "ampere,mtmitchell-bmc", "aspeed,ast2600";
> > +
> > +       chosen {
> > +               stdout-path = &uart5;
>
> I know you've been told by Arnd and others to remove the default
> command line here, but without it your device tree fails to produce
> any output in my tests:
>
> qemu-system-arm -M ast2600-evb -nographic -dtb
> arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dtb -kernel
> arch/arm/boot/zImage
>
> Without a working test, I can't tell the difference between a broken
> device tree and one that omits the serial device on the command line.
> Can you work with Arnd to come to a solution here?

If you use qemu as the boot loader, I think the expected way to do
this is to use the "-append" command line argument along with "-kernel".

Is there any reason for this machine to be special here?

       Arnd
