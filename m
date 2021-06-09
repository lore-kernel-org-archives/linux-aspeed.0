From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 09 Jun 2021 10:26:11 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v5_10/10]_gpio:_gpio-aspeed-sgpio:_Return_error_if_?=
 =?UTF-8?Q?ngpios_is_not_multiple_of_8.?=
In-Reply-To: <20210608102547.4880-11-steven_lee@aspeedtech.com>
References: <20210608102547.4880-1-steven_lee@aspeedtech.com>
 <20210608102547.4880-11-steven_lee@aspeedtech.com>
Message-ID: <311d0c03-06f3-4c68-aa5a-877a592b6975@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 8 Jun 2021, at 19:55, Steven Lee wrote:
> Add an else-if condition in the probe function to check whether ngpios is
> multiple of 8.
> Per AST datasheet, numbers of available serial GPIO pins in Serial GPIO
> Configuration Register must be n bytes. For instance, if n = 1, it means
> AST SoC supports 8 GPIO pins.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
