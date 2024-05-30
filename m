From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 30 May 2024 09:05:56 -0000
Subject: [PATCH v2 08/20] pinctrl: st: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-8-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
 <20240504-pinctrl-cleanup-v2-8-26c5f2dc1181@nxp.com>
Message-ID: <ZlhBImaUrnddkm-r@surfacebook.localdomain>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sat, May 04, 2024 at 09:20:06PM +0800, Peng Fan (OSS) kirjoitti:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use scope based of_node_put() cleanup to simplify code.

...

>  	struct property *pp;
>  	struct device *dev = info->dev;
>  	struct st_pinconf *conf;
> -	struct device_node *pins;
> +	struct device_node *pins __free(device_node) = NULL;

It's better to move it upper to follow reversed xmas tree order (okay, to some
extent in this case).

>  	phandle bank;
>  	unsigned int offset;
> -	int i = 0, npins = 0, nr_props, ret = 0;
> +	int i = 0, npins = 0, nr_props;

-- 
With Best Regards,
Andy Shevchenko


