From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 9 Apr 2024 09:36:23 +0200
Subject: [PATCH 5/9] dt-bindings: rtc: rtc-aspeed: move to trivial-rtc
In-Reply-To: <20240408-rtc_dtschema-v1-5-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240408-rtc_dtschema-v1-5-c447542fc362@gmail.com>
Message-ID: <5ad54140-d6c2-4c65-b31e-1ef19bc5ce5a@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/04/2024 17:53, Javier Carrasco wrote:
> The RTCs documented in this binding require a compatible, a reg
> and a single interrupt, which make them suitable for a direct
> conversion into trivial-rtc.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

