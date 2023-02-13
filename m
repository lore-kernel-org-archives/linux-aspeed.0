From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 13 Feb 2023 09:33:28 +0100
Subject: [PATCH 1/4] dt-bindings: aspeed: Add UART controller
In-Reply-To: <2d0d1866-95f9-942d-57e0-06a5ed17d35d@linaro.org>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
 <20230210072643.2772-2-chiawei_wang@aspeedtech.com>
 <2d0d1866-95f9-942d-57e0-06a5ed17d35d@linaro.org>
Message-ID: <b59c8885-562d-f680-622e-3859bf7ff8db@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/02/2023 10:12, Krzysztof Kozlowski wrote:
> On 10/02/2023 08:26, Chia-Wei Wang wrote:
>> Add dt-bindings for Aspeed UART controller.
> 
> Describe the hardware. What's the difference against existing Aspeed
> UART used everywhere?

I expect the answer here. You are adding duplicated driver and bindings
instead of merging with existing ones. That's common issue and
explanation "it is different" is not enough.

Best regards,
Krzysztof

