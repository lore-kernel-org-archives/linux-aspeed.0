From: Joel Stanley <joel@jms.id.au>
Date: Mon, 14 Sep 2020 06:38:50 +0000
Subject: [PATCH -next] EDAC/aspeed: use module_platform_driver to simplify
 the code
In-Reply-To: <20200914065358.3726216-1-liushixin2@huawei.com>
References: <20200914065358.3726216-1-liushixin2@huawei.com>
Message-ID: <CACPK8XdWAFjdmsr6nRtuvK95DOrq2C39WHjG+ZHvHGEVP4kE_w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2020 at 06:31, Liu Shixin <liushixin2@huawei.com> wrote:
>
> module_platform_driver() makes the code simpler by eliminating
> boilerplate code.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/edac/aspeed_edac.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index fbec28dc661d..fde809efc520 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c
> @@ -388,23 +388,7 @@ static struct platform_driver aspeed_driver = {
>         .probe          = aspeed_probe,
>         .remove         = aspeed_remove
>  };
> -
> -
> -static int __init aspeed_init(void)
> -{
> -       return platform_driver_register(&aspeed_driver);
> -}
> -
> -
> -static void __exit aspeed_exit(void)
> -{
> -       platform_driver_unregister(&aspeed_driver);
> -}
> -
> -
> -module_init(aspeed_init);
> -module_exit(aspeed_exit);
> -
> +module_platform_driver(aspeed_driver);
>
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Stefan Schaeckeler <sschaeck@cisco.com>");
> --
> 2.25.1
>
