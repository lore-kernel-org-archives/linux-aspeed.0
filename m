From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 07 Aug 2019 14:15:40 -0700
Subject: [PATCH] clk: aspeed: Add SDIO gate
In-Reply-To: <20190710141009.20651-1-andrew@aj.id.au>
References: <20190710141009.20651-1-andrew@aj.id.au>
Message-ID: <20190807211541.5D6B0217D9@mail.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Andrew Jeffery (2019-07-10 07:10:09)
> From: Joel Stanley <joel@jms.id.au>
> 
> The clock divisor comes with an enable bit (gate). This was not
> implemented as we didn't have access to SD hardware when writing the
> driver. Now that we can test it, add the gate as a parent to the
> divisor.
> 
> There is no reason to expose the gate separately, so users will enable
> it by turning on the ASPEED_CLK_SDIO divisor.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> [aj: Minor style cleanup]
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---

Applied to clk-next

