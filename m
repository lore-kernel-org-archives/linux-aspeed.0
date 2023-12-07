From: Joel Stanley <joel@jms.id.au>
Date: Thu, 7 Dec 2023 10:40:17 +1030
Subject: [PATCH v6 2/2] ARM: dts: aspeed: Harma: Add Facebook Harma
 (AST2600) BMC
In-Reply-To: <20231206155316.4181813-3-peteryin.openbmc@gmail.com>
References: <20231206155316.4181813-1-peteryin.openbmc@gmail.com> <20231206155316.4181813-3-peteryin.openbmc@gmail.com>
Message-ID: <CACPK8XepWC+KUaYr8nQJ9ggkX5n=aQzT_U5+u_N86=LthkbwDw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 at 02:25, Peter Yin <peteryin.openbmc@gmail.com> wrote:
>
> Add linux device tree entry related to
> Harma specific devices connected to BMC SoC.

This isn't a very helpful commit message. Convention is to mention
what the system is to give context; eg "The SuperCorp Machine1
multi-node server system uses an AST2600 BMC".

> +&mac3 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii4_default>;
> +       no-hw-checksum;
> +       use-ncsi;
> +       ncsi-ctrl,start-redo-probe;
> +       ncsi-ctrl,no-channel-monitor;
> +       mlx,multi-host;
> +       ncsi-package = <1>;
> +       ncsi-channel = <1>;
> +       ncsi-rexmit = <1>;
> +       ncsi-timeout = <2>;

These properties are not supported by the kernel. It seems Facebook
uses them in their machines, it would be great if you contributed
support for them to mainline.

If not, please drop the properties.

> +
> +&gpio0 {
> +       pinctrl-names = "default";
> +       gpio-line-names =
> +       /*A0-A7*/       "","","","","","","","",
> +       /*B0-B7*/       "","","","",
> +                       "FM_BMC_MUX_CS_SPI_SEL_0","FM_ID_LED_N","","",
> +       /*C0-C7*/       "","","","","","","","",
> +       /*D0-D7*/       "","","SOL_UART_SET","","","","","",
> +       /*E0-E7*/       "","","","","","","","",
> +       /*F0-F7*/       "","","","","","","","",
> +       /*G0-G7*/       "","","","","","","","",
> +       /*H0-H7*/       "","","","","","","","",
> +       /*I0-I7*/       "","","","","","","","",
> +       /*J0-J7*/       "","","","","","","","",
> +       /*K0-K7*/       "","","","","","","","",
> +       /*L0-L7*/       "","","","","","","","",
> +       /*M0-M7*/       "","","","","","","","",
> +       /*N0-N7*/       "LED_POSTCODE_0","LED_POSTCODE_1",
> +                       "LED_POSTCODE_2","LED_POSTCODE_3",
> +                       "LED_POSTCODE_4","LED_POSTCODE_5",
> +                       "LED_POSTCODE_6","LED_POSTCODE_7",
> +       /*O0-O7*/       "","","","","","","","",
> +       /*P0-P7*/       "FP_SYS_PWRBTN_IN_N","BMC_SYS_PWRBTN_OUT_N",

Is this machine going to run openbmc?

We have a set of documented properties for GPIOs such as the power button:

https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md

If you intentionally do not want to follow this scheme, please mention
why in your commit message.

Cheers,

Joel
