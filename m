From: Joel Stanley <joel@jms.id.au>
Date: Fri, 11 Nov 2022 05:58:16 +0000
Subject: [PATCH] MAINTAINERS: aspeed: Update git tree URL
In-Reply-To: <20221110013438.16212-1-zev@bewilderbeest.net>
References: <20221110013438.16212-1-zev@bewilderbeest.net>
Message-ID: <CACPK8XdkXaVXzabFM-g6xQ1CBjZheiP9oFrYk5o1__QR7WBcdw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Nov 2022 at 01:34, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> The description for joel/aspeed.git on git.kernel.org currently says:
>
>     Old Aspeed tree. Please see joel/bmc.git
>
> Let's update MAINTAINERS accordingly.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Thanks!

Acked-by: Joel Stanley <joel@jms.id.au>

Arnd, does the soc team have a branch for these?

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cac5a4ad4eb8..1775e5fdaefd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1969,7 +1969,7 @@ L:        linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  L:     linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
>  S:     Supported
>  Q:     https://patchwork.ozlabs.org/project/linux-aspeed/list/
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
>  F:     Documentation/devicetree/bindings/arm/aspeed/
>  F:     arch/arm/boot/dts/aspeed-*
>  F:     arch/arm/mach-aspeed/
> --
> 2.38.1
>
