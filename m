From: Cédric Le Goater <clg@kaod.org>
Date: Mon, 18 Dec 2017 10:06:13 +0100
Subject: [PATCH v2 14/19] ARM: dts: aspeed: Sort ASPEED entries in makefile
In-Reply-To: <20171215062443.23059-15-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-15-joel@jms.id.au>
Message-ID: <371c410f-44ff-cdba-a820-eb24e0fb618a@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 07:24 AM, Joel Stanley wrote:
> In preperation for adding more boards.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  arch/arm/boot/dts/Makefile | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d0381e9caf21..5d1e9d37bf3a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1101,7 +1101,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D \
>  	mt8127-moose.dtb \
>  	mt8135-evbp1.dtb
>  dtb-$(CONFIG_ARCH_ZX) +=3D zx296702-ad1.dtb
> -dtb-$(CONFIG_ARCH_ASPEED) +=3D aspeed-bmc-opp-palmetto.dtb \
> -	aspeed-bmc-opp-romulus.dtb \
> -	aspeed-ast2500-evb.dtb
> +dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> +	aspeed-ast2500-evb.dtb \
> +	aspeed-bmc-opp-palmetto.dtb \
> +	aspeed-bmc-opp-romulus.dtb
>  endif
>=20

