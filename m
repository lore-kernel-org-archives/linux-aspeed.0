From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 09 Oct 2024 11:57:07 +1030
Subject: [PATCH v4 2/2] ARM: dts: aspeed: sbp1: IBM sbp1 BMC board
In-Reply-To: <20241008111924.1865857-2-naresh.solanki@9elements.com>
References: <20241008111924.1865857-1-naresh.solanki@9elements.com>
	 <20241008111924.1865857-2-naresh.solanki@9elements.com>
Message-ID: <e4dd331944168257bfd2f4239d24317424da7b9c.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Naresh,

On Tue, 2024-10-08 at 16:49 +0530, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add a device tree for IBM sbp1 BMC board which is based on AST2600 SOC.
> 
> sbp1 baseboard has:
> - support for up to four Sapphire Rapids sockets having 16 DIMMS each.
>   - 240 core/480 threads at maximum
> - 32x CPU PCIe slots
> - 2x M.2 PCH PCIe slots
> - Dual 200Gbit/s NIC
> - SPI TPM
> 
> Added the following:
> - Indication LEDs
> - I2C mux & GPIO controller, pin assignments,
> - Thermister,
> - Voltage regulator
> - EEPROM/VPD
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> 
> ---
> Changes in V4:
> - Move reset related entried under mdio to phy.
> - Removed reserved gpio range.
> Changes in V3:
> Drop unused regulator entries which are not used by drivers.
> Decouple p12v_a
> Update pincfg for U62120
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |    1 +
>  .../boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts   | 6128 +++++++++++++++++
>  2 files changed, 6129 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index c4f064e4b073..577cc6754c45 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -41,6 +41,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-ibm-rainier-1s4u.dtb \
>  	aspeed-bmc-ibm-rainier-4u.dtb \
>  	aspeed-bmc-ibm-system1.dtb \
> +	aspeed-bmc-ibm-sbp1.dtb \

Please keep this list sorted alphabetically.

>  	aspeed-bmc-intel-s2600wf.dtb \
>  	aspeed-bmc-inspur-fp5280g2.dtb \
>  	aspeed-bmc-inspur-nf5280m6.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
> new file mode 100644
> index 000000000000..6036a9ca3840
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
> 
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	bmc_mux_nic: mux at 77 {
> +		compatible = "maxim,max7357";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reset-gpios = <&gpio0 ASPEED_GPIO(R, 3) (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
> +		vdd-supply = <&p3v3_aux>;
> +
> +		i2c at 0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			smb_pex_nic: pinctrl at 20 {
> 
...
> +			};
> +		};
> +
> +		i2c at 1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c at 2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ir38263-pvcore-nic2 at 40 {
> +				compatible = "infineon,ir38263";
> +				reg = <0x40>;
> +
> +				regulators {
> +					pvcore_nic2: vout {
> +						regulator-name = "pvcore_nic2";
> +						regulator-enable-ramp-delay = <2000>;
> +						vin-supply = <&p12v>;
> +					};
> +				};
> +			};

This doesn't match my understanding of the infineon,ir38263 and
regulator bindings. Certainly `make CHECK_DTBS=y ...` complains about
it.

This is untested, but from my understanding, it should rather be
something like:

   pvcore_nic2: regulator at 40 {
       compatible = "infineon,ir38263";
       reg = <0x40>;
   
       regulator-name = "pvcore_nic2";
       regulator-enable-ramp-delay = <2000>;
       vin-supply = <&p12v>;
   };

Note that this is _not_ the same as the maxim,max5978 binding, which
_does_ specify the regulators subnode.

Please fix all infineon,ir38263 nodes in the dts.

...

> +
> +		i2c-protocol;
> +	};
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +
> +	i2cmux2: mux at 77 {
> +		compatible = "maxim,max7357";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reset-gpios = <&gpio0 ASPEED_GPIO(Z, 2) (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
> +		vdd-supply = <&p3v3_aux>;
> +
> +		i2c at 1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			r38263-p1v05-pch-aux at 40 {
> +				compatible = "infineon,ir38263";
> +				reg = <0x40>;
> +
> +				interrupt-parent = <&smb_pex_vr_ctrl>;
> +				interrupts = <9 IRQ_TYPE_LEVEL_LOW>;

Aside from the regulators subnode issue, the infineon,ir38263 binding
doensn't specify interrupt properties. Does it need to be updated?

Otherwise, we have the following warning:

   r38263-p1v05-pch-aux at 40: Unevaluated properties are not allowed ('interrupt-parent', 'interrupts', 'regulators' were unexpected)

> +
> +				regulators {
> +					p1v05_pch_aux: vout {
> +						regulator-name = "p1v05_pch_aux";
> +						regulator-enable-ramp-delay = <2000>;
> +						vin-supply = <&p12v>;
> +					};
> +				};
> +			};
> +		};
> +
> +		i2c at 2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ir38060-p1v8-pch-aux at 40 {
> +				compatible = "infineon,ir38060";
> +				reg = <0x40>;
> +
> +				interrupt-parent = <&smb_pex_vr_ctrl>;
> +				interrupts = <32 IRQ_TYPE_LEVEL_LOW>;

As above.

Andrew
