From: Joel Stanley <joel@jms.id.au>
Date: Wed, 26 Feb 2020 10:55:59 +0000
Subject: [PATCH v1] ARM: dts: mihawk: Change the name of mihawk led
In-Reply-To: <20200220055255.22809-1-Ben_Pai@wistron.com>
References: <20200220055255.22809-1-Ben_Pai@wistron.com>
Message-ID: <CACPK8Xf=t+PY42qxF9jProYGGZZJONb=H1D4xZJc7teFWJ2FrA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2020 at 05:53, Ben Pai <Ben_Pai@wistron.com> wrote:
>
> 1.Change the name of power, fault and rear-id.
> 2.Remove the two leds.

The patch looks okay. Why do you remove the other two leds?

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> Signed-off-by: Ben Pai <Ben_Pai@wistron.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
> index e55cc454b17f..6c11854b9006 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
> @@ -120,35 +120,24 @@
>         leds {
>                 compatible = "gpio-leds";
>
> -               fault {
> +               front-fault {
>                         retain-state-shutdown;
>                         default-state = "keep";
>                         gpios = <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_LOW>;
>                 };
>
> -               power {
> +               power-button {
>                         retain-state-shutdown;
>                         default-state = "keep";
>                         gpios = <&gpio ASPEED_GPIO(AA, 1) GPIO_ACTIVE_LOW>;
>                 };
>
> -               rear-id {
> +               front-id {
>                         retain-state-shutdown;
>                         default-state = "keep";
>                         gpios = <&gpio ASPEED_GPIO(AA, 2) GPIO_ACTIVE_LOW>;
>                 };
>
> -               rear-g {
> -                       retain-state-shutdown;
> -                       default-state = "keep";
> -                       gpios = <&gpio ASPEED_GPIO(AA, 4) GPIO_ACTIVE_LOW>;
> -               };
> -
> -               rear-ok {
> -                       retain-state-shutdown;
> -                       default-state = "keep";
> -                       gpios = <&gpio ASPEED_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
> -               };
>
>                 fan0 {
>                         retain-state-shutdown;
> --
> 2.17.1
>
>
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------
> This email contains confidential or legally privileged information and is for the sole use of its intended recipient.
> Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited.
> If you are not the intended recipient, you may reply to the sender and should delete this e-mail immediately.
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------
