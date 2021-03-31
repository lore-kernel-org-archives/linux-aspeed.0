From: Joel Stanley <joel@jms.id.au>
Date: Wed, 31 Mar 2021 07:41:18 +0000
Subject: [PATCH 3/3] ARM: dts: aspeed: add ASRock E3C246D4I BMC
In-Reply-To: <20210330002338.335-4-zev@bewilderbeest.net>
References: <20210330002338.335-1-zev@bewilderbeest.net>
 <20210330002338.335-4-zev@bewilderbeest.net>
Message-ID: <CACPK8XcwMYgc9R24KuGa0hqKQAxawDScHp1+y62aeEvcpvPiSw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 30 Mar 2021 at 00:25, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> This is a relatively low-cost AST2500-based Xeon E-2100/E-2200 series
> mini-ITX board that we hope can provide a decent platform for OpenBMC
> development.
>
> This initial device-tree provides the necessary configuration for
> basic BMC functionality such as host power control, serial console and
> KVM support, and POST code snooping.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  | 188 ++++++++++++++++++
>  1 file changed, 188 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> new file mode 100644
> index 000000000000..27b34c3cf67a
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/{
> +       model = "ASRock E3C246D4I BMC";
> +       compatible = "aspeed,ast2500";

Convention is to add a compatible for the board. I'll add
asrock,e3c246d4Ii-bmc when I apply the patch.

> +&vuart {
> +       status = "okay";
> +       aspeed,sirq-active-high;

We don't have support for this yet, but I'll leave it in and you will
need to send a follow up if the property changes.

Cheers,

Joel
