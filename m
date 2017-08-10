From: Rob Herring <robh@kernel.org>
Date: Thu, 10 Aug 2017 10:45:22 -0500
Subject: [PATCH 1/2] dt-bindings: watchdog: aspeed: External reset signal
 properties
In-Reply-To: <20170802044529.30032-2-andrew@aj.id.au>
References: <20170802044529.30032-1-andrew@aj.id.au>
 <20170802044529.30032-2-andrew@aj.id.au>
Message-ID: <20170810154522.7br6ta3f6plf7ytm@rob-hp-laptop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 02, 2017 at 02:15:28PM +0930, Andrew Jeffery wrote:
> For the AST2500 and compatible watchdog controllers the external reset
> signal can be configured for push-pull or open-drain drive types, and in
> the case of push-pull driving, active low or high.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

