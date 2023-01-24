From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 24 Jan 2023 09:17:43 +0100
Subject: [PATCH 2/2] spi: dt-bindings: cleanup examples - indentation,
 lowercase hex
In-Reply-To: <20230123201751.GA2450665-robh@kernel.org>
References: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
 <20230118173932.358153-2-krzysztof.kozlowski@linaro.org>
 <20230123201751.GA2450665-robh@kernel.org>
Message-ID: <934be0a4-3639-5f72-cf54-b796b32df484@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 23/01/2023 21:17, Rob Herring wrote:
> On Wed, Jan 18, 2023 at 06:39:32PM +0100, Krzysztof Kozlowski wrote:
>> Cleanup examples:
>>  - use 4-space indentation (for cases when it is neither 4 not 2 space),
>>  - drop redundant blank lines,
>>  - use lowercase hex.
>>
>> No functional impact except adjusting to preferred coding style.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/spi/amlogic,meson-gx-spicc.yaml  |  26 +--
>>  .../bindings/spi/amlogic,meson6-spifc.yaml    |  22 +--
>>  .../bindings/spi/aspeed,ast2600-fmc.yaml      |  24 +--
>>  .../bindings/spi/brcm,spi-bcm-qspi.yaml       | 156 +++++++++---------
>>  .../bindings/spi/cdns,qspi-nor.yaml           |   4 +-
>>  .../bindings/spi/nvidia,tegra210-quad.yaml    |  42 ++---
>>  .../bindings/spi/qcom,spi-qcom-qspi.yaml      |   1 -
>>  .../devicetree/bindings/spi/renesas,rspi.yaml |  22 +--
>>  .../bindings/spi/spi-sunplus-sp7021.yaml      |   4 +-
>>  .../devicetree/bindings/spi/st,stm32-spi.yaml |   1 -
>>  10 files changed, 150 insertions(+), 152 deletions(-)
> 
> [...]
> 
>> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> index d35c6f7e2dd5..18afdaab946d 100644
>> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
>> @@ -95,7 +95,6 @@ examples:
>>               <&dmamux1 1 40 0x400 0x05>;
>>        dma-names = "rx", "tx";
>>        cs-gpios = <&gpioa 11 0>;
> 
> Looks like the indentation needs adjusting here.
> 

Ack

Best regards,
Krzysztof

