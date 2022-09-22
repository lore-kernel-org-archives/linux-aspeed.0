From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 22 Sep 2022 08:47:14 +0200
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: document AMD DaytonaX
In-Reply-To: <20220922063514.f6euqlw35jrkpee4@krzk-bin>
References: <20220920165404.14099-1-aladyshev22@gmail.com>
 <20220921210950.10568-1-aladyshev22@gmail.com>
 <20220921210950.10568-2-aladyshev22@gmail.com>
 <20220922063514.f6euqlw35jrkpee4@krzk-bin>
Message-ID: <035f5834-6fb7-95ba-1569-6dbf8eface49@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 22/09/2022 08:35, Krzysztof Kozlowski wrote:
> On Thu, 22 Sep 2022 00:09:46 +0300, Konstantin Aladyshev wrote:
>> Document AMD DaytonaX board compatible.
>>
>> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1680833
> 
> 
> /: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm/boot/dts/aspeed-bmc-qcom-dc-scm-v1.dtb

Ignore, this is not related.

Best regards,
Krzysztof

