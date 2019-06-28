From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 28 Jun 2019 09:46:56 -0600
Subject: [PATCH v2 2/8] dt-bindings: pinctrl: aspeed: Convert AST2400
 bindings to json-schema
In-Reply-To: <20190628023838.15426-3-andrew@aj.id.au>
References: <20190628023838.15426-1-andrew@aj.id.au>
 <20190628023838.15426-3-andrew@aj.id.au>
Message-ID: <CAL_JsqKjDyuDjeBBqhF=2ceG2h0WiJC6QKtHJ-=yL3XqxXF0Hw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 27, 2019 at 8:39 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Convert ASPEED pinctrl bindings to DT schema format using json-schema
>
> Cc: Johnny Huang <johnny_huang@aspeedtech.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> In v2:
>
> * Enforce function/group names in bindings
> * Move description above properties
> * Simplify specification of compatible
> * Cleanup license specification
>
>  .../pinctrl/aspeed,ast2400-pinctrl.txt        | 80 ------------------
>  .../pinctrl/aspeed,ast2400-pinctrl.yaml       | 81 +++++++++++++++++++
>  2 files changed, 81 insertions(+), 80 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
