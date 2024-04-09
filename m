From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 9 Apr 2024 09:37:53 +0200
Subject: [PATCH 7/9] dt-bindings: rtc: spear-rtc: move to trivial-rtc
In-Reply-To: <20240408-rtc_dtschema-v1-7-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240408-rtc_dtschema-v1-7-c447542fc362@gmail.com>
Message-ID: <e5aefcc8-1181-487f-95bf-e1cbe13e1f98@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/04/2024 17:53, Javier Carrasco wrote:
> The RTC documented in this binding requires a compatible, a reg
> and a single interrupt, which makes it suitable for a direct
> conversion into trivial-rtc.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  Documentation/devicetree/bindings/rtc/spear-rtc.txt    | 15 ---------------
>  Documentation/devicetree/bindings/rtc/trivial-rtc.yaml |  2 ++
>  2 files changed, 2 insertions(+), 15 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

