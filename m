From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 4 Sep 2019 09:02:33 +0200
Subject: [PATCH 4/4] gpio: Update documentation with ast2600 controllers
In-Reply-To: <20190904061245.30770-4-rashmica.g@gmail.com>
References: <20190904061245.30770-1-rashmica.g@gmail.com>
 <20190904061245.30770-4-rashmica.g@gmail.com>
Message-ID: <CAMpxmJUGm3Zs8VHwHnXTQ2cKnpF0caR=7V4bBi1_sy1U2mWc0g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

?r., 4 wrz 2019 o 08:13 Rashmica Gupta <rashmica.g@gmail.com> napisa?(a):
>

Again, this needs a proper commit description and the subject should
start with "dt-bindings: ...".

You also need to Cc the device-tree maintainers. Use
scripts/get_maintainer.pl to list all people that should get this
patch.

Bart

> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-aspeed.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt b/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
> index 7e9b586770b0..cd388797e07c 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
> @@ -2,7 +2,8 @@ Aspeed GPIO controller Device Tree Bindings
>  -------------------------------------------
>
>  Required properties:
> -- compatible           : Either "aspeed,ast2400-gpio" or "aspeed,ast2500-gpio"
> +- compatible           : Either "aspeed,ast2400-gpio", "aspeed,ast2500-gpio",
> +                                         "aspeed,ast2600-gpio", or "aspeed,ast2600-1-8v-gpio"
>
>  - #gpio-cells          : Should be two
>                           - First cell is the GPIO line number
> --
> 2.20.1
>
