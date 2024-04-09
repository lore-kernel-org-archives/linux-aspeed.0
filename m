From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 9 Apr 2024 11:40:38 +0200
Subject: [PATCH 3/9] dt-bindings: rtc: lpc32xx-rtc: move to trivial-rtc
In-Reply-To: <6dc808bf-682f-4e91-aac7-7ce6f05a0ab4@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240408-rtc_dtschema-v1-3-c447542fc362@gmail.com>
 <dd5e9837-0dcf-4b0e-8d11-f8bed868cdf2@linaro.org>
 <6dc808bf-682f-4e91-aac7-7ce6f05a0ab4@gmail.com>
Message-ID: <ea5a9c80-c43f-49e9-b9ac-da27c74a32bb@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 09/04/2024 10:52, Javier Carrasco wrote:
> On 4/9/24 09:34, Krzysztof Kozlowski wrote:
>> On 08/04/2024 17:53, Javier Carrasco wrote:
>>> This RTC requires a compatible, a reg and a single interrupt,
>>> which makes it suitable for a direct conversion into trivial-rtc.
>>>
>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt  | 15 ---------------
>>>  Documentation/devicetree/bindings/rtc/trivial-rtc.yaml |  2 ++
>>>  2 files changed, 2 insertions(+), 15 deletions(-)
>>
>> This one no... and if you tested DTS you would see errors, although you
>> need to test specific lpc config, not multi_v7.
>>
>> It does not look like you tested the DTS against bindings. Please run
>> `make dtbs_check W=1` (see
>> Documentation/devicetree/bindings/writing-schema.rst or
>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>> for instructions).
>>
>> Anyway, you *must* check all DTS before moving anything to trivial.
>>
>> Does it mean all other bindings were not checked against DTS at all?
>>
>> Best regards,
>> Krzysztof
>>
> Hi,
> 
> I did check the conversion against nxp/lpc/lpc3250-phy3250.dts, which
> throws a message about the 'clocks' property.
> 
> That property is not documented in the original binding, and even though
> it could be missing, I could not find any function to get a clock (i.e.

Old bindings are not really accurate.

> any form of clk_get()) in rtc-lpc32xx.c, which is the only file where
> the compatible can be found.
> 
> Is therefore the property not useless in the dts? My apologies if I am
> missing something here.

Useless for whom? For Linux yes. For U-Boot or out-of-tree users of DTS,
I don't know. Anyway the true question is if there is a clock or there
is no. If there is a clock, then it should be in the binding even if
Linux driver does not use it.

I propose to add it and be done with it.




Best regards,
Krzysztof

