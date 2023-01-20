From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 20 Jan 2023 12:39:46 +1030
Subject: [PATCH] i2c: aspeed: Use devm_platform_get_and_ioremap_resource()
In-Reply-To: <202301191715319948743@zte.com.cn>
References: <202301191715319948743@zte.com.cn>
Message-ID: <f5423719-6d12-407a-85e6-896fe97c723c@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 19 Jan 2023, at 19:45, ye.xingchen at zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
