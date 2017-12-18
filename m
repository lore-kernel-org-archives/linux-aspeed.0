From: Cédric Le Goater <clg@kaod.org>
Date: Mon, 18 Dec 2017 10:16:19 +0100
Subject: [PATCH v2 10/19] ARM: dts: aspeed: Add LPC Snoop device
In-Reply-To: <20171215062443.23059-11-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-11-joel@jms.id.au>
Message-ID: <c5ef27de-34c1-f5e9-e4ae-e2709b004677@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 07:24 AM, Joel Stanley wrote:
> LPC snoop hardware on the ASPEED BMC, used for monitoring
> host I/O port activity.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 7 +++++++
>  arch/arm/boot/dts/aspeed-g5.dtsi | 6 ++++++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-=
g4.dtsi
> index f6fee40c04c0..b3580f37f507 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -236,6 +236,13 @@
>  						status =3D "disabled";
>  					};
> =20
> +					lpc_snoop: lpc-snoop at 0 {
> +						compatible =3D "aspeed,ast2500-lpc-snoop";

it should be :

	aspeed,ast2400-lpc-snoop

a part from that :

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> +						reg =3D <0x0 0x80>;
> +						interrupts =3D <8>;
> +						status =3D "disabled";
> +					};
> +
>  					lhc: lhc at 20 {
>  						compatible =3D "aspeed,ast2500-lhc";
>  						reg =3D <0x20 0x24 0x48 0x8>;
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-=
g5.dtsi
> index 96a9d2fe3f0d..50766f0629f8 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -287,6 +287,12 @@
>  						status =3D "disabled";
>  					};
> =20
> +					lpc_snoop: lpc-snoop at 0 {
> +						compatible =3D "aspeed,ast2500-lpc-snoop";
> +						reg =3D <0x0 0x80>;
> +						interrupts =3D <8>;
> +						status =3D "disabled";
> +					};
> =20
>  					lhc: lhc at 20 {
>  						compatible =3D "aspeed,ast2500-lhc";
>=20

