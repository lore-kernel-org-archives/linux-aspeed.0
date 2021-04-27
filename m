From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 27 Apr 2021 11:52:41 +0930
Subject: =?UTF-8?Q?Re:_[PATCH]_EDAC/aspeed:_use_proper_format_string_for_printing?=
 =?UTF-8?Q?_resource?=
In-Reply-To: <20210421135500.3518661-1-arnd@kernel.org>
References: <20210421135500.3518661-1-arnd@kernel.org>
Message-ID: <dd4286c6-c856-40c4-b1f8-060f76258d57@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 21 Apr 2021, at 23:24, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On ARMv7, resource_size_t can be 64-bit, which breaks printing
> it as %x:
> 
> drivers/edac/aspeed_edac.c: In function 'init_csrows':
> drivers/edac/aspeed_edac.c:257:28: error: format '%x' expects argument 
> of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 
> 'long long unsigned int'} [-Werror=format=]
>   257 |         dev_dbg(mci->pdev, "dt: /memory node resources: first 
> page r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> 
> Use the special %pR format string to pretty-print the entire
> resource instead.
> 
> Fixes: edfc2d73ca45 ("EDAC/aspeed: Add support for AST2400 and AST2600")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/edac/aspeed_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index a46da56d6d54..6bd5f8815919 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c
> @@ -254,8 +254,8 @@ static int init_csrows(struct mem_ctl_info *mci)
>  		return rc;
>  	}
>  
> -	dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> -		r.start, resource_size(&r), PAGE_SHIFT);
> +	dev_dbg(mci->pdev, "dt: /memory node resources: first page %pR, PAGE_SHIFT macro=0x%x\n",

Could probably drop the "first page " as well, but it's a dev_dbg() and not a big deal.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
