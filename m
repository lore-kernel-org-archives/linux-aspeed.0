From: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 06 Mar 2023 14:18:36 -0800
Subject: [PATCH v5 4/6] dt-bindings: clock: ast2600: remove IC36 & I3C7 clock definitions
In-Reply-To: <20230302005834.13171-5-jk@codeconstruct.com.au>
References: <20230302005834.13171-1-jk@codeconstruct.com.au> <20230302005834.13171-5-jk@codeconstruct.com.au>
Message-ID: <9f6866f9eb097c0ca1c9d8fd8586c9e7.sboyd@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Jeremy Kerr (2023-03-01 16:58:32)
> The current ast2600 clock definitions include entries for i3c6 and i3c7
> devices, which don't exist: there are no clock control lines documented
> for these, and only i3c devices 0 through 5 are present.
> 
> So, remove the definitions for I3C6 and I3C7. Although this is a
> potential ABI-breaking change, there are no in-tree users of these, and
> any references would be broken anyway, as the hardware doesn't exist.
> 
> This is a partial cherry-pick and rework of ed44b8cdfdb and 1a35eb926d7
> from Aspeed's own tree, originally by Dylan Hung
> <dylan_hung@aspeedtech.com>.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> ---

Applied to clk-next
