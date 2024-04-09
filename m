From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 9 Apr 2024 09:40:11 +0200
Subject: [PATCH 8/9] dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema
In-Reply-To: <20240408-rtc_dtschema-v1-8-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240408-rtc_dtschema-v1-8-c447542fc362@gmail.com>
Message-ID: <f0467c4f-45e2-4cae-b1b5-3867e5b9bf08@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/04/2024 17:53, Javier Carrasco wrote:
> Convert existing binding to dtschema to support validation.
> 
> The 'fsl,imx28-rtc' compatible is currently not supported, and it is
> only referenced in this binding and in nxp/mxs/imx28.dtsi. Therefore,
> that compatible has been dropped, which triggers a warning when testing
> the DT against the new binding.

Instead document missing compatibles and mention this in commit msg.

> 
> There is another reference to fsl,stmp3xxx-rtc in nxp/mxs/imx23.dtsi,
> where another unsupported compatible 'fsl,imx23-rtc' is used, and the
> same problem would arise when testing the file against the new binding.

Please write concise messages... you have to paragraphs about the same?
What is the difference here?

> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml  | 45 ++++++++++++++++++++++
>  .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       | 21 ----------
>  2 files changed, 45 insertions(+), 21 deletions(-)
> 


Best regards,
Krzysztof

