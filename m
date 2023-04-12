From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Apr 2023 16:18:10 +0200
Subject: [PATCH v9 1/2] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <40f1ca77-7f7a-dc51-1137-45664a6ef2a1@linaro.org>
References: <20230405022825.333246-1-ryan_chen@aspeedtech.com>
 <20230405022825.333246-2-ryan_chen@aspeedtech.com>
 <40f1ca77-7f7a-dc51-1137-45664a6ef2a1@linaro.org>
Message-ID: <3ee27d89-5a13-cf5f-c7d3-aa2740a790f3@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/04/2023 09:36, Krzysztof Kozlowski wrote:
> On 05/04/2023 04:28, Ryan Chen wrote:
>> Add ast2600-i2cv2 compatible and aspeed,global-regs, aspeed,enable-dma
>> and description for ast2600-i2cv2.
>>
>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>> ---
>>  .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 52 +++++++++++++++++--
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>

Unreviewed. I don't understand this. It's v9 and still wrong address people.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

Best regards,
Krzysztof

