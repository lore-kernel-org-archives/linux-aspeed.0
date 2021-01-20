From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 20 Jan 2021 15:40:56 +1030
Subject: [PATCH v5 5/5] soc: aspeed: Adapt to new LPC device tree layout
In-Reply-To: <20210114131622.8951-6-chiawei_wang@aspeedtech.com>
References: <20210114131622.8951-6-chiawei_wang@aspeedtech.com>
Message-ID: <20210120051056.712222-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Add check against LPC device v2 compatible string to
> ensure that the fixed device tree layout is adopted.
> The LPC register offsets are also fixed accordingly.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> ---
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c  | 20 ++++++++++++++------
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 23 +++++++++++++++--------

In the future please do separate patches for separate drivers, but for now:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
