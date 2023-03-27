From: Joel Stanley <joel@jms.id.au>
Date: Mon, 27 Mar 2023 00:46:33 +0000
Subject: [PATCH v3 4/4] ARM: dts: aspeed: bonnell: Add DIMM SPD
In-Reply-To: <20230322140348.569397-5-eajames@linux.ibm.com>
References: <20230322140348.569397-1-eajames@linux.ibm.com> <20230322140348.569397-5-eajames@linux.ibm.com>
Message-ID: <CACPK8XfJr03L43KbWcZ44nAiVhpPF8Pao2OM4R2F36b=bkQ-fQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 22 Mar 2023 at 14:04, Eddie James <eajames@linux.ibm.com> wrote:
>
> Add the DIMM SPD to the processor I2C busses.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I will take this through the aspeed tree.

> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> index 79516dc21c01..ab99d915b50e 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> @@ -232,18 +232,38 @@ cfam0_i2c1: i2c-bus at 1 {
>
>                         cfam0_i2c10: i2c-bus at a {
>                                 reg = <10>;     /* OP3A */
> +
> +                               eeprom at 50 {
> +                                       compatible = "atmel,at30tse004a";
> +                                       reg = <0x50>;
> +                               };
>                         };
>
>                         cfam0_i2c11: i2c-bus at b {
>                                 reg = <11>;     /* OP3B */
> +
> +                               eeprom at 50 {
> +                                       compatible = "atmel,at30tse004a";
> +                                       reg = <0x50>;
> +                               };
>                         };
>
>                         cfam0_i2c12: i2c-bus at c {
>                                 reg = <12>;     /* OP4A */
> +
> +                               eeprom at 50 {
> +                                       compatible = "atmel,at30tse004a";
> +                                       reg = <0x50>;
> +                               };
>                         };
>
>                         cfam0_i2c13: i2c-bus at d {
>                                 reg = <13>;     /* OP4B */
> +
> +                               eeprom at 50 {
> +                                       compatible = "atmel,at30tse004a";
> +                                       reg = <0x50>;
> +                               };
>                         };
>
>                         cfam0_i2c14: i2c-bus at e {
> --
> 2.31.1
>
