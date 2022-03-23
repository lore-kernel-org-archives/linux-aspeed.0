From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 23 Mar 2022 13:37:32 +0100
Subject: [PATCH 2/2] i2c:aspeed:support ast2600 i2c new register mode
 driver
In-Reply-To: <20220323004009.943298-3-ryan_chen@aspeedtech.com>
References: <20220323004009.943298-1-ryan_chen@aspeedtech.com>
 <20220323004009.943298-3-ryan_chen@aspeedtech.com>
Message-ID: <YjsUjB7vr1scHPVy@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 23, 2022 at 08:40:09AM +0800, ryan_chen wrote:
> Add i2c new register mode driver to support AST2600 i2c
> new register set. AST2600 i2c controller have legacy and
> new register mode. The new register mode have global register
> support 4 base clock for scl clock selection, and new clock
> divider mode. And i2c new register mode have separate register
> set to control i2c master and slave.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/i2c/busses/Kconfig                 |   11 +
>  drivers/i2c/busses/Makefile                |    1 +
>  drivers/i2c/busses/aspeed-i2c-new-global.c |   91 ++
>  drivers/i2c/busses/aspeed-i2c-new-global.h |   19 +
>  drivers/i2c/busses/i2c-new-aspeed.c        | 1698 ++++++++++++++++++++

I always find it funny when somebody uses 'new'. What is the next
version going to be called? 'even-newer', and the version after that
'really-really-new'?

> +static const struct of_device_id aspeed_new_i2c_bus_of_table[] = {
> +	{
> +		.compatible = "aspeed,ast2600-i2c-bus",
> +	},

Given this compatible string, why not call it i2c-aspeed-2600.c, and
remove 'new' everywhere.

       Andrew
