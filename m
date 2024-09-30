From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 30 Sep 2024 14:07:39 +0930
Subject: [PATCH v6 5/7] gpio: aspeed: Change the macro to support
 deferred probe
In-Reply-To: <20240927111744.3511373-6-billy_tsai@aspeedtech.com>
References: <20240927111744.3511373-1-billy_tsai@aspeedtech.com>
	 <20240927111744.3511373-6-billy_tsai@aspeedtech.com>
Message-ID: <506c41f97dc0243ed156f1775006ef30fe4a3f54.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-09-27 at 19:17 +0800, Billy Tsai wrote:
> Use module_platform_driver() to replace module_platform_driver_probe().
> The former utilizes platform_driver_register(), which allows the driver to
> defer probing when it doesn't acquire the necessary resources due to probe
> order. In contrast, the latter uses __platform_driver_probe(), which
> includes the comment "Note that this is incompatible with deferred
> probing." Since our GPIO driver requires access to the clock resource, the
> former is more suitable.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Seems okay to make it less of a deviant, though maybe we should fix the
sgpio drive as well? Anyway:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Andrew
