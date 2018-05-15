From: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 15 May 2018 15:00:03 -0700
Subject: [PATCH v2] clk: aspeed: Support second reset register
In-Reply-To: <20180427025547.14115-1-joel@jms.id.au>
References: <20180427025547.14115-1-joel@jms.id.au>
Message-ID: <152642160316.237094.580656516961912710@swboyd.mtv.corp.google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Joel Stanley (2018-04-26 19:55:47)
> The ast2500 has an additional reset register that contains resets not
> present in the ast2400. This enables support for this register, and adds
> the one reset line that is controlled by it.
> 
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Applied to clk-next

