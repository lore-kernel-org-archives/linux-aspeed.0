From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 10 Apr 2024 17:58:18 +0200
Subject: [PATCH v2 4/4] dt-bindings: rtc: stmp3xxx-rtc: convert to
 dtschema
In-Reply-To: <20240410-rtc_dtschema-v2-4-d32a11ab0745@gmail.com>
References: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
 <20240410-rtc_dtschema-v2-4-d32a11ab0745@gmail.com>
Message-ID: <e07b4e26-f3b6-4b7a-ad5b-b2599bab0fcf@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/04/2024 17:55, Javier Carrasco wrote:
> Convert existing binding to dtschema to support validation and
> add the undocumented compatible 'fsl,imx23-rtc'.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml  | 51 ++++++++++++++++++++++
>  .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       | 21 ---------
>  2 files changed, 51 insertions(+), 21 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

