From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 21 Feb 2023 10:38:48 +0100
Subject: [PATCH v5 0/2] Add ASPEED AST2600 I2Cv2 controller driver
In-Reply-To: <TYZPR06MB52743FC4ED5ED152446106ABF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <54ef0dee-30dc-3ba9-d2f7-8270204b5505@linaro.org>
 <TYZPR06MB5274195CB92C4604280A776EF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
 <abec828b-9b34-fc5a-cd36-8be6f20dfd25@linaro.org>
 <TYZPR06MB52743FC4ED5ED152446106ABF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
Message-ID: <1f0b18b1-0fe4-a7e9-4d72-3938471ead42@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/02/2023 02:12, Ryan Chen wrote:
>> Yes. New compatible and new syscon phandle (constrained to specific
>> compatibles in allOf:if:then:) to the old binding.
> Thank your guidance.
> The following is my sample modify, if my understand is correct, I will update in patch1 thread discussion.
> I need add in original aspeed,i2c.yaml not aspeed,i2cv2.yaml
> allOf:
>   - $ref: /schemas/i2c/i2c-controller.yaml#
>   - if:
>       properties:
>         compatible:
>           contains:
>             const: aspeed,ast2600-i2cv2
> 
>     then:
>       required:
>         - aspeed,gr

else:
  properties:
    aspeed,gr: false

Best regards,
Krzysztof

