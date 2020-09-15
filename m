From: Rob Herring <robh@kernel.org>
Date: Tue, 15 Sep 2020 13:59:45 -0600
Subject: [PATCH v2 01/15] dt-bindings: gpio: convert bindings for NXP
 PCA953x family to dtschema
In-Reply-To: <20200910175733.11046-2-krzk@kernel.org>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-2-krzk@kernel.org>
Message-ID: <20200915195945.GA2407885@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2020 19:57:19 +0200, Krzysztof Kozlowski wrote:
> Convert the NXP PCA953x family of GPIO expanders bindings to device tree
> schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Use additionalProperties.
> 2. Add wakeup-source.
> 3. Add hogs.
> 4. Extend example with hogs.
> ---
>  .../devicetree/bindings/gpio/gpio-pca953x.txt |  90 ----------
>  .../bindings/gpio/gpio-pca95xx.yaml           | 166 ++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |   4 -
>  3 files changed, 166 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
