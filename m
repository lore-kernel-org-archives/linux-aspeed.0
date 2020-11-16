From: Joel Stanley <joel@jms.id.au>
Date: Mon, 16 Nov 2020 03:33:24 +0000
Subject: [PATCH] ARM: dts: aspeed: wedge400: Fix FMC flash0 layout
In-Reply-To: <20201110072159.7941-1-rentao.bupt@gmail.com>
References: <20201110072159.7941-1-rentao.bupt@gmail.com>
Message-ID: <CACPK8Xcy=EAP4qTyBXoxExXthR31sqS_+gCu41X2yxL6aC8eMw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2020 at 07:22, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> Update "data0" partition's size from 8MB to 4MB to fix "partition data0
> extends beyond the end of device" warning at bootup time.

Thanks for testing :)

> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I will apply for 5.11.

> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
> index ad1fcad3676c..63a3dd548f30 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
> @@ -124,8 +124,8 @@
>                  * "data0" partition (4MB) is reserved for persistent
>                  * data store.
>                  */
> -               data0 at 3800000 {
> -                       reg = <0x7c00000 0x800000>;
> +               data0 at 7c00000 {
> +                       reg = <0x7c00000 0x400000>;
>                         label = "data0";
>                 };
>
> --
> 2.17.1
>
