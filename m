From: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 28 Oct 2019 16:40:28 -0700
Subject: [PATCH] clk: ast2600: Fix enabling of clocks
In-Reply-To: <20191016131319.31318-1-joel@jms.id.au>
References: <20191016131319.31318-1-joel@jms.id.au>
Message-ID: <20191028234029.07821214E0@mail.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Joel Stanley (2019-10-16 06:13:19)
> The struct clk_ops enable callback for the aspeed gates mixes up the set
> to clear and write to set registers.
> 
> Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Applied to clk-fixes

