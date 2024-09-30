From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 30 Sep 2024 14:12:09 +0930
Subject: [PATCH v6 7/7] gpio: aspeed: Use devm_clk api to manage clock
 source
In-Reply-To: <20240927111744.3511373-8-billy_tsai@aspeedtech.com>
References: <20240927111744.3511373-1-billy_tsai@aspeedtech.com>
	 <20240927111744.3511373-8-billy_tsai@aspeedtech.com>
Message-ID: <3a484923ec6fce4a3562b4bedaf846b2ae2ffee7.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-09-27 at 19:17 +0800, Billy Tsai wrote:
> Replace of_clk_get with devm_clk_get_enabled to manage the clock source.
> 
> Fixes: 5ae4cb94b313 ("gpio: aspeed: Add debounce support")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Though as noted in patch 3/7, 7/7 (this patch) and 5/7 should probably
be ordered before 3/7.
