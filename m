From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 23 Sep 2022 09:31:35 +0930
Subject: [PATCH v3] dt-bindings: arm: aspeed: adjust qcom,dc-scm-v1-bmc compatible
 after rename
In-Reply-To: <1c33bf6d-b458-b2bb-3116-ed20b9cadc0e@linaro.org>
References: <20220811062953.5976-1-krzysztof.kozlowski@linaro.org>
 <1c33bf6d-b458-b2bb-3116-ed20b9cadc0e@linaro.org>
Message-ID: <c5acf780-7a9d-442c-a41c-efc69e5d0ed3@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 22 Sep 2022, at 16:19, Krzysztof Kozlowski wrote:
> On 11/08/2022 08:29, Krzysztof Kozlowski wrote:
>> The Nuvia DC-SCM BMC board compatible was renamed in commit
>> 7f058112873e ("ARM: dts: aspeed: nuvia: rename vendor nuvia to qcom"),
>> so adjust the bindings as well.
>> 
>> Fixes: f77024c80147 ("dt-bindings: arm: aspeed: document board compatibles")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Acked-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> 
>> ---
>> 
>> Changes since v2:
>> 1. Fix typo in commit msg.
>> 2. Add Acks.
>> 
>> Changes since v1:
>> 1. Use proper qcom compatible.
>
> Andrew, Joel,
>
> Do you have any more comments on this patch? Do you plan to pick it up?
> 5 weeks passed..

Sorry, things have been a bit complicated recently. Looks okay to me, 
but Joel needs to pick it up.

Acked-by: Andrew Jeffery <andrew@aj.id.au>
