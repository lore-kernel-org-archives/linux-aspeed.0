From: Cédric Le Goater <clg@kaod.org>
Date: Mon, 18 Dec 2017 10:25:31 +0100
Subject: [PATCH v2 03/19] ARM: dts: aspeed: Add LPC and child devices
In-Reply-To: <20171215062443.23059-4-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-4-joel@jms.id.au>
Message-ID: <f08188a0-a6dd-a445-340c-eee1ca335865@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 07:24 AM, Joel Stanley wrote:
> From: Andrew Jeffery <andrew@aj.id.au>
>=20
> Ensure the ordering is correct and add all of the children in the SoC
> device trees for the ast2400 and ast2500.
>=20
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 35 +++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/aspeed-g5.dtsi | 27 +++++++++++++++++----------
>  2 files changed, 52 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-=
g4.dtsi
> index 100d092e6c07..a3bc5da7d42c 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -226,6 +226,41 @@
>  				status =3D "disabled";
>  			};
> =20
> +			lpc: lpc at 1e789000 {
> +				compatible =3D "aspeed,ast2400-lpc", "simple-mfd";
> +				reg =3D <0x1e789000 0x1000>;
> +
> +				#address-cells =3D <1>;
> +				#size-cells =3D <1>;
> +				ranges =3D <0x0 0x1e789000 0x1000>;
> +
> +				lpc_bmc: lpc-bmc at 0 {
> +					compatible =3D "aspeed,ast2400-lpc-bmc";
> +					reg =3D <0x0 0x80>;
> +				};
> +
> +				lpc_host: lpc-host at 80 {
> +					compatible =3D "aspeed,ast2400-lpc-host", "simple-mfd", "syscon";
> +					reg =3D <0x80 0x1e0>;
> +					reg-io-width =3D <4>;
> +
> +					#address-cells =3D <1>;
> +					#size-cells =3D <1>;
> +					ranges =3D <0x0 0x80 0x1e0>;
> +
> +					lpc_ctrl: lpc-ctrl at 0 {
> +						compatible =3D "aspeed,ast2400-lpc-ctrl";
> +						reg =3D <0x0 0x80>;
> +						status =3D "disabled";
> +					};
> +
> +					lhc: lhc at 20 {
> +						compatible =3D "aspeed,ast2500-lhc";

aspeed,ast2400-lhc

The layout of the registers are the same but there a couple of differences
in the bit definitions between the two SoCs.

a part from that :

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.=20

> +						reg =3D <0x20 0x24 0x48 0x8>;
> +					};
> +				};
> +			};
> +
>  			uart2: serial at 1e78d000 {
>  				compatible =3D "ns16550a";
>  				reg =3D <0x1e78d000 0x20>;
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-=
g5.dtsi
> index 1f9d28313f82..7861631940fe 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -266,6 +266,16 @@
>  				status =3D "disabled";
>  			};
> =20
> +			vuart: serial at 1e787000 {
> +				compatible =3D "aspeed,ast2500-vuart";
> +				reg =3D <0x1e787000 0x40>;
> +				reg-shift =3D <2>;
> +				interrupts =3D <10>;
> +				clocks =3D <&clk_uart>;
> +				no-loopback-test;
> +				status =3D "disabled";
> +			};
> +
>  			lpc: lpc at 1e789000 {
>  				compatible =3D "aspeed,ast2500-lpc", "simple-mfd";
>  				reg =3D <0x1e789000 0x1000>;
> @@ -289,6 +299,13 @@
> =20
>  					reg-io-width =3D <4>;
> =20
> +					lpc_ctrl: lpc-ctrl at 0 {
> +						compatible =3D "aspeed,ast2500-lpc-ctrl";
> +						reg =3D <0x0 0x80>;
> +						status =3D "disabled";
> +					};
> +
> +
>  					lhc: lhc at 20 {
>  						compatible =3D "aspeed,ast2500-lhc";
>  						reg =3D <0x20 0x24 0x48 0x8>;
> @@ -296,16 +313,6 @@
>  				};
>  			};
> =20
> -			vuart: serial at 1e787000 {
> -				compatible =3D "aspeed,ast2500-vuart";
> -				reg =3D <0x1e787000 0x40>;
> -				reg-shift =3D <2>;
> -				interrupts =3D <10>;
> -				clocks =3D <&clk_uart>;
> -				no-loopback-test;
> -				status =3D "disabled";
> -			};
> -
>  			uart2: serial at 1e78d000 {
>  				compatible =3D "ns16550a";
>  				reg =3D <0x1e78d000 0x20>;
>=20

