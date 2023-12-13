From: Ninad Palsule <ninad@linux.ibm.com>
Date: Wed, 13 Dec 2023 13:49:21 -0600
Subject: [PATCH v1 8/8] ARM: dts: aspeed: System1: PS, sensor and more
In-Reply-To: <427fa99c-764c-4d6a-b9f1-cd9089710d5e@linaro.org>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-9-ninad@linux.ibm.com>
 <5b98538a-8ffe-42ec-b020-514dcfcebba3@linaro.org>
 <44abff4a-0a8e-499b-8b98-a4a1680cb431@linux.ibm.com>
 <427fa99c-764c-4d6a-b9f1-cd9089710d5e@linaro.org>
Message-ID: <edcdcea2-febc-4859-9ccf-b8c59b794f01@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Krzysztof,

On 12/13/23 13:37, Krzysztof Kozlowski wrote:
> On 13/12/2023 20:02, Ninad Palsule wrote:
>> Hello Krzysztof,
>>
>> On 12/12/23 14:26, Krzysztof Kozlowski wrote:
>>> On 12/12/2023 17:40, Ninad Palsule wrote:
>>>> This drop adds following devices in the device tree.
>>>> - EEPROM/VPD
>>>> - Power supplies
>>>> - Humidity, pressure and temperature sensors.
>>>> - Trusted platform module(TPM) chip
>>>>
>>>> Tested:
>>>>       This board is tested using the simics simulator.
>>>>
>>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>>> ---
>>> Don't mix DTS with drivers. DTS and drivers go via different subsystems
>>> and cannot have dependencies, so why DTS is patch #6, then driver #7 and
>>> now again DTS #7?
>> There is a dependency on driver code as patch #8 uses the compatibility
>> string added in driver patch #7.? I have now moved driver patch at the
>> start. Is that ok? OR you are suggesting something else?
> First, there is no dependency. Second, except confusing order anyway DTS
> will go via separate trees. Third, again, there is no dependency. If
> there is, your patchset is broken and this needs to be fixed. Although I
> don't understand how new hardware can depend on driver... it's really odd.

Thanks for the quick response.

This board uses the nuvoton TPM device. The tpm devices uses 
"nuvoton,npct75x" driver hence we added it in the device tree. If the 
driver doesn't have this compatibility string then it won't load. So if 
someone tries to use this board then tpm won't work unless the 
compatibility string is added in the driver. That is the dependency I am 
talking about.

Please let me know.

Regards,

Ninad

>
> Best regards,
> Krzysztof
>
