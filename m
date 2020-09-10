From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 10 Sep 2020 18:54:12 +0200
Subject: [PATCH 1/6] dt-bindings: gpio: Convert bindings for NXP PCA953x
 family to dtschema
In-Reply-To: <20200829094024.31842-1-krzk@kernel.org>
References: <20200829094024.31842-1-krzk@kernel.org>
Message-ID: <20200910165412.GB11510@kozik-lap>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Aug 29, 2020 at 11:40:19AM +0200, Krzysztof Kozlowski wrote:
> Convert the NXP PCA953x family of GPIO expanders bindings to device tree
> schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/gpio/gpio-pca953x.txt |  90 ------------
>  .../bindings/gpio/gpio-pca95xx.yaml           | 138 ++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |   4 -
>  3 files changed, 138 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
>

I will resend the dt-bindings replacing unevaluated ->
additionalProperties.

Best regards,
Krzysztof

