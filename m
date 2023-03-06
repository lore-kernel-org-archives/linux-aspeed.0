From: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 06 Mar 2023 14:18:15 -0800
Subject: [PATCH v5 2/6] dt-bindings: clock: ast2600: Add top-level I3C clock
In-Reply-To: <20230302005834.13171-3-jk@codeconstruct.com.au>
References: <20230302005834.13171-1-jk@codeconstruct.com.au> <20230302005834.13171-3-jk@codeconstruct.com.au>
Message-ID: <4fc238f83c507735bac362e4dea9a0ef.sboyd@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Jeremy Kerr (2023-03-01 16:58:30)
> The ast2600 hardware has a top-level clock for all i3c controller
> peripherals (then gated to each individual controller), so add a
> top-level i3c clock line to control this.
> 
> This is a partial cherry-pick and rework of ed44b8cdfdb and 1a35eb926d7
> from Aspeed's own tree, originally by Dylan Hung
> <dylan_hung@aspeedtech.com>.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> ---

Applied to clk-next
