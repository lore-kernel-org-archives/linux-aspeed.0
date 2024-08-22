From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 22 Aug 2024 11:10:11 +0930
Subject: [PATCH 1/5] usb: aspeed_udc: Use devm_clk_get_enabled() helpers
In-Reply-To: <20240821121048.31566-2-liulei.rjpt@vivo.com>
References: <20240821121048.31566-1-liulei.rjpt@vivo.com>
	 <20240821121048.31566-2-liulei.rjpt@vivo.com>
Message-ID: <98e7dd9ec454c1a8156ae74fe17ded7384dbe799.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-08-21 at 20:10 +0800, Lei Liu wrote:
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids calls to clk_disable_unprepare().
> 
> Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

