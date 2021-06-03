From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 04 Jun 2021 08:58:46 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v3_5/5]_gpio:_gpio-aspeed-sgpio:_Move_irq=5Fchip_to?=
 =?UTF-8?Q?_aspeed-sgpio_struct?=
In-Reply-To: <20210603101822.9645-6-steven_lee@aspeedtech.com>
References: <20210603101822.9645-1-steven_lee@aspeedtech.com>
 <20210603101822.9645-6-steven_lee@aspeedtech.com>
Message-ID: <c93cd6b7-229d-4f82-acc5-f85a9c66587f@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 3 Jun 2021, at 19:48, Steven Lee wrote:
> The current design initializes irq->chip from a global irqchip struct,
> which causes multiple sgpio devices use the same irq_chip.
> The patch moves irq_chip to aspeed_sgpio struct for initializing
> irq_chip from their private gpio struct.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
