From: Rob Herring (Arm) <robh@kernel.org>
Date: Wed, 16 Oct 2024 12:27:40 -0500
Subject: [PATCH v4 1/2] dt-bindings: interrupt-controller: Add support
 for ASPEED AST27XX INTC
In-Reply-To: <20241016022410.1154574-2-kevin_chen@aspeedtech.com>
References: <20241016022410.1154574-1-kevin_chen@aspeedtech.com>
 <20241016022410.1154574-2-kevin_chen@aspeedtech.com>
Message-ID: <172909966003.2068484.893211890028147027.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Wed, 16 Oct 2024 10:24:09 +0800, Kevin Chen wrote:
> The ASPEED AST27XX interrupt controller(INTC) contains second level and
> third level interrupt controller.
> 
> INTC0:
> The second level INTC, which used to assert GIC if interrupt in INTC1 asserted.
> 
> INTC1_x:
> The third level INTC, which used to assert INTC0 if interrupt in modules
> of INTC asserted.
> 
> The relationship is like the following:
>   +-----+   +-------+     +---------+---module0
>   | GIC |---| INTC0 |--+--| INTC1_0 |---module1
>   |     |   |       |  |  |         |---...
>   +-----+   +-------+  |  +---------+---module31
>                        |
>                        |   +---------+---module0
>                        +---| INTC1_1 |---module1
>                        |   |         |---...
>                        |   +---------+---module31
>                       ...
>                        |   +---------+---module0
>                        +---| INTC1_5 |---module1
>                            |         |---...
>                            +---------+---module31
> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> ---
>  .../aspeed,ast2700-intc.yaml                  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

