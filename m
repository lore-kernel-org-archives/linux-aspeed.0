From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Oct 2023 12:22:26 +1030
Subject: [PATCH 7/7] ARM: dts: aspeed: mtmitchell: Add I2C NVMe alias port
In-Reply-To: <20231005035525.19036-8-chanh@os.amperecomputing.com>
References: <20231005035525.19036-1-chanh@os.amperecomputing.com> <20231005035525.19036-8-chanh@os.amperecomputing.com>
Message-ID: <CACPK8XehearTYQrmKTwwCB=Gvgur25Zr+UkgxzJW-7KKbJ9U7w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 at 14:26, Chanh Nguyen <chanh@os.amperecomputing.com> wrote:
>
> Adds the I2C alias ports to each NVMe drive via the
> backplane card.
>
> Besides that, it also adds the eeprom and temperature sensor
> on the backplane card.
>
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 267 ++++++++++++++++++
>  1 file changed, 267 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> index eb8d5e367276..1f70e3e4e83b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> @@ -14,6 +14,42 @@
>         aliases {
>                 serial7 = &uart8;
>                 serial8 = &uart9;
> +
> +               /*
> +                *  I2C NVMe alias port
> +                */
> +               i2c100 = &backplane_0;
> +               i2c48 = &nvmeslot_0;
> +               i2c49 = &nvmeslot_1;
> +               i2c50 = &nvmeslot_2;
> +               i2c51 = &nvmeslot_3;
> +               i2c52 = &nvmeslot_4;
> +               i2c53 = &nvmeslot_5;
> +               i2c54 = &nvmeslot_6;
> +               i2c55 = &nvmeslot_7;
> +
> +               i2c101 = &backplane_1;
> +               i2c56 = &nvmeslot_8;
> +               i2c57 = &nvmeslot_9;
> +               i2c58 = &nvmeslot_10;
> +               i2c59 = &nvmeslot_11;
> +               i2c60 = &nvmeslot_12;
> +               i2c61 = &nvmeslot_13;
> +               i2c62 = &nvmeslot_14;
> +               i2c63 = &nvmeslot_15;
> +
> +               i2c102 = &backplane_2;
> +               i2c64 = &nvmeslot_16;
> +               i2c65 = &nvmeslot_17;
> +               i2c66 = &nvmeslot_18;
> +               i2c67 = &nvmeslot_19;
> +               i2c68 = &nvmeslot_20;
> +               i2c69 = &nvmeslot_21;
> +               i2c70 = &nvmeslot_22;
> +               i2c71 = &nvmeslot_23;
> +
> +               i2c80 = &nvme_m2_0;
> +               i2c81 = &nvme_m2_1;
>         };
>
>         chosen {
> @@ -534,6 +570,237 @@
>
>  &i2c9 {
>         status = "okay";
> +       i2c-mux at 70 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x70>;
> +               i2c-mux-idle-disconnect;
> +
> +               backplane_1: i2c at 0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0>;
> +
> +                       eeprom at 50 {
> +                               compatible = "atmel,24c64";
> +                               reg = <0x50>;
> +                               pagesize = <32>;
> +                       };
> +
> +                       i2c-mux at 71 {
> +                               compatible = "nxp,pca9548";
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               reg = <0x71>;
> +                               i2c-mux-idle-disconnect;
> +
> +                               nvmeslot_8: i2c at 0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x0>;
> +                               };
> +                               nvmeslot_9: i2c at 1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x1>;
> +                               };
> +                               nvmeslot_10: i2c at 2 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x2>;
> +                               };
> +                               nvmeslot_11: i2c at 3 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x3>;
> +                               };
> +                               nvmeslot_12: i2c at 4 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x4>;
> +                               };
> +                               nvmeslot_13: i2c at 5 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x5>;
> +                               };
> +                               nvmeslot_14: i2c at 6 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x6>;
> +                               };
> +                               nvmeslot_15: i2c at 7 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x7>;
> +                               };
> +                       };
> +
> +                       tmp432 at 4c {
> +                               compatible = "ti,tmp75";
> +                               reg = <0x4c>;
> +                       };
> +               };
> +
> +               backplane_2: i2c at 2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +
> +                       eeprom at 50 {
> +                               compatible = "atmel,24c64";
> +                               reg = <0x50>;
> +                               pagesize = <32>;
> +                       };
> +
> +                       i2c-mux at 71 {
> +                               compatible = "nxp,pca9548";
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               reg = <0x71>;
> +                               i2c-mux-idle-disconnect;
> +
> +                               nvmeslot_16: i2c at 0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x0>;
> +                               };
> +                               nvmeslot_17: i2c at 1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x1>;
> +                               };
> +                               nvmeslot_18: i2c at 2 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x2>;
> +                               };
> +                               nvmeslot_19: i2c at 3 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x3>;
> +                               };
> +                               nvmeslot_20: i2c at 4 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x4>;
> +                               };
> +                               nvmeslot_21: i2c at 5 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x5>;
> +                               };
> +                               nvmeslot_22: i2c at 6 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x6>;
> +                               };
> +                               nvmeslot_23: i2c at 7 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x7>;
> +                               };
> +                       };
> +
> +                       tmp432 at 4c {
> +                               compatible = "ti,tmp75";
> +                               reg = <0x4c>;
> +                       };
> +               };
> +
> +               backplane_0: i2c at 4 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x4>;
> +
> +                       eeprom at 50 {
> +                               compatible = "atmel,24c64";
> +                               reg = <0x50>;
> +                               pagesize = <32>;
> +                       };
> +
> +                       i2c-mux at 71 {
> +                               compatible = "nxp,pca9548";
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               reg = <0x71>;
> +                               i2c-mux-idle-disconnect;
> +
> +                               nvmeslot_0: i2c at 0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x0>;
> +                               };
> +                               nvmeslot_1: i2c at 1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x1>;
> +                               };
> +                               nvmeslot_2: i2c at 2 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x2>;
> +                               };
> +                               nvmeslot_3: i2c at 3 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x3>;
> +                               };
> +                               nvmeslot_4: i2c at 4 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x4>;
> +                               };
> +                               nvmeslot_5: i2c at 5 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x5>;
> +                               };
> +                               nvmeslot_6: i2c at 6 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x6>;
> +                               };
> +                               nvmeslot_7: i2c at 7 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x7>;
> +                               };
> +                       };
> +
> +                       tmp432 at 4c {
> +                               compatible = "ti,tmp75";
> +                               reg = <0x4c>;
> +                       };
> +               };
> +
> +               i2c at 7 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x7>;
> +
> +                       i2c-mux at 71 {
> +                               compatible = "nxp,pca9546";
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               reg = <0x71>;
> +                               i2c-mux-idle-disconnect;
> +
> +                               nvme_m2_0: i2c at 0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x0>;
> +                               };
> +
> +                               nvme_m2_1: i2c at 1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0x1>;
> +                               };
> +                       };
> +               };
> +       };
>  };
>
>  &i2c11 {
> --
> 2.17.1
>
