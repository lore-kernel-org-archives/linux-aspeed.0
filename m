From: Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Sep 2020 02:41:49 +0000
Subject: [PATCH v3 4/5] ARM: dts: Aspeed: Tacoma: Add IBM Operation Panel
 I2C device
In-Reply-To: <20200909203059.23427-5-eajames@linux.ibm.com>
References: <20200909203059.23427-1-eajames@linux.ibm.com>
 <20200909203059.23427-5-eajames@linux.ibm.com>
Message-ID: <CACPK8XdSUAiShnY2CZOb8_6YfaMxXnbUg0k=mWctYbRWEUpyBg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2020 at 20:31, Eddie James <eajames@linux.ibm.com> wrote:
>
> Set I2C bus 0 to multi-master mode and add the panel device that will
> register as a slave.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Applied to the aspeed tree for v5.10.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> index 5f4ee67ac787..4d070d6ba09f 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> @@ -4,6 +4,7 @@
>
>  #include "aspeed-g6.dtsi"
>  #include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
>  #include <dt-bindings/leds/leds-pca955x.h>
>
>  / {
> @@ -438,7 +439,13 @@ aliases {
>  };
>
>  &i2c0 {
> +       multi-master;
>         status = "okay";
> +
> +       ibm-panel at 62 {
> +               compatible = "ibm,op-panel";
> +               reg = <(0x62 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
>  };
>
>  &i2c1 {
> --
> 2.26.2
>
