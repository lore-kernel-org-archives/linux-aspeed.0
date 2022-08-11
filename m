From: Lee Jones <lee@kernel.org>
Date: Thu, 11 Aug 2022 08:01:49 +0100
Subject: [PATCH 2/2] dt-bindings: mfd: aspeed,ast2x00-scu: Convert to DT
 schema format
In-Reply-To: <20220810161635.73936-3-robh@kernel.org>
References: <20220810161635.73936-1-robh@kernel.org>
 <20220810161635.73936-3-robh@kernel.org>
Message-ID: <YvSpXfA8o+3FfiPb@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 10 Aug 2022, Rob Herring wrote:

> Convert the aspeed,ast2[456]00-scu binding to DT schema format.
> 
> The original binding was missing '#address-cells', '#size-cells',
> 'ranges', and child nodes, so add them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 110 ++++++++++++++++++
>  .../devicetree/bindings/mfd/aspeed-scu.txt    |  48 --------
>  2 files changed, 110 insertions(+), 48 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-scu.txt

Applied, thanks.

-- 
Lee Jones [???]
