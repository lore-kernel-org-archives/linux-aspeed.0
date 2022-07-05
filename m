From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 5 Jul 2022 13:42:54 +0200
Subject: [PATCH v3 36/40] ARM: dts: aspeed: align gpio-key node names with
 dtschema
In-Reply-To: <5e0d5cca-c4a8-6651-0e67-47b5fc23c5c7@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
 <20220616005333.18491-36-krzysztof.kozlowski@linaro.org>
 <5e0d5cca-c4a8-6651-0e67-47b5fc23c5c7@linaro.org>
Message-ID: <3a01a031-356e-fde2-b160-0676fb542f51@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27/06/2022 10:49, Krzysztof Kozlowski wrote:
> On 16/06/2022 02:53, Krzysztof Kozlowski wrote:
>> The node names should be generic and DT schema expects certain pattern
>> (e.g. with key/button/switch).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 30 ++++++------
>>  .../boot/dts/aspeed-bmc-bytedance-g220a.dts   | 48 +++++++++----------
>>  arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts  |  8 ++--
>>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts  | 12 ++---
>>  .../boot/dts/aspeed-bmc-inspur-fp5280g2.dts   | 22 ++++-----
>>  arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts   | 23 ++++-----
>>  arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts   | 20 ++++----
>>  arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts   |  2 +-
>>  arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts |  2 +-
>>  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |  2 +-
>>  arch/arm/boot/dts/aspeed-bmc-opp-swift.dts    | 30 ++++++------
>>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   | 12 ++---
>>  arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts   |  4 +-
>>  .../boot/dts/aspeed-bmc-opp-witherspoon.dts   | 16 +++----
>>  arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts    |  4 +-
>>  15 files changed, 118 insertions(+), 117 deletions(-)
>>
> 
> Joel,
> 
> Any comments on the Aspeed patches? Do you intend to take them or shall
> I handle them with the rest?

These are still not in next and still not response here, so I'll pick
them up.

Best regards,
Krzysztof
