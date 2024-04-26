From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 08:31:00 +0200
Subject: [PATCH v3 12/14] ARM: dts: aspeed: Add IBM P11 FSI devices
In-Reply-To: <20240425213701.655540-13-eajames@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-13-eajames@linux.ibm.com>
Message-ID: <dc106aa2-8f69-4f71-ad9f-6dfb97c63a50@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 25/04/2024 23:36, Eddie James wrote:
> Add the P11 FSI device tree for use in upcoming BMC systems.
> Unlike P10, there is no system with only two processors, so
> only the quad processor FSI layout is necessary.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 1696 +++++++++++++++++
>  1 file changed, 1696 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
> 
> diff --git a/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi b/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
> new file mode 100644
> index 000000000000..c3a0ecf12aa0
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
> @@ -0,0 +1,1696 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2024 IBM Corp.
> +
> +&fsim0 {

This does not make sense. You do not include any file here, so what do
you want to override?

How can you even test this file?

> +	status = "okay";
> +
> +	#address-cells = <2>;
> +	#size-cells = <0>;
> +
> +	cfam-reset-gpios = <&gpio0 ASPEED_GPIO(Q, 0) GPIO_ACTIVE_HIGH>;
> +


> +
> +&cfam3_i2c16 {
> +	fsi-i2cr at 20 {
> +		compatible = "ibm,i2cr-fsi-master";
> +		reg = <0x20>;
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cfam at 0,0 {
> +			reg = <0 0>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			chip-id = <0>;
> +
> +			scom416: scom at 1000 {
> +				compatible = "ibm,i2cr-scom";
> +				reg = <0x1000 0x400>;
> +			};
> +
> +			sbefifo416: sbefifo at 2400 {
> +				compatible = "ibm,odyssey-sbefifo";
> +				reg = <0x2400 0x400>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +	};
> +};
> +
> +&cfam3_i2c17 {

This looks randomly ordered.


> +&fsi_occ1 {
> +	reg = <2>;
> +};
> +
> +&fsi_occ2 {
> +	reg = <3>;
> +};
> +
> +&fsi_occ3 {
> +	reg = <4>;
> +};
> +
> +/ {

Nope. Root node never goes to end of file. Look at all modern DTS.

> +	aliases {
> +		i2c100 = &cfam0_i2c0;
> +		i2c101 = &cfam0_i2c1;
> +		i2c110 = &cfam0_i2c10;
> +		i2c111 = &cfam0_i2c11;
> +		i2c112 = &cfam0_i2c12;
> +		i2c113 = &cfam0_i2c13;
> +		i2c114 = &cfam0_i2c14;
> +		i2c115 = &cfam0_i2c15;
> +		i2c202 = &cfam1_i2c2;
> +		i2c203 = &cfam1_i2c3;
> +		i2c210 = &cfam1_i2c10;



Best regards,
Krzysztof

