From: Joel Stanley <joel@jms.id.au>
Date: Thu, 2 May 2024 17:59:50 +0930
Subject: [PATCH v3 0/3] ARM: dts: aspeed: Add ASRock E3C256D4I BMC
In-Reply-To: <20240502002836.17862-5-zev@bewilderbeest.net>
References: <20240502002836.17862-5-zev@bewilderbeest.net>
Message-ID: <CACPK8Xe9BcFziQTKA2FrQq6GT1aWeSirDrWTNBh8b+HwcZzctg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2 May 2024 at 09:59, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> Hello,
>
> These patches add a device-tree (and a couple tiny bindings updates)
> for the Aspeed BMC on the ASRock E3C256D4I, so that it can be added as
> a supported OpenBMC platform.

Thanks! Applied and pushed out.

>
> Changes since v2 [1]:
>  - Added patch 1 adding isl69269 to trivial-devices.yml
>  - Adjusted isl69269 compat string to use isil vendor prefix instead
>    of renesas, dropped unprefixed entry
>
> Changes since v1 [0]:
>  - Removed bootargs [Krzysztof]
>  - Renamed LED nodes [Krzysztof]
>  - Added function & color properties to LED nodes
>  - Added #address-cells and #size-cells to FRU eeprom node
>
> [0] https://lore.kernel.org/lkml/20231114112722.28506-4-zev at bewilderbeest.net/
> [1] https://lore.kernel.org/lkml/20231120121954.19926-4-zev at bewilderbeest.net/
>
> Thanks,
> Zev
>
>
> Zev Weiss (3):
>   dt-bindings: trivial-devices: add isil,isl69269
>   dt-bindings: arm: aspeed: document ASRock E3C256D4I
>   ARM: dts: aspeed: Add ASRock E3C256D4I BMC
>
>  .../bindings/arm/aspeed/aspeed.yaml           |   1 +
>  .../devicetree/bindings/trivial-devices.yaml  |   2 +
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../aspeed/aspeed-bmc-asrock-e3c256d4i.dts    | 322 ++++++++++++++++++
>  4 files changed, 326 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
>
> --
> 2.44.0
>
