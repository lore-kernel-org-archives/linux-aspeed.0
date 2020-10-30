From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 30 Oct 2020 16:32:50 +1030
Subject: [PATCH v2] pinctrl: aspeed: Fix GPI only function problem.
In-Reply-To: <20201030055450.29613-1-billy_tsai@aspeedtech.com>
References: <20201027084417.10137-1-billy_tsai@aspeedtech.com>
 <20201030055450.29613-1-billy_tsai@aspeedtech.com>
Message-ID: <265dfc71-0087-44db-9f6c-4f105cc1853d@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 30 Oct 2020, at 16:24, Billy Tsai wrote:
> Some gpio pin at aspeed soc is input only and the prefix name of these
> pin is "GPI" only.
> This patch fine-tune the condition of GPIO check from "GPIO" to "GPI"
> and it will fix the usage error of banks D and E in the AST2400/AST2500
> and banks T and U in the AST2600.
> 
> Fixes: 4d3d0e4272d8 ("pinctrl: Add core support for Aspeed SoCs")
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Thanks Billy. Generally the Fixes: tag should be part of the trailer block, 
hopefully Linus is happy to remove the newline for us!

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
