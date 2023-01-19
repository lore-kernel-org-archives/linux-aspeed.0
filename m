From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 19 Jan 2023 15:23:52 +1030
Subject: [PATCH 1/2] spi: dt-bindings: drop unneeded quotes
In-Reply-To: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
References: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
Message-ID: <47290046-59a2-4bf0-8af0-3a7b4304deb3@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 19 Jan 2023, at 04:09, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/spi/allwinner,sun4i-a10-spi.yaml  |  2 +-
>  .../bindings/spi/allwinner,sun6i-a31-spi.yaml  |  2 +-
>  .../bindings/spi/amlogic,meson-gx-spicc.yaml   |  6 +++---
>  .../bindings/spi/amlogic,meson6-spifc.yaml     |  6 +++---
>  .../bindings/spi/aspeed,ast2600-fmc.yaml       |  2 +-

For the Aspeed change:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
