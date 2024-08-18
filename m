From: Rob Herring <robh@kernel.org>
Date: Sun, 18 Aug 2024 09:20:30 -0600
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add support
 for ASPEED AST27XX INTC
In-Reply-To: <20240814114106.2809876-3-kevin_chen@aspeedtech.com>
References: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
 <20240814114106.2809876-3-kevin_chen@aspeedtech.com>
Message-ID: <20240818152030.GA101410-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 14, 2024 at 07:41:05PM +0800, Kevin Chen wrote:
> The ASPEED AST27XX interrupt controller(INTC) contain second level and
> third level interrupt controller. The third level INTC combines 32 interrupt
> sources into 1 interrupt into parent interrupt controller. The second
> level INTC doing hand shake with third level INTC.

Missing Signed-off-by. checkpatch.pl also reports trailing whitespace.
