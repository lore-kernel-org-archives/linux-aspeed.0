From: Borislav Petkov <bp@alien8.de>
Date: Thu, 19 Dec 2019 07:33:12 +0100
Subject: [PATCH] EDAC: aspeed: Remove unneeded semicolon
In-Reply-To: <1576648806-1114-1-git-send-email-vulab@iscas.ac.cn>
References: <1576648806-1114-1-git-send-email-vulab@iscas.ac.cn>
Message-ID: <20191219063312.GC32039@zn.tnic>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 18, 2019 at 06:00:06AM +0000, Xu Wang wrote:
> Remove unneeded semicolon reported by coccinelle.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/edac/aspeed_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index 09a9e3d..b194658b 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c
> @@ -243,7 +243,7 @@ static int init_csrows(struct mem_ctl_info *mci)
>  	if (!np) {
>  		dev_err(mci->pdev, "dt: missing /memory node\n");
>  		return -ENODEV;
> -	};
> +	}
>  
>  	rc = of_address_to_resource(np, 0, &r);
>  
> @@ -252,7 +252,7 @@ static int init_csrows(struct mem_ctl_info *mci)
>  	if (rc) {
>  		dev_err(mci->pdev, "dt: failed requesting resource for /memory node\n");
>  		return rc;
> -	};
> +	}
>  
>  	dev_dbg(mci->pdev, "dt: /memory node resources: first page r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>  		r.start, resource_size(&r), PAGE_SHIFT);
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
