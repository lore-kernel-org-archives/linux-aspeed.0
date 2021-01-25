From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 25 Jan 2021 14:45:34 +1030
Subject: [PATCH v5 5/5] soc: aspeed: Adapt to new LPC device tree layout
In-Reply-To: <20210114131622.8951-6-chiawei_wang@aspeedtech.com>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-6-chiawei_wang@aspeedtech.com>
Message-ID: <a40f7391-e468-4155-b19c-240fb65ce22c@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 14 Jan 2021, at 23:46, Chia-Wei, Wang wrote:
> Add check against LPC device v2 compatible string to
> ensure that the fixed device tree layout is adopted.
> The LPC register offsets are also fixed accordingly.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> ---
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c  | 20 ++++++++++++++------
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 23 +++++++++++++++--------

Using a Witherspoon (AST2500) I've tested the aspeed-lpc-ctrl driver:

Tested-by: Andrew Jeffery <andrew@aj.id.au>
