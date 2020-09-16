From: Borislav Petkov <bp@alien8.de>
Date: Wed, 16 Sep 2020 19:22:38 +0200
Subject: [PATCH -next] EDAC/aspeed: use module_platform_driver to
 simplify the code
In-Reply-To: <20200914065358.3726216-1-liushixin2@huawei.com>
References: <20200914065358.3726216-1-liushixin2@huawei.com>
Message-ID: <20200916172238.GQ2643@zn.tnic>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 14, 2020 at 02:53:58PM +0800, Liu Shixin wrote:
> module_platform_driver() makes the code simpler by eliminating
> boilerplate code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/edac/aspeed_edac.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index fbec28dc661d..fde809efc520 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c
> @@ -388,23 +388,7 @@ static struct platform_driver aspeed_driver = {
>  	.probe		= aspeed_probe,
>  	.remove		= aspeed_remove
>  };
> -
> -
> -static int __init aspeed_init(void)
> -{
> -	return platform_driver_register(&aspeed_driver);
> -}
> -
> -
> -static void __exit aspeed_exit(void)
> -{
> -	platform_driver_unregister(&aspeed_driver);
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

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
