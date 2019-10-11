From: Rob Herring <robh@kernel.org>
Date: Fri, 11 Oct 2019 12:01:03 -0500
Subject: [PATCH v2 1/2] dt-bindings: clock: Add AST2500 RMII RCLK
 definitions
In-Reply-To: <20191010020655.3776-2-andrew@aj.id.au>
References: <20191010020655.3776-1-andrew@aj.id.au>
 <20191010020655.3776-2-andrew@aj.id.au>
Message-ID: <20191011170103.GA14903@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2019 12:36:54 +1030, Andrew Jeffery wrote:
> The AST2500 has an explicit gate for the RMII RCLK for each of the two
> MACs.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> v2: Drop "_GATE" from symbol names
> 
>  include/dt-bindings/clock/aspeed-clock.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
