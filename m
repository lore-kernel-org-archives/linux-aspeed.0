From: Cédric Le Goater <clg@kaod.org>
Date: Wed, 20 Dec 2017 07:44:12 +0100
Subject: [PATCH v3 18/20] ARM: dts: aspeed-romulus: Update Romulus system
In-Reply-To: <20171220032328.30584-19-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
 <20171220032328.30584-19-joel@jms.id.au>
Message-ID: <7b5e578b-3f83-1bad-df27-68071105edf0@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On 12/20/2017 04:23 AM, Joel Stanley wrote:
>  - Fix incorrect RAM size
>  - Remove alias; these are now specified in the dtsi
>  - Add newly upstreamed devices
>  - Include OpenBMC flash layout
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  v3:
>   - Add GPIO include
>   - Fix duplicate fmc and spi nodes
>   - Add unit name for memory node to fix warning
> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts | 133 +++++++++++++++++++++=
++++--
>  1 file changed, 126 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot=
/dts/aspeed-bmc-opp-romulus.dts
> index a7a9386f964d..623b6ab42021 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> @@ -1,23 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /dts-v1/;
> -
>  #include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> =20
>  / {
>  	model =3D "Romulus BMC";
>  	compatible =3D "ibm,romulus-bmc", "aspeed,ast2500";
> =20
> -	aliases {
> -		serial4 =3D &uart5;
> -	};
> -
>  	chosen {
>  		stdout-path =3D &uart5;
>  		bootargs =3D "console=3DttyS4,115200 earlyprintk";
>  	};
> =20
> -	memory {
> -		reg =3D <0x80000000 0x40000000>;
> +	memory at 80000000 {
> +		reg =3D <0x80000000 0x20000000>;
>  	};
> =20
>  	reserved-memory {
> @@ -29,6 +25,49 @@
>  			no-map;
>  			reg =3D <0xbf000000 0x01000000>; /* 16M */
>  		};
> +
> +		flash_memory: region at 98000000 {
> +			no-map;
> +			reg =3D <0x98000000 0x04000000>; /* 64M */
> +		};
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		fault {
> +			gpios =3D <&gpio ASPEED_GPIO(N, 2) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		identify {
> +			gpios =3D <&gpio ASPEED_GPIO(N, 4) GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		power {
> +			gpios =3D <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	fsi: gpio-fsi {
> +		compatible =3D "fsi-master-gpio", "fsi-master";
> +		#address-cells =3D <2>;
> +		#size-cells =3D <0>;
> +
> +		clock-gpios =3D <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
> +		data-gpios =3D <&gpio ASPEED_GPIO(AA, 2) GPIO_ACTIVE_HIGH>;
> +		mux-gpios =3D <&gpio ASPEED_GPIO(A, 6) GPIO_ACTIVE_HIGH>;
> +		enable-gpios =3D <&gpio ASPEED_GPIO(D, 0) GPIO_ACTIVE_HIGH>;
> +		trans-gpios =3D <&gpio ASPEED_GPIO(R, 2) GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	gpio-keys {
> +		compatible =3D "gpio-keys";
> +
> +		checkstop {
> +			label =3D "checkstop";
> +			gpios =3D <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
> +			linux,code =3D <ASPEED_GPIO(J, 2)>;
> +		};
>  	};
>  };
> =20
> @@ -38,6 +77,7 @@
>  		status =3D "okay";
>  		m25p,fast-read;
>  		label =3D "bmc";
> +#include "openbmc-flash-layout.dtsi"
>  	};
>  };
> =20
> @@ -53,6 +93,12 @@
>  	};
>  };
> =20
> +&lpc_ctrl {
> +	status =3D "okay";
> +	memory-region =3D <&flash_memory>;
> +	flash =3D <&spi1>;
> +};
> +
>  &uart1 {
>  	/* Rear RS-232 connector */
>  	status =3D "okay";
> @@ -81,6 +127,10 @@
>  	pinctrl-0 =3D <&pinctrl_rmii1_default>;
>  };
> =20
> +&i2c1 {
> +	status =3D "okay";
> +};
> +
>  &i2c2 {
>  	status =3D "okay";
>  };
> @@ -133,8 +183,77 @@
> =20
>  &i2c12 {
>  	status =3D "okay";
> +
> +	max31785 at 52 {
> +		compatible =3D "maxim,max31785";
> +		reg =3D <0x52>;
> +	};
> +};
> +
> +&gpio {
> +	nic_func_mode0 {
> +		gpio-hog;
> +		gpios =3D <ASPEED_GPIO(D, 3) GPIO_ACTIVE_HIGH>;
> +		output-low;
> +		line-name =3D "nic_func_mode0";
> +	};
> +	nic_func_mode1 {
> +		gpio-hog;
> +		gpios =3D <ASPEED_GPIO(D, 4) GPIO_ACTIVE_HIGH>;
> +		output-low;
> +		line-name =3D "nic_func_mode1";
> +	};
>  };
> =20
>  &vuart {
>  	status =3D "okay";
>  };
> +
> +&gfx {
> +	status =3D "okay";
> +};
> +
> +&pinctrl {
> +	aspeed,external-nodes =3D <&gfx &lhc>;
> +};
> +
> +&pwm_tacho {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
> +
> +	fan at 0 {
> +		reg =3D <0x00>;
> +		aspeed,fan-tach-ch =3D /bits/ 8 <0x08>;
> +	};
> +
> +	fan at 1 {
> +		reg =3D <0x00>;
> +		aspeed,fan-tach-ch =3D /bits/ 8 <0x09>;
> +	};
> +
> +	fan at 2 {
> +		reg =3D <0x01>;
> +		aspeed,fan-tach-ch =3D /bits/ 8 <0x0a>;
> +	};
> +
> +	fan at 3 {
> +		reg =3D <0x01>;
> +		aspeed,fan-tach-ch =3D /bits/ 8 <0x0b>;
> +	};
> +
> +	fan at 4 {
> +		reg =3D <0x00>;
> +		aspeed,fan-tach-ch =3D /bits/ 8 <0x0c>;
> +	};
> +
> +	fan at 5 {
> +		reg =3D <0x00>;
> +		aspeed,fan-tach-ch =3D /bits/ 8 <0x0d>;
> +	};
> +
> +	fan at 6 {
> +		reg =3D <0x01>;
> +		aspeed,fan-tach-ch =3D /bits/ 8 <0x0e>;
> +	};
> +};
>=20

