From: Joel Stanley <joel@jms.id.au>
Date: Tue, 19 Oct 2021 06:46:34 +0000
Subject: [PATCH v2 2/3] ARM: dts: aspeed: mtjade: Add I2C buses for NVMe
 devices
In-Reply-To: <20211019060155.945-3-quan@os.amperecomputing.com>
References: <20211019060155.945-1-quan@os.amperecomputing.com>
 <20211019060155.945-3-quan@os.amperecomputing.com>
Message-ID: <CACPK8Xe645Me=NnjKP8L40a+ADT1FteL==b7SRNPAGM=K9UC3g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 19 Oct 2021 at 06:02, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>
> This commit adds configuration i2c busses for 24 NVMe slots and
> 2 M2 NVMe slots found on Mt.Jade hardware reference platform
> with Ampere's Altra processor family.
>
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
> v2:
>   + Introduced in v2
>
>  .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 258 ++++++++++++++++++
>  1 file changed, 258 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> index 3515d55bd312..723c7063c223 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> @@ -7,6 +7,50 @@ / {
>         model = "Ampere Mt. Jade BMC";
>         compatible = "ampere,mtjade-bmc", "aspeed,ast2500";
>
> +       aliases {
> +               /*
> +                *  i2c bus 50-57 assigned to NVMe slot 0-7
> +                */
> +               i2c50 = &nvmeslot_0;
> +               i2c51 = &nvmeslot_1;
> +               i2c52 = &nvmeslot_2;
> +               i2c53 = &nvmeslot_3;
> +               i2c54 = &nvmeslot_4;
> +               i2c55 = &nvmeslot_5;
> +               i2c56 = &nvmeslot_6;
> +               i2c57 = &nvmeslot_7;
> +
> +               /*
> +                *  i2c bus 60-67 assigned to NVMe slot 8-15
> +                */
> +               i2c60 = &nvmeslot_8;
> +               i2c61 = &nvmeslot_9;
> +               i2c62 = &nvmeslot_10;
> +               i2c63 = &nvmeslot_11;
> +               i2c64 = &nvmeslot_12;
> +               i2c65 = &nvmeslot_13;
> +               i2c66 = &nvmeslot_14;
> +               i2c67 = &nvmeslot_15;
> +
> +               /*
> +                *  i2c bus 70-77 assigned to NVMe slot 16-23
> +                */
> +               i2c70 = &nvmeslot_16;
> +               i2c71 = &nvmeslot_17;
> +               i2c72 = &nvmeslot_18;
> +               i2c73 = &nvmeslot_19;
> +               i2c74 = &nvmeslot_20;
> +               i2c75 = &nvmeslot_21;
> +               i2c76 = &nvmeslot_22;
> +               i2c77 = &nvmeslot_23;
> +
> +               /*
> +                *  i2c bus 80-81 assigned to NVMe M2 slot 0-1
> +                */
> +               i2c80 = &nvme_m2_0;
> +               i2c81 = &nvme_m2_1;
> +       };
> +
>         chosen {
>                 stdout-path = &uart5;
>                 bootargs = "console=ttyS4,115200 earlycon";
> @@ -445,6 +489,220 @@ rtc at 51 {
>
>  &i2c5 {
>         status = "okay";
> +       i2c-mux at 70 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x70>;
> +               i2c-mux-idle-disconnect;
> +
> +               nvmeslot_0_7: i2c at 3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +               };
> +       };
> +
> +       i2c-mux at 71 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x71>;
> +               i2c-mux-idle-disconnect;
> +
> +               nvmeslot_8_15: i2c at 4 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x4>;
> +               };
> +
> +               nvmeslot_16_23: i2c at 3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +               };
> +
> +       };
> +
> +       i2c-mux at 72 {
> +               compatible = "nxp,pca9545";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x72>;
> +               i2c-mux-idle-disconnect;
> +
> +               nvme_m2_0: i2c at 0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0>;
> +               };
> +
> +               nvme_m2_1: i2c at 1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x1>;
> +               };
> +       };
> +};
> +
> +&nvmeslot_0_7 {
> +       status = "okay";
> +
> +       i2c-mux at 75 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x75>;
> +               i2c-mux-idle-disconnect;
> +
> +               nvmeslot_0: i2c at 0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0>;
> +               };
> +               nvmeslot_1: i2c at 1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x1>;
> +               };
> +               nvmeslot_2: i2c at 2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +               };
> +               nvmeslot_3: i2c at 3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +               };
> +               nvmeslot_4: i2c at 4 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x4>;
> +               };
> +               nvmeslot_5: i2c at 5 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x5>;
> +               };
> +               nvmeslot_6: i2c at 6 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x6>;
> +               };
> +               nvmeslot_7: i2c at 7 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x7>;
> +               };
> +
> +       };
> +};
> +
> +&nvmeslot_8_15 {
> +       status = "okay";
> +
> +       i2c-mux at 75 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x75>;
> +               i2c-mux-idle-disconnect;
> +
> +               nvmeslot_8: i2c at 0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0>;
> +               };
> +               nvmeslot_9: i2c at 1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x1>;
> +               };
> +               nvmeslot_10: i2c at 2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +               };
> +               nvmeslot_11: i2c at 3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +               };
> +               nvmeslot_12: i2c at 4 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x4>;
> +               };
> +               nvmeslot_13: i2c at 5 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x5>;
> +               };
> +               nvmeslot_14: i2c at 6 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x6>;
> +               };
> +               nvmeslot_15: i2c at 7 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x7>;
> +               };
> +       };
> +};
> +
> +&nvmeslot_16_23 {
> +       status = "okay";
> +
> +       i2c-mux at 75 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x75>;
> +               i2c-mux-idle-disconnect;
> +
> +               nvmeslot_16: i2c at 0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0>;
> +               };
> +               nvmeslot_17: i2c at 1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x1>;
> +               };
> +               nvmeslot_18: i2c at 2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +               };
> +               nvmeslot_19: i2c at 3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +               };
> +               nvmeslot_20: i2c at 4 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x4>;
> +               };
> +               nvmeslot_21: i2c at 5 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x5>;
> +               };
> +               nvmeslot_22: i2c at 6 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x6>;
> +               };
> +               nvmeslot_23: i2c at 7 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x7>;
> +               };
> +       };
>  };
>
>  &i2c6 {
> --
> 2.28.0
>
