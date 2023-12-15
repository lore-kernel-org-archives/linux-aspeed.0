From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 15 Dec 2023 08:35:07 +0100
Subject: [PATCH v1 4/8] ARM: dts: aspeed: System1: Add i2c and muxes
In-Reply-To: <8cdadff2-055a-48ab-8495-45c8285d3d8f@linux.ibm.com>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-5-ninad@linux.ibm.com>
 <72a749b9-b9be-4496-9bcc-37519044c109@linaro.org>
 <8cdadff2-055a-48ab-8495-45c8285d3d8f@linux.ibm.com>
Message-ID: <66a211d8-de40-4827-9e84-b226545986c6@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/12/2023 19:34, Ninad Palsule wrote:
>>>   	chosen {
>>>   		stdout-path = &uart5;
>>>   		bootargs = "console=ttyS4,115200n8 earlycon";
>>> @@ -54,10 +113,12 @@ vga_memory: region at bf000000 {
>>>   			reg = <0xbf000000 0x01000000>;  /* 16M */
>>>   		};
>>>   	};
>>> +
>> You need to clean your patchset...
> I made changes about the stdout-path, is that what you mean?

No, I meant you made irrelevant changes in this patch.

>>
>>
>>>   };
>>>   
>>>   &adc1 {
>>>   	status = "okay";
>>> +
>> Really.
> I need to add "status = okay" otherwise its not instantiated.

That was about blank line. How is it related to this patch "Add i2c and
muxes"?

Best regards,
Krzysztof

