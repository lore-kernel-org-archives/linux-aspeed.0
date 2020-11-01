From: Joel Stanley <joel@jms.id.au>
Date: Sun, 1 Nov 2020 23:58:44 +0000
Subject: [PATCH] ARM: dts: aspeed: tiogapass: Remove vuart
In-Reply-To: <20200813190431.3331026-1-vijaykhemka@fb.com>
References: <20200813190431.3331026-1-vijaykhemka@fb.com>
Message-ID: <CACPK8Xe8cfQO2=+66_xE3gVWnqThWqPkhVuELpOowdaXORZCbw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2020 at 19:04, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Removed vuart for facebook tiogapass platform as it uses uart2 and
> uart3 pin with aspeed uart routing feature.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index 2d44d9ad4e40..e6ad821a8635 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -82,11 +82,6 @@ &lpc_ctrl {
>         status = "okay";
>  };
>
> -&vuart {
> -       // VUART Host Console
> -       status = "okay";
> -};
> -
>  &uart1 {
>         // Host Console
>         status = "okay";
> --
> 2.24.1
>
