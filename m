From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 20 Feb 2023 11:35:30 +0100
Subject: [PATCH v5 0/2] Add ASPEED AST2600 I2Cv2 controller driver
In-Reply-To: <TYZPR06MB5274195CB92C4604280A776EF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <54ef0dee-30dc-3ba9-d2f7-8270204b5505@linaro.org>
 <TYZPR06MB5274195CB92C4604280A776EF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
Message-ID: <abec828b-9b34-fc5a-cd36-8be6f20dfd25@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 20/02/2023 10:56, Ryan Chen wrote:
>>
>>> And also have separate i2c master and slave register set for control.
>>
>> Since several of my questions remained unanswered and quite frankly it's
>> fruitless... so let me read the commit msg directly - it's the same device, just
>> with different register layout. Having new compatible makes sense, but this
>> should be part of old binding.
>>
> Sorry, I am confused, Do you mean I should base on original Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> Add new compatible? Not add another aspeed,i2cv2.yaml.

Yes. New compatible and new syscon phandle (constrained to specific
compatibles in allOf:if:then:) to the old binding.

Best regards,
Krzysztof

