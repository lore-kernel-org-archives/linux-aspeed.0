From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 24 Jul 2019 07:40:00 -0600
Subject: [PATCH 3/3] dt-bindings: aspeed: Remove mention of deprecated
 compatibles
In-Reply-To: <20190724081313.12934-4-andrew@aj.id.au>
References: <20190724081313.12934-1-andrew@aj.id.au>
 <20190724081313.12934-4-andrew@aj.id.au>
Message-ID: <CAL_JsqLEb3QSLAhm9BsFa+A_Jmgr4gDtV2nUCKkgwwQaMLBk9g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 24, 2019 at 2:13 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Guide readers away from using the aspeed,g[45].* compatible patterns.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/mfd/aspeed-scu.txt         | 2 --
>  Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt   | 2 --
>  .../devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml  | 5 +----
>  .../devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml  | 4 +---
>  4 files changed, 2 insertions(+), 11 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
