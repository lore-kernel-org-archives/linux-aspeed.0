From: Rob Herring <robh@kernel.org>
Date: Wed, 26 Jun 2024 07:38:13 -0600
Subject: [PATCH v1 00/17] Revise Facebook Minerva BMC DTS
In-Reply-To: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
Message-ID: <CAL_JsqL-b==HMLJGd_e-43yZHjBFYrrLV5J2a=E2LSEck=ii6w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 26, 2024 at 7:05?AM Yang Chen <yangchen.openbmc@gmail.com> wrote:
>
> Revise the Linux device tree entry related to Facebook platform Minerva
> specific devices connected to the Aspeed AST2600 BMC.
>
> Changelog:
> - v1:

You already sent v1. This is v2.

>   - Modify the properties of spi to match the schema.
>
> Yang Chen (17):
>   ARM: dts: aspeed: minerva: change the address of tmp75
>   ARM: dts: aspeed: minerva: change aliases for uart
>   ARM: dts: aspeed: minerva: add eeprom on i2c bus
>   ARM: dts: aspeed: minerva: change RTC reference
>   ARM: dts: aspeed: minerva: enable mdio3
>   ARM: dts: aspeed: minerva: remove unused bus and device
>   ARM: dts: aspeed: minerva: Define the LEDs node name
>   ARM: dts: aspeed: minerva: Add adc sensors for fan board
>   ARM: dts: aspeed: minerva: add linename of two pins
>   ARM: dts: aspeed: minerva: enable ehci0 for USB
>   ARM: dts: aspeed: minerva: add tmp75 sensor
>   ARM: dts: aspeed: minerva: add power monitor xdp710
>   ARM: dts: aspeed: minerva: revise sgpio line name
>   ARM: dts: aspeed: minerva: Switch the i2c bus number
>   ARM: dts: aspeed: minerva: remove unused power device
>   ARM: dts: aspeed: minerva: add ltc4287 device
>   ARM: dts: aspeed: minerva: Add spi-gpio
>
>  .../aspeed/aspeed-bmc-facebook-minerva.dts    | 516 +++++++++++++-----
>  1 file changed, 373 insertions(+), 143 deletions(-)
>
> --
> 2.34.1
>
>
