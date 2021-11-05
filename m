From: Joel Stanley <joel@jms.id.au>
Date: Fri, 5 Nov 2021 01:40:05 +0000
Subject: [PATCH v2] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
In-Reply-To: <20211105005955.107419-1-osk@google.com>
References: <20211105005955.107419-1-osk@google.com>
Message-ID: <CACPK8XcXR=V5-Q+sC4MniNJZJgvbiysFD-5yu6v30_2BwDRTSA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 5 Nov 2021 at 01:00, Oskar Senft <osk@google.com> wrote:
>
> This change updates the configuration for the nct7802 hardware
> monitor to correctly configure its temperature sensors.
>
> Signed-off-by: Oskar Senft <osk@google.com>

I applied this and tried comple testing, and got this warning:

  DTC     arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:217.4-14: Warning
(reg_format): /ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 0:reg:
property has invalid length (4 bytes) (#address-cells == 2,
#size-cells == 1)
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:220.4-14: Warning
(reg_format): /ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 1:reg:
property has invalid length (4 bytes) (#address-cells == 2,
#size-cells == 1)
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:226.4-14: Warning
(reg_format): /ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 2:reg:
property has invalid length (4 bytes) (#address-cells == 2,
#size-cells == 1)
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:232.4-14: Warning
(reg_format): /ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 3:reg:
property has invalid length (4 bytes) (#address-cells == 2,
#size-cells == 1)
arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb: Warning (pci_device_reg):
Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb: Warning
(pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb: Warning (i2c_bus_reg):
Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dtb: Warning (spi_bus_reg):
Failed prerequisite 'reg_format'
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:216.13-218.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 0: Relying on
default #address-cells value
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:216.13-218.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 0: Relying on
default #size-cells value
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:219.13-223.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 1: Relying on
default #address-cells value
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:219.13-223.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 1: Relying on
default #size-cells value
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:225.13-229.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 2: Relying on
default #address-cells value
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:225.13-229.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 2: Relying on
default #size-cells value
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:231.13-234.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 3: Relying on
default #address-cells value
../arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts:231.13-234.5: Warning
(avoid_default_addr_size):
/ahb/apb/bus at 1e78a000/i2c-bus at 40/nct7802 at 28/channel at 3: Relying on
default #size-cells value

You need to add this to the nct node:

#address-cells = <1>;
#size-cells = <0>;

Did you see this with your testing? I'm building on top of v5.15 and
my distro's dtc is 1.6.0.

> ---
> Changes from PATCH v1:
> - Removed superfluous "status" from channels.
> ---
>  arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
> index 68f332ee1886..66734e4e2ea1 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
> @@ -213,6 +213,25 @@ &i2c0 {
>         nct7802 at 28 {
>                 compatible = "nuvoton,nct7802";
>                 reg = <0x28>;
> +               channel at 0 { /* LTD */
> +                       reg = <0>;
> +               };
> +               channel at 1 { /* RTD1 */
> +                       reg = <1>;
> +                       sensor-type = "temperature";
> +                       temperature-mode = "thermistor";
> +               };
> +
> +               channel at 2 { /* RTD2 */
> +                       reg = <2>;
> +                       sensor-type = "temperature";
> +                       temperature-mode = "thermistor";
> +               };
> +
> +               channel at 3 { /* RTD3 */
> +                       reg = <3>;
> +                       sensor-type = "temperature";
> +               };
>         };
>
>         /* Also connected to:
> --
> 2.34.0.rc0.344.g81b53c2807-goog
>
