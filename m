From: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 06 Mar 2023 14:18:06 -0800
Subject: [PATCH v5 1/6] clk: ast2600: allow empty entries in aspeed_g6_gates
In-Reply-To: <20230302005834.13171-2-jk@codeconstruct.com.au>
References: <20230302005834.13171-1-jk@codeconstruct.com.au> <20230302005834.13171-2-jk@codeconstruct.com.au>
Message-ID: <3fa10935df53baca5e4521f0fbe6f382.sboyd@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Jeremy Kerr (2023-03-01 16:58:29)
> We're about to remove an entry from aspeed_g6_gates, but we won't want
> to alter/reorder existing entries. Allow empty entries in this array.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> ---

Applied to clk-next
