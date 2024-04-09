From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 9 Apr 2024 09:37:03 +0200
Subject: [PATCH 6/9] dt-bindings: rtc: pxa-rtc: convert to dtschema
In-Reply-To: <20240408-rtc_dtschema-v1-6-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240408-rtc_dtschema-v1-6-c447542fc362@gmail.com>
Message-ID: <8ac44f38-c396-4edb-8a73-35d956fc98e6@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/04/2024 17:53, Javier Carrasco wrote:
> Convert existing binding to dtschema to support validation.
> 
> The missing 'reg' and 'interrupts' properties have been added, taking
> the 2 supported interrupts into account to fix the example.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

