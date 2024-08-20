From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 20 Aug 2024 12:01:55 +0200
Subject: [PATCH v13 1/3] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <OS8PR06MB7541A25AC3A11C51DD57E1B4F28D2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240819092850.1590758-1-ryan_chen@aspeedtech.com>
 <20240819092850.1590758-2-ryan_chen@aspeedtech.com>
 <7237aa34-9821-4ba7-a45b-3b1d598bc282@kernel.org>
 <OS8PR06MB75418A2ACA6693A8163F19E8F28D2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <46a9280d-f4ef-4cfb-83a3-3744e04721f3@kernel.org>
 <OS8PR06MB7541A25AC3A11C51DD57E1B4F28D2@OS8PR06MB7541.apcprd06.prod.outlook.com>
Message-ID: <266f4b55-bddb-4c44-9eb5-3eef35757714@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 20/08/2024 08:50, Ryan Chen wrote:
>>>> Subject: Re: [PATCH v13 1/3] dt-bindings: i2c: aspeed: support for
>>>> AST2600-i2cv2
>>>>
>>>> On 19/08/2024 11:28, Ryan Chen wrote:
>>>>> Add ast2600-i2cv2 compatible and aspeed,global-regs,
>>>>> aspeed,enable-dma and description for ast2600-i2cv2.
>>>>>
>>>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzk+dt@kernel.org>
>>>>
>>>> ?!?
>>>>
>>>> What happened here? Why are you amending tags?!? That's not allowed.
>>>> You cannot change received tags, change people names or their data!
>>>> And how is it even possible, srsly, how do you even work with git?
>>>> Git would never do it, so you had to do it on purpose via some weird
>> workflow.
>>>>
>>> Sorry, I don't know Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> is
>> you or not.
>>> Or should I still keep Krzysztof Kozlowski <krzk+dt@kernel.org>?
>>>
>>> https://patches.linaro.org/project/linux-i2c/patch/20230415012848.1777
>>> 768-2-ryan_chen at aspeedtech.com/
>>
>> Here is the tag you received. You added it in v12.
>>
>> Why did you change the tag suddenly to something else?
>>
>> Do you understand that you are not allowed to change people tags? I have
>> doubts if you ask about people's identities, which is entirely irrelevant.
>>
> Sorry, I am not understood.

I don't know how to say this simpler that you are not allowed to change
tags.

You receive tag, use b4 to apply it or add it manually. Do not alter it.
Do not change it. Do not add things there. Do not remove parts of it.

Tag is as is. You only copy and paste.

Is this understood now?



> https://patches.linaro.org/project/linux-i2c/patch/20230415012848.1777768-2-ryan_chen at aspeedtech.com/
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> at v10
> So, what should I do now at v13?? 

Fix your workflow and go back to previous version which had correct tag.
And answer - why did you decide to change it?

Best regards,
Krzysztof

