From: Joel Stanley <joel@jms.id.au>
Date: Tue, 17 Aug 2021 08:21:04 +0000
Subject: [PATCH] ARM: dts: aspeed: cloudripper: Add comments for "mdio1"
In-Reply-To: <20210813061900.24539-1-rentao.bupt@gmail.com>
References: <20210813061900.24539-1-rentao.bupt@gmail.com>
Message-ID: <CACPK8Xei0K2vcEGc3Qr5zcb1SHMgNbJ+4_fVd6u-FiOHt4PxSg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 13 Aug 2021 at 06:19, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> Add some comments to explain the purpose of "mdio1" controller: it's
> connected to the MDC/MDIO interface of the on-board management switch.
>
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Thanks, applied.

> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
> index 01ec3ce0a29d..9c6271a17ae8 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
> @@ -96,6 +96,11 @@
>         status = "okay";
>  };
>
> +/*
> + * "mdio1" is connected to the MDC/MDIO interface of the on-board
> + * management switch (whose ports are connected to BMC, Host and front
> + * panel ethernet port).
> + */
>  &mdio1 {
>         status = "okay";
>  };
> --
> 2.17.1
>
