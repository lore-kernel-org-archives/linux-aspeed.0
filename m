From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 28 Mar 2022 10:46:38 +1030
Subject: aspeed2500 SPI1 control at run-time with OpenBMC
In-Reply-To: <CAFPZpNbNc5Fx1tBtmM1x0n-qEB_qp+wSSrR2+_0bxPrPyh1xMw@mail.gmail.com>
References: <CAFPZpNbNc5Fx1tBtmM1x0n-qEB_qp+wSSrR2+_0bxPrPyh1xMw@mail.gmail.com>
Message-ID: <c29de2ea-0f60-4e7f-8308-11849a7de8e8@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ali,

On Sat, 26 Mar 2022, at 01:09, Ali El-Haj-Mahmoud wrote:
> I'm working on an aspeed2500-based system:
> https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts.
>
> We would like to be able to update the host BIOS (SPI1) from the BMC.
> Something along these lines:
>
> - Upload a BIOS image to the BMC. Validate.
> - Power down the host.
> - Switch SPI1 control (SCU70[13:12]) to 'master' to connect to BMC.
> - Flash the new image.
> - Switch SPI1 to 'passthru' to connect back to the host.
> - Power on the host.
>
> I'm able to accomplish this in a debug build using devmem to control
> SCU70[13:12]. However, it seems this should be doable via pinctrl
> instead 
> (https://github.com/torvalds/linux/blob/master/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c#L515-L520),
> but I'm not able to get it to work.

Right, we don't have any support for runtime pinmuxing beyond 
binding/unbinding drivers. Adjusting the mux state on driver 
bind/unbind is handled by the core of the kernel driver model.

A slightly less messy approach is to use the pinmux-select attribute in 
debugfs (still bad though, in that it doesn't require devmem but does 
require debugfs. That's bad for these reasons: 
https://source.android.com/setup/start/android-11-release#debugfs ).

>
> To begin with, a patch similar to
> https://lists.ozlabs.org/pipermail/openbmc/2016-November/005392.html
> is needed to allow modifying SCU70[13:12] via pinctrl.
>
> After that, I'm not sure how to configure SPI1 in the DTS.
>
> With the config below, SPI1 is connected to the BMC, and the host cannot boot:
>
> &spi1 {
> status = "okay";
> pinctrl-names = "default";
> pinctrl-0 = <&pinctrl_spi1_default>;
> pinctrl-1 = <&pinctrl_spi1passthru_default>;
> ...
> };

This won't do what you hope as the pinctrl-N index values must align to 
the mux states in pinctrl-names, so pinctrl-1 is meaningless in this 
case.

>
> I can still switch it to passthru at run time and boot the host, but
> that's not the behavior I'd like:
>
> $ echo SPI1PASSTHRU SPI1PASSTHRU >
> /sys/kernel/debug/pinctrl/1e6e2080.pinctrl-aspeed-g5-pinctrl/pinmux-select
>
> If I switch the order of the pinctrls, SPI1 is connected to the host,
> and I cannot access it from the BMC, even if I try to explicitly
> switch it:
>
> &spi1 {
> status = "okay";
> pinctrl-names = "default";
> pinctrl-0 = <&pinctrl_spi1passthru_default>;
> pinctrl-1 = <&pinctrl_spi1_default>;
> ...
> };
>
> And this has no effect:
> $ echo SPI1 SPI1 >
> /sys/kernel/debug/pinctrl/1e6e2080.pinctrl-aspeed-g5-pinctrl/pinmux-select
>
> Is this use-case supported through pinctrl? Am I missing something here? Thanks!

Not explicitly as I mentioned. You're also going to run into the 
constraints here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c?h=v5.17#n2739

Fundamentally that needs to be changed. We could do something like have 
it default to pass-through unless a driver is bound.

Andrew
