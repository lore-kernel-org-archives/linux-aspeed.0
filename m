From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 Aug 2023 12:32:49 +0200
Subject: [PATCH] dt-bindings: pinctrl: aspeed: Allow only defined pin mux
 node properties
In-Reply-To: <20230819010907.916061-1-robh@kernel.org>
References: <20230819010907.916061-1-robh@kernel.org>
Message-ID: <CACRpkdZQVry-p90AZSfrJHJuscN3CuJU-ySKU2+zCHbVt-Z1Kg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Aug 19, 2023 at 3:09?AM Rob Herring <robh@kernel.org> wrote:

> The Aspeed pinctrl bindings are missing an additionalProperties/
> unevaluatedProperties schemas on the child pin mux nodes which means any
> undefined properties are allowed. In addition, using
> 'additionalProperties' for child nodes with any name works better than a
> pattern matching everything with an if/then schema to select nodes only.
>
> With 'additionalProperties' added, 'pins' and 'bias-disable'
> properties need to be added as they were not defined. A $ref to
> pinmux-node.yaml which defines the common property types was also
> missing.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied!

> Really 'pins' should have some constraints, but I don't know what the
> possible values are. Happy to add if someone can tell me what.

Aspeed folks: put this on your TODO!

Yours,
Linus Walleij
