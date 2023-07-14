From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 14 Jul 2023 02:59:40 -0700
Subject: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
In-Reply-To: <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org>
References: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
 <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org>
Message-ID: <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/14/23 00:13, Krzysztof Kozlowski wrote:
> On 14/07/2023 09:04, ??? wrote:
> 
>>          > This is because our register layout for PWM and Tach is not
>> continuous.
>>
>>          > PWM0 used 0x0 0x4, Tach0 used 0x8 0xc
>>
>>          > PWM1 used 0x10 0x14, Tach1 used 0x18 0x1c
>>
>>          > ...
>>
>>          > Each PWM/Tach instance has its own controller register and is not
>> dependent on others.
> 
> Your email reply quoting style is very difficult to read.
> 
>>
>>
>>
>> Hi Guenter,
>>
>>
>>
>> Did you receive a response to my previous email?
>>
>> I would like to inquire if you have any further concerns regarding the PWM
>> and Tach with 16 instances.
> 
> But isn't like this in all PWMs in all SoCs?
> 

Correct, pretty much every fan controller is implemented that way.
I don't understand the logic.

Guenter


