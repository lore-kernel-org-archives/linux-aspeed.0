From: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 06 Mar 2023 14:18:25 -0800
Subject: [PATCH v5 3/6] clk: ast2600: Add full configs for I3C clocks
In-Reply-To: <20230302005834.13171-4-jk@codeconstruct.com.au>
References: <20230302005834.13171-1-jk@codeconstruct.com.au> <20230302005834.13171-4-jk@codeconstruct.com.au>
Message-ID: <3a8f668c9b1517ac00bafebda8f2b58f.sboyd@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Jeremy Kerr (2023-03-01 16:58:31)
> The current ast2600 I3C clock definitions are top-level (rather than
> based on their actual hw sources: either HCLK or APLL), and include a
> couple of definitions for (non-existent) i3c6 and i3c7.
> 
> Re-parent the individual I3C controller clocks to the main i3c clock,
> explicitly sourced from the APLL rather than whatever G6_CLK_SELECTION5
> was last set to.
> 
> While we're at it, remove the definitions for the i3c6 and i3c7 clock
> lines; this hardware isn't present.
> 
> This is a partial cherry-pick and rework of ed44b8cdfdb and 1a35eb926d7
> from Aspeed's own tree, originally by Dylan Hung
> <dylan_hung@aspeedtech.com>.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> ---

Applied to clk-next
