From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 22 Jun 2022 12:10:25 +0200
Subject: [PATCH 2/7] dt-bindings: arm: aspeed: document board compatibles
In-Reply-To: <0207c2fe-7c01-7852-3cd1-74297cd4857d@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-2-krzysztof.kozlowski@linaro.org>
 <0207c2fe-7c01-7852-3cd1-74297cd4857d@linaro.org>
Message-ID: <fd015563-0326-c897-4ecc-cc77e8a4a14c@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 20/06/2022 13:06, Krzysztof Kozlowski wrote:
> On 29/05/2022 12:49, Krzysztof Kozlowski wrote:
>> Document all compatibles used in existing upstreamed Aspeed AST2400,
>> AST2500 and AST2600 based boards.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/arm/aspeed/aspeed.yaml           | 83 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 84 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> 
> Joel, Andrew,
> 
> Any comments on the series? Rob applied only patch 1, so the rest is
> supposed through Aspeed tree. Shall I pick them up and send to arm-soc?

I'll grab the bindings and DTS. I'll keep it on separate branch, so I
can share to avoid conflicts. If anyone prefers to pick it up, let me
know so I will drop them from my tree.

Best regards,
Krzysztof
