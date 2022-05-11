From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 May 2022 06:09:33 +0000
Subject: [PATCH 0/6] ARM: dts: aspeed: bletchley: update dts file base on
 DVT schematic
In-Reply-To: <20220509151118.4899-1-potin.lai.pt@gmail.com>
References: <20220509151118.4899-1-potin.lai.pt@gmail.com>
Message-ID: <CACPK8XfXbay7u5kMDgMoyDTO_Le2i4okNUG8sb8_NDepbPRjxA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 9 May 2022 at 15:14, Potin Lai <potin.lai.pt@gmail.com> wrote:
>
> This patch series update Facebook Bletchley BMC devicetree base on DVT
> schematic.
>
> - EHCI: enable ehci0 for detecting and accessing usb device on sled
> - MDIO Bus: enable mdio0 for accessing switch registers
> - SPI2 Flash: switch spi driver back to aspeed-smc to improve performance
> - EEPROM: add eeprom node on each sled
> - GPIO:
>   - add PCA9536 IOEPX node on each sled
>   - update gpio line names

These look fine to me.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Patrick, did you want to review them before I merge?

>
> Potin Lai (6):
>   ARM: dts: aspeed: bletchley: enable ehci0 device node
>   ARM: dts: aspeed: bletchley: switch spi2 driver to aspeed-smc
>   ARM: dts: aspeed: bletchley: Enable mdio0 bus
>   ARM: dts: aspeed: bletchley: update gpio0 line names
>   ARM: dts: aspeed: bletchley: add pca9536 node on each sled
>   ARM: dts: aspeed: bletchley: add eeprom node on each sled
>
>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 180 ++++++++++++++----
>  1 file changed, 145 insertions(+), 35 deletions(-)
>
> --
> 2.17.1
>
