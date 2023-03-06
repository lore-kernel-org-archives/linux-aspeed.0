From: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 06 Mar 2023 14:18:47 -0800
Subject: [PATCH v5 5/6] clk: ast2600: Add comment about combined clock + reset handling
In-Reply-To: <20230302005834.13171-6-jk@codeconstruct.com.au>
References: <20230302005834.13171-1-jk@codeconstruct.com.au> <20230302005834.13171-6-jk@codeconstruct.com.au>
Message-ID: <cc6a0ded69becc0b3f7e9ac5190d8f64.sboyd@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Jeremy Kerr (2023-03-01 16:58:33)
> Add a little description about how reset lines can be implicit with
> clock enable/disable. This is mostly based on the commit message
> from the original submission in 15ed8ce5f8.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---

Applied to clk-next
