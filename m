From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 9 Apr 2024 09:40:36 +0200
Subject: [PATCH 9/9] dt-bindings: rtc: via,vt8500-rtc: move to trivial-rtc
In-Reply-To: <20240408-rtc_dtschema-v1-9-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240408-rtc_dtschema-v1-9-c447542fc362@gmail.com>
Message-ID: <ba35f6e4-a83d-4460-9670-a8c2c3331472@linaro.org>
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


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

