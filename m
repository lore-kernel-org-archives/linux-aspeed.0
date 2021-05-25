From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 25 May 2021 14:07:07 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_3/3]_pinctrl:_pinctrl-aspeed-g6:_Add_sgpio_pinct?=
 =?UTF-8?Q?rl_settings?=
In-Reply-To: <20210525042736.10379-4-steven_lee@aspeedtech.com>
References: <20210525042736.10379-1-steven_lee@aspeedtech.com>
 <20210525042736.10379-4-steven_lee@aspeedtech.com>
Message-ID: <7f673953-7a90-4143-a475-444a1096e55f@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 25 May 2021, at 13:57, Steven Lee wrote:
> AST2600 supports 2 SGPIO master interfaces and 2 SGPIO slave interfaces.
> Current pinctrl driver only define the first sgpio master and slave
> interfaces.
> The sencond SGPIO master and slave interfaces should be added in

Typo here: 'second', 

Regardless, this looks good to me.

Thanks Steven!

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
