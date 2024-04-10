From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 10 Apr 2024 17:57:40 +0200
Subject: [PATCH v2 2/4] dt-bindings: rtc: lpc32xx-rtc: convert to dtschema
In-Reply-To: <20240410-rtc_dtschema-v2-2-d32a11ab0745@gmail.com>
References: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
 <20240410-rtc_dtschema-v2-2-d32a11ab0745@gmail.com>
Message-ID: <66bc1635-6400-42f3-b8a6-9378ce23a872@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/04/2024 17:55, Javier Carrasco wrote:
> Convert existing binding to dtschema to support validation.
> 
> Add the undocumented 'clocks' property.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/rtc/lpc32xx-rtc.txt        | 15 --------
>  .../devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml   | 41 ++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 15 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

