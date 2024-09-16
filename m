From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 16 Sep 2024 12:06:52 +0200
Subject: [PATCH v3 2/4] dt-bindings: Add AST2700 bindings
In-Reply-To: <20240916091039.3584505-3-ryan_chen@aspeedtech.com>
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-3-ryan_chen@aspeedtech.com>
Message-ID: <b9bf19af-0c3c-4622-9124-a66d9df649b2@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 16/09/2024 11:10, Ryan Chen wrote:
> Add reset, clock dt bindings for AST2700.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../dt-bindings/clock/aspeed,ast2700-clk.h    | 163 ++++++++++++++++++
>  .../dt-bindings/reset/aspeed,ast2700-reset.h  | 124 +++++++++++++
>  2 files changed, 287 insertions(+)

This is supposed to be part of the commit adding these bindings. You got
this comment already, didn't you?

>  create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
>  create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h
> 
> diff --git a/include/dt-bindings/clock/aspeed,ast2700-clk.h b/include/dt-bindings/clock/aspeed,ast2700-clk.h
> new file mode 100644
> index 000000000000..63021af3caf5
> --- /dev/null
> +++ b/include/dt-bindings/clock/aspeed,ast2700-clk.h

Use compatible as filename.


Best regards,
Krzysztof

