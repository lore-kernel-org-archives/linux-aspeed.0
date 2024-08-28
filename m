From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 28 Aug 2024 09:30:08 +0200
Subject: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
In-Reply-To: <20240828062740.1614744-4-ryan_chen@aspeedtech.com>
References: <20240828062740.1614744-1-ryan_chen@aspeedtech.com>
 <20240828062740.1614744-4-ryan_chen@aspeedtech.com>
Message-ID: <231a159e-7596-46d2-a44f-bd61b2908f38@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 28/08/2024 08:27, Ryan Chen wrote:
> Add AST2700 clock controller driver. This driver also selects MFD_SYSCON,
> which provides access to system controller registers, and register the
> reset controller.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>


> +	clks[SCU0_CLK_GATE_EMMCCLK] =
> +		ast2700_clk_hw_register_gate(NULL, "emmcclk-gate", "emmcclk",
> +					     0, clk_base + SCU0_CLK_STOP,
> +					     27, 0, &ast2700_clk_lock);
> +
> +	clks[SCU0_CLK_GATE_RVAS1CLK] =
> +		ast2700_clk_hw_register_gate(NULL, "rvas2clk", NULL,
> +					     0, clk_base + SCU0_CLK_STOP,
> +					     28, 0, &ast2700_clk_lock);
> +
> +	of_clk_add_hw_provider(soc0_node, of_clk_hw_onecell_get, clk_data);
> +
> +	return 0;
> +};
> +
> +CLK_OF_DECLARE_DRIVER(ast2700_soc0, "aspeed,ast2700-scu0", ast2700_soc0_clk_init);
> +CLK_OF_DECLARE_DRIVER(ast2700_soc1, "aspeed,ast2700-scu1", ast2700_soc1_clk_init);

Nope, this is not documented.

You cannot add new compatibles without bindings.

Best regards,
Krzysztof

