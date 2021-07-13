From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Jul 2021 16:44:10 -0600
Subject: [PATCH v6 2/9] dt-bindings: aspeed-sgpio: Add ast2600 sgpio
In-Reply-To: <20210712100317.23298-3-steven_lee@aspeedtech.com>
References: <20210712100317.23298-1-steven_lee@aspeedtech.com>
 <20210712100317.23298-3-steven_lee@aspeedtech.com>
Message-ID: <20210713224410.GA987786@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 12 Jul 2021 18:03:09 +0800, Steven Lee wrote:
> AST2600 SoC has 2 SGPIO master interfaces one with 128 pins another one
> with 80 pins. Add ast2600-sgpiom compatibles and update descriptions to
> introduce the max number of available gpio pins that AST2600 supported.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
