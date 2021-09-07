From: Joel Stanley <joel@jms.id.au>
Date: Tue, 7 Sep 2021 22:33:05 +0000
Subject: [PATCH] ARM: dts: aspeed: Add TYAN S7106 BMC machine
In-Reply-To: <20210907194931.1173750-1-osk@google.com>
References: <20210907194931.1173750-1-osk@google.com>
Message-ID: <CACPK8Xd-2FeUh3+yeJ7T87Vz8+A94TqiYO1Am0Tk=5nDLbeVQQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 7 Sept 2021 at 19:49, Oskar Senft <osk@google.com> wrote:
>
> The TYAN S7106 is a server platform with an ASPEED AST2500 BMC.

Looks good Oskar. Some minor improvements suggested below.

I'll pull this in to the openbmc tree once it's looking good, so
there's no need to resend it separately in this case.

Please do cc linux-arm-kernel at lists.infradead.org when submitting
patches upstream.

> Signed-off-by: Oskar Senft <osk@google.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts | 415 ++++++++++++++++++++
>  1 file changed, 415 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts

You need to add this to arch/arm/boot/dts/Makefile so it is built.

> diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
> new file mode 100644
> index 000000000000..292bfb1a4bb2
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
> @@ -0,0 +1,415 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +       model = "Tyan S7106 BMC";
> +       compatible = "tyan,s7106-bmc", "aspeed,ast2500";
> +
> +       chosen {
> +               stdout-path = &uart5;
> +               bootargs = "console=ttyS4,115200 earlyprintk";

s/earlyprintk/earlycon/

See 239566b032f3 ("ARM: dts: aspeed: Set earlycon boot argument") for
background.

> +       };
> +
> +       memory at 80000000 {
> +               device_type = "memory";
> +               reg = <0x80000000 0x20000000>;
> +       };
> +
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               p2a_memory: region at 987F0000 {

I think we're standardising on lower case for hex numbers.

> +                       no-map;
> +                       reg = <0x987F0000 0x00010000>; /* 64KB */
> +               };
> +
> +               vga_memory: framebuffer at 9f000000 {
> +                       no-map;
> +                       reg = <0x9f000000 0x01000000>; /* 16M */
> +               };
> +
> +               gfx_memory: framebuffer {
> +                       size = <0x01000000>; /* 16M */
> +                       alignment = <0x01000000>;
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +               };
> +       };

> +&mac0 {
> +       status = "okay";
> +
> +       use-ncsi;
> +       no-hw-checksum;

Are you sure you need no-hw-checksum?

Back in the day we disabled it when using ncsi on the ast2400, as we
thought it was broken when using NCSI. That was not the case:

 commit 6aff0bf641cf69e487d7b46fc8be773d161f814d
 Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
 Date:   Wed Apr 12 13:27:03 2017 +1000

    ftgmac100: Disable HW checksum generation on AST2400, enable on others

    We found out that HW checksum generation only works from AST2500
    onward. This disables it on AST2400 and removes the "no-hw-checksum"
    properties in the device-trees. The problem we had wasn't related
    to NC-SI.

I suggest dropping the property.

> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii1_default>;
> +};

> +&kcs1 {
> +       status = "okay";
> +       kcs_addr = <0xca8>;

This style of kcs binding is deprecated. Instead we use this form:

        aspeed,lpc-io-reg = <0xca8>;

> +};
> +
> +&kcs3 {
> +       status = "okay";
> +       kcs_addr = <0xca2>;
> +};
> +
> +&gfx {
> +       status = "okay";
> +       memory-region = <&gfx_memory>;

This display device is for when the BMC is running to display it's own content.

If the system is only showing the output from the host, then you don't
need this enabled.

> +};
> +
> +&gpio {
> +       status = "okay";
> +       gpio-line-names =
> +       /*A0-A7*/       "","","IDLED_N","","","","","",
> +       /*B0-B7*/       "","","","","","","","",
> +       /*C0-C7*/       "","","","","ID_BUTTON","POST_COMPLETE","","",
> +       /*D0-D7*/       "","","PS_PWROK","PLTRST_N","","","","",
> +       /*E0-E7*/       "POWER_BUTTON","POWER_OUT","RESET_BUTTON","RESET_OUT",
> +                                       "NMI_BUTTON","NMI_OUT","","HEARTBEAT_LED_N",

We have a document that contains names for common BMC GPIOs:

https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md

Ideally your device tree would use them, but given this is an old
platform then I understand if you want to maintain compatibility with
existing userspace.

> +       /*F0-F7*/       "","CLEAR_CMOS_N","","","IPMI_ALERT_LED_N","","","",
> +       /*G0-G7*/       "BMC_PE_SMB_EN_1_N","BMC_PE_SMB_EN_2_N","","","","","","",
> +       /*H0-H7*/       "","","","","","","","",
> +       /*I0-I7*/       "","","","","","","","",
> +       /*J0-J7*/       "","","","","","","","",
> +       /*K0-K7*/       "","","","","","","","",
> +       /*L0-L7*/       "","","","","","","","",
> +       /*M0-M7*/       "","","","","","","","",
> +       /*N0-N7*/       "","","","","","","","",
> +       /*O0-O7*/       "","","","","","","","",
> +       /*P0-P7*/       "","","","","","","","",
> +       /*Q0-Q7*/       "","","","","BMC_PE_SMB_SW_BIT0","BMC_PE_SMB_SW_BIT1","","",
> +       /*R0-R7*/       "","","","","","","","",
> +       /*S0-S7*/       "","","","","","","","",
> +       /*T0-T7*/       "","","","","","","","",
> +       /*U0-U7*/       "","","","","","","","",
> +       /*V0-V7*/       "","","","","","","","",
> +       /*W0-W7*/       "","","","","","","","",
> +       /*X0-X7*/       "","","","","","","","",
> +       /*Y0-Y7*/       "","","","","","","","",
> +       /*Z0-Z7*/   "","","","","","","","",
> +       /*AA0-AA7*/     "","","","BMC_SMB3_PCH_IE_SML3_EN","","","","",
> +       /*AB0-AB7*/     "","","","","","","","";
> +};
> --
> 2.33.0.309.g3052b89438-goog
>
