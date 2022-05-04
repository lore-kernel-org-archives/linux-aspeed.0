From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 May 2022 23:25:05 +0200
Subject: [PATCH] dt-bindings: pinctrl: aspeed: Drop referenced nodes in
 examples
In-Reply-To: <20220422192139.2592632-1-robh@kernel.org>
References: <20220422192139.2592632-1-robh@kernel.org>
Message-ID: <CACRpkdZcVwvBHrDy-wxPURhJ4OWRMA9TQ1e2vmcXnhEG2HaMDA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 22, 2022 at 9:21 PM Rob Herring <robh@kernel.org> wrote:

> The additional nodes in the example referenced from the pinctrl node
> 'aspeed,external-nodes' properties are either incorrect (aspeed,ast2500-lpc)
> or not documented with a schema (aspeed,ast2500-gfx). There's no need to
> show these nodes as part of the pinctrl example, so just remove them.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied. Concerns about lost examples can be solved
with incremental patches on top adding more schema.

Yours,
Linus Walleij
