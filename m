From: Rob Herring <robh@kernel.org>
Date: Mon, 19 Feb 2018 14:41:25 -0600
Subject: [PATCH 1/3] dt-bindings: aspeed-lpc: Add reset controller
In-Reply-To: <20180219065438.19933-2-joel@jms.id.au>
References: <20180219065438.19933-1-joel@jms.id.au>
 <20180219065438.19933-2-joel@jms.id.au>
Message-ID: <20180219204125.ralfeo6rm7wzkcnq@rob-hp-laptop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 19, 2018 at 05:24:36PM +1030, Joel Stanley wrote:
> This describes the reset controller present in the LPC address space.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt          | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
