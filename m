From: Rob Herring <robh@kernel.org>
Date: Fri, 11 Oct 2019 12:01:20 -0500
Subject: [PATCH v2 1/2] dt-bindings: clock: Add AST2600 RMII RCLK gate
 definitions
In-Reply-To: <20191010020725.3990-2-andrew@aj.id.au>
References: <20191010020725.3990-1-andrew@aj.id.au>
 <20191010020725.3990-2-andrew@aj.id.au>
Message-ID: <20191011170120.GA15442@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2019 12:37:24 +1030, Andrew Jeffery wrote:
> The AST2600 has an explicit gate for the RMII RCLK for each of the four
> MACs.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  include/dt-bindings/clock/ast2600-clock.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
