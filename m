From: Joel Stanley <joel@jms.id.au>
Date: Thu, 5 Aug 2021 00:28:02 +0000
Subject: [PATCH 6/6] ARM: dts: aspeed: Add Facebook Fuji (AST2600) BMC
In-Reply-To: <20210728233755.17963-7-rentao.bupt@gmail.com>
References: <20210728233755.17963-1-rentao.bupt@gmail.com>
 <20210728233755.17963-7-rentao.bupt@gmail.com>
Message-ID: <CACPK8XemZkV7nK_b4883DN+dJKhL=tXfqK6=DpHQe=fZRu_ETQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 28 Jul 2021 at 23:38, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> Add initial version of device tree for Facebook Fuji (AST2600) BMC.

I like to read what kind of platform the BMC is going into if you can
add that detail, but it's not essential.

> +&spi1 {
> +       status = "okay";
> +
> +       /*
> +        * Customize spi1 flash memory size to 32MB (maximum flash size on
> +        * the bus) to save vmalloc space.
> +        */
> +       reg = < 0x1e630000 0xc4
> +               0x30000000 0x2000000 >;

Which driver supports this?

It would be great to see Facebook work to get the SPI NOR driver for
the ast2600 merged to mainline.

I doubt the IBM team will get to this, as we are using eMMC instead.

> +
> +       flash at 0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "spi1.0";
> +               spi-max-frequency = <5000000>;
> +
> +               partitions {
> +                       compatible = "fixed-partitions";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +
> +                       flash1 at 0 {
> +                               reg = <0x0 0x2000000>;
> +                               label = "system-flash";
> +                       };
> +               };
> +       };
> +};

> +&ehci1 {
> +       status = "okay";
> +};

Have you verified that USB works with mainline? I've had reports of it
working on 5.8 but it seems to have regressed as of v5.10.


> +&mdio1 {
> +       status = "okay";
> +
> +       ethphy3: ethernet-phy at 13 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <0x0d>;
> +       };
> +};
> +
> +&mac3 {
> +       phy-handle = <&ethphy3>;

status = okay?

You should specify the pinmux too I think, even if the default happens
to work, so that other devices cannot claim the pins.

Cheers,

Joel
