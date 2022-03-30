From: Ali El-Haj-Mahmoud <aaelhaj@google.com>
Date: Wed, 30 Mar 2022 17:02:17 -0400
Subject: aspeed2500 SPI1 control at run-time with OpenBMC
In-Reply-To: <a509d7a3-2551-4eea-b965-9499ada39b16@www.fastmail.com>
References: <CAFPZpNbNc5Fx1tBtmM1x0n-qEB_qp+wSSrR2+_0bxPrPyh1xMw@mail.gmail.com>
 <c29de2ea-0f60-4e7f-8308-11849a7de8e8@www.fastmail.com>
 <CAFPZpNZ1+UDVcEs_gp1zCzxXfP6PqZ8kx+UGhb73BusiScRk+g@mail.gmail.com>
 <a509d7a3-2551-4eea-b965-9499ada39b16@www.fastmail.com>
Message-ID: <CAFPZpNb4fNF-QgQrWLeSkN9TjYsWZvH1YrbQj66rBW6jn8rCug@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I'm testing with pinmux-select/debugfs at initially to understand how
this is supposed to work.

I have a local patch to let pinctrl driver modify SCU70[13:12]:
https://github.com/aaelhaj/linux/commit/732342c55876fb81bd02828b4530ee28158b5c96

The desired state is that SPI1 is by default in passthru so that the
host can boot. I'd like to switch it to be connected to the BMC only
when updating the host BIOS (while the host is switched off).

Testing with:

&spi1 {
status = "okay";
pinctrl-names = "default";
pinctrl-0 = <&pinctrl_spi1_default>;
}

I would assume this means SPI1 would be connected to BMC (SCU70[13:12]
= 0x1), which is indeed the case. After rebooting the system:
$ echo $(( ($(devmem 0x1e6e2070 32) >> 12) & 0x3 ))
1

I can flash a new host BIOS:
$ grep -xl pnor /sys/class/mtd/*/name
/sys/class/mtd/mtd6/name
$ dd if=bios.bin of=/dev/mtd6

I can also switch the pinmux-select to SPI1PASSTHRU to boot the host
with the new BIOS:
$ echo SPI1PASSTHRU SPI1PASSTHRU >
/sys/kernel/debug/pinctrl/1e6e2080.pinctrl-aspeed-g5-pinctrl/pinmux-select
$ echo $(( ($(devmem 0x1e6e2070 32) >> 12) & 0x3 ))
3

So at least I know that I can switch the state of SPI1 control using
pinmux-select/debugfs when it starts connected to the BMC by default.

However, the other way around doesn't work. If I have this config:

&spi1 {
status = "okay";
pinctrl-names = "default";
pinctrl-0 = <&pinctrl_spi1passthru_default>;
};

I would assume this should have SPI1 in passthru mode connected to the
host (SCU70[13:12] = 0x3), which is indeed the case:

$ echo $(( ($(devmem 0x1e6e2070 32) >> 12) & 0x3 ))
3

The host boots by default, which is again the desired behavior. I can
switch SPI1 control to master through pinmux-select:
$ echo SPI1 SPI1 >
/sys/kernel/debug/pinctrl/1e6e2080.pinctrl-aspeed-g5-pinctrl/pinmux-select
$ echo $(( ($(devmem 0x1e6e2070 32) >> 12) & 0x3 ))
1

However, I cannot access the device. '/dev/mtd6' doesn't exist, and I
cannot bind it:
$  echo 1e630000.spi >/sys/bus/platform/drivers/aspeed-smc/bind
-sh: echo: write error: No such file or directory

I'm probably missing something obvious but not sure what.
Thanks again, and sorry for the long winded reply.

On Tue, Mar 29, 2022 at 10:08 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Wed, 30 Mar 2022, at 04:27, Ali El-Haj-Mahmoud wrote:
> > Thanks for the reply Andrew.
> >
> >> Not explicitly as I mentioned. You're also going to run into the
> >> constraints here:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c?h=v5.17#n2739
> >>
> >> Fundamentally that needs to be changed. We could do something like have
> >> it default to pass-through unless a driver is bound.
> >
> > Could you please elaborate on this a bit? I'm way out of my depth here
> > and would appreciate any additional pointers.
> >
> > I already ran into the read-only constraints in the pinctrl driver,
> > and I have a patch that excludes SCU70[13:12], but that wasn't enough.
>
> What were you doing to test it?
