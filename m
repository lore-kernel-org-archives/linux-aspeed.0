From: Joel Stanley <joel@jms.id.au>
Date: Thu, 19 May 2022 02:46:43 +0000
Subject: [PATCH] ARM: dts: aspeed: Adding Jabil Rubypass BMC
In-Reply-To: <20220420065538.4070503-1-David_Wang6097@jabil.com>
References: <20220420065538.4070503-1-David_Wang6097@jabil.com>
Message-ID: <CACPK8XdXHsvzAgnX5VjqtznakEmRhcokb66yOYkhr8v+vWKXJg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 20 Apr 2022 at 06:55, David Wang <David_Wang6097@jabil.com> wrote:
>
> The initial introduction of the jabil server with AST2600 BMC SoC.
>
> Signed-off-by: David Wang <David_Wang6097@jabil.com>
> ---
>  .../boot/dts/aspeed-bmc-jabil-rubypass.dts    | 383 ++++++++++++++++++
>  1 file changed, 383 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
> new file mode 100644
> index 000000000000..80763ff48b2a
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
> @@ -0,0 +1,383 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +       model = "Jabil Boy";
> +       compatible = "aspeed,ast2600";

add a string for your machine. Something like this:

compatible = "jabil,boy",  "aspeed,ast2600";

> +
> +       aliases {
> +               serial4 = &uart5;

This is in the dsti, so it's not required.

> +       };
> +
> +       chosen {
> +               bootargs = "console=ttyS4,115200n8";
> +       };
> +
> +       memory at 80000000 {
> +               device_type = "memory";
> +               reg = <0x80000000 0x80000000>;
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               identify {
> +                       default-state = "off";
> +                       gpios = <&gpio0 ASPEED_GPIO(B, 7) GPIO_ACTIVE_LOW>;
> +               };
> +
> +               status_amber {
> +                       default-state = "off";
> +                       gpios = <&gpio0 ASPEED_GPIO(G, 3) GPIO_ACTIVE_LOW>;
> +               };
> +
> +               status_green {
> +                       default-state = "keep";
> +                       gpios = <&gpio0 ASPEED_GPIO(G, 2) GPIO_ACTIVE_LOW>;
> +               };
> +
> +               status_susack {
> +                       default-state = "off";
> +                       gpios = <&gpio0 ASPEED_GPIO(V, 6) GPIO_ACTIVE_LOW>;
> +               };
> +
> +               fan1_fault{
> +                       default-state = "off";
> +                       gpios = <&gpio3_71 0 GPIO_ACTIVE_HIGH>;
> +               };
> +               fan2_fault{
> +                       default-state = "off"
> +               };
> +               fan3_fault{
> +                       default-state = "off";
> +                       gpios = <&gpio3_71 2 GPIO_ACTIVE_HIGH>;
> +               };
> +               fan4_fault{
> +                       default-state = "off";
> +                       gpios = <&gpio3_71 3 GPIO_ACTIVE_HIGH>;
> +               };
> +               fan5_fault{
> +                       default-state = "off";
> +                       gpios = <&gpio3_71 4 GPIO_ACTIVE_HIGH>;
> +               };
> +               fan6_fault{
> +                       default-state = "off";
> +                       gpios = <&gpio3_71 5 GPIO_ACTIVE_HIGH>;
> +               };
> +
> +               power_amber {
> +                       default-state = "off";
> +                       gpios = <&gpio0 ASPEED_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +};
> +
> +&mdio0 {
> +       status = "okay";
> +
> +       ethphy0: ethernet-phy at 0 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <0>;
> +       };
> +};
> +
> +&mdio1 {
> +       status = "okay";
> +
> +       ethphy1: ethernet-phy at 0 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <0>;
> +       };
> +};
> +
> +&mdio2 {
> +       status = "okay";
> +
> +       ethphy2: ethernet-phy at 0 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <0>;
> +       };
> +};
> +
> +&mdio3 {
> +       status = "okay";
> +
> +       ethphy3: ethernet-phy at 0 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <0>;
> +       };
> +};
> +
> +&mac0 {
> +       status = "okay";
> +
> +       phy-mode = "rgmii-rxid";
> +       phy-handle = <&ethphy0>;
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rgmii1_default>;
> +};
> +
> +
> +&mac1 {
> +       status = "okay";
> +
> +       phy-mode = "rgmii-rxid";
> +       phy-handle = <&ethphy1>;
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rgmii2_default>;
> +};
> +
> +&mac2 {
> +       status = "okay";
> +
> +       phy-mode = "rgmii";
> +       phy-handle = <&ethphy2>;
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rgmii3_default>;
> +};
> +
> +&mac3 {
> +       status = "okay";
> +
> +       phy-mode = "rgmii";
> +       phy-handle = <&ethphy3>;
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rgmii4_default>;
> +};
> +
> +&emmc_controller {
> +       status = "okay";
> +};
> +
> +&emmc {
> +       non-removable;
> +       bus-width = <4>;
> +       max-frequency = <100000000>;
> +       clk-phase-mmc-hs200 = <9>, <225>;
> +};
> +
> +&rtc {
> +       status = "okay";
> +};
> +
> +&fmc {
> +       status = "okay";
> +       flash at 0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "bmc";
> +               spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-128.dtsi"
> +       };
> +};
> +
> +&spi1 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_spi1_default>;
> +
> +       flash at 0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "pnor";
> +               spi-max-frequency = <100000000>;
> +       };
> +};
> +
> +&uart1 {
> +       status = "okay";
> +       pinctrl-0 = <&pinctrl_txd1_default
> +               &pinctrl_rxd1_default
> +               &pinctrl_nrts1_default
> +               &pinctrl_ndtr1_default
> +               &pinctrl_ndsr1_default
> +               &pinctrl_ncts1_default
> +               &pinctrl_ndcd1_default
> +               &pinctrl_nri1_default>;
> +};
> +
> +&uart2 {
> +       status = "okay";
> +       pinctrl-0 = <&pinctrl_txd2_default
> +               &pinctrl_rxd2_default
> +               &pinctrl_nrts2_default
> +               &pinctrl_ndtr2_default
> +               &pinctrl_ndsr2_default
> +               &pinctrl_ncts2_default
> +               &pinctrl_ndcd2_default
> +               &pinctrl_nri2_default>;
> +};
> +
> +&uart3 {
> +       status = "okay";
> +};
> +
> +&uart4 {
> +       status = "okay";
> +};
> +
> +
> +&uart5 {
> +       // Workaround for A0
> +       compatible = "snps,dw-apb-uart";

Are you really on an A0? If not, this can be dropped.

> +};
> +
> +&i2c0 {
> +       status = "okay";
> +
> +       temp at 2e {
> +               compatible = "adi,adt7490";
> +               reg = <0x2e>;
> +       };
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +};
> +
> +&i2c2 {
> +       status = "okay";
> +};
> +
> +&i2c3 {
> +       multi-master;
> +       status = "okay";
> +
> +       gpio at 70 {
> +               compatible = "nxp,pca9538";
> +               reg = <0x70>;
> +               interrupt-parent = <&gpio0>;
> +               interrupts = <ASPEED_GPIO(O, 7) IRQ_TYPE_EDGE_FALLING>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               gpio-line-names =
> +                       "FAN1_PRSNT_N", "FAN2_PRSNT_N", "FAN3_PRSNT_N", "FAN4_PRSNT_N",
> +                       "FAN5_PRSNT_N", "FAN6_PRSNT_N", "FANCTRL1_FANFAIL_N", "FANCTRL2_FANFAIL_N";
> +       };
> +
> +       gpio3_71:gpio at 71 {
> +               compatible = "nxp,pca9538";
> +               reg = <0x71>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               gpio-line-names =
> +                       "LED_FAN1_FAULT", "LED_FAN2_FAULT", "LED_FAN3_FAULT", "LED_FAN4_FAULT",
> +                       "LED_FAN5_FAULT", "LED_FAN6_FAULT", "PU_U12_IO6", "PU_U12_IO7";
> +       };
> +};
> +
> +&i2c4 {
> +       status = "okay";
> +};
> +
> +&i2c5 {
> +       status = "okay";
> +};
> +
> +&i2c6 {
> +       status = "okay";
> +};
> +
> +&i2c7 {
> +       status = "okay";
> +};
> +
> +&i2c8 {
> +       status = "okay";
> +};
> +
> +&i2c9 {
> +       status = "okay";
> +};
> +
> +&i2c12 {
> +       status = "okay";
> +};
> +
> +&i2c13 {
> +       status = "okay";
> +};
> +
> +&i2c14 {
> +       status = "okay";
> +};
> +
> +&i2c15 {
> +       status = "okay";
> +};
> +
> +&fsim0 {
> +       status = "okay";
> +};
> +
> +&ehci1 {
> +       status = "okay";
> +};
> +
> +&uhci {
> +       status = "okay";
> +};
> +
> +&sdc {
> +       status = "okay";
> +};
> +
> +&gpio0 {
> +       status = "okay";
> +       /* Enable GPIOP0 and GPIOP2 pass-through by default */
> +       /* pinctrl-names = "pass-through";                  */
> +       /* pinctrl-0 = <&pinctrl_thru0_default              */
> +       /*              &pinctrl_thru1_default>;            */

Commented out? Unless you have a good reason to keep these like this,
please un-comment or remove them.

> +
> +       gpio-line-names =
> +       /*A0-A7*/       "SMB_DCSCM_I2C2_R_SCL","SMB_DCSCM_I2C2_R_SDA","TP_GPIOA2","TP_GPIOA3","SMB_CPU_PIROM_R_SCL","SMB_CPU_PIROM_R_SDA","SMB_IPMB_STBY_LVC3_R_SCL","SMB_IPMB_STBY_LVC3_R_SDA",
> +       /*B0-B7*/       "NCSI_BMC_I210_NCSI_PRSNT_N","NMI_OUT","IRQ_SMB3_M2_ALERT_N","FM_SPD_SWITCH_CTRL_N","RGMII_BMC_RMM4_LVC3_R_MDC","RGMII_BMC_RMM4_LVC3_R_MDIO","FM_BMC_BMCINIT_R","FP_ID_LED_N",
> +       /*C0-C7*/       "","RMII_BMC_I210_TXEN_R","RMII_BMC_I210_TXD0_R","RMII_BMC_I210_TXD1_R","","","CLK_50M_BMC_MAC3_NCSI","",
> +       /*D0-D7*/       "RMII_BMC_I210_RXD0","RMII_BMC_I210_RXD1","RMII_BMC_I210_CRSDV","RMII_BMC_I210_RXER","","RMII_BMC_OCP3_A_TXEN_R","RMII_BMC_OCP3_A_TXD0_R","RMII_BMC_OCP3_A_TXD1_R",
> +       /*E0-E7*/       "","","CLK_50M_BMC_MAC4_NCSI","","RMII_BMC_OCP3_A_RXD0","RMII_BMC_OCP3_A_RXD1","RMII_BMC_OCP3_A_CRSDV","RMII_BMC_OCP3_A_RXER",
> +       /*F0-F7*/       "","","","","","","ID_BUTTON","PS_PWROK",
> +       /*G0-G7*/       "FM_SMB_BMC_NVME_LVC3_ALERT_N","RST_BMC_I2C_M2_R_N","FP_LED_STATUS_GREEN_N","FP_LED_STATUS_AMBER_N","FM_FORCE_BMC_UPDATE_N","FM_BMC_CRASHLOG_TRIG_N","FM_BMC_CPU_FBRK_OUT_R_N","DBP_PRESENT_IN_R2_N",
> +       /*H0-H7*/       "SGPIO_BMC_FPGA_CLK_R","SGPIO_BMC_FPGA_LD_R_N","SGPIO_BMC_FPGA_DOUT_R","SGPIO_BMC_FPGA_DIN","PLTRST_N","CPU_CATERR","PCH_BMC_THERMTRIP","FM_CPU1_CATERR_N",
> +       /*I0-I7*/       "JTAG_ASD_NTRST_R_N","JTAG_ASD_TDI_R","JTAG_ASD_TCK_R","JTAG_ASD_TMS_R","JTAG_ASD_TDO","FM_BMC_PWRBTN_OUT_R_N","FM_BMC_PWR_BTN_PTHRU_N","TP_FM_BMC_PCH_SCI_R_N",
> +       /*J0-J7*/       "SMB_CHASSENSOR_STBY_LVC3_SCL","SMB_CHASSENSOR_STBY_LVC3_SDA","SMB_FPGA_REG_R_SCL","SMB_FPGA_REG_R_SDA","SMB_DCSCM_I2C12_R_SCL","SMB_DCSCM_I2C12_R_SDA","SMB_BMC_FAN_STBY_LVC3_R_SCL","SMB_BMC_FAN_STBY_LVC3_R_SDA",
> +       /*K0-K7*/       "SMB_HSBP_STBY_LVC3_R_SCL","SMB_HSBP_STBY_LVC3_R_SDA","SMB_SMLINK0_STBY_LVC3_R2_SCL","SMB_SMLINK0_STBY_LVC3_R2_SDA","SMB_TEMPSENSOR_STBY_LVC3_R_SCL","SMB_TEMPSENSOR_STBY_LVC3_R_SDA","SMB_PMBUS_SML1_STBY_LVC3_R_SCL","SMB_PMBUS_SML1_STBY_LVC3_R_SDA",
> +       /*L0-L7*/       "SMB_PCIE_STBY_LVC3_R_SCL","SMB_PCIE_STBY_LVC3_R_SDA","SMB_HOST_STBY_BMC_LVC3_R_SCL","SMB_HOST_STBY_BMC_LVC3_R_SDA","PREQ_N","TCK_MUX_SEL","","",
> +       /*M0-M7*/       "TP_SPA_CTS_N","TP_SPA_DCD_N","TP_SPA_DSR_N","PU_SPA_RI_N","TP_SPA_DTR_N","TP_SPA_RTS_N","SPA_SOUT","SPA_SIN",
> +       /*N0-N7*/       "TP_SPB_CTS_N","TP_SPB_DCD_N","TP_SPB_DSR_N","PU_SPB_RI_N","TP_SPB_DTR_N","TP_SPB_RTS_N","UART_BMC_TXD2","UART_BMC_RXD2",
> +       /*O0-O7*/       "BMC_FPGA_GPIO_0","BMC_FPGA_GPIO_1","BMC_FPGA_GPIO_2","BMC_FPGA_GPIO_3","FM_BMC_PCH_SPARE_R","FM_CPU1_DISABLE_COD_N","NMI_BUTTON","PDB_PCA9538_INT_N",
> +       /*P0-P7*/       "RESET_BUTTON","RESET_OUT","POWER_BUTTON","POWER_OUT","","","DISPLAYPORT_MUX_AUX_R_SEL","BMC_HBLED_N",
> +       /*Q0-Q7*/       "TP_BMC_FAN1_A_TACH","TP_BMC_FAN1_B_TACH","TP_BMC_FAN2_A_TACH","TP_BMC_FAN2_B_TACH","TP_BMC_FAN3_A_TACH","TP_BMC_FAN3_B_TACH","TP_BMC_FAN4_A_TACH","TP_BMC_FAN4_B_TACH",
> +       /*R0-R7*/       "","","","","","FPGA_JTAG_MUX_SEL","DISPLAYPORT_MUX_R_OE","DISPLAYPORT_MUX_DX_R_SEL",
> +       /*S0-S7*/       "RST_BMC_PCIE_MUX_N","BMC_RST_RTCRST_R","PRDY_N","FM_FLASH_SECURITY_STRAP","RST_IPMB_SWITCH_R_N","A_P3V_BAT_SCALED_EN","REMOTE_DEBUG_ENABLE","FM_PCHHOT_N",
> +       /*T0-T7*/       "GND","GND","GND","GND","GND","GND","GND","GND",
> +       /*U0-U7*/       "GND","GND","GND","GND","GND","GND","GND","GND",
> +       /*V0-V7*/       "SIO_S3","SIO_S5","TP_BMC_SIO_PWREQ_N","SIO_ONCONTROL","SIO_POWER_GOOD","LED_BMC_FW_CONFIG_DONE_N","FM_BMC_SUSACK_N","TP_IRQ_BMC_PCH_SMI_LPC_N_R",
> +       /*W0-W7*/       "ESPI_IO0_LPC_LAD0_R","ESPI_IO1_LPC_LAD1_R","ESPI_IO2_LPC_LAD2_R","ESPI_IO3_LPC_LAD3_R","CLK_24M_66M_LPC0_ESPI_BMC","ESPI_CS0_N_LFRAME_N_BMC","IRQ_LPC_SERIRQ_ESPI_ALERT_N","RST_LPC_LRST_ESPI_RST_BMC_R_N",
> +       /*X0-X7*/       "CPU_ERR2","SMI","POST_COMPLETE","TP_SPI_BMC_SAFS_R_CLK","TP_SPI_BMC_SAFS_R_MOSI","TP_SPI_BMC_SAFS_R_MISO","TP_SPI_BMC_SAFS_R_IO2","TP_SPI_BMC_SAFS_R_IO3",
> +       /*Y0-Y7*/       "BMC_PWR_AMB_LED_R_N","IRQ_SML0_ALERT_BMC_R2_N","JTAG_CPLD_BMC_MUX_R_SEL","IRQ_SML1_PMBUS_BMC_ALERT_N","SPI_BMC_BOOT_R_IO2","SPI_BMC_BOOT_R_IO3","PU_SPI_BMC_BOOT_ABR","PU_SPI_BMC_BOOT_WP_N",
> +       /*Z0-Z7*/       "CPU_ERR0","CPU_ERR1","PU_TP_PWRGD_P3V3_RISER2","PU_GPIOZ3","PU_GPIOZ4","PU_GPIOZ5","PU_GPIOZ6","PU_GPIOZ7";

I see you've not used any of the OpenBMC naming conventions for your
GPIOs. Can you explain why?

> +};
> +
> +&gpio1 {
> +       status = "okay";
> +       gpio-line-names = /* GPIO18 A-E */
> +       /*A0-A7*/       "TP_GPIO18B5","TP_GPIO18B4","RST_EMMC_BMC_R_N","","","","","",
> +       /*B0-B7*/       "","","PD_GPIOB2","","RGMII_BMC_RMM4_TX_R_CLK","RGMII_BMC_RMM4_TX_R_CTRL","RGMII_BMC_RMM4_R_TXD0","RGMII_BMC_RMM4_R_TXD1",
> +       /*C0-C7*/       "RGMII_BMC_RMM4_R_TXD2","RGMII_BMC_RMM4_R_TXD3","RGMII_BMC_RMM4_RX_CLK","RGMII_BMC_RMM4_RX_CTRL","RGMII_BMC_RMM4_RXD0","RGMII_BMC_RMM4_RXD1","RGMII_BMC_RMM4_RXD2","RGMII_BMC_RMM4_RXD3",
> +       /*D0-D7*/       "EMMC_BMC_R_CLK","EMMC_BMC_R_CMD","EMMC_BMC_R_DATA0","EMMC_BMC_R_DATA1","EMMC_BMC_R_DATA2","EMMC_BMC_R_DATA3","EMMC_BMC_CD_N","EMMC_BMC_WP_N",
> +       /*E0-E3*/       "EMMC_BMC_R_DATA4","EMMC_BMC_R_DATA5","EMMC_BMC_R_DATA6","EMMC_BMC_R_DATA7";
> +};
> +
> +&lpc_snoop {
> +       snoop-ports = <0x80>;
> +       status = "okay";
> +};
> +
> --
> 2.30.2
>
